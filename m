Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2092CB74
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfE1QPe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 12:15:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34159 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfE1QP1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 12:15:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so32648259eda.1
        for <linux-api@vger.kernel.org>; Tue, 28 May 2019 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=APCrAvO45WxG2Z8dfWcCRk4DUY8ED5a7eiZnfDHqXrg=;
        b=XY50YErwMzcK4b2EJ3Yqe+d4nhkKDipKsPAIbaHdLbnMaCRTQt/7KSd6+32LoUKpqz
         aeGT5DX+k3xCrJEqMWxCAmUD5bbqYrWItKYmrTdKl/kAA/yZNnaP3BlMcDQxKT1Mo8AQ
         WriwTcpqeJiu2CFEVqE1RutpiTmZmyifR4RjQfNQv9b5EDaN0TyBhloQk0R1fKchYvWi
         Jg8fPa+tSeRcs+Ble2TqgN1WPji/7X2dnFhnX0LRsjWX6SLhoy2k+JPRUUmGgecmcJyF
         hzgmMT7CQcM6wCJD52eYLRScxcoABgs1FelkHFrgu4NOqBlkeJ/Ff0EebUcl5L0dBOoo
         FtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=APCrAvO45WxG2Z8dfWcCRk4DUY8ED5a7eiZnfDHqXrg=;
        b=XNWNBva5p2kafg4FrMMez+JVoVGDkELSfiz2Gjov4THgDEJGQv0ZEzIaL71FjfL/cF
         1T0aUpTSwBHv8UON4FEORHZxRIRZbBhKpHuPpaEcZsYgT01cd6cEZw0QVKMZMQ0t7Ewd
         8t2xniGiNYnR8Ei6f2M1GNJTbOaorSQCpmEZF02hgkgZ2NqaYFeVWuHLolf6Uq9pjK2P
         DQbZwaaE2Cvk5GRZsmyZHniayjTwbluZ9PKcZY4cbZO3THtRFvjAiXF7Jo6tQexfeNcx
         z0964dWZUEwe3KWu3DK1Z8CETerKwPXRrRfNhNQhYMEK9n3LUvZ/PuVzV90ylT8d0nly
         kh3w==
X-Gm-Message-State: APjAAAUWhCZdGkf7fBP6ABCuMcrmzcUrQojBr05kBpRvZMbxAbQf5RSC
        df6njtv/ePg7gErR1UxrFU6ULA==
X-Google-Smtp-Source: APXvYqxplFSWKYUVi8zFdC6FL9P2zZJFxS1PTqk9F8PBPaSKcxV4aV+QR+60zNN6XgknS5phD8dk4Q==
X-Received: by 2002:a50:91cc:: with SMTP id h12mr129701698eda.3.1559060125768;
        Tue, 28 May 2019 09:15:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b4sm4393511eda.9.2019.05.28.09.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 09:15:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0F0A21041E5; Tue, 28 May 2019 19:15:24 +0300 (+03)
Date:   Tue, 28 May 2019 19:15:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
Message-ID: <20190528161524.tn5sqzhmhgyuwrmy@box>
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <20190522152254.5cyxhjizuwuojlix@box>
 <358bb95e-0dca-6a82-db39-83c0cf09a06c@virtuozzo.com>
 <20190524115239.ugxv766doolc6nsc@box>
 <c3cd3719-0a5e-befe-89f2-328526bb714d@virtuozzo.com>
 <20190527233030.hpnnbi4aqnu34ova@box>
 <de6e4e89-66ac-da2f-48a6-4d98a728687a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6e4e89-66ac-da2f-48a6-4d98a728687a@virtuozzo.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 12:15:16PM +0300, Kirill Tkhai wrote:
> On 28.05.2019 02:30, Kirill A. Shutemov wrote:
> > On Fri, May 24, 2019 at 05:00:32PM +0300, Kirill Tkhai wrote:
> >> On 24.05.2019 14:52, Kirill A. Shutemov wrote:
> >>> On Fri, May 24, 2019 at 01:45:50PM +0300, Kirill Tkhai wrote:
> >>>> On 22.05.2019 18:22, Kirill A. Shutemov wrote:
> >>>>> On Mon, May 20, 2019 at 05:00:01PM +0300, Kirill Tkhai wrote:
> >>>>>> This patchset adds a new syscall, which makes possible
> >>>>>> to clone a VMA from a process to current process.
> >>>>>> The syscall supplements the functionality provided
> >>>>>> by process_vm_writev() and process_vm_readv() syscalls,
> >>>>>> and it may be useful in many situation.
> >>>>>
> >>>>> Kirill, could you explain how the change affects rmap and how it is safe.
> >>>>>
> >>>>> My concern is that the patchset allows to map the same page multiple times
> >>>>> within one process or even map page allocated by child to the parrent.
> >>>>>
> >>>>> It was not allowed before.
> >>>>>
> >>>>> In the best case it makes reasoning about rmap substantially more difficult.
> >>>>>
> >>>>> But I'm worry it will introduce hard-to-debug bugs, like described in
> >>>>> https://lwn.net/Articles/383162/.
> >>>>
> >>>> Andy suggested to unmap PTEs from source page table, and this make the single
> >>>> page never be mapped in the same process twice. This is OK for my use case,
> >>>> and here we will just do a small step "allow to inherit VMA by a child process",
> >>>> which we didn't have before this. If someone still needs to continue the work
> >>>> to allow the same page be mapped twice in a single process in the future, this
> >>>> person will have a supported basis we do in this small step. I believe, someone
> >>>> like debugger may want to have this to make a fast snapshot of a process private
> >>>> memory (when the task is stopped for a small time to get its memory). But for
> >>>> me remapping is enough at the moment.
> >>>>
> >>>> What do you think about this?
> >>>
> >>> I don't think that unmapping alone will do. Consider the following
> >>> scenario:
> >>>
> >>> 1. Task A creates and populates the mapping.
> >>> 2. Task A forks. We have now Task B mapping the same pages, but
> >>> write-protected.
> >>> 3. Task B calls process_vm_mmap() and passes the mapping to the parent.
> >>>
> >>> After this Task A will have the same anon pages mapped twice.
> >>
> >> Ah, sure.
> >>
> >>> One possible way out would be to force CoW on all pages in the mapping,
> >>> before passing the mapping to the new process.
> >>
> >> This will pop all swapped pages up, which is the thing the patchset aims
> >> to prevent.
> >>
> >> Hm, what about allow remapping only VMA, which anon_vma::rb_root contain
> >> only chain and which vma->anon_vma_chain contains single entry? This is
> >> a vma, which were faulted, but its mm never were duplicated (or which
> >> forks already died).
> > 
> > The requirement for the VMA to be faulted (have any pages mapped) looks
> > excessive to me, but the general idea may work.
> > 
> > One issue I see is that userspace may not have full control to create such
> > VMA. vma_merge() can merge the VMA to the next one without any consent
> > from userspace and you'll get anon_vma inherited from the VMA you've
> > justed merged with.
> > 
> > I don't have any valid idea on how to get around this.
> 
> Technically it is possible by creating boundary 1-page VMAs with another protection:
> one above and one below the desired region, then map the desired mapping. But this
> is not comfortable.
> 
> I don't think it's difficult to find a natural limitation, which prevents mapping
> a single page twice if we want to avoid this at least on start. Another suggestion:
> 
> prohibit to map a remote process's VMA only in case of its vm_area_struct::anon_vma::root
> is the same as root of one of local process's VMA.
> 
> What about this?

I don't see anything immediately wrong with this, but it's still going to
produce puzzling errors for a user. How would you document such limitation
in the way it makes sense for userspace developer?

-- 
 Kirill A. Shutemov
