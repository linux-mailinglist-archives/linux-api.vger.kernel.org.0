Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B9727B4E7
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgI1TAw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 15:00:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:21559 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgI1TAw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 28 Sep 2020 15:00:52 -0400
IronPort-SDR: 8o7EDK0c9ZAxylgnD5n/vrLTviF24O4nwtxAWQSFp0lPiPtQHq0y0Ti80GMaOiIzUFzmIQDiPH
 A3BG93+TEFSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="142060597"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="142060597"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 11:38:46 -0700
IronPort-SDR: JExQWT9GytmoqUJjWWfoYiFWm2ROgswGk82oXhpKsrogI/lX+XzPT5+ZNvBpVwls4DrM/WjH9G
 3eMVhQSaIUzg==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="311889478"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 11:38:45 -0700
Date:   Mon, 28 Sep 2020 11:40:53 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jacob Pan <jacob.pan.linux@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v12 0/6] IOMMU user API enhancement
Message-ID: <20200928114053.79170d23@jacob-builder>
In-Reply-To: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Joerg,

Just wondering if you will be able to take this for v5.10? There hasn't
been any material changes since we last discussed in LPC. We have VFIO and
other vSVA patches depending on it.

Thanks!

Jacob 

On Fri, 25 Sep 2020 09:32:41 -0700, Jacob Pan <jacob.pan.linux@gmail.com>
wrote:

> IOMMU user API header was introduced to support nested DMA translation and
> related fault handling. The current UAPI data structures consist of three
> areas that cover the interactions between host kernel and guest:
>  - fault handling
>  - cache invalidation
>  - bind guest page tables, i.e. guest PASID
> 
> Future extensions are likely to support more architectures and vIOMMU
> features.
> 
> In the previous discussion, using user-filled data size and feature flags
> is made a preferred approach over a unified version number.
> https://lkml.org/lkml/2020/1/29/45
> 
> In addition to introduce argsz field to data structures, this patchset is
> also trying to document the UAPI design, usage, and extension rules. VT-d
> driver changes to utilize the new argsz field is included, VFIO usage is
> to follow.
> 
> This set is available at:
> https://github.com/jacobpan/linux.git vsva_v5.9_uapi_v12
> 
> Thanks,
> 
> Jacob
> 
> 
> Changelog:
> v12
> 	- Removed a redundant check in cache invalidate API
> v11
> 	- Use #define instead of enum in PASID data format, squashed
> change into "iommu/uapi: Handle data and argsz filled by users"
> 	- Remove alloc/free from documentation per Yi's comment. IOMMU
> UAPI does not perform IOASID alloc/free.
> v10
> 	- Documentation grammar fixes based on Randy's review
> v9
> 	- Directly pass PASID value to iommu_sva_unbind_gpasid() without
> 	  the superfluous data in struct iommu_gpasid_bind_data.
> v8
> 	- Rebased to v5.9-rc2
> 	- Addressed review comments from Eric Auger
> 	  1. added a check for the unused vendor flags
> 	  2. commit message improvements
> v7
> 	- Added PASID data format enum for range checking
> 	- Tidy up based on reviews from Alex W.
> 	- Removed doc section for vIOMMU fault handling
> v6
> 	- Renamed all UAPI functions with iommu_uapi_ prefix
> 	- Replaced argsz maxsz checking with flag specific size checks
> 	- Documentation improvements based on suggestions by Eric Auger
> 	  Replaced example code with a pointer to the actual code
> 	- Added more checks for illegal flags combinations
> 	- Added doc file to MAINTAINERS
> v5
> 	- Addjusted paddings in UAPI data to be 8 byte aligned
> 	- Do not clobber argsz in IOMMU core before passing on to vendor
> driver
> 	- Removed pr_warn_ for invalid UAPI data check, just return
> -EINVAL
> 	- Clarified VFIO responsibility in UAPI data handling
> 	- Use iommu_uapi prefix to differentiate APIs has in-kernel caller
> 	- Added comment for unchecked flags of invalidation granularity
> 	- Added example in doc to show vendor data checking
> 
> v4
> 	- Added checks of UAPI data for reserved fields, version, and
> flags.
> 	- Removed version check from vendor driver (vt-d)
> 	- Relaxed argsz check to match the UAPI struct size instead of
> variable union size
> 	- Updated documentation
> 
> v3:
> 	- Rewrote backward compatibility rule to support existing code
> 	  re-compiled with newer kernel UAPI header that runs on older
> 	  kernel. Based on review comment from Alex W.
> 	  https://lore.kernel.org/linux-iommu/20200611094741.6d118fa8@w520.home/
> 	- Take user pointer directly in UAPI functions. Perform argsz
> check and copy_from_user() in IOMMU driver. Eliminate the need for
> 	  VFIO or other upper layer to parse IOMMU data.
> 	- Create wrapper function for in-kernel users of UAPI functions
> v2:
> 	- Removed unified API version and helper
> 	- Introduced argsz for each UAPI data
> 	- Introduced UAPI doc
> 
> 
> Jacob Pan (6):
>   docs: IOMMU user API
>   iommu/uapi: Add argsz for user filled data
>   iommu/uapi: Use named union for user data
>   iommu/uapi: Rename uapi functions
>   iommu/uapi: Handle data and argsz filled by users
>   iommu/vt-d: Check UAPI data processed by IOMMU core
> 
>  Documentation/userspace-api/iommu.rst | 209
> ++++++++++++++++++++++++++++++++++ MAINTAINERS
> |   1 + drivers/iommu/intel/iommu.c           |  25 ++--
>  drivers/iommu/intel/svm.c             |  13 ++-
>  drivers/iommu/iommu.c                 | 196
> +++++++++++++++++++++++++++++-- include/linux/iommu.h                 |
> 35 ++++-- include/uapi/linux/iommu.h            |  18 ++-
>  7 files changed, 456 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/userspace-api/iommu.rst
> 


Thanks,

Jacob
