Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B184177F4
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347165AbhIXPkS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347185AbhIXPkR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 11:40:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E5CC0614ED
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 08:38:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x8so3909176plv.8
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5AhDSP7B56c2gjHAftAo6mg6wD5b+oWdPPF0jeXrR90=;
        b=RnyB0Ynyudwej3vwBU/THN/k/d77zsjvlxs8kFutZKNT2xhgozEi/OzF4IkDBD1npA
         y1/pSzyb531DXANjDxMZonl73Ilfn0QoU99eie8t3xSlDK0O2aP3JHJMoi/5EnrrVJO+
         1W1THM3Ak8Z07rYF3Y9dIU4iBt92zlKbYxtg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5AhDSP7B56c2gjHAftAo6mg6wD5b+oWdPPF0jeXrR90=;
        b=E+bJ6ZVIdkHeK0mgBTfRQwikFPqutadQuYwlK88j6YvQs7xEt3azXOiw4ydo9cedp9
         V0W26Lw0CNpC2O+YrLXJtCjxsWcYM/SYyZK9xP3vQG0Ht67jJtjQZOIYjoCVTIgDYVYI
         TxBjRRhXZAic75WDAK3x0SCduMhKS/9jcTy+A+RA2j7bPzvsACz2F981mBopGL4C0IAJ
         C6XaybcdyQCo9EohxxwtIIBFEJPjo+sExFFUGWOa3JFzkC+bFnczwyGkaA6zV/ZGJkZI
         Ngy79U4dbCMv4EGc1A1+vKXWqApuFgmofr8KkdNTE4KXJeHFqr066d7Gr5GNP3lkScHw
         Igbw==
X-Gm-Message-State: AOAM53151MP6XW35w6JAfAoXgxLYhlMbu/kK+a8SJwdO6f4+S2B8/Nvh
        N3Gydf9kMlWkQNM+J01v/hQJUQ==
X-Google-Smtp-Source: ABdhPJzpKwKKx0xqyyX4MCqAqyAb6w99J8bx3cPKERCKizzY88B8wpEJlXkXjCgoe1AjFigVzxYV3w==
X-Received: by 2002:a17:90a:4d4e:: with SMTP id l14mr3028156pjh.4.1632497923393;
        Fri, 24 Sep 2021 08:38:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 198sm9172997pfy.6.2021.09.24.08.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:38:42 -0700 (PDT)
Date:   Fri, 24 Sep 2021 08:38:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 3/6] exec: Check for a pending fatal signal instead of
 core_state
Message-ID: <202109240834.8D3A18AC32@keescook>
References: <87v92qx2c6.fsf@disp2133>
 <87fstux27w.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fstux27w.fsf@disp2133>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 23, 2021 at 07:10:43PM -0500, Eric W. Biederman wrote:
> 
> Prevent exec continuing when a fatal signal is pending by replacing
> mmap_read_lock with mmap_read_lock_killable.  This is always the right
> thing to do as userspace will never observe an exec complete when
> there is a fatal signal pending.
> 
> With that change it becomes unnecessary to explicitly test for a core
> dump in progress.  In coredump_wait zap_threads arranges under
> mmap_write_lock for all tasks that use a mm to also have SIGKILL
> pending, which means mmap_read_lock_killable will always return -EINTR
> when old_mm->core_state is present.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/exec.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index a098c133d8d7..b6079f1a098e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -987,16 +987,14 @@ static int exec_mmap(struct mm_struct *mm)
>  
>  	if (old_mm) {
>  		/*
> -		 * Make sure that if there is a core dump in progress
> -		 * for the old mm, we get out and die instead of going
> -		 * through with the exec.  We must hold mmap_lock around
> -		 * checking core_state and changing tsk->mm.
> +		 * If there is a pending fatal signal perhaps a signal
> +		 * whose default action is to create a coredump get
> +		 * out and die instead of going through with the exec.
>  		 */
> -		mmap_read_lock(old_mm);
> -		if (unlikely(old_mm->core_state)) {
> -			mmap_read_unlock(old_mm);
> +		ret = mmap_read_lock_killable(old_mm);

This appears to ultimately call into rwsem_down_read_slowpath(), which
checks signal_pending_state() (and returns the EINTR from before),
so this looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> +		if (ret) {
>  			up_write(&tsk->signal->exec_update_lock);
> -			return -EINTR;
> +			return ret;
>  		}
>  	}
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
