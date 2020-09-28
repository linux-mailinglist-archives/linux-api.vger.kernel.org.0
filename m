Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3514727B715
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgI1Vgn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgI1Vgn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:36:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175BCC061755;
        Mon, 28 Sep 2020 14:36:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so2389139pfn.9;
        Mon, 28 Sep 2020 14:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHiQmkkK2NJuMpdF84U1p8BgO8doyJ+ubIf1vtzVkMU=;
        b=ZvCZ0nRk+mPGK3HxzkDtiCXgRQS+HZ9mDv5od0kf5cW4cXXEytUF1TNSDrg/0qiHAJ
         gOaBO0Z9f3ZFMTVaSttSCv3jRpYCdU8sEwjJH+RAKI1I0UXWNDTLi21rlGwsHqWmQqPP
         GUDLXrexJhPthsBZaKjZ1WcemJMT6g1a0NgL4hZcmzU0pJvxh4V0G08LiAziz1mlXip7
         zJnzSeVeHCBA3a5pa2TzbkAivXN6I08OvquXGR3ApOa5qV2BIGHFuN3d78DDG0hih5ZY
         m6kDJWVMn77C6PXj84Qd0ij2w5Mm/cwtVQ54gVsUa3C/IwqbsMLOigqSXkfoT2AQTll2
         RXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHiQmkkK2NJuMpdF84U1p8BgO8doyJ+ubIf1vtzVkMU=;
        b=cB+qxVtrnq+u7CgDJkoMvZf67nsK/fa3obtzVxCnXy6N6tWIuA9VDAAVi/j69Q+fdq
         d0X8oAo5erHEqRidXU2q5gszrqNp5EBV73UNgTiGOT3RxzCJCVDuCmlS/t457E45qzkk
         WPIfda0i0FcUa6t8Dfm8FwJygLSfhZ+4f9XYZEdp5MfZRLWdJQU6I/ZYyC0gL83enB9L
         WKHydRBRxsTHATYmzKam1B/ASwNcX6qZdMNpcjGmpEWAzIcRi6jin2kZRhnUdHFtNR8a
         yVq1iVL97N8Lzj0O7Sc1RsWpiWxWsyV0NRVyJv8MzqAF5iUilEsllsD585FEVvk4rR3/
         Aj7w==
X-Gm-Message-State: AOAM532aMBJ0PYdIt0aR2LbKN7nC3BpyRz061KjbaymHj1vAJT9QU9Jc
        ac6YnZL0yRRiGDHIr3G1NFA=
X-Google-Smtp-Source: ABdhPJxdu2bPX+w7b00QUlcN/F3zpKQph9sX+X/W3d3IiEF5PpxH0ceFbZOkwxqhCiSFkNFLgbC4fA==
X-Received: by 2002:a63:f74a:: with SMTP id f10mr792980pgk.263.1601329002652;
        Mon, 28 Sep 2020 14:36:42 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:41 -0700 (PDT)
From:   Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-api@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 00/14] IOASID extensions for guest SVA
Date:   Mon, 28 Sep 2020 14:38:27 -0700
Message-Id: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

IOASID was introduced in v5.5 as a generic kernel allocator service for
both PCIe Process Address Space ID (PASID) and ARM SMMU's Sub Stream
ID. In addition to basic ID allocation, ioasid_set was defined as a
token that is shared by a group of IOASIDs. This set token can be used
for permission checking, but lack of some features to address the
following needs by guest Shared Virtual Address (SVA).
- Manage IOASIDs by group, group ownership, quota, etc.
- State synchronization among IOASID users
- Non-identity guest-host IOASID mapping
- Lifecycle management across many users

This patchset introduces the following extensions as solutions to the
problems above.
- Redefine and extend IOASID set such that IOASIDs can be managed by groups.
- Add notifications for IOASID state synchronization
- Add reference counting for life cycle alignment among users
- Support ioasid_set private IDs, which can be used as guest IOASIDs
Please refer to Documentation/ioasid.rst in enclosed patch 1/9 for more
details.

This patchset only included VT-d driver as users of some of the new APIs.
VFIO and KVM patches are coming up to fully utilize the APIs introduced
here.

You can find this series at:
https://github.com/jacobpan/linux.git ioasid_v3
(VFIO and KVM patches will be available at this branch when published.)

This work is a result of collaboration with many people:
Liu, Yi L <yi.l.liu@intel.com>
Wu Hao <hao.wu@intel.com>
Ashok Raj <ashok.raj@intel.com>
Kevin Tian <kevin.tian@intel.com>

Thanks,

Jacob

Changelog:

V3:
- Use consistent ioasid_set_ prefix for ioasid_set level APIs
- Make SPID and private detach/attach APIs symmetric
- Use the same ioasid_put semantics as Jean-Phillippe IOASID reference patch
- Take away the public ioasid_notify() function, notifications are now emitted
  by IOASID core as a result of certain IOASID APIs
- Partition into finer incremental patches
- Miscellaneous cleanup, locking, exception handling fixes based on v2 reviews

V2:
- Redesigned ioasid_set APIs, removed set ID
- Added set private ID (SPID) for guest PASID usage.
- Add per ioasid_set notification and priority support.
- Back to use spinlocks and atomic notifications.
- Added async work in VT-d driver to perform teardown outside atomic context

Jacob Pan (14):
  docs: Document IO Address Space ID (IOASID) APIs
  iommu/ioasid: Rename ioasid_set_data()
  iommu/ioasid: Add a separate function for detach data
  iommu/ioasid: Support setting system-wide capacity
  iommu/ioasid: Redefine IOASID set and allocation APIs
  iommu/ioasid: Introduce API to adjust the quota of an ioasid_set
  iommu/ioasid: Add an iterator API for ioasid_set
  iommu/ioasid: Add reference couting functions
  iommu/ioasid: Introduce ioasid_set private ID
  iommu/ioasid: Introduce notification APIs
  iommu/ioasid: Support mm type ioasid_set notifications
  iommu/vt-d: Remove mm reference for guest SVA
  iommu/vt-d: Listen to IOASID notifications
  iommu/vt-d: Store guest PASID during bind

 Documentation/driver-api/ioasid.rst | 648 ++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c         |  29 +-
 drivers/iommu/intel/pasid.h         |   1 +
 drivers/iommu/intel/svm.c           | 132 +++++-
 drivers/iommu/ioasid.c              | 890 ++++++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h         |   2 +
 include/linux/ioasid.h              | 197 +++++++-
 7 files changed, 1830 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/driver-api/ioasid.rst

-- 
2.7.4

