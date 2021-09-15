Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6C40C733
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbhIOOTJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbhIOOTJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:19:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C0C061575;
        Wed, 15 Sep 2021 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gayeFQoleCUQQDyuBnh7LSK/9+UPW6t+X7Htmku3f4s=; b=IGempERyvTUsrrMrQ6GphB7W/w
        oEEhJ8n2eRrMEkiiTF5j2hJd4dzqEhAkqxLLQNckHWliIa07cwkRdtvZ96t786h4D9/r0MlFyRdeV
        Z0mZBu6AImaWeK/mo20cPZW2IXZzh1Xgagqz5FLMnDYlxFnd5DQrFk7kK5PAUKuMctwVuVuv6Tjyp
        WcJ2EJNyzMbqqkJh25oh0HbiyJDu/Kq0AYRyKYl072GU5AMeIhdQwM8TXy13HqwI9FcmrTeJMJCK9
        J23Pq0NkvVxXvXH5FoP4p4YIM44CDznZnIZjxzJ4arg1DfCAKTjEEcEVXDDnjcRffDYIf81y40g16
        fUwL8EOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVjA-003PU3-9t; Wed, 15 Sep 2021 14:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A093300C80;
        Wed, 15 Sep 2021 16:17:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2F2D028B2AEB3; Wed, 15 Sep 2021 16:17:29 +0200 (CEST)
Message-ID: <20210915141525.556892413@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 15/20] futex: Simplify double_lock_hb()
References: <20210915140710.596174479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/futex.h |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -316,14 +316,12 @@ extern void futex_q_unlock(struct futex_
 static inline void
 double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 {
-	if (hb1 <= hb2) {
-		spin_lock(&hb1->lock);
-		if (hb1 < hb2)
-			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
-	} else { /* hb1 > hb2 */
-		spin_lock(&hb2->lock);
-		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
-	}
+	if (hb1 > hb2)
+		swap(hb1, hb2);
+
+	spin_lock(&hb1->lock);
+	if (hb1 != hb2)
+		spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
 }
 
 static inline void


