Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF343159A7
	for <lists+linux-api@lfdr.de>; Tue,  9 Feb 2021 23:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhBIWqd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 9 Feb 2021 17:46:33 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2895 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhBIWXs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Feb 2021 17:23:48 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DZy5p3j1qz5KDt;
        Wed, 10 Feb 2021 06:21:02 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 10 Feb 2021 06:22:48 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 06:22:47 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Wed, 10 Feb 2021 06:22:47 +0800
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
Thread-Index: AQHW/SrsWWMRpilf2UC1Pz29QqsBVqpNZGQAgACtCgCAAKKukP//jqmAgADcIzCAADaMgIABCrxA
Date:   Tue, 9 Feb 2021 22:22:47 +0000
Message-ID: <2527b4ac8df14fa1b427bef65dace719@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
 <20210208213023.GZ4718@ziepe.ca>
 <0868d209d7424942a46d1238674cf75d@hisilicon.com>
 <20210209135331.GF4718@ziepe.ca>
In-Reply-To: <20210209135331.GF4718@ziepe.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.77]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> Sent: Wednesday, February 10, 2021 2:54 AM
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
> On Tue, Feb 09, 2021 at 03:01:42AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> > On the other hand, wouldn't it be the benefit of hardware accelerators
> > to have a lower and more stable latency zip/encryption than CPU?
> 
> No, I don't think so.

Fortunately or unfortunately, I think my people have this target to have
a lower-latency and more stable zip/encryption by using accelerators,
otherwise, they are going to use CPU directly if there is no advantage
of accelerators.

> 
> If this is an important problem then it should apply equally to CPU
> and IO jitter.
> 
> Honestly I find the idea that occasional migration jitters CPU and DMA
> to not be very compelling. Such specialized applications should
> allocate special pages to avoid this, not adding an API to be able to
> lock down any page

That is exactly what we have done to provide a hugeTLB pool so that
applications can allocate memory from this pool.

+-------------------------------------------+
 |                                           |
 |applications using accelerators            |
 +-------------------------------------------+


     alloc from pool             free to pool
           +                      ++
           |                       |
           |                       |
           |                       |
           |                       |
           |                       |
           |                       |
           |                       |
+----------+-----------------------+---------+
|                                            |
|                                            |
|      HugeTLB memory pool                   |
|                                            |
|                                            |
+--------------------------------------------+

The problem is that SVA declares we can use any memory of a process
to do I/O. And in real scenarios, we are unable to customize most
applications to make them use the pool. So we are looking for some
extension generically for applications such as Nginx, Ceph.

I am also thinking about leveraging vm.compact_unevictable_allowed
which David suggested and making an extension on it, for example,
permit users to disable compaction and numa balancing on unevictable
pages of SVA process,  which might be a smaller deal.

> 
> Jason

Thanks
Barry

