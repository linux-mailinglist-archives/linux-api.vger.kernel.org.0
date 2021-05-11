Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7940037A5C5
	for <lists+linux-api@lfdr.de>; Tue, 11 May 2021 13:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhEKLbU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 May 2021 07:31:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2776 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhEKLbT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 May 2021 07:31:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfbGx73YHzmgJV;
        Tue, 11 May 2021 19:26:49 +0800 (CST)
Received: from [10.174.184.135] (10.174.184.135) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 19:30:02 +0800
Subject: Re: [RFC PATCH v3 0/8] Add IOPF support for VFIO passthrough
From:   Shenming Lu <lushenming@huawei.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Cornelia Huck <cohuck@redhat.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-api@vger.kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Barry Song" <song.bao.hua@hisilicon.com>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <cb9584fd-c7f5-8cac-8c63-219ded2ef9db@huawei.com>
Message-ID: <b7fbb6a3-8777-d46a-af6c-5b3243e8b00c@huawei.com>
Date:   Tue, 11 May 2021 19:30:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <cb9584fd-c7f5-8cac-8c63-219ded2ef9db@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.135]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Alex,

Hope for some suggestions or comments from you since there seems to be many unsure
points in this series. :-)

Thanks,
Shenming


On 2021/4/26 9:41, Shenming Lu wrote:
> On 2021/4/9 11:44, Shenming Lu wrote:
>> Hi,
>>
>> Requesting for your comments and suggestions. :-)
> 
> Kind ping...
> 
>>
>> The static pinning and mapping problem in VFIO and possible solutions
>> have been discussed a lot [1, 2]. One of the solutions is to add I/O
>> Page Fault support for VFIO devices. Different from those relatively
>> complicated software approaches such as presenting a vIOMMU that provides
>> the DMA buffer information (might include para-virtualized optimizations),
>> IOPF mainly depends on the hardware faulting capability, such as the PCIe
>> PRI extension or Arm SMMU stall model. What's more, the IOPF support in
>> the IOMMU driver has already been implemented in SVA [3]. So we add IOPF
>> support for VFIO passthrough based on the IOPF part of SVA in this series.
>>
>> We have measured its performance with UADK [4] (passthrough an accelerator
>> to a VM(1U16G)) on Hisilicon Kunpeng920 board (and compared with host SVA):
>>
>> Run hisi_sec_test...
>>  - with varying sending times and message lengths
>>  - with/without IOPF enabled (speed slowdown)
>>
>> when msg_len = 1MB (and PREMAP_LEN (in Patch 4) = 1):
>>             slowdown (num of faults)
>>  times      VFIO IOPF      host SVA
>>  1          63.4% (518)    82.8% (512)
>>  100        22.9% (1058)   47.9% (1024)
>>  1000       2.6% (1071)    8.5% (1024)
>>
>> when msg_len = 10MB (and PREMAP_LEN = 512):
>>             slowdown (num of faults)
>>  times      VFIO IOPF
>>  1          32.6% (13)
>>  100        3.5% (26)
>>  1000       1.6% (26)
>>
>> History:
>>
>> v2 -> v3
>>  - Nit fixes.
>>  - No reason to disable reporting the unrecoverable faults. (baolu)
>>  - Maintain a global IOPF enabled group list.
>>  - Split the pre-mapping optimization to be a separate patch.
>>  - Add selective faulting support (use vfio_pin_pages to indicate the
>>    non-faultable scope and add a new struct vfio_range to record it,
>>    untested). (Kevin)
>>
>> v1 -> v2
>>  - Numerous improvements following the suggestions. Thanks a lot to all
>>    of you.
>>
>> Note that PRI is not supported at the moment since there is no hardware.
>>
>> Links:
>> [1] Lesokhin I, et al. Page Fault Support for Network Controllers. In ASPLOS,
>>     2016.
>> [2] Tian K, et al. coIOMMU: A Virtual IOMMU with Cooperative DMA Buffer Tracking
>>     for Efficient Memory Management in Direct I/O. In USENIX ATC, 2020.
>> [3] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210401154718.307519-1-jean-philippe@linaro.org/
>> [4] https://github.com/Linaro/uadk
>>
>> Thanks,
>> Shenming
>>
>>
>> Shenming Lu (8):
>>   iommu: Evolve the device fault reporting framework
>>   vfio/type1: Add a page fault handler
>>   vfio/type1: Add an MMU notifier to avoid pinning
>>   vfio/type1: Pre-map more pages than requested in the IOPF handling
>>   vfio/type1: VFIO_IOMMU_ENABLE_IOPF
>>   vfio/type1: No need to statically pin and map if IOPF enabled
>>   vfio/type1: Add selective DMA faulting support
>>   vfio: Add nested IOPF support
>>
>>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |    3 +-
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   18 +-
>>  drivers/iommu/iommu.c                         |   56 +-
>>  drivers/vfio/vfio.c                           |   85 +-
>>  drivers/vfio/vfio_iommu_type1.c               | 1000 ++++++++++++++++-
>>  include/linux/iommu.h                         |   19 +-
>>  include/linux/vfio.h                          |   13 +
>>  include/uapi/linux/iommu.h                    |    4 +
>>  include/uapi/linux/vfio.h                     |    6 +
>>  9 files changed, 1181 insertions(+), 23 deletions(-)
>>
