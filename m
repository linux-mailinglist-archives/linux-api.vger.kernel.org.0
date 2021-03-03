Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFC732C695
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346697AbhCDA3V (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhCDAAF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Mar 2021 19:00:05 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F37BC0613E8
        for <linux-api@vger.kernel.org>; Wed,  3 Mar 2021 15:34:23 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id b10so26472099ybn.3
        for <linux-api@vger.kernel.org>; Wed, 03 Mar 2021 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dK3NMZEn6j+LEopfsKHiSKgLCccGDXi0UgAxRfW2Oqc=;
        b=PmpeEda9EVHOi2NUTA6CQFAIu3OnfUOUQQ1bsO2Wgb4Z1uXp+cFrBBjYJDNIBtXOTs
         /ckOxfORWw2x+c6lh9BCl/9/Rr3/34Oa+ujJ1Dbtl9cyMTSfcly6z6kzFxCVwEPDAf8X
         WwfEkSDvKoN4DZwVI3CiTHwAar1bL/8NnTjQ4x/6KFF+nqku5nwb1ciZ7kwpp6idKSnh
         RB6vdb5nk0v4z94zYx0S/+pkC/AM9E7zatTomJLb6+qeJjTG/2b1x87YaMeyV9M0M70l
         Xjwi2jPUWCxeQBBWPOfs9MN3LkjS5oQWbUtWkHUgml0L/3ZwnddJea2A85/vRg76WD7o
         6u/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dK3NMZEn6j+LEopfsKHiSKgLCccGDXi0UgAxRfW2Oqc=;
        b=AhaTlt9O20M+5UmBl+Y3IHYVx0oETZdVcHtMprNIchyKUB/EVX4yCyLAal/CU1R3kH
         /yBjgoEvjnJQPCk+8wnI8NLMwMvdzRiv7Wm4WDOPaCXNbjV52SCswEykWlycoBwaAKpp
         ObExhh29AltKZnMtjkqWeLHE9z/bHLwuAqHs9wi+lgOFKLlBYp9iu2pAk7XSpryKsiwI
         XdxdL+3o5BTpA0fD4rK6WmUOnsSUHGsnsmyijR7WEUKFlRDK9ZUX9q483NPJg89r+ep9
         a47dpUlcm+bAMKyjvu7NIRv/1C7JwTKWsTo6lJnyRye579n++RQoIhZ28gK5JXMDgEjq
         zfnQ==
X-Gm-Message-State: AOAM531wSiMJo35A/IMh60uqDGNmhsQgOj64/FPJXqYdmbL9FP0Bpxh7
        CAnkA5QTvDNkR0q5CuEFA5ZrSYRyDdxF0SBRagjKow==
X-Google-Smtp-Source: ABdhPJzc/mHrww3IY/9z3+WUQSdSGo89Gggng+nexIlrYjiTSXlmpCbrmm1SF2HqKZOC/kksFNF5jAzISE+d4+AHWE0=
X-Received: by 2002:a25:d74b:: with SMTP id o72mr2541368ybg.190.1614814462375;
 Wed, 03 Mar 2021 15:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20210303185807.2160264-1-surenb@google.com> <CALvZod73Uem8jzP3QQdQ6waXbx80UUOTJQS7WBwnmaCdq++8xw@mail.gmail.com>
In-Reply-To: <CALvZod73Uem8jzP3QQdQ6waXbx80UUOTJQS7WBwnmaCdq++8xw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 Mar 2021 15:34:11 -0800
Message-ID: <CAJuCfpFgDRezmQMjCajXzBp86UbMLMJbqEaeo0_J+pneZ5XOgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        James Morris <jmorris@namei.org>,
        Linux MM <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 3, 2021 at 3:17 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Mar 3, 2021 at 10:58 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
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
> > Cc: stable@vger.kernel.org # 5.10+
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Minchan Kim <minchan@kernel.org>
> > Acked-by: David Rientjes <rientjes@google.com>
> > ---
> > changes in v3
> > - Added Reviewed-by: Kees Cook <keescook@chromium.org>
> > - Created man page for process_madvise per Andrew's request: https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=a144f458bad476a3358e3a45023789cb7bb9f993
> > - cc'ed stable@vger.kernel.org # 5.10+ per Andrew's request
> > - cc'ed linux-security-module@vger.kernel.org per James Morris's request
> >
> >  mm/madvise.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index df692d2e35d4..01fef79ac761 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1198,12 +1198,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >                 goto release_task;
> >         }
> >
> > -       mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > +       /* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> > +       mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> >         if (IS_ERR_OR_NULL(mm)) {
> >                 ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> >                 goto release_task;
> >         }
> >
> > +       /*
> > +        * Require CAP_SYS_NICE for influencing process performance. Note that
> > +        * only non-destructive hints are currently supported.
>
> How is non-destructive defined? Is MADV_DONTNEED non-destructive?

Non-destructive in this context means the data is not lost and can be
recovered. I follow the logic described in
https://lwn.net/Articles/794704/ where Minchan was introducing
MADV_COLD and MADV_PAGEOUT as non-destructive versions of MADV_FREE
and MADV_DONTNEED. Following that logic, MADV_FREE and MADV_DONTNEED
would be considered destructive hints.
Note that process_madvise_behavior_valid() allows only MADV_COLD and
MADV_PAGEOUT at the moment, which are both non-destructive.

>
> > +        */
> > +       if (!capable(CAP_SYS_NICE)) {
> > +               ret = -EPERM;
> > +               goto release_mm;
> > +       }
> > +
> >         total_len = iov_iter_count(&iter);
> >
> >         while (iov_iter_count(&iter)) {
> > @@ -1218,6 +1228,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >         if (ret == 0)
> >                 ret = total_len - iov_iter_count(&iter);
> >
> > +release_mm:
> >         mmput(mm);
> >  release_task:
> >         put_task_struct(task);
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >
