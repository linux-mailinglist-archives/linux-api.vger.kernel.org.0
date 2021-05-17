Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BFE3828A8
	for <lists+linux-api@lfdr.de>; Mon, 17 May 2021 11:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhEQJqU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 May 2021 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbhEQJqT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 May 2021 05:46:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D023C061573;
        Mon, 17 May 2021 02:45:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621244701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSHB4rglq/PZpB4u7nwm5nXOxfOiWpHnSt2L2UUsA3k=;
        b=j9XvQplHO0930Cv+vVmr3MbRHM4xOYt+5xJpSKRkP11aH3iHKsBV0ikOVjawbYUJAgHaez
        svA9L9J/a6ajJ9Hi38pSnID+YFS1MQ0tofL8Reko3CzR2iUKOfkG0ren/BZyfw21G9UrQO
        30ivjwH3SQ6Ic2chS39bCpwd4PVUFPXbEu6z98FGQDZguP9INiRmhI+Mbw9H+YRSdwNJFy
        j0Xb5yOKwSrx38ZemXnfSYXt/JxYnMeGVVUrMLqcv4dyXWRTWi0jMPFXWXjtZ3G3yhCuoR
        9yOHF5yGT+FCUqsVQbnG605Go7LjbrUYX9U6R7RuoJeZt04CV5Y/nA4ckMfvOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621244701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSHB4rglq/PZpB4u7nwm5nXOxfOiWpHnSt2L2UUsA3k=;
        b=K1i7Gds1PrGxQj5Lf8eDq+BcMKxpeecLeitxyGyYOlPU53ZemSlMPRH/lS4Nosr4/3ptrz
        5JXiv/wUFeVEDQAg==
To:     Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu> <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com> <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com> <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com> <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com> <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
Date:   Mon, 17 May 2021 11:45:00 +0200
Message-ID: <874kf11yoz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Len,

On Sun, May 02 2021 at 11:27, Len Brown wrote:
> Here is how it works:
>
> 1. The kernel boots and sees the feature in CPUID.
>
> 2. If the kernel supports that feature, it sets XCR0[feature].
>
>     For some features, there may be a bunch of kernel support,
>     while simple features may require only state save/restore.
>
> 2a.  If the kernel doesn't support the feature, XCR0[feature] remains cleared.
>
> 3. user-space sees the feature in CPUID
>
> 4. user-space sees for the feature via xgetbv[XCR0]
>
> 5. If the feature is enabled in XCR0, the user happily uses it.
>
>     For AMX, Linux implements "transparent first use"
>     so that it doesn't have to allocate 8KB context switch
>     buffers for tasks that don't actually use AMX.
>     It does this by arming XFD for all tasks, and taking a #NM
>     to allocate a context switch buffer only for those tasks
>     that actually execute AMX instructions.

I thought more about this and it's absolutely the wrong way to go for
several reasons.

AMX (or whatever comes next) is nothing else than a device and it
just should be treated as such. The fact that it is not exposed
via a driver and a device node does not matter at all.

Not doing so requires this awkward buffer allocation issue via #NM with
all it's downsides; it's just wrong to force the kernel to manage
resources of a user space task without being able to return a proper
error code. 

It also prevents fine grained control over access to this
functionality. As AMX is clearly a shared resource which is not per HT
thread (maybe not even per core) and it has impact on power/frequency it
is important to be able to restrict access on a per process/cgroup
scope.

Having a proper interface (syscall, prctl) which user space can use to
ask for permission and allocation of the necessary buffer(s) is clearly
avoiding the downsides and provides the necessary mechanisms for proper
control and failure handling.

It's not the end of the world if something which wants to utilize this
has do issue a syscall during detection. It does not matter whether
that's a library or just the application code itself.

That's a one off operation and every involved entity can cache the
result in TLS.

AVX512 has already proven that XSTATE management is fragile and error
prone, so we really have to stop this instead of creating yet another
half baken solution.

Thanks,

        tglx
