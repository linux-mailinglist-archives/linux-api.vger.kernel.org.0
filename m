Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D996413B9
	for <lists+linux-api@lfdr.de>; Sat,  3 Dec 2022 03:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiLCCvO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Dec 2022 21:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiLCCvN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Dec 2022 21:51:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A72110043
        for <linux-api@vger.kernel.org>; Fri,  2 Dec 2022 18:51:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so6261225plr.10
        for <linux-api@vger.kernel.org>; Fri, 02 Dec 2022 18:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFa9wOyNkjOu3wfCu+8VdnDJI7y7l4XWc1FYOJwGpZ4=;
        b=MwXxQx4ch7cB9jSlFLmDT0N2Y+Ipy0C0qW3vi2Yec7LRae1mKWT0hUhw++ETkd1tDD
         qLrQGaPTwOVb+5Ppyte36QwiJau/skp/BHnbVO3tNgZxW0RYx/1iqQzvCX/WbYPszyMk
         8A3Xki9QsSgaEIenI9mO2tmYhcHvYZX/9Mqxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFa9wOyNkjOu3wfCu+8VdnDJI7y7l4XWc1FYOJwGpZ4=;
        b=FRjHCwzguHtsm91ZoZVrMYiICn/H/ATTGwyOCbGrVyDLrjTcFqCKO/M/2vz15iu7cV
         7m+5/ERnE+ApaBy7oBzBO9jYo1PHSbO6YfxFDeree8bJY/dhhRjIvjxETOgWRABa1jLO
         lQREKSW4nTjMsjKaSg8/7caQE+2fR3Zkj6ZnIdZBbA8AuVw+nlu0lQeNe9lH7HWFPaXl
         PJI9BXzg88PKFfR4cxU7M5S5977f8Q5l0+MLdL+KBaXcVN7iO6hw49vy2fzFGx7518dV
         VKdmdia9ewydOUCEm7fNAtVUx/hLFUssOfXwyeoMXN39CMm8JzIfbDXz8p5vxypEAgwX
         Ihcg==
X-Gm-Message-State: ANoB5pk82jhkHpUOsvnUciKDmyHQAeSI5xnm9y+4IPYex6wYOZEZGKCV
        5ebr9vuOC/J2kaaawTq4jd7YIw==
X-Google-Smtp-Source: AA0mqf7SH+F7LKTBiFUzgZQQ6ur0ObRkDRQBwN/2rgLDHgZEfyIb9IMJkbjc5SN+oT2XbWNyLsDlFA==
X-Received: by 2002:a17:90a:9f09:b0:218:6158:b081 with SMTP id n9-20020a17090a9f0900b002186158b081mr80915815pjp.66.1670035870894;
        Fri, 02 Dec 2022 18:51:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090a7d1100b00218c5bdb983sm5372466pjl.22.2022.12.02.18.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:51:10 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:51:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Subject: Re: [PATCH v4 30/39] x86/shstk: Introduce map_shadow_stack syscall
Message-ID: <202212021848.B6277C86@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-31-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-31-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:57PM -0800, Rick Edgecombe wrote:
> When operating with shadow stacks enabled, the kernel will automatically
> allocate shadow stacks for new threads, however in some cases userspace
> will need additional shadow stacks. The main example of this is the
> ucontext family of functions, which require userspace allocating and
> pivoting to userspace managed stacks.
> 
> Unlike most other user memory permissions, shadow stacks need to be
> provisioned with special data in order to be useful. They need to be setup
> with a restore token so that userspace can pivot to them via the RSTORSSP
> instruction. But, the security design of shadow stack's is that they
> should not be written to except in limited circumstances. This presents a
> problem for userspace, as to how userspace can provision this special
> data, without allowing for the shadow stack to be generally writable.
> 
> Previously, a new PROT_SHADOW_STACK was attempted, which could be
> mprotect()ed from RW permissions after the data was provisioned. This was
> found to not be secure enough, as other thread's could write to the
> shadow stack during the writable window.
> 
> The kernel can use a special instruction, WRUSS, to write directly to
> userspace shadow stacks. So the solution can be that memory can be mapped
> as shadow stack permissions from the beginning (never generally writable
> in userspace), and the kernel itself can write the restore token.
> 
> First, a new madvise() flag was explored, which could operate on the
> PROT_SHADOW_STACK memory. This had a couple downsides:
> 1. Extra checks were needed in mprotect() to prevent writable memory from
>    ever becoming PROT_SHADOW_STACK.
> 2. Extra checks/vma state were needed in the new madvise() to prevent
>    restore tokens being written into the middle of pre-used shadow stacks.
>    It is ideal to prevent restore tokens being added at arbitrary
>    locations, so the check was to make sure the shadow stack had never been
>    written to.
> 3. It stood out from the rest of the madvise flags, as more of direct
>    action than a hint at future desired behavior.
> 
> So rather than repurpose two existing syscalls (mmap, madvise) that don't
> quite fit, just implement a new map_shadow_stack syscall to allow
> userspace to map and setup new shadow stacks in one step. While ucontext
> is the primary motivator, userspace may have other unforeseen reasons to
> setup it's own shadow stacks using the WRSS instruction. Towards this
> provide a flag so that stacks can be optionally setup securely for the
> common case of ucontext without enabling WRSS. Or potentially have the
> kernel set up the shadow stack in some new way.
> 
> The following example demonstrates how to create a new shadow stack with
> map_shadow_stack:
> void *shstk = map_shadow_stack(addr, stack_size, SHADOW_STACK_SET_TOKEN);
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> 
> v3:
>  - Change syscall common -> 64 (Kees)
>  - Use bit shift notation instead of 0x1 for uapi header (Kees)
>  - Call do_mmap() with MAP_FIXED_NOREPLACE (Kees)
>  - Block unsupported flags (Kees)
>  - Require size >= 8 to set token (Kees)
> 
> v2:
>  - Change syscall to take address like mmap() for CRIU's usage
> 
> v1:
>  - New patch (replaces PROT_SHADOW_STACK).
> 
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  arch/x86/include/uapi/asm/mman.h       |  3 ++
>  arch/x86/kernel/shstk.c                | 56 ++++++++++++++++++++++----
>  include/linux/syscalls.h               |  1 +
>  include/uapi/asm-generic/unistd.h      |  2 +-
>  kernel/sys_ni.c                        |  1 +
>  6 files changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..f65c671ce3b1 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,7 @@
>  448	common	process_mrelease	sys_process_mrelease
>  449	common	futex_waitv		sys_futex_waitv
>  450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451	64	map_shadow_stack	sys_map_shadow_stack
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
> index 775dbd3aff73..15c5a1c4fc29 100644
> --- a/arch/x86/include/uapi/asm/mman.h
> +++ b/arch/x86/include/uapi/asm/mman.h
> @@ -12,6 +12,9 @@
>  		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
>  #endif
>  
> +/* Flags for map_shadow_stack(2) */
> +#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
> +
>  #include <asm-generic/mman.h>
>  
>  #endif /* _ASM_X86_MMAN_H */
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index e53225a8d39e..8f329c22728a 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -17,6 +17,7 @@
>  #include <linux/compat.h>
>  #include <linux/sizes.h>
>  #include <linux/user.h>
> +#include <linux/syscalls.h>
>  #include <asm/msr.h>
>  #include <asm/fpu/xstate.h>
>  #include <asm/fpu/types.h>
> @@ -71,19 +72,31 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
>  	return 0;
>  }
>  
> -static unsigned long alloc_shstk(unsigned long size)
> +static unsigned long alloc_shstk(unsigned long addr, unsigned long size,
> +				 unsigned long token_offset, bool set_res_tok)
>  {
>  	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
>  	struct mm_struct *mm = current->mm;
> -	unsigned long addr, unused;
> +	unsigned long mapped_addr, unused;
>  
> -	mmap_write_lock(mm);
> -	addr = do_mmap(NULL, 0, size, PROT_READ, flags,
> -		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
> +	if (addr)
> +		flags |= MAP_FIXED_NOREPLACE;
>  
> +	mmap_write_lock(mm);
> +	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
> +			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
>  	mmap_write_unlock(mm);
>  
> -	return addr;
> +	if (!set_res_tok || IS_ERR_VALUE(addr))

Should this be IS_ERR_VALUE(mapped_addr) (i.e. the result of the
do_mmap)?

> +		goto out;
> +
> +	if (create_rstor_token(mapped_addr + token_offset, NULL)) {
> +		vm_munmap(mapped_addr, size);
> +		return -EINVAL;
> +	}
> +
> +out:
> +	return mapped_addr;
>  }
>  
>  static unsigned long adjust_shstk_size(unsigned long size)
> @@ -134,7 +147,7 @@ static int shstk_setup(void)
>  		return -EOPNOTSUPP;
>  
>  	size = adjust_shstk_size(0);
> -	addr = alloc_shstk(size);
> +	addr = alloc_shstk(0, size, 0, false);
>  	if (IS_ERR_VALUE(addr))
>  		return PTR_ERR((void *)addr);
>  
> @@ -179,7 +192,7 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
>  
>  
>  	size = adjust_shstk_size(stack_size);
> -	addr = alloc_shstk(size);
> +	addr = alloc_shstk(0, size, 0, false);
>  	if (IS_ERR_VALUE(addr))
>  		return PTR_ERR((void *)addr);
>  
> @@ -373,6 +386,33 @@ static int shstk_disable(void)
>  	return 0;
>  }
>  
> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
> +{
> +	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
> +	unsigned long aligned_size;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return -ENOSYS;

Using -ENOSYS means there's no way to tell the difference between
"kernel doesn't support it" and "CPU doesn't support it". Should this,
perhaps return -ENOTSUP?

> +
> +	if (flags & ~SHADOW_STACK_SET_TOKEN)
> +		return -EINVAL;
> +
> +	/* If there isn't space for a token */
> +	if (set_tok && size < 8)
> +		return -EINVAL;
> +
> +	/*
> +	 * An overflow would result in attempting to write the restore token
> +	 * to the wrong location. Not catastrophic, but just return the right
> +	 * error code and block it.
> +	 */
> +	aligned_size = PAGE_ALIGN(size);
> +	if (aligned_size < size)
> +		return -EOVERFLOW;
> +
> +	return alloc_shstk(addr, aligned_size, size, set_tok);
> +}
> +
>  long shstk_prctl(struct task_struct *task, int option, unsigned long features)
>  {
>  	if (option == ARCH_SHSTK_LOCK) {
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 33a0ee3bcb2e..392dc11e3556 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1058,6 +1058,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>  					    unsigned long home_node,
>  					    unsigned long flags);
> +asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 45fa180cc56a..b12940ec5926 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -887,7 +887,7 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 452
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 860b2dcf3ac4..cb9aebd34646 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -381,6 +381,7 @@ COND_SYSCALL(vm86old);
>  COND_SYSCALL(modify_ldt);
>  COND_SYSCALL(vm86);
>  COND_SYSCALL(kexec_file_load);
> +COND_SYSCALL(map_shadow_stack);
>  
>  /* s390 */
>  COND_SYSCALL(s390_pci_mmio_read);
> -- 
> 2.17.1
> 

Otherwise, looks good!

-- 
Kees Cook
