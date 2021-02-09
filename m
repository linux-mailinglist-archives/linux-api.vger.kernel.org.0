Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E453146C7
	for <lists+linux-api@lfdr.de>; Tue,  9 Feb 2021 04:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhBIDCf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 8 Feb 2021 22:02:35 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2892 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhBIDCa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Feb 2021 22:02:30 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DZSL560z1z5PjV;
        Tue,  9 Feb 2021 10:59:57 +0800 (CST)
Received: from dggpemm100011.china.huawei.com (7.185.36.112) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 9 Feb 2021 11:01:41 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 11:01:42 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 9 Feb 2021 11:01:42 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     David Hildenbrand <david@redhat.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
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
Thread-Index: AQHW/SrsWWMRpilf2UC1Pz29QqsBVqpNZGQAgACtCgCAAKKukP//jqmAgADcIzA=
Date:   Tue, 9 Feb 2021 03:01:42 +0000
Message-ID: <0868d209d7424942a46d1238674cf75d@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
 <20210208213023.GZ4718@ziepe.ca>
In-Reply-To: <20210208213023.GZ4718@ziepe.ca>
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
> Sent: Tuesday, February 9, 2021 10:30 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: David Hildenbrand <david@redhat.com>; Wangzhou (B)
> <wangzhou1@hisilicon.com>; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-mm@kvack.org;
> linux-arm-kernel@lists.infradead.org; linux-api@vger.kernel.org; Andrew
> Morton <akpm@linux-foundation.org>; Alexander Viro <viro@zeniv.linux.org.uk>;
> gregkh@linuxfoundation.org; kevin.tian@intel.com; jean-philippe@linaro.org;
> eric.auger@redhat.com; Liguozhu (Kenneth) <liguozhu@hisilicon.com>;
> zhangfei.gao@linaro.org; chensihang (A) <chensihang1@hisilicon.com>
> Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
> pin
> 
> On Mon, Feb 08, 2021 at 08:35:31PM +0000, Song Bao Hua (Barry Song) wrote:
> >
> >
> > > From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> > > Sent: Tuesday, February 9, 2021 7:34 AM
> > > To: David Hildenbrand <david@redhat.com>
> > > Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; linux-kernel@vger.kernel.org;
> > > iommu@lists.linux-foundation.org; linux-mm@kvack.org;
> > > linux-arm-kernel@lists.infradead.org; linux-api@vger.kernel.org; Andrew
> > > Morton <akpm@linux-foundation.org>; Alexander Viro
> <viro@zeniv.linux.org.uk>;
> > > gregkh@linuxfoundation.org; Song Bao Hua (Barry Song)
> > > <song.bao.hua@hisilicon.com>; kevin.tian@intel.com;
> > > jean-philippe@linaro.org; eric.auger@redhat.com; Liguozhu (Kenneth)
> > > <liguozhu@hisilicon.com>; zhangfei.gao@linaro.org; chensihang (A)
> > > <chensihang1@hisilicon.com>
> > > Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
> > > pin
> > >
> > > On Mon, Feb 08, 2021 at 09:14:28AM +0100, David Hildenbrand wrote:
> > >
> > > > People are constantly struggling with the effects of long term pinnings
> > > > under user space control, like we already have with vfio and RDMA.
> > > >
> > > > And here we are, adding yet another, easier way to mess with core MM in
> the
> > > > same way. This feels like a step backwards to me.
> > >
> > > Yes, this seems like a very poor candidate to be a system call in this
> > > format. Much too narrow, poorly specified, and possibly security
> > > implications to allow any process whatsoever to pin memory.
> > >
> > > I keep encouraging people to explore a standard shared SVA interface
> > > that can cover all these topics (and no, uaccel is not that
> > > interface), that seems much more natural.
> > >
> > > I still haven't seen an explanation why DMA is so special here,
> > > migration and so forth jitter the CPU too, environments that care
> > > about jitter have to turn this stuff off.
> >
> > This paper has a good explanation:
> > https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7482091
> >
> > mainly because page fault can go directly to the CPU and we have
> > many CPUs. But IO Page Faults go a different way, thus mean much
> > higher latency 3-80x slower than page fault:
> > events in hardware queue -> Interrupts -> cpu processing page fault
> > -> return events to iommu/device -> continue I/O.
> 
> The justifications for this was migration scenarios and migration is
> short. If you take a fault on what you are migrating only then does it
> slow down the CPU.

I agree this can slow down CPU, but not as much as IO page fault.

On the other hand, wouldn't it be the benefit of hardware accelerators
to have a lower and more stable latency zip/encryption than CPU?

> 
> Are you also working with HW where the IOMMU becomes invalidated after
> a migration and doesn't reload?
> 
> ie not true SVA but the sort of emulated SVA we see in a lot of
> places?

Yes. It is true SVA not emulated SVA.

> 
> It would be much better to work improve that to have closer sync with the
> CPU page table than to use pinning.

Absolutely I agree improving IOPF and making IOPF catch up with the 
performance of page fault is the best way. but it would take much
long time to optimize both HW and SW. While waiting for them to
mature, probably some way which can minimize IOPF should be used to
take the responsivity.

> 
> Jason

Thanks
Barry
