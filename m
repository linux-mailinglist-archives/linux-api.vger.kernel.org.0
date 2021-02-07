Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD37312796
	for <lists+linux-api@lfdr.de>; Sun,  7 Feb 2021 22:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGVfF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 16:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBGVfE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Feb 2021 16:35:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA5BC06174A;
        Sun,  7 Feb 2021 13:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y+S/LX44a9NNx3dGKU3W10H4coPDrc53Kmvv4eVUILs=; b=jk3k6ovvjVTWnfOKs4KKL28gHs
        E3infYdAisvXmp2e28FqZSi8PowAudg/J4HUU+RQZkOd4jyrho7b1D2lBJL/Zi0gyDGl6Zhkz6+CX
        61rDbpkJo3h7u9i/iGE0BIu1tHx5KkSe0b78+GMS62RmlOZcEpWcN6GRwbMQI2HBmJ9ukrRvmeHN8
        T92alHBcH65ZJXdEW+4Ldz5OtgSFwNgd11YIKUjsk39oW/3MyqppThjjUZmLKNFhLTFE34L8rgcYl
        1AScMZodOOkOZCxEDymnpEc3MrtSAHSFauRuDhn3zomqsOxWHJFoMLUqZ1wtHGze+DL2xmOnj+hr4
        7Qc/yQog==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l8rh3-0059pm-0q; Sun, 07 Feb 2021 21:34:11 +0000
Date:   Sun, 7 Feb 2021 21:34:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        gregkh@linuxfoundation.org, song.bao.hua@hisilicon.com,
        jgg@ziepe.ca, kevin.tian@intel.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, liguozhu@hisilicon.com,
        zhangfei.gao@linaro.org, Sihang Chen <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Message-ID: <20210207213409.GL308988@casper.infradead.org>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Feb 07, 2021 at 04:18:03PM +0800, Zhou Wang wrote:
> SVA(share virtual address) offers a way for device to share process virtual
> address space safely, which makes more convenient for user space device
> driver coding. However, IO page faults may happen when doing DMA
> operations. As the latency of IO page fault is relatively big, DMA
> performance will be affected severely when there are IO page faults.
> >From a long term view, DMA performance will be not stable.
> 
> In high-performance I/O cases, accelerators might want to perform
> I/O on a memory without IO page faults which can result in dramatically
> increased latency. Current memory related APIs could not achieve this
> requirement, e.g. mlock can only avoid memory to swap to backup device,
> page migration can still trigger IO page fault.

Well ... we have two requirements.  The application wants to not take
page faults.  The system wants to move the application to a different
NUMA node in order to optimise overall performance.  Why should the
application's desires take precedence over the kernel's desires?  And why
should it be done this way rather than by the sysadmin using numactl to
lock the application to a particular node?

> +struct mem_pin_container {
> +	struct xarray array;
> +	struct mutex lock;
> +};

I don't understand what the lock actually protects.

> +struct pin_pages {
> +	unsigned long first;
> +	unsigned long nr_pages;
> +	struct page **pages;
> +};

I don't think you need 'first', and I think you can embed the pages
array into this struct, removing one allocation.

> +	xa_for_each(&priv->array, idx, p) {
> +		unpin_user_pages(p->pages, p->nr_pages);
> +		xa_erase(&priv->array, p->first);
> +		vfree(p->pages);
> +		kfree(p);
> +	}
> +
> +	mutex_destroy(&priv->lock);
> +	xa_destroy(&priv->array);

If you just called xa_erase() on every element of the array, you don't need
to call xa_destroy().

> +	if (!can_do_mlock())
> +		return -EPERM;

You check for can_do_mlock(), but you don't account the pages to this
rlimit.

> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;

You don't need to mask off the bits, the shift will remove them.

> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;

DIV_ROUND_UP()?

> +	pages = vmalloc(nr_pages * sizeof(struct page *));

kvmalloc().  vmalloc() always allocates at least a page, so we want to
use kmalloc if the size is small.  Also, use array_size() -- I know this
can't overflow, but let's be clear

> +	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
> +				  flags | FOLL_LONGTERM, pages);
> +	if (ret != nr_pages) {
> +		pr_err("mempinfd: Failed to pin page\n");

No.  You mustn't allow the user to be able to generate messages to syslog,
just by passing garbage to a syscall.

> +	ret = xa_insert(&priv->array, p->first, p, GFP_KERNEL);
> +	if (ret)
> +		goto unpin_pages;

Hmm.  So we can't pin two ranges which start at the same address, but we
can pin two overlapping ranges.  Is that OK?

