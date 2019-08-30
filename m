Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FD4A2C1B
	for <lists+linux-api@lfdr.de>; Fri, 30 Aug 2019 03:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfH3BLr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Aug 2019 21:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfH3BLq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Aug 2019 21:11:46 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E6B21897;
        Fri, 30 Aug 2019 01:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567127505;
        bh=mXSu3yZoOBiiXKChRyUnZ8uuktrSKvYCEZu71UFxXJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YltCN12jd046f5sNbp6uI9OC6JGi1/KU0s1w5+EGSNFun5EsgUSLKB9/cLSrV0c+i
         ckdQwy9HT/EFN6ANJn1GVqTA4r1PrsdlZmjULXiQAUSiH0i6NrCxj3c9wFiO2nowU/
         XXuNApohlIpeLe7ubokYtkAH+v5eIUSTYAYm6+e0=
From:   Andy Lutomirski <luto@kernel.org>
To:     Theodore Tso <tytso@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/7] random: Add GRND_INSECURE to return best-effort non-cryptographic bytes
Date:   Thu, 29 Aug 2019 18:11:37 -0700
Message-Id: <d4fdee4bf20ad37feaf22c39964b46e123ccd7e3.1567126741.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1567126741.git.luto@kernel.org>
References: <cover.1567126741.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c       | 11 +++++++++--
 include/uapi/linux/random.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d152612e08fc..acabb870f222 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2122,7 +2122,14 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 {
 	int ret;
 
-	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM))
+	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM|GRND_INSECURE))
+		return -EINVAL;
+
+	/*
+	 * Requesting insecure and blocking randomness at the same time makes
+	 * no sense.
+	 */
+	if ((flags & (GRND_INSECURE|GRND_RANDOM)) == (GRND_INSECURE|GRND_RANDOM))
 		return -EINVAL;
 
 	if (count > INT_MAX)
@@ -2131,7 +2138,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 	if (flags & GRND_RANDOM)
 		return _random_read(flags & GRND_NONBLOCK, buf, count);
 
-	if (!crng_ready()) {
+	if (!(flags & GRND_INSECURE) && !crng_ready()) {
 		if (flags & GRND_NONBLOCK)
 			return -EAGAIN;
 		ret = wait_for_random_bytes();
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index 26ee91300e3e..c092d20088d3 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -49,8 +49,10 @@ struct rand_pool_info {
  *
  * GRND_NONBLOCK	Don't block and return EAGAIN instead
  * GRND_RANDOM		Use the /dev/random pool instead of /dev/urandom
+ * GRND_INSECURE	Return non-cryptographic random bytes
  */
 #define GRND_NONBLOCK	0x0001
 #define GRND_RANDOM	0x0002
+#define GRND_INSECURE	0x0004
 
 #endif /* _UAPI_LINUX_RANDOM_H */
-- 
2.21.0

