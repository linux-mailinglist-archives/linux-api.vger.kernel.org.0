Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2B7406FA4
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhIJQ3Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Sep 2021 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhIJQ3Y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Sep 2021 12:29:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6FC061756
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 09:28:13 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id g14so4093557ljk.5
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ni2JhLZQgk9Q6G2MUbeVWPBAuWIrAdHFzB95UL3/Sis=;
        b=FZrorI4CFj/1QAA+qnqt0Jg0yZPa9EKmXgA0exenFIey7++LpW0YpJ6Kh1Ivx2Y0Sx
         gfSJWmMk8X7/4+gITPhZ1eaBubFCD17NGZKsh6jm/hjttEpQTypNZWCuLJsfsmhEORAg
         B5N5vLra29/4UdTLPH/rZCa9+TS0+W399jX6uH8VwEwtky4tpSxUQOAAHwOxs765IWVN
         5RuRkvlkKZlMtSeitRNWPZaLgDSvcsiwiqeypfkwVXwCZ7754AdKLGr0ZD6el3+6bkBE
         lts09uJPRmZ3/wa6KujBoPA6mhewvVqFIKD85835Fi/m7EtCP66voRar5DXtHCN0ah8P
         1PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ni2JhLZQgk9Q6G2MUbeVWPBAuWIrAdHFzB95UL3/Sis=;
        b=mq/WmJ86W5Kq3D4bHxs14Dewkp6vnayQyWUT59pNrZA6kjG46gEi2VyKMFzkz6Mf/B
         NK96B+4ngETN+qf9zoFllFjMa4Dh0N5ptu7KqarbyN0gzj78lT5t84mW1S6YYrX78UlJ
         MtpDjyTyPfgVd5ffDk36GZsdC0NOLjWuieQPWpthyO+QaMW23l6ULtftSxgpRv+MxTBd
         a35kZRLcrL+kJa3KIv2DIG2TlesDMc0Dp7rABON0IMYBPMx+pUtKkcuQfQi56i2AafoI
         YEXBUhu7so8i6ASUd13dq2N5CuRssFpehS9GALtsJbFsis2DAD6JuT2f7bdgRoKlFnZq
         +inw==
X-Gm-Message-State: AOAM532J2x53BuYU8VC3/XLW92tUhQsi2RBDInfGReRLC/rxUmxQmcmb
        hCXRx9v3FX9SMKKO3RTJgwNJ5bRdqPMn2j4pJyXPXg==
X-Google-Smtp-Source: ABdhPJz4eFhp7mu1CoZeB0tGR4NbpNaTNku0TpUUxYeznocD2fVHVGVwoV8mh/6htHy4a0DYUGHwoQCLHqPcRnXSzYQ=
X-Received: by 2002:a2e:b44f:: with SMTP id o15mr4889575ljm.430.1631291291374;
 Fri, 10 Sep 2021 09:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
 <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
 <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com> <3591AC6D-45D2-476A-80B1-46BFA1742602@oracle.com>
In-Reply-To: <3591AC6D-45D2-476A-80B1-46BFA1742602@oracle.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 10 Sep 2021 09:28:00 -0700
Message-ID: <CAPNVh5fMUQCa37iprcAykgkHzY5Rj8DSiwtZBU6FbnzjOv8ciw@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific data
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 10, 2021 at 9:13 AM Prakash Sangappa
<prakash.sangappa@oracle.com> wrote:
>
>
>
> > On Sep 10, 2021, at 8:18 AM, Peter Oskolkov <posk@google.com> wrote:
> >
> > On Wed, Sep 8, 2021 at 5:16 PM Prakash Sangappa
> > <prakash.sangappa@oracle.com> wrote:
> >>
> >> Including liunx-kernel..
> >>
> >> Resending RFC. This patchset is not final. I am looking for feedback o=
n
> >> this proposal to share thread specific data for us in latency sensitiv=
e
> >> codepath.
> >
> > Hi Prakash,
>
>
> >
> > I'd like to add here that Jann and I have been discussing a similar
> > feature for my UMCG patchset:
> >
> > https://lore.kernel.org/lkml/CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=3DxG8H=
Zqj2n+OPoKw@mail.gmail.com/
>
> Hi Peter,
>
> I will take  a look.
>
> >
> > In short, due to the need to read/write to the userspace from
> > non-sleepable contexts in the kernel it seems that we need to have some
> > form of per task/thread kernel/userspace shared memory that is pinned,
> > similar to what your sys_task_getshared does.
>
> Exactly. For this reason wanted kernel to allocate the pinned memory.
> Didn=E2=80=99t want to deal with files etc as a large number threads will=
 be using
> the shared structure mechanism.
>
> >
> > Do you think your sys_task_getshared can be tweaked to return an
> > arbitrarily-sized block of memory (subject to overall constraints)
> > rather than a fixed number of "options"?
>
> I suppose it could. How big of a size? We don=E2=80=99t want to hold on t=
o
> arbitrarily large  amount of pinned memory. The preference would
> be for the kernel to decide what is going to be shared based on
> what functionality/data sharing is supported. In that sense the size
> is pre defined not something the userspace/application can ask.

There could be a sysctl or some other mechanism that limits the amount
of memory pinned per mm (or per task). Having "options" hardcoded for
such a generally useful feature seems limiting...

>
> I have not looked at your use case.
>
> >
> > On a more general note, we have a kernel extension internally at
> > Google, named "kuchannel", that is similar to what you propose here:
> > per task/thread shared memory with counters and other stat fields that
> > the kernel populates and the userspace reads (and some additional
> > functionality that is not too relevant to the discussion).
>
> We have few other use cases for this we are looking at, which I can
> describe later.
>
> -Prakash
>
> >
> > Thanks,
> > Peter
> >
> > [...]
>
