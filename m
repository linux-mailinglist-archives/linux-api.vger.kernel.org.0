Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211043B88C6
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 20:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhF3SyT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 14:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhF3SyS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 14:54:18 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7EC0617A8
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 11:51:48 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i4so6699708ybe.2
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoBBBmTYhX92RzZNabmusTXUOu2aNFXN3aBTat+PLK8=;
        b=daVFivh6Fo86bv1Wet55ewJd8qrwOGm5ItRJ1EZ981lvQzwAQtcVcr528OLJT0AUrZ
         uPGqoruHC6FgqMwQmnVIHpZsWdvftIcPQiJTh36OpuWLYufqvDrGcZmo1EriiSuNz4e6
         ewBX7MlZFA4irWaGblZqYZZL6XX8cP6V0WPRPIeLkHoOuXvNqH68Y1t2W+60n5UrL1q4
         Lec3YL7rigYCRThrHT1oeZV47Av1+9FbORqyDORYJ3Va82PSX3CP1/IyYPkUPB2mxynQ
         H7zh/GZIicKa7n04VUE/s7aCo9EVClCt7RAs7JZHCQdbpUCf1HZfGEyHMQ6gb2JalHzd
         t43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoBBBmTYhX92RzZNabmusTXUOu2aNFXN3aBTat+PLK8=;
        b=My7qW4oEN/7m8i14qBa5F+iZw1V74737lWs4gGEh90UWyQtm9sV/uGNh1BJblkZLTo
         mNlT6RagapuP8SkOBO/i7eupMSEnrmYZYAq03NiRMEwxjU5AQYd8EX1m5ZQssLFH831T
         jqqjTpMf4guEO3rg+ColSLP4ZqRIZ4MJbjfVJGGSth+MgHombbDPLIsmf3+RRmaGzem+
         6lbkXe4qT4GZyNbT3ZW2RXTShPdChXlBHUBFKAi7mSIxSnLky28W4jFnMbo/oCkbrdat
         zWR6ETr0D2EXakvdcoDXSVcquvOXuUHIAx+iOmRqPBGPEFboMdXX15zxyr4/oT8NY7jv
         vioQ==
X-Gm-Message-State: AOAM533yOK/TfcPCoT4wMPSpyyVvGC7uXv9ViqWVEBj9Pyx0y1vQLDqq
        upcoBf7x7mCjqtNXUodoOn/EkIy3n19u98xKn85Duw==
X-Google-Smtp-Source: ABdhPJyKK+cDCxlBFy6A3X6BxKdCqBpHbAJ2DvVH7Xvrh+mJ3LBI5f4jNcPY6g5WKChTsyfqL2YzAZxR02WbxRbPTiU=
X-Received: by 2002:a25:d913:: with SMTP id q19mr48111254ybg.397.1625079107259;
 Wed, 30 Jun 2021 11:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
In-Reply-To: <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 30 Jun 2021 11:51:36 -0700
Message-ID: <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Jun 23, 2021 at 12:28 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > In modern systems it's not unusual to have a system component monitoring
> > memory conditions of the system and tasked with keeping system memory
> > pressure under control. One way to accomplish that is to kill
> > non-essential processes to free up memory for more important ones.
> > Examples of this are Facebook's OOM killer daemon called oomd and
> > Android's low memory killer daemon called lmkd.
> > For such system component it's important to be able to free memory
> > quickly and efficiently. Unfortunately the time process takes to free
> > up its memory after receiving a SIGKILL might vary based on the state
> > of the process (uninterruptible sleep), size and OPP level of the core
> > the process is running. A mechanism to free resources of the target
> > process in a more predictable way would improve system's ability to
> > control its memory pressure.
> > Introduce process_reap system call that reclaims memory of a dying process
> > from the context of the caller. This way the memory in freed in a more
> > controllable way with CPU affinity and priority of the caller. The workload
> > of freeing the memory will also be charged to the caller.
> > The operation is allowed only on a dying process.
>
> At the risk of asking a potentially silly question, should this just
> be a file in procfs?

Hmm. I guess it's doable if procfs will not disappear too soon before
memory is released... syscall also supports parameters, in this case
flags can be used in the future to support PIDs in addition to PIDFDs
for example.
Before looking more in that direction, a silly question from my side:
why procfs interface would be preferable to a syscall?

>
> Also, please consider removing all mention of the word "reap" from the
> user API.  For better or for worse, "reap" in UNIX refers to what
> happens when a dead task gets wait()ed.  I sincerely wish I could go
> back in time and gently encourage whomever invented that particular
> abomination to change their mind, but my time machine doesn't work.

I see. Thanks for the note. How about process_mem_release() and
replacing reap with release everywhere?

>
> --Andy
