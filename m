Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBE7314B2E
	for <lists+linux-api@lfdr.de>; Tue,  9 Feb 2021 10:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhBIJL4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Feb 2021 04:11:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12899 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhBIJDi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Feb 2021 04:03:38 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DZcMN435zzjKV1;
        Tue,  9 Feb 2021 17:01:36 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Feb 2021
 17:02:30 +0800
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
To:     Matthew Wilcox <willy@infradead.org>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <20210207213409.GL308988@casper.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <gregkh@linuxfoundation.org>, <song.bao.hua@hisilicon.com>,
        <jgg@ziepe.ca>, <kevin.tian@intel.com>, <jean-philippe@linaro.org>,
        <eric.auger@redhat.com>, <liguozhu@hisilicon.com>,
        <zhangfei.gao@linaro.org>, Sihang Chen <chensihang1@hisilicon.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <a8f90c52-d51f-173f-7fd0-fb0792ac58e4@hisilicon.com>
Date:   Tue, 9 Feb 2021 17:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210207213409.GL308988@casper.infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2021/2/8 5:34, Matthew Wilcox wrote:
> On Sun, Feb 07, 2021 at 04:18:03PM +0800, Zhou Wang wrote:
>> SVA(share virtual address) offers a way for device to share process virtual
>> address space safely, which makes more convenient for user space device
>> driver coding. However, IO page faults may happen when doing DMA
>> operations. As the latency of IO page fault is relatively big, DMA
>> performance will be affected severely when there are IO page faults.
>> >From a long term view, DMA performance will be not stable.
>>
>> In high-performance I/O cases, accelerators might want to perform
>> I/O on a memory without IO page faults which can result in dramatically
>> increased latency. Current memory related APIs could not achieve this
>> requirement, e.g. mlock can only avoid memory to swap to backup device,
>> page migration can still trigger IO page fault.
> 
> Well ... we have two requirements.  The application wants to not take
> page faults.  The system wants to move the application to a different
> NUMA node in order to optimise overall performance.  Why should the
> application's desires take precedence over the kernel's desires?  And why
> should it be done this way rather than by the sysadmin using numactl to
> lock the application to a particular node?

Just as Barry mentioned, there are other cases which could trigger IOPF.
Only numactl is not enough.

> 
>> +struct mem_pin_container {
>> +	struct xarray array;
>> +	struct mutex lock;
>> +};
> 
> I don't understand what the lock actually protects.

This lock protects pin/unpin and record/remove.
 - pin pages and record them
 - unpin pages and remove them
should be exlusive.

> 
>> +struct pin_pages {
>> +	unsigned long first;
>> +	unsigned long nr_pages;
>> +	struct page **pages;
>> +};
> 
> I don't think you need 'first', and I think you can embed the pages
> array into this struct, removing one allocation.

'first' will be recorded and be used to unpin later. We use it
as an index to get pinned pages and do unpin operation.

> 
>> +	xa_for_each(&priv->array, idx, p) {
>> +		unpin_user_pages(p->pages, p->nr_pages);
>> +		xa_erase(&priv->array, p->first);
>> +		vfree(p->pages);
>> +		kfree(p);
>> +	}
>> +
>> +	mutex_destroy(&priv->lock);
>> +	xa_destroy(&priv->array);
> 
> If you just called xa_erase() on every element of the array, you don't need
> to call xa_destroy().

OK.

> 
>> +	if (!can_do_mlock())
>> +		return -EPERM;
>
> You check for can_do_mlock(), but you don't account the pages to this
> rlimit.

Here I just copied it from ib_umen_get and do_mlock. If needed, we can
add account for pages here.

> 
>> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
> 
> You don't need to mask off the bits, the shift will remove them.

OK.

> 
>> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
> 
> DIV_ROUND_UP()?

addr->size is input pin page size which is not same as PAGE_SIZE.
So seems we can not use this macro.

> 
>> +	pages = vmalloc(nr_pages * sizeof(struct page *));
> 
> kvmalloc().  vmalloc() always allocates at least a page, so we want to
> use kmalloc if the size is small.  Also, use array_size() -- I know this
> can't overflow, but let's be clear

Yes, will use kvmalloc and array_size here.

> 
>> +	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
>> +				  flags | FOLL_LONGTERM, pages);
>> +	if (ret != nr_pages) {
>> +		pr_err("mempinfd: Failed to pin page\n");
> 
> No.  You mustn't allow the user to be able to generate messages to syslog,
> just by passing garbage to a syscall.

OK, will remove this.

> 
>> +	ret = xa_insert(&priv->array, p->first, p, GFP_KERNEL);
>> +	if (ret)
>> +		goto unpin_pages;
> 
> Hmm.  So we can't pin two ranges which start at the same address, but we
> can pin two overlapping ranges.  Is that OK?

The design here is only supporting pin a range with different start address.
If two overlapping ranges with different start address, we will not prevent
this. If this will not go wrong, let's make it simple firstly.

Best,
Zhou

> 
> 
> .
> 

