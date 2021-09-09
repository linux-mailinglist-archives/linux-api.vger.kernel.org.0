Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9048D405FEA
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 01:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhIIXO5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Sep 2021 19:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbhIIXO4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Sep 2021 19:14:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8649AC061574
        for <linux-api@vger.kernel.org>; Thu,  9 Sep 2021 16:13:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s10so111614lfr.11
        for <linux-api@vger.kernel.org>; Thu, 09 Sep 2021 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5XDrpASHY+IJ8EJdbAMAdJg1bJMF+apHBxaBZD2fpU=;
        b=H1gviqF+uN0ad86kxP6PUazKjHwP09wv/V6vGjQfm6pJhfnBUjgRsORLEyH9E3RxbI
         XEF6NudXRYq06F3ICN9md4Pk9oq8jrOHuSM2GwDMrTVthmVPl7zXoMM9fIOgN5Nbx/WY
         OxtYZuddTrX/PAeSJYYjS+k65whVJInZjn8vCCjkZxAsHxuaPKm/XCG3ZEUggMO3OCMD
         UgIPd2l/08RueTbNCNyZQwOtfYS6cxBQaPANmY0by1z4pYhaol1wedLenoKqnnJPD4Y0
         47ETl5kB530wVjFrA4Kxi8QB16RuxfQtmTEp0g7VhK0gAQ8OCYUlpdccrXBZXou5pB+P
         zdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5XDrpASHY+IJ8EJdbAMAdJg1bJMF+apHBxaBZD2fpU=;
        b=s1Dbh0liZN42YGZp+28QXitauU98ocCRaAZcyzoeRsXh/LFE0A8YdT2a/1+3yIZs+B
         XzG7RNbyYi4vpc9dIE8sUAJ3w6uUoE5Yt5oxO6ByWiJtRO1Vv4buAndWAZvYVoseR7S0
         8aQxXbn5eUL01qCG85nAxr4eJ1xjP4dev+iQ67dkyObt7rJTVV+cAlZiZr998sxaubHf
         amMCSgBoSZ8QHzRcA16ID/QtRTjtbwMW/s6uZRMylIj8rqxZSMOmw0rgUbb1/4lbNCfX
         Vgj8dHelAav4HCDAvbxxqaSth2XiegUf9Fcv6bSuXShhyzbr1j8kiMHw66cIKian6x8a
         4G5w==
X-Gm-Message-State: AOAM533HtEJrZLMgbeCH+RUA7oDXU7WLftaHKsCMDpivCpx0Ug83NmEp
        LRBadx6K0MrxUYB1UmD47vAOTwl8XjlF6uLmwUWUsg==
X-Google-Smtp-Source: ABdhPJyEnH12Py66A+Hi7mRzB2OeTpx8ovkkf2lQRHVsMDDP4yfupozyVW+YAv5Mhaer5xZE8mOHG6SkokQ3G+3vYRU=
X-Received: by 2002:a05:6512:ac4:: with SMTP id n4mr1583475lfu.237.1631229224654;
 Thu, 09 Sep 2021 16:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
 <CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com> <CAPNVh5eF6x8e4Lp=ZDOspwrbRYNOEyjeNW4WC99jCAZyeKLGww@mail.gmail.com>
In-Reply-To: <CAPNVh5eF6x8e4Lp=ZDOspwrbRYNOEyjeNW4WC99jCAZyeKLGww@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 10 Sep 2021 01:13:17 +0200
Message-ID: <CAG48ez3dwtpjpSPKAheWzYcxrLvNeZ1=1OJQoiD3HWfYqs8H4Q@mail.gmail.com>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 10, 2021 at 12:10 AM Peter Oskolkov <posk@google.com> wrote:
> On Thu, Sep 9, 2021 at 2:21 PM Jann Horn <jannh@google.com> wrote:
> > > Option 1: as you suggest, pin pages holding struct umcg_task in sys_umcg_ctl;
> >
> > FWIW, there is a variant on this that might also be an option:
> >
> > You can create a new memory mapping from kernel code and stuff pages
> > into it that were originally allocated as normal kernel pages. This is
> > done in a bunch of places, e.g.:
> >
> > This has the advantage that it avoids pinning random pages that were
> > originally allocated from ZONE_MOVABLE blocks. (Or pinning hugepages,
> > or something like that.)
> > The downsides are that it reduces userspace's freedom to place the
> > UAPI structs wherever it wants (so userspace e.g. probably can't
> > directly put the struct in thread-local storage, instead it has to
> > store a pointer to the struct), and that you need to write a bunch of
> > code to create the mapping and allocate slots in these pages for
> > userspace threads.
>
> Thanks again, Jann! Why do you think using custom mapping like this is
> preferable to doing just kzalloc(size, GFP_USER), or maybe
> alloc_page(GFP_USER)?

kzalloc() / alloc_page() just give you kernel memory allocations; but
if you want userspace to be able to directly read/write that memory,
you have to also map the same physical memory into the userspace
pagetables somehow (at a separate address), which requires that you
set up a VMA to tell the MM subsystem that that userspace address
range is in use, and to specify what should happen when userspace
calls memory management syscalls on it, or when pagefaults occur in
it.

Also, when allocating memory that should also be mapped into
userspace, you have to use alloc_page(); memory from kzalloc() (in
other words, slab memory) can't be mapped into userspace. (Technically
it could be mapped into userspace with PFNMAP, but doing that would be
weird.)

> The documentation here
> https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html
> says:
>
> "GFP_USER means that the allocated memory is not movable and it must
> be directly accessible by the kernel", which sounds exactly what we
> need here.

If you look at the actual definitions of GFP_KERNEL and GFP_USER:

#define GFP_KERNEL (__GFP_RECLAIM | __GFP_IO | __GFP_FS)
#define GFP_USER (__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)

you can see that the only difference between them is the
__GFP_HARDWALL flag, which is documented as follows:

 * %__GFP_HARDWALL enforces the cpuset memory allocation policy.

So this basically just determines whether memory allocations fail if
the task's memory allocation policy says they should fail because no
memory is available on the right nodes. The choice of GFP flags
doesn't influence whether userspace ends up getting access to the
allocated memory. (On 32-bit machines, it does influence whether the
kernel can easily access the memory though: Normal userspace anonymous
memory is GFP_HIGHUSER, which includes __GFP_HIGHMEM, meaning that the
returned page doesn't have to be mapped in the kernel's linear
mapping, it can be in "high memory".)
