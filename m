Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D221121DFF2
	for <lists+linux-api@lfdr.de>; Mon, 13 Jul 2020 20:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGMSkX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jul 2020 14:40:23 -0400
Received: from mail.efficios.com ([167.114.26.124]:58328 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgGMSkX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jul 2020 14:40:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F269A2A4A07;
        Mon, 13 Jul 2020 14:40:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id l2LzFfAbobEV; Mon, 13 Jul 2020 14:40:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3D1A42A4A06;
        Mon, 13 Jul 2020 14:40:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3D1A42A4A06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594665621;
        bh=OtJcpQT6Tlw3emHPtltrgY/B5bBauqAWAQxOtZu6g8E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pvgpEFdwme+7Hs0kX58yiYRT3p/YssMZK5NU/c+JWr/cb7cl8xwcPIJuJ568RXGoV
         guEvYtpKFjy78AcvOCMeEQfLf9ChHjvVUJWwoOG+RgNkG8Ra2Slg5etOFXBibjK10u
         0sK5w4Cphqd7o2uQLmgQtRLi2GV5QMfjviGixvmmmekca7axZaQYzZ6IcX8oHEk5fG
         RVCp0ezZUKY6D4PiGplGMtcWiJPsS3WvpFwfXrflvxQT+tjo43lN0Bobtlc0ZsPdeO
         /0FCD6qHmhqGu3CB8EQGEBIJhqc0nmRghxCCYJy2TmACGPinorYuEiRxfDink4iUVH
         d3bE/vTRagICQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id worjRc0Quwiy; Mon, 13 Jul 2020 14:40:21 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1669C2A473D;
        Mon, 13 Jul 2020 14:40:21 -0400 (EDT)
Date:   Mon, 13 Jul 2020 14:40:20 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        carlos <carlos@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Message-ID: <1305865358.10354.1594665620975.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200711155459.4mswacrvosw377tk@wittgenstein>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com> <87zh8bw158.fsf@mid.deneb.enyo.de> <1448906726.3717.1594222431276.JavaMail.zimbra@efficios.com> <20200708162247.txdleelcalxkrfjy@wittgenstein> <1565638541.5051.1594229688015.JavaMail.zimbra@efficios.com> <20200709124941.u4quvvaiabx36ee3@wittgenstein> <1197598149.7002.1594307757307.JavaMail.zimbra@efficios.com> <20200711155459.4mswacrvosw377tk@wittgenstein>
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce
 RSEQ_FLAG_RELIABLE_CPU_ID
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
Thread-Index: H9RtQhQ5vu1lETOVJqIpDy4KpmVemg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 11, 2020, at 11:54 AM, Christian Brauner christian.brauner@ubuntu.com wrote:

> 
> The registration is a thread-group property I'll assume, right, i.e. all
> threads will have rseq TLS or no thread will have it?

No, rseq registration is a per-thread property, but it would arguably be
a bit weird for a thread-group to observe different registration states
for different threads.

> Some things I seem to be able to assume (correct me if I'm wrong):
> - rseq registration is expected to be done at thread creation time

True.

> - rseq registration _should_ only be done once, i.e. if a caller detects
>  that rseq is already registered for a thread, then they could
>  technically re-register rseq - risking a feature mismatch if doing so
>  - but they shouldn't re-register but simply assume that someone else
>  is in control of rseq. If they violate that assumption than you're
>  hosed anyway.

Right.

> So it seems as long as callers leave rseq registration alone whenever
> they detect that it is already registered then one can assume that rseq
> is under consistent control of a single library/program. If that's the
> case it should safe to assume that the library will use the same rseq
> registration for all threads bounded by the available kernel features or
> by the set of features it is aware of.

The rseq registration is per-thread. But yes, as soon as one user registers
rseq, other users for that thread are expected to piggy-back on that
registration.

> I proposed that specific scheme because I was under the impression that
> you are in need of a mechanism for a caller (at thread creation I
> assume) to check what feature set is supported by rseq _without_
> issung a system call. If you were to record the requested flags in
> struct rseq or in some other way, then another library which tries to
> register rseq for a thread but detects it has already been registered
> can look at e.g. whether the reliable cpu feature is around and then
> adjust it's behavior accordingly.
> Another reason why this seems worthwhile is because of how rseq works in
> general. Since it registers a piece of userspace memory which userspace
> can trivially access enforcing that userspace issue a syscall to get at
> the feature list seems odd when you can just record it in the struct.
> But that's a matter of style, I guess.

Good points.

> 
> Also, I'm thinking about the case of adding one or two new features that
> introduce mutually exclusive behavior for rseq, i.e. if you register
> rseq with FEAT1 and someone else registers it with FEAT2 and FEAT1 and
> FEAT2 would lead to incompatible behavior for an aspect or all of rseq.
> Even if you had a way to query the kernel for FEAT1 and FEAT2 in the
> rseq syscall it still be a problem since a caller wouldn't know at rseq
> registration time whether the library registered rseq with FEAT1 or
> FEAT2. If you record the behavior somewhere - kernel_flags or whatever -
> then the caller could check at registration time "ah, rseq is registered
> with this behavior" I need to adjust my behavior.

I think what we want here is to be able to extend the feature set, but not
"pick and choose" different incompatible features.

[...]
>> 
>> One additional thing to keep in mind: the application can itself choose
>> to define the __rseq_abi TLS, which AFAIU (please let me know if I am
>> wrong) would take precedence over glibc's copy. So extending the
> 
> You mean either that an application could simply choose to ignore that e.g.
> glibc has already registered rseq and e.g. unregister it and register
> it's own or that it registers it's own rseq before glibc comes into the
> play?

No quite.

I mean that an application binary or a preloaded library is allowed to
interpose with glibc and expose a __rseq_abi symbol with a size smaller
than glibc's __rseq_abi. The issue is that glibc (or other library
responsible for rseq registration) is unaware of that symbol's size.

This means that extending __rseq_abi cannot be done by means of additional
flags or parameters passed directly from the registration owner to the
rseq system call.

> I mean, if I interpreted what you're trying to say correctly, I think
> one needs to work under the assumption that if someone else has already
> registered rseq than it becomes the single source of truth. I think that
> basically needs to be the contract. Same way you expect a user of
> pthreads to not suddenly go and call clone3() with CLONE_THREAD |
> CLONE_VM | [...] and assume that this won't mess with glibc's internal
> state.

Right. The issue is not about which library owns the registration, but
rather making sure everyone agree on the size of __rseq_abi, including
interposition scenarios.

[...]
>> 
>> For both approaches, we could either pass them as parameters with rseq
>> registration, and make rseq registration success conditional on the
>> kernel implementing those feature/fix-version, or validate the flag/version
>> separately from registration.
>> 
>> If this is done on registration, it means glibc will eventually have to
>> handle this. This prevents user libraries with specific needs to query
>> whether their features are available. Doing the feature/version validation
>> separately from registration allows each user library to make its own
>> queries and take advantage of new kernel features before glibc is
>> upgraded to be made aware of them.
> 
> Why isn't there a "dual scheme"? I.e. you record the features somewhere
> in struct rseq or some other place so userspace can query an already
> registered thread for the features it was registered with and have a way
> to query the kernel for the supported features through the system call
> (See what I suggested above with the feature checking flags.).

This discussion got my head into gears over the weekend, and I think
I came up with something that could elegantly solve all the "rseq extensibility"
problem. More below.

[...]

> I really think this is not an rseq specific problem. This seems to be a
> generic problem any interface has when it e.g. makes use of an extended
> struct and e.g. decides to make its own syscalls without going through
> the glibc wrappers (If there are any...). That's the reality right now
> and will likely always be that way short of us blocking non-libc
> syscalls similar to some bsds at which point we need a 1:1 kernel + libc
> development. :) That's not going to happen. The problem ranges from
> struct statx to struct clone_args and struct open_how and so on.

AFAIU the only "special" thing about rseq is that its __rseq_abi is
a TLS symbol shared between application/libraries, and interposition is
allowed.

> 
> But one question. Musn't the assumption be that all threads in a
> thread-group if they have registered rseq then the same
> application/library has done that registration?

No, __rseq_abi is a TLS, and the registration is per-thread.

> And if that's the case
> then the application/library doing the registration is what defines the
> layout for that thread-group and becomes the one source of truth.
> Basically, if an application uses it's own rseq then glibc must be out
> of the picture. If that's not part of the contract then it feels to me
> that rseq cannot be extended (for now).

Indeed, the new scheme I have in mind for rseq extensibility would allow
new features to be used between new application/library and kernel even
with an older glibc which would contain the rseq registration code, but
be unaware of those new features.

[...]
> 
> Wouldn't the non-updated application just access fields and methods of
> the smaller struct? The way struct extensions work is that we only
> extend them after the last member and always correctly 64 bit aligned.
> And as long as you only extend the struct at the end wouldn't that be
> ok? An application with a non-updated/smaller struct rseq would just
> access fields that the larger struct supports, no?

The issue is symbol interposition, as discussed above.

So here is the idea which emerged through the weekend as I was thinking
about your email:

* Current technical constraints
  - struct rseq __rseq_abi can be interposed by preloaded libraries and
    application, without knowledge from the registration "owner" (typically
    glibc).

* Objectives:
  - Allow extending the size of struct rseq to add additional features,
    such as node_id field, signal-disabling fields, and so on.
  - Allow extending this size without requiring an upgrade of the library
    performing rseq registration. Simply upgrading the rseq "user" application
    or library and the kernel should suffice.

* Proposed ABI
  - Reserve a bit in the field (struct rseq *)->flags of the TLS __rseq_abi,
    named e.g.: RSEQ_CS_FLAG_SIZE = (1U << 3).
  - A definition wishing to extend struct rseq would be required to initialize
    __rseq_abi with this bit set in the flags field.
  - When RSEQ_CS_FLAG_SIZE is set, struct rseq is guaranteed to have two new
    fields after the flags field: a __u32 user_size and a __u32 kernel_size field.
  - The user_size field is meant to be initialized to sizeof(struct rseq) by the
    __rseq_abi definition. In an interposition scenario, a kernel supporting this
    size feature will know about the size of the symbol by checking both the
    RSEQ_CS_FLAG_SIZE flag and the user_size field.
  - On registration, if the __rseq_abi.flags RSEQ_CS_FLAG_SIZE flag is set (and this
    flag is supported by the kernel), the kernel updates the kernel_size field to
    min(sizeof(struct rseq), __rseq_abi.user_size), effectively the subset of size
    supported by both the user-space __rseq_abi definition and by the kernel.
  - Users wishing to use additional fields beyond __rseq_abi.flags would need to check
    that __rseq_abi->flags & RSEQ_CS_FLAG_SIZE is true, and that
    __rseq_abi.kernel_size >= offsetof(struct rseq, feature_field) + sizeof(__rseq_abi.feature_field)
    This would ensure the fields are only used if the symbol is large enough to
    hold them *and* the kernel supports them.

With this kind of scheme, we could then easily extend struct rseq to cover additional
use-cases such as:

- adding a new "node_id" field to speed up getcpu(3), user-space locking on NUMA,
  and possibly memory allocators,
- adding fields allowing to quickly disable/enable signals,
- adding a "__u64 features" field, which would contain for instance
  RSEQ_FEATURE_RELIABLE_CPU_ID.

I'm not sure why I did not think of this earlier, but it all seems to fit nicely.

Any comments ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
