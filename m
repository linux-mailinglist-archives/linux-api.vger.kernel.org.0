Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94034F905
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 01:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFVXsU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Jun 2019 19:48:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44431 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfFVXsU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 Jun 2019 19:48:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so5094450pgp.11
        for <linux-api@vger.kernel.org>; Sat, 22 Jun 2019 16:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lh0bykVQFvQflkOokSve4pshtQHLBmvnAZFm1p4jA6c=;
        b=GLCoWdQPNqLP7jC9lBJEDXfyIeqdR7aqTbk7x33CpSoVuPAPgl0DbubPyjI+2W+Mii
         Qd7amH/qTcG/+Z238gjmt3SaUnbUJHANMD0VEISMPFObriujKaIZ1MHUWesFkcDYbG9T
         szzis3rxVUVlC08Psjvccv5xp2HpffSAueRDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lh0bykVQFvQflkOokSve4pshtQHLBmvnAZFm1p4jA6c=;
        b=iXh/BLmjNFXcFEVRN2laMb/OXXEEcsxDQBRtx04fQU/hLjD48ChNrLOk1OvQCxovWG
         c3qvRbqZvbK/ppPNRwiclzEdF4vyea8zsZdeml3saLITlCRVc1FE3BM1aFJuavkEXD8K
         xCW4BIX7yiCHbUPAoVITNbDIMjh2PtNl5M9AZYYyu373eyMHSLF+aBG1l5vcEq6xiLL3
         Yr3JJ4Xku38y4JgkkaRq4+2R933f6jh1aK3xsbVg0wvTix3Rx4m5VlgeONwjVtP0cJEM
         CmL3E1xGDzB3MzjH6Pu/pTfwKvYR8dnrK4ipvQWmra48/+agsIeVgjKMK+f84dwf6E/0
         k5sg==
X-Gm-Message-State: APjAAAXZHpeL9pe1k9gyQpxcuJWcLyIryKcRI3rr1wcXDQnLmIF8EBlr
        hKUU8U2baSx2cGsC8brevdWxUeIgVFI=
X-Google-Smtp-Source: APXvYqz/YGqSay35+ZDL2BdcLtDDiqJMjqj9CqoKrM6ZuWgSRgoAdzR27bWfzZV8zVRHDWBN5GH1gg==
X-Received: by 2002:a17:90a:32c7:: with SMTP id l65mr3440052pjb.1.1561247298707;
        Sat, 22 Jun 2019 16:48:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a11sm6818221pff.128.2019.06.22.16.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:48:17 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:48:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH V34 04/29] Enforce module signatures if the kernel is
 locked down
Message-ID: <201906221647.181A170A1B@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-5-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-5-matthewgarrett@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:33PM -0700, Matthew Garrett wrote:
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
>  kernel/module.c              | 38 +++++++++++++++++++++++++++++-------
>  security/lockdown/lockdown.c |  1 +
>  3 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c808d344ec75..46d85cd63b06 100644
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
> index 0b9aa8ab89f0..6aa681edd660 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2763,8 +2763,9 @@ static inline void kmemleak_load_module(const struct module *mod,
>  #ifdef CONFIG_MODULE_SIG
>  static int module_sig_check(struct load_info *info, int flags)
>  {
> -	int err = -ENOKEY;
> +	int ret, err = -ENODATA;
>  	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
> +	const char *reason;
>  	const void *mod = info->hdr;
>  
>  	/*
> @@ -2779,16 +2780,39 @@ static int module_sig_check(struct load_info *info, int flags)
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
> +		ret = security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
> +		return ret;

return security_locked_down(LOCKDOWN_MODULE_SIGNATURE); ? Means no need
to add "ret". Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees


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
> index 8e39b36b8f33..25a3a5b0aa9c 100644
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
