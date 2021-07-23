Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AD93D3491
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 08:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhGWFjw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 01:39:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47628 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhGWFjt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 01:39:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5D0521FF53;
        Fri, 23 Jul 2021 06:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627021220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8uQ4/E3Pg2AaedWhgz8TbxdBCTE3NVNf26n2c3ARfE=;
        b=Fitv+2rBlAONt3Ul0ivrD3yXXmi9oKL+oO7Ox7WlnJ2NUNdmDc1v77oKiYkcu9cD7/+soA
        XTDUsHdv00QaXiHZMYR6/OBlrF1TDLJIdzHP9CIOn1gfKTaCTMj2cnqcLfYUzG1pnCkTe9
        2lkTTuRTtzv8CgTPlhOL9EI2R6g3AuU=
Received: from suse.cz (tiehlicka.dhcp.prg.suse.com [10.156.228.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 12EDBA3B87;
        Fri, 23 Jul 2021 06:20:20 +0000 (UTC)
Date:   Fri, 23 Jul 2021 08:20:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
Message-ID: <YPpfo2z8feq0vTlE@dhcp22.suse.cz>
References: <20210723011436.60960-1-surenb@google.com>
 <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 22-07-21 21:47:56, Suren Baghdasaryan wrote:
> On Thu, Jul 22, 2021, 7:04 PM Shakeel Butt <shakeelb@google.com> wrote:
> 
> > On Thu, Jul 22, 2021 at 6:14 PM Suren Baghdasaryan <surenb@google.com>
> > wrote:
> > >
> > [...]
> > > +
> > > +       mmap_read_lock(mm);
> >
> > How about mmap_read_trylock(mm) and return -EAGAIN on failure?
> >
> 
> That sounds like a good idea. Thanks! I'll add that in the next respin.

Why is that a good idea? Can you do anything meaningful about the
failure other than immediately retry the syscall and hope for the best?

-- 
Michal Hocko
SUSE Labs
