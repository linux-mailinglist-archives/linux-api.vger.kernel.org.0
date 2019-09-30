Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23079C2B0C
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 01:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfI3XoC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 19:44:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37183 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3XoB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Sep 2019 19:44:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so6536307pfo.4
        for <linux-api@vger.kernel.org>; Mon, 30 Sep 2019 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rt01Jv8ohzIRqssmjcdymlBJksS/BQ9v/XBsfaX3lHA=;
        b=miT9e73NNApEZbLYrEaknoY7YM8uVcN5fnsZnjpIrEzwOEpxoPYU23GlA3VgcYud6f
         DPNzRxrf1ONCAhCm1nIrKgbkQ9xMsDEDF0qoErLdhvCj1yt5WGO0vYyhF7/+q2tJD3Sa
         UNaCV/MjnUznz5scAs1KrNBrj8PlxQPi0HQrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rt01Jv8ohzIRqssmjcdymlBJksS/BQ9v/XBsfaX3lHA=;
        b=nQjTTpLq7+L9UeTAGkzNl76CbihCFIFsBZO+rzwIwZ4yPaO9NbIilfTGi0ugOiQrPi
         zWM5ht2/e1+h+OF6ngmuH0rzqVpqGU3SoxA23CdUXBytDMXfC2GUzeDqTV9EfnVZHZ75
         rucn3xFo8mZebKUCK9mV4Ph8XbJKm2451FIJNSRbD0tPD9Yel/hL2672I7RNzRwhdCxT
         BqRrGaLdCd7ks9KUFnhBdPV8KTIKFb703LG2JATCOXisEki/AuErgmOm/xa1iG99FEfl
         CTTiyJxMUn9E7Kx3cwy2Cbje0Yd6TzQ9zUWYcHI5oRAxrYVWZS0GZ1nM7yP/wcy8bHlO
         KFUQ==
X-Gm-Message-State: APjAAAXbGGDIcSQX/qOGUz0YKPJsqsKtwFBJcV1V4nk1apd/Z2LpzR4q
        UfeT2XFVuzexz7TumrZgGsWtvg==
X-Google-Smtp-Source: APXvYqx31HYPawEqqTl+T6ScG/0l9lMgmK87gqYX4ESnkDUDt3+RsBLgU5VhYncUSDRS2rKTq2nMmA==
X-Received: by 2002:a63:fc5f:: with SMTP id r31mr26708650pgk.55.1569887038935;
        Mon, 30 Sep 2019 16:43:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t14sm12804335pgv.84.2019.09.30.16.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:43:58 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:43:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 3/4] sched_setattr: switch to
 copy_struct_from_user()
Message-ID: <201909301643.570C02E@keescook>
References: <20190930191526.19544-1-asarai@suse.de>
 <20190930191526.19544-4-asarai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930191526.19544-4-asarai@suse.de>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 01, 2019 at 05:15:25AM +1000, Aleksa Sarai wrote:
> From: Aleksa Sarai <cyphar@cyphar.com>
> 
> The change is very straightforward, and helps unify the syscall
> interface for struct-from-userspace syscalls. Ideally we could also
> unify sched_getattr(2)-style syscalls as well, but unfortunately the
> correct semantics for such syscalls are much less clear (see [1] for
> more detail). In future we could come up with a more sane idea for how
> the syscall interface should look.
> 
> [1]: commit 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
>      robustify sched_read_attr() ABI logic and code")
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/sched/core.c | 43 +++++++------------------------------------
>  1 file changed, 7 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7880f4f64d0e..dd05a378631a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5106,9 +5106,6 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
>  	u32 size;
>  	int ret;
>  
> -	if (!access_ok(uattr, SCHED_ATTR_SIZE_VER0))
> -		return -EFAULT;
> -
>  	/* Zero the full structure, so that a short copy will be nice: */
>  	memset(attr, 0, sizeof(*attr));
>  
> @@ -5116,45 +5113,19 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
>  	if (ret)
>  		return ret;
>  
> -	/* Bail out on silly large: */
> -	if (size > PAGE_SIZE)
> -		goto err_size;
> -
>  	/* ABI compatibility quirk: */
>  	if (!size)
>  		size = SCHED_ATTR_SIZE_VER0;
> -
> -	if (size < SCHED_ATTR_SIZE_VER0)
> +	if (size < SCHED_ATTR_SIZE_VER0 || size > PAGE_SIZE)
>  		goto err_size;
>  
> -	/*
> -	 * If we're handed a bigger struct than we know of,
> -	 * ensure all the unknown bits are 0 - i.e. new
> -	 * user-space does not rely on any kernel feature
> -	 * extensions we dont know about yet.
> -	 */
> -	if (size > sizeof(*attr)) {
> -		unsigned char __user *addr;
> -		unsigned char __user *end;
> -		unsigned char val;
> -
> -		addr = (void __user *)uattr + sizeof(*attr);
> -		end  = (void __user *)uattr + size;
> -
> -		for (; addr < end; addr++) {
> -			ret = get_user(val, addr);
> -			if (ret)
> -				return ret;
> -			if (val)
> -				goto err_size;
> -		}
> -		size = sizeof(*attr);
> +	ret = copy_struct_from_user(attr, sizeof(*attr), uattr, size);
> +	if (ret) {
> +		if (ret == -E2BIG)
> +			goto err_size;
> +		return ret;
>  	}
>  
> -	ret = copy_from_user(attr, uattr, size);
> -	if (ret)
> -		return -EFAULT;
> -
>  	if ((attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) &&
>  	    size < SCHED_ATTR_SIZE_VER1)
>  		return -EINVAL;
> @@ -5354,7 +5325,7 @@ sched_attr_copy_to_user(struct sched_attr __user *uattr,
>   * sys_sched_getattr - similar to sched_getparam, but with sched_attr
>   * @pid: the pid in question.
>   * @uattr: structure containing the extended parameters.
> - * @usize: sizeof(attr) that user-space knows about, for forwards and backwards compatibility.
> + * @usize: sizeof(attr) for fwd/bwd comp.
>   * @flags: for future extension.
>   */
>  SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
> -- 
> 2.23.0
> 

-- 
Kees Cook
