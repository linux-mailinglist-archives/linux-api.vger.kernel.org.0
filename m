Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB62EFAF3
	for <lists+linux-api@lfdr.de>; Fri,  8 Jan 2021 23:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbhAHWQV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 Jan 2021 17:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbhAHWQV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 Jan 2021 17:16:21 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B0C061757;
        Fri,  8 Jan 2021 14:15:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lj6so4408342pjb.0;
        Fri, 08 Jan 2021 14:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPwxujGNNyOBnF0Vwn1tLQOHKm27c8aE8Qm8sfiISfM=;
        b=rI/GoBBGWlXF5JUC0/uPwoTcwobevsRYyKgkfhrgde/PuiIA7VM71TTPWx2an5anQ0
         qP3a8g0ZYMtCczxBB+l/0bEOt+goxz88uiM9BRoP1eazMsil4IUXfVqOxTxyItzoE2WJ
         zpUhjuyTBJRSEslBe/YubfQ6h24QfaoFp3nwEBd28ascrg+EK+0WBe39JNDg4+QQXaIg
         MTI6n8R1EVdMFWGB74kNH4G/ctcN/hm0lIBglC18rNAJbshB8ktGt7giiftPldRWk2Qf
         MsTq4cwKOV00oLw2Ln/PMZZD8aQyjSnTCgFzAr/xew0GkKEhHs0pT4ia0p8smIlIBg2V
         mRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cPwxujGNNyOBnF0Vwn1tLQOHKm27c8aE8Qm8sfiISfM=;
        b=amQOScDS19s7zi/aipbLnfDqtRwCyRsV6Z/+QUZPn1udV1icLTSP0ymFkbQFWymuKr
         5EWdtgRovI2u30WvKKdyTshVV7ziU5jWayOuFXGmi0vI2dDg8HYfxNFQVWkCg89o9OQD
         gBAYgLqg9ovb8/VwOEWoRTf/Yq8XfPKDAUbyK6N3QSE3Ekq1Y2rxMqlWuyFW+ZPZLmlH
         AzAFzBozCeyxrnPtdujrXwMgPniA/GLgknz3bT1UdlZxZdDlD5AF9NEaEfP6orYXb/09
         X+mTTSDi03uRRhw7xk2vkty/vb23BoJY1I4MOD1c69MvFYZEHFUHOE6Sw2xEamuNJbws
         RNJg==
X-Gm-Message-State: AOAM532iNPtU24/06mb6AQJj83rgI34f6S8Fe7SeSL8CywpcjqcXL9al
        0ErPgnqD5pp7m42tKTNWp7w=
X-Google-Smtp-Source: ABdhPJy4f4mlQgM559uJm1g1tPUPB7QKx9c6aaz7sIh4PCKsyofkc+Ulp6tDGlFc4DCvAuSUOc8NtA==
X-Received: by 2002:a17:90a:6708:: with SMTP id n8mr5974485pjj.35.1610144140538;
        Fri, 08 Jan 2021 14:15:40 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id 77sm9968507pfv.16.2021.01.08.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:15:39 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 8 Jan 2021 14:15:37 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jannh@google.com, keescook@chromium.org,
        jeffv@google.com, mhocko@suse.com, shakeelb@google.com,
        rientjes@google.com, edgararriaga@google.com, timmurray@google.com,
        linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for
 process_madvise
Message-ID: <X/jZibYD1B42D+r7@google.com>
References: <20210108205857.1471269-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108205857.1471269-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 08, 2021 at 12:58:57PM -0800, Suren Baghdasaryan wrote:
> process_madvise currently requires ptrace attach capability.
> PTRACE_MODE_ATTACH gives one process complete control over another
> process. It effectively removes the security boundary between the
> two processes (in one direction). Granting ptrace attach capability
> even to a system process is considered dangerous since it creates an
> attack surface. This severely limits the usage of this API.
> The operations process_madvise can perform do not affect the correctness
> of the operation of the target process; they only affect where the data
> is physically located (and therefore, how fast it can be accessed).
> What we want is the ability for one process to influence another process
> in order to optimize performance across the entire system while leaving
> the security boundary intact.
> Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> and CAP_SYS_NICE for influencing process performance.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

It sounds logical to me.
If security folks don't see any concern and fix below,

Acked-by: Minchan Kim <minchan@kernel.org>

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
> +		goto release_task;

mmput?

> +	}
> +
>  	total_len = iov_iter_count(&iter);
>  
>  	while (iov_iter_count(&iter)) {
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
