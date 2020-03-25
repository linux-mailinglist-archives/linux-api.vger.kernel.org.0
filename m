Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB1FD1933D5
	for <lists+linux-api@lfdr.de>; Wed, 25 Mar 2020 23:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCYWm0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Mar 2020 18:42:26 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34095 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWm0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Mar 2020 18:42:26 -0400
Received: by mail-pj1-f68.google.com with SMTP id q16so2701975pje.1
        for <linux-api@vger.kernel.org>; Wed, 25 Mar 2020 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=32blQ6BelWdyKkuvsFFmseYgkxqvrHHDfZ4Jy+npmXg=;
        b=llI5fbH7jaEnN2aApIM8CfavTiQ8UjVN18ZZoPEMccXPEkh2nRieYPs4beOexWuYHS
         UM/90F8INodTY70v8DG9jBgXhsp8jegHgt232KmKLtYTSKCdaJIFpDVGFmLdiaYpXWta
         qy9v83lejzlGM9+bStyyIN0L9/fJmzJ9jP1kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32blQ6BelWdyKkuvsFFmseYgkxqvrHHDfZ4Jy+npmXg=;
        b=iS5UFETQFbACXvrzmst4L4KJ6B0/yxHNJ+sXZSr1dK1DlL2jXCRrr74FYkR+e/oqXX
         TKY8JhwuPBzXou24kZL1Xi1I0Lr8j3JlzFX2L5aJRI9cf/G/lDMKz4xqCPNVMrx4EF0h
         u0tYpzbjdceP3WWVOXWXtmq/In6dOoZSPCeb4CnMdE0KhS9OM8J3+9VeulMg9GXmm82C
         GgpLXhi7DtGQNMA3APV90G3RPXY5ahfNByzDQSmcDrA/eNs33m1FlNv5ByIdwK9K7RXu
         WSTnPHhJiL2aEppfrLNq3WkI+00tQ5ex/v7159P/J8wzXosDtwnOXHLf82G0XRaAvGUR
         EDdw==
X-Gm-Message-State: ANhLgQ1MesCU0O/o/APWRZpyxWeyOPURsWOiHkpT0jHh1gQ6liXd/cox
        DZPdStIwwVG6WO8AeLZ1+tAEyw==
X-Google-Smtp-Source: ADFU+vvicQ+leUWBf0Njne8GoiluUkBvqVW1zfb4wNajEaoMEv2V6R3u/c0lURO6sdKariva9/uKVw==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr6089435pjq.5.1585176144350;
        Wed, 25 Mar 2020 15:42:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15sm158986pfq.10.2020.03.25.15.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:42:23 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:42:22 -0700
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
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 2/2] kernel/sysctl: support handling command line aliases
Message-ID: <202003251423.9138B8C8A9@keescook>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <20200325120345.12946-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325120345.12946-2-vbabka@suse.cz>
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

const char ...

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

static const ...

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

Nice. :) Effectively: -9 lines +1 line for the using aliasing. I think
it would be worth identifying the specific requirements for a sysctl
alias to be safe to use, and likely in a comment before the alias table:

- boot param parsing must be identical to the sysctl parsing
- temporal changes must be tolerable: i.e. early_param() runs earlier
  than when the sysctl-in-boot-param runs -- must the variable be set
  before the code's other __init functions run?
- must be for a non-module code (since we don't have the dynamic support
  yet)

As it turns out, "numa_zonelist_order" has literally no effect on
anything -- it's a parsed but ignored setting:

static int __parse_numa_zonelist_order(char *s)
{
	/*
	 * We used to support different zonlists modes but they turned
	 * out to be just not useful. Let's keep the warning in place
	 * if somebody still use the cmd line parameter so that we do
	 * not fail it silently
	 */
	if (!(*s == 'd' || *s == 'D' || *s == 'n' || *s == 'N')) {
		pr_warn("Ignoring unsupported numa_zonelist_order value: %s\n", s);
		return -EINVAL;
	}
	return 0;
}

But anyway, do you have a way to generate a list of potential candidates?

-- 
Kees Cook
