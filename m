Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1256A215D3C
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 19:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgGFRdt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 13:33:49 -0400
Received: from mail.efficios.com ([167.114.26.124]:45952 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgGFRdt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 13:33:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 86AF52D9653;
        Mon,  6 Jul 2020 13:33:47 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CO8gOEY7BbwQ; Mon,  6 Jul 2020 13:33:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0A6AB2D9892;
        Mon,  6 Jul 2020 13:33:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0A6AB2D9892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594056827;
        bh=i/WrZ1DoeGB46B7nkupfX78ZREZcTVGuidBQs5XahH0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Z2VIGKu9D9GtJKRe+EYIk+uLwQpNSpiFLQbr8WBC3/YVuqCmxpDqTjHo3mkSREtlp
         Oemp6hPw4ReEyjJ4ZkWVIRfO8Ns3S2X4Rn771XJ7l51EDFTuSZrPUbZ3NTzZY18U1r
         SilcSCirh/UBHxpvKTcFddLxq/xWFik3dJKovTvRAfFp9UEe7WJqVpN+gKGNPtN/eE
         cB4PStyrgNa52qRES6gvuyK6AU/lL1fTSqzLQWz+iW72gRluWu/sdpipHEDcbpSBHx
         uMY85Va9RbZuATfI768iz3chBTEubcxaUPf7p9rJBB6HYETaNgMnQUhAB6oKMkvxwf
         0zniJ6Q5SfbYQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wjh0mtULVLH2; Mon,  6 Jul 2020 13:33:46 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E90802D9917;
        Mon,  6 Jul 2020 13:33:46 -0400 (EDT)
Date:   Mon, 6 Jul 2020 13:33:46 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1679448037.22891.1594056826859.JavaMail.zimbra@efficios.com>
In-Reply-To: <942999672.22574.1594046978937.JavaMail.zimbra@efficios.com>
References: <20200629190036.26982-1-mathieu.desnoyers@efficios.com> <20200629190036.26982-3-mathieu.desnoyers@efficios.com> <877dvg4ud4.fsf@oldenburg2.str.redhat.com> <942999672.22574.1594046978937.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH 2/3] Linux: Use rseq in sched_getcpu if available (v9)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3928)
Thread-Topic: Linux: Use rseq in sched_getcpu if available (v9)
Thread-Index: s+lDRWKNxhAkUDtcGJ1GCFO2e2bJllGyoJBw
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 6, 2020, at 10:49 AM, Mathieu Desnoyers mathieu.desnoyers@effi=
cios.com wrote:

> ----- On Jul 6, 2020, at 9:59 AM, Florian Weimer fweimer@redhat.com wrote=
:
>=20
>> * Mathieu Desnoyers:
>>=20
>>> When available, use the cpu_id field from __rseq_abi on Linux to
>>> implement sched_getcpu().  Fall-back on the vgetcpu vDSO if
>>> unavailable.
>>=20
>> I've pushed this to glibc master, but unfortunately it looks like this
>> exposes a kernel bug related to affinity mask changes.
>>=20
>> After building and testing glibc, this
>>=20
>>  for x in {1..2000} ; do posix/tst-affinity-static  & done
>>=20
>> produces some =E2=80=9Cerror:=E2=80=9D lines for me:
>>=20
>> error: Unexpected CPU 2, expected 0
>> error: Unexpected CPU 2, expected 0
>> error: Unexpected CPU 2, expected 0
>> error: Unexpected CPU 2, expected 0
>> error: Unexpected CPU 138, expected 0
>> error: Unexpected CPU 138, expected 0
>> error: Unexpected CPU 138, expected 0
>> error: Unexpected CPU 138, expected 0
>>=20
>> =E2=80=9Cexpected 0=E2=80=9D is a result of how the test has been writte=
n, it bails out
>> on the first failure, which happens with CPU ID 0.
>>=20
>> Smaller systems can use a smaller count than 2000 to reproduce this.  It
>> also happens sporadically when running the glibc test suite itself
>> (which is why it took further testing to reveal this issue).
>>=20
>> I can reproduce this with the Debian 4.19.118-2+deb10u1 kernel, the
>> Fedora 5.6.19-300.fc32 kernel, and the Red Hat Enterprise Linux kernel
>> 4.18.0-193.el8 (all x86_64).
>>=20
>> As to the cause, I'd guess that the exit path in the sched_setaffinity
>> system call fails to update the rseq area, so that userspace can observe
>> the outdated CPU ID there.
>=20
> Hi Florian,
>=20
> We have a similar test in Linux, see tools/testing/selftests/rseq/basic_t=
est.c.
> That test does not trigger this issue, even when executed repeatedly.
>=20
> I'll investigate further what is happening within the glibc test.

Here are the missing kernel bits. Just adding those in wake_up_new_task() i=
s
enough to make the problem go away, but to err on the safe side I'm plannin=
g to
add an rseq_migrate within sched_fork:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1757381cabd4..ff83f790a9b3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3043,6 +3043,7 @@ int sched_fork(unsigned long clone_flags, struct task=
_struct *p)
         * so use __set_task_cpu().
         */
        __set_task_cpu(p, smp_processor_id());
+       rseq_migrate(p);
        if (p->sched_class->task_fork)
                p->sched_class->task_fork(p);
        raw_spin_unlock_irqrestore(&p->pi_lock, flags);
@@ -3103,6 +3104,7 @@ void wake_up_new_task(struct task_struct *p)
         */
        p->recent_used_cpu =3D task_cpu(p);
        __set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0=
));
+       rseq_migrate(p);
 #endif
        rq =3D __task_rq_lock(p, &rf);
        update_rq_clock(rq);

I'm not sure why your test catches it fairly quickly but ours does not. Tha=
t's a good
catch.

Now we need to discuss how we introduce that fix in a way that will allow u=
ser-space
to trust the __rseq_abi.cpu_id field's content.

The usual approach to kernel bug fixing is typically to push the fix, mark =
it for
stable kernels, and expect everyone to pick up the fixes. I wonder how comf=
ortable
glibc would be to replace its sched_getcpu implementation with a broken-unt=
il-fixed
kernel rseq implementation without any mechanism in place to know whether i=
t can
trust the value of the cpu_id field. I am extremely reluctant to do so.

One possible way to introduce this fix would be to use the rseq flags argum=
ent to allow
glibc to query whether the kernel implements a rseq with a cpu_id field it =
can trust.
So glibc could do, for registration:

  ret =3D INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq),
                               RSEQ_FLAG_REGISTER | RSEQ_FLAG_RELIABLE_CPU_=
ID,
                               RSEQ_SIG);

(I'm open to bike-shedding the actual flag name)

So if the kernel does not implement the fix, the registration would return =
EINVAL.
When getting EINVAL like this, we could then re-issue the rseq syscall:

  ret =3D INTERNAL_SYSCALL_CALL (rseq, NULL, 0, RSEQ_FLAG_RELIABLE_CPU_ID, =
0);

to check whether EINVAL has been caused by other invalid system call parame=
ters,
or it's really because the RSEQ_FLAG_RELIABLE_CPU_ID flag is unknown. Being=
 able
to distinguish between invalid parameters and unknown flags like this would=
 end
up requiring one extra system call on failed registration attempt on kernel=
s which
implement a broken rseq.

This also means glibc would only start really activating rseq on kernels im=
plementing
this fix.

Thoughts ?

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
