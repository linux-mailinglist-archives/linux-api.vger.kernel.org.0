Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C9840720E
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 21:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhIJTh6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Sep 2021 15:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhIJTh6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Sep 2021 15:37:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88126C061756
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 12:36:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id f2so4941224ljn.1
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MxYG3oQ5GLJLXh/udMSbpNxO67lymB3pYR+6ivwJVGg=;
        b=dIPk8+MOkoDL8UzaYpVPnebIT6lPLIhM+Km0cGozYUcAd6riuY8F9aJqNnl6Yi+K3c
         HsErue62OffPI5GMJJZPwCOFZXc4Y2qKNvOe3wSQj2V10FG1Xwh8Le7NluHOADKniwCY
         OsBMcnJRzrsqLO4CWZAvNQ68gto8r+vXHA2qWU0sS9dAqb0ca8qdK1VAuZpkBdPryBg/
         31JB9aRX9oQS+KG7+rOBKNP9GFliGzO/ml9W3CjF+JFLP9Ho37ucySjuWtbpFRiQll6O
         kWD0506kUXdjErMVRqILnaCFrI0CFSoMMp6ivDGKwbiommTvlfP6tmxFu4SJA/OLcmTQ
         7lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MxYG3oQ5GLJLXh/udMSbpNxO67lymB3pYR+6ivwJVGg=;
        b=xeRcSwR7MwjTMKgGLW05uR3JaxfKRYhCYf7/aRhhA9BxtvYTMJThxQF3BEs/DikvuN
         GSq35YPNPaSjki/KejICwA3QW6srVcNjkvSAcaBFQNiy7v+yLwpueITakLW4ffIbCc7K
         k6QZWlA6lNzOlQ/w+FqtjqeSntI4s2uw3gKg2ZIT+rJEH8IOxALTktliIvfsv4UFrvTE
         laGWR8gitdIAWGmcVCAi80mN3lmnt8zTdsKTgxg4/SVdYab2tvk4je+7Zz0yP6NgZ21k
         4M0uE7u46OoGie0wK6EJ/dXZwSNHEoxcP3JC7Z5IF3ekCabb8aCUuOC0aaSPbhvD34F+
         RjvA==
X-Gm-Message-State: AOAM530y1pb14GWrwC2HQv5uancWyL0Q5Khi7X/v+7pa9jzWcVVxyMkm
        AoRTBs7gWAUzIDVbNQOB1SQuYdNG5KOy1M92VoDGlw==
X-Google-Smtp-Source: ABdhPJz4+6T/K0xrvvEKNssVnq2g5qLgSxrRWwEYdgoA26xREhTizSjUO4EsmmbODXakmfL1ktnU4MSev+fdJw0f7wA=
X-Received: by 2002:a2e:1556:: with SMTP id 22mr5235455ljv.253.1631302604595;
 Fri, 10 Sep 2021 12:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
 <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
 <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
 <3591AC6D-45D2-476A-80B1-46BFA1742602@oracle.com> <CAPNVh5fMUQCa37iprcAykgkHzY5Rj8DSiwtZBU6FbnzjOv8ciw@mail.gmail.com>
 <CAG48ez1sPjPYePmXTgtFbaj6_0yY0Z_bGw+apwO_zTV-qwftSA@mail.gmail.com>
In-Reply-To: <CAG48ez1sPjPYePmXTgtFbaj6_0yY0Z_bGw+apwO_zTV-qwftSA@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 10 Sep 2021 12:36:33 -0700
Message-ID: <CAPNVh5fP-QnziX7NpYqKv+0Ha8-prhvTHiCbUB0jx+_P36QUGg@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific data
To:     Jann Horn <jannh@google.com>
Cc:     Prakash Sangappa <prakash.sangappa@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 10, 2021 at 12:12 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Sep 10, 2021 at 6:28 PM Peter Oskolkov <posk@google.com> wrote:
> > On Fri, Sep 10, 2021 at 9:13 AM Prakash Sangappa
> > <prakash.sangappa@oracle.com> wrote:
> > > > Do you think your sys_task_getshared can be tweaked to return an
> > > > arbitrarily-sized block of memory (subject to overall constraints)
> > > > rather than a fixed number of "options"?
> > >
> > > I suppose it could. How big of a size? We don=E2=80=99t want to hold =
on to
> > > arbitrarily large  amount of pinned memory. The preference would
> > > be for the kernel to decide what is going to be shared based on
> > > what functionality/data sharing is supported. In that sense the size
> > > is pre defined not something the userspace/application can ask.
> >
> > There could be a sysctl or some other mechanism that limits the amount
> > of memory pinned per mm (or per task). Having "options" hardcoded for
> > such a generally useful feature seems limiting...
>
> That seems like it'll just create trouble a few years down the line
> when the arbitrarily-chosen limit that nobody is monitoring blows up
> in someone's production environment.
>
> If this area is used for specific per-thread items, then the kernel
> should be able to enforce that you only allocate as much space as is
> needed for all threads of the process (based on the maximum number
> that have ever been running in parallel in the process), right? Which
> would probably work best if the kernel managed those allocations.

This sounds, again, as if the kernel should be aware of the kind of
items being allocated; having a more generic mechanism of allocating
pinned memory for the userspace to use at its discretion would be more
generally useful, I think. But how then the kernel/system should be
protected from a buggy or malicious process trying to grab too much?

One option would be to have a generic in-kernel mechanism for this,
but expose it to the userspace via domain-specific syscalls that do
the accounting you hint at. This sounds a bit like an over-engineered
solution, though...
