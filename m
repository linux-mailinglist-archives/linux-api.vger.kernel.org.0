Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3E294F3B
	for <lists+linux-api@lfdr.de>; Wed, 21 Oct 2020 16:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443778AbgJUOy7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Oct 2020 10:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443653AbgJUOy6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Oct 2020 10:54:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77557C0613CF
        for <linux-api@vger.kernel.org>; Wed, 21 Oct 2020 07:54:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e22so3684585ejr.4
        for <linux-api@vger.kernel.org>; Wed, 21 Oct 2020 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BFCPvM2IrIxIbO/NAcdmKF4cshlij12nw9Eb0WJDBag=;
        b=gtraypYYX1Ts6KvEYPbWTw38IGVzD3hSarSd3/Gs5PLsvUR0OJ0quvcAk1qwBnB4eV
         E6qili6MZI8oOMOUenDUtlxhJb7rLtMhImtFofl3fq/Na6Udq4wr+05g5K2MG7pmP/Fk
         RIHSA1rm2s1ZRNmzGRZNvWpdiQSwFlRvi6DermMxq3byJLg7xzP9CMBhShZCDU1o8M1T
         GUWKNZwGtrolIY/ZUpP470LmDY13GXicW2Bv5diWJg+EykFuwV+jXR7apuP4VOJLEUAZ
         hTJYD2Y4TV4wKdvro4O4firrBitP8OqhnYCK6S4JlxRC0w9Q1lfqmkNteDpRRdVtOu0M
         xhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BFCPvM2IrIxIbO/NAcdmKF4cshlij12nw9Eb0WJDBag=;
        b=f2jL6S9tHVNGnsGnd+Zl29MFXnHKomc9W9rThffwOB99IAx3TxzyWmMI90vzJrDLyj
         4hRqCuN6XCw8bcOkJl9ydPIGlu/rxt5pXD3fRLlA9fi0wbYIE+nDq0yL9PTJMTFHEMyi
         c9nS7dZEEbIOD2X6kdAWgVYctHWk4jddAvtLgvHaLEpIrEPgdv8oo9U2RFmK6kIujPnQ
         eiJOYTIwcOflOAn82TxUWrs4BhYc221NialhdRYQaopbqt5cDvEot8u6VyiyWas/KMVP
         UvhxLrLHLc2LyVoC/mxxcvWxMbTsHnMsAAHTdIGbRleT2Dh2Luc9bUCqjEPOYrr1AlSn
         v+2g==
X-Gm-Message-State: AOAM5308i4cKA2rLHAmd3VZjAwQYz3wVqFkVCo49g6xBMzJMeJX4Cgru
        CD0aN1ouv/WHLtVrNl8hatig7A==
X-Google-Smtp-Source: ABdhPJzhzTRYyOOgZYy1AMK6rSQ1NL+2tSuKTUBIqZvdQLncyfEHZsHZ7BDLcE7Yw9HNN5D2QgbCQg==
X-Received: by 2002:a17:906:d292:: with SMTP id ay18mr4038597ejb.244.1603292097022;
        Wed, 21 Oct 2020 07:54:57 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y1sm2226896edj.76.2020.10.21.07.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 07:54:56 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:54:36 +0200
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
Subject: Re: [PATCH v3 03/14] iommu/ioasid: Add a separate function for
 detach data
Message-ID: <20201021145436.GA1653231@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601329121-36979-4-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 28, 2020 at 02:38:30PM -0700, Jacob Pan wrote:
> IOASID private data can be cleared by ioasid_attach_data() with a NULL
> data pointer. A common use case is for a caller to free the data
> afterward. ioasid_attach_data() calls synchronize_rcu() before return
> such that free data can be sure without outstanding readers.
> However, since synchronize_rcu() may sleep, ioasid_attach_data() cannot
> be used under spinlocks.
> 
> This patch adds ioasid_detach_data() as a separate API where
> synchronize_rcu() is called only in this case. ioasid_attach_data() can
> then be used under spinlocks. In addition, this change makes the API
> symmetrical.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

A typo below, but

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/intel/svm.c |  4 ++--
>  drivers/iommu/ioasid.c    | 54 ++++++++++++++++++++++++++++++++++++++---------
>  include/linux/ioasid.h    |  5 ++++-
>  3 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 2c5645f0737a..06a16bee7b65 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -398,7 +398,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	list_add_rcu(&sdev->list, &svm->devs);
>   out:
>  	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
> -		ioasid_attach_data(data->hpasid, NULL);
> +		ioasid_detach_data(data->hpasid);
>  		kfree(svm);
>  	}
>  
> @@ -441,7 +441,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
>  				 * the unbind, IOMMU driver will get notified
>  				 * and perform cleanup.
>  				 */
> -				ioasid_attach_data(pasid, NULL);
> +				ioasid_detach_data(pasid);
>  				kfree(svm);
>  			}
>  		}
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 5f63af07acd5..6cfbdfb492e0 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -272,24 +272,58 @@ int ioasid_attach_data(ioasid_t ioasid, void *data)
>  
>  	spin_lock(&ioasid_allocator_lock);
>  	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> -	if (ioasid_data)
> -		rcu_assign_pointer(ioasid_data->private, data);
> -	else
> +
> +	if (!ioasid_data) {
>  		ret = -ENOENT;
> -	spin_unlock(&ioasid_allocator_lock);
> +		goto done_unlock;
> +	}
>  
> -	/*
> -	 * Wait for readers to stop accessing the old private data, so the
> -	 * caller can free it.
> -	 */
> -	if (!ret)
> -		synchronize_rcu();
> +	if (ioasid_data->private) {
> +		ret = -EBUSY;
> +		goto done_unlock;
> +	}
> +	rcu_assign_pointer(ioasid_data->private, data);
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
>  
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(ioasid_attach_data);
>  
>  /**
> + * ioasid_detach_data - Clear the private data of an ioasid
> + *
> + * @ioasid: the IOASIDD to clear private data

IOASID

> + */
> +void ioasid_detach_data(ioasid_t ioasid)
> +{
> +	struct ioasid_data *ioasid_data;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> +
> +	if (!ioasid_data) {
> +		pr_warn("IOASID %u not found to detach data from\n", ioasid);
> +		goto done_unlock;
> +	}
> +
> +	if (ioasid_data->private) {
> +		rcu_assign_pointer(ioasid_data->private, NULL);
> +		goto done_unlock;
> +	}
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +	/*
> +	 * Wait for readers to stop accessing the old private data,
> +	 * so the caller can free it.
> +	 */
> +	synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(ioasid_detach_data);
> +
> +/**
>   * ioasid_alloc - Allocate an IOASID
>   * @set: the IOASID set
>   * @min: the minimum ID (inclusive)
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 9c44947a68c8..c7f649fa970a 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -40,7 +40,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
> -
> +void ioasid_detach_data(ioasid_t ioasid);
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>  				    ioasid_t max, void *private)
> @@ -72,5 +72,8 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
>  	return -ENOTSUPP;
>  }
>  
> +static inline void ioasid_detach_data(ioasid_t ioasid)
> +{
> +}
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> -- 
> 2.7.4
> 
