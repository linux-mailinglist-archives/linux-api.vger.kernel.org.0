Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED419828D
	for <lists+linux-api@lfdr.de>; Mon, 30 Mar 2020 19:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgC3RlU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 13:41:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36773 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbgC3RlQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Mar 2020 13:41:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id i13so8942198pfe.3
        for <linux-api@vger.kernel.org>; Mon, 30 Mar 2020 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9A9BFDWaBKeFJEhXv569Hcf1cU3lWJT2qzpJ99N8MCk=;
        b=c588ptYqwCmsWEonO588jIjpypgAAMTUL58QUCwA/bBLmIORgJNEOXJxHmUoCvXzNS
         qdwHBXTKTzAdmAMY7lWdJG4D14txV1wst9CUI7g7DNIHQb4vdQiWZpRkHcyxl4Wx8ifz
         fwzua6wxK/EOmnxeRkV1nUTb+4EQjsgGp6C9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9A9BFDWaBKeFJEhXv569Hcf1cU3lWJT2qzpJ99N8MCk=;
        b=iFovWET3eEJObfHtrs4FSs77nI2cdudliyXI8WM3tfRveFue//X8F9koQ7/exVYwuI
         f2/4/lqzbu4V3aI3QL8Aq4Ya7gc5l9yl3FJWkMc/tlbH7gvM5BTijIUwElyYr1NjMLS3
         glpcZOXzvkeLHDzOtO7TSxoztVOUNPZXJNUkMMg0N6N5fZDpq0XRdAhJS6gYAGKg2shI
         xammNzhC0dGuKeFISo6VXDTDfrd2dhu0/RStV7h72hFQeFWxBPaH6xKWtgAMkaTM4X/S
         olC15QCFP5TM15Ce3hecPpuCvJaXSJ3xeTuobAqNUGoM8RVpUbP7hUcaeblahoQtKjZB
         XIeQ==
X-Gm-Message-State: ANhLgQ3sbAfJgP14KtyMIN1P8KIreakYyGtDJG+R1KffbFxm3LepDs/6
        2jUIuBWMpQeKahkHYiUzlOwH4Q==
X-Google-Smtp-Source: ADFU+vuP1FGs+E8bbM6cuPnbi2RGCCdWSTAmb5Pnlf37InzDZNSuZ3SNT/PxgA7MaMnVZYPI0R1hRQ==
X-Received: by 2002:a63:6d02:: with SMTP id i2mr13505140pgc.267.1585590073404;
        Mon, 30 Mar 2020 10:41:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x75sm10741891pfc.161.2020.03.30.10.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:41:12 -0700 (PDT)
Date:   Mon, 30 Mar 2020 10:41:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/3] kernel/sysctl: support handling command line aliases
Message-ID: <202003301041.86E6C7EB@keescook>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330115535.3215-3-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 30, 2020 at 01:55:34PM +0200, Vlastimil Babka wrote:
> We can now handle sysctl parameters on kernel command line, but historically
> some parameters introduced their own command line equivalent, which we don't
> want to remove for compatibility reasons. We can however convert them to the
> generic infrastructure with a table translating the legacy command line
> parameters to their sysctl names, and removing the one-off param handlers.
> 
> This patch adds the support and makes the first conversion to demonstrate it,
> on the (deprecated) numa_zonelist_order parameter.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/proc/proc_sysctl.c | 48 ++++++++++++++++++++++++++++++++++++-------
>  mm/page_alloc.c       |  9 --------
>  2 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 653188c9c4c9..97eb0b552bf8 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1727,6 +1727,37 @@ int __init proc_sys_init(void)
>  	return sysctl_init();
>  }
>  
> +struct sysctl_alias {
> +	const char *kernel_param;
> +	const char *sysctl_param;
> +};
> +
> +/*
> + * Historically some settings had both sysctl and a command line parameter.
> + * With the generic sysctl. parameter support, we can handle them at a single
> + * place and only keep the historical name for compatibility. This is not meant
> + * to add brand new aliases. When adding existing aliases, consider whether
> + * the possibly different moment of changing the value (e.g. from early_param
> + * to the moment do_sysctl_args() is called) is an issue for the specific
> + * parameter.
> + */
> +static const struct sysctl_alias sysctl_aliases[] = {
> +	{"numa_zonelist_order",		"vm.numa_zonelist_order" },
> +	{ }
> +};
> +
> +static const char *sysctl_find_alias(char *param)
> +{
> +	const struct sysctl_alias *alias;
> +
> +	for (alias = &sysctl_aliases[0]; alias->kernel_param != NULL; alias++) {
> +		if (strcmp(alias->kernel_param, param) == 0)
> +			return alias->sysctl_param;
> +	}
> +
> +	return NULL;
> +}
> +
>  /* Set sysctl value passed on kernel command line. */
>  static int process_sysctl_arg(char *param, char *val,
>  			       const char *unused, void *arg)
> @@ -1740,15 +1771,18 @@ static int process_sysctl_arg(char *param, char *val,
>  	loff_t pos = 0;
>  	ssize_t wret;
>  
> -	if (strncmp(param, "sysctl", sizeof("sysctl") - 1))
> -		return 0;
> -
> -	param += sizeof("sysctl") - 1;
> +	if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
> +		param += sizeof("sysctl") - 1;
>  
> -	if (param[0] != '/' && param[0] != '.')
> -		return 0;
> +		if (param[0] != '/' && param[0] != '.')
> +			return 0;
>  
> -	param++;
> +		param++;
> +	} else {
> +		param = (char *) sysctl_find_alias(param);
> +		if (!param)
> +			return 0;
> +	}
>  
>  	if (!proc_mnt) {
>  		proc_fs_type = get_fs_type("proc");
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..de7a134b1b8a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5460,15 +5460,6 @@ static int __parse_numa_zonelist_order(char *s)
>  	return 0;
>  }
>  
> -static __init int setup_numa_zonelist_order(char *s)
> -{
> -	if (!s)
> -		return 0;
> -
> -	return __parse_numa_zonelist_order(s);
> -}
> -early_param("numa_zonelist_order", setup_numa_zonelist_order);
> -
>  char numa_zonelist_order[] = "Node";
>  
>  /*
> -- 
> 2.25.1
> 

-- 
Kees Cook
