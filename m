Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7631F30FE91
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 21:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhBDUg1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 15:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbhBDUgW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Feb 2021 15:36:22 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17D9C0613D6
        for <linux-api@vger.kernel.org>; Thu,  4 Feb 2021 12:35:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 8so2367805plc.10
        for <linux-api@vger.kernel.org>; Thu, 04 Feb 2021 12:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/YqqsMMXQlhsJbnhOFdOST+3qyRvfvIeEMX7fG1uGdk=;
        b=TMxYcIftnS6MnaEQtUVCuD6J1E6iRmW9FqQUHJU+Ooydr+UbhkYdQDHgCjovgYGPs7
         U5j6ptzCIuMqnipgc6lVxPZ5QKeTS/JDn7msUrTJsLioj63Zfmb2QgWii8mmnop/EWSg
         /33SV+lg8zKH9VO+zpymZZQkvWhOCLV83M8Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/YqqsMMXQlhsJbnhOFdOST+3qyRvfvIeEMX7fG1uGdk=;
        b=CPb0ATxMKlVSaegTndGqC3aL9sFHE14NO0GLRUBlGESoniVvNPVZv37rCtKRPtta4m
         Umy8V6mOCUwdswqlrVn7Y/sgxtwt8GmorOd/U/CFB8AIppF+OEavsuJyNiLb1jpbab+/
         I2/iClBYg2s3NF8UwVc9bGbnh8IIc4LNFyS9nx43s/DmWUuKwiC6h0eg08IUM/WrCRPQ
         OA4A0Rr9s1ssYelNdkNfnOu+V0RORKceAuH7lxyCv0Gj6JAGB0iW0v+ke/qkL9JQG2f3
         /tvBEeKdXFisMU6tFD1AROAz9Co8+BfXaBqBgzzdO828Z9rmq4uJDk4wL9jEAIFgl/c1
         vaRA==
X-Gm-Message-State: AOAM533oEre4BEgnwl/1euT/ua385ZR+1yS5DmuzPTsfahJkPZhvp85Y
        FGyF+gM3QS8yimDuqy/PVhGbnQ==
X-Google-Smtp-Source: ABdhPJyDHR/CskCg3u5D/Yn4khY30VmVRvMUaSCxDPEOQHNERSWB14WBXQ2gR6mRGLnfIqdtKSKpeA==
X-Received: by 2002:a17:90a:648f:: with SMTP id h15mr727537pjj.71.1612470941523;
        Thu, 04 Feb 2021 12:35:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b65sm7086054pfg.139.2021.02.04.12.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:35:40 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:35:39 -0800
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 24/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
Message-ID: <202102041235.BA6C4982F@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-25-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-25-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:46PM -0800, Yu-cheng Yu wrote:
> arch_prctl(ARCH_X86_CET_STATUS, u64 *args)
>     Get CET feature status.
> 
>     The parameter 'args' is a pointer to a user buffer.  The kernel returns
>     the following information:
> 
>     *args = shadow stack/IBT status
>     *(args + 1) = shadow stack base address
>     *(args + 2) = shadow stack size

What happens if this needs to grow in the future? Should the first u64
contain the array size?

Otherwise, looks sensible.

-Kees

> 
>     32-bit binaries use the same interface, but only lower 32-bits of each
>     item.
> 
> arch_prctl(ARCH_X86_CET_DISABLE, unsigned int features)
>     Disable CET features specified in 'features'.  Return -EPERM if CET is
>     locked.
> 
> arch_prctl(ARCH_X86_CET_LOCK)
>     Lock in CET features.
> 
> Also change do_arch_prctl_common()'s parameter 'cpuid_enabled' to
> 'arg2', as it is now also passed to prctl_cet().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/cet.h        |  3 ++
>  arch/x86/include/uapi/asm/prctl.h |  4 +++
>  arch/x86/kernel/Makefile          |  2 +-
>  arch/x86/kernel/cet_prctl.c       | 60 +++++++++++++++++++++++++++++++
>  arch/x86/kernel/process.c         |  6 ++--
>  5 files changed, 71 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/kernel/cet_prctl.c
> 
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> index ec4b5e62d0ce..16870e5bc8eb 100644
> --- a/arch/x86/include/asm/cet.h
> +++ b/arch/x86/include/asm/cet.h
> @@ -14,9 +14,11 @@ struct sc_ext;
>  struct cet_status {
>  	unsigned long	shstk_base;
>  	unsigned long	shstk_size;
> +	unsigned int	locked:1;
>  };
>  
>  #ifdef CONFIG_X86_CET
> +int prctl_cet(int option, u64 arg2);
>  int cet_setup_shstk(void);
>  int cet_setup_thread_shstk(struct task_struct *p, unsigned long clone_flags);
>  void cet_disable_shstk(void);
> @@ -25,6 +27,7 @@ int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *new_ssp)
>  void cet_restore_signal(struct sc_ext *sc);
>  int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
>  #else
> +static inline int prctl_cet(int option, u64 arg2) { return -EINVAL; }
>  static inline int cet_setup_thread_shstk(struct task_struct *p,
>  					 unsigned long clone_flags) { return 0; }
>  static inline void cet_disable_shstk(void) {}
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index 5a6aac9fa41f..9245bf629120 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -14,4 +14,8 @@
>  #define ARCH_MAP_VDSO_32	0x2002
>  #define ARCH_MAP_VDSO_64	0x2003
>  
> +#define ARCH_X86_CET_STATUS		0x3001
> +#define ARCH_X86_CET_DISABLE		0x3002
> +#define ARCH_X86_CET_LOCK		0x3003
> +
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 4a9a7e7d00dc..2f60a28769f9 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -151,7 +151,7 @@ obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
>  obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
>  
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev-es.o
> -obj-$(CONFIG_X86_CET)			+= cet.o
> +obj-$(CONFIG_X86_CET)			+= cet.o cet_prctl.o
>  
>  ###
>  # 64 bit specific files
> diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
> new file mode 100644
> index 000000000000..0030c63a08c0
> --- /dev/null
> +++ b/arch/x86/kernel/cet_prctl.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/errno.h>
> +#include <linux/uaccess.h>
> +#include <linux/prctl.h>
> +#include <linux/compat.h>
> +#include <linux/mman.h>
> +#include <linux/elfcore.h>
> +#include <linux/processor.h>
> +#include <asm/prctl.h>
> +#include <asm/cet.h>
> +
> +/* See Documentation/x86/intel_cet.rst. */
> +
> +static int cet_copy_status_to_user(struct cet_status *cet, u64 __user *ubuf)
> +{
> +	u64 buf[3] = {};
> +
> +	if (cet->shstk_size) {
> +		buf[0] |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
> +		buf[1] = cet->shstk_base;
> +		buf[2] = cet->shstk_size;
> +	}
> +
> +	return copy_to_user(ubuf, buf, sizeof(buf));
> +}
> +
> +int prctl_cet(int option, u64 arg2)
> +{
> +	struct cet_status *cet;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_CET))
> +		return -ENOTSUPP;
> +
> +	cet = &current->thread.cet;
> +
> +	if (option == ARCH_X86_CET_STATUS)
> +		return cet_copy_status_to_user(cet, (u64 __user *)arg2);
> +
> +	switch (option) {
> +	case ARCH_X86_CET_DISABLE:
> +		if (cet->locked)
> +			return -EPERM;
> +
> +		if (arg2 & ~GNU_PROPERTY_X86_FEATURE_1_VALID)
> +			return -EINVAL;
> +		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
> +			cet_disable_shstk();
> +		return 0;
> +
> +	case ARCH_X86_CET_LOCK:
> +		if (arg2)
> +			return -EINVAL;
> +		cet->locked = 1;
> +		return 0;
> +
> +	default:
> +		return -ENOSYS;
> +	}
> +}
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 3af6b36e1a5c..9e11e5f589f3 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -979,14 +979,14 @@ unsigned long get_wchan(struct task_struct *p)
>  }
>  
>  long do_arch_prctl_common(struct task_struct *task, int option,
> -			  unsigned long cpuid_enabled)
> +			  unsigned long arg2)
>  {
>  	switch (option) {
>  	case ARCH_GET_CPUID:
>  		return get_cpuid_mode();
>  	case ARCH_SET_CPUID:
> -		return set_cpuid_mode(task, cpuid_enabled);
> +		return set_cpuid_mode(task, arg2);
>  	}
>  
> -	return -EINVAL;
> +	return prctl_cet(option, arg2);
>  }
> -- 
> 2.21.0
> 
> 

-- 
Kees Cook
