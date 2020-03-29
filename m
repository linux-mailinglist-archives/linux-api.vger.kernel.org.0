Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F6196E05
	for <lists+linux-api@lfdr.de>; Sun, 29 Mar 2020 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgC2PA2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Mar 2020 11:00:28 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35263 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgC2PA1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Mar 2020 11:00:27 -0400
Received: by mail-qv1-f67.google.com with SMTP id q73so7588270qvq.2;
        Sun, 29 Mar 2020 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rGYXAWrsWIiLxM6vPsIDZ7Rl8wO5mf18IjFe9bRFrdY=;
        b=l1WgTAtHA2qzsTMjg9bSRxPYSmVkj+ocQcmwqNeUWqzZT2PrDU2wmSkTOXNlk8pnSd
         Ke7q89sT/A+PdbS//C2wAsaMuxtRZtlrDcy8IL4pNhieSbhK23liAHwCIhCZtvInOXnS
         u3UqZr/0kItiLH3hsZdHySOupM06YTyY5KhWD/OHjdAufCynTaCvMhOHwgFxv84hroTa
         9nKqcuSGBUXYSNZQkY/8FyLK6SbjbQjcyOCxdBiqBErl6VnKiQhm9uZibZA/VBzP28mJ
         QZSlwbziG0QbzcDWqjM8FI7mzOBKdxqqFc061tjkiYsS38AUSYvSl1mbnwQ5qen9bfbO
         itpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rGYXAWrsWIiLxM6vPsIDZ7Rl8wO5mf18IjFe9bRFrdY=;
        b=l/tN06zE6P6TJY+08nTpTmK8Z0+IaTnoP7acsMvv0gEV8WXeBOSmC35j5TUb/aZkxQ
         BXKgJECvglVl0/CRYWQRc+JgI03Df6IHocMdlBAymrZ8rzqlM5Ub2+XZ3pa6oc0LWAH8
         USdD88Ih/8ns0+PlOmRfMmiaVU5jsnw2FotEHpKX7D/5i2NdM06+Gy0olz7aHm75zUlT
         AG9hn2s+eR9URJJ4hiZIcMxox0h2KxXWuOOPabVQW16xCz8tDtS4YdZnQRJczyeBHE1Y
         L2fHDBqBRuccE9sHHNAW4iboRuc00YS2drF28dLVKkPW3zll8P7ycq/EN5sch5GfV8d6
         0fvA==
X-Gm-Message-State: ANhLgQ3DTYgKdeeiqSQO7Xru163OtyPnXyNQ0l2RHsvQVQ8oWhRF6yB1
        mSzwHYmiBaTZFu+RdweYR2I=
X-Google-Smtp-Source: ADFU+vtYT62GFNGeoVetw+nZmaRphF0bJ+n5GbMC9MYWFGp7A0ljCgjR4ff4KGTtPm64IJAKsM79Iw==
X-Received: by 2002:ad4:4364:: with SMTP id u4mr7593136qvt.58.1585494026561;
        Sun, 29 Mar 2020 08:00:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l62sm5281385qte.52.2020.03.29.08.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 08:00:26 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 29 Mar 2020 11:00:24 -0400
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 2/2] kernel/sysctl: support handling command line aliases
Message-ID: <20200329150022.GA823603@rani.riverdale.lan>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <20200325120345.12946-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200325120345.12946-2-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 25, 2020 at 01:03:45PM +0100, Vlastimil Babka wrote:
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
> ---
>  kernel/sysctl.c | 39 +++++++++++++++++++++++++++++++++++----
>  mm/page_alloc.c |  9 ---------
>  2 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 18c7f5606d55..fd72853396f9 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1971,6 +1971,22 @@ static struct ctl_table dev_table[] = {
>  	{ }
>  };
>  
> +struct sysctl_alias {
> +	char *kernel_param;
> +	char *sysctl_param;
> +};
> +
> +/*
> + * Historically some settings had both sysctl and a command line parameter.
> + * With the generic sysctl. parameter support, we can handle them at a single
> + * place and only keep the historical name for compatibility. This is not meant
> + * to add brand new aliases.
> + */
> +static struct sysctl_alias sysctl_aliases[] = {
> +	{"numa_zonelist_order",		"vm.numa_zonelist_order" },
> +	{ }
> +};
> +
>  int __init sysctl_init(void)
>  {
>  	struct ctl_table_header *hdr;
> @@ -1980,6 +1996,18 @@ int __init sysctl_init(void)
>  	return 0;
>  }
>  
> +char *sysctl_find_alias(char *param)

This function should probably be declared static?

> +{
> +	struct sysctl_alias *alias;
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
>  int process_sysctl_arg(char *param, char *val,
>  			       const char *unused, void *arg)
> @@ -1990,10 +2018,13 @@ int process_sysctl_arg(char *param, char *val,
>  	loff_t ppos = 0;
>  	struct ctl_table *ctl, *found = NULL;
>  
> -	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
> -		return 0;
> -
> -	param += sizeof("sysctl.") - 1;
> +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1) == 0) {
> +		param += sizeof("sysctl.") - 1;
> +	} else {
> +		param = sysctl_find_alias(param);
> +		if (!param)
> +			return 0;
> +	}
>  
>  	remaining = param;
>  	ctl = &sysctl_base_table[0];
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
