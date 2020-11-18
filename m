Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E752B8524
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 20:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgKRTzo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 14:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgKRTzo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Nov 2020 14:55:44 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3189C0613D6
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 11:55:43 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so3857625wmb.2
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 11:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqXDHDE0XNoMtMMP4vBpbYVH76sdGhaJz7TypcwTaQk=;
        b=iXe5RJU6Qev5NqSNAVez1nIdFf4mwr4StMPXUamTysxMolJ2bISoFP86SDCkk/iq4w
         BOAUoU/wGpAp0Q3JfluXCQcOk8zA00QGXOjuTpA6gGp059VhDsWE8hZ0zd/G/KQ1EVdp
         CEsCVsCFBDGZSUK4kbVKVwvMj2uX6QQldnSSfm4aozSKgjo2jHW4+mcddTqY7GnU+rHR
         JMIdsXOfrgccaF5Lz0DEr5pmSo83lOgr2ZnAaogukvZq5OK2LnmtvHhByuHyo2wHSK5X
         Zi8iYDF8/7BKsSIPD7UlbAYSctDwtnayVWouvo4M1CQE1vfZQk3KdDqPfvRYaNJdYgP2
         T5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqXDHDE0XNoMtMMP4vBpbYVH76sdGhaJz7TypcwTaQk=;
        b=kTE8vG7nrxO4cIiARZKfNi+e/VJsCV8nxtQRhSQB68luTfJDwjQzWz0aWnt0lN1ZiW
         hDJC5R+jtuvhq0BjGw7r9oAlkLTtmOxSN4tZSQfZN9VFxbCjJn+m2id1rqrqVAgDcXJc
         3uxDkNfF/XCch+goMP5tBU2mxPtNCWCR9qSysunUqdDh9DQW/dZS4o92eyTDVz0j2o/w
         Pca1j2khEIJEPfNbUSHPXTtt4r5S/Md/1RYoEZkyD8wvNi45XXtSL0y29EcnEIhQIv6C
         CPf99L9sdrEwnA4Abw03gN+8KYgjd8HOVnq3AvEEYQz/sqJbKhHzALnfXIXTMR7tvC2G
         7jzw==
X-Gm-Message-State: AOAM531FbN8yBXzuOujElfiyYLitnDgloqOsdyrQviSQHJ08SZcV7kmE
        J25jI3AR6xvZBXSdUlcsnKB1RCx7e7ptrtwtuPxZLQ==
X-Google-Smtp-Source: ABdhPJzM0gtpHpVIk3vy8y6gvZMI+xhgfXGjwgj2RAxX6jDpQagvQ44juJuIJT4mHSI3i8oKlYK/f8pnAUGJM5097A4=
X-Received: by 2002:a1c:e3c1:: with SMTP id a184mr782194wmh.88.1605729342286;
 Wed, 18 Nov 2020 11:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20201113173448.1863419-1-surenb@google.com> <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
 <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
 <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
 <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
 <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
 <CAJuCfpH-Qjm5uqfaUcfk0QV2zC76uL96FQjd88bZGBvCuXE_aA@mail.gmail.com>
 <20201113181632.6d98489465430a987c96568d@linux-foundation.org>
 <20201118154334.GT12284@dhcp22.suse.cz> <CAJuCfpGC1Kv2rC7oq-TT2dX1soy5J_R+y6DU8xEzVuJgOqHKAw@mail.gmail.com>
 <20201118193233.GV12284@dhcp22.suse.cz> <CAJuCfpGucpqxOzGhteFrtv-0HrSbAmZjLbA2=NCy-5UEx04mJw@mail.gmail.com>
In-Reply-To: <CAJuCfpGucpqxOzGhteFrtv-0HrSbAmZjLbA2=NCy-5UEx04mJw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Nov 2020 11:55:31 -0800
Message-ID: <CAJuCfpHP0n6Fyi6Lt9dUyYE72S5=iONkvDMkVSmKo6oRPjbMXQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Nov 18, 2020 at 11:51 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Nov 18, 2020 at 11:32 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 18-11-20 11:22:21, Suren Baghdasaryan wrote:
> > > On Wed, Nov 18, 2020 at 11:10 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 13-11-20 18:16:32, Andrew Morton wrote:
> > > > [...]
> > > > > It's all sounding a bit painful (but not *too* painful).  But to
> > > > > reiterate, I do think that adding the ability for a process to shoot
> > > > > down a large amount of another process's memory is a lot more generally
> > > > > useful than tying it to SIGKILL, agree?
> > > >
> > > > I am not sure TBH. Is there any reasonable usecase where uncoordinated
> > > > memory tear down is OK and a target process which is able to see the
> > > > unmapped memory?
> > >
> > > I think uncoordinated memory tear down is a special case which makes
> > > sense only when the target process is being killed (and we can enforce
> > > that by allowing MADV_DONTNEED to be used only if the target process
> > > has pending SIGKILL).
> >
> > That would be safe but then I am wondering whether it makes sense to
> > implement as a madvise call. It is quite strange to expect somebody call
> > a syscall on a killed process. But this is more a detail. I am not a
> > great fan of a more generic MADV_DONTNEED on a remote process. This is
> > just too dangerous IMHO.
>
> Agree 100%

I assumed here that by "a more generic MADV_DONTNEED on a remote
process" you meant "process_madvise(MADV_DONTNEED) applied to a
process that is not being killed". Re-reading your comment I realized
that you might have meant "process_madvice() with generic support to
large memory areas". I hope I understood you correctly.

>
> >
> > > However, the ability to apply other flavors of
> > > process_madvise() to large memory areas spanning multiple VMAs can be
> > > useful in more cases.
> >
> > Yes I do agree with that. The error reporting would be more tricky but
> > I am not really sure that the exact reporting is really necessary for
> > advice like interface.
>
> Andrew's suggestion for this special mode to change return semantics
> to the usual "0 or error code" seems to me like the most reasonable
> way to deal with the return value limitation.
>
> >
> > > For example in Android we will use
> > > process_madvise(MADV_PAGEOUT) to "shrink" an inactive background
> > > process.
> >
> > That makes sense to me.
> > --
> > Michal Hocko
> > SUSE Labs
