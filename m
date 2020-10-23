Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8EA296DDD
	for <lists+linux-api@lfdr.de>; Fri, 23 Oct 2020 13:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463086AbgJWLmO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Oct 2020 07:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463076AbgJWLmO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Oct 2020 07:42:14 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226B4C0613D2
        for <linux-api@vger.kernel.org>; Fri, 23 Oct 2020 04:42:13 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qh17so1937035ejb.6
        for <linux-api@vger.kernel.org>; Fri, 23 Oct 2020 04:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gA8+CjJlncVTA5tTIhpR8Iykc8SEIsErIVYnGmyFNI4=;
        b=Ij8dIfvAABQKPbABPuO1LdAyvmXuRZmmDFS7rJgeDo/U7pvB+1+1OBXm9gLYS3cWRd
         bSrP8L13OaKlLIU6MIZ/n0EKgMJENrlo8E+4/T2RBgZ08thhhvQc7p5aljKUjKq9+0oi
         njwdZEStttOw0Ucn2VlKYzSk2oxIIv2Q3rOL0W0h5yl5XaukoT2HZBWKGeEpK79WEe1i
         tjnHYDwyHjmxcy7JWSUBDKSaLFlWTB7GZJ43Bfxcb2xHBqzkhY2Kmf1j04gIZEER8wjN
         K4EGc2mnA2ZaUPxVURu5qdxJx9QfJTH6gIt2OGMGYi+5Q5sQNxIcPZ3TsYszCx+m/rpi
         BnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gA8+CjJlncVTA5tTIhpR8Iykc8SEIsErIVYnGmyFNI4=;
        b=EfuAgz6/E7wuQpgpUDNrBdyzrybp2gLOwT87I0RBlN0PUjpXesb6m5+YRfAH6j5u6t
         Dg7mAziSlVPSAYO4/2EqHBS46rgdDkz3+fDyp7dSjX6il5g4QGSJlfXwJZB2m0JABefy
         jdLuHG3qnusVfAS4D6lNkjLCFNC6UfC7WWvtjuyb6bsh9SWQYUbXHhy5eWLkUyNPTC9T
         WO9qCHltZYw4LaEBRd91BTwbpIHQ14PTo+ZzBZrU+fyUWMXgVcka5YT2zEg+ulV3UJvm
         diBULslKPEGeITGSfHgkBmPvi7Bkyr8TlB+YY1SmLN+zB9yJ7v+f5OBjdRf1feUbSTBN
         IHsA==
X-Gm-Message-State: AOAM532gApe7yEtYbauJZaOC+RN88/AYI3zJR+tQpUgKzMK73iaTxG7J
        VjhedNK43xlHcemGY3pG6vn0RQ==
X-Google-Smtp-Source: ABdhPJy6U32NZGEonY6SHKZ+kPCGVYS983haM2WPTvvPZ9ESV4dGQ5UyeImSPWUOMhC32l0urHE/ug==
X-Received: by 2002:a17:906:354c:: with SMTP id s12mr1556614eja.263.1603453331577;
        Fri, 23 Oct 2020 04:42:11 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d24sm636604edq.34.2020.10.23.04.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 04:42:10 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:41:51 +0200
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
Subject: Re: [PATCH v3 10/14] iommu/ioasid: Introduce notification APIs
Message-ID: <20201023114151.GC2265982@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-11-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601329121-36979-11-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 28, 2020 at 02:38:37PM -0700, Jacob Pan wrote:
> Relations among IOASID users largely follow a publisher-subscriber
> pattern. E.g. to support guest SVA on Intel Scalable I/O Virtualization
> (SIOV) enabled platforms, VFIO, IOMMU, device drivers, KVM are all users
> of IOASIDs. When a state change occurs, VFIO publishes the change event
> that needs to be processed by other users/subscribers.
> 
> This patch introduced two types of notifications: global and per
> ioasid_set. The latter is intended for users who only needs to handle
> events related to the IOASID of a given set.
> For more information, refer to the kernel documentation at
> Documentation/ioasid.rst.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  57 +++++++++++++++++++-
>  2 files changed, 197 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 378fef8f23d9..894b17c06ead 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -10,12 +10,35 @@
>  #include <linux/spinlock.h>
>  #include <linux/xarray.h>
>  
> +/*
> + * An IOASID can have multiple consumers where each consumer may have
> + * hardware contexts associated with the IOASID.
> + * When a status change occurs, like on IOASID deallocation, notifier chains
> + * are used to keep the consumers in sync.
> + * This is a publisher-subscriber pattern where publisher can change the
> + * state of each IOASID, e.g. alloc/free, bind IOASID to a device and mm.
> + * On the other hand, subscribers get notified for the state change and
> + * keep local states in sync.
> + */
> +static ATOMIC_NOTIFIER_HEAD(ioasid_notifier);
> +/* List to hold pending notification block registrations */
> +static LIST_HEAD(ioasid_nb_pending_list);

nit: it might be tidier to deal with the pending list in the next patch,
since it's only relevant for mm set notifier

> +static DEFINE_SPINLOCK(ioasid_nb_lock);
> +
>  /* Default to PCIe standard 20 bit PASID */
>  #define PCI_PASID_MAX 0x100000
>  static ioasid_t ioasid_capacity = PCI_PASID_MAX;
>  static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
>  static DEFINE_XARRAY_ALLOC(ioasid_sets);
>  
> +struct ioasid_set_nb {
> +	struct list_head	list;
> +	struct notifier_block	*nb;
> +	void			*token;
> +	struct ioasid_set	*set;
> +	bool			active;
> +};
> +
>  enum ioasid_state {
>  	IOASID_STATE_INACTIVE,
>  	IOASID_STATE_ACTIVE,
> @@ -365,6 +388,42 @@ void ioasid_detach_data(ioasid_t ioasid)
>  }
>  EXPORT_SYMBOL_GPL(ioasid_detach_data);
>  
> +/**
> + * ioasid_notify - Send notification on a given IOASID for status change.
> + *
> + * @data:	The IOASID data to which the notification will send
> + * @cmd:	Notification event sent by IOASID external users, can be
> + *		IOASID_BIND or IOASID_UNBIND.
> + *
> + * @flags:	Special instructions, e.g. notify within a set or global by
> + *		IOASID_NOTIFY_FLAG_SET or IOASID_NOTIFY_FLAG_ALL flags
> + * Caller must hold ioasid_allocator_lock and reference to the IOASID
> + */
> +static int ioasid_notify(struct ioasid_data *data,
> +			 enum ioasid_notify_val cmd, unsigned int flags)
> +{
> +	struct ioasid_nb_args args = { 0 };
> +	int ret = 0;
> +
> +	/* IOASID_FREE/ALLOC are internal events emitted by IOASID core only */
> +	if (cmd <= IOASID_NOTIFY_FREE)
> +		return -EINVAL;

This function is now called with ALLOC and FREE

> +
> +	if (flags & ~(IOASID_NOTIFY_FLAG_ALL | IOASID_NOTIFY_FLAG_SET))
> +		return -EINVAL;
> +
> +	args.id = data->id;
> +	args.set = data->set;
> +	args.pdata = data->private;
> +	args.spid = data->spid;
> +	if (flags & IOASID_NOTIFY_FLAG_ALL)
> +		ret = atomic_notifier_call_chain(&ioasid_notifier, cmd, &args);
> +	if (flags & IOASID_NOTIFY_FLAG_SET)
> +		ret = atomic_notifier_call_chain(&data->set->nh, cmd, &args);

If both flags are set, we'll miss errors within the global notification.
Is that a problem?

> +
> +	return ret;
> +}
> +
>  static ioasid_t ioasid_find_by_spid_locked(struct ioasid_set *set, ioasid_t spid)
>  {
>  	ioasid_t ioasid = INVALID_IOASID;
> @@ -417,6 +476,7 @@ int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
>  		goto done_unlock;
>  	}
>  	data->spid = spid;
> +	ioasid_notify(data, IOASID_NOTIFY_BIND, IOASID_NOTIFY_FLAG_SET);
>  
>  done_unlock:
>  	spin_unlock(&ioasid_allocator_lock);
> @@ -436,6 +496,7 @@ void ioasid_detach_spid(ioasid_t ioasid)
>  		goto done_unlock;
>  	}
>  	data->spid = INVALID_IOASID;
> +	ioasid_notify(data, IOASID_NOTIFY_UNBIND, IOASID_NOTIFY_FLAG_SET);
>  
>  done_unlock:
>  	spin_unlock(&ioasid_allocator_lock);
> @@ -469,6 +530,28 @@ static inline bool ioasid_set_is_valid(struct ioasid_set *set)
>  	return xa_load(&ioasid_sets, set->id) == set;
>  }
>  
> +static void ioasid_add_pending_nb(struct ioasid_set *set)
> +{
> +	struct ioasid_set_nb *curr;
> +
> +	if (set->type != IOASID_SET_TYPE_MM)
> +		return;
> +
> +	/*
> +	 * Check if there are any pending nb requests for the given token, if so
> +	 * add them to the notifier chain.
> +	 */
> +	spin_lock(&ioasid_nb_lock);
> +	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
> +		if (curr->token == set->token && !curr->active) {
> +			atomic_notifier_chain_register(&set->nh, curr->nb);
> +			curr->set = set;
> +			curr->active = true;
> +		}
> +	}
> +	spin_unlock(&ioasid_nb_lock);
> +}
> +
>  /**
>   * ioasid_set_alloc - Allocate a new IOASID set for a given token
>   *
> @@ -556,6 +639,13 @@ struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type)
>  	set->quota = quota;
>  	set->id = id;
>  	refcount_set(&set->ref, 1);
> +	ATOMIC_INIT_NOTIFIER_HEAD(&set->nh);
> +
> +	/*
> +	 * Check if there are any pending nb requests for the given token, if so
> +	 * add them to the notifier chain.
> +	 */
> +	ioasid_add_pending_nb(set);
>  
>  	/*
>  	 * Per set XA is used to store private IDs within the set, get ready
> @@ -641,6 +731,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  		goto exit_free;
>  	}
>  	set->nr_ioasids++;
> +	ioasid_notify(data, IOASID_NOTIFY_ALLOC, IOASID_NOTIFY_FLAG_SET);
>  	goto done_unlock;
>  exit_free:
>  	kfree(data);
> @@ -687,6 +778,8 @@ static void ioasid_free_locked(struct ioasid_set *set, ioasid_t ioasid)
>  		return;
>  
>  	data->state = IOASID_STATE_FREE_PENDING;
> +	ioasid_notify(data, IOASID_NOTIFY_FREE,
> +		      IOASID_NOTIFY_FLAG_ALL | IOASID_NOTIFY_FLAG_ALL);
>  	if (!refcount_dec_and_test(&data->users))
>  		return;
>  
> @@ -726,6 +819,7 @@ EXPORT_SYMBOL_GPL(ioasid_set_get);
>  
>  static void ioasid_set_put_locked(struct ioasid_set *set)
>  {
> +	struct ioasid_set_nb *curr;
>  	struct ioasid_data *entry;
>  	unsigned long index;
>  
> @@ -757,6 +851,16 @@ static void ioasid_set_put_locked(struct ioasid_set *set)
>  	/* Return the quota back to system pool */
>  	ioasid_capacity_avail += set->quota;
>  
> +	/* Restore pending status of the set NBs */
> +	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
> +		if (curr->token == set->token) {
> +			if (curr->active)
> +				curr->active = false;
> +			else
> +				pr_warn("Set token exists but not active!\n");
> +		}
> +	}
> +
>  	/*
>  	 * Token got released right away after the ioasid_set is freed.
>  	 * If a new set is created immediately with the newly released token,
> @@ -778,7 +882,9 @@ static void ioasid_set_put_locked(struct ioasid_set *set)
>  void ioasid_set_put(struct ioasid_set *set)
>  {
>  	spin_lock(&ioasid_allocator_lock);
> +	spin_lock(&ioasid_nb_lock);
>  	ioasid_set_put_locked(set);
> +	spin_unlock(&ioasid_nb_lock);
>  	spin_unlock(&ioasid_allocator_lock);
>  }
>  EXPORT_SYMBOL_GPL(ioasid_set_put);
> @@ -980,6 +1086,41 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  }
>  EXPORT_SYMBOL_GPL(ioasid_find);
>  
> +int ioasid_register_notifier(struct ioasid_set *set, struct notifier_block *nb)

A comment might be useful, explaining that @set is optional and that the
caller should set a priority within ioasid_notifier_prios in @nb.

> +{
> +	if (set)
> +		return atomic_notifier_chain_register(&set->nh, nb);
> +	else
> +		return atomic_notifier_chain_register(&ioasid_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_register_notifier);
> +

Here as well, a comment saying that a reference to the set must be held,
though maybe that's obvious.

Thanks,
Jean

> +void ioasid_unregister_notifier(struct ioasid_set *set,
> +				struct notifier_block *nb)
> +{
> +	struct ioasid_set_nb *curr;
> +
> +	spin_lock(&ioasid_nb_lock);
> +	/*
> +	 * Pending list is registered with a token without an ioasid_set,
> +	 * therefore should not be unregistered directly.
> +	 */
> +	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
> +		if (curr->nb == nb) {
> +			pr_warn("Cannot unregister NB from pending list\n");
> +			spin_unlock(&ioasid_nb_lock);
> +			return;
> +		}
> +	}
> +	spin_unlock(&ioasid_nb_lock);
> +
> +	if (set)
> +		atomic_notifier_chain_unregister(&set->nh, nb);
> +	else
> +		atomic_notifier_chain_unregister(&ioasid_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_unregister_notifier);
> +
>  MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
>  MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
>  MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 2dfe85e6cb7e..1b551c99d568 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -23,6 +23,7 @@ enum ioasid_set_type {
>  
>  /**
>   * struct ioasid_set - Meta data about ioasid_set
> + * @nh:		List of notifiers private to that set
>   * @xa:		XArray to store ioasid_set private IDs, can be used for
>   *		guest-host IOASID mapping, or just a private IOASID namespace.
>   * @token:	Unique to identify an IOASID set
> @@ -33,6 +34,7 @@ enum ioasid_set_type {
>   * @ref:	Reference count of the users
>   */
>  struct ioasid_set {
> +	struct atomic_notifier_head nh;
>  	struct xarray xa;
>  	void *token;
>  	int type;
> @@ -58,6 +60,47 @@ struct ioasid_allocator_ops {
>  	void *pdata;
>  };
>  
> +/* Notification data when IOASID status changed */
> +enum ioasid_notify_val {
> +	IOASID_NOTIFY_ALLOC = 1,
> +	IOASID_NOTIFY_FREE,
> +	IOASID_NOTIFY_BIND,
> +	IOASID_NOTIFY_UNBIND,
> +};
> +
> +#define IOASID_NOTIFY_FLAG_ALL BIT(0)
> +#define IOASID_NOTIFY_FLAG_SET BIT(1)
> +/**
> + * enum ioasid_notifier_prios - IOASID event notification order
> + *
> + * When status of an IOASID changes, users might need to take actions to
> + * reflect the new state. For example, when an IOASID is freed due to
> + * exception, the hardware context in virtual CPU, DMA device, and IOMMU
> + * shall be cleared and drained. Order is required to prevent life cycle
> + * problems.
> + */
> +enum ioasid_notifier_prios {
> +	IOASID_PRIO_LAST,
> +	IOASID_PRIO_DEVICE,
> +	IOASID_PRIO_IOMMU,
> +	IOASID_PRIO_CPU,
> +};
> +
> +/**
> + * struct ioasid_nb_args - Argument provided by IOASID core when notifier
> + * is called.
> + * @id:		The IOASID being notified
> + * @spid:	The set private ID associated with the IOASID
> + * @set:	The IOASID set of @id
> + * @pdata:	The private data attached to the IOASID
> + */
> +struct ioasid_nb_args {
> +	ioasid_t id;
> +	ioasid_t spid;
> +	struct ioasid_set *set;
> +	void *pdata;
> +};
> +
>  #if IS_ENABLED(CONFIG_IOASID)
>  void ioasid_install_capacity(ioasid_t total);
>  ioasid_t ioasid_get_capacity(void);
> @@ -82,7 +125,10 @@ void ioasid_detach_data(ioasid_t ioasid);
>  int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
>  void ioasid_detach_spid(ioasid_t ioasid);
>  ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid);
> -
> +int ioasid_register_notifier(struct ioasid_set *set,
> +			struct notifier_block *nb);
> +void ioasid_unregister_notifier(struct ioasid_set *set,
> +				struct notifier_block *nb);
>  void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
>  				void (*fn)(ioasid_t id, void *data),
>  				void *data);
> @@ -145,6 +191,15 @@ static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*
>  	return NULL;
>  }
>  
> +static inline int ioasid_register_notifier(struct notifier_block *nb)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void ioasid_unregister_notifier(struct notifier_block *nb)
> +{
> +}
> +
>  static inline int ioasid_register_allocator(struct ioasid_allocator_ops *allocator)
>  {
>  	return -ENOTSUPP;
> -- 
> 2.7.4
> 
