Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68830294F52
	for <lists+linux-api@lfdr.de>; Wed, 21 Oct 2020 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443814AbgJUO54 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Oct 2020 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443796AbgJUO5z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Oct 2020 10:57:55 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677C8C0613CE
        for <linux-api@vger.kernel.org>; Wed, 21 Oct 2020 07:57:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t20so2867227edr.11
        for <linux-api@vger.kernel.org>; Wed, 21 Oct 2020 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8fS1Un7tm4hoyXJsqhftc1rCjizgyzgSNGUCjm2e3M8=;
        b=HAnWHjuqdAkDysqsuCVv7ZNFRz7Ch50Tyt8VWUH2yRgrGlTtpJXjd7/SOCjBdy54bp
         zCQT702zaGQKAAysikG0BrM62ZC2oIDeC8vEb1MpcUnSDt3TUf5wMhZR2W2BTPFIpfl0
         WJlD/dTSlRPUB4wKY4BQ5DGENmf8ydHKzAg3QJ96R5ex4dSW/OM6xVihfR2VoabVmOLP
         fM59T04L84Zg54APbj4xzZs7HK1uAufQWPFwAlR7tbs45adHVXqDtJJub2jg74rf7WRI
         KXPB8tECXuaEsx7b10fQhYnjzm3G4eEYxxSdZgbUalugBEQpvJUdsakkdHlZsA/6nwjD
         1QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fS1Un7tm4hoyXJsqhftc1rCjizgyzgSNGUCjm2e3M8=;
        b=FkRiug2o8G5he25yNnYfKT22mOTBqBck5crlC5JVDUH3kYukNNFQWcRoa5Y2MbgeqG
         semxhmlhfo0JzOeaVVGUvaNDQMgMZOBJtwh2tTsVI9Q6RBgrRI2YJyTYg9wwROKd23TE
         yDUyTkSekLFotYG46ulacCN3RETxOyDhvsbQZq+re8SxsqEVJSnfMP04tS9INAg092eJ
         phZK2X+6bCgVdFK9nM2EQF6RFUmxnKhRbik+RLJYYASJNBmtbBKBCTLLfA4YtBnGMIet
         3yn4Dv98sqaOYlmohZJU5zQ959Q/YDd6g2no/e3XjD3m7gisJp5/ZQrEQtBabSbRRxl4
         BHbg==
X-Gm-Message-State: AOAM530/ajGxDloIfd/aOOXeL5AKEFuxr7QaXreZGrbCBWk4YbrkowUK
        kjl9E11hESf241XSDNTzvJd1JQ==
X-Google-Smtp-Source: ABdhPJwpjrnhBHug8yxg0CgMBaHasHwZV1qOVXOGryBbHqLEvEQv6AWyUzedMz6X1p7Igtf2M8MzLg==
X-Received: by 2002:a05:6402:151a:: with SMTP id f26mr3587638edw.386.1603292274101;
        Wed, 21 Oct 2020 07:57:54 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id r9sm1973753edt.3.2020.10.21.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 07:57:53 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:57:34 +0200
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
Subject: Re: [PATCH v3 07/14] iommu/ioasid: Add an iterator API for ioasid_set
Message-ID: <20201021145734.GE1653231@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-8-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601329121-36979-8-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 28, 2020 at 02:38:34PM -0700, Jacob Pan wrote:
> Users of an ioasid_set may not keep track of all the IOASIDs allocated
> under the set. When collective actions are needed for each IOASIDs, it
> is useful to iterate over all the IOASIDs within the set. For example,
> when the ioasid_set is freed, the user might perform the same cleanup
> operation on each IOASID.
> 
> This patch adds an API to iterate all the IOASIDs within the set.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Could add a short description of the function parameters, but

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/ioasid.c | 17 +++++++++++++++++
>  include/linux/ioasid.h |  9 +++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index cf8c7d34e2de..9628e78b2ab4 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -701,6 +701,23 @@ int ioasid_adjust_set(struct ioasid_set *set, int quota)
>  EXPORT_SYMBOL_GPL(ioasid_adjust_set);
>  
>  /**
> + * ioasid_set_for_each_ioasid - Iterate over all the IOASIDs within the set
> + *
> + * Caller must hold a reference of the set and handles its own locking.
> + */
> +void ioasid_set_for_each_ioasid(struct ioasid_set *set,
> +				void (*fn)(ioasid_t id, void *data),
> +				void *data)
> +{
> +	struct ioasid_data *entry;
> +	unsigned long index;
> +
> +	xa_for_each(&set->xa, index, entry)
> +		fn(index, data);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
> +
> +/**
>   * ioasid_find - Find IOASID data
>   * @set: the IOASID set
>   * @ioasid: the IOASID to find
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 0a5e82148eb9..aab58bc26714 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -75,6 +75,9 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
>  void ioasid_detach_data(ioasid_t ioasid);
> +void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
> +				void (*fn)(ioasid_t id, void *data),
> +				void *data);
>  #else /* !CONFIG_IOASID */
>  static inline void ioasid_install_capacity(ioasid_t total)
>  {
> @@ -131,5 +134,11 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
>  static inline void ioasid_detach_data(ioasid_t ioasid)
>  {
>  }
> +
> +static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
> +					      void (*fn)(ioasid_t id, void *data),
> +					      void *data)
> +{
> +}
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> -- 
> 2.7.4
> 
