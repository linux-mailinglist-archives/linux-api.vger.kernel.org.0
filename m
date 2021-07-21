Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F373D1275
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 17:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbhGUOxe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 10:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbhGUOxc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 10:53:32 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B261EC061575
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 08:34:08 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id x192so3816009ybe.6
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOE3NPRB7X+kOfCSnwgM1RAUX3A4OJ/1KLMM54dafzU=;
        b=vll2DpaSlntmS7LILP0YtMfKDyAnqJL2dlBVgLqgMHk6eZkoMY6Ewx06Vv73253V0+
         EiC0sLFG4nJibo2AQyD5kcA8Ca8FL7EKVKLPgxnVa6lGCrI53j4zeXIoCEwOjsL5ZpLp
         4g/aKw3zN3BLMelpjGCbtHlT2gPNNfPPfgNcJn8IKK8nfE1ZlbimXiWiRCrXCqHmyeN/
         Iw76LTIJ8rFYtVcuUNkDpfR2GO/k14MilQCvqg+vQRpNSWxQ/k6Q26NGHwwrD0ogaP9T
         hccwChHYLDuXRVWtyvzBAYGTs6dVMF1ty2zVlDgR1HUSGI8aOQzMWgLddDTXl5NgxbHN
         CG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOE3NPRB7X+kOfCSnwgM1RAUX3A4OJ/1KLMM54dafzU=;
        b=IPx4cEOLAS1WDO277yXslq3ITGzLFmxreywNjm3vafUIpSSWw1K+grhp/aUJD39OAn
         HPq1Cpyjeahuj4vggI6JEgM0KihvQLXRJQzE0ZRSlQA3pvYg20+tpT8aZkj2HnzJpYG2
         oilv0h0nUDHrv0/SA3IaxjRi2fM8zFBsKoI6o0sJS5pNcfpZKMjCiBCgRT7IveXD/mgo
         eJ/iqSVLPQqqPmD91LUCB4wXgrRi+4bhIzJcaXpQ762/zn5fBH4ePwdKv+p1eLZga0Y0
         Yvvai2rhBkXIkfDF7x7b8OQSnpNNkg1GteTQyQ39mYmNC+xZ9ZDG5ePNiuUs5Jlk2ZQs
         hKoA==
X-Gm-Message-State: AOAM5310PlYe3rDi0wbZ35VSELg+155wnJpDchqswnDRvw62PCTLXRyW
        GNM3cR3aCUJWNqCTdA+9Koii8iwDZtcRn00cbTMZew==
X-Google-Smtp-Source: ABdhPJyyTCPunnRzKWFhKCFsefVcfi2KAxUStCwy/XNh/S1k9zdtFicTPgnjha+Im/baQZ6P245+qmjJfROyxCqPch8=
X-Received: by 2002:a25:2e49:: with SMTP id b9mr48225098ybn.250.1626881647614;
 Wed, 21 Jul 2021 08:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210718214134.2619099-1-surenb@google.com> <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
 <20210720160707.2332738708948f7d865d67c1@linux-foundation.org> <ba763ed3-9ad1-9502-1ffc-3175446570d1@redhat.com>
In-Reply-To: <ba763ed3-9ad1-9502-1ffc-3175446570d1@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 21 Jul 2021 08:33:56 -0700
Message-ID: <CAJuCfpEB994Xj3FcmzyH1p3yOdLVf6EwZaGaRj7NJi_c9hbsRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm, oom: move task_will_free_mem up in the file to
 be used in process_mrelease
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 21, 2021 at 12:30 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 21.07.21 01:07, Andrew Morton wrote:
> > On Tue, 20 Jul 2021 14:43:52 +0200 David Hildenbrand <david@redhat.com> wrote:
> >
> >> On 18.07.21 23:41, Suren Baghdasaryan wrote:
> >>> process_mrelease needs to be added in the CONFIG_MMU-dependent block which
> >>> comes before __task_will_free_mem and task_will_free_mem. Move these
> >>> functions before this block so that new process_mrelease syscall can use
> >>> them.
> >>>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> ---
> >>> changes in v2:
> >>> - Fixed build error when CONFIG_MMU=n, reported by kernel test robot. This
> >>> required moving task_will_free_mem implemented in the first patch
> >>> - Renamed process_reap to process_mrelease, per majority of votes
> >>> - Replaced "dying process" with "process which was sent a SIGKILL signal" in
> >>> the manual page text, per Florian Weimer
> >>> - Added ERRORS section in the manual page text
> >>> - Resolved conflicts in syscall numbers caused by the new memfd_secret syscall
> >>> - Separated boilerplate code wiring-up the new syscall into a separate patch
> >>> to facilitate the review process
> >>>
> >>>    mm/oom_kill.c | 150 +++++++++++++++++++++++++-------------------------
> >>>    1 file changed, 75 insertions(+), 75 deletions(-)
> >>
> >> TBH, I really dislike this move as it makes git blame a lot harder with
> >> any real benefit.
> >>
> >> Can't you just use prototypes to avoid the move for now in patch #2?
> >>
> >> static bool task_will_free_mem(struct task_struct *task);
> >
> > This change makes the code better - it's silly to be adding forward
> > declarations just because the functions are in the wrong place.
>
> I'd really love to learn what "better" here means and if it's rather
> subjective. When it comes to navigating the code, we do have established
> tools for that (ctags), and personally I couldn't care less where
> exactly in a file the code is located.
>
> Sure, ending up with a forward-declaration for every function might not
> be what we want ;)
>
> >
> > If that messes up git-blame then let's come up with better tooling
> > rather than suffering poorer kernel code because the tools aren't doing
> > what we want of them.  Surely?
>
> I don't agree that what we get is "poorer kernel code" in this very
> instance; I can understand that we avoid forward-declarations when
> moving smallish functions. But moving two functions with 75 LOC is a bit
> too much for my taste at least -- speaking as someone who cares about
> easy backports and git-blame.

There is a third alternative here to have process_mrelease() at the
end of the file with its own #ifdef CONFIG_MMU block, maybe even
embedded in the function like this:

 int process_mrelease(int pidfd, unsigned int flags)
{
#ifdef CONFIG_MMU
        ...
#else
        return ENOSYS;
#endif
}

This would not require moving other functions.
Would that be better than the current approach or the forward declaration?

>
> Anyhow, just my 2 cents.
>
> --
> Thanks,
>
> David / dhildenb
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
