Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7901BF11F
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgD3HRP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:17:15 -0400
Received: from mail.cs.msu.ru ([188.44.42.39]:50583 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgD3HRL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 03:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8X7J2PrsdtBE1Q+hOf7I5rfSDP6MpQUyNWTcjJ6lkk0=; b=Q4rrgDV0cUMIfVpQ5JAenDdsEi
        f9ERFOsGa07CblhpOLgtLmfOrNVVB7O4E6wN0uWyq3kBW2pPJxu27UoaqU4NRD7eItyUaEJQ8Dgfs
        HVcQPQ8vReJcAiz5aT+7xSREngBq9DdKth8jupoC7UX0a0dohKyT9tkD/pPOHgOqnrAm0TKdO02iW
        LoSBjo8xozaRmh6ttMTW1NOz3TuRIAm2Qg2iOB1r0CWuPVxgxO9OpyRfj8c/kWdPzxtuB6rOF325G
        eys1uF4Q0DIwya+xWFw3LEdAhclgKX3KuOayqXVUBR3aS/rIJK5yZGEhYFt3V701XnL8oHxbyYSuW
        08RRhM/A==;
Received: from [37.204.119.143] (port=42272 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93.0.4 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1jU2uw-000B4I-0u; Thu, 30 Apr 2020 09:43:30 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Date:   Thu, 30 Apr 2020 09:43:00 +0300
Message-Id: <20200430064301.1099452-7-ar@cs.msu.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430064301.1099452-1-ar@cs.msu.ru>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL autolearn=no autolearn_force=no version=3.4.4
Subject: [PATCH v3 6/7] n_tty: ->ops->write: Cut core logic out to a separate function
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

To simplify internal re-use of the line discipline's write method,
we isolate the work it does to its own function.

Since in-kernel callers might not refer to the tty through a file,
the struct file* argument might make no sense, so we also stop
tty_io_nonblock() from dereferencing file too early, allowing
to pass NULL as the referring file here.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 drivers/tty/n_tty.c | 33 ++++++++++++++++++++++-----------
 include/linux/tty.h |  2 +-
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 10d6b60a5..f72a3fd4b 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2309,22 +2309,15 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
  *		  lock themselves)
  */
 
-static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
-			   const unsigned char *buf, size_t nr)
+static ssize_t do_n_tty_write(struct tty_struct *tty, struct file *file,
+			      const unsigned char *buf, size_t nr)
 {
 	const unsigned char *b = buf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int c;
 	ssize_t retval = 0;
 
-	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
-	if (L_TOSTOP(tty) && file->f_op->write != redirected_tty_write) {
-		retval = tty_check_change(tty);
-		if (retval)
-			return retval;
-	}
-
-	down_read(&tty->termios_rwsem);
+	lockdep_assert_held_read(&tty->termios_rwsem);
 
 	/* Write out any echoed characters that are still pending */
 	process_echoes(tty);
@@ -2392,10 +2385,28 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	remove_wait_queue(&tty->write_wait, &wait);
 	if (nr && tty->fasync)
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	up_read(&tty->termios_rwsem);
 	return (b - buf) ? b - buf : retval;
 }
 
+static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
+			   const unsigned char *buf, size_t nr)
+{
+	ssize_t retval = 0;
+
+	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
+	if (L_TOSTOP(tty) && file->f_op->write != redirected_tty_write) {
+		retval = tty_check_change(tty);
+		if (retval)
+			return retval;
+	}
+
+	down_read(&tty->termios_rwsem);
+	retval = do_n_tty_write(tty, file, buf, nr);
+	up_read(&tty->termios_rwsem);
+
+	return retval;
+}
+
 /**
  *	n_tty_poll		-	poll method for N_TTY
  *	@tty: terminal device
diff --git a/include/linux/tty.h b/include/linux/tty.h
index cafb9b7f7..3499845ab 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -390,7 +390,7 @@ static inline void tty_set_flow_change(struct tty_struct *tty, int val)
 
 static inline bool tty_io_nonblock(struct tty_struct *tty, struct file *file)
 {
-	return file->f_flags & O_NONBLOCK ||
+	return (file && file->f_flags & O_NONBLOCK) ||
 		test_bit(TTY_LDISC_CHANGING, &tty->flags);
 }
 
-- 
2.26.2

