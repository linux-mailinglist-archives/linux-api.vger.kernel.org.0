Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EED27CBE0
	for <lists+linux-api@lfdr.de>; Tue, 29 Sep 2020 14:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgI2Mar (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Sep 2020 08:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729241AbgI2L3L (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Sep 2020 07:29:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601378902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGARCpvA09aUjSBBoDGMfF3ZU07Wv/ZTQCcyI1kBack=;
        b=CZ4ysgpAOnYB7JlK2AuOHZPbOUS52Z2g9o2SjJWTzg8+k5wTvUEGcsBuTcmuVHWRdZEcyM
        SVWbAz4WJ9igitdo1eFF1AjJLc/xMMvqHPYEgFfxHq9EdcQSia4XDwOp0kgvFdwTQaDyZS
        yltZCTFrl2vH/uVEagT1nGwfc7QViZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-q2JR0HniPwOJr1qIWbxPXQ-1; Tue, 29 Sep 2020 07:26:14 -0400
X-MC-Unique: q2JR0HniPwOJr1qIWbxPXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D1B3425D8;
        Tue, 29 Sep 2020 11:26:12 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 885B155796;
        Tue, 29 Sep 2020 11:26:05 +0000 (UTC)
Subject: Re: [PATCH v12 6/6] iommu/vt-d: Check UAPI data processed by IOMMU
 core
To:     Jacob Pan <jacob.pan.linux@gmail.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-api@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601051567-54787-7-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <814e10c3-4957-2ce6-0490-7af0daa327e4@redhat.com>
Date:   Tue, 29 Sep 2020 13:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1601051567-54787-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Jacob,

On 9/25/20 6:32 PM, Jacob Pan wrote:
> IOMMU generic layer already does sanity checks on UAPI data for version
> match and argsz range based on generic information.
> 
> This patch adjusts the following data checking responsibilities:
> - removes the redundant version check from VT-d driver
> - removes the check for vendor specific data size
> - adds check for the use of reserved/undefined flags
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/iommu/intel/iommu.c |  3 +--
>  drivers/iommu/intel/svm.c   | 11 +++++++++--
>  include/uapi/linux/iommu.h  |  1 +
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 461f3a6864d4..18ed3b3c70d7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5408,8 +5408,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  	int ret = 0;
>  	u64 size = 0;
>  
> -	if (!inv_info || !dmar_domain ||
> -	    inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +	if (!inv_info || !dmar_domain)
>  		return -EINVAL;
>  
>  	if (!dev || !dev_is_pci(dev))
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 99353d6468fa..0cb9a15f1112 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -284,8 +284,15 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	if (WARN_ON(!iommu) || !data)
>  		return -EINVAL;
>  
> -	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> -	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +		return -EINVAL;
> +
> +	/* IOMMU core ensures argsz is more than the start of the union */
> +	if (data->argsz < offsetofend(struct iommu_gpasid_bind_data, vendor.vtd))
> +		return -EINVAL;
> +
> +	/* Make sure no undefined flags are used in vendor data */
> +	if (data->vendor.vtd.flags & ~(IOMMU_SVA_VTD_GPASID_LAST - 1))
>  		return -EINVAL;
>  
>  	if (!dev_is_pci(dev))
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 66d4ca40b40f..e1d9e75f2c94 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -288,6 +288,7 @@ struct iommu_gpasid_bind_data_vtd {
>  #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
>  #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
>  #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
> +#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
>  	__u64 flags;
>  	__u32 pat;
>  	__u32 emt;
> 

