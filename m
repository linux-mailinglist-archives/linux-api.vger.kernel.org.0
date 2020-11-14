Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624AE2B2AE1
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 03:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKNCvt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 21:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgKNCvt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Nov 2020 21:51:49 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE1C0613D2
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 18:51:49 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so14785036wmd.2
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 18:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/pF82g4ci3xp6pW4O0nO7ylMYBzowQiQ/mlbHUCZjYM=;
        b=lfdqtHmEO2B3dirgmxVeOVkreCFY8yc6AV6c/Po/ambopcg50qfTbxC6PX8k70WymB
         yWIzqfHgvKtagwRTwkF1qfCLQsNtGJdnc99FLtZ0JFvpH7IlNFicfVEvzsxq52rG2kCN
         uhHpV7F4a4CrHmHrASuaAOgkvPwi6tFTO2CAMZ8+63nRrui9J9NYT1wFE/asvtGsfy9s
         AkVZ1B1S9baz3knpYDgLBcqt2A8MMbxm+e7Y4bluSFFpCcg2j7qBtLsOwkNHn7ZJp/Og
         ab0ZZM0EjYC+ESFVkW0iWTnTxhXd60ZuC+2gAxUT8ibRXXhgyZY8VZh6dNQBjCyHXf3G
         /xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/pF82g4ci3xp6pW4O0nO7ylMYBzowQiQ/mlbHUCZjYM=;
        b=CSZdrMwvJLgMEKvt/DGYhYH+E1I4QeQkXZ3FtL4Z2sCpVHsxflngzYnizE0JhSpCab
         cy1ljv/04QafVCgHAlvKf7ijryGpceo+FveKZHPFcM3rdeV0PEIAMThqopwF1gEpDoLt
         a3f0O7EoAr+hk290pboQcg27EwE8xgXUL3gPZmX270oS1NfUJ2rDfxRQq6i1dBct3KCD
         7F0ls/Q5z1awzjknenlGy6O0HJHcPREwgZ/K5jJwcuOxygr2giYCvLWVIENhZckIBqod
         8K8rf98RLUM2Qj95dhxDjT2QApSgLJamOfEPPgKbEi84HW0O/EmrGIfnvF8eNIPwjHYh
         5VVw==
X-Gm-Message-State: AOAM531yfJyKTvaxffuXd1ZF3CQI78APUkLiOdkIKrttvDwj+ncY8Nuu
        klbThCUFEgGrsCEgjPNXpS3PtPx1L+Az/b26ox+4lQ==
X-Google-Smtp-Source: ABdhPJwl3dK1Pst00k61vPihAcc18qxn5bQRviOKf/y8pjdzr3R0jjOBDf+WXIe5huKKNi3014n6lFP3HK6wVxHoZZo=
X-Received: by 2002:a1c:9c0e:: with SMTP id f14mr5192682wme.22.1605322307590;
 Fri, 13 Nov 2020 18:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20201113173448.1863419-1-surenb@google.com> <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
 <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
 <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
 <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
 <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
 <CAJuCfpH-Qjm5uqfaUcfk0QV2zC76uL96FQjd88bZGBvCuXE_aA@mail.gmail.com> <20201113181632.6d98489465430a987c96568d@linux-foundation.org>
In-Reply-To: <20201113181632.6d98489465430a987c96568d@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 13 Nov 2020 18:51:36 -0800
Message-ID: <CAJuCfpExoi-+TC1cR8mJMg_e+T6apoJj9x8DjTM01rw725XpQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 13, 2020 at 6:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 Nov 2020 17:57:02 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > On Fri, Nov 13, 2020 at 5:18 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 13 Nov 2020 17:09:37 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > > > > Seems to me that the ability to reap another process's memory is a
> > > > > > > generally useful one, and that it should not be tied to delivering a
> > > > > > > signal in this fashion.
> > > > > > >
> > > > > > > And we do have the new process_madvise(MADV_PAGEOUT).  It may need a
> > > > > > > few changes and tweaks, but can't that be used to solve this problem?
> > > > > >
> > > > > > Thank you for the feedback, Andrew. process_madvise(MADV_DONTNEED) was
> > > > > > one of the options recently discussed in
> > > > > > https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> > > > > > . The thread describes some of the issues with that approach but if we
> > > > > > limit it to processes with pending SIGKILL only then I think that
> > > > > > would be doable.
> > > > >
> > > > > Why would it be necessary to read /proc/pid/maps?  I'd have thought
> > > > > that a starting effort would be
> > > > >
> > > > >         madvise((void *)0, (void *)-1, MADV_PAGEOUT)
> > > > >
> > > > > (after translation into process_madvise() speak).  Which is equivalent
> > > > > to the proposed process_madvise(MADV_DONTNEED_MM)?
> > > >
> > > > Yep, this is very similar to option #3 in
> > > > https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> > > > and I actually have a tested prototype for that.
> > >
> > > Why is the `vector=NULL' needed?  Can't `vector' point at a single iovec
> > > which spans the whole address range?
> >
> > That would be the option #4 from the same discussion and the issues
> > noted there are "process_madvise return value can't handle such a
> > large number of bytes and there is MAX_RW_COUNT limit on max number of
> > bytes one process_madvise call can handle". In my prototype I have a
> > special handling for such "bulk operation" to work around the
> > MAX_RW_COUNT limitation.
>
> Ah, OK, return value.  Maybe process_madvise() shouldn't have done that
> and should have simply returned 0 on success, like madvise().
>
> I guess a special "nuke whole address space" command is OK.  But, again
> in the search for generality, the ability to nuke very large amounts of
> address space (but not the entire address space) would be better.
>
> The process_madvise() return value issue could be addressed by adding a
> process_madvise() mode which return 0 on success.
>
> And I guess the MAX_RW_COUNT issue is solvable by adding an
> import_iovec() arg to say "don't check that".  Along those lines.
>
> It's all sounding a bit painful (but not *too* painful).  But to
> reiterate, I do think that adding the ability for a process to shoot
> down a large amount of another process's memory is a lot more generally
> useful than tying it to SIGKILL, agree?

I see. So you are suggesting a mode where process_madvise() can
operate on large areas spanning multiple VMAs. This slightly differs
from option 4 in the previous RFC which suggested a special mode that
operates on the *entire* mm of the process. I agree, your suggestion
is more generic.

>
> > >
> > > > If that's the
> > > > preferred method then I can post it quite quickly.
> > >
> > > I assume you've tested that prototype.  How did its usefulness compare
> > > with this SIGKILL-based approach?
> >
> > Just to make sure I understand correctly your question, you are asking
> > about performance comparison of:
> >
> > // approach in this RFC
> > pidfd_send_signal(SIGKILL, SYNC_REAP_MM)
> >
> > vs
> >
> > // option #4 in the previous RFC
> > kill(SIGKILL); process_madvise(vector=NULL, MADV_DONTNEED);
> >
> > If so, I have results for the current RFC approach but the previous
> > approach was testing on an older device, so don't have
> > apples-to-apples comparison results at the moment. I can collect the
> > data for fair comparison if desired, however I don't expect a
> > noticeable performance difference since they both do pretty much the
> > same thing (even on different devices my results are quite close). I
> > think it's more a question of which API would be more appropriate.
>
> OK.  I wouldn't expect performance to be very different (and things can
> be sped up if so), but the API usefulness might be an issue.  Using
> process_madvise() (or similar) makes it a two-step operation, whereas
> tying it to SIGKILL&&TASK_UNINTERRUPTIBLE provides a more precise tool.
> Any thoughts on this?
>
