Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC443B8A2D
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhF3Vrr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhF3Vrp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 17:47:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC88C0617A8
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 14:45:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kt19so2745949pjb.2
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sL+FFKsX9IdN5XdQVajgEYwrzSq0hT/ELJaZM0Lrtzg=;
        b=C3soKyBYy0FjT9Fo/LQggyILS9Ty9DsEiwdgYoqhCWcL6wCHAOQXr6ZxRMTyW4ekD5
         QJZnVWJKsbZxaZ9HVElMnmcdSJgxEkmwObesE9b7wMYGhq0DaaPeQY3+gwDUjFylKiGu
         pT313n7riRrBO5Hn/6ySxcYDjdTjqQ/+aPz4krMXjXN0cya00uuemKmmgc93ImWkxNwJ
         /bSeZDfgoWEVe2lfZ1CA6RDim0Uk++ZJzJ1njtt1GJYvu1uQkdLKTzMt3WmwdAgJ1x6E
         Q93t4d5gnE87Sc4Ah4haMzFVIadeSwP4FIAyZYSDoeUingmC8ZbbhXO6MvFPEV0xrko1
         UywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sL+FFKsX9IdN5XdQVajgEYwrzSq0hT/ELJaZM0Lrtzg=;
        b=sXdlxxD5rbFIJVeDHxWS7N0pum5+PYQKx8gnh24Ky/alorLgfqBD9c54GF8q6ZCQNj
         1r3V4bNgnG+QUkNLfVMVf27let1MBliboXMlsawZYPOZ5G2XCGxeGXG9K9qTTEiM9Vpi
         HGQAEwibx5IB8ah/uUxB2/QhOcr16YjhgvDjNuIv/oc3h+Ieb33hQpIJDPe234SWijxE
         a0MkpPE1JKxKZk9jgxX7SyFxywqkNBVux2PMliTgkYBHnINj+/GdEYO+ThdYvSvSEACk
         Xg8lgEgTjd/PP+C1w7wPu1wzmt84jfQ2AjxZQEJjSW2nTi1TG9AExgq8tipg9Y+O+LiJ
         fqKw==
X-Gm-Message-State: AOAM530rIem6c32TPPY7YFQ8q4Da3IoKJ6ARlqciEm2aEhN7vT3eDnw3
        vyaoCUygNzxrG+EmGmBxnvIV+g==
X-Google-Smtp-Source: ABdhPJzjPM+JEpI3NZWKn5a3Rrz/XC40otouJCWOXpFaap6+sK1msyTi34OFYYVjwQrVVpFeWJJX2g==
X-Received: by 2002:a17:90a:bb83:: with SMTP id v3mr9301754pjr.102.1625089515569;
        Wed, 30 Jun 2021 14:45:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:14ba])
        by smtp.gmail.com with ESMTPSA id ay3sm14271861pjb.38.2021.06.30.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 14:45:15 -0700 (PDT)
Date:   Wed, 30 Jun 2021 17:45:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
Message-ID: <YNzl6XNu2vxyCJu8@cmpxchg.org>
References: <20210623192822.3072029-1-surenb@google.com>
 <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 30, 2021 at 11:51:36AM -0700, Suren Baghdasaryan wrote:
> On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
> > Also, please consider removing all mention of the word "reap" from the
> > user API.  For better or for worse, "reap" in UNIX refers to what
> > happens when a dead task gets wait()ed.  I sincerely wish I could go
> > back in time and gently encourage whomever invented that particular
> > abomination to change their mind, but my time machine doesn't work.
> 
> I see. Thanks for the note. How about process_mem_release() and
> replacing reap with release everywhere?

I don't quite understand the objection. This syscall works on tasks
that are at the end of their life, right? Isn't something like
process_mreap() establishing exactly the mental link we want here?
Release is less descriptive for what this thing is to be used for.
