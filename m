Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBEEA2C23
	for <lists+linux-api@lfdr.de>; Fri, 30 Aug 2019 03:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfH3BLu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Aug 2019 21:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfH3BLt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Aug 2019 21:11:49 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5952B22CF5;
        Fri, 30 Aug 2019 01:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567127508;
        bh=X4irArokqxNk8ds89THjZ+EOtSp5mEI9ypOKtb4645w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAH7HTQ/GVrTfuvRZyLVzj+vTBP6khi9fqCPzbAkINksEpbX0rnPbsbSFX9CcnLwe
         1MpiQaklsb0BG99ddXClKHKulMZq3XSR1xLoHMao4XER9XM+5686Y1wgE7WvfjlDDe
         4q47LPgaryspKa5IG8X8XbYErXoSKzzISVNmMm3c=
From:   Andy Lutomirski <luto@kernel.org>
To:     Theodore Tso <tytso@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 6/7] random: Delete code to pull data into pools
Date:   Thu, 29 Aug 2019 18:11:41 -0700
Message-Id: <5df8443b2987ed344e0b2e311743ace634a42d12.1567126741.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1567126741.git.luto@kernel.org>
References: <cover.1567126741.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

There is no pool that pulls, so it was just dead code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4521138231ed..99fea5cc29a8 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -528,10 +528,8 @@ struct entropy_store {
 	const struct poolinfo *poolinfo;
 	__u32 *pool;
 	const char *name;
-	struct entropy_store *pull;
 
 	/* read-write data: */
-	unsigned long last_pulled;
 	spinlock_t lock;
 	unsigned short add_ptr;
 	unsigned short input_rotate;
@@ -1347,41 +1345,6 @@ EXPORT_SYMBOL_GPL(add_disk_randomness);
  *
  *********************************************************************/
 
-/*
- * This utility inline function is responsible for transferring entropy
- * from the primary pool to the secondary extraction pool. We make
- * sure we pull enough for a 'catastrophic reseed'.
- */
-static void _xfer_secondary_pool(struct entropy_store *r, size_t nbytes);
-static void xfer_secondary_pool(struct entropy_store *r, size_t nbytes)
-{
-	if (!r->pull ||
-	    r->entropy_count >= (nbytes << (ENTROPY_SHIFT + 3)) ||
-	    r->entropy_count > r->poolinfo->poolfracbits)
-		return;
-
-	_xfer_secondary_pool(r, nbytes);
-}
-
-static void _xfer_secondary_pool(struct entropy_store *r, size_t nbytes)
-{
-	__u32	tmp[OUTPUT_POOL_WORDS];
-
-	int bytes = nbytes;
-
-	/* pull at least as much as a wakeup */
-	bytes = max_t(int, bytes, random_read_wakeup_bits / 8);
-	/* but never more than the buffer size */
-	bytes = min_t(int, bytes, sizeof(tmp));
-
-	trace_xfer_secondary_pool(r->name, bytes * 8, nbytes * 8,
-				  ENTROPY_BITS(r), ENTROPY_BITS(r->pull));
-	bytes = extract_entropy(r->pull, tmp, bytes,
-				random_read_wakeup_bits / 8, 0);
-	mix_pool_bytes(r, tmp, bytes);
-	credit_entropy_bits(r, bytes*8);
-}
-
 /*
  * This function decides how many bytes to actually take from the
  * given pool, and also debits the entropy count accordingly.
@@ -1545,7 +1508,6 @@ static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 			spin_unlock_irqrestore(&r->lock, flags);
 			trace_extract_entropy(r->name, EXTRACT_SIZE,
 					      ENTROPY_BITS(r), _RET_IP_);
-			xfer_secondary_pool(r, EXTRACT_SIZE);
 			extract_buf(r, tmp);
 			spin_lock_irqsave(&r->lock, flags);
 			memcpy(r->last_data, tmp, EXTRACT_SIZE);
@@ -1554,7 +1516,6 @@ static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 	}
 
 	trace_extract_entropy(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
-	xfer_secondary_pool(r, nbytes);
 	nbytes = account(r, nbytes, min, reserved);
 
 	return _extract_entropy(r, buf, nbytes, fips_enabled);
@@ -1765,7 +1726,6 @@ static void __init init_std_data(struct entropy_store *r)
 	ktime_t now = ktime_get_real();
 	unsigned long rv;
 
-	r->last_pulled = jiffies;
 	mix_pool_bytes(r, &now, sizeof(now));
 	for (i = r->poolinfo->poolbytes; i > 0; i -= sizeof(rv)) {
 		if (!arch_get_random_seed_long(&rv) &&
-- 
2.21.0

