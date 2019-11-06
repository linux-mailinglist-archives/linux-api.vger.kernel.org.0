Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5758EF15DC
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2019 13:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfKFMLX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Nov 2019 07:11:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45434 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfKFMLW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 Nov 2019 07:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573042280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpGpajIdUKG+l3evsOIcGbv3/o82O4FHGiGfJ+VbwHE=;
        b=MBEoqQ0o3G+DqF08lFkLGnyyvj+B8oGImjPz1HBPFCyJkYgUa4eVHyCvwwGg24J+0ilTJ8
        niGbETLW0/ObBu8EXfHMSKhhY0+MGr2nKmtNKSE1LoOhphAeXqZ40Y5nG+fzjpSbPjeE7Z
        FcYroEidvpbbTqA1hn509GUAMt2lRx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-6Y_jhjCfPPmLke4XljSNoQ-1; Wed, 06 Nov 2019 07:11:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F305800EBA;
        Wed,  6 Nov 2019 12:11:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9B42160BE0;
        Wed,  6 Nov 2019 12:11:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  6 Nov 2019 13:11:14 +0100 (CET)
Date:   Wed, 6 Nov 2019 13:11:11 +0100
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
Message-ID: <20191106121111.GC12575@redhat.com>
References: <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
 <20191105152728.GA5666@redhat.com>
 <alpine.DEB.2.21.1911051800070.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051851380.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051920420.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051959260.1869@nanos.tec.linutronix.de>
 <20191106085529.GA12575@redhat.com>
 <alpine.DEB.2.21.1911061028020.1869@nanos.tec.linutronix.de>
 <20191106103509.GB12575@redhat.com>
 <alpine.DEB.2.21.1911061154520.1869@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911061154520.1869@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 6Y_jhjCfPPmLke4XljSNoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/06, Thomas Gleixner wrote:
>
> But even if we adapt that patch to the current code it won't solve the
> -ESRCH issue I described above.

Hmm. I must have missed something. Why?

Please see the unfinished/untested patch below.

I think that (with or without this fix) handle_exit_race() logic needs
cleanups, there is no reason for get_futex_value_locked(), we can drop
->pi_lock right after we see PF_EXITPIDONE. Lets discuss this later.

But why we can not rely on handle_exit_race() without PF_EXITING check?

Yes, exit_robust_list() is called before exit_pi_state_list() which (with
this patch) sets PF_EXITPIDONE. But this is fine? handle_futex_death()
doesn't wakeup pi futexes, exit_pi_state_list() does this.

Could you explain?

Oleg.


diff --git a/kernel/exit.c b/kernel/exit.c
index a46a50d..a6c788c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -761,17 +761,6 @@ void __noreturn do_exit(long code)
 =09}
=20
 =09exit_signals(tsk);  /* sets PF_EXITING */
-=09/*
-=09 * Ensure that all new tsk->pi_lock acquisitions must observe
-=09 * PF_EXITING. Serializes against futex.c:attach_to_pi_owner().
-=09 */
-=09smp_mb();
-=09/*
-=09 * Ensure that we must observe the pi_state in exit_mm() ->
-=09 * mm_release() -> exit_pi_state_list().
-=09 */
-=09raw_spin_lock_irq(&tsk->pi_lock);
-=09raw_spin_unlock_irq(&tsk->pi_lock);
=20
 =09if (unlikely(in_atomic())) {
 =09=09pr_info("note: %s[%d] exited with preempt_count %d\n",
@@ -846,12 +835,6 @@ void __noreturn do_exit(long code)
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
index bcdf531..0d8edcf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1297,8 +1297,7 @@ void mm_release(struct task_struct *tsk, struct mm_st=
ruct *mm)
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
index bd18f60..c3b5d33 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -905,6 +905,7 @@ void exit_pi_state_list(struct task_struct *curr)
 =09 * versus waiters unqueueing themselves:
 =09 */
 =09raw_spin_lock_irq(&curr->pi_lock);
+=09curr->flags |=3D PF_EXITPIDONE;
 =09while (!list_empty(head)) {
 =09=09next =3D head->next;
 =09=09pi_state =3D list_entry(next, struct futex_pi_state, list);
@@ -1169,18 +1170,11 @@ static int attach_to_pi_state(u32 __user *uaddr, u3=
2 uval,
 =09return ret;
 }
=20
-static int handle_exit_race(u32 __user *uaddr, u32 uval,
-=09=09=09    struct task_struct *tsk)
+static int handle_exit_race(u32 __user *uaddr, u32 uval)
 {
 =09u32 uval2;
=20
 =09/*
-=09 * If PF_EXITPIDONE is not yet set, then try again.
-=09 */
-=09if (tsk && !(tsk->flags & PF_EXITPIDONE))
-=09=09return -EAGAIN;
-
-=09/*
 =09 * Reread the user space value to handle the following situation:
 =09 *
 =09 * CPU0=09=09=09=09CPU1
@@ -1245,7 +1239,7 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 =
uval, union futex_key *key,
 =09=09return -EAGAIN;
 =09p =3D find_get_task_by_vpid(pid);
 =09if (!p)
-=09=09return handle_exit_race(uaddr, uval, NULL);
+=09=09return handle_exit_race(uaddr, uval);
=20
 =09if (unlikely(p->flags & PF_KTHREAD)) {
 =09=09put_task_struct(p);
@@ -1259,13 +1253,13 @@ static int attach_to_pi_owner(u32 __user *uaddr, u3=
2 uval, union futex_key *key,
 =09 * p->pi_lock:
 =09 */
 =09raw_spin_lock_irq(&p->pi_lock);
-=09if (unlikely(p->flags & PF_EXITING)) {
+=09if (unlikely(p->flags & PF_EXITPIDONE)) {
 =09=09/*
 =09=09 * The task is on the way out. When PF_EXITPIDONE is
 =09=09 * set, we know that the task has finished the
 =09=09 * cleanup:
 =09=09 */
-=09=09int ret =3D handle_exit_race(uaddr, uval, p);
+=09=09int ret =3D handle_exit_race(uaddr, uval);
=20
 =09=09raw_spin_unlock_irq(&p->pi_lock);
 =09=09put_task_struct(p);

