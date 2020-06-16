Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26AF1FC0B4
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 23:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFPVNT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 17:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgFPVNS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 17:13:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401DEC06174E
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 14:13:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so2024416pjb.0
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=eqEyb6JQUaVvUerJGlNUxsrnO2s/SjrzdS9NtiPOeYo=;
        b=g6zCQtb1WWtXnfW4lrEfAQterYlqGC+qzWbEDOKWIv0NGjz9l6EEUTZT4gJDW3+dm/
         jAky84uduB/j4JURdB4IZE7r4mqAIkdv49wcpUU4CiKisBZQqJrpYrx1NFFYznrl+9BI
         aZQn4KnFjY341j/bwx6nWPjr01h0+bU/gSCyL7NrzL425xz3u5Z4j3HPi1f1I/fXEd6u
         S96nkQ/d4HJ6cFF1dPP7aUkIC04jHD6rbpaZoCr6UafwOcfi/6KLjw65d+wSqtv/UEP1
         nxtbnnX7dZPCS4htwAKfNvqmCaYCgjjYhsQLMEccQtT6DDw+wQb0qVBBFqHNlFNYsxYK
         6Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=eqEyb6JQUaVvUerJGlNUxsrnO2s/SjrzdS9NtiPOeYo=;
        b=pJ/sbukiGEljD23rNkJyXMViVLZAQ+WqwG1PJy/GcSTX1ppvgL3uxl06WzgRZpc5af
         nnfpGepDY/2zjDE+lcyI115r5zbObYAlDKcV27GD3ifNuBfph2Ni3p89SoVKEdwu1yOB
         0PjuG+Lf5sZpjFP3r8+xfKdoZxueDw6ItIELhQXPslRbfJmwL3xQ2yqx2WGHJVDX5hj3
         +zyPjnjk2sYCACq+TbnyMZ7/zCnRnLRYpboCA8i6Lp1fQJR0mKteK7n+/aiZyQiTIOLC
         HvO/bKEpJhK3MAw4Jw/QNa4Q9Id0um2RS39IsliW3VsiNzPDroqNiELKMR01dn1wIaES
         k3Rg==
X-Gm-Message-State: AOAM5333XUcJHZXLh6jhIEeZillXB54eVgPJEUn1oTaVWLXlF+mndrfZ
        LSxnDj8MDx03+aSK0YAen21aug==
X-Google-Smtp-Source: ABdhPJy69Z2QgDcdZTYpebC8ze5IvfOADkMTD+75F8SeFWRv4Ch+M+gwBX/zyw6HkQzCVDsLgMTKjA==
X-Received: by 2002:a17:90a:ee14:: with SMTP id e20mr4899331pjy.55.1592341996543;
        Tue, 16 Jun 2020 14:13:16 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:2854:eba6:e44d:d731? ([2601:646:c200:1ef2:2854:eba6:e44d:d731])
        by smtp.gmail.com with ESMTPSA id 8sm3282064pja.0.2020.06.16.14.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 14:13:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/8] seccomp: Implement constant action bitmaps
Date:   Tue, 16 Jun 2020 14:13:14 -0700
Message-Id: <CE2F8139-4549-46CC-ABDB-3429361847A2@amacapital.net>
References: <CAG48ez2HrPLhby31PUFb4f=iM60USA4NYRE6AjE8pPQ+ctm60g@mail.gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <CAG48ez2HrPLhby31PUFb4f=iM60USA4NYRE6AjE8pPQ+ctm60g@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Jun 16, 2020, at 11:36 AM, Jann Horn <jannh@google.com> wrote:
>=20
> =EF=BB=BFOn Tue, Jun 16, 2020 at 5:49 PM Kees Cook <keescook@chromium.org>=
 wrote:
>>> On Tue, Jun 16, 2020 at 02:14:47PM +0200, Jann Horn wrote:
>>> Wouldn't it be simpler to use a function that can run a subset of
>>> seccomp cBPF and bails out on anything that indicates that a syscall's
>>> handling is complex or on instructions it doesn't understand? For
>>> syscalls that have a fixed policy, a typical seccomp filter doesn't
>>> even use any of the BPF_ALU ops, the scratch space, or the X register;
>>> it just uses something like the following set of operations, which is
>>> easy to emulate without much code:
>>>=20
>>> BPF_LD | BPF_W | BPF_ABS
>>> BPF_JMP | BPF_JEQ | BPF_K
>>> BPF_JMP | BPF_JGE | BPF_K
>>> BPF_JMP | BPF_JGT | BPF_K
>>> BPF_JMP | BPF_JA
>>> BPF_RET | BPF_K
>>=20
>> Initially, I started down this path. It needed a bit of plumbing into
>> BPF to better control the lifetime of the cBPF "saved original filter"
>> (normally used by CHECKPOINT_RESTORE uses)
>=20
> I don't think you need that? When a filter is added, you can compute
> the results of the added individual filter, and then merge the state.
>=20
>> and then I needed to keep
>> making exceptions (same list you have: ALU, X register, scratch, etc)
>> in the name of avoiding too much complexity in the emulator. I decided
>> I'd rather reuse the existing infrastructure to actually execute the
>> filter (no cBPF copy needed to be saved, no separate code, and full
>> instruction coverage).
>=20
> If you really think that this bit of emulation is so bad, you could
> also make a copy of the BPF filter in which you replace all load
> instructions from syscall arguments with "return NON_CONSTANT_RESULT",
> and then run that through the normal BPF infrastructure.
>=20
>>> Something like (completely untested):
> [...]
>> I didn't actually finish going down the emulator path (I stopped right
>> around the time I verified that libseccomp does use BPF_ALU -- though
>> only BPF_AND), so I didn't actually evaluate the filter contents for othe=
r
>> filter builders (i.e. Chrome).
>>=20
>> But, if BPF_ALU | BPF_AND were added to your code above, it would cover
>> everything libseccomp generates (which covers a lot of the seccomp
>> filters, e.g. systemd, docker). I just felt funny about an "incomplete"
>> emulator.
>>=20
>> Though now you've got me looking. It seems this is the core
>> of Chrome's BPF instruction generation:
>> https://github.com/chromium/chromium/blob/master/sandbox/linux/bpf_dsl/po=
licy_compiler.cc
>> It also uses ALU|AND, but adds JMP|JSET.
>>=20
>> So... that's only 2 more instructions to cover what I think are likely
>> the two largest seccomp instruction generators.
>>=20
>>> That way, you won't need any of this complicated architecture-specific s=
tuff.
>>=20
>> There are two arch-specific needs, and using a cBPF-subset emulator
>> just gets rid of the local TLB flush. The other part is distinguishing
>> the archs. Neither requirement is onerous (TLB flush usually just
>> needs little more than an extern, arch is already documented in the
>> per-arch syscall_get_arch()).
>=20
> But it's also somewhat layer-breaking and reliant on very specific
> assumptions. Normal kernel code doesn't mess around with page table
> magic, outside of very specific low-level things. And your method
> would break if the fixed-value members were not all packed together at
> the start of the structure.
>=20
>=20
> And from a hardening perspective: The more code we add that fiddles
> around with PTEs directly, rather than going through higher-level
> abstractions, the higher the chance that something gets horribly
> screwed up. For example, this bit from your patch looks *really*
> suspect:
>=20
> +                       preempt_disable();
> +                       set_pte_at(&init_mm, vaddr, ptep,
> pte_mkold(*(READ_ONCE(ptep))));
> +                       local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_S=
IZE);
> +                       preempt_enable();
>=20
> First off, that set_pte_at() is just a memory write; I don't see why
> you put it inside a preempt_disable() region.
> But more importantly, sticking a local TLB flush inside a
> preempt_disable() region with nothing else in there looks really
> shady. How is that supposed to work? If we migrate from CPU0 to CPU1
> directly before this region, and then from CPU1 back to CPU0 directly
> afterwards, the local TLB flush will have no effect.


Indeed.

With my x86/mm maintainer hat on, this is highly questionable. Either the re=
al API should be used, or there should be a sane API. The former will have r=
eally atrocious performance, and the latter would need some thought. Basical=
ly, if you pin entire process to one CPU, you can clear the dirty bit, flush=
, do some magic, and read it back. This is only valid if you have a short en=
ough operation that running with preemption off is reasonable.  Otherwise yo=
u need to arrange to flush when you schedule in, which could be done with a v=
oluntary preemption style or with scheduler hooks.

I=E2=80=99m not convinced this is worthwhile.=
