Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCC42A859D
	for <lists+linux-api@lfdr.de>; Thu,  5 Nov 2020 19:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKESDC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Nov 2020 13:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbgKESDB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Nov 2020 13:03:01 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A6C0613CF
        for <linux-api@vger.kernel.org>; Thu,  5 Nov 2020 10:03:00 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h22so2499295wmb.0
        for <linux-api@vger.kernel.org>; Thu, 05 Nov 2020 10:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jpSyB1O0iDaABw6MiKreg1tNDRBJY3vn2MGhikQS5I=;
        b=K0deb7jCCEd/+s8edtRGoRUX5Zf8VGCa0Catbh8UYR1Pa7Q7UiIXi3QPkbvB7qhFYx
         j8AunHWkZG65tM7jAFjoHuk/CLZPvEq0G4RpBxC0mJd+kChxKSqKEolMZ4XCoQeCgBB2
         LUswPweuty6yGaKB9u0XFjHiaGfMxaE4me9f/7+BwJaeIpJnrAtcmYFNsiggf4kfcSgE
         Ad6ydyLGitRGYjCshPzeyJcKn3CQND9lv46d8tHTOxAZwC12La7X2vMQP8oQfQI5OzRf
         O+jshXNl7LeDg29hx4pBSawGLnV4XJfyXAuygI9nWIYAG0/53eCzqzHBsMBV0kKCx4ez
         LyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jpSyB1O0iDaABw6MiKreg1tNDRBJY3vn2MGhikQS5I=;
        b=JaVwRq7BuYCK5KL/0W1s50scVYxtOsJphay75nI9OMWAW+XaNbTgE4Wex2VS48BQBv
         ZunecgOZJV+4nwOz3EHVfEsv+k+YuR1icd/dzcbredXNfDa0qKM2O4107Lk/8OhSGp51
         v+GhB2uVqmCICrlkJiMRdNLnrx/qAQxQCtAVM3/M+NP3oWvk71LaeP83O8liFaDzxf1T
         zVM/9g/OFFNYjchj7c3qrQhMATjQbkLCoZRTisXE9qKZlvV+EDRTs5Iv9t2jL7OBdGVk
         Yn2vKqWQgjsXnsoTUJuL/3/k5Zeg5YJXgMXRrZzM/a632i153cQD26g9FahcVhuGIQih
         4cQg==
X-Gm-Message-State: AOAM531/qFw+iJupOWMVzGvSnA4q5kT5DA6kJ/BFmppnrBkFQURaRGUs
        UtoFlUgBuM6cVkvud+B5cfD/iWbzzgias2nLWpgAVA==
X-Google-Smtp-Source: ABdhPJxfUDQBtId2UzZIbJCACL/YfYx2kpaTw5a0OdTOnkUDvQ9yNexMzwKVma9IXhkcq0u1TShASkea2onjIYmzo/c=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr3874885wmf.37.1604599379469;
 Thu, 05 Nov 2020 10:02:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz> <20201103213228.GB1631979@google.com>
 <20201104065844.GM21990@dhcp22.suse.cz> <20201104204051.GA3544305@google.com>
 <20201105122012.GD21348@dhcp22.suse.cz> <CAJuCfpF5zAif97-uK8M+-fJhd0pab4fMPDMUNkAXYOB3MC7aXg@mail.gmail.com>
 <20201105171611.GO21348@dhcp22.suse.cz> <CAJuCfpHAxxoD6GG6t9_VthSa00znTHvLx60K-=cBee4ia1S5ew@mail.gmail.com>
 <20201105174357.GR21348@dhcp22.suse.cz>
In-Reply-To: <20201105174357.GR21348@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 5 Nov 2020 10:02:48 -0800
Message-ID: <CAJuCfpGNC1m=tz1fBbFnCc=_87Dr=L4OuORbLDGd=iD6r6Q3Ng@mail.gmail.com>
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

On Thu, Nov 5, 2020 at 9:44 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 05-11-20 09:21:13, Suren Baghdasaryan wrote:
> > On Thu, Nov 5, 2020 at 9:16 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 05-11-20 08:50:58, Suren Baghdasaryan wrote:
> > > > On Thu, Nov 5, 2020 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Wed 04-11-20 12:40:51, Minchan Kim wrote:
> > > > > > On Wed, Nov 04, 2020 at 07:58:44AM +0100, Michal Hocko wrote:
> > > > > > > On Tue 03-11-20 13:32:28, Minchan Kim wrote:
> > > > > > > > On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > > > > > > > > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > > > > > > > > [...]
> > > > > > > > > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > > > > > > > > which in addition to sending a kill signal would also reap the
> > > > > > > > > > victim's mm in the context of the caller? Maybe having some code will
> > > > > > > > > > get the discussion moving forward?
> > > > > > > > >
> > > > > > > > > Yeah, having a code, even preliminary, might help here. This definitely
> > > > > > > > > needs a good to go from process management people as that proper is land
> > > > > > > > > full of surprises...
> > > > > > > >
> > > > > > > > Just to remind a idea I suggested to reuse existing concept
> > > > > > > >
> > > > > > > >     fd = pidfd_open(victim process)
> > > > > > > >     fdatasync(fd);
> > > > > > > >     close(fd);
> > > > > > >
> > > > > > > I must have missed this proposal. Anyway, are you suggesting fdatasync
> > > > > > > to act as a destructive operation?
> > > > > >
> > > > > > write(fd) && fdatasync(fd) are already destructive operation if the file
> > > > > > is shared.
> > > > >
> > > > > I am likely missing something because fdatasync will not destroy any
> > > > > underlying data. It will sync
> > > > >
> > > > > > You don't need to reaping as destruptive operation. Rather than, just
> > > > > > commit on the asynchrnous status "write file into page cache and commit
> > > > > > with fsync" and "killing process and commit with fsync".
> > > > >
> > > > > I am sorry but I do not follow. The result of the memory reaping is a
> > > > > data loss. Any private mapping will simply lose it's content. The caller
> > > > > will get EFAULT when trying to access it but there is no way to
> > > > > reconstruct the data. This is everything but not resembling what I see
> > > > > f{data}sync is used for.
> > > >
> > > > I think Minchan considers f{data}sync as a "commit" operation.
> > >
> > > But there is nothing like commit in that operation. It is simply a
> > > destroy operation. ftruncate as Minchan mentions in another reply would
> > > be a closer fit but how do you interpret the length argument? What about
> > > memory regions which cannot be reaped?
> > >
> > > I do understand that reusing an existing mechanism is usually preferable
> > > but the semantic should be reasonable and easy to reason about.
> >
> > Maybe then we can consider a flag for pidfd_send_signal() to indicate
> > that we want a synchronous mm cleanup when SIGKILL is being sent?
> > Similar to my original RFC but cleanup would happen in the context of
> > the caller. That seems to me like the simplest and most obvious way of
> > expressing what we want to accomplish. WDYT?
>
> Yes that would make sense. Althought it would have to be SIGKILL
> specific flag IMO. But let's see what process management people think
> about that.

Very well, I'll brush up the implementation and will post a new RFC. Thanks!

>
> --
> Michal Hocko
> SUSE Labs
