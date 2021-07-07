Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624863BE819
	for <lists+linux-api@lfdr.de>; Wed,  7 Jul 2021 14:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhGGMlX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Jul 2021 08:41:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41440 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhGGMlX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Jul 2021 08:41:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 240DA22420;
        Wed,  7 Jul 2021 12:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625661522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wtj4oqJE3RiN5VpO28h+0U6s0vV8LrwsND4LhinfUSo=;
        b=AGrjPda2dkldufEtWLLsXeP5nO0ItjRm+3IxvNNgLrIvm4nmzr8qB7Rs1jBYQAQmbtB2eB
        cNNHS8Ec+oK6JaWxToEy+d3SO1eChhxXobVV5PVdF0ZqT91UnOwuIs3Ejh11tiE0laYf/j
        Uh6xJXRuUCZVfC0fZKQIPwtjb00Ya0c=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7E6BDA3C27;
        Wed,  7 Jul 2021 12:38:41 +0000 (UTC)
Date:   Wed, 7 Jul 2021 14:38:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
Message-ID: <YOWcj0+P238W1y+t@dhcp22.suse.cz>
References: <20210623192822.3072029-1-surenb@google.com>
 <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
 <YNzl6XNu2vxyCJu8@cmpxchg.org>
 <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
 <CAJuCfpG5Ua7C4usJGEqTm6_UUd6VyRd0BsPgT97LWOzjb4Ry+g@mail.gmail.com>
 <20210702152724.7fv5tnik4qlap6do@wittgenstein>
 <af8e76f1-6625-25d1-98d2-a3c8a9bf2fd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8e76f1-6625-25d1-98d2-a3c8a9bf2fd6@redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 05-07-21 09:41:54, David Hildenbrand wrote:
> On 02.07.21 17:27, Christian Brauner wrote:
[...]
> > That one was my favorite from the list I gave too but maybe we can
> > satisfy Andy too if we use one of:
> > - process_mfree()
> > - process_mrelease()
> > 
> 
> FWIW, I tend to like process_mrelease(), due to the implied "release" ("free
> the memory if there are no other references") semantics.

Agreed.

> Further, a new
> syscall feels cleaner than some magic sysfs/procfs toggle. Just my 2 cents.

Yeah, proc based interface is both tricky to use and kinda ugly now that
pidfd can solve all at in once.

My original preference was a more generic kill syscall to allow flags
but a dedicated syscall doesn't look really bad either.
-- 
Michal Hocko
SUSE Labs
