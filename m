Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153F0C2B08
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 01:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfI3Xmo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 19:42:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45084 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3Xmm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Sep 2019 19:42:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so4521849pls.12
        for <linux-api@vger.kernel.org>; Mon, 30 Sep 2019 16:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wLr0Vt1uSURCynHd+D4IDsYdXD0Hdb1LJEHAhkiX/7E=;
        b=mZNGk+x3kv2moNk1c6RdHZOB0UU5sAU0q9JBjluoBUvDvNH/Lmpq4eOCBGv+MGh9HI
         v1KPLnIl7veKR6Q9e3kxUbtQbhQkwn+IT+g6quH9axLM/w/qnnEUxnjJTaw8w+yQiIGH
         42MTn25g0mYOn/CoJPJhttFlMW89mPwGRjYyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLr0Vt1uSURCynHd+D4IDsYdXD0Hdb1LJEHAhkiX/7E=;
        b=D7oUvwX0ok+SNlFCv5X89BIpLLKM3XpPukvvQeYroSbDSDjJw04qBxU925CpWsbiVy
         ky6ctJdeCMGgUasmZADr81XtLqdx60XONLw2G1Ber0AKsyIfZWODpLgEU/hwptUzoD2T
         XVY/Su7ursMZlyO21gM4e0WM3GTCEhKSWt42BNAHeFhwWtjUkB9IC52eMKgYEpbM4QAh
         VJ7NVLZ5wnMkOFlElkAlfP8y/HfbUhgjxn7kM7zYJtrB7qquSzdF3h6S2kvMN/woggGN
         ANtmu93XYs51pAghrthx+o5cWD/weftTm/WAsQLSY2irgPu7nChD9JZfWwP5w+O0OyOX
         x0Iw==
X-Gm-Message-State: APjAAAUl1JV7n0cWgXMWujWjsUjuEKNMrxVWbYXsdLrk856Uzl8b1o4Z
        Fb2WjguOXOZtU/5kJNXLShTphg==
X-Google-Smtp-Source: APXvYqwMVMi1uRTZbg67FldsawD6kjq0VUepruCztzLpLU1ZrQ4YIs4p+vjoMFhn/fIDskfcKzAAsg==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr15122196pls.29.1569886960701;
        Mon, 30 Sep 2019 16:42:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g7sm22247124pfm.176.2019.09.30.16.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:42:39 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:42:38 -0700
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
Subject: Re: [PATCH RESEND v3 2/4] clone3: switch to copy_struct_from_user()
Message-ID: <201909301640.4FC92294FF@keescook>
References: <20190930191526.19544-1-asarai@suse.de>
 <20190930191526.19544-3-asarai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930191526.19544-3-asarai@suse.de>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 01, 2019 at 05:15:24AM +1000, Aleksa Sarai wrote:
> From: Aleksa Sarai <cyphar@cyphar.com>
> 
> The change is very straightforward, and helps unify the syscall
> interface for struct-from-userspace syscalls. Additionally, explicitly
> define CLONE_ARGS_SIZE_VER0 to match the other users of the
> struct-extension pattern.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  include/uapi/linux/sched.h |  2 ++
>  kernel/fork.c              | 34 +++++++---------------------------
>  2 files changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index b3105ac1381a..0945805982b4 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -47,6 +47,8 @@ struct clone_args {
>  	__aligned_u64 tls;
>  };
>  
> +#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
> +
>  /*
>   * Scheduling policies
>   */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f9572f416126..2ef529869c64 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2525,39 +2525,19 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>  #ifdef __ARCH_WANT_SYS_CLONE3
>  noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  					      struct clone_args __user *uargs,
> -					      size_t size)
> +					      size_t usize)
>  {
> +	int err;
>  	struct clone_args args;
>  
> -	if (unlikely(size > PAGE_SIZE))
> +	if (unlikely(usize > PAGE_SIZE))
>  		return -E2BIG;

I quickly looked through the earlier threads and couldn't find it, but
I have a memory of some discussion about moving this test into the
copy_struct_from_user() function itself? That would seems like a
reasonable idea? ("4k should be enough for any structure!")

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>


> -
> -	if (unlikely(size < sizeof(struct clone_args)))
> +	if (unlikely(usize < CLONE_ARGS_SIZE_VER0))
>  		return -EINVAL;
>  
> -	if (unlikely(!access_ok(uargs, size)))
> -		return -EFAULT;
> -
> -	if (size > sizeof(struct clone_args)) {
> -		unsigned char __user *addr;
> -		unsigned char __user *end;
> -		unsigned char val;
> -
> -		addr = (void __user *)uargs + sizeof(struct clone_args);
> -		end = (void __user *)uargs + size;
> -
> -		for (; addr < end; addr++) {
> -			if (get_user(val, addr))
> -				return -EFAULT;
> -			if (val)
> -				return -E2BIG;
> -		}
> -
> -		size = sizeof(struct clone_args);
> -	}
> -
> -	if (copy_from_user(&args, uargs, size))
> -		return -EFAULT;
> +	err = copy_struct_from_user(&args, sizeof(args), uargs, usize);
> +	if (err)
> +		return err;
>  
>  	/*
>  	 * Verify that higher 32bits of exit_signal are unset and that
> -- 
> 2.23.0
> 

-- 
Kees Cook
