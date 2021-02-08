Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D793312B8D
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 09:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBHIQ3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Feb 2021 03:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhBHIQL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Feb 2021 03:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612772083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRxWJ7WNsR3Y9yvptpnpz6C31b3RRDtBV5Rnzs7rDTo=;
        b=XwV3I6GdXB1FthKHTkM+3Tv5AOX6Rdyz/4CmZ8ofRA5uyy1dov2roKmc16LyaFsA+l2880
        t5zkbCxKT6lxeRnGTtgD41nvmaECoL8JIR9OnMLkOc+10ctWmPQcG5WbYRaYlacA+qoA3W
        GwQPQ4tm+LN1SacLE65uEi3ii050efc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-55cpkyl3N_GRgxFi1ZUuqA-1; Mon, 08 Feb 2021 03:14:39 -0500
X-MC-Unique: 55cpkyl3N_GRgxFi1ZUuqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5299100CCE4;
        Mon,  8 Feb 2021 08:14:36 +0000 (UTC)
Received: from [10.36.113.240] (ovpn-113-240.ams2.redhat.com [10.36.113.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EF6F18EC5;
        Mon,  8 Feb 2021 08:14:29 +0000 (UTC)
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
To:     Zhou Wang <wangzhou1@hisilicon.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     gregkh@linuxfoundation.org, song.bao.hua@hisilicon.com,
        jgg@ziepe.ca, kevin.tian@intel.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, liguozhu@hisilicon.com,
        zhangfei.gao@linaro.org, Sihang Chen <chensihang1@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
Date:   Mon, 8 Feb 2021 09:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 07.02.21 09:18, Zhou Wang wrote:
> SVA(share virtual address) offers a way for device to share process virtual
> address space safely, which makes more convenient for user space device
> driver coding. However, IO page faults may happen when doing DMA
> operations. As the latency of IO page fault is relatively big, DMA
> performance will be affected severely when there are IO page faults.
>  From a long term view, DMA performance will be not stable.
> 
> In high-performance I/O cases, accelerators might want to perform
> I/O on a memory without IO page faults which can result in dramatically
> increased latency. Current memory related APIs could not achieve this
> requirement, e.g. mlock can only avoid memory to swap to backup device,
> page migration can still trigger IO page fault.
> 
> Various drivers working under traditional non-SVA mode are using
> their own specific ioctl to do pin. Such ioctl can be seen in v4l2,
> gpu, infiniband, media, vfio, etc. Drivers are usually doing dma
> mapping while doing pin.
> 
> But, in SVA mode, pin could be a common need which isn't necessarily
> bound with any drivers, and neither is dma mapping needed by drivers
> since devices are using the virtual address of CPU. Thus, It is better
> to introduce a new common syscall for it.
> 
> This patch leverages the design of userfaultfd and adds mempinfd for pin
> to avoid messing up mm_struct. A fd will be got by mempinfd, then user
> space can do pin/unpin pages by ioctls of this fd, all pinned pages under
> one file will be unpinned in file release process. Like pin page cases in
> other places, can_do_mlock is used to check permission and input
> parameters.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Sihang Chen <chensihang1@hisilicon.com>
> Suggested-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   arch/arm64/include/asm/unistd.h   |   2 +-
>   arch/arm64/include/asm/unistd32.h |   2 +
>   fs/Makefile                       |   1 +
>   fs/mempinfd.c                     | 199 ++++++++++++++++++++++++++++++++++++++
>   include/linux/syscalls.h          |   1 +
>   include/uapi/asm-generic/unistd.h |   4 +-
>   include/uapi/linux/mempinfd.h     |  23 +++++
>   init/Kconfig                      |   6 ++
>   8 files changed, 236 insertions(+), 2 deletions(-)
>   create mode 100644 fs/mempinfd.c
>   create mode 100644 include/uapi/linux/mempinfd.h
> 
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 86a9d7b3..949788f 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -38,7 +38,7 @@
>   #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>   #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>   
> -#define __NR_compat_syscalls		442
> +#define __NR_compat_syscalls		443
>   #endif
>   
>   #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index cccfbbe..3f49529 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
>   __SYSCALL(__NR_process_madvise, sys_process_madvise)
>   #define __NR_epoll_pwait2 441
>   __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
> +#define __NR_mempinfd 442
> +__SYSCALL(__NR_mempinfd, sys_mempinfd)
>   
>   /*
>    * Please add new compat syscalls above this comment and update
> diff --git a/fs/Makefile b/fs/Makefile
> index 999d1a2..e1cbf12 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_COREDUMP)		+= coredump.o
>   obj-$(CONFIG_SYSCTL)		+= drop_caches.o
>   
>   obj-$(CONFIG_FHANDLE)		+= fhandle.o
> +obj-$(CONFIG_MEMPINFD)		+= mempinfd.o
>   obj-y				+= iomap/
>   
>   obj-y				+= quota/
> diff --git a/fs/mempinfd.c b/fs/mempinfd.c
> new file mode 100644
> index 0000000..23d3911
> --- /dev/null
> +++ b/fs/mempinfd.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2021 HiSilicon Limited. */
> +#include <linux/anon_inodes.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/mm_types.h>
> +#include <linux/slab.h>
> +#include <linux/syscalls.h>
> +#include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
> +#include <linux/xarray.h>
> +#include <uapi/linux/mempinfd.h>
> +
> +struct mem_pin_container {
> +	struct xarray array;
> +	struct mutex lock;
> +};
> +
> +struct pin_pages {
> +	unsigned long first;
> +	unsigned long nr_pages;
> +	struct page **pages;
> +};
> +
> +static int mempinfd_release(struct inode *inode, struct file *file)
> +{
> +	struct mem_pin_container *priv = file->private_data;
> +	struct pin_pages *p;
> +	unsigned long idx;
> +
> +	xa_for_each(&priv->array, idx, p) {
> +		unpin_user_pages(p->pages, p->nr_pages);
> +		xa_erase(&priv->array, p->first);
> +		vfree(p->pages);
> +		kfree(p);
> +	}
> +
> +	mutex_destroy(&priv->lock);
> +	xa_destroy(&priv->array);
> +	kfree(priv);
> +
> +	return 0;
> +}
> +
> +static int mempinfd_input_check(u64 addr, u64 size)
> +{
> +	if (!size || addr + size < addr)
> +		return -EINVAL;
> +
> +	if (!can_do_mlock())
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +static int mem_pin_page(struct mem_pin_container *priv,
> +			struct mem_pin_address *addr)
> +{
> +	unsigned int flags = FOLL_FORCE | FOLL_WRITE;
> +	unsigned long first, last, nr_pages;
> +	struct page **pages;
> +	struct pin_pages *p;
> +	int ret;
> +
> +	if (mempinfd_input_check(addr->addr, addr->size))
> +		return -EINVAL;
> +
> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
> +	nr_pages = last - first + 1;
> +
> +	pages = vmalloc(nr_pages * sizeof(struct page *));
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
> +				  flags | FOLL_LONGTERM, pages);
> +	if (ret != nr_pages) {
> +		pr_err("mempinfd: Failed to pin page\n");
> +		goto unlock;
> +	}

People are constantly struggling with the effects of long term pinnings 
under user space control, like we already have with vfio and RDMA.

And here we are, adding yet another, easier way to mess with core MM in 
the same way. This feels like a step backwards to me.

-- 
Thanks,

David / dhildenb

