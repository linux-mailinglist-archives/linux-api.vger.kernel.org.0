Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114F22E0DFD
	for <lists+linux-api@lfdr.de>; Tue, 22 Dec 2020 18:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgLVRtg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Dec 2020 12:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgLVRtg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Dec 2020 12:49:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ACDC0613D3
        for <linux-api@vger.kernel.org>; Tue, 22 Dec 2020 09:48:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 190so2549103wmz.0
        for <linux-api@vger.kernel.org>; Tue, 22 Dec 2020 09:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZ3Mpnz+y+y40eMwZF/PF9p0ykrXNof+TnqSLHPYMc4=;
        b=fJurTTnF+Va0FHUdyTWNlS1cGpvh5djyhWHIz8cfeXiEfOyaHauqRQAM7CWWF/HB4r
         XIFtvR6qpYy5MgmX/TledRqo+t3vH2fcKr7e38xsmzAyKFWgAU8vhI2ZUIFIAYsEkZ8p
         a1YloLSV7hKc5+Gwt6KP7k500IbltONvgsDcSeGi9zSpQg8zA7YgsqoHX5zOYwp5BF/e
         iW/jP7UOFR0ATiu/JRaMsx7mEMPFpD1OoYVYpfMH/SAtbBGfvYXc6oIG88gZL0BbXR1o
         FAp5U+WxGka2LA/evqmWwrzWueuV0cQwOyeE9XZRiQIJnFQm1w0/OvkqpZyWL+tQoCmU
         sZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZ3Mpnz+y+y40eMwZF/PF9p0ykrXNof+TnqSLHPYMc4=;
        b=BuzdlBnsngYr8FBQwwm9LwuJYJ51Dzq72OSvHd4avrendY7MhZFtYGAKbHlSgrFNsU
         VP4O06xbzDhXbnnroZXYs/o3HQOEMxwzXOrEjh8x7YorU8wwqqvf+0DwURqa0nZJVXzh
         8nG6FA6GKXzgKQS6Ds+FIt/C5Ee8ZMfk2Kx+k3gk+T9punNJdYrSYLuv4ZPHqpe3HDX8
         RacJrCwvkHYkIBPKw7NsG62+1xBAj0uNeF+JZ32v4E7irz/LInMNbqNDBCRQfHzwqWZK
         yNpZBItlee7zHiDveBiRsia5w5573GNc2VZwCn9un436tdtm/8HIsiZlnCSi8BWeqCpC
         meWQ==
X-Gm-Message-State: AOAM532Ckw6/3bIC6J/WQ4F+IIScP5OCw83iyoiEw8NrJqdcES22/zKb
        iTmdsyj7NgMJjxKog2MsrH3y+x5kTW7FogZUkEyJbA==
X-Google-Smtp-Source: ABdhPJx8xdo+vZEMkO7jQEED2nsivqCj2PRiduHKYZoEitQJoXN17y7RtUWzBp4kXUmTBuo5w4edqoIkhNfbujhKVnY=
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr22732565wmh.88.1608659333913;
 Tue, 22 Dec 2020 09:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com> <CAG48ez0UKYCdgyW91SmOcT52vbLFz9RjLpaucWpj6bTrgQCwnA@mail.gmail.com>
 <20201222134438.GA7170@infradead.org>
In-Reply-To: <20201222134438.GA7170@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 22 Dec 2020 09:48:43 -0800
Message-ID: <CAJuCfpGiVS69kznSrAdosxnRd-zgXPJd8MXou=gd8K8j7xLMjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Dec 22, 2020 at 5:44 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Dec 11, 2020 at 09:27:46PM +0100, Jann Horn wrote:
> > > Can we just use one element in iovec to indicate entire address rather
> > > than using up the reserved flags?
> > >
> > >         struct iovec {
> > >                 .iov_base = NULL,
> > >                 .iov_len = (~(size_t)0),
> > >         };
> >
> > In addition to Suren's objections, I think it's also worth considering
> > how this looks in terms of compat API. If a compat process does
> > process_madvise() on another compat process, it would be specifying
> > the maximum 32-bit number, rather than the maximum 64-bit number, so
> > you'd need special code to catch that case, which would be ugly.
> >
> > And when a compat process uses this API on a non-compat process, it
> > semantically gets really weird: The actual address range covered would
> > be larger than the address range specified.
> >
> > And if we want different access checks for the two flavors in the
> > future, gating that different behavior on special values in the iovec
> > would feel too magical to me.
> >
> > And the length value SIZE_MAX doesn't really make sense anyway because
> > the length of the whole address space would be SIZE_MAX+1, which you
> > can't express.
> >
> > So I'm in favor of a new flag, and strongly against using SIZE_MAX as
> > a magic number here.
>
> Yes, using SIZE_MAX is a horrible interface in this case.  I'm not
> a huge fan of a flag either.  What is the use case for the madvise
> to all of a processes address space anyway?

Thanks for the feedback! The use case is userspace memory reaping
similar to oom-reaper. Detailed justification is here:
https://lore.kernel.org/linux-mm/20201124053943.1684874-1-surenb@google.com
