Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3AF1186
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2019 09:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfKFIzm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Nov 2019 03:55:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50919 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727882AbfKFIzl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 Nov 2019 03:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573030538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5xdFXcNgincji0RYeUETKSWOPK9/JzBbCUJSaYDbgU=;
        b=bXX2X5MFoGSNi1IHzD8y0yfP9hHEe4rY4c5QT9WRO+y6cUznRbGHSO/rrPItyKxOFSS1bx
        fgesLBowetmvRIlkMsUcF6vdqog/ha5Uu/bkF3asnzA/IIfcikcYSUKX9w5pB2mRPBhfqB
        p5wK6TUcDxO3bu8IEJVLJlroAjK6Ox0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-boHwpARWOCe1CnVuNAgH4w-1; Wed, 06 Nov 2019 03:55:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F67C800C72;
        Wed,  6 Nov 2019 08:55:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 653E35D70E;
        Wed,  6 Nov 2019 08:55:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  6 Nov 2019 09:55:32 +0100 (CET)
Date:   Wed, 6 Nov 2019 09:55:29 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Florian Weimer <fweimer@redhat.com>, Shawn Landden <shawn@git.icu>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: handle_exit_race && PF_EXITING
Message-ID: <20191106085529.GA12575@redhat.com>
References: <20191104002909.25783-1-shawn@git.icu>
 <87woceslfs.fsf@oldenburg2.str.redhat.com>
 <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
 <20191105152728.GA5666@redhat.com>
 <alpine.DEB.2.21.1911051800070.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051851380.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051920420.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051959260.1869@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911051959260.1869@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: boHwpARWOCe1CnVuNAgH4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/05, Thomas Gleixner wrote:
>
>  sys_futex()
>     loop infinite because
>     =09 PF_EXITING is set,
> =09 but PF_EXITPIDONE not

Yes.

IOW, the problem is very simple. RT task preempts the exiting lock owner
after it sets PF_EXITING but before it sets PF_EXITPIDONE, if they run on
the same CPU futex_lock_pi() will spin forever.

> So the obvious question is why PF_EXITPIDONE is set way after the futex
> exit cleanup has run,

Another obvious question is why this code checks PF_EXITING. I still think
it should not.

> The way we can deal with that is:
>
>     do_exit()
>     tsk->flags |=3D PF_EXITING;
>     ...
>     mutex_lock(&tsk->futex_exit_mutex);
>     futex_exit();
>     tsk->flags |=3D PF_EXITPIDONE;
>     mutex_unlock(&tsk->futex_exit_mutex);
>
> and on the futex lock_pi side:
>
>     if (!(tsk->flags & PF_EXITING))
>     =09return 0;=09=09<- All good
>
>     if (tsk->flags & PF_EXITPIDONE)
>         return -EOWNERDEAD;=09<- Locker can take over
>
>     mutex_lock(&tsk->futex_exit_mutex);
>     if (tsk->flags & PF_EXITPIDONE) {
>         mutex_unlock(&tsk->futex_exit_mutex);
>         return -EOWNERDEAD;=09<- Locker can take over
>     }
>
>     queue_futex();
>     mutex_unlock(&tsk->futex_exit_mutex);
>
> Not that I think it's pretty, but it plugs all holes AFAICT.

I have found the fix I sent in 2015, attached below. I forgot everything
I knew about futex.c, so I need some time to adapt it to the current code.

But I think it is clear what this patch tries to do, do you see any hole?

Oleg.

[PATCH] futex: don't spin waiting for PF_EXITING -> PF_EXITPIDONE transitio=
n

It is absolutely not clear why attach_to_pi_owner() returns -EAGAIN which
triggers "retry" if the lock owner is PF_EXITING but not PF_EXITPIDONE.
This burns CPU for no reason and this can even livelock if the rt_task()
caller preempts a PF_EXITING owner.

Remove the PF_EXITING check altogether. We do not care if it is exiting,
all we need to know is can we rely on exit_pi_state_list() or not. So we
also need to set PF_EXITPIDONE before we flush ->pi_state_list and call
exit_pi_state_list() unconditionally.

Perhaps we can add the fast-path list_empty() check in mm_release() back,
but lets fix the problem first. Besides, in theory this check is already
not correct, at least it should be list_empty_careful() to avoid the race
with free_pi_state() in progress.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/exit.c  |   22 +---------------------
 kernel/fork.c  |    3 +--
 kernel/futex.c |   40 ++++++++++------------------------------
 3 files changed, 12 insertions(+), 53 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 6806c55..bc969ed 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -683,27 +683,13 @@ void do_exit(long code)
 =09 */
 =09if (unlikely(tsk->flags & PF_EXITING)) {
 =09=09pr_alert("Fixing recursive fault but reboot is needed!\n");
-=09=09/*
-=09=09 * We can do this unlocked here. The futex code uses
-=09=09 * this flag just to verify whether the pi state
-=09=09 * cleanup has been done or not. In the worst case it
-=09=09 * loops once more. We pretend that the cleanup was
-=09=09 * done as there is no way to return. Either the
-=09=09 * OWNER_DIED bit is set by now or we push the blocked
-=09=09 * task into the wait for ever nirwana as well.
-=09=09 */
+=09=09/* Avoid the new additions to ->pi_state_list at least */
 =09=09tsk->flags |=3D PF_EXITPIDONE;
 =09=09set_current_state(TASK_UNINTERRUPTIBLE);
 =09=09schedule();
 =09}
=20
 =09exit_signals(tsk);  /* sets PF_EXITING */
-=09/*
-=09 * tsk->flags are checked in the futex code to protect against
-=09 * an exiting task cleaning up the robust pi futexes.
-=09 */
-=09smp_mb();
-=09raw_spin_unlock_wait(&tsk->pi_lock);
=20
 =09if (unlikely(in_atomic()))
 =09=09pr_info("note: %s[%d] exited with preempt_count %d\n",
@@ -779,12 +765,6 @@ void do_exit(long code)
 =09 * Make sure we are holding no locks:
 =09 */
 =09debug_check_no_locks_held();
-=09/*
-=09 * We can do this unlocked here. The futex code uses this flag
-=09 * just to verify whether the pi state cleanup has been done
-=09 * or not. In the worst case it loops once more.
-=09 */
-=09tsk->flags |=3D PF_EXITPIDONE;
=20
 =09if (tsk->io_context)
 =09=09exit_io_context(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 4dc2dda..ec3208e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -803,8 +803,7 @@ void mm_release(struct task_struct *tsk, struct mm_stru=
ct *mm)
 =09=09tsk->compat_robust_list =3D NULL;
 =09}
 #endif
-=09if (unlikely(!list_empty(&tsk->pi_state_list)))
-=09=09exit_pi_state_list(tsk);
+=09exit_pi_state_list(tsk);
 #endif
=20
 =09uprobe_free_utask(tsk);
diff --git a/kernel/futex.c b/kernel/futex.c
index b101381..c1104a8 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -716,11 +716,13 @@ void exit_pi_state_list(struct task_struct *curr)
=20
 =09if (!futex_cmpxchg_enabled)
 =09=09return;
+
 =09/*
-=09 * We are a ZOMBIE and nobody can enqueue itself on
-=09 * pi_state_list anymore, but we have to be careful
-=09 * versus waiters unqueueing themselves:
+=09 * attach_to_pi_owner() can no longer add the new entry. But
+=09 * we have to be careful versus waiters unqueueing themselves.
 =09 */
+=09curr->flags |=3D PF_EXITPIDONE;
+
 =09raw_spin_lock_irq(&curr->pi_lock);
 =09while (!list_empty(head)) {
=20
@@ -905,24 +907,12 @@ static int attach_to_pi_owner(u32 uval, union futex_k=
ey *key,
 =09=09return -EPERM;
 =09}
=20
-=09/*
-=09 * We need to look at the task state flags to figure out,
-=09 * whether the task is exiting. To protect against the do_exit
-=09 * change of the task flags, we do this protected by
-=09 * p->pi_lock:
-=09 */
 =09raw_spin_lock_irq(&p->pi_lock);
-=09if (unlikely(p->flags & PF_EXITING)) {
-=09=09/*
-=09=09 * The task is on the way out. When PF_EXITPIDONE is
-=09=09 * set, we know that the task has finished the
-=09=09 * cleanup:
-=09=09 */
-=09=09int ret =3D (p->flags & PF_EXITPIDONE) ? -ESRCH : -EAGAIN;
-
+=09if (unlikely(p->flags & PF_EXITPIDONE)) {
+=09=09/* exit_pi_state_list() was already called */
 =09=09raw_spin_unlock_irq(&p->pi_lock);
 =09=09put_task_struct(p);
-=09=09return ret;
+=09=09return -ESRCH;
 =09}
=20
 =09/*
@@ -1633,12 +1623,7 @@ retry_private:
 =09=09=09=09goto retry;
 =09=09=09goto out;
 =09=09case -EAGAIN:
-=09=09=09/*
-=09=09=09 * Two reasons for this:
-=09=09=09 * - Owner is exiting and we just wait for the
-=09=09=09 *   exit to complete.
-=09=09=09 * - The user space value changed.
-=09=09=09 */
+=09=09=09/* The user space value changed. */
 =09=09=09free_pi_state(pi_state);
 =09=09=09pi_state =3D NULL;
 =09=09=09double_unlock_hb(hb1, hb2);
@@ -2295,12 +2280,7 @@ retry_private:
 =09=09case -EFAULT:
 =09=09=09goto uaddr_faulted;
 =09=09case -EAGAIN:
-=09=09=09/*
-=09=09=09 * Two reasons for this:
-=09=09=09 * - Task is exiting and we just wait for the
-=09=09=09 *   exit to complete.
-=09=09=09 * - The user space value changed.
-=09=09=09 */
+=09=09=09/* The user space value changed. */
 =09=09=09queue_unlock(hb);
 =09=09=09put_futex_key(&q.key);
 =09=09=09cond_resched();
--=20
1.5.5.1



