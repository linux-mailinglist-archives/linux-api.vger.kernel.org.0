Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43173DE25B
	for <lists+linux-api@lfdr.de>; Tue,  3 Aug 2021 00:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhHBWQw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Aug 2021 18:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhHBWQv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Aug 2021 18:16:51 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B4C06175F
        for <linux-api@vger.kernel.org>; Mon,  2 Aug 2021 15:16:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j77so28933296ybj.3
        for <linux-api@vger.kernel.org>; Mon, 02 Aug 2021 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVGojMx+DUr0Bkpg2GauKzHjG+QgnSZtH0f6WVA+GT0=;
        b=By54SS2dwDkwJGwhuIY8NsqezsY4v2SSiJz/qQ9prW1GHhN67KM613ArcrnWbfN29w
         66vJKXYIXsQWnaTR7h1Zg/CFtOpvRzaM6jlIwcaNF46QV77I8s1SYBSas/aRaxTzZw9Q
         r5kcuWovT3l/xOkysf+JSJWN36GqoJxKjj8NvWoeAnhIirN6HY4zI3YG1GX4M6EB0jLA
         /n+GC3iP+r/Rv7q99K2vr6rxpb/M6LHy6+9m/dE7gM9Pa6wvZ262dyGCi6FvoYRW7OZi
         VuDuagjPRdTAPq4VP9znMB0RCmC61qRMholJzB5mVVtKwzz41MR9B6NTx5+ss6GAmQ3K
         QCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVGojMx+DUr0Bkpg2GauKzHjG+QgnSZtH0f6WVA+GT0=;
        b=riX3L0SEn9HCkijvZDEAUNcZ3l/C44HB9EiZej/b2RQRAmDn69NcMBwmQTB+cw4Hwm
         OcapurSSBrlgiTS5dYnFIij6FDOIWdWua3Pt94N94Z//FQfq92qeP6SLaKwAJSw4on5W
         uYWP0lmVJNU08zB7Ape51rgrKMIZ736uEHpm+ihJbEmPC4WUcBzK0MzLAC3NfnWUKqP6
         tXPxJ4dVLrhLw7C8dCHTgXzuIesVRDgznXsj4ddCVimtL8Ox7IKDsqPh4TVd5FOrL3Sv
         DbbslJcy4GK/r24/h7tEtk/Tyo7sb82DDldx+6Zyt0Od15kOeO/dH8yePrdyYKWnL6BQ
         jKGg==
X-Gm-Message-State: AOAM530yRlwkrquqwGPze8BY/6tpat5EtDvQrOc62rOC7t2JNl6JFSWn
        YA25V2+7VW41KyoBApdIS11KbUfIpOFkcX6AFADLvw==
X-Google-Smtp-Source: ABdhPJznsVErJkSBK2mP8Pgp6BYYOZiuyhX+5Nzyp4ctrjdWEjLWT0m8oePoA6y1TBwFp0C7H8pMMC76CRg5lw9NzP0=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr24318844ybc.136.1627942599134;
 Mon, 02 Aug 2021 15:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz> <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <YPqDnqULylkkzQG5@dhcp22.suse.cz> <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
 <CAJuCfpGmpwTv92joNuVPaEJg1PigtGQn2daywHaqF4TXjuiCWQ@mail.gmail.com>
 <CALvZod7Vb2MKgCcSYtsMd8F4sFb2K7jQk3AGSECYfKvd3MNqzQ@mail.gmail.com>
 <YP5jyLeYsN3JtdX8@dhcp22.suse.cz> <CALvZod4M6mF3VvAdade3n5fE1E0LQp+CeJHWLc+pHmZqqAhepg@mail.gmail.com>
 <CAJuCfpHObuK7jOcqdme9fU5=zFoteaY+5f2_uKdW0VQJa6H7OQ@mail.gmail.com>
 <CALvZod7-0zra65jTUUYx6Oi17GPbRtHpAtVysiTX4_=bfqthPA@mail.gmail.com> <CAJuCfpHVUZZFPBFc6SPWOT7TrH5=SczegruB1+j=2N_ka7DG4A@mail.gmail.com>
In-Reply-To: <CAJuCfpHVUZZFPBFc6SPWOT7TrH5=SczegruB1+j=2N_ka7DG4A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 2 Aug 2021 15:16:27 -0700
Message-ID: <CAJuCfpFKP=+pG=dLd5RLyDaqGN8HMHJaqSH9c-uvWckyMWweig@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 2, 2021 at 1:08 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Aug 2, 2021 at 1:05 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Mon, Aug 2, 2021 at 12:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Mon, Jul 26, 2021 at 6:44 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > On Mon, Jul 26, 2021 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > [...]
> > > > >
> > > > > Is process_mrelease on all of them really necessary? I thought that the
> > > > > primary reason for the call is to guarantee a forward progress in cases
> > > > > where the userspace OOM victim cannot die on SIGKILL. That should be
> > > > > more an exception than a normal case, no?
> > > > >
> > > >
> > > > I am thinking of using this API in this way: On user-defined OOM
> > > > condition, kill a job/cgroup and unconditionally reap all of its
> > > > processes. Keep monitoring the situation and if it does not improve go
> > > > for another kill and reap.
> > > >
> > > > I can add additional logic in between kill and reap to see if reap is
> > > > necessary but unconditionally reaping is more simple.
> > > >
> > > > >
> > > > > > An alternative would be to have a cgroup specific interface for
> > > > > > reaping similar to cgroup.kill.
> > > > >
> > > > > Could you elaborate?
> > > > >
> > > >
> > > > I mentioned this in [1] where I was thinking if it makes sense to
> > > > overload cgroup.kill to also add the SIGKILLed processes in
> > > > oom_reaper_list. The downside would be that there will be one thread
> > > > doing the reaping and the syscall approach allows userspace to reap in
> > > > multiple threads. I think for now, I would go with whatever Suren is
> > > > proposing and we can always add more stuff if need arises.
> > > >
> > > > [1] https://lore.kernel.org/containers/CALvZod4jsb6bFzTOS4ZRAJGAzBru0oWanAhezToprjACfGm+ew@mail.gmail.com/
> > >
> > > Hi Folks,
> > > So far I don't think there was any request for further changes.
> > > Anything else you would want me to address or are we in a good shape
> > > wrt this feature?
> > > If so, would people who had a chance to review this patchset be
> > > willing to endorse it with their Reviewed-by or Acked-by?
> >
> > I think with Michal's suggestion to use a killable mmap lock, at least
> > I am good with the patch.
>
> Ah, yes. Thanks for pointing this out! I'll replace mmap_read_lock()
> with mmap_read_lock_killable(). Will post an updated version later
> today.

Posted the next version at https://lore.kernel.org/patchwork/patch/1471403/
