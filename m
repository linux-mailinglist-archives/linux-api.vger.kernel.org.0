Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F2C3B98D8
	for <lists+linux-api@lfdr.de>; Fri,  2 Jul 2021 01:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhGAXKp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Jul 2021 19:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGAXKp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Jul 2021 19:10:45 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC1BC061762
        for <linux-api@vger.kernel.org>; Thu,  1 Jul 2021 16:08:13 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r135so13620606ybc.0
        for <linux-api@vger.kernel.org>; Thu, 01 Jul 2021 16:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVFwhu0Nl1U9FivJTXYgbITws6r7aJBlzJ81RHuWBSo=;
        b=lYp1QR+VzXen7d2xJF2fbcLqhi1ay1+vCQpxCfKI+F1Y7rAEbyh89MNhAJooFga14A
         2CH/m1K/T8X3/uyuzQjJDfWZHqlboXl4tsagwV7koZJU7jeAfOYCnWCgWa/O4R5fwY3k
         yYnfPUXeE/8aSQXjZhSXs6EvokPk/NMTM5PpcQaBWdcNl0Dl55TWRBjo3DMictyRffxP
         FNevKNKq8Ym1jcjlF+kQrzoOANVGeNb9pQxesajua1x+gbaUcYlzLUHWX9Mz/Ee+5Yf1
         2ZFBoRILOFE+9MK5DbKOXMVrix+YZBY/am2DjjhmAb4abHoU+TtwSZ7pcjhIfuwthRJm
         tOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVFwhu0Nl1U9FivJTXYgbITws6r7aJBlzJ81RHuWBSo=;
        b=conCFWdmerEisjt93nI6X0w1m1RYXV8ZfFPvcAAHnzSvY8H1L4ZGxlzcDO6OrnDu63
         rLtw5s71doKZl8s3DTcmwCX0VPCv6YxmKC1aTw0trRzitRPJh/NRdtrXL2x4eO8hCvGL
         FhKtro0uHl+DnGbaomfOY3xdrsJrGu8SmrXHJT3AzzfElzlJkByNyhaTS4VR0z4uNvhG
         P5XbUEp6b4MMcp0Ow2vjpROZ7WWVb4Q1hCXmpOQDbvwmgB/PJ7d2CvHbMtSdzYX8YcOv
         MQ8NE/O3MNUuJgL7K1T6dOlEFvGZVxEixtoErm5AOpklii9Su6v71zKiOQELmoNTEcFs
         ITLw==
X-Gm-Message-State: AOAM531cCXQL9aFq4nLO65+Vnm7UJ5SO/XmvPiOhYkfFTV+r0l0UcUya
        /l+JYSY1Da7jJr74UW+Huwz57kgRXFr/4s4Qh4aQ9g==
X-Google-Smtp-Source: ABdhPJzlD1Rwyg4aaTXscYYkLEEMfARA5rwHrPGJiwB0C5EZgf9sRsRKGD9SS7+cgRsYyt0WzPidD7cw4j9F8JmjJMM=
X-Received: by 2002:a25:2341:: with SMTP id j62mr3050343ybj.190.1625180892125;
 Thu, 01 Jul 2021 16:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com> <CALCETrW7Mm6xNwdhsEd9LZFJNJ_5ZtBPfTiqs=np3V7cqo=cAA@mail.gmail.com>
In-Reply-To: <CALCETrW7Mm6xNwdhsEd9LZFJNJ_5ZtBPfTiqs=np3V7cqo=cAA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Jul 2021 16:08:01 -0700
Message-ID: <CAJuCfpEWmcJSKuAD+4yOcWyTTDTo0p7Aico5FruXZcyZt120Jg@mail.gmail.com>
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

)

On Wed, Jun 30, 2021 at 5:46 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Jun 30, 2021 at 11:51 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On Wed, Jun 23, 2021 at 12:28 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > In modern systems it's not unusual to have a system component monitoring
> > > > memory conditions of the system and tasked with keeping system memory
> > > > pressure under control. One way to accomplish that is to kill
> > > > non-essential processes to free up memory for more important ones.
> > > > Examples of this are Facebook's OOM killer daemon called oomd and
> > > > Android's low memory killer daemon called lmkd.
> > > > For such system component it's important to be able to free memory
> > > > quickly and efficiently. Unfortunately the time process takes to free
> > > > up its memory after receiving a SIGKILL might vary based on the state
> > > > of the process (uninterruptible sleep), size and OPP level of the core
> > > > the process is running. A mechanism to free resources of the target
> > > > process in a more predictable way would improve system's ability to
> > > > control its memory pressure.
> > > > Introduce process_reap system call that reclaims memory of a dying process
> > > > from the context of the caller. This way the memory in freed in a more
> > > > controllable way with CPU affinity and priority of the caller. The workload
> > > > of freeing the memory will also be charged to the caller.
> > > > The operation is allowed only on a dying process.
> > >
> > > At the risk of asking a potentially silly question, should this just
> > > be a file in procfs?
> >
> > Hmm. I guess it's doable if procfs will not disappear too soon before
> > memory is released... syscall also supports parameters, in this case
> > flags can be used in the future to support PIDs in addition to PIDFDs
> > for example.
> > Before looking more in that direction, a silly question from my side:
> > why procfs interface would be preferable to a syscall?
>
> It avoids using a syscall nr.  (Admittedly a syscall nr is not *that*
> precious of a resource.)  It also makes it possible to use a shell
> script to do this, which is maybe useful.

I see. Not really sure if the shell usage is a big usecase for this
operation but let's see if more people like that approach. For my
specific usecase one syscall (process_reap) is better than three
syscalls (open, write, close) and the possibility to extend the
functionality using flags might be of value for the future.

>
> --Andy
