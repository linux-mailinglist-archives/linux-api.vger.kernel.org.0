Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D54296DD6
	for <lists+linux-api@lfdr.de>; Fri, 23 Oct 2020 13:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463099AbgJWLkC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Oct 2020 07:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463097AbgJWLkC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Oct 2020 07:40:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC88BC0613D2
        for <linux-api@vger.kernel.org>; Fri, 23 Oct 2020 04:40:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t25so1892174ejd.13
        for <linux-api@vger.kernel.org>; Fri, 23 Oct 2020 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k/LuG6OtmNxqgVsLg5OMLiO/NQ4A3lJS87y3CYTUFFU=;
        b=Mtnnlm0J+WJBA3c9EfY6XwzvvhI4ZTON59If853cfKAxf255FiwPsu2HmVYtaERP9K
         08S2K24j0qeXvucT73YxGGv9qu2WqLCPst7ZCfgGV0eZpxDqGz2ALUYtLVMjuLpwgRA8
         SOV/85qh33Nzd9zBbpEqR5MVZofGiO8prX96ppaMAZdMxC4y4LbWon73TcDYSRrqABbt
         PE2bdhMfWQ9xJCEvtMWbQ7qfmF2x+0L7s9z65upRSMuAxt3l24wPjggChIMbKBHb7N4L
         VqfMDEkQgc7QTIRKRLcjxV7DNkdsI76EVk5UGgKiT1Mfsh7BT7UMymNZhuQOQ/oGm7zd
         0dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k/LuG6OtmNxqgVsLg5OMLiO/NQ4A3lJS87y3CYTUFFU=;
        b=AB9+UqIsRWzsYS7schkNk+Ah90RP6NLb0/R2gxvoQvAmNJaL/sio4nlVdVffOlCnoM
         OJwyecZNosDJM+rFRR1gwq3a0JS6pThN9TjfiRH4lQ0pSugBQsJ3HNjy/8y9qF6iYRNl
         mXGtf/MnIkTEZUV9szuLi7cYH1+w4rrg2HmLLgSKke+kgUjNjXLcJ2FczpIuz74Gh72w
         yFRUgAH6yYtXIFk/AjWpmokgjdfb+R7qmouF1K1/qcv89lx4u5c5ju3zGIesdQe1npgP
         bI22rJKzFmpcvlCQAK2czQ+RuKTGDGKTdeOpERBadoB/MGIbGddqt6BKKaH7cI1qL8gl
         HIwg==
X-Gm-Message-State: AOAM533395QBGJ4itHp1I9DUKoghAWm/eIp51M82CP3iWoVx5I0g9i4R
        7m7nOD92w2E2GR5jUWQvpzJEUA==
X-Google-Smtp-Source: ABdhPJwCZ+zxFTZOtGHYnLserZW2l39r5Fdug8xbOh9JCoPBucOCa5n/4fRByHlvRI1ljK8JLQiutw==
X-Received: by 2002:a17:906:abcf:: with SMTP id kq15mr1479197ejb.208.1603453200189;
        Fri, 23 Oct 2020 04:40:00 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p17sm649317edw.10.2020.10.23.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 04:39:59 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:39:39 +0200
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
Subject: Re: [PATCH v3 09/14] iommu/ioasid: Introduce ioasid_set private ID
Message-ID: <20201023113939.GB2265982@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-10-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601329121-36979-10-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 28, 2020 at 02:38:36PM -0700, Jacob Pan wrote:
> When an IOASID set is used for guest SVA, each VM will acquire its
> ioasid_set for IOASID allocations. IOASIDs within the VM must have a
> host/physical IOASID backing, mapping between guest and host IOASIDs can
> be non-identical. IOASID set private ID (SPID) is introduced in this
> patch to be used as guest IOASID. However, the concept of ioasid_set
> specific namespace is generic, thus named SPID.
> 
> As SPID namespace is within the IOASID set, the IOASID core can provide
> lookup services at both directions. SPIDs may not be available when its
> IOASID is allocated, the mapping between SPID and IOASID is usually
> established when a guest page table is bound to a host PASID.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  19 +++++++++
>  2 files changed, 121 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 828cc44b1b1c..378fef8f23d9 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -26,6 +26,7 @@ enum ioasid_state {
>   * struct ioasid_data - Meta data about ioasid
>   *
>   * @id:		Unique ID
> + * @spid:	Private ID unique within a set
>   * @users:	Number of active users
>   * @state:	Track state of the IOASID
>   * @set:	ioasid_set of the IOASID belongs to
> @@ -34,6 +35,7 @@ enum ioasid_state {
>   */
>  struct ioasid_data {
>  	ioasid_t id;
> +	ioasid_t spid;
>  	refcount_t users;
>  	enum ioasid_state state;
>  	struct ioasid_set *set;
> @@ -363,6 +365,105 @@ void ioasid_detach_data(ioasid_t ioasid)
>  }
>  EXPORT_SYMBOL_GPL(ioasid_detach_data);
>  
> +static ioasid_t ioasid_find_by_spid_locked(struct ioasid_set *set, ioasid_t spid)
> +{
> +	ioasid_t ioasid = INVALID_IOASID;
> +	struct ioasid_data *entry;
> +	unsigned long index;
> +
> +	if (!xa_load(&ioasid_sets, set->id)) {
> +		pr_warn("Invalid set\n");

Could use ioasid_set_is_valid(), and perhaps a WARN_ON() instead of
pr_warn() since this is a programming error.

> +		goto done;

Or just return INVALID_IOASID

> +	}
> +
> +	xa_for_each(&set->xa, index, entry) {
> +		if (spid == entry->spid) {
> +			refcount_inc(&entry->users);
> +			ioasid = index;

break

> +		}
> +	}
> +done:
> +	return ioasid;
> +}
> +
> +/**
> + * ioasid_attach_spid - Attach ioasid_set private ID to an IOASID
> + *
> + * @ioasid: the system-wide IOASID to attach
> + * @spid:   the ioasid_set private ID of @ioasid
> + *
> + * After attching SPID, future lookup can be done via ioasid_find_by_spid().

            attaching

> + */
> +int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
> +{
> +	struct ioasid_data *data;
> +	int ret = 0;
> +
> +	if (spid == INVALID_IOASID)
> +		return -EINVAL;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	data = xa_load(&active_allocator->xa, ioasid);
> +
> +	if (!data) {
> +		pr_err("No IOASID entry %d to attach SPID %d\n",
> +			ioasid, spid);
> +		ret = -ENOENT;
> +		goto done_unlock;
> +	}
> +	/* Check if SPID is unique within the set */
> +	if (ioasid_find_by_spid_locked(data->set, spid) != INVALID_IOASID) {

We need an additional parameter to ioasid_find_by_spid_locked(), telling
it not to take a reference to the conflicting entry. Here we return with
the reference, which will never be released.

> +		ret = -EINVAL;
> +		goto done_unlock;
> +	}
> +	data->spid = spid;
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_attach_spid);
> +
> +void ioasid_detach_spid(ioasid_t ioasid)

Could add a small comment to this public function

Thanks,
Jean

> +{
> +	struct ioasid_data *data;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	data = xa_load(&active_allocator->xa, ioasid);
> +
> +	if (!data || data->spid == INVALID_IOASID) {
> +		pr_err("Invalid IOASID entry %d to detach\n", ioasid);
> +		goto done_unlock;
> +	}
> +	data->spid = INVALID_IOASID;
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_detach_spid);
> +
> +/**
> + * ioasid_find_by_spid - Find the system-wide IOASID by a set private ID and
> + * its set.
> + *
> + * @set:	the ioasid_set to search within
> + * @spid:	the set private ID
> + *
> + * Given a set private ID and its IOASID set, find the system-wide IOASID. Take
> + * a reference upon finding the matching IOASID. Return INVALID_IOASID if the
> + * IOASID is not found in the set or the set is not valid.
> + */
> +ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
> +{
> +	ioasid_t ioasid;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid = ioasid_find_by_spid_locked(set, spid);
> +	spin_unlock(&ioasid_allocator_lock);
> +	return ioasid;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
> +
>  static inline bool ioasid_set_is_valid(struct ioasid_set *set)
>  {
>  	return xa_load(&ioasid_sets, set->id) == set;
> @@ -529,6 +630,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  		goto exit_free;
>  	}
>  	data->id = id;
> +	data->spid = INVALID_IOASID;
>  	data->state = IOASID_STATE_ACTIVE;
>  	refcount_set(&data->users, 1);
>  
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 16d421357173..2dfe85e6cb7e 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -79,6 +79,10 @@ bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
>  bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
>  void ioasid_detach_data(ioasid_t ioasid);
> +int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
> +void ioasid_detach_spid(ioasid_t ioasid);
> +ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid);
> +
>  void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
>  				void (*fn)(ioasid_t id, void *data),
>  				void *data);
> @@ -159,6 +163,21 @@ static inline void ioasid_detach_data(ioasid_t ioasid)
>  {
>  }
>  
> +static inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void ioasid_detach_spid(ioasid_t ioasid)
> +{
> +}
> +
> +static inline ioasid_t ioasid_find_by_spid(struct ioasid_set *set,
> +					   ioasid_t spid)
> +{
> +	return INVALID_IOASID;
> +}
> +
>  static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
>  					      void (*fn)(ioasid_t id, void *data),
>  					      void *data)
> -- 
> 2.7.4
> 
