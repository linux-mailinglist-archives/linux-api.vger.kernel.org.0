Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851DB416402
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhIWRNj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242537AbhIWRNg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:13:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CF0C061767;
        Thu, 23 Sep 2021 10:12:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id DAF181F44602
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 08/22] futex: Rename: {get,cmpxchg}_futex_value_locked()
Date:   Thu, 23 Sep 2021 14:10:57 -0300
Message-Id: <20210923171111.300673-9-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923171111.300673-1-andrealmeid@collabora.com>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In order to prepare introducing these symbols into the global
namespace; rename them:

 s/\<\([^_ ]*\)_futex_value_locked/futex_\1_value_locked/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex/core.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 032189fa7b7f..0e10aeef3468 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -732,7 +732,7 @@ static struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb,
 	return NULL;
 }
 
-static int cmpxchg_futex_value_locked(u32 *curval, u32 __user *uaddr,
+static int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr,
 				      u32 uval, u32 newval)
 {
 	int ret;
@@ -744,7 +744,7 @@ static int cmpxchg_futex_value_locked(u32 *curval, u32 __user *uaddr,
 	return ret;
 }
 
-static int get_futex_value_locked(u32 *dest, u32 __user *from)
+static int futex_get_value_locked(u32 *dest, u32 __user *from)
 {
 	int ret;
 
@@ -1070,7 +1070,7 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 	 * still is what we expect it to be, otherwise retry the entire
 	 * operation.
 	 */
-	if (get_futex_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr))
 		goto out_efault;
 
 	if (uval != uval2)
@@ -1220,7 +1220,7 @@ static int handle_exit_race(u32 __user *uaddr, u32 uval,
 	 * The same logic applies to the case where the exiting task is
 	 * already gone.
 	 */
-	if (get_futex_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr))
 		return -EFAULT;
 
 	/* If the user space value has changed, try again. */
@@ -1341,7 +1341,7 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
 
-	err = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+	err = futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 	if (unlikely(err))
 		return err;
 
@@ -1388,7 +1388,7 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 	 * Read the user space value first so we can validate a few
 	 * things before proceeding further.
 	 */
-	if (get_futex_value_locked(&uval, uaddr))
+	if (futex_get_value_locked(&uval, uaddr))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -1559,7 +1559,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 		goto out_unlock;
 	}
 
-	ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+	ret = futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 	if (!ret && (curval != uval)) {
 		/*
 		 * If a unconditional UNLOCK_PI operation (user space did not
@@ -2006,7 +2006,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 	u32 curval;
 	int ret;
 
-	if (get_futex_value_locked(&curval, pifutex))
+	if (futex_get_value_locked(&curval, pifutex))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -2182,7 +2182,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	if (likely(cmpval != NULL)) {
 		u32 curval;
 
-		ret = get_futex_value_locked(&curval, uaddr1);
+		ret = futex_get_value_locked(&curval, uaddr1);
 
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
@@ -2628,14 +2628,14 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
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
 
@@ -2872,7 +2872,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 retry_private:
 	*hb = futex_q_lock(q);
 
-	ret = get_futex_value_locked(&uval, uaddr);
+	ret = futex_get_value_locked(&uval, uaddr);
 
 	if (ret) {
 		futex_q_unlock(*hb);
@@ -3250,7 +3250,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	 * preserve the WAITERS bit not the OWNER_DIED one. We are the
 	 * owner.
 	 */
-	if ((ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))) {
+	if ((ret = futex_cmpxchg_value_locked(&curval, uaddr, uval, 0))) {
 		spin_unlock(&hb->lock);
 		switch (ret) {
 		case -EFAULT:
@@ -3588,7 +3588,7 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 	 * does not guarantee R/W access. If that fails we
 	 * give up and leave the futex locked.
 	 */
-	if ((err = cmpxchg_futex_value_locked(&nval, uaddr, uval, mval))) {
+	if ((err = futex_cmpxchg_value_locked(&nval, uaddr, uval, mval))) {
 		switch (err) {
 		case -EFAULT:
 			if (fault_in_user_writeable(uaddr))
@@ -3934,7 +3934,7 @@ static void __init futex_detect_cmpxchg(void)
 	 * implementation, the non-functional ones will return
 	 * -ENOSYS.
 	 */
-	if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
+	if (futex_cmpxchg_value_locked(&curval, NULL, 0, 0) == -EFAULT)
 		futex_cmpxchg_enabled = 1;
 #endif
 }
-- 
2.33.0

