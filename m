Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B787638C30A
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbhEUJ3a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 05:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhEUJ3S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 05:29:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550CAC061763;
        Fri, 21 May 2021 02:26:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621589187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YH3IeA3uE4Q+xSi3z5y5AVoS8ahuOw9YD3AMctxS7O0=;
        b=RiphfFneNCnbD6G8Lii75tG/Vq+it+xs5PzoghIEjXytCf1126mnlkbNJqigdk5MJVInxQ
        lMKqkSUARY3nzjofsEIEIvaOrZuOZLZDw2VfkM/XjzH06Y5zB3JWl85jUIa5NMf2QpPMu2
        nuHiiBR6kZIgIvx9dGE1hP9DG6LBAmTjqNG8UHunL/0O+t5u7BEJMNBFIADdX+gRgP+Vog
        rTBeEICG01i5xOYBO80dYlkUBBxTfZSEt8Zr8OiMcKmmqYT8fS26srUkJhWAkTI/xukqiH
        GgGw20bXVU12gnejjg+x5Uj6n6+6dza5FAWXOUo+nq0BU9SK+N8NeJfeBSvOrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621589187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YH3IeA3uE4Q+xSi3z5y5AVoS8ahuOw9YD3AMctxS7O0=;
        b=XcH8jWcpAmSlaGhTzXGoU4IyMmZXjpCi6Gh3Qo2esYoUJE1YRF6hson4GJXo1VfWgKqrMn
        lveu5FhtbLBIYnBw==
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
In-Reply-To: <CAJvTdKmC3dY3BZafPvh1M880kGAusViCAZNBQ3NoLvOQgWuuBA@mail.gmail.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu> <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com> <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com> <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com> <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com> <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com> <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com> <87k0ntazyn.ffs@nanos.tec.linutronix.de> <CAJvTdK=DCdwc86VdCVsCH+et6aGuAE3hi-wKmE5769SA0g1H-Q@mail.gmail.com> <87h7ixaxs9.ffs@nanos.tec.linutronix.de> <CAJvTdKmC3dY3BZafPvh1M880kGAusViCAZNBQ3NoLvOQgWuuBA@mail.gmail.com>
Date:   Fri, 21 May 2021 11:26:26 +0200
Message-ID: <87eee0bfp9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Len,

On Thu, May 20 2021 at 17:49, Len Brown wrote:
> On Thu, May 20, 2021 at 5:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>   2) It has effects on power/thermal and therefore effects which reach
>>      outside of the core scope
>
> FWIW, this is true of *every* instruction in the CPU.
> Indeed, even when the CPU is executing *no* instructions at all,
> the C-state chosen by that CPU has power/thermal impacts on its peers.
>
> Granted, high performance instructions such as AVX-512 and TMUL
> are the most extreme case.

Right and we have to draw the line somewhere.

>>   3) Your approach of making it unconditionally available via the
>>      proposed #NM prevents the OS and subsequently the system admin /
>>      system designer to implement fine grained control over that
>>      resource.
>>
>>      And no, an opt-in approach by providing a non-mandatory
>>      preallocation prctl does not solve that problem.
>
> I'm perfectly fine with making the explicit allocation (aka opt-in) mandatory,
> and enforcing it.

Great!

Thanks,

        tglx
