Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD45B38B8A2
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhETUzc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 16:55:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhETUzb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 16:55:31 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621544048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1b5EOQQ/YePsonGaR3lRGcz0LoWmLLhdRCD6BOMopXw=;
        b=YilffwgwuvF7ns1RjBuj3XrxFDri3U6Icv+iwHmiRgXp3DmKKS0ulGuvJ0ZUjdkYdRukdy
        Ugesy59DLi6YlaP0HPqON0dQdlwMvm+NvSu685KsKn738V0o4JAv8nXaqvOa53QFbSWclW
        ix0kOXubaeEQRikJDhEsq6F3vH2TKvhDmDafOIWZssFCWY8b/YWiybgXmo78qiBVUULv34
        NDBeA44vBw4Rz3+MHOV56b44GcQpI7fccQJqdNqKsd/K3YxiN19nKXIcD1yhewM4Hsh/F8
        7VetH0Qw/vqWBaqMNBUKpcLO1ODCP8+zoonmxII/kcGVYkp/AS0Ogi14+ibKHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621544048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1b5EOQQ/YePsonGaR3lRGcz0LoWmLLhdRCD6BOMopXw=;
        b=bHSgkAE6LdkqO1B17Okr2XuhipocTUDnPnj2b5iBoHY25TggkOlXZ5Lfl5M14lyAGwirij
        Jra0eTcBSOuz9KBg==
To:     Len Brown <lenb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu> <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com> <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com> <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com> <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com> <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com> <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
Date:   Thu, 20 May 2021 22:54:08 +0200
Message-ID: <87k0ntazyn.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Len,

On Thu, May 20 2021 at 11:35, Len Brown wrote:
> On Mon, May 17, 2021 at 5:45 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> AMX (or whatever comes next) is nothing else than a device and it
>> just should be treated as such. The fact that it is not exposed
>> via a driver and a device node does not matter at all.
>
> TMM registers are part of the CPU architectural state.
> If TMM registers exist for one logical CPU, they exist for all CPUs --
> including HT siblings. (Intel supports only homogeneous ISA)
>
> Ditto for the instructions that access and operate on TMM registers.
>
> One can reasonably predict, that like Intel has done for all other registers,
> there will be future instructions added to the ISA to operate on TMM registers,
> including in combination with non-TMM registers that are also part
> of the architectural state.
>
> It is an unfortunate word choice that some documentation calls the
> TMUL instruction an "accelerator".  It isn't. It is part of the ISA,
> like any other instruction.

of course I know that it is an instruction and the register state is
part of the per CPU architectural state.

Though there is a fundamental difference between per logical CPU
architectural state and per logical CPU resources and you know that as
well as I do.

IOW, that does not change the fact that AMX is a shared resource. That's
true for AVX and that's also true for the architectural RNG, which is
also accessed like "any other instruction". We've seen how well that
works.

That's the whole point. Because it's a shared resource with causes
contention and also has side effects vs. power/thermal and state size
this _is_ different from 'any other instruction'.

> I agree that a device interface may make sense for real accelerators
> that don't run x86 instructions, I don't see long term viability for attempting
> to carve a sub-set of x86 instructions into a device, particularly when
> the set of instructions will continue to evolve.

Nobody asked for a device interface for AMX. All I asked for is a
_mandatory_ "request usage" interface, e.g. prctl.

Just for the record:

 Your like "any other instruction" argument is a nothing else than a
 strawman.

 There exist instructions today which need OS assistance, e.g. the SGX
 related instructions, the upcoming TDX related ones, ENQCMD & al.

Please tell me _why_ they are so different. They are part of the ISA and
still are subject to fine grained (OS) control.

>> Not doing so requires this awkward buffer allocation issue via #NM with
>> all it's downsides; it's just wrong to force the kernel to manage
>> resources of a user space task without being able to return a proper
>> error code.
>
> The hardware #NM support for fault on first use is a feature to allow the OS
> to optimize space so that pages do not have to be dedicated to back registers
> unless/until they are actually used.
>
> There is absolutely no requirement that a particular
> OS take advantage of that feature.  If you think that this optimization is
> awkward, we can easily delete/disable it and simply statically allocate buffers
> for all threads at initialization time.  Though you'll have to convince me
> why the word "awkward" applies, rather than "elegant".

It's not elegant. It's a hack to avoid rethinking the approach to this
kind of features.

But I have to admit that it's a cute hack and it even can be utilized
for a access-request based solution.

> Regarding error return for allocation failures.
>
> I'm not familiar with the use-case where vmalloc would be likely to fail today,
> and I'd be interested if anybody can detail that use-case.

It does not matter whether it's likely or not. Unlikely simply does not
exist at cloud-scale.

> But even if there is none today, I grate that Linux could evolve to make vmalloc
> fail in the future, and so an interface to reqeust pre-allocation of buffers
> is reasonable insurance.  Chang has implemented this prctl in v5
> of the TMUL patch series.

No, it's not a reasonable insurance, simply because it's not mandatory.

>> It also prevents fine grained control over access to this
>> functionality. As AMX is clearly a shared resource which is not per HT
>> thread (maybe not even per core) and it has impact on power/frequency it
>> is important to be able to restrict access on a per process/cgroup
>> scope.
>
> AMX is analogous to the multiplier used by AVX-512.
> The architectural state must exist on every CPU, including HT siblings.
> Today, the HT siblings share the same execution unit,
> and I have no reason to expect that will change.

I'm well aware that HT siblings share the same execution unit for
AVX.

Though AMX is if I remember the discussions two years ago correctly
shared by more than the HT siblings which makes things worse.

> I thought we already addressed the FUD surrounding power/frequency.

What's FUD here?

  The fact that AMX is a shared resource which has contention issues?

  The fact that AMX usage has an influence on power/frequency?

If that's FUD by now, then your documentation needs an update.

> As with every kind of instruction -- those that use
> more power will leave less power for their peers, and there is a mechanism
> to track that power budget.  I acknowledge that the mechanism was overly
> conservative and slow to recover in initial AVX-512 systems, and that issue
> persists even with the latest publically available hardware today.
> I acknowledge that you do not trust that Intel has addressed this
> (for both AVX-512 and AMX) in the first hardware that supports AMX.

It does not matter whether I trust Intel or not to get this right. It
does neither matter whether there is a mechanism to track the budget or
not.

What matters is that the proposed #NM automatism simply prevents fine
grained access control for a _shared_ resource which has implications on
power and frequency and performance in general due to the fact that it's
shared and causes contention.

And because the #NM hack allows the world and its dog to use AMX any
unpriviledged user can utilize it. See the idea to use it for grep...

You might want to talk to the people in your company who care about
real-time and functional safety whether they think it's a good idea to
allow unrestricted access to functionality which has an influence on the
overall system behaviour with no other knob than to turn it off
completely. Turn it off completely is not an option simply because there
are valid use cases even in that area.

>> Having a proper interface (syscall, prctl) which user space can use to
>> ask for permission and allocation of the necessary buffer(s) is clearly
>> avoiding the downsides and provides the necessary mechanisms for proper
>> control and failure handling.
>>
>> It's not the end of the world if something which wants to utilize this
>> has do issue a syscall during detection. It does not matter whether
>> that's a library or just the application code itself.
>>
>> That's a one off operation and every involved entity can cache the
>> result in TLS.
>>
>> AVX512 has already proven that XSTATE management is fragile and error
>> prone, so we really have to stop this instead of creating yet another
>> half baked solution.
>
> We fixed the glibc ABI issue.  It is available now and production
> release is this summer.

That does not answer my questions at all.

> Yes, it should have been addressed when AVX-512 was deployed.

Correct. And in hindsight we should have insisted to have fine grained
control over that back then, but that's water under the bridge.

AMX and what's coming next is not.

Thanks,

        tglx
