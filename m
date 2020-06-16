Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8291FBE73
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 20:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgFPStl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 14:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgFPStj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 14:49:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E7C061573
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 11:49:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so9925631pfc.5
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b8hRDF1XXrhu33JiDGyXvZcU8whbvzEGz0i9JpZbnTw=;
        b=d1hgB/JfsbnTPAahOwwwk5u0Ves0Pd6Np/WEpvfWvNicPrEwEbwW6uhgYBPbHqFmUd
         pqtLB52Wexz5oocb976Fc/Pe1WmQYH1IBjio5pDJErc1ZsgHAMAfaKk84Tw0uy9PAFsv
         yHqRw5O7ESY5H28zG5bwR+MlYz9OKbGTkbgzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b8hRDF1XXrhu33JiDGyXvZcU8whbvzEGz0i9JpZbnTw=;
        b=T6/HhvQoFTfjZtHxkZ07d9qHlb7pN+3TIEOmHkt4CUr7ySads6J3+JQkQfaUK4OjWd
         JhCHQJwNP9qjlca6W50EFrwXFYO7oQupaRcMjoh6ESsRExDXT7P6YFDy8Jm57yIjtD4N
         WOxo7RYwofdhYlKSALz9iIf47asl/Mgs/GL7rJ3gEq20DmB94+ZJAUyh8+iqKrj403jX
         R3jGOLVyBfJwQLpDFbpISdnmR8rqK93dmp9i3t8OTk1VI5rvU5yZu4GyVe1wV016+Tx0
         w77YgEz0JFU4CubnILllOiA7wC/1dODiYeR2Z/1h1dGfEjGeSpFlgNQd/0bE97k9CnIU
         Mp4g==
X-Gm-Message-State: AOAM53017dndP6K2c91Sz7nRMrOPVwTLrJN8weTLOXCbRYELZIxtzzN9
        KSsXJ/c8+oj1WihQ+W+jcg+RqQ==
X-Google-Smtp-Source: ABdhPJy3iOEuaZxX1Ecv1DqNdAuYKJbtRDJF37S2pVwLCY+nnumK7HqELR1zqiOaHjj813LM+Z+ubA==
X-Received: by 2002:a62:4ec7:: with SMTP id c190mr3210241pfb.55.1592333378455;
        Tue, 16 Jun 2020 11:49:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm18313185pfq.43.2020.06.16.11.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:49:37 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:49:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
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
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 4/8] seccomp: Implement constant action bitmaps
Message-ID: <202006161145.1E6B616CBE@keescook>
References: <20200616074934.1600036-1-keescook@chromium.org>
 <20200616074934.1600036-5-keescook@chromium.org>
 <CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com>
 <202006160757.99FD9B785@keescook>
 <CAG48ez2HrPLhby31PUFb4f=iM60USA4NYRE6AjE8pPQ+ctm60g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2HrPLhby31PUFb4f=iM60USA4NYRE6AjE8pPQ+ctm60g@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 16, 2020 at 08:36:28PM +0200, Jann Horn wrote:
> On Tue, Jun 16, 2020 at 5:49 PM Kees Cook <keescook@chromium.org> wrote:
> > On Tue, Jun 16, 2020 at 02:14:47PM +0200, Jann Horn wrote:
> > > Wouldn't it be simpler to use a function that can run a subset of
> > > seccomp cBPF and bails out on anything that indicates that a syscall's
> > > handling is complex or on instructions it doesn't understand? For
> > > syscalls that have a fixed policy, a typical seccomp filter doesn't
> > > even use any of the BPF_ALU ops, the scratch space, or the X register;
> > > it just uses something like the following set of operations, which is
> > > easy to emulate without much code:
> > >
> > > BPF_LD | BPF_W | BPF_ABS
> > > BPF_JMP | BPF_JEQ | BPF_K
> > > BPF_JMP | BPF_JGE | BPF_K
> > > BPF_JMP | BPF_JGT | BPF_K
> > > BPF_JMP | BPF_JA
> > > BPF_RET | BPF_K
> >
> > Initially, I started down this path. It needed a bit of plumbing into
> > BPF to better control the lifetime of the cBPF "saved original filter"
> > (normally used by CHECKPOINT_RESTORE uses)
> 
> I don't think you need that? When a filter is added, you can compute
> the results of the added individual filter, and then merge the state.

That's what I thought too, but unfortunately not (unless I missed
something) -- the seccomp verifier is run as a callback from the BPF
internals, so seccomp only see what the user sends (which is unverified)
and the final eBPF filter. There isn't state I can attach during the
callback, so I opted to just do the same thing as CHECKPOINT_RESTORE,
but to then explicitly free the cBPF after bitmap generation.

> > and then I needed to keep
> > making exceptions (same list you have: ALU, X register, scratch, etc)
> > in the name of avoiding too much complexity in the emulator. I decided
> > I'd rather reuse the existing infrastructure to actually execute the
> > filter (no cBPF copy needed to be saved, no separate code, and full
> > instruction coverage).
> 
> If you really think that this bit of emulation is so bad, you could
> also make a copy of the BPF filter in which you replace all load
> instructions from syscall arguments with "return NON_CONSTANT_RESULT",
> and then run that through the normal BPF infrastructure.
> 
> > > Something like (completely untested):
> [...]
> > I didn't actually finish going down the emulator path (I stopped right
> > around the time I verified that libseccomp does use BPF_ALU -- though
> > only BPF_AND), so I didn't actually evaluate the filter contents for other
> > filter builders (i.e. Chrome).
> >
> > But, if BPF_ALU | BPF_AND were added to your code above, it would cover
> > everything libseccomp generates (which covers a lot of the seccomp
> > filters, e.g. systemd, docker). I just felt funny about an "incomplete"
> > emulator.
> >
> > Though now you've got me looking. It seems this is the core
> > of Chrome's BPF instruction generation:
> > https://github.com/chromium/chromium/blob/master/sandbox/linux/bpf_dsl/policy_compiler.cc
> > It also uses ALU|AND, but adds JMP|JSET.
> >
> > So... that's only 2 more instructions to cover what I think are likely
> > the two largest seccomp instruction generators.
> >
> > > That way, you won't need any of this complicated architecture-specific stuff.
> >
> > There are two arch-specific needs, and using a cBPF-subset emulator
> > just gets rid of the local TLB flush. The other part is distinguishing
> > the archs. Neither requirement is onerous (TLB flush usually just
> > needs little more than an extern, arch is already documented in the
> > per-arch syscall_get_arch()).
> 
> But it's also somewhat layer-breaking and reliant on very specific
> assumptions. Normal kernel code doesn't mess around with page table
> magic, outside of very specific low-level things. And your method
> would break if the fixed-value members were not all packed together at
> the start of the structure.

Right -- that was lucky. I suspect the emulation route will win out
here.

> And from a hardening perspective: The more code we add that fiddles
> around with PTEs directly, rather than going through higher-level
> abstractions, the higher the chance that something gets horribly
> screwed up. For example, this bit from your patch looks *really*
> suspect:
> 
> +                       preempt_disable();
> +                       set_pte_at(&init_mm, vaddr, ptep,
> pte_mkold(*(READ_ONCE(ptep))));
> +                       local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
> +                       preempt_enable();
> 
> First off, that set_pte_at() is just a memory write; I don't see why
> you put it inside a preempt_disable() region.
> But more importantly, sticking a local TLB flush inside a
> preempt_disable() region with nothing else in there looks really
> shady. How is that supposed to work? If we migrate from CPU0 to CPU1
> directly before this region, and then from CPU1 back to CPU0 directly
> afterwards, the local TLB flush will have no effect.

Yeah, true, that's another good reason not to do this.

-- 
Kees Cook
