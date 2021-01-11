Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FEB2F1BC4
	for <lists+linux-api@lfdr.de>; Mon, 11 Jan 2021 18:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbhAKRGb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Jan 2021 12:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbhAKRGa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Jan 2021 12:06:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E173C061794
        for <linux-api@vger.kernel.org>; Mon, 11 Jan 2021 09:05:50 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 3so556585wmg.4
        for <linux-api@vger.kernel.org>; Mon, 11 Jan 2021 09:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHu1ckVRAMWx4RepAlDhc0i4dSbBejVwjp9wkCsGwWQ=;
        b=U8DCHxOZsNnXyHsqGt/aEYsvKCWeeNiemmjB41i5nfiN+qhhV7UhvWucy4ZZ50W9ya
         zKysXo93jowfFFeokf0s7lG6rUakqE5kd4+DIk3XeUI36UidX0kc5ti1qRvvCgO9UO2x
         hVPp85Jhh4Gm7ZelMM25WPtS/jQSC3s95fnmdSfFQMjFuZEKGaO5AO9uEASvwk/Xfn8z
         +VjqUJXYp3t6IpE1sBc3MFGU/NsX2HFZL0Ff9MqF+LiUYQp2t9JXTlbkYyYTvEB/OzhZ
         mpPlpyGqFACMFjZgtADlHwln/yvk6eFkGGVyuPBvaBIlfDJo8hEO+EtFZ6IJVKxpdUye
         t33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHu1ckVRAMWx4RepAlDhc0i4dSbBejVwjp9wkCsGwWQ=;
        b=RSYTO1Y9ZBN92uoreavLYa2gkYdwv8XoBt7orx8UWCJjPARj3DmEwDQKP0vr6Yv7hE
         2YjJVdH7Iz2hIj1AVBK0MbmdlxGBZnKL3lWAf/Yb+y7SgkL4iy5+/iB28iNiflLFdpsf
         sNb5qxW3D6obQ4RUNoHUsf9IOxLQrxBEyXqQ/rfIQltMUPPXJNZWH4LYdeGnfM82VaaR
         KX8oT6thP4hTUBuF2fuM6O1QVIgrUeXIPQ7pBs44LBnpJ36rF2aWhiKPnlnrkQRhrei8
         tbkUfxYCyqHDSQ4bQN0cVg4KbzCg2rZ4kYZ5ThOy/luGNkrRTWuK6V2sy6+vaP7nm/U3
         N34A==
X-Gm-Message-State: AOAM530AreVFuhcn7u1gwCpjjoDQbtICxnURMVCTOwg7IzJAMSnqL+6u
        QZJZrfE28uVtXls1R53xPQUIcPxnjkf0VrIMjuYCTQ==
X-Google-Smtp-Source: ABdhPJwuNTuUcYaBZ08xd/Ii7ZYohmL1BPrUHr53gbc0AGN0DmQFWjIcA/QD16dFhDbX+aMkVap0PfDnmCDOKrzq9QY=
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr612383wma.22.1610384748638;
 Mon, 11 Jan 2021 09:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20210108205857.1471269-1-surenb@google.com> <875z43rd0u.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <875z43rd0u.fsf@oldenburg2.str.redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 11 Jan 2021 09:05:37 -0800
Message-ID: <CAJuCfpGwer93uKRE3nqtmLwsUnK_Cn-Zz1bXuFGX94mmVxqQZg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
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

On Mon, Jan 11, 2021 at 2:20 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Suren Baghdasaryan:
>
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 6a660858784b..c2d600386902 100644
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
>
> Shouldn't this depend on the requested behavior?  Several operations
> directly result in observable changes, and go beyond performance tuning.

Thanks for the comment Florian.
process_madvise supports only MADV_COLD and MADV_PAGEOUT hints which
are both non-destructive (see process_madvise_behavior_valid()
function). Maybe you meant something else by "observable changes", if
so please clarify.
Thanks,
Suren.

>
> Thanks,
> Florian
> --
> Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
> Commercial register: Amtsgericht Muenchen, HRB 153243,
> Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
