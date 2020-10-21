Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB51F294F4D
	for <lists+linux-api@lfdr.de>; Wed, 21 Oct 2020 16:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443794AbgJUO5d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Oct 2020 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442021AbgJUO5c (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Oct 2020 10:57:32 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77636C0613CF
        for <linux-api@vger.kernel.org>; Wed, 21 Oct 2020 07:57:30 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so3672262ejw.7
        for <linux-api@vger.kernel.org>; Wed, 21 Oct 2020 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uDhQg/1PwpQnDC2Kzqd7p30WxXAYl/Dt0HzmXyUtUtM=;
        b=NoGcYBlystc010ave+WzAHOpt++dZH1i/YRqz/rXzQfPQOwEAjmaEqQhJaS+WWtMTu
         6GVHomUOSTiseTimztfpf+NO3y7sVKox40ScNxOCe56vlQAJNNBkF3qgzhhMc/rZFE2H
         J1aU0qD1e0TA/fp9RXG49pFSkYRWc5SC3vXLBxW73s3rtQiVpQz0thT1Y/DAawSq8Zf+
         l6V9/VQ0P7tG3WEqgMPwvw0JR8YMJemq+RnNArdFxVDpzpmDmI3tbC0Qq13g7nVdqVlk
         JZPNMSURbeKabzPhg0An0u6KY/iO79UYfkAmm53xgLkTBmxKgbQBDsjT84uufnqcTt0A
         7Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uDhQg/1PwpQnDC2Kzqd7p30WxXAYl/Dt0HzmXyUtUtM=;
        b=qfprzU9lyQ3iBMwZZX1qI+qGxrYSdN+cxLftgFGJL0BwQiYEfhTnu1VJBFf9dEq5w+
         m2+z79WWCnaV2zTkduOJWkMdmlx5tT0W9awwtU5LqfeSbxIshJ2ZzjWY8Q9OqS+riEsA
         0S5sSZ4QQmuZLGXApT5S1f4oQcKgRBPyhlFMc+2zogkG5/M8CTvukorzqD1+pYr/eRGZ
         6gdzL5dKH+tTTRRMvoD8F+26cKKVBY5Jhv4QXOW34D2rTwT6E1zPkPpJuQvIuE2wJqBw
         1NvTypI7JA8dIwk/TNERkIuB4yW7jtqp5dc+7DXLFUMGiIopJKWAFIUMjjTatr0jY1KD
         sOpQ==
X-Gm-Message-State: AOAM531+/cS8kwhRhg4V4sTHJEa5a025sjKnvGX6Qvj6HUojE/6UKtCI
        xDtCKyGUlhFt/NcTCb/RZNyztw==
X-Google-Smtp-Source: ABdhPJy6ik6ltUjA3Gre7jtRggbeq5hOPX2y/q2s1z+uiXxa5wNrPld0RrdyPY19/Z5YmdIFB92h2A==
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr4022951eji.509.1603292249135;
        Wed, 21 Oct 2020 07:57:29 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id z2sm110970edr.64.2020.10.21.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 07:57:28 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:57:09 +0200
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
Subject: Re: [PATCH v3 06/14] iommu/ioasid: Introduce API to adjust the quota
 of an ioasid_set
Message-ID: <20201021145709.GD1653231@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-7-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601329121-36979-7-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 28, 2020 at 02:38:33PM -0700, Jacob Pan wrote:
> Each ioasid_set is given a quota during allocation. As system
> administrators balance resources among VMs, we shall support the
> adjustment of quota at runtime. The new quota cannot be less than the
> outstanding IOASIDs already allocated within the set. The extra quota
> will be returned to the system-wide IOASID pool if the new quota is
> smaller than the existing one.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Minor comments below, but

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/ioasid.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  6 ++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 61e25c2375ab..cf8c7d34e2de 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -654,6 +654,53 @@ void ioasid_set_put(struct ioasid_set *set)
>  EXPORT_SYMBOL_GPL(ioasid_set_put);
>  
>  /**
> + * ioasid_adjust_set - Adjust the quota of an IOASID set
> + * @set:	IOASID set to be assigned
> + * @quota:	Quota allowed in this set
> + *
> + * Return 0 on success. If the new quota is smaller than the number of
> + * IOASIDs already allocated, -EINVAL will be returned. No change will be
> + * made to the existing quota.
> + */
> +int ioasid_adjust_set(struct ioasid_set *set, int quota)

@quota probably doesn't need to be signed (since it's the same as an
ioasid_t, which is unsigned).

> +{
> +	int ret = 0;
> +
> +	if (quota <= 0)
> +		return -EINVAL;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	if (set->nr_ioasids > quota) {
> +		pr_err("New quota %d is smaller than outstanding IOASIDs %d\n",
> +			quota, set->nr_ioasids);
> +		ret = -EINVAL;
> +		goto done_unlock;
> +	}
> +
> +	if ((quota > set->quota) &&
> +		(quota - set->quota > ioasid_capacity_avail)) {

misaligned

> +		ret = -ENOSPC;
> +		goto done_unlock;
> +	}
> +
> +	/* Return the delta back to system pool */
> +	ioasid_capacity_avail += set->quota - quota;
> +
> +	/*
> +	 * May have a policy to prevent giving all available IOASIDs
> +	 * to one set. But we don't enforce here, it should be in the
> +	 * upper layers.
> +	 */

I think here would be OK to check about fairness. But anyway, we don't
have to worry about this yet, so I'd just drop the comment.

Thanks,
Jean

> +	set->quota = quota;
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_adjust_set);
> +
> +/**
>   * ioasid_find - Find IOASID data
>   * @set: the IOASID set
>   * @ioasid: the IOASID to find
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 1ae213b660f0..0a5e82148eb9 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -62,6 +62,7 @@ struct ioasid_allocator_ops {
>  void ioasid_install_capacity(ioasid_t total);
>  ioasid_t ioasid_get_capacity(void);
>  struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type);
> +int ioasid_adjust_set(struct ioasid_set *set, int quota);
>  void ioasid_set_get(struct ioasid_set *set);
>  void ioasid_set_put(struct ioasid_set *set);
>  
> @@ -99,6 +100,11 @@ static inline struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, i
>  	return ERR_PTR(-ENOTSUPP);
>  }
>  
> +static inline int ioasid_adjust_set(struct ioasid_set *set, int quota)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  static inline void ioasid_set_put(struct ioasid_set *set)
>  {
>  }
> -- 
> 2.7.4
> 
