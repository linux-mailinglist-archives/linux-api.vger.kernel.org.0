Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2119916EFDF
	for <lists+linux-api@lfdr.de>; Tue, 25 Feb 2020 21:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgBYUNj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Feb 2020 15:13:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33647 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBYUNi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 25 Feb 2020 15:13:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so272555plb.0
        for <linux-api@vger.kernel.org>; Tue, 25 Feb 2020 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IfvOa5CAoS9YrIm9N+UKd0iHPjsP1Uph4Ha67JwUu2o=;
        b=Z3jNU3sFtdRcUf3XGqpGhOL2LVYIwJc2/3GB2RBrFkvN/amW/IWS6/xFHLrBHEY9B3
         VcfHm8TXxaWtA6xKll8ghTdVcB4Uco9nYUxcs7quUwQMLlYY0kQ3mGvv821BcaEuA6a3
         6Xfea/cZ+XC2gGZE+CD/J+nr/LokygHBO5Tvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfvOa5CAoS9YrIm9N+UKd0iHPjsP1Uph4Ha67JwUu2o=;
        b=h3IgItYvf8QDoiQCtywblCTgZQjjWhWeO/ubXeHIHoJ/ztPayXJsHQBDyxQamCTJGi
         8Yf+UlGNEUa/gZRMuCp3EwT3iSdRb5Xa5QcUYxoxtgO3Xw6pjH73uo22z2A92G4B+3zl
         iNj87Yvk7xF8IMtFobzjk4KDxN0JxandK8bbdkspWDALwDZbTfbxz40jxXMK/TrU/BBR
         POVycvYzIINwWfVYHyY4hXxgXOz5Cx9If+XUL238gipgBDfI2ksADJs927B6xxkYXWQ3
         yeVCPpd3GhrJ9y3YIk/3MTX2efwd96dAcfZbHTw10WKGj2GBIyI9IAX8qcuC3cst23Xi
         UuLQ==
X-Gm-Message-State: APjAAAUwuM8d9lfb1gOSRjTS9tffUipjpiNyefTQ9SiEnQY/8J9E1Ubf
        Z49MZW4rexPFB38JimIzpO/tnQ==
X-Google-Smtp-Source: APXvYqw0iwR9Xn1V95LV9IEegPlHmPh9oFHhrgdXWTNBfMRQN1imw8kisoN796o80/OQIjtO6Xs0BA==
X-Received: by 2002:a17:90a:330c:: with SMTP id m12mr866153pjb.18.1582661616566;
        Tue, 25 Feb 2020 12:13:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 13sm17939080pfi.78.2020.02.25.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:13:35 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:13:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Subject: Re: [RFC PATCH v9 11/27] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
Message-ID: <202002251213.DFD1E3E27@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-12-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-12-yu-cheng.yu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:19AM -0800, Yu-cheng Yu wrote:
> After the introduction of _PAGE_DIRTY_SW, a dirty PTE can have either
> _PAGE_DIRTY_HW or _PAGE_DIRTY_SW.  Change _PAGE_DIRTY to _PAGE_DIRTY_BITS.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index 4b04af569c05..e467ca182633 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -1201,7 +1201,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
>  	}
>  
>  	/* Clear dirty field. */
> -	se->val64 &= ~_PAGE_DIRTY;
> +	se->val64 &= ~_PAGE_DIRTY_BITS;
>  
>  	ops->clear_pse(se);
>  	ops->clear_ips(se);
> -- 
> 2.21.0
> 

-- 
Kees Cook
