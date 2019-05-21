Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9939224806
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 08:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfEUG0b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 02:26:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfEUG0a (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 21 May 2019 02:26:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FB96AE08;
        Tue, 21 May 2019 06:26:29 +0000 (UTC)
Date:   Tue, 21 May 2019 08:26:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190521062628.GE32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-8-minchan@kernel.org>
 <20190520092801.GA6836@dhcp22.suse.cz>
 <20190521025533.GH10039@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521025533.GH10039@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 21-05-19 11:55:33, Minchan Kim wrote:
> On Mon, May 20, 2019 at 11:28:01AM +0200, Michal Hocko wrote:
> > [cc linux-api]
> > 
> > On Mon 20-05-19 12:52:54, Minchan Kim wrote:
> > > System could have much faster swap device like zRAM. In that case, swapping
> > > is extremely cheaper than file-IO on the low-end storage.
> > > In this configuration, userspace could handle different strategy for each
> > > kinds of vma. IOW, they want to reclaim anonymous pages by MADV_COLD
> > > while it keeps file-backed pages in inactive LRU by MADV_COOL because
> > > file IO is more expensive in this case so want to keep them in memory
> > > until memory pressure happens.
> > > 
> > > To support such strategy easier, this patch introduces
> > > MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER options in madvise(2) like
> > > that /proc/<pid>/clear_refs already has supported same filters.
> > > They are filters could be Ored with other existing hints using top two bits
> > > of (int behavior).
> > 
> > madvise operates on top of ranges and it is quite trivial to do the
> > filtering from the userspace so why do we need any additional filtering?
> > 
> > > Once either of them is set, the hint could affect only the interested vma
> > > either anonymous or file-backed.
> > > 
> > > With that, user could call a process_madvise syscall simply with a entire
> > > range(0x0 - 0xFFFFFFFFFFFFFFFF) but either of MADV_ANONYMOUS_FILTER and
> > > MADV_FILE_FILTER so there is no need to call the syscall range by range.
> > 
> > OK, so here is the reason you want that. The immediate question is why
> > cannot the monitor do the filtering from the userspace. Slightly more
> > work, all right, but less of an API to expose and that itself is a
> > strong argument against.
> 
> What I should do if we don't have such filter option is to enumerate all of
> vma via /proc/<pid>/maps and then parse every ranges and inode from string,
> which would be painful for 2000+ vmas.

Painful is not an argument to add a new user API. If the existing API
suits the purpose then it should be used. If it is not usable, we can
think of a different way.
-- 
Michal Hocko
SUSE Labs
