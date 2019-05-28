Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616852BDB8
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 05:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfE1D0k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 23:26:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46694 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfE1D0k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 May 2019 23:26:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so3669800pgr.13;
        Mon, 27 May 2019 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QG32BojiDvTi7QyqABLSNsM9GCVly22jtOu9QTHQPrg=;
        b=OO5A0Ki4+Hhg7qm9S2QddUw6ei4mfN0ziSpjQ2FJr9EwFpQOjVJZk7AXIrWdy2b8d8
         9As80BlwO/xBsRxNIMxw8LTIbaap21mfZbZsKmD1QcvQlZXPBhFWWHyRYjELMyCff5wz
         kOQ+viUNi2TU0D3OYeya1qiu+zbQnrMrSWCd+grhmCMfYHX4gSTxNui1Fmll74ErHW6r
         QxOTx9QVMsO1vig+fdYh9qNbbBRkDfpyRjjzLU4/Y3Jc0hQHkdvXHbwDJKFhdR8tcVxO
         SSM+1EjY/KSeK5kj4iihK4oBfeMh2iJbpmgY1z0TWrtkQLnTp1RgyfbwUrVy4DniOeny
         Ssjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QG32BojiDvTi7QyqABLSNsM9GCVly22jtOu9QTHQPrg=;
        b=kAy3H70KSuLesNRMrR9AZVppF15NvVfHReIlTTrh12MinFkmZ05xxD8mzpuk6+A8j8
         QWZO+2FvoV0n9tUF2v1VDi5eMnoRBIDMIgXcaY/d1MGRYqGnXK6uSUVsJ9cwR5s1cKP+
         RxX+OfOUbC9xOujrNZ13CNcZeLK3fQTjDOFLav/IXUfXM9MX5pZvG5AZT0L/zmwwbrO6
         ymw8EDR6NKCt/LqFIvEfxk9Z28UKJGITRIYkvrq40xY2zwthCR+qm7PswEB0HCwHn1Dw
         mjYY65QMf+uQrU3rmlNN0Am9Z5oiJQ9oQNfNRp6+jE335NvxoPqkmV+x2ies6cuVauUA
         X9/A==
X-Gm-Message-State: APjAAAU/8+Wurkf2bYZ11SzH8Jf0LrSDVCVsbVnCmm837hoOU4Pv6tOA
        NGszoy03+uocAlMbusMhMgIXzXIv
X-Google-Smtp-Source: APXvYqxlMeibdgDQO1OB7jGa10I7zpitXKcUIwCKk9t9v+ZxXCrcvGIW7KcFY9Hh+mB+DsnRrbkWCw==
X-Received: by 2002:a17:90a:f98d:: with SMTP id cq13mr2713394pjb.41.1559013999141;
        Mon, 27 May 2019 20:26:39 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id q17sm18860762pfq.74.2019.05.27.20.26.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 20:26:37 -0700 (PDT)
Date:   Tue, 28 May 2019 12:26:32 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
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
Message-ID: <20190528032632.GF6879@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-8-minchan@kernel.org>
 <20190520092801.GA6836@dhcp22.suse.cz>
 <20190521025533.GH10039@google.com>
 <20190521062628.GE32329@dhcp22.suse.cz>
 <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527124411.GC1658@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 27, 2019 at 02:44:11PM +0200, Michal Hocko wrote:
> On Mon 27-05-19 16:58:11, Minchan Kim wrote:
> > On Tue, May 21, 2019 at 08:26:28AM +0200, Michal Hocko wrote:
> > > On Tue 21-05-19 11:55:33, Minchan Kim wrote:
> > > > On Mon, May 20, 2019 at 11:28:01AM +0200, Michal Hocko wrote:
> > > > > [cc linux-api]
> > > > > 
> > > > > On Mon 20-05-19 12:52:54, Minchan Kim wrote:
> > > > > > System could have much faster swap device like zRAM. In that case, swapping
> > > > > > is extremely cheaper than file-IO on the low-end storage.
> > > > > > In this configuration, userspace could handle different strategy for each
> > > > > > kinds of vma. IOW, they want to reclaim anonymous pages by MADV_COLD
> > > > > > while it keeps file-backed pages in inactive LRU by MADV_COOL because
> > > > > > file IO is more expensive in this case so want to keep them in memory
> > > > > > until memory pressure happens.
> > > > > > 
> > > > > > To support such strategy easier, this patch introduces
> > > > > > MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER options in madvise(2) like
> > > > > > that /proc/<pid>/clear_refs already has supported same filters.
> > > > > > They are filters could be Ored with other existing hints using top two bits
> > > > > > of (int behavior).
> > > > > 
> > > > > madvise operates on top of ranges and it is quite trivial to do the
> > > > > filtering from the userspace so why do we need any additional filtering?
> > > > > 
> > > > > > Once either of them is set, the hint could affect only the interested vma
> > > > > > either anonymous or file-backed.
> > > > > > 
> > > > > > With that, user could call a process_madvise syscall simply with a entire
> > > > > > range(0x0 - 0xFFFFFFFFFFFFFFFF) but either of MADV_ANONYMOUS_FILTER and
> > > > > > MADV_FILE_FILTER so there is no need to call the syscall range by range.
> > > > > 
> > > > > OK, so here is the reason you want that. The immediate question is why
> > > > > cannot the monitor do the filtering from the userspace. Slightly more
> > > > > work, all right, but less of an API to expose and that itself is a
> > > > > strong argument against.
> > > > 
> > > > What I should do if we don't have such filter option is to enumerate all of
> > > > vma via /proc/<pid>/maps and then parse every ranges and inode from string,
> > > > which would be painful for 2000+ vmas.
> > > 
> > > Painful is not an argument to add a new user API. If the existing API
> > > suits the purpose then it should be used. If it is not usable, we can
> > > think of a different way.
> > 
> > I measured 1568 vma parsing overhead of /proc/<pid>/maps in ARM64 modern
> > mobile CPU. It takes 60ms and 185ms on big cores depending on cpu governor.
> > It's never trivial.
> 
> This is not the only option. Have you tried to simply use
> /proc/<pid>/map_files interface? This will provide you with all the file
> backed mappings.

I compared maps vs. map_files with 3036 file-backed vma.
Test scenario is to dump all of vmas of the process and parse address
ranges.
For map_files, it's easy to parse each address range because directory name
itself is range. However, in case of maps, I need to parse each range
line by line so need to scan all of lines.

(maps cover additional non-file-backed vmas so nr_vma is a little bigger)

performance mode:
map_files: nr_vma 3036 usec 13387
maps     : nr_vma 3078 usec 12923

powersave mode:

map_files: nr_vma 3036 usec 52614
maps     : nr_vma 3078 usec 41089

map_files is slower than maps if we dump all of vmas. I guess directory
operation needs much more jobs(e.g., dentry lookup, instantiation)
compared to maps.

