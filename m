Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E87317280
	for <lists+linux-api@lfdr.de>; Wed, 10 Feb 2021 22:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhBJVj4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Wed, 10 Feb 2021 16:39:56 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3017 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhBJVjx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Feb 2021 16:39:53 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DbY5Y0SHwzR9M9;
        Thu, 11 Feb 2021 05:37:53 +0800 (CST)
Received: from dggpemm100011.china.huawei.com (7.185.36.112) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 11 Feb 2021 05:39:09 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 05:39:09 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Thu, 11 Feb 2021 05:39:09 +0800
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
Thread-Index: AQHW/SrsWWMRpilf2UC1Pz29QqsBVqpNZGQAgACtCgCAAKKukP//jqmAgADcIzCAADaMgIABCrxAgADNm4CAALRckA==
Date:   Wed, 10 Feb 2021 21:39:09 +0000
Message-ID: <8a676b45ebaa49e8886f4bf9b762bb75@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
 <20210208213023.GZ4718@ziepe.ca>
 <0868d209d7424942a46d1238674cf75d@hisilicon.com>
 <20210209135331.GF4718@ziepe.ca>
 <2527b4ac8df14fa1b427bef65dace719@hisilicon.com>
 <20210210180405.GP4718@ziepe.ca>
In-Reply-To: <20210210180405.GP4718@ziepe.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.223]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> Sent: Thursday, February 11, 2021 7:04 AM
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
> On Tue, Feb 09, 2021 at 10:22:47PM +0000, Song Bao Hua (Barry Song) wrote:
> 
> > The problem is that SVA declares we can use any memory of a process
> > to do I/O. And in real scenarios, we are unable to customize most
> > applications to make them use the pool. So we are looking for some
> > extension generically for applications such as Nginx, Ceph.
> 
> But those applications will suffer jitter even if their are using CPU
> to do the same work. I fail to see why adding an accelerator suddenly
> means the application owner will care about jitter introduced by
> migration/etc.

The only point for this is that when migration occurs on the accelerator,
the impact/jitter is much bigger than it does on CPU. Then the accelerator
might be unhelpful.

> 
> Again in proper SVA it should be quite unlikely to take a fault caused
> by something like migration, on the same likelyhood as the CPU. If
> things are faulting so much this is a problem then I think it is a
> system level problem with doing too much page motion.

My point is that single one SVA application shouldn't require system
to make global changes, such as disabling numa balancing, disabling
THP, to decrease page fault frequency by affecting other applications.

Anyway, guys are in lunar new year. Hopefully, we are getting more
real benchmark data afterwards to make the discussion more targeted.

> 
> Jason

Thanks
Barry
