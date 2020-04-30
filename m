Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91081BF108
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgD3HQp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:16:45 -0400
Received: from mail.cs.msu.ru ([188.44.42.39]:50463 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgD3HQo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 03:16:44 -0400
X-Greylist: delayed 1989 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 03:16:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MCF4uYzz7F8p7ezZgMR/XpDxwDlhjV1t3xDjOnjcv0g=; b=jK/eik5oO4DUBeovMYOGZQDeET
        +6RSThmOVSvh1cJXdCq2stRPQYcRSWUU+FoZGiNOjPee+4ndh54dFCbWc+8wie9XNZtPY0FOb+p5X
        GJL69YgWKZhx2e/l0uQJd3ls4AqfiFJny/Atg5CgMElvFtpIxCZGypbpHdKxL7T5v1/IOKM279gB/
        TqEXLFUikP0VYfi003El6Avh/FuVZ/oLBOHy7cPFyPIVnvz1vBmPM975nFZUhAMQ5IrunOImkxoJs
        b9quQUZr6SkZYu6X0HPFXZuxfxqcYKcnO/N6xmVzUyxnO9NJFyWfMLoIwDocFLCIBoVz3YyyeOCjI
        uZxPUYew==;
Received: from [37.204.119.143] (port=42272 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93.0.4 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1jU2uv-000B4I-4v; Thu, 30 Apr 2020 09:43:29 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Date:   Thu, 30 Apr 2020 09:42:57 +0300
Message-Id: <20200430064301.1099452-4-ar@cs.msu.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430064301.1099452-1-ar@cs.msu.ru>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL autolearn=no autolearn_force=no version=3.4.4
Subject: [PATCH v3 3/7] n_tty: Send SIGINFO to fg pgrp on status request character
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

No kerninfo line is printed yet.

No existing implementation of this on any Unix-like system echoes
the status character; no existing implementation discards or flushes
pending input on VSTATUS receipt. Thus we do neither.

There are existing popular TUI applications (e. g. mutt) that only
turn off icanon and not iexten, but still do not expect any special
treatment of the status request character — so we require all three:
isig, icanon and iexten to trigger this.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 drivers/tty/n_tty.c | 15 +++++++++++++--
 include/linux/tty.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 1794d84e7..10d6b60a5 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -79,6 +79,10 @@
 #define ECHO_BLOCK		256
 #define ECHO_DISCARD_WATERMARK	N_TTY_BUF_SIZE - (ECHO_BLOCK + 32)
 
+#define SIG_FLUSHING_MASK ( \
+	rt_sigmask(SIGINT) | rt_sigmask(SIGQUIT) | \
+	rt_sigmask(SIGTSTP)			 )
+#define SIG_FLUSHING(sig) ((1 << sig) & SIG_FLUSHING_MASK)
 
 #undef N_TTY_TRACE
 #ifdef N_TTY_TRACE
@@ -1122,7 +1126,7 @@ static void isig(int sig, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (L_NOFLSH(tty)) {
+	if (L_NOFLSH(tty) || (!SIG_FLUSHING(sig))) {
 		/* signal only */
 		__isig(sig, tty);
 
@@ -1244,7 +1248,8 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 	if (I_IXON(tty))
 		start_tty(tty);
 	if (L_ECHO(tty)) {
-		echo_char(c, tty);
+		if (c != STATUS_CHAR(tty))
+			echo_char(c, tty);
 		commit_echoes(tty);
 	} else
 		process_echoes(tty);
@@ -1294,6 +1299,9 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 		} else if (c == SUSP_CHAR(tty)) {
 			n_tty_receive_signal_char(tty, SIGTSTP, c);
 			return 0;
+		} else if (c == STATUS_CHAR(tty)) {
+			n_tty_receive_signal_char(tty, SIGINFO, c);
+			return 0;
 		}
 	}
 
@@ -1848,6 +1856,9 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 			set_bit(INTR_CHAR(tty), ldata->char_map);
 			set_bit(QUIT_CHAR(tty), ldata->char_map);
 			set_bit(SUSP_CHAR(tty), ldata->char_map);
+			if (L_ICANON(tty) && L_IEXTEN(tty)) {
+				set_bit(STATUS_CHAR(tty), ldata->char_map);
+			}
 		}
 		clear_bit(__DISABLED_CHAR, ldata->char_map);
 		ldata->raw = 0;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index bd5fe0e90..8411fd18d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -120,6 +120,7 @@ struct tty_bufhead {
 #define WERASE_CHAR(tty) ((tty)->termios.c_cc[VWERASE])
 #define LNEXT_CHAR(tty)	((tty)->termios.c_cc[VLNEXT])
 #define EOL2_CHAR(tty) ((tty)->termios.c_cc[VEOL2])
+#define STATUS_CHAR(tty) ((tty)->termios.c_cc[VSTATUS])
 
 #define _I_FLAG(tty, f)	((tty)->termios.c_iflag & (f))
 #define _O_FLAG(tty, f)	((tty)->termios.c_oflag & (f))
-- 
2.26.2

