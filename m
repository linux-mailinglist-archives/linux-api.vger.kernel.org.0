Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D6F339218
	for <lists+linux-api@lfdr.de>; Fri, 12 Mar 2021 16:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhCLPpk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Mar 2021 10:45:40 -0500
Received: from mx4.veeam.com ([104.41.138.86]:49884 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231789AbhCLPpT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 12 Mar 2021 10:45:19 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id BB4E1114A84;
        Fri, 12 Mar 2021 18:45:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1615563913; bh=ay5rQDiZzTT+utrO+8oIcBlw6h3n728bJRSViccZ2nw=;
        h=From:To:CC:Subject:Date:From;
        b=miu7nl73pYbNAwOnTFVd1AAqr9VBxGeSW9ETKlmzb6i0Dxgpi5B/t7J/tTJ9vFzfc
         zPZmDoWbfnyfYnjeKj+RDcRLWoF5DW1K6w23phFtpke15oFbZVHPCxe89CbdGqYM4/
         b+NvT21p4tk40WgRS8jprPUICz+ebalgOQytu6+U=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 12 Mar 2021 16:45:12 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v7 0/3] block device interposer
Date:   Fri, 12 Mar 2021 18:44:52 +0300
Message-ID: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58627366
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi all.

I'm joyful to suggest the block device interposer (bdev_interposer) v7.
bdev_interposer allows to redirect bio requests to other block devices.

In this series of patches I suggest a different implementation of the bio
interception mechanism. Now the interposer is a different block device.
Instead of an additional hook, the function fops->submit_bio() of
the interposer device is used.
This implementation greatly simplifies the application of this
bdev_interposer in device-mapper. But there is one limitation - the size
of the interposer device must be greater than or equal to the size of
the original device.

The first patch adds the function blk_mq_is_queue_frozen(). It allows to
check a queue state.

The second patch is dedicated to bdev_interposer itself, which provides
the ability to redirect bio to the interposer device.

The third one adds the DM_INTERPOSED_FLAG flag. When this flag is
applied with the ioctl DM_TABLE_LOAD_CMD, the underlying devices are
opened without the FMODE_EXCL flag and connected via bdev_interposer.

Changes in this patchset v7:
  * the request interception mechanism. Now the interposer is
    a block device that receives requests instead of the original device;
  * code design fixes.

History:
v6 - https://patchwork.kernel.org/project/linux-block/cover/1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com/
  * designed for 5.12;
  * thanks to the new design of the bio structure in v5.12, it is
    possible to perform interception not for the entire disk, but
    for each block device;
  * instead of the new ioctl DM_DEV_REMAP_CMD and the 'noexcl' option,
    the DM_INTERPOSED_FLAG flag for the ioctl DM_TABLE_LOAD_CMD is
    applied.

v5 - https://patchwork.kernel.org/project/linux-block/cover/1612881028-7878-1-git-send-email-sergei.shtepa@veeam.com/
 * rebase for v5.11-rc7;
 * patch set organization;
 * fix defects in documentation;
 * add some comments;
 * change mutex names for better code readability;
 * remove calling bd_unlink_disk_holder() for targets with non-exclusive
   flag;
 * change type for struct dm_remap_param from uint8_t to __u8.

v4 - https://patchwork.kernel.org/project/linux-block/cover/1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com/
Mostly changes were made, due to Damien's comments:
 * on the design of the code;
 * by the patch set organization;
 * bug with passing a wrong parameter to dm_get_device();
 * description of the 'noexcl' parameter in the linear.rst.
Also added remap_and_filter.rst.

v3 - https://patchwork.kernel.org/project/linux-block/cover/1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com/
In this version, I already suggested blk_interposer to apply to dm-linear.
Problems were solved:
 * Interception of bio requests from a specific device on the disk, not
   from the entire disk. To do this, we added the dm_interposed_dev
   structure and an interval tree to store these structures.
 * Implemented ioctl DM_DEV_REMAP_CMD. A patch with changes in the lvm2
   project was sent to the team lvm-devel@redhat.com.
 * Added the 'noexcl' option for dm-linear, which allows you to open
   the underlying block-device without FMODE_EXCL mode.

v2 - https://patchwork.kernel.org/project/linux-block/cover/1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com/
I tried to suggest blk_interposer without using it in device mapper,
but with the addition of a sample of its use. It was then that I learned
about the maintainers' attitudes towards the samples directory :).

v1 - https://lwn.net/ml/linux-block/20201119164924.74401-1-hare@suse.de/
This Hannes's patch can be considered as a starting point, since this is
where the interception mechanism and the term blk_interposer itself
appeared. It became clear that blk_interposer can be useful for
device mapper.

before v1 - https://patchwork.kernel.org/project/linux-block/cover/1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com/
I tried to offer a rather cumbersome blk-filter and a monster-like
blk-snap module for creating snapshots.

Thank you to everyone who was able to take the time to review
the previous versions.
I hope that this time I achieved the required quality.

Thanks,
Sergei.

Sergei Shtepa (3):
  block: add blk_mq_is_queue_frozen()
  block: add bdev_interposer
  dm: add DM_INTERPOSED_FLAG

 block/bio.c                   |  2 ++
 block/blk-core.c              | 57 ++++++++++++++++++++++++++++++++
 block/blk-mq.c                | 13 ++++++++
 block/genhd.c                 | 54 +++++++++++++++++++++++++++++++
 drivers/md/dm-core.h          |  3 ++
 drivers/md/dm-ioctl.c         | 13 ++++++++
 drivers/md/dm-table.c         | 61 +++++++++++++++++++++++++++++------
 drivers/md/dm.c               | 38 +++++++++++++++-------
 include/linux/blk-mq.h        |  1 +
 include/linux/blk_types.h     |  3 ++
 include/linux/blkdev.h        |  9 ++++++
 include/linux/device-mapper.h |  1 +
 include/uapi/linux/dm-ioctl.h |  6 ++++
 13 files changed, 240 insertions(+), 21 deletions(-)

-- 
2.20.1

