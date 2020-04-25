Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87291B88CD
	for <lists+linux-api@lfdr.de>; Sat, 25 Apr 2020 21:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDYTM2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 25 Apr 2020 15:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgDYTM2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 25 Apr 2020 15:12:28 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED395C09B04D;
        Sat, 25 Apr 2020 12:12:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n17so10374841ejh.7;
        Sat, 25 Apr 2020 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=AvkTm+mzyMVnfea52ydtpICgabBlh0drjq1+bCYJ/0E=;
        b=owcl22kbPn701gTg+yz5fH4eADn9UPJ8LvqPgSsO//5pO5nQwCpMCPDuJ1Z0zEIjov
         JDLVjNvjiTacXVj5ZPcON8jy8rtBgWTBT0Nk6RzGo+blUwDf6J1QPfwVs6YmfM+992m3
         Z2l8B/Khn+FlsU0VmlFWwvcyNbGMK0lpCsH85HsSec+988C4vCXKgzzBM1z4uCfH/6Ob
         iZfD30qFau+ypGebisZTV/1tZ839Dz7aKJyHx3CyeWsrDaYDIUcI8S1dMta5aG0lb+da
         S1a61+C8LXQwF3BwcSm8HssCaW/CkxpZ72h9ZMNg4jTRGrw698xR/7gn9kgO/LkEGm34
         Z/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=AvkTm+mzyMVnfea52ydtpICgabBlh0drjq1+bCYJ/0E=;
        b=rn1O9YqqqEu83/XCZrt/+f8uI6x3CCENohdqVU3o4InVyPkVjAJPjjsi9lV+9D6A3B
         hyGcHNfzKie/DSaruD8isvvfM0ynDM3km1mLQjLyVTLeRTKRyC201qzDU4jbAw4F1l6O
         T2uI/189Ocu1tzh1Vz3HjU8tzp8ghm75xU5+XEXOH/y7p3Zzxdyn7Lv9KJzP1vWhh7jb
         DisVES/VrteEl502xdeidZyVJIAa/QhlMQAycwfWL/7Din2/krZrzFUTwo53CK1STXjX
         uVOXux2P062JwchJQAjpWu6wyXw8niu7WHpteN8+nB7b++RPJjNyQ2kP0cfvuf1Lj/Ra
         dsqQ==
X-Gm-Message-State: AGi0PuZe+vJzOQZGnIkra11hAVSse4hNxnXhWKDmpLd0YlUB/88oOGh5
        6GSS3U6oQCEFb2hiGqoaCF9WQZtMA9Xe6bGIhzw=
X-Google-Smtp-Source: APiQypIB4qwMx+YzraThqWvM/ROoqpHMd0pA8h8UYyusPpy0T9i5WYMdcs6pk91daKm+dz1FjXBYiWBtPVhtzTLdrqE=
X-Received: by 2002:a17:906:2488:: with SMTP id e8mr12844760ejb.157.1587841946564;
 Sat, 25 Apr 2020 12:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191128120140.20367-1-cyphar@cyphar.com> <20191128130840.GA3719@calabresa>
 <20191128135506.yo7432egjsg5ha5a@yavin.dot.cyphar.com>
In-Reply-To: <20191128135506.yo7432egjsg5ha5a@yavin.dot.cyphar.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sat, 25 Apr 2020 21:12:15 +0200
Message-ID: <CAKgNAkj9W7ay+YuQv1ct+LXE8tj1R+hzDDgGZo3KvWhWD0k2ug@mail.gmail.com>
Subject: Re: [PATCH] sched_getattr.2: update to include changed size semantics
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Aleksa,

I don't think there was ever a follow-up to this patch. Would you be
willing to send one?

Thanks,

Michael

On Thu, 28 Nov 2019 at 14:55, Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2019-11-28, Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> > On Thu, Nov 28, 2019 at 11:01:40PM +1100, Aleksa Sarai wrote:
> > > Due to a userspace breakage, commit 1251201c0d34 ("sched/core: Fix
> > > uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and
> > > code") changed the semantics of sched_getattr(2) when the userspace
> > > struct is smaller than the kernel struct. Now, any trailing non-zero
> > > data in the kernel structure is ignored when copying to userspace.
> > >
> > > Ref: 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
> > >                     robustify sched_read_attr() ABI logic and code")
> > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > ---
> > >  man2/sched_setattr.2 | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/man2/sched_setattr.2 b/man2/sched_setattr.2
> > > index 76ffa14eba85..fbb67b8eb98b 100644
> > > --- a/man2/sched_setattr.2
> > > +++ b/man2/sched_setattr.2
> > > @@ -284,10 +284,8 @@ structure,
> > >  the additional bytes in the user-space structure are not touched.
> > >  If the caller-provided structure is smaller than the kernel
> > >  .I sched_attr
> > > -structure and the kernel needs to return values outside the provided space,
> > > -.BR sched_getattr ()
> > > -fails with the error
> > > -.BR E2BIG .
> > > +structure, the kernel will silently not return any values which would be stored
> > > +outside the provided space.
> > >  As with
> > >  .BR sched_setattr (),
> > >  these semantics allow for future extensibility of the interface.
> > > --
> > > 2.24.0
> > >
> >
> > I was thinking about documenting the difference in behavior of older kernels,
> > before uclamp support.
> >
> > However, in practice, for sched_getattr, the kernel never returned E2BIG (the
> > code uses EFBIG incorrectly, in fact). It does, however, return EINVAL for
> > sizes smaller than SCHED_ATTR_SIZE_VER0.
>
> I've been told the EFBIG was actually a typo and it was always meant to
> be E2BIG. But yes, the precise problem with the old semantics was that
> they weren't tested "in the wild" with a proper struct upgrade -- hence
> all of the headaches.
>
> If we ever do implement a copy_struct_to_user() we are almost certainly
> going to implement it with the new sched_getattr() semantics. To be
> honest, I'm not sure I can imagine a case where an old userspace program
> would benefit from being given an error saying that the kernel has some
> properties that it doesn't understand. (sched_getattr() is also weird
> for other reasons, such as the fact it takes a separate size argument.)
>
> > However, E2BIG is still mentioned below as a possible return value for
> > sched_getattr. Can you remove that too?
>
> Will do.
>
> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
