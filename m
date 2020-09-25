Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F6F278E7B
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgIYQaw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIYQaw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Sep 2020 12:30:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D00CC0613CE;
        Fri, 25 Sep 2020 09:30:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t7so2094666pjd.3;
        Fri, 25 Sep 2020 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TjJK6XN5jlS9wkc7N97gyRXrkYGGb2wNNiD+ZxlnoDY=;
        b=Ytu1IT20bjPDOrxeMxT5l67LMIda5L5usR+fLSz8zC/ivopJkNvACGbl8N6Wx0/IwV
         qGa3dIY5oUQFKYGL43bmVCEIir1FD9+TADuLMOFkrOhcbD4utnlupFIPhh9vDYQf1doP
         AaiRwttnDGpJVCWzqUsWicV51z9GU9oX+IXnCWL4btbQCNMwwk/ULht+Zy86Spi1xmLn
         3R8bW7wzSXMcS3niDevXzeijrzotWpfLWvctPqyk2RohEFas/IZawJVF0IDOXFsNVU+V
         Q/Od4zBV3N8wJF7+GRVWNLLBuQ593w9doO1vIo988UooNCggYD66TxdTI1hH58ERW6lP
         Ny4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TjJK6XN5jlS9wkc7N97gyRXrkYGGb2wNNiD+ZxlnoDY=;
        b=Y8iuOwOQjWrHMrbASVnfVnxpIV3aA7IHvrW9+htVwxzW5NCVEoeRYcQw5IJC2uwZ84
         cHwfhp3I7pSmjIR+Kd1yaDNgHqc2EUHeCDGceJj243Lb1RVHprCyidnKQmlGTBiQzjo/
         ldsmsgPWKd5y0RIzJJpzUxwX61DfUYUf7cSimQXEjPkqQYPGfFOGuC4gj6FsWtbCKJs+
         88K4s75PKPzqYDt0n468QhqcKI4RqlP7JHj2ehob9x4qtH+dAK+PC8c0jofxRJ827XsU
         JVg45FZf3CzSlMdHNjlEhsiSGLs2Vfmdn9X6dEMfjAIx7MP60E6l36GF0x0pQ8lqXVB8
         KX2w==
X-Gm-Message-State: AOAM532LHNiez/4vmZ82OgP+blQuZ/gXcaobSx5QFB7Rd+GqUdQuTbrE
        dqF9ZjoEN2XrJbPgREpDAJ8=
X-Google-Smtp-Source: ABdhPJw9WV8IFgqFgR7/YTd9vFzMCOePTuSLuRR93fCwMzasZmyOHxVnFzGm952RNmAwPYx7+Wd0gA==
X-Received: by 2002:a17:90b:f0b:: with SMTP id br11mr380158pjb.191.1601051451563;
        Fri, 25 Sep 2020 09:30:51 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id j19sm3197039pfe.108.2020.09.25.09.30.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 09:30:50 -0700 (PDT)
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
Subject: [PATCH v12 0/6] IOMMU user API enhancement
Date:   Fri, 25 Sep 2020 09:32:41 -0700
Message-Id: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
https://github.com/jacobpan/linux.git vsva_v5.9_uapi_v12

Thanks,

Jacob


Changelog:
v12
	- Removed a redundant check in cache invalidate API
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
 drivers/iommu/iommu.c                 | 196 +++++++++++++++++++++++++++++--
 include/linux/iommu.h                 |  35 ++++--
 include/uapi/linux/iommu.h            |  18 ++-
 7 files changed, 456 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/userspace-api/iommu.rst

-- 
2.7.4

