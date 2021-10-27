Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAF43D025
	for <lists+linux-api@lfdr.de>; Wed, 27 Oct 2021 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbhJ0R5D (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 27 Oct 2021 13:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbhJ0R5D (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 27 Oct 2021 13:57:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A29C061570;
        Wed, 27 Oct 2021 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9nZeTw3uA8X+QDH9NcO9I7ui/+gpNaoqSNDmb15VGLI=; b=DiUG8whq1N5A1oFfdH/3I4Js1A
        GqQboUMp3hTNNH2O3vSWk2lJqtNEwa0qrBE8ZebivmZjaHiV8Zv8JrtZPjloYnXsUsmQ2qJLs+3+e
        RKsnu0tshRQCJxG0fos02IZrSMW3sMYvRlFzYiPxCp0tl0QHQdBK+AbeXBoRNazuFM3orw68f8qBy
        Bx+ZTAyuOkZd8oH/sFog5zbh+crCXqHFV5CXOVhKlohsoGA17Xf7alQid2lkUBggu6XdNN1dq8Grg
        cyZxaBw7RNyuGh6BXBvBuubcu71M8mJViSatdxxJhOq3EDuU8ATisnjgrNV4xPv4zxIlsegSF+s+Z
        Uqe7aNsA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfn5P-000Dnx-WF; Wed, 27 Oct 2021 17:51:51 +0000
Date:   Wed, 27 Oct 2021 18:51:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Liam R. Howlett" <liam.howlett@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and
 exit_mmap
Message-ID: <YXmRq5d86Umzrxs+@casper.infradead.org>
References: <20211022014658.263508-1-surenb@google.com>
 <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXmNaoV4dBTOJ3+w@casper.infradead.org>
 <CAJuCfpFP-57JkWhDAN4T6VtPboSV4LGqipHMU4j+wJKU45yjYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFP-57JkWhDAN4T6VtPboSV4LGqipHMU4j+wJKU45yjYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 27, 2021 at 10:42:29AM -0700, Suren Baghdasaryan wrote:
> On Wed, Oct 27, 2021 at 10:35 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Oct 27, 2021 at 09:08:21AM -0700, Suren Baghdasaryan wrote:
> > > Unconditional mmap_write_lock around free_pgtables in exit_mmap seems
> > > to me the most semantically correct way forward and the pushback is on
> > > the basis of regressing performance of the exit path. I would like to
> > > measure that regression to confirm this. I don't have access to a big
> > > machine but will ask someone in another Google team to try the test
> > > Michal wrote here
> > > https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/ on
> > > a server with and without a custom patch.
> >
> > Sorry to hijack this, but could you ask that team to also test this
> > patch?  I think there's probably a good-sized win here, but I have no
> > profiles to share at this point.  I've only done light testing, and
> > it may have bugs.
> >
> > NB: I only did the exit() path here.  fork() conversion is left as an
> > exercise for the reader^W^W Liam.
> 
> To clarify, this patch does not change the mmap_write_lock portion of
> exit_mmap. Do you want to test it in isolation or with the locking
> changes in exit_mmap I mentioned?

Correct, it does not.  I think it's interesting to test it in isolation,
but if you want to test it in in combination, that could also be
interesting (see if we regain some of the expected performance loss).
I just don't have a NUMA box of my own to test on, so I'm hoping to
exploit your test infrastructure ;-)

By the way, my vmavec patch should also be helpful on small systems
like phones ... ;-)
