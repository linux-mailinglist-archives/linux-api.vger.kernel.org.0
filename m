Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED444441569
	for <lists+linux-api@lfdr.de>; Mon,  1 Nov 2021 09:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhKAIk1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Nov 2021 04:40:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43170 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhKAIk1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Nov 2021 04:40:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 15DA0218B5;
        Mon,  1 Nov 2021 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635755873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XEk3a5ycM/6Z3eTDoA+OxlibhFeAVcniDJrpsbt1oNM=;
        b=HzgQDpTbMUYIp/F/gANRfnX40aWO52VT8TZvHHbN13yX3H3yq3DrPcDQ1O6M2rz2036ip4
        GdFLVrnFW6LNig5oIHXZh7l12VAEn/anqJHpAcdtukUXj6ObtIbZxWSInR2C+UxSxo8SCE
        z9CwEXS6ybHBykW9sUydxfFIwNpcAVI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 86EA9A3B88;
        Mon,  1 Nov 2021 08:37:52 +0000 (UTC)
Date:   Mon, 1 Nov 2021 09:37:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <YX+nYGlZBOAljoeF@dhcp22.suse.cz>
References: <20211022014658.263508-1-surenb@google.com>
 <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXvxBSzA2YIxbwVC@dhcp22.suse.cz>
 <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 29-10-21 09:07:39, Suren Baghdasaryan wrote:
> On Fri, Oct 29, 2021 at 6:03 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Well, I still do not see why that is a problem. This syscall is meant to
> > release the address space not to do it fast.
> 
> It's the same problem for a userspace memory reaper as for the
> oom-reaper. The goal is to release the memory of the victim and to
> quickly move on to the next one if needed.

The purpose of the oom_reaper is to _guarantee_ a forward progress. It
doesn't have to be quick or optimized for speed.
 
[...]

> > Btw. the above code will not really tell you much on a larger machine
> > unless you manage to trigger mmap_sem contection. Otherwise you are
> > measuring the mmap_sem writelock fast path and that should be really
> > within a noise comparing to the whole address space destruction time. If
> > that is not the case then we have a real problem with the locking...
> 
> My understanding of that discussion is that the concern was that even
> taking uncontended mmap_sem writelock would regress the exit path.
> That was what I wanted to confirm. Am I misreading it?

No, your reading match my recollection. I just think that code
robustness in exchange of a rw semaphore write lock fast path is a
reasonable price to pay even if that has some effect on micro
benchmarks.
-- 
Michal Hocko
SUSE Labs
