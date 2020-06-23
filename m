Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFF8204D38
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2020 10:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgFWI7w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Jun 2020 04:59:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20735 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731887AbgFWI7v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Jun 2020 04:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592902790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YYUHpwtKBdHN2bUzpcdFL+IBAoMpH1jVcd2VuLN6zQ=;
        b=EfVWbSu1FLxgv9YYBYhypdhXnnbIjOZ9zLYQkFUmUrNaNwYaSF4fm8dIr9dZQqBZO7h5Bw
        WySKC1FmQdqfks2d3Znww97MwoY6N2ctqtoS9eDUTlHMiQumUFild/zJX0oEE4vB85Mh35
        3lIuYKMl4J3dmSkvdKqBtBmIoqIz2hI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-uijAevYEOVuvO4L-422LMw-1; Tue, 23 Jun 2020 04:59:48 -0400
X-MC-Unique: uijAevYEOVuvO4L-422LMw-1
Received: by mail-wr1-f70.google.com with SMTP id y16so10777434wrr.20
        for <linux-api@vger.kernel.org>; Tue, 23 Jun 2020 01:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6YYUHpwtKBdHN2bUzpcdFL+IBAoMpH1jVcd2VuLN6zQ=;
        b=T/y0/v2L6NAJqZuHyizhF+qX9hobJFwX3l3q6OHEDgVI043GQzCmVoqCw1P7J7p6Tn
         pHJ5hw0xGnvLmFT7rJ8M7Rr3c+J2A+sQJwOm/nCka1jc23b883olSzRjsyEvaMWLK21L
         2qhBxlTt9ltsfz35+bCpQqYLSY1ow6PSyC7kMq8B7swUJ8kwCXm9quYR5J39gALXjt7I
         5aD5BHWogS2+loJhRtQ4ebcUhBeJIXc6t6VtGg4cWVErmGiyOCvFD1eCWgKpiB6ccEsC
         rqSHEcaQ/9Mv8i8XPDGVchjfWn8RuWOgWA5aeqBYvfwaakWnz66qyp8s5PQy4+486az1
         eRuQ==
X-Gm-Message-State: AOAM5328Qar0LrZ2EpSPh5lVZQtjBFxLhD7wVCSuAdUDr8bcPSxpVziK
        /gzTOhsFa4FBMm5CQW/AR9natT70cVvLyZu1a6D02Y9+WX79+5QedhUxZly/sPy1sst20IoZnfl
        oWJ8TixxTEvir8tuSzKPr
X-Received: by 2002:a1c:2ec7:: with SMTP id u190mr16670684wmu.48.1592902786927;
        Tue, 23 Jun 2020 01:59:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLrWoolrthgSu2bCq2JJvakjB4En0jFRa4H3Bx0ucd0nJhcl3Kt7z5+Ch17DeTSUScxZApyA==
X-Received: by 2002:a1c:2ec7:: with SMTP id u190mr16670640wmu.48.1592902786635;
        Tue, 23 Jun 2020 01:59:46 -0700 (PDT)
Received: from localhost ([2001:470:5b39:29:79fc:ff4e:48ab:b845])
        by smtp.gmail.com with ESMTPSA id e5sm21789345wrw.19.2020.06.23.01.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 01:59:45 -0700 (PDT)
Date:   Tue, 23 Jun 2020 10:59:44 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>
Subject: Re: [PATCH v8 0/4]  introduce memory hinting API for external process
Message-ID: <20200623085944.cvob63vrv54fo7cs@butterfly.localdomain>
References: <20200622192900.22757-1-minchan@kernel.org>
 <20200622193635.GA23000@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622193635.GA23000@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello.

On Mon, Jun 22, 2020 at 12:36:35PM -0700, Minchan Kim wrote:
> On Mon, Jun 22, 2020 at 12:28:56PM -0700, Minchan Kim wrote:
> > Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> > application could give hints to kernel what memory range are preferred to be
> > reclaimed. However, in some platform(e.g., Android), the information
> > required to make the hinting decision is not known to the app.
> > Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without any app
> > involvement.
> > 
> > To solve the concern, this patch introduces new syscall - process_madvise(2).
> > Bascially, it's same with madvise(2) syscall but it has some differences.
> > 
> > 1. It needs pidfd of target process to provide the hint
> > 2. It supports only MADV_{COLD|PAGEOUT} at this moment.
> >    Other hints in madvise will be opened when there are explicit requests from
> >    community to prevent unexpected bugs we couldn't support.
> > 3. Only privileged processes can do something for other process's address
> >    space.
> > 
> > For more detail of the new API, please see "mm: introduce external memory hinting API"
> > description in this patchset.
> > 
> > * from v7 -  http://lore.kernel.org/r/20200302193630.68771-1-minchan@kernel.org
> >   * dropping pid support from new syscall and fold releated patches into syscall patch
> >   * dropping KSM patch by discussion - Oleksandr, I lost the discussion.
> >     Please resend the single patch against of the patchset if you resolves the discussion.
> >     https://lore.kernel.org/linux-api/20200302193630.68771-8-minchan@kernel.org/
> 
> Oleksandr, it seems you discussed something with Vlastimil but couldn't
> find conclustion yet and Since Jann put an a new note in the thread,
> I detach the patch from this patchset.
> 
> Please send the KSM patch based on this patchset if you belive there is
> no need to be actionable for comments.

I don't think we came to some definite conclusion, but I'll try to implement
Vlastimil's suggestion and then send it separately for evaluation.

Lets keep KSM bit out of your submission so I won't slow it down.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

