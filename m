Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9D2C2C2
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfE1JIe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 05:08:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:45920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbfE1JIY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 28 May 2019 05:08:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 784DAB010;
        Tue, 28 May 2019 09:08:23 +0000 (UTC)
Date:   Tue, 28 May 2019 11:08:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190528090821.GU1658@dhcp22.suse.cz>
References: <20190520092801.GA6836@dhcp22.suse.cz>
 <20190521025533.GH10039@google.com>
 <20190521062628.GE32329@dhcp22.suse.cz>
 <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz>
 <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz>
 <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528084927.GB159710@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 28-05-19 17:49:27, Minchan Kim wrote:
> On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> > On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > > if we went with the per vma fd approach then you would get this
> > > > feature automatically because map_files would refer to file backed
> > > > mappings while map_anon could refer only to anonymous mappings.
> > >
> > > The reason to add such filter option is to avoid the parsing overhead
> > > so map_anon wouldn't be helpful.
> > 
> > Without chiming on whether the filter option is a good idea, I'd like
> > to suggest that providing an efficient binary interfaces for pulling
> > memory map information out of processes.  Some single-system-call
> > method for retrieving a binary snapshot of a process's address space
> > complete with attributes (selectable, like statx?) for each VMA would
> > reduce complexity and increase performance in a variety of areas,
> > e.g., Android memory map debugging commands.
> 
> I agree it's the best we can get *generally*.
> Michal, any opinion?

I am not really sure this is directly related. I think the primary
question that we have to sort out first is whether we want to have
the remote madvise call process or vma fd based. This is an important
distinction wrt. usability. I have only seen pid vs. pidfd discussions
so far unfortunately.

An interface to query address range information is a separate but
although a related topic. We have /proc/<pid>/[s]maps for that right
now and I understand it is not a general win for all usecases because
it tends to be slow for some. I can see how /proc/<pid>/map_anons could
provide per vma information in a binary form via a fd based interface.
But I would rather not conflate those two discussions much - well except
if it could give one of the approaches more justification but let's
focus on the madvise part first.
-- 
Michal Hocko
SUSE Labs
