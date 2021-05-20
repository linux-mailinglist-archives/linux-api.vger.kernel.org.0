Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF2438B35C
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhETPhz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 11:37:55 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:42846 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhETPhw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 11:37:52 -0400
Received: by mail-il1-f172.google.com with SMTP id h11so15595105ili.9;
        Thu, 20 May 2021 08:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VfQrs6a4Y7ppU0xIKRfb7qnrLFvac9XNiiNfh1302E=;
        b=h+VsOcH4YdGp3F1lKhuQpG297FqPkf2PC8yyvFWTEkWtD1Q5+q/oeC0jSEDODd159t
         w/IljteEnA4K4V+K6p3Zi+DN9hE4FB9yczN+LiB0vxZ2fbh/VkDGkAP+KyOnxRtCJnuf
         9vQhPbSJeWVbd64gPpGsPggTHBXUdbMJfhliixK9yQae+RTM5ALiz74v4DPbr18yqC1z
         yHkSetRbei5npEoPJN3M6FFW9xQT4hVm2yFU7ffVHREqCwO02jFpLa4nRa+fCK+aSgjY
         a0va4m6EVQ2efp0jw22SPEsjsLDB3ohbxFqKIfuMBRMyWhsnf3ErD0v7zMZXGmmCd9OF
         4MuA==
X-Gm-Message-State: AOAM532upocHQAFrsThkoIxB4hzlAIQpcWaPGC30S/PZtbT9TPUMmhRz
        OZPbbv1a9hguUMn5ld6ajQ1GDaCa0BW9UmKdW4E=
X-Google-Smtp-Source: ABdhPJzs3Emj3Jb4mK3XgTEj+frqBNXJkhzs91AdHGmWunPoKGHENUnqY0pTOgY4+Tr8BS10NN6kSMIEa1Bv5UCTJQ8=
X-Received: by 2002:a92:cf45:: with SMTP id c5mr6267683ilr.182.1621524989346;
 Thu, 20 May 2021 08:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de>
In-Reply-To: <874kf11yoz.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 20 May 2021 11:35:53 -0400
Message-ID: <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Thomas,

On Mon, May 17, 2021 at 5:45 AM Thomas Gleixner <tglx@linutronix.de> wrote:

> AMX (or whatever comes next) is nothing else than a device and it
> just should be treated as such. The fact that it is not exposed
> via a driver and a device node does not matter at all.

TMM registers are part of the CPU architectural state.
If TMM registers exist for one logical CPU, they exist for all CPUs --
including HT siblings.
(Intel supports only homogeneous ISA)

Ditto for the instructions that access and operate on TMM registers.

One can reasonably predict, that like Intel has done for all other registers,
there will be future instructions added to the ISA to operate on TMM registers,
including in combination with non-TMM registers that are also part
of the architectural state.

It is an unfortunate word choice that some documentation calls the
TMUL instruction
an "accelerator".  It isn't.  It is part of the ISA, like any other instruction.

I agree that a device interface may make sense for real accelerators
that don't run x86 instructions, I don't see long term viability for attempting
to carve a sub-set of x86 instructions into a device, particularly when
the set of instructions will continue to evolve.

> Not doing so requires this awkward buffer allocation issue via #NM with
> all it's downsides; it's just wrong to force the kernel to manage
> resources of a user space task without being able to return a proper
> error code.

The hardware #NM support for fault on first use is a feature to allow the OS
to optimize space so that pages do not have to be dedicated to back registers
unless/until they are actually used.

There is absolutely no requirement that a particular
OS take advantage of that feature.  If you think that this optimization is
awkward, we can easily delete/disable it and simply statically allocate buffers
for all threads at initialization time.  Though you'll have to convince me
why the word "awkward" applies, rather than "elegant".

Regarding error return for allocation failures.

I'm not familiar with the use-case where vmalloc would be likely to fail today,
and I'd be interested if anybody can detail that use-case.
But even if there is none today, I grate that Linux could evolve to make vmalloc
fail in the future, and so an interface to reqeust pre-allocation of buffers
is reasonable insurance.  Chang has implemented this prctl in v5
of the TMUL patch series.

> It also prevents fine grained control over access to this
> functionality. As AMX is clearly a shared resource which is not per HT
> thread (maybe not even per core) and it has impact on power/frequency it
> is important to be able to restrict access on a per process/cgroup
> scope.

AMX is analogous to the multiplier used by AVX-512.
The architectural state must exist on every CPU, including HT siblings.
Today, the HT siblings share the same execution unit,
and I have no reason to expect that will change.

I thought we already addressed the FUD surrounding power/frequency.
As with every kind of instruction -- those that use
more power will leave less power for their peers, and there is a mechanism
to track that power budget.  I acknowledge that the mechanism was overly
conservative and slow to recover in initial AVX-512 systems, and that issue
persists even with the latest publically available hardware today.
I acknowledge that you do not trust that Intel has addressed this
(for both AVX-512 and AMX) in the first hardware that supports AMX.

> Having a proper interface (syscall, prctl) which user space can use to
> ask for permission and allocation of the necessary buffer(s) is clearly
> avoiding the downsides and provides the necessary mechanisms for proper
> control and failure handling.
>
> It's not the end of the world if something which wants to utilize this
> has do issue a syscall during detection. It does not matter whether
> that's a library or just the application code itself.
>
> That's a one off operation and every involved entity can cache the
> result in TLS.
>
> AVX512 has already proven that XSTATE management is fragile and error
> prone, so we really have to stop this instead of creating yet another
> half baked solution.

We fixed the glibc ABI issue.  It is available now and production
release is this summer.
Yes, it should have been addressed when AVX-512 was deployed.

thanks
Len Brown, Intel Open Source Technology Center
