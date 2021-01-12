Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45FE2F2922
	for <lists+linux-api@lfdr.de>; Tue, 12 Jan 2021 08:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392043AbhALHrR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Jan 2021 02:47:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:37624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbhALHrR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 12 Jan 2021 02:47:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610437590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBGTtO60lRhzhjBUzaj4i2s5sW7EfXTuKGnmunlohWE=;
        b=hwvbKiO/E+NP9QqEauVNDAoXqNTjumZS4MLitpiS9HlpLmF/1Yfxx5GZBSvryW5wwOIx5i
        aPe3gN854YKDgcGGxg7pMMKmlKDwomzFnegh8MQ78X/ZT2s+vLlhl5UtDI+d1i66gmCFHd
        zDf6PbuIUWr9KLvxPrgtSHGkeBnbUv0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87EF3AB92;
        Tue, 12 Jan 2021 07:46:30 +0000 (UTC)
Date:   Tue, 12 Jan 2021 08:46:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jannh@google.com, keescook@chromium.org,
        jeffv@google.com, minchan@kernel.org, shakeelb@google.com,
        rientjes@google.com, edgararriaga@google.com, timmurray@google.com,
        linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for
 process_madvise
Message-ID: <20210112074629.GG22493@dhcp22.suse.cz>
References: <20210111170622.2613577-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111170622.2613577-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 11-01-21 09:06:22, Suren Baghdasaryan wrote:
> process_madvise currently requires ptrace attach capability.
> PTRACE_MODE_ATTACH gives one process complete control over another
> process. It effectively removes the security boundary between the
> two processes (in one direction). Granting ptrace attach capability
> even to a system process is considered dangerous since it creates an
> attack surface. This severely limits the usage of this API.
> The operations process_madvise can perform do not affect the correctness
> of the operation of the target process; they only affect where the data
> is physically located (and therefore, how fast it can be accessed).

Yes it doesn't influence the correctness but it is still a very
sensitive operation because it can allow a targeted side channel timing
attacks so we should be really careful.

> What we want is the ability for one process to influence another process
> in order to optimize performance across the entire system while leaving
> the security boundary intact.
> Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> and CAP_SYS_NICE for influencing process performance.

I have to say that ptrace modes are rather obscure to me. So I cannot
really judge whether MODE_READ is sufficient. My understanding has
always been that this is requred to RO access to the address space. But
this operation clearly has a visible side effect. Do we have any actual
documentation for the existing modes?

I would be really curious to hear from Jann and Oleg (now Cced).

Is CAP_SYS_NICE requirement really necessary?

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Minchan Kim <minchan@kernel.org>
> Acked-by: David Rientjes <rientjes@google.com>
> ---
>  mm/madvise.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 6a660858784b..a9bcd16b5d95 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1197,12 +1197,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  		goto release_task;
>  	}
>  
> -	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> +	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> +	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
>  	if (IS_ERR_OR_NULL(mm)) {
>  		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
>  		goto release_task;
>  	}
>  
> +	/*
> +	 * Require CAP_SYS_NICE for influencing process performance. Note that
> +	 * only non-destructive hints are currently supported.
> +	 */
> +	if (!capable(CAP_SYS_NICE)) {
> +		ret = -EPERM;
> +		goto release_mm;
> +	}
> +
>  	total_len = iov_iter_count(&iter);
>  
>  	while (iov_iter_count(&iter)) {
> @@ -1217,6 +1227,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  	if (ret == 0)
>  		ret = total_len - iov_iter_count(&iter);
>  
> +release_mm:
>  	mmput(mm);
>  release_task:
>  	put_task_struct(task);
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 

-- 
Michal Hocko
SUSE Labs
