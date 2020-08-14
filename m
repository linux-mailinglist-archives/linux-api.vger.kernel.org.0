Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC921244E34
	for <lists+linux-api@lfdr.de>; Fri, 14 Aug 2020 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgHNRrM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Aug 2020 13:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNRrJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 14 Aug 2020 13:47:09 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C14C20829
        for <linux-api@vger.kernel.org>; Fri, 14 Aug 2020 17:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597427228;
        bh=akv/UmJpcxiw7tC5PwlDZdR2KC9Vs7eUyK1bJfdTthU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M1BVD6SnLlAB2txByxPfGzUWpVOp3wq3n7nM5a54Y2PQJRoJlEXq4f0QbkFagm6pg
         9dBY7bMOODEevE6mAvxFYo35Mi9HPTiws8gRQ5R225rEKUaODsFf8AGNqWHm7C1l6j
         PV+URg/mt57tVczx/6gYBnLYKuLv/hYkJ1cGVOd8=
Received: by mail-wr1-f49.google.com with SMTP id f12so9032927wru.13
        for <linux-api@vger.kernel.org>; Fri, 14 Aug 2020 10:47:08 -0700 (PDT)
X-Gm-Message-State: AOAM531kpMObGZ6//M4urVGxmJX6aBb8sfw8crX8tgrtAoOuNFBy7aCz
        cKimNgKkZLEYRTmaieggIkkADiJWfa7OzO92ROdu0g==
X-Google-Smtp-Source: ABdhPJyUWIngePPeonF9Qb5pi4t0BlSXHz3udbBaINEYqUbzO/kdzoB39Yt/n/fFkRBlsagQA4nriALJiUYA+FrSZsE=
X-Received: by 2002:adf:e90f:: with SMTP id f15mr3752426wrm.18.1597427226974;
 Fri, 14 Aug 2020 10:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200130162340.GA14232@rapoport-lnx>
In-Reply-To: <20200130162340.GA14232@rapoport-lnx>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 14 Aug 2020 10:46:55 -0700
X-Gmail-Original-Message-ID: <CALCETrVOWodgnRBFpPLEnc_Bfg=fgfAJiD1p-eE1uwCMc6c9Tg@mail.gmail.com>
Message-ID: <CALCETrVOWodgnRBFpPLEnc_Bfg=fgfAJiD1p-eE1uwCMc6c9Tg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: extend memfd with ability to create "secret"
 memory areas
To:     Mike Rapoport <rppt@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jan 30, 2020 at 8:23 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> Hi,
>
> This is essentially a resend of my attempt to implement "secret" mappings
> using a file descriptor [1].
>
> I've done a couple of experiments with secret/exclusive/whatever
> memory backed by a file-descriptor using a chardev and memfd_create
> syscall. There is indeed no need for VM_ flag, but there are still places
> that would require special care, e.g vm_normal_page(), madvise(DO_FORK), so
> it won't be completely free of core mm modifications.
>
> Below is a POC that implements extension to memfd_create() that allows
> mapping of a "secret" memory. The "secrecy" mode should be explicitly set
> using ioctl(), for now I've implemented exclusive and uncached mappings.

Hi-

Sorry for the extremely delayed response.

I like the general concept, and I like the exclusive concept.  While
it is certainly annoying for the kernel to manage non-direct-mapped
pages, I think it's the future.  But I have serious concerns about the
uncached part.  Here are some concerns.

If it's done at all, I think it should be MFD_SECRET_X86_UNCACHED.  I
think that uncached memory is outside the scope of things that can
reasonably be considered to be architecture-neutral.  (For example, on
x86, UC and WC have very different semantics, and UC has quite
different properties than WB for things like atomics.  Also, the
performance of UC is interesting at best, and the ways to even
moderately efficiently read from UC memory or write to UC memory are
highly x86-specific.)

I'm a little unconvinced about the security benefits.  As far as I
know, UC memory will not end up in cache by any means (unless
aliased), but it's going to be tough to do much with UC data with
anything resembling reasonable performance without derived values
getting cached.  It's likely entirely impossible to do it reliably
without asm.  But even with plain WB memory, getting it into L1 really
should not be that bad unless major new vulnerabilities are
discovered.  And there are other approaches that could be more
arch-neutral and more performant.  For example, there could be an
option to flush a few cache lines on schedule out.  This way a task
could work on some (exclusive but WB) secret memory and have the cache
lines flushed if anything interrupts it.  Combined with turning SMT
off, this could offer comparable protection with much less overhead.

UC also doesn't seem reliable on x86, sadly.  From asking around,
there are at least a handful of scenarios under which the kernel can
ask the CPU for UC but get WB anyway.  Apparently Xen hypervisors will
do this unless the domain has privileged MMIO access, and ESXi will do
it under some set of common circumstances.  So unless we probe somehow
or have fancy enumeration or administrative configuration, I'm not
sure we can even get predictable behavior if we hand userspace a
supposedly UC mapping.  Giving user code WB when it thinks it has UC
could end badly.

--Andy
