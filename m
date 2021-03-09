Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5D9331F24
	for <lists+linux-api@lfdr.de>; Tue,  9 Mar 2021 07:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhCIGWZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 01:22:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13875 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhCIGWY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Mar 2021 01:22:24 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DvlSc1YQGz8vRm;
        Tue,  9 Mar 2021 14:20:32 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Mar 2021 14:22:11 +0800
From:   Shenming Lu <lushenming@huawei.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-api@vger.kernel.org>
CC:     Kevin Tian <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        <zhukeqian1@huawei.com>, <lushenming@huawei.com>
Subject: [RFC PATCH v2 0/6] Add IOPF support for VFIO passthrough
Date:   Tue, 9 Mar 2021 14:22:01 +0800
Message-ID: <20210309062207.505-1-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.184.135]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

The static pinning and mapping problem in VFIO and possible solutions
have been discussed a lot [1, 2]. One of the solutions is to add I/O
page fault support for VFIO devices. Different from those relatively
complicated software approaches such as presenting a vIOMMU that provides
the DMA buffer information (might include para-virtualized optimizations),
IOPF mainly depends on the hardware faulting capability, such as the PCIe
PRI extension or Arm SMMU stall model. What's more, the IOPF support in
the IOMMU driver is being implemented in SVA [3]. So we add IOPF support
for VFIO passthrough based on the IOPF part of SVA in this series.

We have measured its performance with UADK [4] (passthrough an accelerator
to a VM) on Hisilicon Kunpeng920 board:

Run hisi_sec_test...
 - with varying message lengths and sending times
 - with/without stage 2 IOPF enabled

when msg_len = 1MB and PREMAP_LEN (in patch 3) = 1:
           speed (KB/s)
 times     w/o IOPF        with IOPF (num of faults)        degradation
 1         325596          119152 (518)                     36.6%
 100       7524985         5804659 (1058)                   77.1%
 1000      8661817         8440209 (1071)                   97.4%
 5000      8804512         8724368 (1216)                   99.1%

If we use the same region to send messages, since page faults occur almost
only when first accessing, more times, less degradation.

when msg_len = 10MB and PREMAP_LEN = 512:
           speed (KB/s)
 times     w/o IOPF        with IOPF (num of faults)        degradation
 1         1012758         682257 (13)                      67.4%
 100       8680688         8374154 (26)                     96.5%
 1000      8860861         8719918 (26)                     98.4%

We see that pre-mapping can help.

And we also measured the performance of host SVA with the same params:

when msg_len = 1MB:
           speed (KB/s)
 times     w/o IOPF        with IOPF (num of faults)        degradation
 1         951672          163866 (512)                     17.2%
 100       8691961         4529971 (1024)                   52.1%
 1000      9158721         8376346 (1024)                   91.5%
 5000      9184532         9008739 (1024)                   98.1%

Besides, the avg time spent in vfio_iommu_dev_fault_handler() (in patch 3)
is little less than iopf_handle_group() (in SVA) (1.6 us vs 2.0 us).

History:

v1 -> v2
 - Numerous improvements following the suggestions. Thanks a lot to all
   of you.

Yet TODO:
 - Add support for PRI.
 - Consider selective-faulting. (suggested by Kevin)
 ...

Links:
[1] Lesokhin I, et al. Page Fault Support for Network Controllers. In ASPLOS,
    2016.
[2] Tian K, et al. coIOMMU: A Virtual IOMMU with Cooperative DMA Buffer Tracking
    for Efficient Memory Management in Direct I/O. In USENIX ATC, 2020.
[3] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210302092644.2553014-1-jean-philippe@linaro.org/
[4] https://github.com/Linaro/uadk

Any comments and suggestions are very welcome. :-)

Thanks,
Shenming


Shenming Lu (6):
  iommu: Evolve to support more scenarios of using IOPF
  vfio: Add an MMU notifier to avoid pinning
  vfio: Add a page fault handler
  vfio: VFIO_IOMMU_ENABLE_IOPF
  vfio: No need to statically pin and map if IOPF enabled
  vfio: Add nested IOPF support

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  11 +-
 drivers/iommu/io-pgfault.c                    |   4 -
 drivers/iommu/iommu.c                         |  56 ++-
 drivers/vfio/vfio.c                           | 118 +++++
 drivers/vfio/vfio_iommu_type1.c               | 446 +++++++++++++++++-
 include/linux/iommu.h                         |  21 +-
 include/linux/vfio.h                          |  14 +
 include/uapi/linux/iommu.h                    |   3 +
 include/uapi/linux/vfio.h                     |   6 +
 10 files changed, 661 insertions(+), 21 deletions(-)

-- 
2.19.1

