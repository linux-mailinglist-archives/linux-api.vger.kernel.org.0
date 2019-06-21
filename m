Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9760A4DF5E
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 05:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfFUDqP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 23:46:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37417 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfFUDqO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 23:46:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so2843132pfa.4
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 20:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UcRKm0yi/1LOFFoCKIK/Brfe9Z+qKqObyoVYwCPqe5A=;
        b=Bvnsdxk047qMCYZomJxCMLbIam0txekt2/bzcLlDt3dkDaii0on+5apAz3gIOCEMqH
         81cQ0ZSMvmDZgtWfEUqWzNpWd1x9cEb4y5gXnkcs5iqWbMELw72NEciomEFq6bsWnYwX
         aeIwqqjyes8QQfZe1VlD0+WPmw0Z/wIaKzrms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UcRKm0yi/1LOFFoCKIK/Brfe9Z+qKqObyoVYwCPqe5A=;
        b=BZa+wmW7qu5njfdkNX38NW7hPwqKallaJlm47UJduCiQKkB+V8OeUgGtlZkCg5+qKh
         1g4vaAeRcTpZyNqFz+34IYfR+S3r1RvE4xvSwKdHOchz/ev7ZWguVpShFgn67FRSjr7+
         HA3Ly4FHZr8PfZLPNteKhjm/w9tLyeuAiGoCcHDCxl/1QN1lWJp6ql5TO7AFZ4gUhCcO
         cv4yfYq/nhFVdO2QN/HuCemgDcpINkqEIXq9xXBJeVE33zG1vPBF0DyGuU9rlIR079ah
         QheAIJL3Tf/hN/Sg/1IIZUAWKIDM2p+PI9Nr3sgB1g5Fn58hfzxbyBbRaHWas7QwOdjE
         Xukg==
X-Gm-Message-State: APjAAAUpVQP5gNLRhrYWxi77BWVwNgNIW3nTgXLMXoMqG/u4fy8T+E0d
        KiyZVBKtN28J19n4cVerUoWCdA==
X-Google-Smtp-Source: APXvYqxMjepKCHZFI7Rja6rx/OhPhF71GP3zxOtZth3VkELV2td1AR57r2nqWQZ8Y/4q8yTsH/RngQ==
X-Received: by 2002:a63:f648:: with SMTP id u8mr15989938pgj.132.1561088773619;
        Thu, 20 Jun 2019 20:46:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k197sm966289pgc.22.2019.06.20.20.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 20:46:12 -0700 (PDT)
Date:   Thu, 20 Jun 2019 20:46:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH V33 04/30] Enforce module signatures if the kernel is
 locked down
Message-ID: <201906202045.793323FC@keescook>
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-5-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621011941.186255-5-matthewgarrett@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 06:19:15PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> If the kernel is locked down, require that all modules have valid
> signatures that we can verify.
> 
> I have adjusted the errors generated:
> 
>  (1) If there's no signature (ENODATA) or we can't check it (ENOPKG,
>      ENOKEY), then:
> 
>      (a) If signatures are enforced then EKEYREJECTED is returned.
> 
>      (b) If there's no signature or we can't check it, but the kernel is
> 	 locked down then EPERM is returned (this is then consistent with
> 	 other lockdown cases).
> 
>  (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
>      the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we
>      return the error we got.
> 
> Note that the X.509 code doesn't check for key expiry as the RTC might not
> be valid or might not have been transferred to the kernel's clock yet.
> 
>  [Modified by Matthew Garrett to remove the IMA integration. This will
>   be replaced with integration with the IMA architecture policy
>   patchset.]
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> ---
>  include/linux/security.h     |  1 +
>  kernel/module.c              | 39 +++++++++++++++++++++++++++++-------
>  security/lockdown/lockdown.c |  1 +
>  3 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a86a7739ca24..a7612b03b42a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -82,6 +82,7 @@ enum lsm_event {
>   */
>  enum lockdown_reason {
>  	LOCKDOWN_NONE,
> +	LOCKDOWN_MODULE_SIGNATURE,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/kernel/module.c b/kernel/module.c
> index 0b9aa8ab89f0..780e9605ff88 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2763,8 +2763,9 @@ static inline void kmemleak_load_module(const struct module *mod,
>  #ifdef CONFIG_MODULE_SIG
>  static int module_sig_check(struct load_info *info, int flags)
>  {
> -	int err = -ENOKEY;
> +	int err = -ENODATA;
>  	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
> +	const char *reason;
>  	const void *mod = info->hdr;
>  
>  	/*
> @@ -2779,16 +2780,40 @@ static int module_sig_check(struct load_info *info, int flags)
>  		err = mod_verify_sig(mod, info);
>  	}
>  
> -	if (!err) {
> +	switch (err) {
> +	case 0:
>  		info->sig_ok = true;
>  		return 0;
> -	}
>  
> -	/* Not having a signature is only an error if we're strict. */
> -	if (err == -ENOKEY && !is_module_sig_enforced())
> -		err = 0;
> +		/* We don't permit modules to be loaded into trusted kernels
> +		 * without a valid signature on them, but if we're not
> +		 * enforcing, certain errors are non-fatal.
> +		 */
> +	case -ENODATA:
> +		reason = "Loading of unsigned module";
> +		goto decide;
> +	case -ENOPKG:
> +		reason = "Loading of module with unsupported crypto";
> +		goto decide;
> +	case -ENOKEY:
> +		reason = "Loading of module with unavailable key";
> +	decide:
> +		if (is_module_sig_enforced()) {
> +			pr_notice("%s is rejected\n", reason);
> +			return -EKEYREJECTED;
> +		}
>  
> -	return err;
> +		if (security_is_locked_down(LOCKDOWN_MODULE_SIGNATURE))
> +			return -EPERM;

LSM hooks should return the desired error code. Here and in all the
other patches, I'd expect to see stuff like:

	ret = security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
	if (ret)
		return ret;


> +		return 0;
> +
> +		/* All other errors are fatal, including nomem, unparseable
> +		 * signatures and signature check failures - even if signatures
> +		 * aren't required.
> +		 */
> +	default:
> +		return err;
> +	}
>  }
>  #else /* !CONFIG_MODULE_SIG */
>  static int module_sig_check(struct load_info *info, int flags)
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 1ecb2eecb245..08abd7e6609b 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -18,6 +18,7 @@ static enum lockdown_reason kernel_locked_down;
>  
>  static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_NONE] = "none",
> +	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
