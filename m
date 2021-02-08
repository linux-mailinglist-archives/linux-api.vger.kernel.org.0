Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0179B312A20
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 06:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhBHFfK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 8 Feb 2021 00:35:10 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2825 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBHFfK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Feb 2021 00:35:10 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DYvmB4nCwz13rcr;
        Mon,  8 Feb 2021 13:32:10 +0800 (CST)
Received: from dggpemm100012.china.huawei.com (7.185.36.212) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 8 Feb 2021 13:34:23 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm100012.china.huawei.com (7.185.36.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 13:34:23 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 13:34:23 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     David Rientjes <rientjes@google.com>
CC:     Matthew Wilcox <willy@infradead.org>,
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
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
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
Thread-Index: AQHW/SrsWWMRpilf2UC1Pz29QqsBVqpMsX2AgACQE1D//789gIAAtGdg
Date:   Mon, 8 Feb 2021 05:34:23 +0000
Message-ID: <9343d5ebeff3423c8055323fe83a0796@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <20210207213409.GL308988@casper.infradead.org>
 <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
 <90aca1e9-61b5-88d-d28c-369e6973559e@google.com>
In-Reply-To: <90aca1e9-61b5-88d-d28c-369e6973559e@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.200]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> -----Original Message-----
> From: David Rientjes [mailto:rientjes@google.com]
> Sent: Monday, February 8, 2021 3:18 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Matthew Wilcox <willy@infradead.org>; Wangzhou (B)
> <wangzhou1@hisilicon.com>; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-mm@kvack.org;
> linux-arm-kernel@lists.infradead.org; linux-api@vger.kernel.org; Andrew
> Morton <akpm@linux-foundation.org>; Alexander Viro <viro@zeniv.linux.org.uk>;
> gregkh@linuxfoundation.org; jgg@ziepe.ca; kevin.tian@intel.com;
> jean-philippe@linaro.org; eric.auger@redhat.com; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>; zhangfei.gao@linaro.org; chensihang (A)
> <chensihang1@hisilicon.com>
> Subject: RE: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
> pin
> 
> On Sun, 7 Feb 2021, Song Bao Hua (Barry Song) wrote:
> 
> > NUMA balancer is just one of many reasons for page migration. Even one
> > simple alloc_pages() can cause memory migration in just single NUMA
> > node or UMA system.
> >
> > The other reasons for page migration include but are not limited to:
> > * memory move due to CMA
> > * memory move due to huge pages creation
> >
> > Hardly we can ask users to disable the COMPACTION, CMA and Huge Page
> > in the whole system.
> >
> 
> What about only for mlocked memory, i.e. disable
> vm.compact_unevictable_allowed?
> 
> Adding syscalls is a big deal, we can make a reasonable inference that
> we'll have to support this forever if it's merged.  I haven't seen mention
> of what other unevictable memory *should* be migratable that would be
> adversely affected if we disable that sysctl.  Maybe that gets you part of
> the way there and there are some other deficiencies, but it seems like a
> good start would be to describe how CONFIG_NUMA_BALANCING=n +
> vm.compact_unevcitable_allowed + mlock() doesn't get you mostly there and
> then look into what's missing.
> 

I believe it can resolve the performance problem for the SVA
applications if we disable vm.compact_unevcitable_allowed and
NUMA_BALANCE, and use mlock().

The problem is that it is insensible to ask users to disable
unevictable_allowed or numa balancing of the whole system
only because there is one SVA application in the system.

SVA, for itself, is a mechanism to let cpu and devices share same
address space. In a typical server system, there are many processes,
the better way would be only changing the behavior of the specific
process rather than changing the whole system. It is hard to ask
users to do that only because there is a SVA monster.
Plus, this might negatively affect those applications not using SVA.

> If it's a very compelling case where there simply are no alternatives, it
> would make sense.  Alternative is to find a more generic way, perhaps in
> combination with vm.compact_unevictable_allowed, to achieve what you're
> looking to do that can be useful even beyond your originally intended use
> case.

sensible. Actually pin is exactly the way to disable migration for specific
pages AKA. disabling "vm.compact_unevictable_allowed" on those pages.

It is hard to differentiate what pages should not be migrated. Only apps
know that as even SVA applications can allocate many non-IO pages which
should be able to move.

Thanks
Barry
