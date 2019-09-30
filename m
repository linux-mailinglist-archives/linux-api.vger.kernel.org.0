Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC83C2B0E
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 01:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfI3Xo1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 19:44:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33585 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732432AbfI3Xo1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Sep 2019 19:44:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so6546747pfl.0
        for <linux-api@vger.kernel.org>; Mon, 30 Sep 2019 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ilcOW0DhxzP7cIfpAA5KLok6ryAtW1OtyQigm1GgWCI=;
        b=as+xB15GRaFe7FTzsO6s24Sj5ll6UhFZ4MsqYoS7IE98ZBmebkNqerEmpy4I9LCZNV
         Apm38dGhkB6bLRTsy1GS4crenHxZJuHpvNJu2QkObyDmUY+zhatT28KpWIzIJPLYXfgo
         QCtDJYE27HKsaN6lW9DSeLwIdlBAH1fc8b/+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ilcOW0DhxzP7cIfpAA5KLok6ryAtW1OtyQigm1GgWCI=;
        b=jCFi+QgOYDGCaPp6N2qsTCdMM0UE8GwAS8346sUUmfsMgZYLTwI81jvReykcsJoc9S
         et7pod4rTGKeGTnZUhGTjTdWg6Sg8F24E9xqAH3JQhBy5lS95hgR9G7UAULIuTD1hC9P
         QKJ/PM83OvdwXL6o/RjCvHNMWM9zTqksIhs3vUfeDfDVkCVy+VOKpe2FTNglVCWAgCN1
         CaaSsRRmv3CAzkfMi/mXnHIGtroDNfm/TA5g6GcOXOl+ZKgi0Jb2ULjpX4Q+JcsutPPg
         X0+/jj+ToN7iYWTAKFYgQrySGZ0I7oNsTdh77R/+e4cQ9BK6JIJBMPhEQkcRRPlisTne
         Vg8Q==
X-Gm-Message-State: APjAAAXGI/wkinT+Y9/cNIO7GVR+V0Gby/g+hyqq3zz7FySwaoHdloEq
        +dPB4n8j4N6OdrON4ollKp2uPg==
X-Google-Smtp-Source: APXvYqw1qLUTrmoaWs3cAOAE5gZAdxmcewxA2CH6va5f0KzRYrOhYPHIbvUn8ot7gXkJutrZfWwr6Q==
X-Received: by 2002:a17:90a:3524:: with SMTP id q33mr1971412pjb.37.1569887066551;
        Mon, 30 Sep 2019 16:44:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s65sm15933400pgb.91.2019.09.30.16.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:44:25 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:44:24 -0700
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
Subject: Re: [PATCH RESEND v3 4/4] perf_event_open: switch to
 copy_struct_from_user()
Message-ID: <201909301644.7106650E14@keescook>
References: <20190930191526.19544-1-asarai@suse.de>
 <20190930191526.19544-5-asarai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930191526.19544-5-asarai@suse.de>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 01, 2019 at 05:15:26AM +1000, Aleksa Sarai wrote:
> From: Aleksa Sarai <cyphar@cyphar.com>
> 
> The change is very straightforward, and helps unify the syscall
> interface for struct-from-userspace syscalls.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/events/core.c | 47 +++++++++-----------------------------------
>  1 file changed, 9 insertions(+), 38 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4655adbbae10..3f0cb82e4fbc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10586,55 +10586,26 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>  	u32 size;
>  	int ret;
>  
> -	if (!access_ok(uattr, PERF_ATTR_SIZE_VER0))
> -		return -EFAULT;
> -
> -	/*
> -	 * zero the full structure, so that a short copy will be nice.
> -	 */
> +	/* Zero the full structure, so that a short copy will be nice. */
>  	memset(attr, 0, sizeof(*attr));
>  
>  	ret = get_user(size, &uattr->size);
>  	if (ret)
>  		return ret;
>  
> -	if (size > PAGE_SIZE)	/* silly large */
> -		goto err_size;
> -
> -	if (!size)		/* abi compat */
> +	/* ABI compatibility quirk: */
> +	if (!size)
>  		size = PERF_ATTR_SIZE_VER0;
> -
> -	if (size < PERF_ATTR_SIZE_VER0)
> +	if (size < PERF_ATTR_SIZE_VER0 || size > PAGE_SIZE)
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
>  	attr->size = size;
>  
>  	if (attr->__reserved_1)
> -- 
> 2.23.0
> 

-- 
Kees Cook
