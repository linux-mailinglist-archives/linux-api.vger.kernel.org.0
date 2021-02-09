Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFAF314B66
	for <lists+linux-api@lfdr.de>; Tue,  9 Feb 2021 10:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBIJWM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Feb 2021 04:22:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12604 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhBIJSr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Feb 2021 04:18:47 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZchc0Dr5z165bR;
        Tue,  9 Feb 2021 17:16:32 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Feb 2021
 17:17:46 +0800
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
To:     Andy Lutomirski <luto@amacapital.net>
References: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <ED58431F-5972-47D1-BF50-93A20AD86C46@amacapital.net>
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
Message-ID: <2e6cf99f-beb6-9bef-1316-5e58fb0aa86e@hisilicon.com>
Date:   Tue, 9 Feb 2021 17:17:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <ED58431F-5972-47D1-BF50-93A20AD86C46@amacapital.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2021/2/8 6:02, Andy Lutomirski wrote:
> 
> 
>> On Feb 7, 2021, at 12:31 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>>
>> ﻿SVA(share virtual address) offers a way for device to share process virtual
>> address space safely, which makes more convenient for user space device
>> driver coding. However, IO page faults may happen when doing DMA
>> operations. As the latency of IO page fault is relatively big, DMA
>> performance will be affected severely when there are IO page faults.
>> From a long term view, DMA performance will be not stable.
>>
>> In high-performance I/O cases, accelerators might want to perform
>> I/O on a memory without IO page faults which can result in dramatically
>> increased latency. Current memory related APIs could not achieve this
>> requirement, e.g. mlock can only avoid memory to swap to backup device,
>> page migration can still trigger IO page fault.
>>
>> Various drivers working under traditional non-SVA mode are using
>> their own specific ioctl to do pin. Such ioctl can be seen in v4l2,
>> gpu, infiniband, media, vfio, etc. Drivers are usually doing dma
>> mapping while doing pin.
>>
>> But, in SVA mode, pin could be a common need which isn't necessarily
>> bound with any drivers, and neither is dma mapping needed by drivers
>> since devices are using the virtual address of CPU. Thus, It is better
>> to introduce a new common syscall for it.
>>
>> This patch leverages the design of userfaultfd and adds mempinfd for pin
>> to avoid messing up mm_struct. A fd will be got by mempinfd, then user
>> space can do pin/unpin pages by ioctls of this fd, all pinned pages under
>> one file will be unpinned in file release process. Like pin page cases in
>> other places, can_do_mlock is used to check permission and input
>> parameters.
> 
> 
> Can you document what the syscall does?

Will add related document in Documentation/vm.

> 
> Userfaultfd is an fd because one program controls another.  Is mempinfd like this?

We use mempinfd like: (see patch 2/2)

fd = mempinfd();
va = malloc(size);
struct mem_pin_address addr;
addr.va = va;
addr.size = size;
ioctl(fd, MEM_CMD_PIN, &addr);
ioctl(fd, MEM_CMD_UNPIN, &addr);
close(fd);

Best,
Zhou

> .
> 

