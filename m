Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E30D23BED0
	for <lists+linux-api@lfdr.de>; Tue,  4 Aug 2020 19:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgHDRZV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Aug 2020 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgHDRZT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Aug 2020 13:25:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D5BC06174A
        for <linux-api@vger.kernel.org>; Tue,  4 Aug 2020 10:25:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so20980323ljc.3
        for <linux-api@vger.kernel.org>; Tue, 04 Aug 2020 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXauyaNpJWaHWHUFoCmJEOgEHnWy8BHkyRckLun7378=;
        b=eKiLu+oT3PzUQxgwb0aeO+3QR6BelCNjEuogqKv3421diZZdImy3wzNi7b9sHkjJSh
         3JIquL5IVeOz3Osv/rJJDfH3gHO6ozcpqIs4dwN6jGzXPIqcc3VbzjwVbU1xFRdrEFY5
         9hhtcWl7RJSqwRORKZyEeufhZ/Cnu5+UNlwAlQqXb04A8zAN7mqgxtoYeJ4kUz8B2nKD
         p2HZtPXhvqNvpPOZBfQiq+S2S+YZqAyzr7fWvbvoSsQCRGhELPOVWa1Pt1ZbSJMM+G4m
         RmBvh9iw11Un5aRoH+SpgtB8Nii0AUmq33vKxf28+Occq5Tiqrvh0+Ji4A2edhQ44Wa5
         MO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXauyaNpJWaHWHUFoCmJEOgEHnWy8BHkyRckLun7378=;
        b=Ob9/3zE/lc0E2Xl579mGHtVv6eqhtJ0xnh4pI4H6gTfq668qpqFOhzzkUKDxDKtXAy
         8hvp94bRTDrmoziLy0jzbzrQftgzZKOHBKC5/cOaoWZqjwdcRs3BsL95r7qYDWmj+SVg
         0t4Ktmk9Rt2EaxGNGTUxjEPUinEeJ1JUvY8wAHyeNoUfQH5+yR/bZm+whodBE7y5FJJH
         lB6rWYdFHAzT0lvwAOCDS002T4DbxD4XJg5s9/+bGzuU7RY8TXLdqNtgb7dQWIYvsP2c
         CcAtUtIhx34sY15bkwQJHRFyGRC5T1kh56VgD57AuMR9YWWxIlrD6OzM+RLLLvEjZ0c8
         ifpw==
X-Gm-Message-State: AOAM5333MDE8gzHGoi4Sn+Cyl9aYwaN/qd1VTkQ4KgWpACLwis9w6EtG
        SclILgs/7pMMv2Zz1gbZQDR+DrqHfte0WrZbH6DFAw==
X-Google-Smtp-Source: ABdhPJwC0ySOJJPqlRyJdn37WyyeeRdp8xWy9btQxYVtSBnHFw9HIk87PImZ4eVPHdT6uZIWpmmUFvUVuJuoj9xeUq8=
X-Received: by 2002:a2e:6804:: with SMTP id c4mr3166135lja.216.1596561916899;
 Tue, 04 Aug 2020 10:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <b3b4cf95-5eaa-0b4e-34cc-1a855e7148b6@gmail.com>
 <88273c2f-ce21-db54-688d-5bebd4a81ecd@redhat.com> <cbf7666c-440e-b4bd-0ff6-712123845fae@gmail.com>
 <c690ad2f-5f3c-5a8b-7b4c-ad29976aeab0@redhat.com> <CAJgzZoqR4Vh0phZjrDB9dgxNPzH0a35YjC1CwKb3mREOFn5Kbg@mail.gmail.com>
 <c756202e-7af8-c1b4-e99f-d77f3eae8c09@gmail.com>
In-Reply-To: <c756202e-7af8-c1b4-e99f-d77f3eae8c09@gmail.com>
From:   enh <enh@google.com>
Date:   Tue, 4 Aug 2020 10:25:05 -0700
Message-ID: <CAJgzZoqFvn649xG5XSNBmUutgGQ8b16ELhVsdf0XD0QwFrRtZw@mail.gmail.com>
Subject: Re: [RFC PATCH] Replacing "master-slave" terminology for pseudoterminals
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>,
        Zack Weinberg <zackw@panix.com>,
        Florian Weimer <fweimer@redhat.com>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 31, 2020 at 12:48 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hi Elliot,
>
> On 7/30/20 10:35 PM, enh wrote:
> > On Thu, Jul 30, 2020 at 4:38 AM Carlos O'Donell <carlos@redhat.com> wrote:
> >>
> >> On 7/30/20 5:16 AM, Michael Kerrisk (man-pages) wrote:
> >>> I know what you mean. One reason for that verbosity is the need to
> >>> clearly distinguish "pseudoterminal device/end" from "pseudoterminal
> >>> device pair". It's hard to avoid being wordy there.
> >>
> >> The perfect is the enemy of the good. My feeling is that as others
> >> write this text in emails or discussions, we'll eventually all settle
> >> on some other short form we find agreeable and then later we can adjust
> >> the man pages to use that.
> >
> > based on my own brief experience, i'm expecting that _code_ will
> > settle on pty and tty. but if you're reading the man pages to
> > understand the concepts -- which are inherently quite confusing -- i
> > think spelling things out in longhand might remain useful in that
> > context.
> >
> >> Until then taking the lead to change this
> >> language is the correct way forward.
> >
> > yeah, definitely.
> >
> > i'd prefer for michael to go first -- since the bionic documentation
> > is basically just a link to man7.org, and even without that he's the
> > canonical source -- but i'm happy to go first and submit my change
> > first if it helps us make progress :-)
>
> I'd prefer to take this a little slowly. I don't plan to merge the
> changes just yet. I'm interested to get a bit more feedback first,
> including from Zack. (I'm guessing Zack is on holiday or so, which
> is why we've not heard from him.) Also, if we have rough consensus
> on this change, I would like to raise it with the POSIX folk; it
> would of course be great if there was a corresponding change in the
> standard, so that we all (all UNIX) have a common set of reference
> terms.

the good news is that it came up at this week's austin group meeting...

the bad news is that (afaik) none of us were there.

i had been planning to suggest we try to join next week anyway, to
avoid having this stall again.

> Cheers,
>
> Michael
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
