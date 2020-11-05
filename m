Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74352A84AC
	for <lists+linux-api@lfdr.de>; Thu,  5 Nov 2020 18:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgKERQQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Nov 2020 12:16:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:54598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgKERQP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 5 Nov 2020 12:16:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604596573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iSIQtjhr10//VD1ePr+4g1ncowxf9ZrRXex0wWZq72I=;
        b=GKVrtwDWxpqYR0Co35DPMPeKUWx8jjDTMPfP5GQcq39XUodVa5mb+N93C5ijnaLAOA1hgF
        hbbzCm7XVqMyUC81jqyRjVxt1/ObnbW4UOc3lA54s9j7K+alvBF01QUrDHyUecnaOKL0lt
        fXRqzLiviOJN2CjcuNEvHkZnCA/D6LY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05CB0ABAE;
        Thu,  5 Nov 2020 17:16:13 +0000 (UTC)
Date:   Thu, 5 Nov 2020 18:16:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
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
Subject: Re: [RFC]: userspace memory reaping
Message-ID: <20201105171611.GO21348@dhcp22.suse.cz>
References: <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz>
 <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz>
 <20201103213228.GB1631979@google.com>
 <20201104065844.GM21990@dhcp22.suse.cz>
 <20201104204051.GA3544305@google.com>
 <20201105122012.GD21348@dhcp22.suse.cz>
 <CAJuCfpF5zAif97-uK8M+-fJhd0pab4fMPDMUNkAXYOB3MC7aXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpF5zAif97-uK8M+-fJhd0pab4fMPDMUNkAXYOB3MC7aXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 05-11-20 08:50:58, Suren Baghdasaryan wrote:
> On Thu, Nov 5, 2020 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 04-11-20 12:40:51, Minchan Kim wrote:
> > > On Wed, Nov 04, 2020 at 07:58:44AM +0100, Michal Hocko wrote:
> > > > On Tue 03-11-20 13:32:28, Minchan Kim wrote:
> > > > > On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > > > > > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > > > > > [...]
> > > > > > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > > > > > which in addition to sending a kill signal would also reap the
> > > > > > > victim's mm in the context of the caller? Maybe having some code will
> > > > > > > get the discussion moving forward?
> > > > > >
> > > > > > Yeah, having a code, even preliminary, might help here. This definitely
> > > > > > needs a good to go from process management people as that proper is land
> > > > > > full of surprises...
> > > > >
> > > > > Just to remind a idea I suggested to reuse existing concept
> > > > >
> > > > >     fd = pidfd_open(victim process)
> > > > >     fdatasync(fd);
> > > > >     close(fd);
> > > >
> > > > I must have missed this proposal. Anyway, are you suggesting fdatasync
> > > > to act as a destructive operation?
> > >
> > > write(fd) && fdatasync(fd) are already destructive operation if the file
> > > is shared.
> >
> > I am likely missing something because fdatasync will not destroy any
> > underlying data. It will sync
> >
> > > You don't need to reaping as destruptive operation. Rather than, just
> > > commit on the asynchrnous status "write file into page cache and commit
> > > with fsync" and "killing process and commit with fsync".
> >
> > I am sorry but I do not follow. The result of the memory reaping is a
> > data loss. Any private mapping will simply lose it's content. The caller
> > will get EFAULT when trying to access it but there is no way to
> > reconstruct the data. This is everything but not resembling what I see
> > f{data}sync is used for.
> 
> I think Minchan considers f{data}sync as a "commit" operation.

But there is nothing like commit in that operation. It is simply a
destroy operation. ftruncate as Minchan mentions in another reply would
be a closer fit but how do you interpret the length argument? What about
memory regions which cannot be reaped?

I do understand that reusing an existing mechanism is usually preferable
but the semantic should be reasonable and easy to reason about.

-- 
Michal Hocko
SUSE Labs
