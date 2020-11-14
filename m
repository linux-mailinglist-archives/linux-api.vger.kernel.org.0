Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E952B2A68
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 02:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgKNBSN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 20:18:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgKNBSN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 13 Nov 2020 20:18:13 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE51F22261;
        Sat, 14 Nov 2020 01:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605316691;
        bh=uXpBMD7/3ZId9Cgo0JGEfZTnwcfVEbN6QzkoH7cWI8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zxlg/VaU83wqoKZ51iKRh8GpONjw13R13IY5RSHC6EK5QCSz0OOoyTSYf49uxKT6U
         3nIzTyS52dgcSNVsTtonHBnarvphseyiPprIMgSDUe0aPRNvOyQ34wlzIULqH1WGq3
         PAmhHwN8STrTtJh50/O+VNUWTYp/lou0WK54cI6w=
Date:   Fri, 13 Nov 2020 17:18:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
Message-Id: <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
In-Reply-To: <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
References: <20201113173448.1863419-1-surenb@google.com>
        <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
        <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
        <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
        <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 13 Nov 2020 17:09:37 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> > > > Seems to me that the ability to reap another process's memory is a
> > > > generally useful one, and that it should not be tied to delivering a
> > > > signal in this fashion.
> > > >
> > > > And we do have the new process_madvise(MADV_PAGEOUT).  It may need a
> > > > few changes and tweaks, but can't that be used to solve this problem?
> > >
> > > Thank you for the feedback, Andrew. process_madvise(MADV_DONTNEED) was
> > > one of the options recently discussed in
> > > https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> > > . The thread describes some of the issues with that approach but if we
> > > limit it to processes with pending SIGKILL only then I think that
> > > would be doable.
> >
> > Why would it be necessary to read /proc/pid/maps?  I'd have thought
> > that a starting effort would be
> >
> >         madvise((void *)0, (void *)-1, MADV_PAGEOUT)
> >
> > (after translation into process_madvise() speak).  Which is equivalent
> > to the proposed process_madvise(MADV_DONTNEED_MM)?
> 
> Yep, this is very similar to option #3 in
> https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> and I actually have a tested prototype for that.

Why is the `vector=NULL' needed?  Can't `vector' point at a single iovec
which spans the whole address range?

> If that's the
> preferred method then I can post it quite quickly.

I assume you've tested that prototype.  How did its usefulness compare
with this SIGKILL-based approach?

