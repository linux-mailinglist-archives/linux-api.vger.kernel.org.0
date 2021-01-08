Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E382EFB03
	for <lists+linux-api@lfdr.de>; Fri,  8 Jan 2021 23:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbhAHWS3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 Jan 2021 17:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAHWS3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 Jan 2021 17:18:29 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6FCC061798
        for <linux-api@vger.kernel.org>; Fri,  8 Jan 2021 14:17:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 91so10369024wrj.7
        for <linux-api@vger.kernel.org>; Fri, 08 Jan 2021 14:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfNPOuXbiYYuQXptBPkm0/8Iz5DAMcXqOk0WAcfNZT0=;
        b=OwKIICBG4ziBL858fu/p6nkk7+7rYxyWE1veyLMYcq8xsyhXf7/F9O0gvB13SSnZD3
         XO+8qjLHVM4kuZx7TPjG+iaE+jBXURk072L+H23O+fM7S4PaxitqMc78dVhZmghwZ0Fi
         ZbbroueXQAT996JB4CzRaHNHdWgCRtYyjRgm56Ow9PHs7io9FmlxzldrOgn0CXiD1nRo
         NJfhRVkWJipHsA7aZVyDBY0agTh1ZkeyInVUPjSyHbkVJWdyTFgz5oMRSwV3370kckHI
         aPSupM1d8kj6aJchlRpMWL6ETpmSfbqJLzVR5gS+Gi9oYJxaRVgGjiRFMo42lBIYn6Sk
         QKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfNPOuXbiYYuQXptBPkm0/8Iz5DAMcXqOk0WAcfNZT0=;
        b=gpHmt26jVPCVfxlftoG9I26EGHoPTZwCZlNTskvxWpEsuawX9/jawBUmUIQPn5GMPN
         AZGxaQXoTbRF3cFLy6kDp2vopiT8a3PfF18RL7+pK3VMBo1x+N7nwHJnL2AQHj08S9YW
         2o/n3gH5rfVka9oNtUZRN+93FgGozSsBw2nYBigQSmleqJ9aApm1H7Dfho0ych2/SBDG
         Z8Q6dq96R3/Z+7ysg8j4ppBrGuzeiKW3JsLG0Pwea2IgRy1/wTITq6G4uRRdTh/FpBAI
         hA38lMfO3ayX1gVfmGPCEXs652f4RBynSz+D2TPPP7OK0pkOSo5mYx4y4X8gmeKDJBhG
         VHNA==
X-Gm-Message-State: AOAM533q79rDW5va0lHesFeKov0BPTs1dpRJpkBh54SnvcyQtyBP2K1O
        ZLyGXT1a6UQacZh7YLA4I6ma3ojdMj9K5B36RXC4cA==
X-Google-Smtp-Source: ABdhPJzkvv4D9b68I4LPw6/6JgsFsBaEMsfzMhYUYK+Cp+K8peAunfZRgkO+MFAM445tjliWbykC//9ukR40sU97BRE=
X-Received: by 2002:a5d:4a44:: with SMTP id v4mr5731046wrs.106.1610144248889;
 Fri, 08 Jan 2021 14:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20210108205857.1471269-1-surenb@google.com> <X/jZibYD1B42D+r7@google.com>
In-Reply-To: <X/jZibYD1B42D+r7@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 8 Jan 2021 14:17:17 -0800
Message-ID: <CAJuCfpHa3XHVEjNBDHJNo3RBWGdLnXsgZH9wyiGLqj655GwE2w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 8, 2021 at 2:15 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Jan 08, 2021 at 12:58:57PM -0800, Suren Baghdasaryan wrote:
> > process_madvise currently requires ptrace attach capability.
> > PTRACE_MODE_ATTACH gives one process complete control over another
> > process. It effectively removes the security boundary between the
> > two processes (in one direction). Granting ptrace attach capability
> > even to a system process is considered dangerous since it creates an
> > attack surface. This severely limits the usage of this API.
> > The operations process_madvise can perform do not affect the correctness
> > of the operation of the target process; they only affect where the data
> > is physically located (and therefore, how fast it can be accessed).
> > What we want is the ability for one process to influence another process
> > in order to optimize performance across the entire system while leaving
> > the security boundary intact.
> > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > and CAP_SYS_NICE for influencing process performance.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> It sounds logical to me.
> If security folks don't see any concern and fix below,
>
> Acked-by: Minchan Kim <minchan@kernel.org>
>
> > @@ -1197,12 +1197,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >               goto release_task;
> >       }
> >
> > -     mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > +     /* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> > +     mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> >       if (IS_ERR_OR_NULL(mm)) {
> >               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> >               goto release_task;
> >       }
> >
> > +     /*
> > +      * Require CAP_SYS_NICE for influencing process performance. Note that
> > +      * only non-destructive hints are currently supported.
> > +      */
> > +     if (!capable(CAP_SYS_NICE)) {
> > +             ret = -EPERM;
> > +             goto release_task;
>
> mmput?

Ouch! Thanks for pointing it out! Will include in the next respin.

>
> > +     }
> > +
> >       total_len = iov_iter_count(&iter);
> >
> >       while (iov_iter_count(&iter)) {
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
