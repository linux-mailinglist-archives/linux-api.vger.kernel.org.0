Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8748B277917
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 21:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgIXTWg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 15:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgIXTWg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 15:22:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D603C0613CE;
        Thu, 24 Sep 2020 12:22:36 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so287833pjb.4;
        Thu, 24 Sep 2020 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JunQ1snjd9uj+r15M0gcbEm818SqQdfTuxCT2fUorJc=;
        b=nUs9HIfRvflse5Vo11G4iuMS99icrGDqiH/iskFQ6GYBN+1qjS+vgqhyeIjVx9AtrJ
         NVD5ZaQDZYK+pzm7u3YaCA62iOUcrgG7ALteynaIP9G5h/x/djphzDIZItSEejmvkqYL
         TgT1xI5vzHEwaKijIv44pNUD3wiOHrgrTxYOj4ckEEvJVGsb0NxarU7WmrMFDXor3nCS
         Z5IwgElqKZCqo9JlmGrYri2+PK4UIT6tC3B+rxWkENZWUWy+5g38D9N7sf3JqOVud06l
         DW0aLhROGgCqZtkx0vOs2wNtD24rflBHayGEVoxYNlCNX1ObmfRGm090fppsu8M7bB2i
         ps4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JunQ1snjd9uj+r15M0gcbEm818SqQdfTuxCT2fUorJc=;
        b=W3QvSBjPsDN4/UG41avc+d0U5ua4kBgNnPQf5PIbOs8fwriTylHXWJK8hjM6IIfm4A
         cGx9fIQLZrlHQuJH2Y1CDz8Ou0oaAJBNZUq7uleDYcstKEmXKRMgIxevJzIgv4R41IR9
         uSOGBFOGqNRav6FtVd1sYDdWQlRc7ZOZmWyaY1pQA+alUF7XlSYKLBklK1/hZvTTIUUa
         VGTROovVqKlLpAsQfSjY2i8bPs6xGfMb+ytqHoC24mkLKqZS3lBIaSmbC7xdOvZTBtIE
         Y4JgiI2jbKFLx8woOelMVj6KwC/MLQ5SZlwC4QwYVrV71hGz3U+5k395t2d+8cCi7I0B
         jABQ==
X-Gm-Message-State: AOAM532M6SO53eYbh7HSgUGtSXcnqCQbUsjAxezPRoiDeplEuiRmlutw
        PGXy78ovmSD0yDtuzI/aHQOTWO1F88M=
X-Google-Smtp-Source: ABdhPJx5IXV28i4bSJJjnskBx9ph7zUW+tF9/ITXvxgR4Ovrtt3mNFJyN2tWDB/4NmHjPbghdTNSXA==
X-Received: by 2002:a17:90a:9317:: with SMTP id p23mr414571pjo.160.1600975355815;
        Thu, 24 Sep 2020 12:22:35 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id o15sm140918pgi.74.2020.09.24.12.22.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:22:34 -0700 (PDT)
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
Subject: [PATCH v11 0/6] IOMMU user API enhancement
Date:   Thu, 24 Sep 2020 12:24:14 -0700
Message-Id: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
https://github.com/jacobpan/linux.git vsva_v5.9_uapi_v11

Thanks,

Jacob


Changelog:
v11
	- Use #define instead of enum in PASID data format, squashed change
	  into "iommu/uapi: Handle data and argsz filled by users"
	- Remove alloc/free from documentation per Yi's comment. IOMMU UAPI
	  does not perform IOASID alloc/free.
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

Jacob Pan (6):
  docs: IOMMU user API
  iommu/uapi: Add argsz for user filled data
  iommu/uapi: Use named union for user data
  iommu/uapi: Rename uapi functions
  iommu/uapi: Handle data and argsz filled by users
  iommu/vt-d: Check UAPI data processed by IOMMU core

 Documentation/userspace-api/iommu.rst | 209 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 drivers/iommu/intel/iommu.c           |  25 ++--
 drivers/iommu/intel/svm.c             |  13 ++-
 drivers/iommu/iommu.c                 | 201 ++++++++++++++++++++++++++++++--
 include/linux/iommu.h                 |  35 ++++--
 include/uapi/linux/iommu.h            |  18 ++-
 7 files changed, 461 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/userspace-api/iommu.rst

-- 
2.7.4

