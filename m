Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1416F0E8
	for <lists+linux-api@lfdr.de>; Tue, 25 Feb 2020 22:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgBYVKV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Feb 2020 16:10:21 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35586 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgBYVKS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 25 Feb 2020 16:10:18 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so282148pjc.0
        for <linux-api@vger.kernel.org>; Tue, 25 Feb 2020 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RJKpOOFGEfUAGGLqO1NUhiGzKjVzNOK2IgBZIyJHxc0=;
        b=h+pDnoGOYsk+E8Wt6TpmxUxdwV6kjF4atGpRldLId/Yw8w9WfMNnrM8XJReblD9SwC
         8LeJhqiafUtArcvC4wLH1Ri6+yqFHMw0jvz4WTjgvML3xSZUD/c8wIZT5mi6IVRxMhSV
         aNZy8mj/AVPfjzspIlHT7j9dhhuOVWKWW+0mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RJKpOOFGEfUAGGLqO1NUhiGzKjVzNOK2IgBZIyJHxc0=;
        b=BbOOuQ/XGLkjXB0lUHYFK9BFrb3Xvh1HRMMwT2HGjSsLonmN1PnrmGNXqr4fIpgIRu
         TybSSZ+k6ealpRTZdmXi5VhPgp82WHyefYR2/43DNJYKvebXGsPazvy6ZAFpDTaC+7vB
         KEYTQFw88mbczdREeatbKCeVNX9QA540Zy98LJjH8i+Zds/CYhWrC1A2lZYY4kYyB2/j
         +1mJ6frj8YJlAOYLrF/7gZndGSuDob/BKcDPgXmZEAZI2FxuULqCsGbZXbf/w3Q6ixSk
         /FWuJ5KyBwUHMIoib+g88lHFoTcClGeqDHPqvBoL1bMPYCa4kcFvn9xxQZ7f4jzQcB9m
         fa1Q==
X-Gm-Message-State: APjAAAWrRU+gRhL0jgCehqDchJVMGxK743WFHe+V0On28+A3Fjk1whkg
        Efc/Fs/skckLLHkXItMyLFrJAw==
X-Google-Smtp-Source: APXvYqzQAbfYXF5TtmiNKwyw9CCTemc+ykrjzmXEtfYjXSRlSbhEiGrlXLqSnZ/Ps0gefcUFE6oD5g==
X-Received: by 2002:a17:902:bb93:: with SMTP id m19mr467640pls.310.1582665016973;
        Tue, 25 Feb 2020 13:10:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w81sm18583961pff.95.2020.02.25.13.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 13:10:16 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:10:14 -0800
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
Subject: Re: [RFC PATCH v9 18/27] x86/cet/shstk: Introduce WRUSS instruction
Message-ID: <202002251309.E238DFEEB4@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-19-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-19-yu-cheng.yu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:26AM -0800, Yu-cheng Yu wrote:
> WRUSS is a new kernel-mode instruction but writes directly to user Shadow
> Stack (SHSTK) memory.  This is used to construct a return address on SHSTK
> for the signal handler.
> 
> This instruction can fault if the user SHSTK is not valid SHSTK memory.
> In that case, the kernel does a fixup.

Since these functions aren't used in this patch, should this get merged
with patch 19?

-Kees

> 
> v4:
> - Change to asm goto.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/special_insns.h | 32 ++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 6d37b8fcfc77..1b9b2e79c353 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -222,6 +222,38 @@ static inline void clwb(volatile void *__p)
>  		: [pax] "a" (p));
>  }
>  
> +#ifdef CONFIG_X86_INTEL_CET
> +#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
> +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> +{
> +	asm_volatile_goto("1: wrussd %1, (%0)\n"
> +			  _ASM_EXTABLE(1b, %l[fail])
> +			  :: "r" (addr), "r" (val)
> +			  :: fail);
> +	return 0;
> +fail:
> +	return -EPERM;
> +}
> +#else
> +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> +{
> +	WARN_ONCE(1, "%s used but not supported.\n", __func__);
> +	return -EFAULT;
> +}
> +#endif
> +
> +static inline int write_user_shstk_64(unsigned long addr, unsigned long val)
> +{
> +	asm_volatile_goto("1: wrussq %1, (%0)\n"
> +			  _ASM_EXTABLE(1b, %l[fail])
> +			  :: "r" (addr), "r" (val)
> +			  :: fail);
> +	return 0;
> +fail:
> +	return -EPERM;
> +}
> +#endif /* CONFIG_X86_INTEL_CET */
> +
>  #define nop() asm volatile ("nop")
>  
>  
> -- 
> 2.21.0
> 

-- 
Kees Cook
