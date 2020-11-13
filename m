Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644652B22A3
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 18:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKMRhf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 12:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKMRhe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Nov 2020 12:37:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F0EC0613D1
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 09:37:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 33so10797433wrl.7
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjhurK9P35kGnhWjbyimEvcQqerqsp2/lDGVzt9PJQE=;
        b=ghFs2rH1tOxUzusPZBY7hh+pYGf0lSRP1oZiBayW95v4HRIM53tzKkbLSh0pzuA5Co
         xfHhtLLdYKm2lD8HfJ/Q471eufx4MtA4EnYfIIUIZLQdzAjhwzJxqAJFLgi6DTGfCWXt
         VE51V6vz9UOot7j8ToGThJ5WRcoqDehfUZQ4IwLdu3FaFRGpkJevLb0EjnPfoBIeYXs5
         MCPP0KqGyKiMu30O+byGDpFRzV9S2EgR48Dbz7oDYVsNl9VTs9ZRdfnNtN7+lxKFG0HP
         M4Ofux07F5YxHa6/vFLE9zZOz3mRQBWIzHOzWNFPSAZIG+1D4vFt2vyXHpUr4u1MAZhJ
         FjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjhurK9P35kGnhWjbyimEvcQqerqsp2/lDGVzt9PJQE=;
        b=mGYaNvuX5LK49mIOcdjWHS0q7Mvab4LbKekI5QdBFdRocDMjd6tLRZx9Jc9oTrqdyy
         I1XAOLw3s/Z5KBOhbO9FEA+sgAvRXHBJ60ZKc61TgtveKQ62oL0ne7GOwK3wVfrqRqs0
         z/hCRPz94cqvz9xZflLrO0FHGY7kQ5bI1WJe28ZKyfwZv4MDmx7EWqBRmO1y6jHZU4FH
         Adv85wSjr7CxVywvYsRH7kBsGwqWZimJIqBolO0WttPcTs8Pr6/zeNf4ICGwnFnFxduF
         rKa081Jf7z8zbwvAgAVc8RM3GpR9uZdke+VtThuiK/AcN76Vompgd60d0TXtb2Rjyies
         TwRA==
X-Gm-Message-State: AOAM533FhMtlT53YWKZUtn/8zHvkKJVJrMj78rF8p5SBNruRwNgNAarG
        dRpDvmqynbiXeQTDA71Z+4HA1FT8MnmvTSXp7cMYbg==
X-Google-Smtp-Source: ABdhPJysGkR3uusoAbdMq81+hVOKWOIh9cN2NKfa5it3R7D7WPHOzI7MxNNO6qLC7Og9ApYXomjjySnltJCldDkJTG0=
X-Received: by 2002:adf:db87:: with SMTP id u7mr4984321wri.334.1605289050149;
 Fri, 13 Nov 2020 09:37:30 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz> <20201103213228.GB1631979@google.com>
 <20201104065844.GM21990@dhcp22.suse.cz> <20201104204051.GA3544305@google.com>
 <20201105122012.GD21348@dhcp22.suse.cz> <CAJuCfpF5zAif97-uK8M+-fJhd0pab4fMPDMUNkAXYOB3MC7aXg@mail.gmail.com>
 <20201105171611.GO21348@dhcp22.suse.cz> <CAJuCfpHAxxoD6GG6t9_VthSa00znTHvLx60K-=cBee4ia1S5ew@mail.gmail.com>
 <20201105174357.GR21348@dhcp22.suse.cz> <CAJuCfpGNC1m=tz1fBbFnCc=_87Dr=L4OuORbLDGd=iD6r6Q3Ng@mail.gmail.com>
In-Reply-To: <CAJuCfpGNC1m=tz1fBbFnCc=_87Dr=L4OuORbLDGd=iD6r6Q3Ng@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 13 Nov 2020 09:37:18 -0800
Message-ID: <CAJuCfpHT-ew_d5F=r+SfxZqv1awyJ=e1FGdVx71wYkGZ5ZFOLg@mail.gmail.com>
Subject: Re: [RFC]: userspace memory reaping
To:     Michal Hocko <mhocko@suse.com>
Cc:     Minchan Kim <minchan@kernel.org>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 5, 2020 at 10:02 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Nov 5, 2020 at 9:44 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 05-11-20 09:21:13, Suren Baghdasaryan wrote:
> > > On Thu, Nov 5, 2020 at 9:16 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 05-11-20 08:50:58, Suren Baghdasaryan wrote:
> > > > > On Thu, Nov 5, 2020 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Wed 04-11-20 12:40:51, Minchan Kim wrote:
> > > > > > > On Wed, Nov 04, 2020 at 07:58:44AM +0100, Michal Hocko wrote:
> > > > > > > > On Tue 03-11-20 13:32:28, Minchan Kim wrote:
> > > > > > > > > On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > > > > > > > > > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > > > > > > > > > [...]
> > > > > > > > > > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > > > > > > > > > which in addition to sending a kill signal would also reap the
> > > > > > > > > > > victim's mm in the context of the caller? Maybe having some code will
> > > > > > > > > > > get the discussion moving forward?
> > > > > > > > > >
> > > > > > > > > > Yeah, having a code, even preliminary, might help here. This definitely
> > > > > > > > > > needs a good to go from process management people as that proper is land
> > > > > > > > > > full of surprises...
> > > > > > > > >
> > > > > > > > > Just to remind a idea I suggested to reuse existing concept
> > > > > > > > >
> > > > > > > > >     fd = pidfd_open(victim process)
> > > > > > > > >     fdatasync(fd);
> > > > > > > > >     close(fd);
> > > > > > > >
> > > > > > > > I must have missed this proposal. Anyway, are you suggesting fdatasync
> > > > > > > > to act as a destructive operation?
> > > > > > >
> > > > > > > write(fd) && fdatasync(fd) are already destructive operation if the file
> > > > > > > is shared.
> > > > > >
> > > > > > I am likely missing something because fdatasync will not destroy any
> > > > > > underlying data. It will sync
> > > > > >
> > > > > > > You don't need to reaping as destruptive operation. Rather than, just
> > > > > > > commit on the asynchrnous status "write file into page cache and commit
> > > > > > > with fsync" and "killing process and commit with fsync".
> > > > > >
> > > > > > I am sorry but I do not follow. The result of the memory reaping is a
> > > > > > data loss. Any private mapping will simply lose it's content. The caller
> > > > > > will get EFAULT when trying to access it but there is no way to
> > > > > > reconstruct the data. This is everything but not resembling what I see
> > > > > > f{data}sync is used for.
> > > > >
> > > > > I think Minchan considers f{data}sync as a "commit" operation.
> > > >
> > > > But there is nothing like commit in that operation. It is simply a
> > > > destroy operation. ftruncate as Minchan mentions in another reply would
> > > > be a closer fit but how do you interpret the length argument? What about
> > > > memory regions which cannot be reaped?
> > > >
> > > > I do understand that reusing an existing mechanism is usually preferable
> > > > but the semantic should be reasonable and easy to reason about.
> > >
> > > Maybe then we can consider a flag for pidfd_send_signal() to indicate
> > > that we want a synchronous mm cleanup when SIGKILL is being sent?
> > > Similar to my original RFC but cleanup would happen in the context of
> > > the caller. That seems to me like the simplest and most obvious way of
> > > expressing what we want to accomplish. WDYT?
> >
> > Yes that would make sense. Althought it would have to be SIGKILL
> > specific flag IMO. But let's see what process management people think
> > about that.
>
> Very well, I'll brush up the implementation and will post a new RFC. Thanks!
>

Sorry for the delay. The new RFC is posted at
https://lkml.org/lkml/2020/11/13/849

> >
> > --
> > Michal Hocko
> > SUSE Labs
