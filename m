Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7F34F90C
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 01:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfFVXxB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Jun 2019 19:53:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41675 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfFVXxB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 Jun 2019 19:53:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so4774842pls.8
        for <linux-api@vger.kernel.org>; Sat, 22 Jun 2019 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PICVkDCKF9SBFiTMxs5q7Sx1+1o4x5Q3+GA5H81Tneo=;
        b=ir+0iXqVOalSYgdtJfBgUDb+XYb02QjZQLYL30nGIdtelW50JtaMwO6kcaSwRQlt1v
         WtyAwZqNb/Zgi5T9Y4SDSRjK9h1fUmtIjwltjDA+FHsgmScnDc4+qQRbrDXkHqUTATyk
         dR1WcvK7+lI+sifDQPnJj+I2EmVRxvLxhyKrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PICVkDCKF9SBFiTMxs5q7Sx1+1o4x5Q3+GA5H81Tneo=;
        b=WGwy62BR5Mo8o0WZ9XhQpBpV6ER2vsG6175/mL5tHZ/t2/MEN667psubiGvo2dEoXQ
         kFuJRjid8zzN3SzTFpM1/xtUQnpz1FEvoyXqOMb+3MQPE/ccT+Kc5XP17UIbCLwwv52u
         HFS/T4cxb4PQddT6HFAbBQL+hPsFFCh7iTInEhm6FQbwWU1Ve3fF35c8dJPap2l2Ia6V
         iDPVfmlYN+XlWcIRlD37OK/RpYs7JXMF4LRIBMgMBDKszOpiqEjCYKE3NHu6lxaj5Iqr
         GJguCPKO6ui13KIUD0ihq1lc0T3W6bgwDNusPg/rK0rzxbrnqX3+kFMgKUxiCIePqQHR
         2lrQ==
X-Gm-Message-State: APjAAAVGCgbPjLPlfHVSniJBqhXKTs9XxtnvBRqivZeljEFdfMwSTSZB
        kZ6OLyTAvSfN/iRzHeAaxcWK3A==
X-Google-Smtp-Source: APXvYqyIBsDGTwOJfW9dMkHubASlKIulYQ/ol1kt2GUts1AGrEooXih3+gYBHqTmtRZlebHe+XVDeA==
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr61665941plt.289.1561247580963;
        Sat, 22 Jun 2019 16:53:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f197sm6321039pfa.161.2019.06.22.16.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:53:00 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:52:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH V34 06/29] kexec_load: Disable at runtime if the kernel
 is locked down
Message-ID: <201906221652.2268FEE@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-7-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-7-matthewgarrett@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:35PM -0700, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> The kexec_load() syscall permits the loading and execution of arbitrary
> code in ring 0, which is something that lock-down is meant to prevent. It
> makes sense to disable kexec_load() in this situation.
> 
> This does not affect kexec_file_load() syscall which can check for a
> signature on the image to be booted.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> cc: kexec@lists.infradead.org
> ---
>  include/linux/security.h     | 1 +
>  kernel/kexec.c               | 8 ++++++++
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 200175c8605a..00a31ab2e5ba 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -84,6 +84,7 @@ enum lockdown_reason {
>  	LOCKDOWN_NONE,
>  	LOCKDOWN_MODULE_SIGNATURE,
>  	LOCKDOWN_DEV_MEM,
> +	LOCKDOWN_KEXEC,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 68559808fdfa..ec3f07a4b1c0 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -207,6 +207,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	if (result < 0)
>  		return result;
>  
> +	/*
> +	 * kexec can be used to circumvent module loading restrictions, so
> +	 * prevent loading in that case
> +	 */
> +	result = security_locked_down(LOCKDOWN_KEXEC);
> +	if (result)
> +		return result;
> +
>  	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 565c87451f0f..08fcd8116db3 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -20,6 +20,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_NONE] = "none",
>  	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>  	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
> +	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
