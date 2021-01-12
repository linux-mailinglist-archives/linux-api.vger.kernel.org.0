Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA52F3827
	for <lists+linux-api@lfdr.de>; Tue, 12 Jan 2021 19:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406360AbhALSNF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Jan 2021 13:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406340AbhALSMw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Jan 2021 13:12:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F50C061575
        for <linux-api@vger.kernel.org>; Tue, 12 Jan 2021 10:12:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g10so1279628wmh.2
        for <linux-api@vger.kernel.org>; Tue, 12 Jan 2021 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smXyl8aMoZOEr9J+WPP+DzU0ZsazRkPgKalBFLKErx4=;
        b=pIKsGNS7XHejO5gTe8wbn24/35SeJMW+SvSJ/oeKw17yifkmaFlfbY9+v66BJ7um5N
         jU+IZrFDd6idbjz3QMSPU1pUH3f9jUl95GJRt8W0v+LVJIO+2jf7snXL3mAKC9L//EMK
         BnBogYSBWvwjxmqPmRhwtpjK/wFUSLWKW4v7cI9+lddzYKjqxtV51WsYOKjn1kJb7Y8i
         KuYCguZi4+XAkVMo8O93yjXREx8rmKPnAG1WfT9kpAGQOwTBfmpug7TdUsfvnCpc8zVm
         40fWFaxeCpSkrVd746bx3+hRw39BqL48JDjWwBi8+2hnQtppjAqXxe/1drWSKIMgYa/Z
         FwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smXyl8aMoZOEr9J+WPP+DzU0ZsazRkPgKalBFLKErx4=;
        b=COskQ0CEQvrcUAdHjfwnXYWec3JGJMrUQxaMyP7WnKpBnguCY/5tsbfw8UrE9GnrpP
         IOlLbhz8gWr/GmHRHAWF89Sz/dT3B59llnhUuD+xpuM0U4GQ9+4S83mx2uQMnProvK/J
         TWkw8Hef25YcbXVYJgmCcquFx9jGH1R8Wm9tDdImRGzTvgiNX4pUZRAWhEi57zCuEePX
         nr3mcOEh3GxFXLgyV0U5cH9yZA5TxXxIUj4czV00Wjfw0RA2MfMm9W17f7I4QZrswgrd
         Js9wCZsvfxjxGyZ1nK+K2RmAkZu59fwj8QWb3nbFDJOdnrG0ChUASt0fXcrZqAQwztcO
         muzw==
X-Gm-Message-State: AOAM532euVBNAcMs2d6qAOzoEWKy2+oCOW+6etBrkIK1tRvbiBMMKMa3
        Vr6WEMjaf3jF7KI5fGeOzjkU0JHKMqRP/cQObvIVag==
X-Google-Smtp-Source: ABdhPJz5caMoBvGVsM71MxbmEH8PEzgl9neSsmGPzQ4gGQozZ+H8IpOItvaPYAYpiMSgpFD+C1qTg+cErr0BdINtfyU=
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr502029wmh.88.1610475134449;
 Tue, 12 Jan 2021 10:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <20210112074629.GG22493@dhcp22.suse.cz>
In-Reply-To: <20210112074629.GG22493@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Jan 2021 10:12:03 -0800
Message-ID: <CAJuCfpHazLXJ1rpJQ+w9=8-O==rzz3yEVuVtSn-sYMS+a3FoXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 11, 2021 at 11:46 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 11-01-21 09:06:22, Suren Baghdasaryan wrote:
> > process_madvise currently requires ptrace attach capability.
> > PTRACE_MODE_ATTACH gives one process complete control over another
> > process. It effectively removes the security boundary between the
> > two processes (in one direction). Granting ptrace attach capability
> > even to a system process is considered dangerous since it creates an
> > attack surface. This severely limits the usage of this API.
> > The operations process_madvise can perform do not affect the correctness
> > of the operation of the target process; they only affect where the data
> > is physically located (and therefore, how fast it can be accessed).
>
> Yes it doesn't influence the correctness but it is still a very
> sensitive operation because it can allow a targeted side channel timing
> attacks so we should be really careful.

Sorry, I missed this comment in my answer. Possibility of affecting
the target's performance including side channel attack is why we
require CAP_SYS_NICE.

>
> > What we want is the ability for one process to influence another process
> > in order to optimize performance across the entire system while leaving
> > the security boundary intact.
> > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > and CAP_SYS_NICE for influencing process performance.
>
> I have to say that ptrace modes are rather obscure to me. So I cannot
> really judge whether MODE_READ is sufficient. My understanding has
> always been that this is requred to RO access to the address space. But
> this operation clearly has a visible side effect. Do we have any actual
> documentation for the existing modes?
>
> I would be really curious to hear from Jann and Oleg (now Cced).
>
> Is CAP_SYS_NICE requirement really necessary?
>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Minchan Kim <minchan@kernel.org>
> > Acked-by: David Rientjes <rientjes@google.com>
> > ---
> >  mm/madvise.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 6a660858784b..a9bcd16b5d95 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
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
> > +             goto release_mm;
> > +     }
> > +
> >       total_len = iov_iter_count(&iter);
> >
> >       while (iov_iter_count(&iter)) {
> > @@ -1217,6 +1227,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >       if (ret == 0)
> >               ret = total_len - iov_iter_count(&iter);
> >
> > +release_mm:
> >       mmput(mm);
> >  release_task:
> >       put_task_struct(task);
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
>
> --
> Michal Hocko
> SUSE Labs
