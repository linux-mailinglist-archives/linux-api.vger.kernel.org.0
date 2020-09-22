Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416622749DA
	for <lists+linux-api@lfdr.de>; Tue, 22 Sep 2020 22:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIVUPd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Sep 2020 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIVUPd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Sep 2020 16:15:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A87BC061755;
        Tue, 22 Sep 2020 13:15:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so13487993pff.6;
        Tue, 22 Sep 2020 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hn6et9LbYd8DuVyzW2thhcz6VZuD8GdG4uKwbIXOb50=;
        b=L1rUdoLclGSVBza/7wOpYY8ml/ZUxKH4wjY5LU820mOjsxd04jcg+HlQCmL179hWO2
         JvQgv7YapT+ocwEE4i8l8H7G1tULRf7itL6VvemEh1TLT0w0uLIA6ZAd8L/TXIb7gn0m
         oZXfdSWFv0vZoiU/lqVHLT/bGrVxbVejElaf+26Yne/a0kz+M83FclZ6VvimMuUSLuk3
         hyIMU+42B4aHSuvFAAvIvwXYIPxqDOYlGKggmpQcyn6BWTPYJsKHyxUEbL2oNiS6qzIo
         oN36BxQtB4xg+9LTgMJy17o8gnmzA1KxTZ4ZzJNo/6ffyucwbigoEAT6aXiFxrMfyGHB
         HiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hn6et9LbYd8DuVyzW2thhcz6VZuD8GdG4uKwbIXOb50=;
        b=OTWMW+2XV3okRhStDY7cBujHof+IVrphLSPjZK9HF3Gb7HcGHHEIJkocJeWceXf16K
         bRSj3mfu01pYIVUh3b90vieh/9/Gxvkl1NXzLsQn2Ib0nM853/VibvljpzotfENNVjXr
         Rhm9C+lYlV1xk4POhPbFGGTChOpAlJBoj3PPS0n73Vy99PtqGgxw+KHAXnZud0Tm82cT
         F9QcQQDEpbpBmw2wHLghYIOeoUvDSyxwAJtcPJmGgkekW5yoC/XR9qPKFA8CMsVAt6mC
         YI2CJK9O4I3PO/Ee5TCc/hvFQEPoW2OrdH7Fmy+mDKKndccPWRF44gAThPR69nildDaU
         SpFQ==
X-Gm-Message-State: AOAM533Kqy9Jmmh68ydkROlOqYDaq1/wOH0e4YdQruC0jVEm3n+Ga/Tr
        +/rtc59UNKJOgZ86LT7gM+t743bnxo0=
X-Google-Smtp-Source: ABdhPJzEPDUhfqu6NbM4GZAuqgCh4rpYrCNwa9Rrcdh9kGjLXyYxyeXhqo7dh8JiTyamXowx9V1Gwg==
X-Received: by 2002:a17:902:a402:b029:d2:21a:d994 with SMTP id p2-20020a170902a402b02900d2021ad994mr6196232plq.52.1600805732950;
        Tue, 22 Sep 2020 13:15:32 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id e10sm15793028pgb.45.2020.09.22.13.15.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:15:32 -0700 (PDT)
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
        Yi Sun <yi.y.sun@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v10 0/7] IOMMU user API enhancement
Date:   Tue, 22 Sep 2020 13:16:55 -0700
Message-Id: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

IOMMU user API header was introduced to support nested DMA translation and
related fault handling. The current UAPI data structures consist of three
areas that cover the interactions between host kernel and guest:
 - fault handling
 - cache invalidation
 - bind guest page tables, i.e. guest PASID

Future extensions are likely to support more architectures and vIOMMU features.

In the previous discussion, using user-filled data size and feature flags is
made a preferred approach over a unified version number.
https://lkml.org/lkml/2020/1/29/45

In addition to introduce argsz field to data structures, this patchset is also
trying to document the UAPI design, usage, and extension rules. VT-d driver
changes to utilize the new argsz field is included, VFIO usage is to follow.

This set is available at:
https://github.com/jacobpan/linux.git vsva_v5.9_uapi_v10

Thanks,

Jacob


Changelog:
v10
	- Documentation grammar fixes based on Randy's review
v9
	- Directly pass PASID value to iommu_sva_unbind_gpasid() without
	  the superfluous data in struct iommu_gpasid_bind_data.
v8
	- Rebased to v5.9-rc2
	- Addressed review comments from Eric Auger
	  1. added a check for the unused vendor flags
	  2. commit message improvements
v7
	- Added PASID data format enum for range checking
	- Tidy up based on reviews from Alex W.
	- Removed doc section for vIOMMU fault handling
v6
	- Renamed all UAPI functions with iommu_uapi_ prefix
	- Replaced argsz maxsz checking with flag specific size checks
	- Documentation improvements based on suggestions by Eric Auger
	  Replaced example code with a pointer to the actual code
	- Added more checks for illegal flags combinations
	- Added doc file to MAINTAINERS
v5
	- Addjusted paddings in UAPI data to be 8 byte aligned
	- Do not clobber argsz in IOMMU core before passing on to vendor driver
	- Removed pr_warn_ for invalid UAPI data check, just return -EINVAL
	- Clarified VFIO responsibility in UAPI data handling
	- Use iommu_uapi prefix to differentiate APIs has in-kernel caller
	- Added comment for unchecked flags of invalidation granularity
	- Added example in doc to show vendor data checking

v4
	- Added checks of UAPI data for reserved fields, version, and flags.
	- Removed version check from vendor driver (vt-d)
	- Relaxed argsz check to match the UAPI struct size instead of variable
	  union size
	- Updated documentation

v3:
	- Rewrote backward compatibility rule to support existing code
	  re-compiled with newer kernel UAPI header that runs on older
	  kernel. Based on review comment from Alex W.
	  https://lore.kernel.org/linux-iommu/20200611094741.6d118fa8@w520.home/
	- Take user pointer directly in UAPI functions. Perform argsz check
	  and copy_from_user() in IOMMU driver. Eliminate the need for
	  VFIO or other upper layer to parse IOMMU data.
	- Create wrapper function for in-kernel users of UAPI functions
v2:
	- Removed unified API version and helper
	- Introduced argsz for each UAPI data
	- Introduced UAPI doc


Jacob Pan (7):
  docs: IOMMU user API
  iommu/uapi: Add argsz for user filled data
  iommu/uapi: Introduce enum type for PASID data format
  iommu/uapi: Use named union for user data
  iommu/uapi: Rename uapi functions
  iommu/uapi: Handle data and argsz filled by users
  iommu/vt-d: Check UAPI data processed by IOMMU core

 Documentation/userspace-api/iommu.rst | 210 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 drivers/iommu/intel/iommu.c           |  25 ++--
 drivers/iommu/intel/svm.c             |  13 ++-
 drivers/iommu/iommu.c                 | 201 ++++++++++++++++++++++++++++++--
 include/linux/iommu.h                 |  35 ++++--
 include/uapi/linux/iommu.h            |  25 ++--
 7 files changed, 467 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/userspace-api/iommu.rst

-- 
2.7.4

