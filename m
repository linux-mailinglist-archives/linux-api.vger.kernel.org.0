Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41CC3810A0
	for <lists+linux-api@lfdr.de>; Fri, 14 May 2021 21:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhENTZT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 May 2021 15:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhENTZN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 May 2021 15:25:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A21C06138B
        for <linux-api@vger.kernel.org>; Fri, 14 May 2021 12:24:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c17so443637pfn.6
        for <linux-api@vger.kernel.org>; Fri, 14 May 2021 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yN/Is6yDEDov+4EORAZyX0NripMc52bbm+zXoHoJi60=;
        b=OOJOO5woU/FSVNJOXFtzpCx8Iv3ELu4IZmtws+Bx8Df9Yc0OrFpusRR2lJAyU3cbgI
         AuHYiVNklYYACOgZ+iE5XH53G8PxcwqLieAEF1xn8ndSTBMi6Gj8Lm4uEwr2dcAqXoEj
         aHvMZwTV0RARcAx+HPP8KusSatVWbZTGd3xEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yN/Is6yDEDov+4EORAZyX0NripMc52bbm+zXoHoJi60=;
        b=CokC5tlhQZayINix6YghTaUQqi37Bf0bpoU56EpUzwOYTIkysXH1EH9XBwiycUFrl2
         vcxLCJzMRJs16/aqQEW/1Rdq7P6V2xXpUZP/0kLRBudSY1vci0AzvN8UnjuewNO54w4W
         ZCgpjdn+tlilwyauX/vKE/fZ9YeGlSk1KA7vHriZ0mEbDIvHdPOUQFUyY/SuPzDlWfW5
         Xp1fiVt3wzRZjuNVNyx2Jp8H3Z6r7OHuo0iFSkfkcJuS8b2evmZW4vDYo4d2RMMRlqv5
         z7IWMoyIvQzYMSazFl/1OTAVByP3LpUkZQCYs1y8TJHncKgsMQX3jKW/Rr977WMahjjR
         W03Q==
X-Gm-Message-State: AOAM530g4+Z8dhMjDPvcVDd7TzdkJKJ5f+PnjPCw78aGVVjrydmyK+X/
        UXIZOsVawEbTY1JBamvLH0qFmg==
X-Google-Smtp-Source: ABdhPJxYMWWbfbfgdv4rqXc8IybaHeRji8crFPuUxgpgRdpXWguYa/1m5nUoqK/mTOmEC8mr2cf5UQ==
X-Received: by 2002:aa7:95b6:0:b029:28e:aa31:dd3c with SMTP id a22-20020aa795b60000b029028eaa31dd3cmr47629775pfk.43.1621020241051;
        Fri, 14 May 2021 12:24:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b12sm1801531pjd.22.2021.05.14.12.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:24:00 -0700 (PDT)
Date:   Fri, 14 May 2021 12:23:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v26 14/25] LSM: Specify which LSM to display
Message-ID: <202105141218.21BDA22F@keescook>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-15-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513200807.15910-15-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 13, 2021 at 01:07:56PM -0700, Casey Schaufler wrote:
> Create a new entry "interface_lsm" in the procfs attr directory for
> controlling which LSM security information is displayed for a
> process. A process can only read or write its own display value.
> 
> The name of an active LSM that supplies hooks for
> human readable data may be written to "interface_lsm" to set the
> value. The name of the LSM currently in use can be read from
> "interface_lsm". At this point there can only be one LSM capable
> of display active. A helper function lsm_task_ilsm() is
> provided to get the interface lsm slot for a task_struct.
> 
> Setting the "interface_lsm" requires that all security modules using
> setprocattr hooks allow the action. Each security module is
> responsible for defining its policy.
> 
> AppArmor hook provided by John Johansen <john.johansen@canonical.com>
> SELinux hook provided by Stephen Smalley <stephen.smalley.work@gmail.com>
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-api@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> ---
>  .../ABI/testing/procfs-attr-lsm_display       |  22 +++
>  Documentation/security/lsm.rst                |  14 ++
>  fs/proc/base.c                                |   1 +
>  include/linux/lsm_hooks.h                     |  17 ++
>  security/apparmor/include/apparmor.h          |   3 +-
>  security/apparmor/lsm.c                       |  32 ++++
>  security/security.c                           | 166 ++++++++++++++++--
>  security/selinux/hooks.c                      |  11 ++
>  security/selinux/include/classmap.h           |   2 +-
>  security/smack/smack_lsm.c                    |   7 +
>  10 files changed, 256 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/ABI/testing/procfs-attr-lsm_display
> 
> diff --git a/Documentation/ABI/testing/procfs-attr-lsm_display b/Documentation/ABI/testing/procfs-attr-lsm_display
> new file mode 100644
> index 000000000000..0f60005c235c
> --- /dev/null
> +++ b/Documentation/ABI/testing/procfs-attr-lsm_display
> @@ -0,0 +1,22 @@
> +What:		/proc/*/attr/lsm_display
> +Contact:	linux-security-module@vger.kernel.org,
> +Description:	The name of the Linux security module (LSM) that will
> +		provide information in the /proc/*/attr/current,
> +		/proc/*/attr/prev and /proc/*/attr/exec interfaces.
> +		The details of permissions required to read from
> +		this interface are dependent on the LSMs active on the
> +		system.
> +		A process cannot write to this interface unless it
> +		refers to itself.
> +		The other details of permissions required to write to
> +		this interface are dependent on the LSMs active on the
> +		system.
> +		The format of the data used by this interface is a
> +		text string identifying the name of an LSM. The values
> +		accepted are:
> +			selinux		- the SELinux LSM
> +			smack		- the Smack LSM
> +			apparmor	- The AppArmor LSM
> +		By convention the LSM names are lower case and do not
> +		contain special characters.
> +Users:		LSM user-space
> diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
> index 6a2a2e973080..b77b4a540391 100644
> --- a/Documentation/security/lsm.rst
> +++ b/Documentation/security/lsm.rst
> @@ -129,3 +129,17 @@ to identify it as the first security module to be registered.
>  The capabilities security module does not use the general security
>  blobs, unlike other modules. The reasons are historical and are
>  based on overhead, complexity and performance concerns.
> +
> +LSM External Interfaces
> +=======================
> +
> +The LSM infrastructure does not generally provide external interfaces.
> +The individual security modules provide what external interfaces they
> +require.
> +
> +The file ``/sys/kernel/security/lsm`` provides a comma
> +separated list of the active security modules.
> +
> +The file ``/proc/pid/attr/interface_lsm`` contains the name of the security
> +module for which the ``/proc/pid/attr/current`` interface will
> +apply. This interface can be written to.
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 3851bfcdba56..10de522f3112 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2807,6 +2807,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>  	ATTR(NULL, "fscreate",		0666),
>  	ATTR(NULL, "keycreate",		0666),
>  	ATTR(NULL, "sockcreate",	0666),
> +	ATTR(NULL, "interface_lsm",	0666),

Anyone can open this file... (continued below)

>  #ifdef CONFIG_SECURITY_SMACK
>  	DIR("smack",			0555,
>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c61a16f0a5bc..d2c4bc94d47f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1686,4 +1686,21 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>  
>  extern int lsm_inode_alloc(struct inode *inode);
>  
> +/**
> + * lsm_task_ilsm - the "interface_lsm" for this task
> + * @task: The task to report on
> + *
> + * Returns the task's interface LSM slot.
> + */
> +static inline int lsm_task_ilsm(struct task_struct *task)
> +{
> +#ifdef CONFIG_SECURITY
> +	int *ilsm = task->security;
> +
> +	if (ilsm)
> +		return *ilsm;
> +#endif
> +	return LSMBLOB_INVALID;
> +}
> +
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/include/apparmor.h
> index 1fbabdb565a8..b1622fcb4394 100644
> --- a/security/apparmor/include/apparmor.h
> +++ b/security/apparmor/include/apparmor.h
> @@ -28,8 +28,9 @@
>  #define AA_CLASS_SIGNAL		10
>  #define AA_CLASS_NET		14
>  #define AA_CLASS_LABEL		16
> +#define AA_CLASS_DISPLAY_LSM	17
>  
> -#define AA_CLASS_LAST		AA_CLASS_LABEL
> +#define AA_CLASS_LAST		AA_CLASS_DISPLAY_LSM
>  
>  /* Control parameters settable through module/boot flags */
>  extern enum audit_mode aa_g_audit;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 392e25940d1f..4237536106aa 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -621,6 +621,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>  	return error;
>  }
>  
> +
> +static int profile_interface_lsm(struct aa_profile *profile,
> +				 struct common_audit_data *sa)
> +{
> +	struct aa_perms perms = { };
> +	unsigned int state;
> +
> +	state = PROFILE_MEDIATES(profile, AA_CLASS_DISPLAY_LSM);
> +	if (state) {
> +		aa_compute_perms(profile->policy.dfa, state, &perms);
> +		aa_apply_modes_to_perms(profile, &perms);
> +		aad(sa)->label = &profile->label;
> +
> +		return aa_check_perms(profile, &perms, AA_MAY_WRITE, sa, NULL);
> +	}
> +
> +	return 0;
> +}
> +
>  static int apparmor_setprocattr(const char *name, void *value,
>  				size_t size)
>  {
> @@ -632,6 +651,19 @@ static int apparmor_setprocattr(const char *name, void *value,
>  	if (size == 0)
>  		return -EINVAL;
>  
> +	/* LSM infrastructure does actual setting of interface_lsm if allowed */
> +	if (!strcmp(name, "interface_lsm")) {
> +		struct aa_profile *profile;
> +		struct aa_label *label;
> +
> +		aad(&sa)->info = "set interface lsm";
> +		label = begin_current_label_crit_section();
> +		error = fn_for_each_confined(label, profile,
> +					profile_interface_lsm(profile, &sa));
> +		end_current_label_crit_section(label);
> +		return error;
> +	}
> +
>  	/* AppArmor requires that the buffer must be null terminated atm */
>  	if (args[size - 1] != '\0') {
>  		/* null terminate */
> diff --git a/security/security.c b/security/security.c
> index f5407a85641e..1ce125c01782 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -77,7 +77,16 @@ static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
>  
>  char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +
> +/*
> + * The task blob includes the "interface_lsm" slot used for
> + * chosing which module presents contexts.
> + * Using a long to avoid potential alignment issues with
> + * module assigned task blobs.
> + */
> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
> +	.lbs_task = sizeof(long),
> +};
>  
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_lsm_order;
> @@ -669,6 +678,8 @@ int lsm_inode_alloc(struct inode *inode)
>   */
>  static int lsm_task_alloc(struct task_struct *task)
>  {
> +	int *ilsm;
> +
>  	if (blob_sizes.lbs_task == 0) {
>  		task->security = NULL;
>  		return 0;
> @@ -677,6 +688,15 @@ static int lsm_task_alloc(struct task_struct *task)
>  	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>  	if (task->security == NULL)
>  		return -ENOMEM;
> +
> +	/*
> +	 * The start of the task blob contains the "interface" LSM slot number.
> +	 * Start with it set to the invalid slot number, indicating that the
> +	 * default first registered LSM be displayed.
> +	 */
> +	ilsm = task->security;
> +	*ilsm = LSMBLOB_INVALID;
> +
>  	return 0;
>  }
>  
> @@ -1732,14 +1752,26 @@ int security_file_open(struct file *file)
>  
>  int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
>  {
> +	int *oilsm = current->security;
> +	int *nilsm;
>  	int rc = lsm_task_alloc(task);
>  
> -	if (rc)
> +	if (unlikely(rc))
>  		return rc;
> +
>  	rc = call_int_hook(task_alloc, 0, task, clone_flags);
> -	if (unlikely(rc))
> +	if (unlikely(rc)) {
>  		security_task_free(task);
> -	return rc;
> +		return rc;
> +	}
> +
> +	if (oilsm) {
> +		nilsm = task->security;
> +		if (nilsm)
> +			*nilsm = *oilsm;
> +	}
> +
> +	return 0;
>  }
>  
>  void security_task_free(struct task_struct *task)
> @@ -2171,23 +2203,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  				char **value)
>  {
>  	struct security_hook_list *hp;
> +	int ilsm = lsm_task_ilsm(current);
> +	int slot = 0;
> +
> +	if (!strcmp(name, "interface_lsm")) {
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0)
> +			return -EINVAL;
> +
> +		/*
> +		 * Only allow getting the current process' interface_lsm.
> +		 * There are too few reasons to get another process'
> +		 * interface_lsm and too many LSM policy issues.
> +		 */
> +		if (current != p)
> +			return -EINVAL;

... but context isn't established by just checking "current", as this
file handle may have been given to another process.

I suspect the security_get/setprocattr needs to gain a pointer to "file"
so that the f_cred struct can be examined[1] (i.e. compare opener
against reader/writer).

[1] https://www.kernel.org/doc/html/latest/security/credentials.html#open-file-credentials

> +
> +		ilsm = lsm_task_ilsm(p);
> +		if (ilsm != LSMBLOB_INVALID)
> +			slot = ilsm;
> +		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
> +		if (*value)
> +			return strlen(*value);
> +		return -ENOMEM;
> +	}
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> +		if (lsm == NULL && ilsm != LSMBLOB_INVALID &&
> +		    ilsm != hp->lsmid->slot)
> +			continue;
>  		return hp->hook.getprocattr(p, name, value);
>  	}
>  	return LSM_RET_DEFAULT(getprocattr);
>  }
>  
> +/**
> + * security_setprocattr - Set process attributes via /proc
> + * @lsm: name of module involved, or NULL
> + * @name: name of the attribute
> + * @value: value to set the attribute to
> + * @size: size of the value
> + *
> + * Set the process attribute for the specified security module
> + * to the specified value. Note that this can only be used to set
> + * the process attributes for the current, or "self" process.
> + * The /proc code has already done this check.
> + *
> + * Returns 0 on success, an appropriate code otherwise.
> + */
>  int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size)
>  {
>  	struct security_hook_list *hp;
> +	char *termed;
> +	char *copy;
> +	int *ilsm = current->security;
> +	int rc = -EINVAL;
> +	int slot = 0;
> +
> +	if (!strcmp(name, "interface_lsm")) {
> +		/*
> +		 * Change the "interface_lsm" value only if all the security
> +		 * modules that support setting a procattr allow it.
> +		 * It is assumed that all such security modules will be
> +		 * cooperative.
> +		 */
> +		if (size == 0)
> +			return -EINVAL;
> +
> +		hlist_for_each_entry(hp, &security_hook_heads.setprocattr,
> +				     list) {
> +			rc = hp->hook.setprocattr(name, value, size);
> +			if (rc < 0)
> +				return rc;
> +		}

Similarly here -- how do the LSMs reason about who actually _opened_
this file?

-Kees

> +
> +		rc = -EINVAL;
> +
> +		copy = kmemdup_nul(value, size, GFP_KERNEL);
> +		if (copy == NULL)
> +			return -ENOMEM;
> +
> +		termed = strsep(&copy, " \n");
> +
> +		for (slot = 0; slot < lsm_slot; slot++)
> +			if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
> +				*ilsm = lsm_slotlist[slot]->slot;
> +				rc = size;
> +				break;
> +			}
> +
> +		kfree(termed);
> +		return rc;
> +	}
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> +		if (lsm == NULL && *ilsm != LSMBLOB_INVALID &&
> +		    *ilsm != hp->lsmid->slot)
> +			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
>  	return LSM_RET_DEFAULT(setprocattr);
> @@ -2207,15 +2326,15 @@ EXPORT_SYMBOL(security_ismaclabel);
>  int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>  {
>  	struct security_hook_list *hp;
> -	int rc;
> +	int ilsm = lsm_task_ilsm(current);
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;
> -		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
> -					      secdata, seclen);
> -		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
> -			return rc;
> +		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
> +			return hp->hook.secid_to_secctx(
> +					blob->secid[hp->lsmid->slot],
> +					secdata, seclen);
>  	}
>  
>  	return LSM_RET_DEFAULT(secid_to_secctx);
> @@ -2226,16 +2345,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *blob)
>  {
>  	struct security_hook_list *hp;
> -	int rc;
> +	int ilsm = lsm_task_ilsm(current);
>  
>  	lsmblob_init(blob, 0);
>  	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;
> -		rc = hp->hook.secctx_to_secid(secdata, seclen,
> -					      &blob->secid[hp->lsmid->slot]);
> -		if (rc != 0)
> -			return rc;
> +		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
> +			return hp->hook.secctx_to_secid(secdata, seclen,
> +						&blob->secid[hp->lsmid->slot]);
>  	}
>  	return 0;
>  }
> @@ -2243,7 +2361,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
>  
>  void security_release_secctx(char *secdata, u32 seclen)
>  {
> -	call_void_hook(release_secctx, secdata, seclen);
> +	struct security_hook_list *hp;
> +	int ilsm = lsm_task_ilsm(current);
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> +		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot) {
> +			hp->hook.release_secctx(secdata, seclen);
> +			return;
> +		}
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>  
> @@ -2384,8 +2509,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>  				      int __user *optlen, unsigned len)
>  {
> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
> -				optval, optlen, len);
> +	int ilsm = lsm_task_ilsm(current);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
> +			     list)
> +		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
> +			return hp->hook.socket_getpeersec_stream(sock, optval,
> +								 optlen, len);
> +	return -ENOPROTOOPT;
>  }
>  
>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0133b142e938..dba867721336 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6510,6 +6510,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  	/*
>  	 * Basic control over ability to set these attributes at all.
>  	 */
> +
> +	/*
> +	 * For setting interface_lsm, we only perform a permission check;
> +	 * the actual update to the interface_lsm value is handled by the
> +	 * LSM framework.
> +	 */
> +	if (!strcmp(name, "interface_lsm"))
> +		return avc_has_perm(&selinux_state,
> +				    mysid, mysid, SECCLASS_PROCESS2,
> +				    PROCESS2__SETDISPLAY, NULL);
> +
>  	if (!strcmp(name, "exec"))
>  		error = avc_has_perm(&selinux_state,
>  				     mysid, mysid, SECCLASS_PROCESS,
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 62d19bccf3de..8f4b0dd6dd78 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -53,7 +53,7 @@ struct security_class_mapping secclass_map[] = {
>  	    "execmem", "execstack", "execheap", "setkeycreate",
>  	    "setsockcreate", "getrlimit", NULL } },
>  	{ "process2",
> -	  { "nnp_transition", "nosuid_transition", NULL } },
> +	  { "nnp_transition", "nosuid_transition", "setdisplay", NULL } },
>  	{ "system",
>  	  { "ipc_info", "syslog_read", "syslog_mod",
>  	    "syslog_console", "module_request", "module_load", NULL } },
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 5c10ad27be37..7aa7ea38f627 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3508,6 +3508,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>  	struct smack_known_list_elem *sklep;
>  	int rc;
>  
> +	/*
> +	 * Allow the /proc/.../attr/current and SO_PEERSEC "interface_lsm"
> +	 * to be reset at will.
> +	 */
> +	if (strcmp(name, "interface_lsm") == 0)
> +		return 0;
> +
>  	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
>  		return -EPERM;
>  
> -- 
> 2.29.2
> 

-- 
Kees Cook
