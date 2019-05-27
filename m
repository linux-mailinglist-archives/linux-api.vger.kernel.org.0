Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47B52BAB0
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 21:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfE0T14 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 15:27:56 -0400
Received: from mail.efficios.com ([167.114.142.138]:55984 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfE0T1z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 May 2019 15:27:55 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AB0D6200ECD;
        Mon, 27 May 2019 15:27:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 2XDxU0yZTogr; Mon, 27 May 2019 15:27:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1DF44200EC5;
        Mon, 27 May 2019 15:27:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1DF44200EC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1558985273;
        bh=d31GhQ9bjr6oReTPqU/khzs4flPCAOchr34x8uA7phA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NwtpcrHO5Ph9WBzkmHBi58aqvmzA+duCIFTAk6+EISV5Qqbb2/q7e64B5BPbx/VMj
         WOoANuLvR2DdzsPpu3jCkYim9NuLZMiHUBz+eunwmwEpbGI04wjN4H23DbrApucR+E
         TCb6tY5d8ZWwiZIHo5+1xUHg98N5UIgzSxImzYxGRKYn5Mr92kMcMJRVwfc4IbDcPo
         S8rSxNE/EcyXlGgHKCK5sxOfdR8uscAdbzkj3FibQFcfSgAs+O47ntYkwj6ssBrPOd
         eogvNNniRcv+iLtsmxCMlP8JIPbys8QKXCJjiTe6OhAYUIFiivofcfkWbP+3bU0/S0
         OVWo1yjd+xmzw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id j1ZExa31FGWe; Mon, 27 May 2019 15:27:53 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0176E200EBC;
        Mon, 27 May 2019 15:27:53 -0400 (EDT)
Date:   Mon, 27 May 2019 15:27:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1239705947.14878.1558985272873.JavaMail.zimbra@efficios.com>
In-Reply-To: <87h89gjgaf.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <20190503184219.19266-2-mathieu.desnoyers@efficios.com> <87h89gjgaf.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: 18yTu+T8PFt4cXiNhOg61XhmaTl3EQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On May 27, 2019, at 7:19 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> +/* volatile because fields can be read/updated by the kernel.  */
>> +__thread volatile struct rseq __rseq_abi = {
>> +  .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
>> +};
> 
> As I've explained repeatedly, the volatile qualifier is wrong because it
> is impossible to get rid of it.  (Accessing an object declared volatile
> using non-volatile pointers is undefined.)  Code using __rseq_abi should
> use relaxed MO atomics or signal fences/compiler barriers, as
> appropriate.

Hi Florian,

OK. So let's remove the volatile.

This means the sched_getcpu() implementation will need to load __rseq_abi.cpu_id
with a atomic_load_relaxed(), am I correct ?

This field can be updated at by the kernel at any point of user-space execution
due to preemption, so we need to ensure the load is performed as a single
instruction to prevent the compiler from doing load tearing, and to force it
to re-fetch the value within loops.

It would become:

int
sched_getcpu (void)
{
  int cpu_id = atomic_load_relaxed (&__rseq_abi.cpu_id);

  return cpu_id >= 0 ? cpu_id : vsyscall_sched_getcpu ();
}

> 
>> +/* Advertise Restartable Sequences registration ownership across
>> +   application and shared libraries.
>> +
>> +   Libraries and applications must check whether this variable is zero or
>> +   non-zero if they wish to perform rseq registration on their own. If it
>> +   is zero, it means restartable sequence registration is not handled, and
>> +   the library or application is free to perform rseq registration. In
>> +   that case, the library or application is taking ownership of rseq
>> +   registration, and may set __rseq_handled to 1. It may then set it back
>> +   to 0 after it completes unregistering rseq.
>> +
>> +   If __rseq_handled is found to be non-zero, it means that another
>> +   library (or the application) is currently handling rseq registration.
>> +
>> +   Typical use of __rseq_handled is within library constructors and
>> +   destructors, or at program startup.  */
>> +
>> +int __rseq_handled;
> 
> It's not clear to me whether the intent is that __rseq_handled reflects
> kernel support for rseq or not.

If __rseq_handled is set, it means a library is managing the rseq registration.
It is independent from the fact that the kernel supports rseq or not.

If e.g. glibc manages rseq registration, it sets __rseq_handled to 1. It will
then query the kernel for rseq availability. If the kernel happens to not
support rseq, the __rseq_abi.cpu_id will be set to RSEQ_CPU_ID_REGISTRATION_FAILED,
which means the registration has failed.

The kernel does not support rseq in that scenario, and it would be pointless
for an early adopter library to try to also register it.

As soon as a library changes the state of __rseq_abi.cpu_id, it is indeed
managing rseq registration. Perhaps the meaning of "handling" rseq registration
should be clarified in the comment.

> Currently, it only tells us whether
> glibc has been built with rseq support or not.  It does not reflect
> kernel support.

We know we have kernel support if __rseq_abi.cpu_id >= 0.

>  I'm still not convinced that this symbol is necessary,
> especially if we mandate a kernel header version which defines __NR_rseq
> for building glibc (which may happen due to the time64_t work).

__NR_rseq is not yet supported by all Linux architectures. So we will need
to support building glibc against kernel headers that do not define __NR_rseq
for quite a while anyway.

Moreover, this does not solve the issue tackled by __rseq_handled: early
adopter libraries managing rseq registration built against older glibc
versions which eventually end up running within a process linked against
a newer glibc which handles rseq registration.

> 
> Furthermore, the reference to ELF constructors is misleading.  I believe
> the code you added to __libc_start_main to initialize __rseq_handled and
> register __seq_abi with the kernel runs *after* ELF constructors have
> executed (and not at all if the main program is written in Go, alas).
> All initialization activity for the shared case needs to happen in
> elf/rtld.c or called from there, probably as part of the security
> initialization code or thereabouts.

in elf/rtld.c:dl_main() we have the following code:

  /* We do not initialize any of the TLS functionality unless any of the
     initial modules uses TLS.  This makes dynamic loading of modules with
     TLS impossible, but to support it requires either eagerly doing setup
     now or lazily doing it later.  Doing it now makes us incompatible with
     an old kernel that can't perform TLS_INIT_TP, even if no TLS is ever
     used.  Trying to do it lazily is too hairy to try when there could be
     multiple threads (from a non-TLS-using libpthread).  */
  bool was_tls_init_tp_called = tls_init_tp_called;
  if (tcbp == NULL)
    tcbp = init_tls ();

If I understand your point correctly, I should move the rseq_init() and
rseq_register_current_thread() for the SHARED case just after this
initialization, otherwise calling those from LIBC_START_MAIN() is too
late and it runs after initial modules constructors (or not at all for
Go). However, this means glibc will start using TLS internally. I'm
concerned that this is not quite in line with the above comment which
states that TLS is not initialized if no initial modules use TLS.

For the !SHARED use-case, if my understanding is correct, I should keep
rseq_init() and rseq_register_current_thread() calls within LIBC_START_MAIN().

Thoughts ?

Thanks for the feedback!

Mathieu



> 
> Thanks,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
