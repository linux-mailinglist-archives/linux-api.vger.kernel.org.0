Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A1D3E2364
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 08:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhHFGmC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 02:42:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55344 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhHFGmB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 02:42:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6B4D9223AD;
        Fri,  6 Aug 2021 06:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628232105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3TW/hbpU2iIogA7/HVgljoLbJH3MuJbKrYqp6bZxa8=;
        b=lcGg7DjCd59pnNkutnkEqAUCpfRkb+2fqXYTowV1MgFCNq9kTkwmrTFxey1/CHITdFK8PR
        8w/YX1C4MaaLQ/bnVpn3lSAxPaNjXCEqViCXRXq6j5H3izcB/1GkUsDh/q3x/dmwfYfyp0
        mdUJfzAila9qn2TVoUc8Arqgr8gQdHA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2DE98A3B87;
        Fri,  6 Aug 2021 06:41:45 +0000 (UTC)
Date:   Fri, 6 Aug 2021 08:41:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v7 1/2] mm: introduce process_mrelease system call
Message-ID: <YQzZqFwDP7eUxwcn@dhcp22.suse.cz>
References: <20210805170859.2389276-1-surenb@google.com>
 <46998d10-d0ca-aeeb-8dcd-41b8130fb756@redhat.com>
 <CAJuCfpGvqgUWpdL_KNE1tnqH2OjqX64QjBYttoPRtGgXWfONRQ@mail.gmail.com>
 <CALvZod5ANyddJJVmyrzArH5Z--PAufpt1DyTgipQixbpe3Du7Q@mail.gmail.com>
 <CAJuCfpEgXh96WEpqn5aPE8mmmpW28j4KHoBkDQN-ob0vNOVHoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEgXh96WEpqn5aPE8mmmpW28j4KHoBkDQN-ob0vNOVHoQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 05-08-21 11:37:06, Suren Baghdasaryan wrote:
[...]
> > One question I have is why mmget() and not mmgrab()? I see mmgrab() in
> > oom_kill.c.
> 
> You are likely right here. The caller's context probably can't be
> considered a "real user" when reaping the mm. However, we take an
> mmap_lock shortly after, so not sure if in practice there is much
> difference.
> Michal, WDYT?

As explained in other response. mmget is to pin address space to not go
away. You do not need that for this purpose. All you need is to pin mm
to not go away. Address space can be unmapped concurrently.
-- 
Michal Hocko
SUSE Labs
