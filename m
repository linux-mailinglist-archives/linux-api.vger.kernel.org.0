Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2183DC986
	for <lists+linux-api@lfdr.de>; Sun,  1 Aug 2021 06:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhHAECG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 1 Aug 2021 00:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhHAECE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 1 Aug 2021 00:02:04 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA2C06175F
        for <linux-api@vger.kernel.org>; Sat, 31 Jul 2021 21:01:55 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id az7so13534999qkb.5
        for <linux-api@vger.kernel.org>; Sat, 31 Jul 2021 21:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Bamtlf1xYDbsxVIm2+Hj57JkHWBBhyBU5JpXT15STbM=;
        b=LSHEuW5/YX6Gd4nLb2XE10CrvjgFEJIu8hjBL06szNHTitQHTQiecsmoEnUEH8l1ks
         BMTWEgFKO4ZrE6GdFu62kquXtXG2gHhFe1CLhSqRbqhDp0jK0ISilfzcVvpuL8CdcT8t
         J6r+US2mhB1QjthfCD7/udVR2nJDNYZkq/+4IIMvzFSsIpLTg/0oZVVd1eyM9J5LzHqA
         k8uOLtSfxwq4dvW4HDVzWZ0bGHVN9QcgEc61iA+kgMyCPOeEFEEPw/axIkw9ppd6kQrg
         zXYtv2xnLk/qo0zqNHc8zWazozt+Uw3mnrjShjjrJBtfRdbjAtHLiFjVxwanehVAMh5O
         soPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Bamtlf1xYDbsxVIm2+Hj57JkHWBBhyBU5JpXT15STbM=;
        b=PRwjp1006IG/Fr0FbOT3Vn0m0FPzq48GPsqMIKgKA15tDuEHyai4RKWOA2RFKcQBEC
         Zmewd+cWKheyNtDSaHJBxHUuH5aA6ZDnoq/Fl+enqEWbP/UDXToLFwnWgWQfdW3CAtuq
         ZwKQohTZ0Att7tkpWJNmGkpL5oFAIqSIi7MQXhAOuibSFxZQvr6U/NO8+hIERHVd5K6t
         ebx1/qi3/s7bF817vfm8Sp5ZULZ37tJFjB+ouca3wPcV2rvovAmiun5jtRP2sFRUkYS3
         5esfm9aBh1XcjsOE0YbQoTt/JX4hekb+6PBm7tv0xk5mdJn3ix1dFn9rVuvTqVwBO5rz
         CMSg==
X-Gm-Message-State: AOAM532/Rl9Bwnlx663Va5yn2xEighZVGPLLYOQISQaHFlq/hsjrNlb0
        A5hpnUBLXQY4zc1feYZOnkHQpw==
X-Google-Smtp-Source: ABdhPJwpiOW6lPa9+HxDKJhJy9Z92W83ZI44clBKHCglmMG1irmPwdmlSECTwZypIvw95ecMuWY1tw==
X-Received: by 2002:a37:9b14:: with SMTP id d20mr9473258qke.368.1627790514364;
        Sat, 31 Jul 2021 21:01:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 71sm2818101qtc.97.2021.07.31.21.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 21:01:53 -0700 (PDT)
Date:   Sat, 31 Jul 2021 21:01:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 04/16] huge tmpfs: revert shmem's use of
 transhuge_vma_enabled()
In-Reply-To: <CAHbLzko5oU_1X=M1LFr=4hNDvs0BF0UY+_8e0RHMhUqspMHV3Q@mail.gmail.com>
Message-ID: <55526ab1-4280-9538-51d7-6669b8a97f@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <b44e3619-712e-90af-89d2-e4ba654c5110@google.com> <CAHbLzko5oU_1X=M1LFr=4hNDvs0BF0UY+_8e0RHMhUqspMHV3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 30 Jul 2021, Yang Shi wrote:
> On Fri, Jul 30, 2021 at 12:36 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > 5.14 commit e6be37b2e7bd ("mm/huge_memory.c: add missing read-only THP
> > checking in transparent_hugepage_enabled()") added transhuge_vma_enabled()
> > as a wrapper for two very different checks: shmem_huge_enabled() prefers
> > to show those two checks explicitly, as before.
> 
> Basically I have no objection to separating them again. But IMHO they
> seem not very different. Or just makes things easier for the following
> patches?

Well, it made it easier to apply the patch I'd prepared earlier,
but that was not the point; and I thought it best to be upfront
about the reversion, rather than hiding it in the movement.

The end result of the two checks is the same (don't try for huge pages),
and they have been grouped together because they occurred together in
several places, and both rely on "vma".

But one check is whether the app has marked that address range not to use
THPs; and the other check is whether the process is running in a hierarchy
that has been marked never to use THPs (which just uses vma to get to mm
to get to mm->flags (whether current->mm would be more relevant is not an
argument I want to get into, I'm not at all sure)).

To me those are very different; and I'm particularly concerned to make
MMF_DISABLE_THP references visible, since it did not exist when Kirill
and I first implemented shmem huge pages, and I've tended to forget it:
but consider it more in this series.

Hugh

> 
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  mm/shmem.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index ce3ccaac54d6..c6fa6f4f2db8 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -4003,7 +4003,8 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
> >         loff_t i_size;
> >         pgoff_t off;
> >
> > -       if (!transhuge_vma_enabled(vma, vma->vm_flags))
> > +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> > +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> >                 return false;
> >         if (shmem_huge == SHMEM_HUGE_FORCE)
> >                 return true;
> > --
> > 2.26.2
