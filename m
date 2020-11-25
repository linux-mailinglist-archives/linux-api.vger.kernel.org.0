Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BE22C4B5C
	for <lists+linux-api@lfdr.de>; Thu, 26 Nov 2020 00:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgKYXNn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Nov 2020 18:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgKYXNn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Nov 2020 18:13:43 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640F9C0613D4;
        Wed, 25 Nov 2020 15:13:27 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id f5so150372plj.13;
        Wed, 25 Nov 2020 15:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dFX+ONxlEObvYwRnMfQuG63qm5Q8vreuwMUNJvNIzew=;
        b=JWMtwU+sMcf/hDLp1f2TaGqqz35AegdQz6nPvKnv5nMyefCl5aMCqgyVUhmq+BprRi
         SCUs3nZiZeeFPqoz8/w4WKHuC74G6KR7qYW81QtzmL0QrebTe0KmS213gdtA/fnfUVnS
         iXwEXuzN2D3KSeQYjupBty7spj3VHd6UB/d0lTb43x6OSLlMdNYCJJUXaCLQSfvr3fDT
         7ppzN3vmJKNCNDimAeeDElcuXuZOwB/6SAV6/m4cwThoxVr3TkSYYGEbxvoOTkzS1AuZ
         E7DZoOxY7pIwVZM13Ki+APnlT42tMRXoAV+b/fZMrEFKLg/J9jvgOegZk7rB+IMOXbcW
         yW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dFX+ONxlEObvYwRnMfQuG63qm5Q8vreuwMUNJvNIzew=;
        b=MJaGaiOFf5iSTDAUuuvKwA0gG//1MTZGZb3oAUahLEDg1ftDZG9LIyogDto1WCVTOv
         UJnouwq7h3Afm9p502OBiqtyyigt3qbv6OQcQ0DXhexooNI+Y0caF9DJWu/OQR3McmuR
         wTn4x9nQs8YMqUZxdRCCJOWjz/Crg12LtPY+v0m2O1tvWt97H1b8i+VsY7LHrA7psf3U
         H3avVQLjM6W50TZmw5UdhU1lCPIGeuZK7ywkJxYJLvNwdRm/oV8cNxovppoPIlnyAl7a
         80eys7L3n3a3QtHr5QKDn9U+j1k24G/xGu9cHv82PV9Ckg/XWsWowQ4ccWFrIxgLbSoa
         gv8A==
X-Gm-Message-State: AOAM531u91J6eDxpmzZVV6CKrgnDoPRMbKZ4H0wWjGZIF3SqjHiDUYQc
        sDkUeY5siYuX0YLOX/pM+S0=
X-Google-Smtp-Source: ABdhPJytsz+avRF+He4HbgRmXMIbnhtl7L2CUY8fDjG/l/N9IKm7q2YcnXslk+JP2Xc2NmY6yBioXA==
X-Received: by 2002:a17:902:8d93:b029:d8:d8ee:e275 with SMTP id v19-20020a1709028d93b02900d8d8eee275mr210383plo.71.1606346006805;
        Wed, 25 Nov 2020 15:13:26 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id k9sm2745244pfi.188.2020.11.25.15.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 15:13:25 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 25 Nov 2020 15:13:22 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, christian@brauner.io,
        oleg@redhat.com, timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
Message-ID: <20201125231322.GF1484898@google.com>
References: <20201124053943.1684874-1-surenb@google.com>
 <20201124053943.1684874-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124053943.1684874-2-surenb@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 23, 2020 at 09:39:42PM -0800, Suren Baghdasaryan wrote:
> process_madvise requires a vector of address ranges to be provided for
> its operations. When an advice should be applied to the entire process,
> the caller process has to obtain the list of VMAs of the target process
> by reading the /proc/pid/maps or some other way. The cost of this
> operation grows linearly with increasing number of VMAs in the target
> process. Even constructing the input vector can be non-trivial when
> target process has several thousands of VMAs and the syscall is being
> issued during high memory pressure period when new allocations for such
> a vector would only worsen the situation.
> In the case when advice is being applied to the entire memory space of
> the target process, this creates an extra overhead.
> Add PMADV_FLAG_RANGE flag for process_madvise enabling the caller to
> advise a memory range of the target process. For now, to keep it simple,
> only the entire process memory range is supported, vec and vlen inputs
> in this mode are ignored and can be NULL and 0.
> Instead of returning the number of bytes that advice was successfully
> applied to, the syscall in this mode returns 0 on success. This is due
> to the fact that the number of bytes would not be useful for the caller
> that does not know the amount of memory the call is supposed to affect.
> Besides, the ssize_t return type can be too small to hold the number of
> bytes affected when the operation is applied to a large memory range.

Can we just use one element in iovec to indicate entire address rather
than using up the reserved flags?

	struct iovec {
		.iov_base = NULL,
		.iov_len = (~(size_t)0),
	};

Furthermore, it would be applied for other syscalls where have support
iovec if we agree on it.

> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/alpha/include/uapi/asm/mman.h           |  4 ++
>  arch/mips/include/uapi/asm/mman.h            |  4 ++
>  arch/parisc/include/uapi/asm/mman.h          |  4 ++
>  arch/xtensa/include/uapi/asm/mman.h          |  4 ++
>  fs/io_uring.c                                |  2 +-
>  include/linux/mm.h                           |  3 +-
>  include/uapi/asm-generic/mman-common.h       |  4 ++
>  mm/madvise.c                                 | 47 +++++++++++++++++---
>  tools/include/uapi/asm-generic/mman-common.h |  4 ++
>  9 files changed, 67 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> index a18ec7f63888..54588d2f5406 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -79,4 +79,8 @@
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
>  				 PKEY_DISABLE_WRITE)
>  
> +/* process_madvise flags */
> +#define PMADV_FLAG_RANGE	0x1	/* advice for all VMAs in the range */
> +#define PMADV_FLAG_MASK	(PMADV_FLAG_RANGE)
> +
>  #endif /* __ALPHA_MMAN_H__ */
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> index 57dc2ac4f8bd..af94f38a3a9d 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -106,4 +106,8 @@
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
>  				 PKEY_DISABLE_WRITE)
>  
> +/* process_madvise flags */
> +#define PMADV_FLAG_RANGE	0x1	/* advice for all VMAs in the range */
> +#define PMADV_FLAG_MASK	(PMADV_FLAG_RANGE)
> +
>  #endif /* _ASM_MMAN_H */
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> index ab78cba446ed..ae644c493991 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -77,4 +77,8 @@
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
>  				 PKEY_DISABLE_WRITE)
>  
> +/* process_madvise flags */
> +#define PMADV_FLAG_RANGE	0x1	/* advice for all VMAs in the range */
> +#define PMADV_FLAG_MASK	(PMADV_FLAG_RANGE)
> +
>  #endif /* __PARISC_MMAN_H__ */
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> index e5e643752947..934cdd11abff 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -114,4 +114,8 @@
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
>  				 PKEY_DISABLE_WRITE)
>  
> +/* process_madvise flags */
> +#define PMADV_FLAG_RANGE	0x1	/* advice for all VMAs in the range */
> +#define PMADV_FLAG_MASK	(PMADV_FLAG_RANGE)
> +
>  #endif /* _XTENSA_MMAN_H */
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index a8c136a1cf4e..508c48b998ee 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -4118,7 +4118,7 @@ static int io_madvise(struct io_kiocb *req, bool force_nonblock)
>  	if (force_nonblock)
>  		return -EAGAIN;
>  
> -	ret = do_madvise(current->mm, ma->addr, ma->len, ma->advice);
> +	ret = do_madvise(current->mm, ma->addr, ma->len, ma->advice, 0);
>  	if (ret < 0)
>  		req_set_fail_links(req);
>  	io_req_complete(req, ret);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index db6ae4d3fb4e..414c7639e394 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2579,7 +2579,8 @@ extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
>  		       struct list_head *uf, bool downgrade);
>  extern int do_munmap(struct mm_struct *, unsigned long, size_t,
>  		     struct list_head *uf);
> -extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
> +extern int do_madvise(struct mm_struct *mm, unsigned long start, unsigned long len_in,
> +		      int behavior, unsigned int flags);
>  
>  #ifdef CONFIG_MMU
>  extern int __mm_populate(unsigned long addr, unsigned long len,
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index f94f65d429be..4898034593ec 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -80,4 +80,8 @@
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
>  				 PKEY_DISABLE_WRITE)
>  
> +/* process_madvise flags */
> +#define PMADV_FLAG_RANGE	0x1	/* advice for all VMAs in the range */
> +#define PMADV_FLAG_MASK	(PMADV_FLAG_RANGE)
> +
>  #endif /* __ASM_GENERIC_MMAN_COMMON_H */
> diff --git a/mm/madvise.c b/mm/madvise.c
> index a8d8d48a57fe..1aa074a46524 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1001,6 +1001,14 @@ process_madvise_behavior_valid(int behavior)
>  	}
>  }
>  
> +static bool can_range_madv_lru_vma(struct vm_area_struct *vma, int behavior)
> +{
> +	if (!can_madv_lru_vma(vma))
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * The madvise(2) system call.
>   *
> @@ -1067,15 +1075,21 @@ process_madvise_behavior_valid(int behavior)
>   *  -EBADF  - map exists, but area maps something that isn't a file.
>   *  -EAGAIN - a kernel resource was temporarily unavailable.
>   */
> -int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
> +int do_madvise(struct mm_struct *mm, unsigned long start, unsigned long len_in,
> +	       int behavior, unsigned int flags)
>  {
>  	unsigned long end, tmp;
>  	struct vm_area_struct *vma, *prev;
>  	int unmapped_error = 0;
>  	int error = -EINVAL;
> +	int error_on_gap;
>  	int write;
> -	size_t len;
> +	unsigned long len;
>  	struct blk_plug plug;
> +	bool range_madvise = !!(flags & PMADV_FLAG_RANGE);
> +
> +	/* For range operations gap between VMAs is normal */
> +	error_on_gap = range_madvise ? 0 : -ENOMEM;
>  
>  	start = untagged_addr(start);
>  
> @@ -1123,13 +1137,14 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  	blk_start_plug(&plug);
>  	for (;;) {
>  		/* Still start < end. */
> -		error = -ENOMEM;
> +		error = error_on_gap;
> +
>  		if (!vma)
>  			goto out;
>  
>  		/* Here start < (end|vma->vm_end). */
>  		if (start < vma->vm_start) {
> -			unmapped_error = -ENOMEM;
> +			unmapped_error = error_on_gap;
>  			start = vma->vm_start;
>  			if (start >= end)
>  				goto out;
> @@ -1140,10 +1155,18 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  		if (end < tmp)
>  			tmp = end;
>  
> +		/* For range operations skip VMAs ineligible for the behavior */
> +		if (range_madvise && !can_range_madv_lru_vma(vma, behavior)) {
> +			prev = vma;
> +			goto skip_vma;
> +		}
> +
>  		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
>  		error = madvise_vma(vma, &prev, start, tmp, behavior);
>  		if (error)
>  			goto out;
> +
> +skip_vma:
>  		start = tmp;
>  		if (prev && start < prev->vm_end)
>  			start = prev->vm_end;
> @@ -1167,7 +1190,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  
>  SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  {
> -	return do_madvise(current->mm, start, len_in, behavior);
> +	return do_madvise(current->mm, start, len_in, behavior, 0);
>  }
>  
>  SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> @@ -1183,7 +1206,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  	size_t total_len;
>  	unsigned int f_flags;
>  
> -	if (flags != 0) {
> +	if (flags & ~PMADV_FLAG_MASK) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -1216,12 +1239,21 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  		goto release_task;
>  	}
>  
> +	/*
> +	 * For range madvise only the entire address space is supported for now
> +	 * and input iovec is ignored.
> +	 */
> +	if (flags & PMADV_FLAG_RANGE) {
> +		ret = do_madvise(mm, 0, ULONG_MAX & PAGE_MASK, behavior, flags);
> +		goto release_mm;
> +	}
> +
>  	total_len = iov_iter_count(&iter);
>  
>  	while (iov_iter_count(&iter)) {
>  		iovec = iov_iter_iovec(&iter);
>  		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
> -					iovec.iov_len, behavior);
> +					iovec.iov_len, behavior, flags);
>  		if (ret < 0)
>  			break;
>  		iov_iter_advance(&iter, iovec.iov_len);
> @@ -1230,6 +1262,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  	if (ret == 0)
>  		ret = total_len - iov_iter_count(&iter);
>  
> +release_mm:
>  	mmput(mm);
>  release_task:
>  	put_task_struct(task);
> diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
> index f94f65d429be..4898034593ec 100644
> --- a/tools/include/uapi/asm-generic/mman-common.h
> +++ b/tools/include/uapi/asm-generic/mman-common.h
> @@ -80,4 +80,8 @@
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
>  				 PKEY_DISABLE_WRITE)
>  
> +/* process_madvise flags */
> +#define PMADV_FLAG_RANGE	0x1	/* advice for all VMAs in the range */
> +#define PMADV_FLAG_MASK	(PMADV_FLAG_RANGE)
> +
>  #endif /* __ASM_GENERIC_MMAN_COMMON_H */
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
