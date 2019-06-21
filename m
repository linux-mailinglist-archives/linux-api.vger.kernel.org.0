Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F194DF4D
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 05:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfFUDWC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 23:22:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35540 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfFUDWC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 23:22:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so2282191plo.2
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 20:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XgqQCjlp6+2QBmDqcbVi4QnHGPaF4Oeb1ed6x/spUgc=;
        b=TyRK0SGkcI8RWa+mEkKtt8IE0pvJpD1cYzcIr4iNZmMTZMlDZkL0kb7sUh9/eyZiJk
         Kn6p8vwmzyKy/M8flUqPVDS23YwYNmzB0udQDAxRCq5/KYAlwyP3M6bcXoF1w8t4LgTu
         Wjvq8nBxv9nubBwSMfwZj6QiJIJ8Xt2jPz3hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XgqQCjlp6+2QBmDqcbVi4QnHGPaF4Oeb1ed6x/spUgc=;
        b=rIpIjig5qtV4PLWs3X6lfV2k2OMEkPZl2BIXVNyjhVg4RPB/Vw0tvqZkwsVgd7HzmM
         TqJ4YTQKXLdwh82heove+YV8LMmtBIPpi/Lf1NfCFkj2W76bZb4nhUSnNJS9BDhhy7LW
         f7e1dle2pul92FiZE93mnp54TBHOSBj35hnGAgqlrqAKf+9IBPNIHcK0TWDTJKZtwDWM
         mMIQaYG9rno86LjJKUTQSSyHPKpl41quJXkuV8/WlBNkKcvuudQbHM6dj77JVXpT9CBK
         LER7zXSmmLRVHpV2RLddKOkftjsWGQNdigfXpSbceartBcuRnDfl3nd57awE55Z1Siwd
         W1Hw==
X-Gm-Message-State: APjAAAVTJN5YHBzgjuzCi46NsTh32Yi82TExxBA151qKp8+h4pNlDuK5
        ahsB8VsILJuHhkZPI0Piovs78g==
X-Google-Smtp-Source: APXvYqx/dheNVHWmM09UQ9EC2eP1Lt7RZ1CxQtCV6ga5L5OGljy8W2hLaBGZOjTfAZfJkPLogoJhtA==
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr19024424plb.84.1561087321332;
        Thu, 20 Jun 2019 20:22:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3sm917324pgo.81.2019.06.20.20.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 20:22:00 -0700 (PDT)
Date:   Thu, 20 Jun 2019 20:21:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V33 01/30] security: Support early LSMs
Message-ID: <201906202010.49D16E03@keescook>
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-2-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621011941.186255-2-matthewgarrett@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 06:19:12PM -0700, Matthew Garrett wrote:
> The lockdown module is intended to allow for kernels to be locked down
> early in boot - sufficiently early that we don't have the ability to
> kmalloc() yet. Add support for early initialisation of some LSMs, and
> then add them to the list of names when we do full initialisation later.

So, if I'm reading correctly, these "early LSMs":

- start up before even boot parameter parsing has happened
- have their position in the LSM ordering ignored
- are initialized in boot order
- cannot use kmalloc, as well as probably lots of other things

> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  include/asm-generic/vmlinux.lds.h |  8 +++++-
>  include/linux/lsm_hooks.h         |  6 ++++
>  include/linux/security.h          |  1 +
>  init/main.c                       |  1 +
>  security/security.c               | 48 +++++++++++++++++++++++++------
>  5 files changed, 54 insertions(+), 10 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index f8f6f04c4453..e1963352fdb6 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -208,8 +208,13 @@
>  			__start_lsm_info = .;				\
>  			KEEP(*(.lsm_info.init))				\
>  			__end_lsm_info = .;
> +#define EARLY_LSM_TABLE()	. = ALIGN(8);				\
> +			__start_early_lsm_info = .;			\
> +			KEEP(*(.early_lsm_info.init))			\
> +			__end_early_lsm_info = .;
>  #else
>  #define LSM_TABLE()
> +#define EARLY_LSM_TABLE()
>  #endif
>  
>  #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
> @@ -610,7 +615,8 @@
>  	ACPI_PROBE_TABLE(irqchip)					\
>  	ACPI_PROBE_TABLE(timer)						\
>  	EARLYCON_TABLE()						\
> -	LSM_TABLE()
> +	LSM_TABLE()							\
> +	EARLY_LSM_TABLE()
>  
>  #define INIT_TEXT							\
>  	*(.init.text .init.text.*)					\
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a240a3fc5fc4..66fd1eac7a32 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2085,12 +2085,18 @@ struct lsm_info {
>  };
>  
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
> +extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  
>  #define DEFINE_LSM(lsm)							\
>  	static struct lsm_info __lsm_##lsm				\
>  		__used __section(.lsm_info.init)			\
>  		__aligned(sizeof(unsigned long))
>  
> +#define DEFINE_EARLY_LSM(lsm)						\
> +	static struct lsm_info __early_lsm_##lsm			\
> +		__used __section(.early_lsm_info.init)			\
> +		__aligned(sizeof(unsigned long))
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  /*
>   * Assuring the safety of deleting a security module is up to
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 49f2685324b0..1bb6fb2f1523 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -194,6 +194,7 @@ int unregister_lsm_notifier(struct notifier_block *nb);
>  
>  /* prototypes */
>  extern int security_init(void);
> +extern int early_security_init(void);
>  
>  /* Security operations */
>  int security_binder_set_context_mgr(struct task_struct *mgr);
> diff --git a/init/main.c b/init/main.c
> index 598e278b46f7..f3faeb89c75f 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -563,6 +563,7 @@ asmlinkage __visible void __init start_kernel(void)
>  	boot_cpu_init();
>  	page_address_init();
>  	pr_notice("%s", linux_banner);
> +	early_security_init();
>  	setup_arch(&command_line);
>  	/*
>  	 * Set up the the initial canary and entropy after arch
> diff --git a/security/security.c b/security/security.c
> index 23cbb1a295a3..2a6672c9e72f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -37,6 +37,7 @@
>  
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> +#define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
>  
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> @@ -281,6 +282,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  static void __init lsm_early_cred(struct cred *cred);
>  static void __init lsm_early_task(struct task_struct *task);
>  
> +static int lsm_append(const char *new, char **result);
> +
>  static void __init ordered_lsm_init(void)
>  {
>  	struct lsm_info **lsm;
> @@ -327,15 +330,11 @@ static void __init ordered_lsm_init(void)
>  	kfree(ordered_lsms);
>  }
>  
> -/**
> - * security_init - initializes the security framework
> - *
> - * This should be called early in the kernel initialization sequence.
> - */
> -int __init security_init(void)
> +int __init early_security_init(void)
>  {
>  	int i;
>  	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
> +	struct lsm_info *lsm;
>  
>  	pr_info("Security Framework initializing\n");

I'd rather this was kept in security_init() since it's the string to
search for when debugging normal LSM initialization.

>  
> @@ -343,6 +342,30 @@ int __init security_init(void)
>  	     i++)
>  		INIT_HLIST_HEAD(&list[i]);
>  
> +	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +		if (!lsm->enabled)
> +			lsm->enabled = &lsm_enabled_true;
> +		initialize_lsm(lsm);
> +	}

This should call prepare_lsm() before initialize_lsm(). While not needed
for this specific LSM, it would be nice to at least do the blog size
calculations and keep everything the same as other LSMs.

> +
> +	return 0;
> +}
> +
> +/**
> + * security_init - initializes the security framework
> + *
> + * This should be called early in the kernel initialization sequence.
> + */
> +int __init security_init(void)
> +{
> +	struct lsm_info *lsm;
> +
> +	/* Append the names of the early LSM modules now */

I would clarify this comment more: "... that kmalloc() is available."

> +	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +		if (lsm->enabled)
> +			lsm_append(lsm->name, &lsm_names);
> +	}
> +
>  	/* Load LSMs in specified order. */
>  	ordered_lsm_init();
>  
> @@ -388,7 +411,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
>  	return !strcmp(last, lsm);
>  }
>  
> -static int lsm_append(char *new, char **result)
> +static int lsm_append(const char *new, char **result)
>  {
>  	char *cp;
>  
> @@ -426,8 +449,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		hooks[i].lsm = lsm;
>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>  	}
> -	if (lsm_append(lsm, &lsm_names) < 0)
> -		panic("%s - Cannot get early memory.\n", __func__);
> +
> +	/*
> +	 * Don't try to append during early_security_init(), we'll come back
> +	 * and fix this up afterwards.
> +	 */
> +	if (slab_is_available()) {
> +		if (lsm_append(lsm, &lsm_names) < 0)
> +			panic("%s - Cannot get early memory.\n", __func__);
> +	}
>  }
>  
>  int call_lsm_notifier(enum lsm_event event, void *data)
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
