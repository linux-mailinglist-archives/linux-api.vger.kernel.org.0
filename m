Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F9A4F95C
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 02:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFWAOt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Jun 2019 20:14:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35824 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFWAOs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 Jun 2019 20:14:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so4822504plo.2
        for <linux-api@vger.kernel.org>; Sat, 22 Jun 2019 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=btG6avAzDAyvn5JxuzcdJRsv07F3W0fAi+zvzELLu4g=;
        b=G10ix/75gAlaiLGUlBh565tLQ8+aylPU/RQBBsKWCCMUORUSsygtn+q15t9tr59J2A
         cUiEQyECiFsC4UExccIv11GBw77rxdlv0rlsUUNpDdl5FmjAPK3GAviiQ1EbJBhyAJCJ
         C48HUkgUK3dqaC+1Ih76fePbjemx7QzQ6cHf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=btG6avAzDAyvn5JxuzcdJRsv07F3W0fAi+zvzELLu4g=;
        b=BH2/9ENz/h23NrgLNYykyOG0RNEOCcgXp/d5TU4+JhndAA37AkMY+/MXcvCECtAERP
         87xMUzT/NtU87ZV7iPtmWKY7rvxSC1wy26CZW2BAQ8VM85Zj7uGOaRxgokHFqz0TUT9Z
         iy9+U7bUO/KrGVyfIh5FE2M0AHG2SGS2NFl3XXMqhYRxYih6zNJlAEaz8Lya0YTZks9l
         fnf/rE+DW5eVnlaeRXvOTqHSYAn/gqiYDkig9N0BVQol/ofmJTVxP6Cuqsnwqi0d9kh9
         QmNw7UrLSlb89GIW0RfZFx2NEa2+C+CC+oxBDh3V+fIgkwzOcAeLpUFqi0cT9M9hFbVM
         Pd2Q==
X-Gm-Message-State: APjAAAX3Q6b0LrBj2XniNHL/VNinB6bq2YBnNldY/XfbA9kZM03iA9Ib
        rEvRGevOuSMDyrRGLb1Ys8C3+w==
X-Google-Smtp-Source: APXvYqxcvat/DBQ6Sbeb3rN2qxDjuCbNFZLf7vlqSfx2l0aGYSWcasg0xVthOBBHvZpowm2Cy1Uu7w==
X-Received: by 2002:a17:902:7443:: with SMTP id e3mr3104455plt.176.1561248887361;
        Sat, 22 Jun 2019 17:14:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q10sm6534267pgg.35.2019.06.22.17.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:14:46 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:14:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH V34 28/29] efi: Restrict efivar_ssdt_load when the kernel
 is locked down
Message-ID: <201906221714.CDECCAEDA6@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-29-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-29-matthewgarrett@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:57PM -0700, Matthew Garrett wrote:
> efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
> EFI variable, which gives arbitrary code execution in ring 0. Prevent
> that when the kernel is locked down.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/efi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 55b77c576c42..9f92a013ab27 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -31,6 +31,7 @@
>  #include <linux/acpi.h>
>  #include <linux/ucs2_string.h>
>  #include <linux/memblock.h>
> +#include <linux/security.h>
>  
>  #include <asm/early_ioremap.h>
>  
> @@ -242,6 +243,11 @@ static void generic_ops_unregister(void)
>  static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
>  static int __init efivar_ssdt_setup(char *str)
>  {
> +	int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
> +
> +	if (ret)
> +		return ret;
> +
>  	if (strlen(str) < sizeof(efivar_ssdt))
>  		memcpy(efivar_ssdt, str, strlen(str));
>  	else
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
