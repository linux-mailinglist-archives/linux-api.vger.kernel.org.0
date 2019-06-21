Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C564DF5C
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 05:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfFUDo3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 23:44:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42800 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfFUDo3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 23:44:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so2829721pff.9
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 20:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PTeOwZy4aOgRuojYRuNXwAvKgqNLH2fT2ARYBGhAVxg=;
        b=B361iDkAs/UaZmteQUaZv5FCAGFi0l3pG+iIq/rYh15zRDavf2xgXJGXHS98WmBG29
         1E5bHlbV8k1zOYx+28eFZ/N+u9/nl+KUcXzfh4jruLRUy7AMXuu9qOdcuQTr2laMEIDf
         ofxvgc7DTPIhZmEB0Ad1gap6aYB8YDoWGhC14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PTeOwZy4aOgRuojYRuNXwAvKgqNLH2fT2ARYBGhAVxg=;
        b=OtFvkaaYlCb8cSWjiDFbRiqKULoII6ko8RtnLP5J/wHKkgV+LJzNEI3a4cUGH6BSwL
         rlO5kU6Xmlka0NsmwZXbuWOTbi8KvL+RIc1ONwaJZ6LWyjgsowqsL5sab47bdZnaOzeY
         8lhNHep/lEeYs9DnGqqDuyW616ChEqjrAIGGbLqre5vjEj9QcbkKIBA3OVV/ZlSVtjFG
         /7b+lEePUFHpGNjNL1satGDVHj3btEcq/tMiaqdK5zB1w6kZqwCH3S8Mi1OS1LBJoSNp
         sZdMj9gDpfKS88sMR5KnWnAYNf+TqfihsTSNfoBCNEI1zEkWzMTDXeKJ+ZaOBZUyqBBC
         s0IA==
X-Gm-Message-State: APjAAAWPiUkzoBeau+FhWdDVxK9NLimUgKUgTse6c9dw0z1HO1YB94Un
        6NZe70Wqru3hDhesZihnjv//cw==
X-Google-Smtp-Source: APXvYqweoE6eZMIiQsorYngKSbrl7+Gj9cLyH2cr9VOnsuiNXxN5dFTQXEIgQF8YpPwJHR967l0J0A==
X-Received: by 2002:a63:6183:: with SMTP id v125mr11440903pgb.221.1561088668128;
        Thu, 20 Jun 2019 20:44:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1sm926805pgv.15.2019.06.20.20.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 20:44:27 -0700 (PDT)
Date:   Thu, 20 Jun 2019 20:44:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V33 03/30] security: Add a static lockdown policy LSM
Message-ID: <201906202028.5AB58C3@keescook>
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-4-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621011941.186255-4-matthewgarrett@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 06:19:14PM -0700, Matthew Garrett wrote:
> While existing LSMs can be extended to handle lockdown policy,
> distributions generally want to be able to apply a straightforward
> static policy. This patch adds a simple LSM that can be configured to
> reject either integrity or all lockdown queries, and can be configured
> at runtime (through securityfs), boot time (via a kernel parameter) or
> build time (via a kconfig option). Based on initial code by David
> Howells.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: David Howells <dhowells@redhat.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   9 +
>  include/linux/security.h                      |   4 +
>  security/Kconfig                              |   3 +-
>  security/Makefile                             |   2 +
>  security/lockdown/Kconfig                     |  46 +++++
>  security/lockdown/Makefile                    |   1 +
>  security/lockdown/lockdown.c                  | 168 ++++++++++++++++++
>  7 files changed, 232 insertions(+), 1 deletion(-)
>  create mode 100644 security/lockdown/Kconfig
>  create mode 100644 security/lockdown/Makefile
>  create mode 100644 security/lockdown/lockdown.c
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2b8ee90bb644..fa336f6cd5bc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2239,6 +2239,15 @@
>  	lockd.nlm_udpport=M	[NFS] Assign UDP port.
>  			Format: <integer>
>  
> +	lockdown=	[SECURITY]
> +			{ integrity | confidentiality }
> +			Enable the kernel lockdown feature. If set to
> +			integrity, kernel features that allow userland to
> +			modify the running kernel are disabled. If set to
> +			confidentiality, kernel features that allow userland
> +			to extract confidential information from the kernel
> +			are also disabled.
> +
>  	locktorture.nreaders_stress= [KNL]
>  			Set the number of locking read-acquisition kthreads.
>  			Defaults to being automatically set based on the
> diff --git a/include/linux/security.h b/include/linux/security.h
> index b75941c811e6..a86a7739ca24 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -76,6 +76,10 @@ enum lsm_event {
>  	LSM_POLICY_CHANGE,
>  };
>  
> +/*
> + *  If you add to this, remember to extend lockdown_reasons in
> + *  security/lockdown/lockdown.c.
> + */

Best to add something like:

BUILD_BUG_ON(ARRAY_SIZE(lockdown_reasons), LOCKDOWN_CONFIDENTIALLY_MAX);

to actually enforce this.

>  enum lockdown_reason {
>  	LOCKDOWN_NONE,
>  	LOCKDOWN_INTEGRITY_MAX,
> diff --git a/security/Kconfig b/security/Kconfig
> index 1d6463fb1450..c35aa72103df 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -236,12 +236,13 @@ source "security/apparmor/Kconfig"
>  source "security/loadpin/Kconfig"
>  source "security/yama/Kconfig"
>  source "security/safesetid/Kconfig"
> +source "security/lockdown/Kconfig"
>  
>  source "security/integrity/Kconfig"
>  
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> +	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

Is this needed? It seems like the early LSMs are totally ignored for
ordering?

>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be ignored. This can be
> diff --git a/security/Makefile b/security/Makefile
> index c598b904938f..be1dd9d2cb2f 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -11,6 +11,7 @@ subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
>  subdir-$(CONFIG_SECURITY_YAMA)		+= yama
>  subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
>  subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
> +subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
>  
>  # always enable default capabilities
>  obj-y					+= commoncap.o
> @@ -27,6 +28,7 @@ obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
>  obj-$(CONFIG_SECURITY_YAMA)		+= yama/
>  obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
>  obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
> +obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
>  obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
>  
>  # Object integrity file lists
> diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
> new file mode 100644
> index 000000000000..431cd2b9a14e
> --- /dev/null
> +++ b/security/lockdown/Kconfig
> @@ -0,0 +1,46 @@
> +config SECURITY_LOCKDOWN_LSM
> +	bool "Basic module for enforcing kernel lockdown"
> +	depends on SECURITY
> +	help
> +	  Build support for an LSM that enforces a coarse kernel lockdown
> +	  behaviour.
> +
> +config SECURITY_LOCKDOWN_LSM_EARLY
> +        bool "Enable lockdown LSM early in init"

whitespace glitches?

> +	depends on SECURITY_LOCKDOWN_LSM
> +	help
> +	  Enable the lockdown LSM early in boot. This is necessary in order
> +	  to ensure that lockdown enforcement can be carried out on kernel
> +	  boot parameters that are otherwise parsed before the security
> +	  subsystem is fully initialised.
> +
> +choice
> +	prompt "Kernel default lockdown mode"
> +	default LOCK_DOWN_KERNEL_FORCE_NONE
> +	depends on SECURITY_LOCKDOWN_LSM
> +	help
> +	  The kernel can be configured to default to differing levels of
> +	  lockdown.
> +
> +config LOCK_DOWN_KERNEL_FORCE_NONE
> +       bool "None"
> +       help
> +          No lockdown functionality is enabled by default. Lockdown may be
> +	  enabled via the kernel commandline or /sys/kernel/security/lockdown.
> +
> +config LOCK_DOWN_KERNEL_FORCE_INTEGRITY
> +       bool "Integrity"
> +       help
> +         The kernel runs in integrity mode by default. Features that allow
> +	 the kernel to be modified at runtime are disabled.
> +
> +config LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
> +       bool "Confidentiality"
> +       help
> +         The kernel runs in confidentiality mode by default. Features that
> +	 allow the kernel to be modified at runtime or that permit userland
> +	 code to read confidential material held inside the kernel are
> +	 disabled.
> +
> +endchoice
> +
> diff --git a/security/lockdown/Makefile b/security/lockdown/Makefile
> new file mode 100644
> index 000000000000..e3634b9017e7
> --- /dev/null
> +++ b/security/lockdown/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_SECURITY_LOCKDOWN_LSM) += lockdown.o
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> new file mode 100644
> index 000000000000..1ecb2eecb245
> --- /dev/null
> +++ b/security/lockdown/lockdown.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Lock down the kernel
> + *
> + * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.
> + */
> +
> +#include <linux/security.h>
> +#include <linux/export.h>
> +#include <linux/lsm_hooks.h>
> +
> +static enum lockdown_reason kernel_locked_down;

What's the use-case for runtime changing this value? (If you didn't, you
could make it __ro_after_init.)

> +
> +static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
> +	[LOCKDOWN_NONE] = "none",
> +	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
> +	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
> +};
> +
> +static enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
> +						 LOCKDOWN_INTEGRITY_MAX,
> +						 LOCKDOWN_CONFIDENTIALITY_MAX};
> +
> +/*
> + * Put the kernel into lock-down mode.
> + */
> +static int lock_kernel_down(const char *where, enum lockdown_reason level)
> +{
> +	if (kernel_locked_down >= level)
> +		return -EPERM;
> +
> +	kernel_locked_down = level;
> +	pr_notice("Kernel is locked down from %s; see man kernel_lockdown.7\n",
> +		  where);
> +	return 0;
> +}
> +
> +static int __init lockdown_param(char *level)
> +{
> +	if (!level)
> +		return -EINVAL;
> +
> +	if (strcmp(level, "integrity") == 0)
> +		lock_kernel_down("command line", LOCKDOWN_INTEGRITY_MAX);
> +	else if (strcmp(level, "confidentiality") == 0)
> +		lock_kernel_down("command line", LOCKDOWN_CONFIDENTIALITY_MAX);
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +early_param("lockdown", lockdown_param);
> +
> +/**
> + * lockdown_is_locked_down - Find out if the kernel is locked down
> + * @what: Tag to use in notice generated if lockdown is in effect
> + */
> +static int lockdown_is_locked_down(enum lockdown_reason what)
> +{	
> +	if ((kernel_locked_down >= what) && lockdown_reasons[what])
> +		pr_notice("Lockdown: %s is restricted; see man kernel_lockdown.7\n",
> +			  lockdown_reasons[what]);
> +	return (kernel_locked_down >= what);
> +}
> +
> +static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
> +	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
> +};
> +
> +static int __init lockdown_lsm_init(void)
> +{
> +#if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
> +	lock_kernel_down("Kernel configuration", LOCKDOWN_INTEGRITY_MAX);
> +#elif defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY)
> +	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
> +#endif
> +	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
> +			   "lockdown");
> +	return 0;
> +}
> +
> +static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
> +			     loff_t *ppos)
> +{
> +	char temp[80];
> +	int i, offset=0;
> +
> +	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
> +		enum lockdown_reason level = lockdown_levels[i];
> +
> +		if (lockdown_reasons[level]) {
> +			const char *label = lockdown_reasons[level];
> +
> +			if (kernel_locked_down == level)
> +				offset += sprintf(temp+offset, "[%s] ", label);
> +			else
> +				offset += sprintf(temp+offset, "%s ", label);
> +		}
> +	}

I thought there were helpers for this kind of thing?

> +
> +	/* Convert the last space to a newline if needed. */
> +	if (offset > 0)
> +		temp[offset-1] = '\n';
> +
> +	return simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
> +}
> +
> +static ssize_t lockdown_write(struct file *file, const char __user *buf,
> +			      size_t n, loff_t *ppos)
> +{
> +	char *state;
> +	int i, len, err = -EINVAL;
> +
> +	state = memdup_user_nul(buf, n);
> +	if (IS_ERR(state))
> +		return PTR_ERR(state);
> +
> +	len = strlen(state);
> +	if (len && state[len-1] == '\n') {
> +		state[len-1] = '\0';
> +		len--;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
> +		enum lockdown_reason level = lockdown_levels[i];
> +		const char *label = lockdown_reasons[level];
> +
> +		if (label && !strcmp(state, label))
> +			err = lock_kernel_down("securityfs", level);
> +	}
> +
> +	kfree(state);
> +	return err ? err : n;
> +}
> +
> +static const struct file_operations lockdown_ops = {
> +	.read  = lockdown_read,
> +	.write = lockdown_write,
> +};
> +
> +static int __init lockdown_secfs_init(void)
> +{
> +	struct dentry *dentry;
> +
> +	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
> +					&lockdown_ops);
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
> +	return 0;
> +}
> +
> +core_initcall(lockdown_secfs_init);
> +
> +#ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
> +DEFINE_EARLY_LSM(lockdown) = {
> +#else
> +DEFINE_LSM(lockdown) = {
> +#endif

Ah, I see now: it *might* be an early LSM. What states are missed if not
early? Only parameters? I think the behavior differences need to be
spelled out in Kconfig (or somewhere...)

> +	.name = "lockdown",
> +	.init = lockdown_lsm_init,
> +};
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
