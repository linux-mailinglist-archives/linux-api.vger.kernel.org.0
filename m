Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2E83B8B67
	for <lists+linux-api@lfdr.de>; Thu,  1 Jul 2021 02:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhGAAsb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 20:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237629AbhGAAsb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Jun 2021 20:48:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFCB26148E
        for <linux-api@vger.kernel.org>; Thu,  1 Jul 2021 00:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625100362;
        bh=0OplSnVaoxKOPAKIj0YXj4H1e8gkOZHWvzcV1/ElgJA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kzz/3Wd7G4WMacY6HfW3qXlVktscSpdpfr3dYCjztQ7jgvHma2uoNa+u5bJ7aYqMW
         +YnNpwAjslPwuF5aAZ/IZOpK9bHmfRixh1ogrjV36gWrne2GB7ea8YgAMtCrt4jKhd
         lkjq1+SeZabmlfJ78G5sr9E39HZTknSmtULkPkcMpaH67dI9i5csc6b01IbccNcLKd
         sPoNgm9ChotEQZ7kJAHppdkMQnuFOkAleSHZeQTREG/zagZ/vgL5fZeprMUi599wgC
         NH/JWm+iCAsFIj+G8XNPa7SJJXOrp2L322L+uLtwf815OtJh6nEjkARD73jx87+rI5
         vnEwTZDSC7x7Q==
Received: by mail-ed1-f44.google.com with SMTP id i5so5871851eds.1
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 17:46:01 -0700 (PDT)
X-Gm-Message-State: AOAM530AC3YaHdZMpB2xMgek+wWxPY87tR94J4mVUdl68cA+JK0RGe/i
        rmhv0W7nX/jbePeP2IL/ZNutTQ31WuKzcKdtTh7fHg==
X-Google-Smtp-Source: ABdhPJxUMSsYleMar6Ny4OBozaHRTablcTTgOJypvmdOI2KwxsSVPgnD113vOEQRqSPVn4WCmT84R/kKOTjaT4scv4A=
X-Received: by 2002:a05:6402:4393:: with SMTP id o19mr49699733edc.263.1625100360517;
 Wed, 30 Jun 2021 17:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
In-Reply-To: <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 30 Jun 2021 17:45:49 -0700
X-Gmail-Original-Message-ID: <CALCETrW7Mm6xNwdhsEd9LZFJNJ_5ZtBPfTiqs=np3V7cqo=cAA@mail.gmail.com>
Message-ID: <CALCETrW7Mm6xNwdhsEd9LZFJNJ_5ZtBPfTiqs=np3V7cqo=cAA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
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
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 30, 2021 at 11:51 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Jun 23, 2021 at 12:28 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > In modern systems it's not unusual to have a system component monitoring
> > > memory conditions of the system and tasked with keeping system memory
> > > pressure under control. One way to accomplish that is to kill
> > > non-essential processes to free up memory for more important ones.
> > > Examples of this are Facebook's OOM killer daemon called oomd and
> > > Android's low memory killer daemon called lmkd.
> > > For such system component it's important to be able to free memory
> > > quickly and efficiently. Unfortunately the time process takes to free
> > > up its memory after receiving a SIGKILL might vary based on the state
> > > of the process (uninterruptible sleep), size and OPP level of the core
> > > the process is running. A mechanism to free resources of the target
> > > process in a more predictable way would improve system's ability to
> > > control its memory pressure.
> > > Introduce process_reap system call that reclaims memory of a dying process
> > > from the context of the caller. This way the memory in freed in a more
> > > controllable way with CPU affinity and priority of the caller. The workload
> > > of freeing the memory will also be charged to the caller.
> > > The operation is allowed only on a dying process.
> >
> > At the risk of asking a potentially silly question, should this just
> > be a file in procfs?
>
> Hmm. I guess it's doable if procfs will not disappear too soon before
> memory is released... syscall also supports parameters, in this case
> flags can be used in the future to support PIDs in addition to PIDFDs
> for example.
> Before looking more in that direction, a silly question from my side:
> why procfs interface would be preferable to a syscall?

It avoids using a syscall nr.  (Admittedly a syscall nr is not *that*
precious of a resource.)  It also makes it possible to use a shell
script to do this, which is maybe useful.

--Andy
