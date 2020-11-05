Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BBA2A8524
	for <lists+linux-api@lfdr.de>; Thu,  5 Nov 2020 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgKERlq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Nov 2020 12:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKERlq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Nov 2020 12:41:46 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C72EC0613CF;
        Thu,  5 Nov 2020 09:41:46 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r186so1863289pgr.0;
        Thu, 05 Nov 2020 09:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ROPmCHdS0kRg9q+B0Dggx9NnmXUvygn2aJySQRUk1PU=;
        b=B2tWMFsjw3bi0iB38Tr2F5SWQxJLB3kpG8hw4mLTqOviEibVyWUsPuzWP8Gi3Gulni
         tBs7hK1LMMzFX00AgmM5RLlzpoF9H1Fn7t/hnj3zX8Dni21u9y6jto/W0kBMKGtKRuEp
         DulPVDquNepyb/CN3kfZEe+o8f4J+5Phwz5zjlGi+LjEO7eJKT5YHXRa5WJ2IHkaIAN5
         4mC5Git3culOK0pwzGV/1iGnuh6ojacbjsqiPTbfbhpmwjUE4fnOtLaPQzrNSuzEJLqd
         k3k56/EmfNvevYeQ/+gO3N4b1gjAIux50/4Y5REK8ZD+WhHEXtAfkVN7NinzRyPtHUxG
         OhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ROPmCHdS0kRg9q+B0Dggx9NnmXUvygn2aJySQRUk1PU=;
        b=uRtUEARagTxWi5RI6djiR/gaNWcLyvRrxbNP4BpSuqO340jobTBuxkbVM30FB1wkHQ
         rqE35dik+u/lKEjDKoCqlqAAN1mjVelPwyZ+KD+rg3dOTcMwo69r0yFmL/nFlamFv21Q
         K/mKprMJDRNNnK9gLVf3Vk9ogSAvwKCN2Jk8bqrIO/Dogx9TPploY0eJ6N8DbF8YIRzu
         74uePCH1f2OHWVLmbKjpR39S1kEWrdt2WskblboeqV8Z+jbYJW9CVdMabyj7hl/8lZUf
         8/w9CjFFH+dabmWTK/023q+puZB1fUNOFeBhc8YLC+2Y39Jdvo8pHzLlXnxUEOqUAVgi
         fAZA==
X-Gm-Message-State: AOAM530n4xOAjR6+N0kaPAPlnXW0dqynX018CzbqSITc13oXo1+IO+hR
        U5DPA6HSNwuSBLoTUCMqohFhBNfykbs=
X-Google-Smtp-Source: ABdhPJwxT1NmWqKn/Ks2DuSG4v+x+CY+eLvgsygQ1M9RxDJ3i9JX8XBa1wf2Dk72/u4YIqGx2LObWg==
X-Received: by 2002:a63:cb51:: with SMTP id m17mr3369432pgi.337.1604598105490;
        Thu, 05 Nov 2020 09:41:45 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id i10sm3162527pfd.60.2020.11.05.09.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:41:44 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 5 Nov 2020 09:41:42 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-api@vger.kernel.org,
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
Subject: Re: [RFC]: userspace memory reaping
Message-ID: <20201105174142.GA395979@google.com>
References: <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz>
 <20201103213228.GB1631979@google.com>
 <20201104065844.GM21990@dhcp22.suse.cz>
 <20201104204051.GA3544305@google.com>
 <20201105122012.GD21348@dhcp22.suse.cz>
 <CAJuCfpF5zAif97-uK8M+-fJhd0pab4fMPDMUNkAXYOB3MC7aXg@mail.gmail.com>
 <20201105171611.GO21348@dhcp22.suse.cz>
 <CAJuCfpHAxxoD6GG6t9_VthSa00znTHvLx60K-=cBee4ia1S5ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHAxxoD6GG6t9_VthSa00znTHvLx60K-=cBee4ia1S5ew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 05, 2020 at 09:21:13AM -0800, Suren Baghdasaryan wrote:
> On Thu, Nov 5, 2020 at 9:16 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 05-11-20 08:50:58, Suren Baghdasaryan wrote:
> > > On Thu, Nov 5, 2020 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 04-11-20 12:40:51, Minchan Kim wrote:
> > > > > On Wed, Nov 04, 2020 at 07:58:44AM +0100, Michal Hocko wrote:
> > > > > > On Tue 03-11-20 13:32:28, Minchan Kim wrote:
> > > > > > > On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > > > > > > > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > > > > > > > [...]
> > > > > > > > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > > > > > > > which in addition to sending a kill signal would also reap the
> > > > > > > > > victim's mm in the context of the caller? Maybe having some code will
> > > > > > > > > get the discussion moving forward?
> > > > > > > >
> > > > > > > > Yeah, having a code, even preliminary, might help here. This definitely
> > > > > > > > needs a good to go from process management people as that proper is land
> > > > > > > > full of surprises...
> > > > > > >
> > > > > > > Just to remind a idea I suggested to reuse existing concept
> > > > > > >
> > > > > > >     fd = pidfd_open(victim process)
> > > > > > >     fdatasync(fd);
> > > > > > >     close(fd);
> > > > > >
> > > > > > I must have missed this proposal. Anyway, are you suggesting fdatasync
> > > > > > to act as a destructive operation?
> > > > >
> > > > > write(fd) && fdatasync(fd) are already destructive operation if the file
> > > > > is shared.
> > > >
> > > > I am likely missing something because fdatasync will not destroy any
> > > > underlying data. It will sync
> > > >
> > > > > You don't need to reaping as destruptive operation. Rather than, just
> > > > > commit on the asynchrnous status "write file into page cache and commit
> > > > > with fsync" and "killing process and commit with fsync".
> > > >
> > > > I am sorry but I do not follow. The result of the memory reaping is a
> > > > data loss. Any private mapping will simply lose it's content. The caller
> > > > will get EFAULT when trying to access it but there is no way to
> > > > reconstruct the data. This is everything but not resembling what I see
> > > > f{data}sync is used for.
> > >
> > > I think Minchan considers f{data}sync as a "commit" operation.
> >
> > But there is nothing like commit in that operation. It is simply a
> > destroy operation. ftruncate as Minchan mentions in another reply would
> > be a closer fit but how do you interpret the length argument? What about
> > memory regions which cannot be reaped?
> >
> > I do understand that reusing an existing mechanism is usually preferable
> > but the semantic should be reasonable and easy to reason about.
> 
> Maybe then we can consider a flag for pidfd_send_signal() to indicate
> that we want a synchronous mm cleanup when SIGKILL is being sent?
> Similar to my original RFC but cleanup would happen in the context of
> the caller. That seems to me like the simplest and most obvious way of
> expressing what we want to accomplish. WDYT?

I think that's better than introducing a specific synchronous kill.
