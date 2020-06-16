Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2009C1FBE3A
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgFPSg6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbgFPSg5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 14:36:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE32C06174E
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 11:36:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a9so24822644ljn.6
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2RjpTiuHZ3l0Pxqe/xAX5M0G+FBIdLaE2yGHwIgHUA=;
        b=Q4o9HNHESg+RdwLs/JmMWK1P2LIdIm2ymfk6CbxiOVhznUpF+7/tWHhKrgkyUJd/Ja
         feN6mXD/nxi3vEtBOzTRmsAwv/kcl4VI44tCrtdNzkbMwGmn4ydIolFBndVx+iOssnV0
         K9NcnQccZ7ZZFfE653QizoY/d/iBAYktzJ5Xrgb/PeLd8+laxtA0uTFzTL0FVrj0tO4g
         IDTndEZaprVDykmvISs2GPkTzFj9RFCAywYDl6NYBoLKD8xL2o0cd64hcsnbnA6mqtmu
         6UlHSDXPw8Ph+YZGHkjNv51lIBS6tR4U2tCfbF3LIFWJgRZyrFwj6DdJ6JyZy9xdyNiO
         zC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2RjpTiuHZ3l0Pxqe/xAX5M0G+FBIdLaE2yGHwIgHUA=;
        b=rxg5MCxVPVaMrnuzfsQhyB9ksCrubiMqa4ckm8eM9Cp5PVVAhBrqcjU7AgUjDDSqs6
         qczOaH9H4GAmSr9vBrD4j3EjfZtuQ7SMXKv0KkCLS5CfHOBfyLwvtjvbIlDiwlBAdOuc
         /ibGlzkIWXcODLrnwSSimUTANa01zKutqhFOCsi0mg/bM0eee451barR1thJscxk7oiV
         0q2ozszMsb8Js4ncfDd4QFoQ7Pjve07LWwOmDYzhUNCEkz1SoKwRDssHM/CalFLui+yo
         D2Jn01Rqwf3lDuKjwDgQDIZpJ4HjQI3TVj2fxDhWFs3tXWozC1zvhJyGVMPb+9UCk8xa
         TuZQ==
X-Gm-Message-State: AOAM531Zj32yGgVaWkUQBYnLr+taEbPMOScBSsqoFOKbGb4rNcprWZc5
        Gx23Gq+ddlCXweQqGgNPu+h79nGw9zWhuCwv/qAVtA==
X-Google-Smtp-Source: ABdhPJy9kYf/f3crna55zPYPd3C7eYBoB/tQeRDdctgjZb1m2Rw1zbcvpVRFYtvNWY77/Kg9xRTJT8gwPxg5C5mfUSU=
X-Received: by 2002:a2e:970c:: with SMTP id r12mr2044805lji.145.1592332615437;
 Tue, 16 Jun 2020 11:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200616074934.1600036-1-keescook@chromium.org>
 <20200616074934.1600036-5-keescook@chromium.org> <CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com>
 <202006160757.99FD9B785@keescook>
In-Reply-To: <202006160757.99FD9B785@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 16 Jun 2020 20:36:28 +0200
Message-ID: <CAG48ez2HrPLhby31PUFb4f=iM60USA4NYRE6AjE8pPQ+ctm60g@mail.gmail.com>
Subject: Re: [PATCH 4/8] seccomp: Implement constant action bitmaps
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 16, 2020 at 5:49 PM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jun 16, 2020 at 02:14:47PM +0200, Jann Horn wrote:
> > Wouldn't it be simpler to use a function that can run a subset of
> > seccomp cBPF and bails out on anything that indicates that a syscall's
> > handling is complex or on instructions it doesn't understand? For
> > syscalls that have a fixed policy, a typical seccomp filter doesn't
> > even use any of the BPF_ALU ops, the scratch space, or the X register;
> > it just uses something like the following set of operations, which is
> > easy to emulate without much code:
> >
> > BPF_LD | BPF_W | BPF_ABS
> > BPF_JMP | BPF_JEQ | BPF_K
> > BPF_JMP | BPF_JGE | BPF_K
> > BPF_JMP | BPF_JGT | BPF_K
> > BPF_JMP | BPF_JA
> > BPF_RET | BPF_K
>
> Initially, I started down this path. It needed a bit of plumbing into
> BPF to better control the lifetime of the cBPF "saved original filter"
> (normally used by CHECKPOINT_RESTORE uses)

I don't think you need that? When a filter is added, you can compute
the results of the added individual filter, and then merge the state.

> and then I needed to keep
> making exceptions (same list you have: ALU, X register, scratch, etc)
> in the name of avoiding too much complexity in the emulator. I decided
> I'd rather reuse the existing infrastructure to actually execute the
> filter (no cBPF copy needed to be saved, no separate code, and full
> instruction coverage).

If you really think that this bit of emulation is so bad, you could
also make a copy of the BPF filter in which you replace all load
instructions from syscall arguments with "return NON_CONSTANT_RESULT",
and then run that through the normal BPF infrastructure.

> > Something like (completely untested):
[...]
> I didn't actually finish going down the emulator path (I stopped right
> around the time I verified that libseccomp does use BPF_ALU -- though
> only BPF_AND), so I didn't actually evaluate the filter contents for other
> filter builders (i.e. Chrome).
>
> But, if BPF_ALU | BPF_AND were added to your code above, it would cover
> everything libseccomp generates (which covers a lot of the seccomp
> filters, e.g. systemd, docker). I just felt funny about an "incomplete"
> emulator.
>
> Though now you've got me looking. It seems this is the core
> of Chrome's BPF instruction generation:
> https://github.com/chromium/chromium/blob/master/sandbox/linux/bpf_dsl/policy_compiler.cc
> It also uses ALU|AND, but adds JMP|JSET.
>
> So... that's only 2 more instructions to cover what I think are likely
> the two largest seccomp instruction generators.
>
> > That way, you won't need any of this complicated architecture-specific stuff.
>
> There are two arch-specific needs, and using a cBPF-subset emulator
> just gets rid of the local TLB flush. The other part is distinguishing
> the archs. Neither requirement is onerous (TLB flush usually just
> needs little more than an extern, arch is already documented in the
> per-arch syscall_get_arch()).

But it's also somewhat layer-breaking and reliant on very specific
assumptions. Normal kernel code doesn't mess around with page table
magic, outside of very specific low-level things. And your method
would break if the fixed-value members were not all packed together at
the start of the structure.


And from a hardening perspective: The more code we add that fiddles
around with PTEs directly, rather than going through higher-level
abstractions, the higher the chance that something gets horribly
screwed up. For example, this bit from your patch looks *really*
suspect:

+                       preempt_disable();
+                       set_pte_at(&init_mm, vaddr, ptep,
pte_mkold(*(READ_ONCE(ptep))));
+                       local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
+                       preempt_enable();

First off, that set_pte_at() is just a memory write; I don't see why
you put it inside a preempt_disable() region.
But more importantly, sticking a local TLB flush inside a
preempt_disable() region with nothing else in there looks really
shady. How is that supposed to work? If we migrate from CPU0 to CPU1
directly before this region, and then from CPU1 back to CPU0 directly
afterwards, the local TLB flush will have no effect.
