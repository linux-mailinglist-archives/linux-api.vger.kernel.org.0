Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F8E314099
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 21:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBHUhM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 8 Feb 2021 15:37:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3427 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhBHUgf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Feb 2021 15:36:35 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DZHmx3ft1z5NXL;
        Tue,  9 Feb 2021 04:34:09 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 9 Feb 2021 04:35:32 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 04:35:32 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 9 Feb 2021 04:35:32 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>
CC:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: RE: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Thread-Topic: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Thread-Index: AQHW/SrsWWMRpilf2UC1Pz29QqsBVqpNZGQAgACtCgCAAKKukA==
Date:   Mon, 8 Feb 2021 20:35:31 +0000
Message-ID: <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
In-Reply-To: <20210208183348.GV4718@ziepe.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.92]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> Sent: Tuesday, February 9, 2021 7:34 AM
> To: David Hildenbrand <david@redhat.com>
> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-mm@kvack.org;
> linux-arm-kernel@lists.infradead.org; linux-api@vger.kernel.org; Andrew
> Morton <akpm@linux-foundation.org>; Alexander Viro <viro@zeniv.linux.org.uk>;
> gregkh@linuxfoundation.org; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; kevin.tian@intel.com;
> jean-philippe@linaro.org; eric.auger@redhat.com; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>; zhangfei.gao@linaro.org; chensihang (A)
> <chensihang1@hisilicon.com>
> Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
> pin
> 
> On Mon, Feb 08, 2021 at 09:14:28AM +0100, David Hildenbrand wrote:
> 
> > People are constantly struggling with the effects of long term pinnings
> > under user space control, like we already have with vfio and RDMA.
> >
> > And here we are, adding yet another, easier way to mess with core MM in the
> > same way. This feels like a step backwards to me.
> 
> Yes, this seems like a very poor candidate to be a system call in this
> format. Much too narrow, poorly specified, and possibly security
> implications to allow any process whatsoever to pin memory.
> 
> I keep encouraging people to explore a standard shared SVA interface
> that can cover all these topics (and no, uaccel is not that
> interface), that seems much more natural.
> 
> I still haven't seen an explanation why DMA is so special here,
> migration and so forth jitter the CPU too, environments that care
> about jitter have to turn this stuff off.

This paper has a good explanation:
https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7482091

mainly because page fault can go directly to the CPU and we have
many CPUs. But IO Page Faults go a different way, thus mean much
higher latency 3-80x slower than page fault:
events in hardware queue -> Interrupts -> cpu processing page fault
-> return events to iommu/device -> continue I/O.

Copied from the paper:

If the IOMMU's page table walker fails to find the desired
translation in the page table, it sends an ATS response to
the GPU notifying it of this failure. This in turn corresponds
to a page fault. In response, the GPU sends another request to
the IOMMU called a Peripheral Page Request (PPR). The IOMMU
places this request in a memory-mapped queue and raises an
interrupt on the CPU. Multiple PPR requests can be queued
before the CPU is interrupted. The OS must have a suitable
IOMMU driver to process this interrupt and the queued PPR
requests. In Linux, while in an interrupt context, the driver
pulls PPR requests from the queue and places them in a work-queue
for later processing. Presumably this design decision was made
to minimize the time spent executing in an interrupt context,
where lower priority interrupts would be dis-abled. At a later
time, an OS worker-thread calls back into the driver to process
page fault requests in the work-queue. Once the requests are
serviced, the driver notifies the IOMMU. In turn, the IOMMU
notifies the GPU. The GPU then sends an-other ATS request to
retry the translation for the original fault-ing address.

Comparison with CPU: On the CPU, a hardware excep-tion is
raised on a page fault, which immediately switches to the
OS. In most cases in Linux, this routine services the page
fault directly, instead of queuing it for later processing.
Con-trast this with a page fault from an accelerator, where
the IOMMU has to interrupt the CPU to request service on
its be-half, and also note the several back-and-forth messages
be-tween the accelerator, the IOMMU, and the CPU. Further-more,
page faults on the CPU are generally handled one at a time
on the CPU, while for the GPU they are batched by the IOMMU
and OS work-queue mechanism.

> 
> Jason

Thanks
Barry

