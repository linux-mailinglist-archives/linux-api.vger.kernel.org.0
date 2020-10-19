Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67581292BB8
	for <lists+linux-api@lfdr.de>; Mon, 19 Oct 2020 18:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgJSQtI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Oct 2020 12:49:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:43066 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729849AbgJSQtH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 19 Oct 2020 12:49:07 -0400
IronPort-SDR: 8eizNy1edeSbwonaVamyZky/0WXY7ioazpSosnkjJUx8kkQAGccePPBr1XF27F06Sl5hGUufBe
 36bz6U3j4aRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="146359033"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="146359033"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 09:49:06 -0700
IronPort-SDR: oiK2RFjYHsNVVqZa6B8pgPwSyVV0MbY1DxgphPSU3WzJPjycIhZxMhTyTE6I4R+NIZUgpRmeqd
 wQ4uJo9Bj3EQ==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="320336768"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 09:49:06 -0700
Date:   Mon, 19 Oct 2020 09:51:25 -0700
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
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 00/14] IOASID extensions for guest SVA
Message-ID: <20201019095125.291915b2@jacob-builder>
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

Any comments on this? I know we have some opens w.r.t. PASID management
UAPI, but I think having this common kernel API features should be
justified.

Thanks!

Jacob


On Mon, 28 Sep 2020 14:38:27 -0700, Jacob Pan <jacob.pan.linux@gmail.com>
wrote:

> IOASID was introduced in v5.5 as a generic kernel allocator service for
> both PCIe Process Address Space ID (PASID) and ARM SMMU's Sub Stream
> ID. In addition to basic ID allocation, ioasid_set was defined as a
> token that is shared by a group of IOASIDs. This set token can be used
> for permission checking, but lack of some features to address the
> following needs by guest Shared Virtual Address (SVA).
> - Manage IOASIDs by group, group ownership, quota, etc.
> - State synchronization among IOASID users
> - Non-identity guest-host IOASID mapping
> - Lifecycle management across many users
> 
> This patchset introduces the following extensions as solutions to the
> problems above.
> - Redefine and extend IOASID set such that IOASIDs can be managed by
> groups.
> - Add notifications for IOASID state synchronization
> - Add reference counting for life cycle alignment among users
> - Support ioasid_set private IDs, which can be used as guest IOASIDs
> Please refer to Documentation/ioasid.rst in enclosed patch 1/9 for more
> details.
> 
> This patchset only included VT-d driver as users of some of the new APIs.
> VFIO and KVM patches are coming up to fully utilize the APIs introduced
> here.
> 
> You can find this series at:
> https://github.com/jacobpan/linux.git ioasid_v3
> (VFIO and KVM patches will be available at this branch when published.)
> 
> This work is a result of collaboration with many people:
> Liu, Yi L <yi.l.liu@intel.com>
> Wu Hao <hao.wu@intel.com>
> Ashok Raj <ashok.raj@intel.com>
> Kevin Tian <kevin.tian@intel.com>
> 
> Thanks,
> 
> Jacob
> 
> Changelog:
> 
> V3:
> - Use consistent ioasid_set_ prefix for ioasid_set level APIs
> - Make SPID and private detach/attach APIs symmetric
> - Use the same ioasid_put semantics as Jean-Phillippe IOASID reference
> patch
> - Take away the public ioasid_notify() function, notifications are now
> emitted by IOASID core as a result of certain IOASID APIs
> - Partition into finer incremental patches
> - Miscellaneous cleanup, locking, exception handling fixes based on v2
> reviews
> 
> V2:
> - Redesigned ioasid_set APIs, removed set ID
> - Added set private ID (SPID) for guest PASID usage.
> - Add per ioasid_set notification and priority support.
> - Back to use spinlocks and atomic notifications.
> - Added async work in VT-d driver to perform teardown outside atomic
> context
> 
> Jacob Pan (14):
>   docs: Document IO Address Space ID (IOASID) APIs
>   iommu/ioasid: Rename ioasid_set_data()
>   iommu/ioasid: Add a separate function for detach data
>   iommu/ioasid: Support setting system-wide capacity
>   iommu/ioasid: Redefine IOASID set and allocation APIs
>   iommu/ioasid: Introduce API to adjust the quota of an ioasid_set
>   iommu/ioasid: Add an iterator API for ioasid_set
>   iommu/ioasid: Add reference couting functions
>   iommu/ioasid: Introduce ioasid_set private ID
>   iommu/ioasid: Introduce notification APIs
>   iommu/ioasid: Support mm type ioasid_set notifications
>   iommu/vt-d: Remove mm reference for guest SVA
>   iommu/vt-d: Listen to IOASID notifications
>   iommu/vt-d: Store guest PASID during bind
> 
>  Documentation/driver-api/ioasid.rst | 648 ++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.c         |  29 +-
>  drivers/iommu/intel/pasid.h         |   1 +
>  drivers/iommu/intel/svm.c           | 132 +++++-
>  drivers/iommu/ioasid.c              | 890
> ++++++++++++++++++++++++++++++++++-- include/linux/intel-iommu.h
> |   2 + include/linux/ioasid.h              | 197 +++++++-
>  7 files changed, 1830 insertions(+), 69 deletions(-)
>  create mode 100644 Documentation/driver-api/ioasid.rst
> 


Thanks,

Jacob
