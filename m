Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC896296DE6
	for <lists+linux-api@lfdr.de>; Fri, 23 Oct 2020 13:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463142AbgJWLnz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Oct 2020 07:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463125AbgJWLny (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Oct 2020 07:43:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21495C0613CE
        for <linux-api@vger.kernel.org>; Fri, 23 Oct 2020 04:43:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t25so1907243ejd.13
        for <linux-api@vger.kernel.org>; Fri, 23 Oct 2020 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w1hT410pcvPp1e/jISfMDxaGMiE6qEWo/7L0amMfRgU=;
        b=cJLW7KXhZrozobsjIxLY2+buIwLvxqKyr27AnZ7HYQWa0uUdukWbasKJ2czJU24TAv
         +xOQlWLO6+S1xUJvXWypAbTgXaMAaueeDEY79s+fzRprkFavmAc4GWPNEArbGHty9Gen
         X9E+dVy9ofbqsgurh6cROggxU5YEL5D66l3f384zkftR4EosrgAMXRSRkMByyTKWVveo
         biP2CbDeOAiFRBbE/JyiUlPoN3H+aGVTUr5eNfYhM/yyLuc32ibRrp/B5bQyt08h6B4O
         hCYerAR9pgUKtxCUaLnWYi4cGUe26zmp9KDA1qKweDdurQd8Oe3cqfTdLeoeKCXXyOJv
         G7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w1hT410pcvPp1e/jISfMDxaGMiE6qEWo/7L0amMfRgU=;
        b=opzqC+lZqQXvihYdpP4mi+RmK+7Y8KWa02G3Du0Ulgkl1sn3EUvbLm9qE5d5M7k6k+
         JKQ8E4FdI96oBRdsovVQ80/i9Z2bXyYyRkj5GU/xfCpSwiHRXjqJ2pX3k1IDeQJ0Xc1V
         vH0r+KBgVszBB/pOHccLMZrwjC2kB0FZx6/fjdRsz3aY7ea/nY3ouqqSgK8G1wVtlrjI
         T7FNK82DM/fSiQylzCsjZARQMzpWYfETJ2uSbRqasd+Y7NfIaqrRc3/oFqPa+dCVZGIg
         KSB1TUP6J3x/+ek7SSHnnrZnOR0GZO2Z+W1nDqZRkNQOd1+fmC/ZsR5ucu7EEd8aBFpF
         UwEQ==
X-Gm-Message-State: AOAM532cS7h8vCFpQp6TnOYLYFKIbiz+dGyhK196EoE9j10xtTCGBKtB
        yQI6WoZt2KyRoCy0e8SQFeUgwA==
X-Google-Smtp-Source: ABdhPJwVjOkSax5nJV5uOP3pmNaE8Fo5w1uLm4eJe7FAqS8w5MKoOR0dfzix1SVIRw2yiVXX9NDP/Q==
X-Received: by 2002:a17:906:66d2:: with SMTP id k18mr1469410ejp.113.1603453432716;
        Fri, 23 Oct 2020 04:43:52 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id sb29sm678261ejb.76.2020.10.23.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 04:43:52 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:43:32 +0200
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
Subject: Re: [PATCH v3 11/14] iommu/ioasid: Support mm type ioasid_set
 notifications
Message-ID: <20201023114332.GD2265982@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-12-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1601329121-36979-12-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 28, 2020 at 02:38:38PM -0700, Jacob Pan wrote:
> As a system-wide resource, IOASID is often shared by multiple kernel
> subsystems that are independent of each other. However, at the
> ioasid_set level, these kernel subsystems must communicate with each
> other for ownership checking, event notifications, etc. For example, on
> Intel Scalable IO Virtualization (SIOV) enabled platforms, KVM and VFIO
> instances under the same process/guest must be aware of a shared IOASID
> set.
> IOASID_SET_TYPE_MM token type was introduced to explicitly mark an
> IOASID set that belongs to a process, thus use the same mm_struct
> pointer as a token. Users of the same process can then identify with
> each other based on this token.
> 
> This patch introduces MM token specific event registration APIs. Event
> subscribers such as KVM instances can register IOASID event handler
> without the knowledge of its ioasid_set. Event handlers are registered
> based on its mm_struct pointer as a token. In case when subscribers
> register handler *prior* to the creation of the ioasid_set, the
> handler’s notification block is stored in a pending list within IOASID
> core. Once the ioasid_set of the MM token is created, the notification
> block will be registered by the IOASID core.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  15 +++++++
>  2 files changed, 132 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 894b17c06ead..d5faeb559a43 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -889,6 +889,29 @@ void ioasid_set_put(struct ioasid_set *set)
>  }
>  EXPORT_SYMBOL_GPL(ioasid_set_put);
>  
> +/*
> + * ioasid_find_mm_set - Retrieve IOASID set with mm token
> + * Take a reference of the set if found.
> + */
> +static struct ioasid_set *ioasid_find_mm_set(struct mm_struct *token)
> +{
> +	struct ioasid_set *set;
> +	unsigned long index;
> +
> +	spin_lock(&ioasid_allocator_lock);

This could deadlock since ioasid_set_put() takes the nb_lock while holding
the allocator_lock.

> +
> +	xa_for_each(&ioasid_sets, index, set) {
> +		if (set->type == IOASID_SET_TYPE_MM && set->token == token) {
> +			refcount_inc(&set->ref);
> +			goto exit_unlock;
> +		}
> +	}
> +	set = NULL;
> +exit_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +	return set;
> +}
> +
>  /**
>   * ioasid_adjust_set - Adjust the quota of an IOASID set
>   * @set:	IOASID set to be assigned
> @@ -1121,6 +1144,100 @@ void ioasid_unregister_notifier(struct ioasid_set *set,
>  }
>  EXPORT_SYMBOL_GPL(ioasid_unregister_notifier);
>  
> +/**
> + * ioasid_register_notifier_mm - Register a notifier block on the IOASID set
> + *                               created by the mm_struct pointer as the token
> + *
> + * @mm: the mm_struct token of the ioasid_set
> + * @nb: notfier block to be registered on the ioasid_set

Maybe add that the priority in @nb needs to be set by the caller using a
ioasid_notifier_priority value

> + *
> + * This a variant of ioasid_register_notifier() where the caller intends to
> + * listen to IOASID events belong the ioasid_set created under the same

                         that belong to

> + * process. Caller is not aware of the ioasid_set, no need to hold reference
> + * of the ioasid_set.
> + */
> +int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
> +{
> +	struct ioasid_set_nb *curr;
> +	struct ioasid_set *set;
> +	int ret = 0;
> +
> +	if (!mm)
> +		return -EINVAL;
> +
> +	spin_lock(&ioasid_nb_lock);
> +
> +	/* Check for duplicates, nb is unique per set */
> +	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
> +		if (curr->token == mm && curr->nb == nb) {
> +			ret = -EBUSY;
> +			goto exit_unlock;
> +		}
> +	}
> +
> +	/* Check if the token has an existing set */
> +	set = ioasid_find_mm_set(mm);
> +	if (!set) {
> +		/* Add to the rsvd list as inactive */
> +		curr->active = false;

curr is invalid here

> +	} else {
> +		/* REVISIT: Only register empty set for now. Can add an option
> +		 * in the future to playback existing PASIDs.
> +		 */

You can drop this comment

> +		if (set->nr_ioasids) {
> +			pr_warn("IOASID set %d not empty\n", set->id);
> +			ret = -EBUSY;
> +			goto exit_unlock;
> +		}
> +		curr = kzalloc(sizeof(*curr), GFP_ATOMIC);

Needs to be in the common path, before this block

> +		if (!curr) {
> +			ret = -ENOMEM;
> +			goto exit_unlock;
> +		}
> +		curr->token = mm;
> +		curr->nb = nb;
> +		curr->active = true;
> +		curr->set = set;
> +
> +		/* Set already created, add to the notifier chain */
> +		atomic_notifier_chain_register(&set->nh, nb);
> +		/*
> +		 * Do not hold a reference, if the set gets destroyed, the nb
> +		 * entry will be marked inactive.
> +		 */
> +		ioasid_set_put(set);
> +	}
> +
> +	list_add(&curr->list, &ioasid_nb_pending_list);
> +
> +exit_unlock:
> +	spin_unlock(&ioasid_nb_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_register_notifier_mm);
> +
> +void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
> +{
> +	struct ioasid_set_nb *curr;
> +
> +	spin_lock(&ioasid_nb_lock);
> +	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
> +		if (curr->token == mm && curr->nb == nb) {
> +			list_del(&curr->list);
> +			spin_unlock(&ioasid_nb_lock);
> +			if (curr->active) {
> +				atomic_notifier_chain_unregister(&curr->set->nh,
> +								 nb);

I think it's possible for ioasid_set_put_locked() to free the set right
after we release the lock, then this unregister() will be use-after-free.
Best keep holding the lock for this.

> +			}
> +			kfree(curr);
> +			return;
> +		}
> +	}
> +	pr_warn("No ioasid set found for mm token %llx\n",  (u64)mm);

Use %p

Overall I think error messages in this series could be demoted to
pr_debug, since they're useful when developing users to this API, but
figuring out whether they can be user-triggered and need care is too much
work.

Thanks,
Jean

> +	spin_unlock(&ioasid_nb_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_unregister_notifier_mm);
> +
>  MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
>  MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
>  MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 1b551c99d568..c6cc855aadb6 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -132,6 +132,9 @@ void ioasid_unregister_notifier(struct ioasid_set *set,
>  void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
>  				void (*fn)(ioasid_t id, void *data),
>  				void *data);
> +int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
> +void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
> +
>  #else /* !CONFIG_IOASID */
>  static inline void ioasid_install_capacity(ioasid_t total)
>  {
> @@ -238,5 +241,17 @@ static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
>  					      void *data)
>  {
>  }
> +
> +static inline int ioasid_register_notifier_mm(struct mm_struct *mm,
> +					      struct notifier_block *nb)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void ioasid_unregister_notifier_mm(struct mm_struct *mm,
> +						 struct notifier_block *nb)
> +{
> +}
> +
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> -- 
> 2.7.4
> 
