Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A463430792C
	for <lists+linux-api@lfdr.de>; Thu, 28 Jan 2021 16:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhA1PJJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Jan 2021 10:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhA1PIV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Jan 2021 10:08:21 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1531C061573
        for <linux-api@vger.kernel.org>; Thu, 28 Jan 2021 07:07:38 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m22so8016254lfg.5
        for <linux-api@vger.kernel.org>; Thu, 28 Jan 2021 07:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gx1FZQ1uHuDZkl2l0QuCyhlDjtM4hAvEVSjKq4XHXek=;
        b=rNDrJmirIdtuQRNEjYCJqIahTLFcoP8DR9oYw737/DvxJ19UDGdrbCsIGle2umy0jD
         NXWAsRT1flRccegDPvkf55kCw2DNk8SqDIL58JVr3fvRjKunbCHaj8KABu2swU23b+Tn
         x+NU2ZIn6ek86dpsaDWMjLSj4H8o+tTQ3yC4aFlrBvOa8XcqzmKF2TQDerrN2R5pYJu+
         fAMFlALz41f7QuqjuFdkX9Gq9MHturSOMu64f3KjxUu+KSfCnR6HUHqw812RnfVk6aYa
         yoVqSkXCV6LgmIAb66X006PCDW1Z8Wnv3RYQ7I2XqpROsvJE5rsKOwyxmgJqOxI69qOR
         rdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gx1FZQ1uHuDZkl2l0QuCyhlDjtM4hAvEVSjKq4XHXek=;
        b=CGbB85Y+foLASp1kqe3dGgskF6OlucSfuuUZTQSYE5ksnE6HPufTKZeHKSFJ4/JG+N
         CP1ZBXWt8zptq049p9EOtHUm5JmaJolxipUd7iW6axrHs8MQ9KmS9fP6EgITr6LJPG3Y
         9hPTneO56mnwdwy+GG+0NP4/LP+lkD6C1nS+FtgrtlbHAweLQpyhmyMhU+WdZqzn+U93
         6B+Rza0hfzCTlWO+Tz1jlvN7GMQIJ/usP4hyHVAhYPr59P1XdOdYwzP75pAbEmvimNUH
         yB5YvM1PYVOWjmHq0REp6ENjzGAiXaLDiDFIHDlwQPfCDavLVTwhwdIchA3MngPvX3Ha
         2ERA==
X-Gm-Message-State: AOAM531+TUx5M/lXQPrPIy8QjtXVJmYUqhA/Lx3bCtmq7ef2q67Vd9XV
        Q/nwXINWdMCRsiczWXEPzvXnxLfNru4D6KpvpmZdNg==
X-Google-Smtp-Source: ABdhPJxzwr8HMJ6apJZ3CZOR5fR8XzuCeUvw1xC4eQd5oEBUK4Q1RF1OXJXRQ9M4PBPC4V1mLDTLd34b3MmjmhPEFbo=
X-Received: by 2002:ac2:5a41:: with SMTP id r1mr7813210lfn.117.1611846457199;
 Thu, 28 Jan 2021 07:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20210121122723.3446-1-rppt@kernel.org> <20210121122723.3446-9-rppt@kernel.org>
 <20210125161706.GE308988@casper.infradead.org> <CALvZod7rn_5oXT6Z+iRCeMX_iMRO9G_8FnwSRGpJJwyBz5Wpnw@mail.gmail.com>
 <20210125213526.GK6332@kernel.org>
In-Reply-To: <20210125213526.GK6332@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 28 Jan 2021 07:07:26 -0800
Message-ID: <CALvZod4__691+OBMcQMfszJzd0g3OTz95gK2vHoL+c5gw+h++Q@mail.gmail.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 25, 2021 at 1:35 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Jan 25, 2021 at 09:18:04AM -0800, Shakeel Butt wrote:
> > On Mon, Jan 25, 2021 at 8:20 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Jan 21, 2021 at 02:27:20PM +0200, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > >
> > > > Account memory consumed by secretmem to memcg. The accounting is updated
> > > > when the memory is actually allocated and freed.
>
> I though about doing per-page accounting, but then one would be able to
> create a lot of secretmem file descriptors, use only a page from each while
> actual memory consumption will be way higher.
>
> > > I think this is wrong.  It fails to account subsequent allocators from
> > > the same PMD.  If you want to track like this, you need separate pools
> > > per memcg.
> > >
> >
> > Are these secretmem pools shared between different jobs/memcgs?
>
> A secretmem pool is per anonymous file descriptor and this file descriptor
> can be shared only explicitly between several processes. So, the secretmem
> pool should not be shared between different jobs/memcg. Of course, it's
> possible to spread threads of a process across different memcgs, but in
> that case the accounting will be similar to what's happening today with
> sl*b.

I don't think memcg accounting for sl*b works like that.

> The first thread to cause kmalloc() will be charged for the
> allocation of the entire slab and subsequent allocations from that slab
> will not be accounted.

The latest kernel does object level memcg accounting. So, each
allocation from these threads will correctly charge their own memcgs.
