Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463563D5569
	for <lists+linux-api@lfdr.de>; Mon, 26 Jul 2021 10:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhGZHkJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Jul 2021 03:40:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49298 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhGZHkI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Jul 2021 03:40:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CC70A21ED4;
        Mon, 26 Jul 2021 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627287635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dqI+Ee5Giqt9QLyCDiFV9fDN7znSnNwARp3fuiYiLdc=;
        b=upGNLqFkSmmkH98NSEEE4bVXU8s7YEF69vWIoYCbwsCfkOJeThVu1P9KvzjIszLt4yOM67
        9gQr91/PzjGv/pKyAhnFGNknnsIYgyUNREsNn2fE2eRjknWQhYziaJMBBVchNQrYogaE0n
        IoVOunQuBNWXWdYqbNXTs2AzKVlwXKk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7577DA3B8B;
        Mon, 26 Jul 2021 08:20:35 +0000 (UTC)
Date:   Mon, 26 Jul 2021 10:20:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
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
        Florian Weimer <fweimer@redhat.com>, jengelh@inai.de,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
Message-ID: <YP5wUxx/TflLP6dq@dhcp22.suse.cz>
References: <20210723011436.60960-1-surenb@google.com>
 <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 22-07-21 19:03:56, Shakeel Butt wrote:
> On Thu, Jul 22, 2021 at 6:14 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> [...]
> > +
> > +       mmap_read_lock(mm);
> 
> How about mmap_read_trylock(mm) and return -EAGAIN on failure?

Btw. wether there is a non-blocking variant or not we should use
killable waiting to make sure the task calling into this is killable
by userspace (e.g. to implement a timeout based approach).
-- 
Michal Hocko
SUSE Labs
