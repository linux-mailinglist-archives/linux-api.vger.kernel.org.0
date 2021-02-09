Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE0314BEA
	for <lists+linux-api@lfdr.de>; Tue,  9 Feb 2021 10:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBIJlX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Feb 2021 04:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229799AbhBIJi3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 9 Feb 2021 04:38:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E804D64E27;
        Tue,  9 Feb 2021 09:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612863468;
        bh=3uhgNxvkQ3DE4szNXNrRNOmM42w+TvFbEvvc39Kp9o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnM8UoIu7vjUquwOGgLNI/nFIs7c5cxhJzUlDrEgEcxaM71P1VbXUNr75slYvIvip
         JxniosSVimGPVVpFt1UW4dNP6DywhSeOr4E8K+/y/jp/U1BlN9NKoE4b81YZyYVsS4
         TOZQ8fJ6UIH5YGUd0osrd5uxargdhmbZrAwT4234=
Date:   Tue, 9 Feb 2021 10:37:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        song.bao.hua@hisilicon.com, jgg@ziepe.ca, kevin.tian@intel.com,
        jean-philippe@linaro.org, eric.auger@redhat.com,
        liguozhu@hisilicon.com, zhangfei.gao@linaro.org,
        Sihang Chen <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Message-ID: <YCJX6QFQ4hsNRrFj@kroah.com>
References: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <ED58431F-5972-47D1-BF50-93A20AD86C46@amacapital.net>
 <2e6cf99f-beb6-9bef-1316-5e58fb0aa86e@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e6cf99f-beb6-9bef-1316-5e58fb0aa86e@hisilicon.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 09, 2021 at 05:17:46PM +0800, Zhou Wang wrote:
> On 2021/2/8 6:02, Andy Lutomirski wrote:
> > 
> > 
> >> On Feb 7, 2021, at 12:31 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> >>
> >> ﻿SVA(share virtual address) offers a way for device to share process virtual
> >> address space safely, which makes more convenient for user space device
> >> driver coding. However, IO page faults may happen when doing DMA
> >> operations. As the latency of IO page fault is relatively big, DMA
> >> performance will be affected severely when there are IO page faults.
> >> From a long term view, DMA performance will be not stable.
> >>
> >> In high-performance I/O cases, accelerators might want to perform
> >> I/O on a memory without IO page faults which can result in dramatically
> >> increased latency. Current memory related APIs could not achieve this
> >> requirement, e.g. mlock can only avoid memory to swap to backup device,
> >> page migration can still trigger IO page fault.
> >>
> >> Various drivers working under traditional non-SVA mode are using
> >> their own specific ioctl to do pin. Such ioctl can be seen in v4l2,
> >> gpu, infiniband, media, vfio, etc. Drivers are usually doing dma
> >> mapping while doing pin.
> >>
> >> But, in SVA mode, pin could be a common need which isn't necessarily
> >> bound with any drivers, and neither is dma mapping needed by drivers
> >> since devices are using the virtual address of CPU. Thus, It is better
> >> to introduce a new common syscall for it.
> >>
> >> This patch leverages the design of userfaultfd and adds mempinfd for pin
> >> to avoid messing up mm_struct. A fd will be got by mempinfd, then user
> >> space can do pin/unpin pages by ioctls of this fd, all pinned pages under
> >> one file will be unpinned in file release process. Like pin page cases in
> >> other places, can_do_mlock is used to check permission and input
> >> parameters.
> > 
> > 
> > Can you document what the syscall does?
> 
> Will add related document in Documentation/vm.

A manpage is always good, and will be required eventually :)

thanks,

greg k-h
