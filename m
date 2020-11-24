Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB12C1DB2
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 06:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgKXFpj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 00:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgKXFpj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 00:45:39 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435BC0613CF
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 21:45:38 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so21075525wrw.1
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 21:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFs/RObUOd+On4EQgVH9l81JcWrm5Ewwy7I/EnEZpRc=;
        b=pHVSEjjgKCPj8u1WeC6H1FiX781gs+9vslN4mIY0bI7J2Sx2Op0HBNitySKWudQiEn
         gPYVmik42GHdvJhKRFEj3WNt+1P2H0t1Npsu7BXIhBR1g6E33S58c+i6bGRW0aSHDZuq
         HhNaWJDjo7QaJCo+nGCwBZC9luRQ/42c+LbqGBiUWrtqwZ/+29p5nVf1M9s0ZqJX0eXi
         4RHYmMBLesird3OdOSDKLe2K6ElGTmhooNWSrFcJvOQTHONKSQ0Q24Fcsz49fkhnANlB
         ted1e00qJnyYjb9Tsq7X3WaXKTpmFDMkxJA8JjW5s4VDdEEqPU8X9jDM3mlbFQwpy+H0
         d+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFs/RObUOd+On4EQgVH9l81JcWrm5Ewwy7I/EnEZpRc=;
        b=BdHwohdwLXT0DA4z3Wmw1ThEXqBPzcYE0gZuQnBK8v/6JYQ9ojPW8dxasUNXXN+uh7
         r2ikqkE52hh1FHRqw+TlzUYBPb6gVQVLxI2NLHvGmqaQYkUvjn8zsC46yc8nkXv7VPMH
         Hc4kr814rTiS/x3WhGYvZhEUvTi8JVl3rifQNO4gF2YoS221En99mhaAFiCOYDtkyQUp
         CEZHbKoVfXrhiavaRcSmdZMeft2DemCds8gxZPBLiyNa5WTUvK4kgf9zYZz1VwFOF0Bh
         eKmXhcGo9XF+daErxpwJsu0ZdT7XupzTZb/xOKE7NcQDKWlbeAkGdtI9kRw5MJYSt64f
         ULQQ==
X-Gm-Message-State: AOAM531+FBeGLvtPy6pTJIyFLaI2jKZWRVuicrVNoCNGLpqnxfhkFYwY
        kPHylAHdcyIEvhDeh9tP4WtW23MFcPgW5wa5JOy/WQ==
X-Google-Smtp-Source: ABdhPJxODaedfDJcEn/GE5PN1Gls3pL9/CyBaXh1Z/70lssTc6UFzgcH6nyYo0mbPkXC8ZbpEnvWxvwAfV18Muv+sz8=
X-Received: by 2002:adf:fd47:: with SMTP id h7mr3271659wrs.106.1606196737273;
 Mon, 23 Nov 2020 21:45:37 -0800 (PST)
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
 <CAJuCfpHP0n6Fyi6Lt9dUyYE72S5=iONkvDMkVSmKo6oRPjbMXQ@mail.gmail.com> <CAJuCfpH8nMijL+ADZnEWiceYE0MXEePYspSGyoNxq4CQC-nXgg@mail.gmail.com>
In-Reply-To: <CAJuCfpH8nMijL+ADZnEWiceYE0MXEePYspSGyoNxq4CQC-nXgg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Nov 2020 21:45:26 -0800
Message-ID: <CAJuCfpG9NPjJ5YnvT8LKLqk1jB71qCac36eGKajusbyKFsg3Jw@mail.gmail.com>
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

On Wed, Nov 18, 2020 at 4:13 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Nov 18, 2020 at 11:55 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Wed, Nov 18, 2020 at 11:51 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Wed, Nov 18, 2020 at 11:32 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 18-11-20 11:22:21, Suren Baghdasaryan wrote:
> > > > > On Wed, Nov 18, 2020 at 11:10 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Fri 13-11-20 18:16:32, Andrew Morton wrote:
> > > > > > [...]
> > > > > > > It's all sounding a bit painful (but not *too* painful).  But to
> > > > > > > reiterate, I do think that adding the ability for a process to shoot
> > > > > > > down a large amount of another process's memory is a lot more generally
> > > > > > > useful than tying it to SIGKILL, agree?
>
> I was looking into how to work around the limitation of MAX_RW_COUNT
> and the conceptual issue there is the "struct iovec" which has its
> iov_len as size_t that lacks capacity for expressing ranges like
> "entire process memory". I would like to check your reaction to the
> following idea which can be implemented without painful surgeries to
> the import_iovec and its friends.
>
> process_madvise(pidfd, iovec = [ { range_start_addr, 0 }, {
> range_end_addr, 0 } ], vlen = 2, behavior=MADV_xxx, flags =
> PMADV_FLAG_RANGE)
>
> So, to represent a range we pass a new PMADV_FLAG_RANGE flag and
> construct a 2-element vector to express range start and range end
> using iovec.iov_base members. iov_len member of the iovec elements is
> ignored in this mode. I know it sounds hacky but I think it's the
> simplest way if we want the ability to express an arbitrarily large
> range.
> Another option is to do what Andrew described as "madvise((void *)0,
> (void *)-1, MADV_PAGEOUT)" which means this mode works only with the
> entire mm of the process.
> WDYT?
>

To follow up on this discussion, I posted a patchset to implement
process_madvise(MADV_DONTNEED) supporting the entire mm range at
https://lkml.org/lkml/2020/11/24/21.

> > > > > >
> > > > > > I am not sure TBH. Is there any reasonable usecase where uncoordinated
> > > > > > memory tear down is OK and a target process which is able to see the
> > > > > > unmapped memory?
> > > > >
> > > > > I think uncoordinated memory tear down is a special case which makes
> > > > > sense only when the target process is being killed (and we can enforce
> > > > > that by allowing MADV_DONTNEED to be used only if the target process
> > > > > has pending SIGKILL).
> > > >
> > > > That would be safe but then I am wondering whether it makes sense to
> > > > implement as a madvise call. It is quite strange to expect somebody call
> > > > a syscall on a killed process. But this is more a detail. I am not a
> > > > great fan of a more generic MADV_DONTNEED on a remote process. This is
> > > > just too dangerous IMHO.
> > >
> > > Agree 100%
> >
> > I assumed here that by "a more generic MADV_DONTNEED on a remote
> > process" you meant "process_madvise(MADV_DONTNEED) applied to a
> > process that is not being killed". Re-reading your comment I realized
> > that you might have meant "process_madvice() with generic support to
> > large memory areas". I hope I understood you correctly.
> >
> > >
> > > >
> > > > > However, the ability to apply other flavors of
> > > > > process_madvise() to large memory areas spanning multiple VMAs can be
> > > > > useful in more cases.
> > > >
> > > > Yes I do agree with that. The error reporting would be more tricky but
> > > > I am not really sure that the exact reporting is really necessary for
> > > > advice like interface.
> > >
> > > Andrew's suggestion for this special mode to change return semantics
> > > to the usual "0 or error code" seems to me like the most reasonable
> > > way to deal with the return value limitation.
> > >
> > > >
> > > > > For example in Android we will use
> > > > > process_madvise(MADV_PAGEOUT) to "shrink" an inactive background
> > > > > process.
> > > >
> > > > That makes sense to me.
> > > > --
> > > > Michal Hocko
> > > > SUSE Labs
