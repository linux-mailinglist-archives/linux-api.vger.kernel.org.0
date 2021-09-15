Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A3140C73A
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhIOOTZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbhIOOTJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:19:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59305C0613C1;
        Wed, 15 Sep 2021 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qD0YCA63xzKIicMGLyhBX404N/spdtTzPpedQ5/+kdg=; b=aMKBNjt+h51M011W8BL/4Hvo8c
        FPq3yH6Hv8FcH0vf62fDmj/dTvTtoYn+UsqJmczsIq1XaDoab24RKBXioGjqLXv5AE/sPtFIeJaQc
        dVf+hNqqcIdptdraT56UTBMNfjtWYPn+76C4w6uFrUZxMq5ZcRz+bWTlSU7LyirLsYlSppu9w6kdw
        q2NlLkyDCMZsGXhq5kxyt15Pi267SuCV50t9wrivrR5gjS5m0lVliyDDM0sHU9Psjy980B6mINsaK
        WONIm2t/r7kAwYb0zuDD4qynj3zw4x6VQ/sVhLMXCNHP1JFvturrlzn3XkUmti13LqzQ72i9chh6R
        wjQKxv+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVj9-003PTs-Fi; Wed, 15 Sep 2021 14:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 188DD3008B8;
        Wed, 15 Sep 2021 16:17:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 05C06234E53A6; Wed, 15 Sep 2021 16:17:29 +0200 (CEST)
Message-ID: <20210915141525.108937118@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 08/20] futex: Rename: {get,cmpxchg}_futex_value_locked()
References: <20210915140710.596174479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In order to prepare introducing these symbols into the global
namespace; rename them:

 s/\<\([^_ ]*\)_futex_value_locked/futex_\1_value_locked/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -732,7 +732,7 @@ static struct futex_q *futex_top_waiter(
 	return NULL;
 }
 
-static int cmpxchg_futex_value_locked(u32 *curval, u32 __user *uaddr,
+static int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr,
 				      u32 uval, u32 newval)
 {
 	int ret;
@@ -744,7 +744,7 @@ static int cmpxchg_futex_value_locked(u3
 	return ret;
 }
 
-static int get_futex_value_locked(u32 *dest, u32 __user *from)
+static int futex_get_value_locked(u32 *dest, u32 __user *from)
 {
 	int ret;
 
@@ -1070,7 +1070,7 @@ static int attach_to_pi_state(u32 __user
 	 * still is what we expect it to be, otherwise retry the entire
 	 * operation.
 	 */
-	if (get_futex_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr))
 		goto out_efault;
 
 	if (uval != uval2)
@@ -1220,7 +1220,7 @@ static int handle_exit_race(u32 __user *
 	 * The same logic applies to the case where the exiting task is
 	 * already gone.
 	 */
-	if (get_futex_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr))
 		return -EFAULT;
 
 	/* If the user space value has changed, try again. */
@@ -1341,7 +1341,7 @@ static int lock_pi_update_atomic(u32 __u
 	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
 
-	err = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+	err = futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 	if (unlikely(err))
 		return err;
 
@@ -1388,7 +1388,7 @@ static int futex_lock_pi_atomic(u32 __us
 	 * Read the user space value first so we can validate a few
 	 * things before proceeding further.
 	 */
-	if (get_futex_value_locked(&uval, uaddr))
+	if (futex_get_value_locked(&uval, uaddr))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -1559,7 +1559,7 @@ static int wake_futex_pi(u32 __user *uad
 		goto out_unlock;
 	}
 
-	ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+	ret = futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 	if (!ret && (curval != uval)) {
 		/*
 		 * If a unconditional UNLOCK_PI operation (user space did not
@@ -2006,7 +2006,7 @@ futex_proxy_trylock_atomic(u32 __user *p
 	u32 curval;
 	int ret;
 
-	if (get_futex_value_locked(&curval, pifutex))
+	if (futex_get_value_locked(&curval, pifutex))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -2182,7 +2182,7 @@ int futex_requeue(u32 __user *uaddr1, un
 	if (likely(cmpval != NULL)) {
 		u32 curval;
 
-		ret = get_futex_value_locked(&curval, uaddr1);
+		ret = futex_get_value_locked(&curval, uaddr1);
 
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
@@ -2628,14 +2628,14 @@ static int __fixup_pi_state_owner(u32 __
 	if (!pi_state->owner)
 		newtid |= FUTEX_OWNER_DIED;
 
-	err = get_futex_value_locked(&uval, uaddr);
+	err = futex_get_value_locked(&uval, uaddr);
 	if (err)
 		goto handle_err;
 
 	for (;;) {
 		newval = (uval & FUTEX_OWNER_DIED) | newtid;
 
-		err = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+		err = futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 		if (err)
 			goto handle_err;
 
@@ -2872,7 +2872,7 @@ static int futex_wait_setup(u32 __user *
 retry_private:
 	*hb = futex_q_lock(q);
 
-	ret = get_futex_value_locked(&uval, uaddr);
+	ret = futex_get_value_locked(&uval, uaddr);
 
 	if (ret) {
 		futex_q_unlock(*hb);
@@ -3250,7 +3250,7 @@ int futex_unlock_pi(u32 __user *uaddr, u
 	 * preserve the WAITERS bit not the OWNER_DIED one. We are the
 	 * owner.
 	 */
-	if ((ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))) {
+	if ((ret = futex_cmpxchg_value_locked(&curval, uaddr, uval, 0))) {
 		spin_unlock(&hb->lock);
 		switch (ret) {
 		case -EFAULT:
@@ -3588,7 +3588,7 @@ static int handle_futex_death(u32 __user
 	 * does not guarantee R/W access. If that fails we
 	 * give up and leave the futex locked.
 	 */
-	if ((err = cmpxchg_futex_value_locked(&nval, uaddr, uval, mval))) {
+	if ((err = futex_cmpxchg_value_locked(&nval, uaddr, uval, mval))) {
 		switch (err) {
 		case -EFAULT:
 			if (fault_in_user_writeable(uaddr))
@@ -3934,7 +3934,7 @@ static void __init futex_detect_cmpxchg(
 	 * implementation, the non-functional ones will return
 	 * -ENOSYS.
 	 */
-	if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
+	if (futex_cmpxchg_value_locked(&curval, NULL, 0, 0) == -EFAULT)
 		futex_cmpxchg_enabled = 1;
 #endif
 }


