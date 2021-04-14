Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0DC35F376
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 14:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350764AbhDNMVN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 08:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233040AbhDNMVM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 08:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618402850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NO4FGUOTnvyNv6ZEsf7CqScF3ifaTTajd0Qf2emlRl0=;
        b=YpS1w1cuS3xQcpeGuRymmMxzhteusWRnHMQGAS8iquKnbbXZ3mpk7McTt+ojglvvSVusfz
        eqLzd9ip+oUcSHiFaTD3/iE98RBgPqnSWBCWFF1XNSMPgyTctMqnHA05N/4OcFL5mzZqbm
        8ZxxW6ybr1XpNXFFceGsu0tj9EY8tJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-MbvmUyxeMQSe91Bt0GGgJQ-1; Wed, 14 Apr 2021 08:20:46 -0400
X-MC-Unique: MbvmUyxeMQSe91Bt0GGgJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03C101006C81;
        Wed, 14 Apr 2021 12:20:44 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-148.ams2.redhat.com [10.36.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 571D210016FE;
        Wed, 14 Apr 2021 12:20:34 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-um@lists.infradead.org, criu@openvz.org,
        Andrei Vagin <avagin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
References: <20210414055217.543246-1-avagin@gmail.com>
        <87blahb1pr.fsf@oldenburg.str.redhat.com>
        <CAG48ez2z0a4x2GfHv9L0HmO1-uzsKtfOF40erPb8ADR-m+itbg@mail.gmail.com>
Date:   Wed, 14 Apr 2021 14:20:48 +0200
In-Reply-To: <CAG48ez2z0a4x2GfHv9L0HmO1-uzsKtfOF40erPb8ADR-m+itbg@mail.gmail.com>
        (Jann Horn's message of "Wed, 14 Apr 2021 13:24:30 +0200")
Message-ID: <874kg99hwf.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Jann Horn:

> On Wed, Apr 14, 2021 at 12:27 PM Florian Weimer <fweimer@redhat.com> wrot=
e:
>>
>> * Andrei Vagin:
>>
>> > We already have process_vm_readv and process_vm_writev to read and wri=
te
>> > to a process memory faster than we can do this with ptrace. And now it
>> > is time for process_vm_exec that allows executing code in an address
>> > space of another process. We can do this with ptrace but it is much
>> > slower.
>> >
>> > =3D Use-cases =3D
>>
>> We also have some vaguely related within the same address space: running
>> code on another thread, without modifying its stack, while it has signal
>> handlers blocked, and without causing system calls to fail with EINTR.
>> This can be used to implement certain kinds of memory barriers.
>
> That's what the membarrier() syscall is for, right? Unless you don't
> want to register all threads for expedited membarrier use?

membarrier is not sufficiently powerful for revoking biased locks, for
example.

For the EINTR issue, <https://github.com/golang/go/issues/38836> is an
example.  I believe CIFS has since seen a few fixes (after someone
reported that tar on CIFS wouldn't work because the SIGCHLD causing
utimensat to fail=E2=80=94and there isn't even a signal handler for SIGCHLD=
!),
but the time it took to get to this point doesn't give me confidence
that it is safe to send signals to a thread that is running unknown
code.

But as you explained regarding the set*id broadcast, it seems that if we
had this run-on-another-thread functionality, we would likely encounter
issues similar to those with SA_RESTART.  We don't see the issue with
set*id today because it's a rare operation, and multi-threaded file
servers that need to change credentials frequently opt out of the set*id
broadcast anyway.  (What I have in mind is a future world where any
printf call, any malloc call, can trigger such a broadcast.)

The cross-VM CRIU scenario would probably somewhere in between (not
quite the printf/malloc level, but more frequent than set*id).

Thanks,
Florian

