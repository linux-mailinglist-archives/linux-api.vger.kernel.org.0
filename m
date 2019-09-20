Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1007FB9304
	for <lists+linux-api@lfdr.de>; Fri, 20 Sep 2019 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfITOhI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Sep 2019 10:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392427AbfITOgf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 20 Sep 2019 10:36:35 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACCBB21907;
        Fri, 20 Sep 2019 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568990194;
        bh=kHRw263jBX10OebCpVsHw8yXgkHI5XAiaesnjRNlA+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anKKxAyVh/1IJmtvyICh43rKDNgKQ4FpuIN/dn0vWAIrk0bPPojuOPyRvuXEKrDeJ
         nQobi34/sCVTnLtUmusGdxgZAmkxUxKKcJkvUvQyhdv5/hT4/Nfd1l6Zmgvj38xZ1w
         +bccizQ421SdfyMrzusR6oyjuh30ag5yFy+/zp6E=
From:   Andy Lutomirski <luto@kernel.org>
To:     Theodore Tso <tytso@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 3/7] random: Ignore GRND_RANDOM in getentropy(2)
Date:   Fri, 20 Sep 2019 07:36:25 -0700
Message-Id: <900d198c4a57aa4c81d506b7d16f996c4414c3dc.1568990048.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568990048.git.luto@kernel.org>
References: <cover.1568990048.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The separate blocking pool is going away.  Start by ignoring
GRND_RANDOM in getentropy(2).

This should not materially break any API.  Any code that worked
without this change should work at least as well with this change.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c       | 3 ---
 include/uapi/linux/random.h | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index acabb870f222..1ad2c7eaf675 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2135,9 +2135,6 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 	if (count > INT_MAX)
 		count = INT_MAX;
 
-	if (flags & GRND_RANDOM)
-		return _random_read(flags & GRND_NONBLOCK, buf, count);
-
 	if (!(flags & GRND_INSECURE) && !crng_ready()) {
 		if (flags & GRND_NONBLOCK)
 			return -EAGAIN;
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index c092d20088d3..dcc1b3e6106f 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -48,7 +48,7 @@ struct rand_pool_info {
  * Flags for getrandom(2)
  *
  * GRND_NONBLOCK	Don't block and return EAGAIN instead
- * GRND_RANDOM		Use the /dev/random pool instead of /dev/urandom
+ * GRND_RANDOM		No effect
  * GRND_INSECURE	Return non-cryptographic random bytes
  */
 #define GRND_NONBLOCK	0x0001
-- 
2.21.0

