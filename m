Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E6E69F7E
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2019 01:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfGOX0h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 19:26:37 -0400
Received: from namei.org ([65.99.196.166]:35448 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730429AbfGOX0h (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 15 Jul 2019 19:26:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6FNQSoZ026061;
        Mon, 15 Jul 2019 23:26:28 GMT
Date:   Tue, 16 Jul 2019 09:26:28 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>, jeyu@kernel.org
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V35 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
In-Reply-To: <20190715195946.223443-20-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1907160926120.25034@namei.org>
References: <20190715195946.223443-1-matthewgarrett@google.com> <20190715195946.223443-20-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 15 Jul 2019, Matthew Garrett wrote:

> From: David Howells <dhowells@redhat.com>
> 
> Provided an annotation for module parameters that specify hardware
> parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
> dma buffers and other types).

Adding Jessica.

> 
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/security.h     |  1 +
>  kernel/params.c              | 28 +++++++++++++++++++++++-----
>  security/lockdown/lockdown.c |  1 +
>  3 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 8f7048395114..43fa3486522b 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -113,6 +113,7 @@ enum lockdown_reason {
>  	LOCKDOWN_ACPI_TABLES,
>  	LOCKDOWN_PCMCIA_CIS,
>  	LOCKDOWN_TIOCSSERIAL,
> +	LOCKDOWN_MODULE_PARAMETERS,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/kernel/params.c b/kernel/params.c
> index cf448785d058..f2779a76d39a 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -12,6 +12,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/ctype.h>
> +#include <linux/security.h>
>  
>  #ifdef CONFIG_SYSFS
>  /* Protects all built-in parameters, modules use their own param_lock */
> @@ -96,13 +97,20 @@ bool parameq(const char *a, const char *b)
>  	return parameqn(a, b, strlen(a)+1);
>  }
>  
> -static void param_check_unsafe(const struct kernel_param *kp)
> +static bool param_check_unsafe(const struct kernel_param *kp,
> +			       const char *doing)
>  {
> +	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
> +	    security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
> +		return false;
> +
>  	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
>  		pr_notice("Setting dangerous option %s - tainting kernel\n",
>  			  kp->name);
>  		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>  	}
> +
> +	return true;
>  }
>  
>  static int parse_one(char *param,
> @@ -132,8 +140,10 @@ static int parse_one(char *param,
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
> @@ -541,6 +551,12 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
>  	return count;
>  }
>  
> +#ifdef CONFIG_MODULES
> +#define mod_name(mod) ((mod)->name)
> +#else
> +#define mod_name(mod) "unknown"
> +#endif
> +
>  /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
>  static ssize_t param_attr_store(struct module_attribute *mattr,
>  				struct module_kobject *mk,
> @@ -553,8 +569,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
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
> index 07a49667f234..065432f9e218 100644
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
> 

-- 
James Morris
<jmorris@namei.org>

