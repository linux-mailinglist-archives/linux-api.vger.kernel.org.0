Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECFD16EFC2
	for <lists+linux-api@lfdr.de>; Tue, 25 Feb 2020 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgBYUHx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Feb 2020 15:07:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbgBYUHx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 25 Feb 2020 15:07:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id z12so87006pgl.4
        for <linux-api@vger.kernel.org>; Tue, 25 Feb 2020 12:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pLqQrmSsfufbn5Lcx5rtfXc4bHifFStx1l8So98nJPs=;
        b=ln0sQVdZxk7+oBHy4Mw4CgpRf4BL0Gsj5oTETS0kuKyPfhtz+uBGKpJEGEwWx+jr2K
         +ovoysMjt8c67QUjI18K1ZPwf6c+o1q95zCWZZiqR/coNQwp4fzR9gE2yB5t0U6YpEA3
         gBkN9TYn1tzX4z2DSPhulsCAEqf9iA84ez2u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pLqQrmSsfufbn5Lcx5rtfXc4bHifFStx1l8So98nJPs=;
        b=Sb6dZ3rT1r7D4Lsm0cM8Y1M7OSuj987SAw4U2RUPeFlssNVSqTjaCuig4HtLHMJwpv
         2MGi8UQCgXZ5sFs0VBHX+RQp9fmp1D7DvSA92JsHSPCqELLKghS2pYhLtaebDVZYb4Jg
         Q/AwPukexmFjko0M2tFzi7iuu6qXpQoG6dW+WV9hiHmLsKIUdH2A45Tcvdp9sHgdO8Ug
         BfQr3HK90x2tTnk1XUyT1CV8QiSTliK5xJ7QyCDS/QGFpHzqiNKSM0QPeLOwiGI/iWKh
         dt+FoW9ds8XLhZJaGnp+I0suT24Pv7GEtoApsWlM5AH6c+0REGBNnXCD445N57UW0vuQ
         1ohg==
X-Gm-Message-State: APjAAAWL/9qbdPwk6fnnfZJin9KZzkAhc29hOwSlA6r3WIXN0pd78+tA
        kbwZrkD3IigEznUQGKG9zagifw==
X-Google-Smtp-Source: APXvYqxMX/WV3XkMcn5ipPdDK8VHcVF6Rk0rk84BxmiB5bgazlkLe7cj/gWW6MgxEhOkWPEKKhUWUA==
X-Received: by 2002:a63:4a47:: with SMTP id j7mr241277pgl.196.1582661272585;
        Tue, 25 Feb 2020 12:07:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v7sm17487346pfn.61.2020.02.25.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:07:51 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:07:50 -0800
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
Subject: Re: [RFC PATCH v9 06/27] mm: Introduce VM_SHSTK for Shadow Stack
 memory
Message-ID: <202002251207.8EB036A712@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-7-yu-cheng.yu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:14AM -0800, Yu-cheng Yu wrote:
> A Shadow Stack (SHSTK) PTE must be read-only and have _PAGE_DIRTY set.
> However, read-only and Dirty PTEs also exist for copy-on-write (COW) pages.
> These two cases are handled differently for page faults and a new VM flag
> is necessary for tracking SHSTK VMAs.
> 
> v9:
> - Add VM_SHSTK case to arch_vma_name().
> - Revise the commit log to explain why a new VM flag is needed.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/mm/mmap.c | 2 ++
>  fs/proc/task_mmu.c | 3 +++
>  include/linux/mm.h | 8 ++++++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index aae9a933dfd4..482813b4c659 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -165,6 +165,8 @@ const char *arch_vma_name(struct vm_area_struct *vma)
>  {
>  	if (vma->vm_flags & VM_MPX)
>  		return "[mpx]";
> +	else if (vma->vm_flags & VM_SHSTK)
> +		return "[shadow stack]";
>  	return NULL;
>  }
>  
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9442631fd4af..590b58ee008a 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -687,6 +687,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_PKEY_BIT4)]	= "",
>  #endif
>  #endif /* CONFIG_ARCH_HAS_PKEYS */
> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +		[ilog2(VM_SHSTK)]	= "ss",
> +#endif
>  	};
>  	size_t i;
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cfaa8feecfe8..b5145fbe102e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -298,11 +298,13 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
> +#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
>  #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
>  #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
>  #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
>  #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> +#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
>  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>  
>  #ifdef CONFIG_ARCH_HAS_PKEYS
> @@ -340,6 +342,12 @@ extern unsigned int kobjsize(const void *objp);
>  # define VM_MPX		VM_NONE
>  #endif
>  
> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +# define VM_SHSTK	VM_HIGH_ARCH_5
> +#else
> +# define VM_SHSTK	VM_NONE
> +#endif
> +
>  #ifndef VM_GROWSUP
>  # define VM_GROWSUP	VM_NONE
>  #endif
> -- 
> 2.21.0
> 

-- 
Kees Cook
