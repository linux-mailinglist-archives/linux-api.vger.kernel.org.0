Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD52BF73
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 08:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfE1G3u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 02:29:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:45354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfE1G3u (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 28 May 2019 02:29:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B3F8AFE2;
        Tue, 28 May 2019 06:29:48 +0000 (UTC)
Date:   Tue, 28 May 2019 08:29:47 +0200
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
Message-ID: <20190528062947.GL1658@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-8-minchan@kernel.org>
 <20190520092801.GA6836@dhcp22.suse.cz>
 <20190521025533.GH10039@google.com>
 <20190521062628.GE32329@dhcp22.suse.cz>
 <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz>
 <20190528032632.GF6879@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528032632.GF6879@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 28-05-19 12:26:32, Minchan Kim wrote:
> On Mon, May 27, 2019 at 02:44:11PM +0200, Michal Hocko wrote:
> > On Mon 27-05-19 16:58:11, Minchan Kim wrote:
> > > On Tue, May 21, 2019 at 08:26:28AM +0200, Michal Hocko wrote:
> > > > On Tue 21-05-19 11:55:33, Minchan Kim wrote:
> > > > > On Mon, May 20, 2019 at 11:28:01AM +0200, Michal Hocko wrote:
> > > > > > [cc linux-api]
> > > > > > 
> > > > > > On Mon 20-05-19 12:52:54, Minchan Kim wrote:
> > > > > > > System could have much faster swap device like zRAM. In that case, swapping
> > > > > > > is extremely cheaper than file-IO on the low-end storage.
> > > > > > > In this configuration, userspace could handle different strategy for each
> > > > > > > kinds of vma. IOW, they want to reclaim anonymous pages by MADV_COLD
> > > > > > > while it keeps file-backed pages in inactive LRU by MADV_COOL because
> > > > > > > file IO is more expensive in this case so want to keep them in memory
> > > > > > > until memory pressure happens.
> > > > > > > 
> > > > > > > To support such strategy easier, this patch introduces
> > > > > > > MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER options in madvise(2) like
> > > > > > > that /proc/<pid>/clear_refs already has supported same filters.
> > > > > > > They are filters could be Ored with other existing hints using top two bits
> > > > > > > of (int behavior).
> > > > > > 
> > > > > > madvise operates on top of ranges and it is quite trivial to do the
> > > > > > filtering from the userspace so why do we need any additional filtering?
> > > > > > 
> > > > > > > Once either of them is set, the hint could affect only the interested vma
> > > > > > > either anonymous or file-backed.
> > > > > > > 
> > > > > > > With that, user could call a process_madvise syscall simply with a entire
> > > > > > > range(0x0 - 0xFFFFFFFFFFFFFFFF) but either of MADV_ANONYMOUS_FILTER and
> > > > > > > MADV_FILE_FILTER so there is no need to call the syscall range by range.
> > > > > > 
> > > > > > OK, so here is the reason you want that. The immediate question is why
> > > > > > cannot the monitor do the filtering from the userspace. Slightly more
> > > > > > work, all right, but less of an API to expose and that itself is a
> > > > > > strong argument against.
> > > > > 
> > > > > What I should do if we don't have such filter option is to enumerate all of
> > > > > vma via /proc/<pid>/maps and then parse every ranges and inode from string,
> > > > > which would be painful for 2000+ vmas.
> > > > 
> > > > Painful is not an argument to add a new user API. If the existing API
> > > > suits the purpose then it should be used. If it is not usable, we can
> > > > think of a different way.
> > > 
> > > I measured 1568 vma parsing overhead of /proc/<pid>/maps in ARM64 modern
> > > mobile CPU. It takes 60ms and 185ms on big cores depending on cpu governor.
> > > It's never trivial.
> > 
> > This is not the only option. Have you tried to simply use
> > /proc/<pid>/map_files interface? This will provide you with all the file
> > backed mappings.
> 
> I compared maps vs. map_files with 3036 file-backed vma.
> Test scenario is to dump all of vmas of the process and parse address
> ranges.
> For map_files, it's easy to parse each address range because directory name
> itself is range. However, in case of maps, I need to parse each range
> line by line so need to scan all of lines.
> 
> (maps cover additional non-file-backed vmas so nr_vma is a little bigger)
> 
> performance mode:
> map_files: nr_vma 3036 usec 13387
> maps     : nr_vma 3078 usec 12923
> 
> powersave mode:
> 
> map_files: nr_vma 3036 usec 52614
> maps     : nr_vma 3078 usec 41089
> 
> map_files is slower than maps if we dump all of vmas. I guess directory
> operation needs much more jobs(e.g., dentry lookup, instantiation)
> compared to maps.

OK, that is somehow surprising. I am still not convinced the filter is a
good idea though. The primary reason is that it encourages using madvise
on a wide range without having a clue what the range contains. E.g. the
full address range and rely the right thing will happen. Do we really
want madvise to operate in that mode?

Btw. if we went with the per vma fd approach then you would get this
feature automatically because map_files would refer to file backed
mappings while map_anon could refer only to anonymous mappings.

-- 
Michal Hocko
SUSE Labs
