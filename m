Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB031294F3D
	for <lists+linux-api@lfdr.de>; Wed, 21 Oct 2020 16:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443608AbgJUOzR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Oct 2020 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443018AbgJUOzR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Oct 2020 10:55:17 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DC5C0613CE
        for <linux-api@vger.kernel.org>; Wed, 21 Oct 2020 07:55:17 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w23so2235455edl.0
        for <linux-api@vger.kernel.org>; Wed, 21 Oct 2020 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TT/hPDcCjkJCenk8sLHU1Sek4T/MxX3FitCsX0otRRc=;
        b=tnlFBdD60NP1j8CKi3rq0v7z4WCacFdpguP+kTr9uz2MOzLrWy6v9UfR2aViCYoEs4
         KNgexySZD6t48QEV0KYpCSCJQr1dAfmO5L3JY6/orVfiif1vNz6RTPCvO2z9suGyggQw
         ZP7CkNfToa3mHdlDo9xnCOF8GRwUleHlkUAmIJY9zZHgUqvebiMZjqJ95PTq4lJptC93
         7btioFs3fVFwa26j3dBRkvE3qpbk/irVE/8cZeZbxswjcfy1LhRk2cTmiwobkzVVMqki
         nhvW//0XltzV4dYBqGiG2MrKzCNIfn0BDtzQ4Z1etG4sws1lKittG2ZNKnfwqBjJhYBx
         izcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TT/hPDcCjkJCenk8sLHU1Sek4T/MxX3FitCsX0otRRc=;
        b=Aqu5jiEeYtScN7Ejg7LxWlbBB2tmfEUoACqw0e1q7TSEveeBsTOxRRODB9RVsm2lY5
         zBYdnZEk0qeFH3d9/QNV+tHZzaPTrcn7D2wG+qrlAs1k07qDgw96eUJVR3KQPfewwXvl
         4Rb4vflYc+FCVI2cBIMXtTG+rzhexTxTA5hDfA74aE3hQyJ3kJKrCRvLaIlpkKVoA/Dk
         I1XWz0BAKJ+wJZmQ1ZGIecF0takBsf6HO5I1B6o01zCVwPOLFIzekM/cRXb8D9dBQLhS
         fwvEnxEXPWplA5Jp4358ifzCTs4CyWg2abqnfp9J8La3lzcnGhQ5j6W967uNnZ+QE3co
         1Vww==
X-Gm-Message-State: AOAM5335pRaQwy5JEhDrWfWXmum6JXooo6RxVt9CiMd/NjcmfIS3uama
        VQnYGRVgbAXTi/+NF5iWTtxbEw==
X-Google-Smtp-Source: ABdhPJxO/uNuN/kb6YExIPr9kYKJ7e7ROpNtyXJhX1g05ieAZquuDAeeEqFw/4xdqCfGl12l+fr2xw==
X-Received: by 2002:a50:8acf:: with SMTP id k15mr3413516edk.351.1603292116012;
        Wed, 21 Oct 2020 07:55:16 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id lb11sm2406579ejb.27.2020.10.21.07.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 07:55:15 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:54:56 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.pan.linux@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 04/14] iommu/ioasid: Support setting system-wide
 capacity
Message-ID: <20201021145456.GB1653231@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601329121-36979-5-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 28, 2020 at 02:38:31PM -0700, Jacob Pan wrote:
> IOASID is a system-wide resource that could vary on different systems.
> The default capacity is 20 bits as defined in the PCI-E specifications.
> This patch adds a function to allow adjusting system IOASID capacity.
> For VT-d this is set during boot as part of the Intel IOMMU
> initialization.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/intel/iommu.c |  5 +++++
>  drivers/iommu/ioasid.c      | 20 ++++++++++++++++++++
>  include/linux/ioasid.h      | 11 +++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 18ed3b3c70d7..e7bcb299e51e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -42,6 +42,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/numa.h>
>  #include <linux/swiotlb.h>
> +#include <linux/ioasid.h>

(not in alphabetical order)

>  #include <asm/irq_remapping.h>
>  #include <asm/cacheflush.h>
>  #include <asm/iommu.h>
> @@ -3331,6 +3332,10 @@ static int __init init_dmars(void)
>  	if (ret)
>  		goto free_iommu;
>  
> +	/* PASID is needed for scalable mode irrespective to SVM */
> +	if (intel_iommu_sm)
> +		ioasid_install_capacity(intel_pasid_max_id);
> +
>  	/*
>  	 * for each drhd
>  	 *   enable fault log
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 6cfbdfb492e0..4277cb17e15b 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -10,6 +10,10 @@
>  #include <linux/spinlock.h>
>  #include <linux/xarray.h>
>  
> +/* Default to PCIe standard 20 bit PASID */
> +#define PCI_PASID_MAX 0x100000
> +static ioasid_t ioasid_capacity = PCI_PASID_MAX;
> +static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
>  struct ioasid_data {
>  	ioasid_t id;
>  	struct ioasid_set *set;
> @@ -17,6 +21,22 @@ struct ioasid_data {
>  	struct rcu_head rcu;
>  };
>  
> +void ioasid_install_capacity(ioasid_t total)
> +{
> +	if (ioasid_capacity && ioasid_capacity != PCI_PASID_MAX) {
> +		pr_warn("IOASID capacity is already set.\n");
> +		return;
> +	}
> +	ioasid_capacity = ioasid_capacity_avail = total;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> +
> +ioasid_t ioasid_get_capacity(void)
> +{
> +	return ioasid_capacity;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_get_capacity);
> +
>  /*
>   * struct ioasid_allocator_data - Internal data structure to hold information
>   * about an allocator. There are two types of allocators:
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index c7f649fa970a..7fc320656be2 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -32,6 +32,8 @@ struct ioasid_allocator_ops {
>  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
>  
>  #if IS_ENABLED(CONFIG_IOASID)
> +void ioasid_install_capacity(ioasid_t total);
> +ioasid_t ioasid_get_capacity(void);
>  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  		      void *private);
>  void ioasid_free(ioasid_t ioasid);
> @@ -42,6 +44,15 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
>  void ioasid_detach_data(ioasid_t ioasid);
>  #else /* !CONFIG_IOASID */
> +static inline void ioasid_install_capacity(ioasid_t total)
> +{
> +}
> +
> +static inline ioasid_t ioasid_get_capacity(void)
> +{
> +	return 0;
> +}
> +
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>  				    ioasid_t max, void *private)
>  {
> -- 
> 2.7.4
> 
