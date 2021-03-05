Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79BA32F223
	for <lists+linux-api@lfdr.de>; Fri,  5 Mar 2021 19:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCESIa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 5 Mar 2021 13:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCESI3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 5 Mar 2021 13:08:29 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B5DC061756
        for <linux-api@vger.kernel.org>; Fri,  5 Mar 2021 10:08:29 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d9so2893184ybq.1
        for <linux-api@vger.kernel.org>; Fri, 05 Mar 2021 10:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+6o5aVNdSv/9PF60BXlGDu7aBq8OxaHxrB0uLUzYrc=;
        b=Ny7RBbrR4UlOHG+dSivV32D5lTfFDCzcqftIe4uJ3WEY9i2EmbM46Yx3Zsf75eQzjh
         25bgNEBZHgpoLKAwZZtYu80p74H/p+WQ1aPU4sTbAqKqI/hPS17ucdidYpFSCmy9CfGR
         pSbu/iLFv0UdpdJV5sspL9FXS3QixX75F9ifzlpm+dogqs4rlJPoee7316SO7JPSl/78
         364PENxK8UAci0rkZBNJMCDtnHDFY6kSmGYTr9eVnXDOsmX2bUWvlnkRJesiyfi7VrZd
         rFpWHDvFxpIORgE5AgAjTstkr43hqtBRKxomoIBoju1bRkumL1zhVMGpeOENsGLpCik2
         CPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+6o5aVNdSv/9PF60BXlGDu7aBq8OxaHxrB0uLUzYrc=;
        b=gqPql+Y4B4eJHk8guP9qVA5iZE0L0HAy1GlMw4UHZ1hYXGF0iluSOuFhoDZFJXmQlY
         m4++Ymhd6sGqtUuhTnfDCOAuAZPO/N0S5Gyvj+ho02evORih5Qd2gO4k9edLBa8Pc0oz
         Q0DppxIZemZAzNVmiSJu/4reu9PPS90drfHAYQKpnhuc+kKDqMu5ZgigwhXUqB8lgwsg
         YIudOZgH5JJ08FNuQiNrS6qiXdKh7Oc3+kQ+T+T6JUrT/lwlzSB9xU+kGd3jJZyhKpQO
         ic6amybxkgRL6cLP0ntQ3CkTAeageZmAYoRPRCtl2RPpJBHQKTYrGwskkLAjFDbOKBRo
         8bTg==
X-Gm-Message-State: AOAM533Gaz380JR9X1l9rXaaw3PZ5/a4nS5/L/3HolsM4fvjgMb7esSB
        wVB6dsTNzcLlKDR8mnsNcQmCqye6afxCjrcT8sOWtQ==
X-Google-Smtp-Source: ABdhPJxCWzTmoai1hZsnAOSmpEhu3oMti16AH2dM9Cjc38rmCbSq4yE+FjTWUWXUJKlm5vAU7D3kMKHzk+97El7TTj8=
X-Received: by 2002:a25:4444:: with SMTP id r65mr16151762yba.84.1614967708501;
 Fri, 05 Mar 2021 10:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20210303185807.2160264-1-surenb@google.com> <CALvZod73Uem8jzP3QQdQ6waXbx80UUOTJQS7WBwnmaCdq++8xw@mail.gmail.com>
 <CAJuCfpFgDRezmQMjCajXzBp86UbMLMJbqEaeo0_J+pneZ5XOgg@mail.gmail.com>
 <CALvZod4nZ6W05N-4ostUEz5EbCuEvuBpc4LRYfAFgwQU-wb9dQ@mail.gmail.com>
 <b45d9599-b917-10c3-6b86-6ecd8db16d43@redhat.com> <CALvZod6b8H-=N6WVrgMVLE3=pm-ELWerjAO5v5KHSH-ih337+g@mail.gmail.com>
 <c234a564-a052-b586-2a32-8580aaf8ca5d@redhat.com>
In-Reply-To: <c234a564-a052-b586-2a32-8580aaf8ca5d@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 5 Mar 2021 10:08:17 -0800
Message-ID: <CAJuCfpHmks2Lxu8j0LaU+yhS3yO62=4qo=Jinr3mK0Km7yguAQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     David Hildenbrand <david@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, Mar 5, 2021 at 9:52 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 05.03.21 18:45, Shakeel Butt wrote:
> > On Fri, Mar 5, 2021 at 9:37 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 04.03.21 01:03, Shakeel Butt wrote:
> >>> On Wed, Mar 3, 2021 at 3:34 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >>>>
> >>>> On Wed, Mar 3, 2021 at 3:17 PM Shakeel Butt <shakeelb@google.com> wrote:
> >>>>>
> >>>>> On Wed, Mar 3, 2021 at 10:58 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >>>>>>
> >>>>>> process_madvise currently requires ptrace attach capability.
> >>>>>> PTRACE_MODE_ATTACH gives one process complete control over another
> >>>>>> process. It effectively removes the security boundary between the
> >>>>>> two processes (in one direction). Granting ptrace attach capability
> >>>>>> even to a system process is considered dangerous since it creates an
> >>>>>> attack surface. This severely limits the usage of this API.
> >>>>>> The operations process_madvise can perform do not affect the correctness
> >>>>>> of the operation of the target process; they only affect where the data
> >>>>>> is physically located (and therefore, how fast it can be accessed).
> >>>>>> What we want is the ability for one process to influence another process
> >>>>>> in order to optimize performance across the entire system while leaving
> >>>>>> the security boundary intact.
> >>>>>> Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> >>>>>> and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> >>>>>> and CAP_SYS_NICE for influencing process performance.
> >>>>>>
> >>>>>> Cc: stable@vger.kernel.org # 5.10+
> >>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
> >>>>>> Acked-by: Minchan Kim <minchan@kernel.org>
> >>>>>> Acked-by: David Rientjes <rientjes@google.com>
> >>>>>> ---
> >>>>>> changes in v3
> >>>>>> - Added Reviewed-by: Kees Cook <keescook@chromium.org>
> >>>>>> - Created man page for process_madvise per Andrew's request: https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=a144f458bad476a3358e3a45023789cb7bb9f993
> >>>>>> - cc'ed stable@vger.kernel.org # 5.10+ per Andrew's request
> >>>>>> - cc'ed linux-security-module@vger.kernel.org per James Morris's request
> >>>>>>
> >>>>>>    mm/madvise.c | 13 ++++++++++++-
> >>>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/mm/madvise.c b/mm/madvise.c
> >>>>>> index df692d2e35d4..01fef79ac761 100644
> >>>>>> --- a/mm/madvise.c
> >>>>>> +++ b/mm/madvise.c
> >>>>>> @@ -1198,12 +1198,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >>>>>>                   goto release_task;
> >>>>>>           }
> >>>>>>
> >>>>>> -       mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> >>>>>> +       /* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> >>>>>> +       mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> >>>>>>           if (IS_ERR_OR_NULL(mm)) {
> >>>>>>                   ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> >>>>>>                   goto release_task;
> >>>>>>           }
> >>>>>>
> >>>>>> +       /*
> >>>>>> +        * Require CAP_SYS_NICE for influencing process performance. Note that
> >>>>>> +        * only non-destructive hints are currently supported.
> >>>>>
> >>>>> How is non-destructive defined? Is MADV_DONTNEED non-destructive?
> >>>>
> >>>> Non-destructive in this context means the data is not lost and can be
> >>>> recovered. I follow the logic described in
> >>>> https://lwn.net/Articles/794704/ where Minchan was introducing
> >>>> MADV_COLD and MADV_PAGEOUT as non-destructive versions of MADV_FREE
> >>>> and MADV_DONTNEED. Following that logic, MADV_FREE and MADV_DONTNEED
> >>>> would be considered destructive hints.
> >>>> Note that process_madvise_behavior_valid() allows only MADV_COLD and
> >>>> MADV_PAGEOUT at the moment, which are both non-destructive.
> >>>>
> >>>
> >>> There is a plan to support MADV_DONTNEED for this syscall. Do we need
> >>> to change these access checks again with that support?
> >>
> >> Eh, I absolutely don't think letting another process discard memory in
> >> another process' address space is a good idea. The target process can
> >> observe that easily and might even run into real issues.
> >>
> >> What's the use case?
> >>
> >
> > Userspace oom reaper. Please look at
> > https://lore.kernel.org/linux-api/20201014183943.GA1489464@google.com/T/
> >
>
> Thanks, somehow I missed that (not that it really changed my opinion on
> the approach while skimming over the discussion :) will have a more
> detailed look)

The latest version of that patchset is:
https://lore.kernel.org/patchwork/patch/1344419/
Yeah, memory reaping is a special case when we are operating on a
dying process to speed up the release of its memory. I don't know if
for that particular case we need to make the checks stricter. It's a
dying process anyway and the data is being destroyed. Allowing to
speed up that process probably can still use CAP_SYS_NICE.

>
> --
> Thanks,
>
> David / dhildenb
>
