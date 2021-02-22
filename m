Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C122D321A91
	for <lists+linux-api@lfdr.de>; Mon, 22 Feb 2021 15:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBVOxy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Feb 2021 09:53:54 -0500
Received: from mail.efficios.com ([167.114.26.124]:59372 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBVOxx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Feb 2021 09:53:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4A0BA31D9F3;
        Mon, 22 Feb 2021 09:53:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qWipWIQqlJGq; Mon, 22 Feb 2021 09:53:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C927D31D9F2;
        Mon, 22 Feb 2021 09:53:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C927D31D9F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614005590;
        bh=wPjmYfhFF1uIglVBdUJXreooF4Fi1lQtXzkwUbCrG68=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=TkEWQHhiXL9QWtwt0pn64j7Yc1PO3yj9qp84fsGFxQuup6CjxaUrOOXOebDnzxggL
         xHooRqhGKvyu2gutiFPj1fsFoCGhjyRZjqXT1YXDb6YItHNI2ZKqSJUP6aEb4QRYC/
         uzGyxhk/KNmveJXzW3wq00UGB7BG0X+g5LvNTV3D/yZ+sF1qB/GCJwWnQdCw66vx1O
         B84Zo3+K2J5n4euRJW4bo7fDCnQp3i9pZB6X2QFbCS7Zbi2LtXRIF4rE3Nb4q+nnSZ
         o5HWVqSzuo0QjbQAVgwbfVVcahZ04KheLraqj1gms2X9be/ikCLa1vzc+BSW3nO1L6
         BbwGIlq1BZSpA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UsrCmF-bCwQv; Mon, 22 Feb 2021 09:53:10 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B08D131DA4D;
        Mon, 22 Feb 2021 09:53:10 -0500 (EST)
Date:   Mon, 22 Feb 2021 09:53:10 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Piotr Figiel <figiel@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, emmir@google.com,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1510231959.29418.1614005590596.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210222115726.GA30843@altlinux.org>
References: <20210222100443.4155938-1-figiel@google.com> <20210222115726.GA30843@altlinux.org>
Subject: Re: [PATCH] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Thread-Index: JeKlBcoleYbfr2zysFNBRALUsSBZ4Q==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Feb 22, 2021, at 6:57 AM, Dmitry V. Levin ldv@altlinux.org wrote:

> On Mon, Feb 22, 2021 at 11:04:43AM +0100, Piotr Figiel wrote:
> [...]
>> --- a/include/uapi/linux/ptrace.h
>> +++ b/include/uapi/linux/ptrace.h
>> @@ -102,6 +102,14 @@ struct ptrace_syscall_info {
>>  =09};
>>  };
>> =20
>> +#define PTRACE_GET_RSEQ_CONFIGURATION=090x420f
>> +
>> +struct ptrace_rseq_configuration {
>> +=09__u64 rseq_abi_pointer;
>> +=09__u32 signature;
>> +=09__u32 pad;
>> +};
>> +
>>  /*
>>   * These values are stored in task->ptrace_message
>>   * by tracehook_report_syscall_* to describe the current syscall-stop.
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 61db50f7ca86..a936af66cf6f 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/cn_proc.h>
>>  #include <linux/compat.h>
>>  #include <linux/sched/signal.h>
>> +#include <linux/minmax.h>
>> =20
>>  #include <asm/syscall.h>=09/* for syscall_get_* */
>> =20
>> @@ -779,6 +780,22 @@ static int ptrace_peek_siginfo(struct task_struct *=
child,
>>  =09return ret;
>>  }
>> =20
>> +#ifdef CONFIG_RSEQ
>> +static long ptrace_get_rseq_configuration(struct task_struct *task,
>> +=09=09=09=09=09  unsigned long size, void __user *data)
>> +{
>> +=09struct ptrace_rseq_configuration conf =3D {
>> +=09=09.rseq_abi_pointer =3D (u64)(uintptr_t)task->rseq,
>> +=09=09.signature =3D task->rseq_sig,
>> +=09};
>> +
>> +=09size =3D min_t(unsigned long, size, sizeof(conf));
>> +=09if (copy_to_user(data, &conf, size))
>> +=09=09return -EFAULT;
>> +=09return size;
>> +}
>> +#endif
>=20
> From API perspective I suggest for such interfaces to return the amount o=
f
> data that could have been written if there was enough room specified, e.g=
.
> in this case it's sizeof(conf) instead of size.

Looking at the ptrace(2) man page:

RETURN VALUE
       On success, the PTRACE_PEEK* requests return the  requested  data  (=
but
       see NOTES), the PTRACE_SECCOMP_GET_FILTER request returns the number=
 of
       instructions in the BPF program, and other requests return zero.

       On error, all requests return  -1,  and  errno  is  set  appropriate=
ly.
       Since  the  value  returned by a successful PTRACE_PEEK* request may=
 be
       -1, the caller must clear errno before the call, and then check it  =
af=E2=80=90
       terward to determine whether or not an error occurred.

It looks like the usual behavior for ptrace requests would be to return 0 w=
hen everything
is OK. Unless there a strong motivation for doing different for this new re=
quest, I
would be tempted to use the same expected behavior than other requests on s=
uccess:
return 0.

Unless there is a strong motivation for returning either size or sizeof(con=
f) ? If we
return sizeof(conf) to user-space, it means it should check it and deal wit=
h the
size mismatch. Is that size ever expected to change ?

Thanks,

Mathieu

>=20
>=20
> --
> ldv

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
