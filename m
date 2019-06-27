Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D04BC5791A
	for <lists+linux-api@lfdr.de>; Thu, 27 Jun 2019 03:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfF0Bti (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Jun 2019 21:49:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38576 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfF0Bth (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 26 Jun 2019 21:49:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id g4so349870plb.5
        for <linux-api@vger.kernel.org>; Wed, 26 Jun 2019 18:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=WM6uPUMLAmx7AP//rA8fowctOYQ/AmGg6H1et0/fxeQ=;
        b=GPMwtTE+s4FHnzPCcPaRaca9fFeyCQYdJ+4Pqg5rcV3ZwX+TwMkiFLiXjV7VmYZu0A
         1nqQJfF8eMw4jnIntXT1hv8EkQ40QlF4yk/dLswm4q4y2Feza716oSK+ZuJdrAXPJBj2
         6ox2mI9ni7ucak56kwY5tWcZ650K94V5UXoNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WM6uPUMLAmx7AP//rA8fowctOYQ/AmGg6H1et0/fxeQ=;
        b=TvXd1n54ZJPvTkx3YBaPWRH8bCJhyqP81CCp3hPgd8zNLXZkm8HCJ9tn0mubtE/RON
         GbLvIeEipWUllGo9rxB8gVNpTqp5ucFV2hotza+KXtWaTH73aXuxCT97rChAPGzSXL8B
         XntTvBHEsiEV9Xyb/ColSxkgkt+pMCTstqP7o0mYE3ZLQPKHZm0BBmklFlUhSo6Ez1j5
         ME6Z53U7rrUAYKii+AclDApCkU2fvOcpILnLO3ndjFLSIngXvqzD/yiKxsJkdTca2Yl4
         6Wt+wXohSFGgkLDvlTZt9wWyBcjxeO3O3gg9Gh4Up3IDaevFlMCkV0iWPD7ciZnkg4xt
         hsaA==
X-Gm-Message-State: APjAAAXIbxDLytP1vmEfRajRsu03IYP+Jowex+y0rT/sxBmXQkjfLDUi
        R+zUDyOHFN6ZGjFamQuAuLUgdQ==
X-Google-Smtp-Source: APXvYqz+uoebBzItdHu2Us8YV0WufO2pkkQ1yhMaFQpW1MFBuEml17h0fcZryss2oo99cskp93paUw==
X-Received: by 2002:a17:902:e582:: with SMTP id cl2mr1492748plb.60.1561600176417;
        Wed, 26 Jun 2019 18:49:36 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id o16sm395909pgi.36.2019.06.26.18.49.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 18:49:35 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V34 19/29] Lock down module params that specify hardware parameters (eg. ioport)
In-Reply-To: <20190622000358.19895-20-matthewgarrett@google.com>
References: <20190622000358.19895-1-matthewgarrett@google.com> <20190622000358.19895-20-matthewgarrett@google.com>
Date:   Thu, 27 Jun 2019 11:49:30 +1000
Message-ID: <87ef3f3ihh.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Matthew Garrett <matthewgarrett@google.com> writes:

> From: David Howells <dhowells@redhat.com>
>
> Provided an annotation for module parameters that specify hardware
> parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
> dma buffers and other types).
>
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  include/linux/security.h     |  1 +
>  kernel/params.c              | 27 ++++++++++++++++++++++-----
>  security/lockdown/lockdown.c |  1 +
>  3 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 61e3f4a62d16..88064d7f6827 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -92,6 +92,7 @@ enum lockdown_reason {
>  	LOCKDOWN_ACPI_TABLES,
>  	LOCKDOWN_PCMCIA_CIS,
>  	LOCKDOWN_TIOCSSERIAL,
> +	LOCKDOWN_MODULE_PARAMETERS,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/kernel/params.c b/kernel/params.c
> index ce89f757e6da..f94fe79e331d 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -24,6 +24,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/ctype.h>
> +#include <linux/security.h>
>  
>  #ifdef CONFIG_SYSFS
>  /* Protects all built-in parameters, modules use their own param_lock */
> @@ -108,13 +109,19 @@ bool parameq(const char *a, const char *b)
>  	return parameqn(a, b, strlen(a)+1);
>  }
>  
> -static void param_check_unsafe(const struct kernel_param *kp)
> +static bool param_check_unsafe(const struct kernel_param *kp,
> +			       const char *doing)
>  {
>  	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
>  		pr_notice("Setting dangerous option %s - tainting kernel\n",
>  			  kp->name);
>  		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>  	}
> +
> +	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
> +	    security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
> +		return false;
> +	return true;
>  }

Should this test occur before tainting the kernel?

Regards,
Daniel

>  
>  static int parse_one(char *param,
> @@ -144,8 +151,10 @@ static int parse_one(char *param,
>  			pr_debug("handling %s with %p\n", param,
>  				params[i].ops->set);
>  			kernel_param_lock(params[i].mod);
> -			param_check_unsafe(&params[i]);
> -			err = params[i].ops->set(val, &params[i]);
> +			if (param_check_unsafe(&params[i], doing))
> +				err = params[i].ops->set(val, &params[i]);
> +			else
> +				err = -EPERM;
>  			kernel_param_unlock(params[i].mod);
>  			return err;
>  		}
> @@ -553,6 +562,12 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
>  	return count;
>  }
>  
> +#ifdef CONFIG_MODULES
> +#define mod_name(mod) (mod)->name
> +#else
> +#define mod_name(mod) "unknown"
> +#endif
> +
>  /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
>  static ssize_t param_attr_store(struct module_attribute *mattr,
>  				struct module_kobject *mk,
> @@ -565,8 +580,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
>  		return -EPERM;
>  
>  	kernel_param_lock(mk->mod);
> -	param_check_unsafe(attribute->param);
> -	err = attribute->param->ops->set(buf, attribute->param);
> +	if (param_check_unsafe(attribute->param, mod_name(mk->mod)))
> +		err = attribute->param->ops->set(buf, attribute->param);
> +	else
> +		err = -EPERM;
>  	kernel_param_unlock(mk->mod);
>  	if (!err)
>  		return len;
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index c89046dc2155..d03c4c296af7 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -28,6 +28,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
>  	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
>  	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
> +	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
