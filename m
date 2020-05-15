Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5A1D4D7A
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2020 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgEOMLI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 May 2020 08:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgEOMLI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 May 2020 08:11:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF685C061A0C;
        Fri, 15 May 2020 05:11:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g9so1999890edw.10;
        Fri, 15 May 2020 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=gwJ2Lc/Yk03IJOC1sFrTAqBzPkN1TQVWqWTUK+qoYiU=;
        b=VMkP8/Jkt2bRofOFAeYJ24ZC+NSUixoqxVFp9JDNhUaBJRGQJjJnHLkkgD8FcxL4jQ
         +Aeuzr09NZ3LRQ30nKqA28QLndOYpBEdMj1zlEVYqerDhaAaCYAcgIUDCicT/weIgdJB
         gzQlJdSp31fCnfXqhBgS9ecQ5IOqMYSPcFhEzEoOpteqezvmcWt7B8kmGf3UQ6NzIy0j
         POIpE7o8uRolvrf6t5A5HN/UwhSYGunqfMQp0svqKMfthdx/lawMsN/l3ZjjhhQvAuOu
         TM+ZWVjigArspnXNg3q14gRjzjOFl6UnbJI4wtDSnkARDlwWafv08/XRwYcrV4IxcciC
         XgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=gwJ2Lc/Yk03IJOC1sFrTAqBzPkN1TQVWqWTUK+qoYiU=;
        b=gxeAr2EBpi/oAqt2iKAjaZy/RpQnUB8q64frb8GXE+MzY1AdIvYsWtCfJ8tUK7m9Tb
         uNhrb1Fnj6klDYjkC+h/gwRRj9vZUPj+HQmD41MvlLuMGtL5mW/zWv9IjnyNzJQ4AYC4
         vK5HYbwNwo64D0HPkY1u7m+y+GYTLxYaM5rXz8r4eUMtB0a7174Stgb4/KZne1cFg0I0
         a7X28S7PwzLPvWHeQeqMQMTigOxa5RSNdwjsufzKDZvkozlxOo+LqrLOW6lKoNcWace3
         2Px/2mtten9TXWeTRINZlnGP/xKFOn5hpqyJzJbVCDJl6ZbU3Eof5v6Uf7Ce/621RB/f
         xxSg==
X-Gm-Message-State: AOAM5338pwkoV5PVuPjdaTrrIAjwxRxWqrKTYwrXodEzxpROjV0dENOO
        MFwEVlweukLGSDVEUaNZWSXkE18bfEo3xw1RNHQ=
X-Google-Smtp-Source: ABdhPJz1eN6Y3UUKLgv0yVbFFEhnGpFslITmprP9DtBrcM+YHui2Hkc909BKV9DKh/c7zASjG5QxxMPGVnRl9ToYdsQ=
X-Received: by 2002:aa7:d513:: with SMTP id y19mr2600654edq.367.1589544666281;
 Fri, 15 May 2020 05:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191128120140.20367-1-cyphar@cyphar.com> <20191128130840.GA3719@calabresa>
 <20191128135506.yo7432egjsg5ha5a@yavin.dot.cyphar.com> <CAKgNAkj9W7ay+YuQv1ct+LXE8tj1R+hzDDgGZo3KvWhWD0k2ug@mail.gmail.com>
In-Reply-To: <CAKgNAkj9W7ay+YuQv1ct+LXE8tj1R+hzDDgGZo3KvWhWD0k2ug@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 15 May 2020 14:10:55 +0200
Message-ID: <CAKgNAkiMNssJ2kCtGXd9ZUMFrG6uVtECBXMLGf2EZeS5-rkPKA@mail.gmail.com>
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

A ping also on this :-).

Cheers,

Michael

On Sat, 25 Apr 2020 at 21:12, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hi Aleksa,
>
> I don't think there was ever a follow-up to this patch. Would you be
> willing to send one?
>
> Thanks,
>
> Michael
>
> On Thu, 28 Nov 2019 at 14:55, Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2019-11-28, Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> > > On Thu, Nov 28, 2019 at 11:01:40PM +1100, Aleksa Sarai wrote:
> > > > Due to a userspace breakage, commit 1251201c0d34 ("sched/core: Fix
> > > > uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and
> > > > code") changed the semantics of sched_getattr(2) when the userspace
> > > > struct is smaller than the kernel struct. Now, any trailing non-zero
> > > > data in the kernel structure is ignored when copying to userspace.
> > > >
> > > > Ref: 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
> > > >                     robustify sched_read_attr() ABI logic and code")
> > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > ---
> > > >  man2/sched_setattr.2 | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/man2/sched_setattr.2 b/man2/sched_setattr.2
> > > > index 76ffa14eba85..fbb67b8eb98b 100644
> > > > --- a/man2/sched_setattr.2
> > > > +++ b/man2/sched_setattr.2
> > > > @@ -284,10 +284,8 @@ structure,
> > > >  the additional bytes in the user-space structure are not touched.
> > > >  If the caller-provided structure is smaller than the kernel
> > > >  .I sched_attr
> > > > -structure and the kernel needs to return values outside the provided space,
> > > > -.BR sched_getattr ()
> > > > -fails with the error
> > > > -.BR E2BIG .
> > > > +structure, the kernel will silently not return any values which would be stored
> > > > +outside the provided space.
> > > >  As with
> > > >  .BR sched_setattr (),
> > > >  these semantics allow for future extensibility of the interface.
> > > > --
> > > > 2.24.0
> > > >
> > >
> > > I was thinking about documenting the difference in behavior of older kernels,
> > > before uclamp support.
> > >
> > > However, in practice, for sched_getattr, the kernel never returned E2BIG (the
> > > code uses EFBIG incorrectly, in fact). It does, however, return EINVAL for
> > > sizes smaller than SCHED_ATTR_SIZE_VER0.
> >
> > I've been told the EFBIG was actually a typo and it was always meant to
> > be E2BIG. But yes, the precise problem with the old semantics was that
> > they weren't tested "in the wild" with a proper struct upgrade -- hence
> > all of the headaches.
> >
> > If we ever do implement a copy_struct_to_user() we are almost certainly
> > going to implement it with the new sched_getattr() semantics. To be
> > honest, I'm not sure I can imagine a case where an old userspace program
> > would benefit from being given an error saying that the kernel has some
> > properties that it doesn't understand. (sched_getattr() is also weird
> > for other reasons, such as the fact it takes a separate size argument.)
> >
> > > However, E2BIG is still mentioned below as a possible return value for
> > > sched_getattr. Can you remove that too?
> >
> > Will do.
> >
> > --
> > Aleksa Sarai
> > Senior Software Engineer (Containers)
> > SUSE Linux GmbH
> > <https://www.cyphar.com/>
>
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
