Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E8D49A67E
	for <lists+linux-api@lfdr.de>; Tue, 25 Jan 2022 03:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2362225AbiAYCJR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jan 2022 21:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384813AbiAXXR7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jan 2022 18:17:59 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6704FC07E299
        for <linux-api@vger.kernel.org>; Mon, 24 Jan 2022 11:45:30 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id j2so24239111ejk.6
        for <linux-api@vger.kernel.org>; Mon, 24 Jan 2022 11:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHZk13TjFNMDjJXMZYf/TM9w4N/o8YjDbaIvNFCkPO0=;
        b=Cv4GiI7Vs9qFebRmH6z6Iu5sLjunEjZkcwoRG04B9LO1othTsQJZ7PZOndTUDTLx7I
         RNVxFE9tnxaTreXBZTM79OAFFdUboLvEggXIwfPBN3JHssLSO8CmUWdsJ101e7RPGoeb
         HxI/Mnv2cIlvO7Mrf/UtcnRl0M+pk1TT3ldDoVBsuw7ta+N6Fy0p+yxSVWYlnmTEMofy
         rkK1fjDg3kUw7AQQ7Vu6KntwUA0iXTszXID3VEaDTL5NCGG4LE8upblMk88iVHwYBlwV
         rNB622h9vHRN4A6P2SgI+o/BvXUPmzf1y4Zwxc+m+BHsAfMRdzIh1koSictnJlWKzdvU
         /PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHZk13TjFNMDjJXMZYf/TM9w4N/o8YjDbaIvNFCkPO0=;
        b=HKeoLn9RQrLWgielSWBk+gvYQag8J3ShQIPLlwziuP+REdMNFCNNIaGoQVY+S9Q8nZ
         tNHfZOlVp7aURpHsHfaysS13+lKkFTFB/bGy3FrewaGmNP+GxcgRixTBAZyFfhVJQO/5
         CrQrNGtDrNROpjg57bIXqFqZSCy8MRONPhdwsKQoGFiMBQkbF5DXdHL+G/m7vXjcEDD4
         Ra7MiridlMv25a3927ato+IV3D61cXjJ6pI/oWokKowehPY2PAgZ4dVO7Oc9QvGqNkNT
         TcERytRJm8GL2TBtMKtqHsTZ2c2o1FeBF8MBIXwf3Ry+wCvDv8u3z1OpS1oiOKd9JF2P
         DWiA==
X-Gm-Message-State: AOAM531LP3KrcumdmrJ6xrBAfH3owP8H5oG674RXzalyrSzZKOyvmzH7
        wbIM7UMkmYvXFakmaY6RHpj65sIigGNNcczDBywFUw==
X-Google-Smtp-Source: ABdhPJzJ+TbZFv5Hzmh44wNfBxe8w+HDTMrFIePgqyBlFF4UEGPC8wWLWJkclkPQGdTxPg5nOT+6yA8VdYwaWXKRhzc=
X-Received: by 2002:a17:906:150c:: with SMTP id b12mr13236929ejd.284.1643053528952;
 Mon, 24 Jan 2022 11:45:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642526745.git.khalid.aziz@oracle.com> <YevrGs3WE7ywB+lH@kernel.org>
 <4d333527-391f-fe6b-eb2d-123d67242d2c@oracle.com>
In-Reply-To: <4d333527-391f-fe6b-eb2d-123d67242d2c@oracle.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 24 Jan 2022 11:45:07 -0800
Message-ID: <CALCETrVNrcsLvFwTER8LmgZZdy0Mye7EJXyuOaS5yVQvB5UNpA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org,
        willy@infradead.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 24, 2022 at 10:54 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> On 1/22/22 04:31, Mike Rapoport wrote:
> > (added linux-api)
> >
> > On Tue, Jan 18, 2022 at 02:19:12PM -0700, Khalid Aziz wrote:
> >> Page tables in kernel consume some of the memory and as long as
> >> number of mappings being maintained is small enough, this space
> >> consumed by page tables is not objectionable. When very few memory
> >> pages are shared between processes, the number of page table entries
> >> (PTEs) to maintain is mostly constrained by the number of pages of
> >> memory on the system. As the number of shared pages and the number
> >> of times pages are shared goes up, amount of memory consumed by page
> >> tables starts to become significant.
> >>
> >> Some of the field deployments commonly see memory pages shared
> >> across 1000s of processes. On x86_64, each page requires a PTE that
> >> is only 8 bytes long which is very small compared to the 4K page
> >> size. When 2000 processes map the same page in their address space,
> >> each one of them requires 8 bytes for its PTE and together that adds
> >> up to 8K of memory just to hold the PTEs for one 4K page. On a
> >> database server with 300GB SGA, a system carsh was seen with
> >> out-of-memory condition when 1500+ clients tried to share this SGA
> >> even though the system had 512GB of memory. On this server, in the
> >> worst case scenario of all 1500 processes mapping every page from
> >> SGA would have required 878GB+ for just the PTEs. If these PTEs
> >> could be shared, amount of memory saved is very significant.
> >>
> >> This is a proposal to implement a mechanism in kernel to allow
> >> userspace processes to opt into sharing PTEs. The proposal is to add
> >> a new system call - mshare(), which can be used by a process to
> >> create a region (we will call it mshare'd region) which can be used
> >> by other processes to map same pages using shared PTEs. Other
> >> process(es), assuming they have the right permissions, can then make
> >> the mashare() system call to map the shared pages into their address
> >> space using the shared PTEs.  When a process is done using this
> >> mshare'd region, it makes a mshare_unlink() system call to end its
> >> access. When the last process accessing mshare'd region calls
> >> mshare_unlink(), the mshare'd region is torn down and memory used by
> >> it is freed.
> >>
> >>
> >> API Proposal
> >> ============
> >>
> >> The mshare API consists of two system calls - mshare() and mshare_unlink()
> >>
> >> --
> >> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
> >>
> >> mshare() creates and opens a new, or opens an existing mshare'd
> >> region that will be shared at PTE level. "name" refers to shared object
> >> name that exists under /sys/fs/mshare. "addr" is the starting address
> >> of this shared memory area and length is the size of this area.
> >> oflags can be one of:
> >>
> >> - O_RDONLY opens shared memory area for read only access by everyone
> >> - O_RDWR opens shared memory area for read and write access
> >> - O_CREAT creates the named shared memory area if it does not exist
> >> - O_EXCL If O_CREAT was also specified, and a shared memory area
> >>    exists with that name, return an error.
> >>
> >> mode represents the creation mode for the shared object under
> >> /sys/fs/mshare.
> >>
> >> mshare() returns an error code if it fails, otherwise it returns 0.
> >
> > Did you consider returning a file descriptor from mshare() system call?
> > Then there would be no need in mshare_unlink() as close(fd) would work.
>
> That is an interesting idea. It could work and eliminates the need for a new system call. It could be confusing though
> for application writers. A close() call with a side-effect of deleting shared mapping would be odd. One of the use cases
> for having files for mshare'd regions is to allow for orphaned mshare'd regions to be cleaned up by calling
> mshare_unlink() with region name. This can require calling mshare_unlink() multiple times in current implementation to
> bring the refcount for mshare'd region to 0 when mshare_unlink() finally cleans up the region. This would be problematic
> with a close() semantics though unless there was another way to force refcount to 0. Right?
>

I'm not sure I understand the problem.  If you're sharing a portion of
an mm and the mm goes away, then all that should be left are some
struct files that are no longer useful.  They'll go away when their
refcount goes to zero.

--Andy
