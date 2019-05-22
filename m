Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C649625BC6
	for <lists+linux-api@lfdr.de>; Wed, 22 May 2019 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfEVBue (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 21:50:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40298 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfEVBud (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 May 2019 21:50:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id g69so236934plb.7;
        Tue, 21 May 2019 18:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KEsTTRLdcPvr4DyB6nsvDnVWKWacN5V2AbAsyIXP34I=;
        b=UjHLINqajyRyc03bkbJEwVX7nyyMpQmWAyv5W7+imFIOFa51iCIXk7CK/61xyyRIai
         FGYl+HB0sIXMbUhOTJDJlmDRS2bCzV0qCGUqghC+DnZPDQp1xWuscp4ICweSbOG1v4p5
         FMbXHwFzUmECuKMiVhzbb1ysJXHPR4w7qbNPVaEJxDG1Xc/OU5cYB1WHPyDB71x9sBqD
         K+H+qxwPPSAbqOlZmB9z2Os4xKbVMMtHfZ06glc1KrU6zwbHYph/usPPsgWR5EvW2NFB
         eSZRhhUszhkhdhGDKNcykyGEq6fUojSTYBiRH5bYQgPXAdTX6rN8GRTnhS29HUp8ht7t
         9vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KEsTTRLdcPvr4DyB6nsvDnVWKWacN5V2AbAsyIXP34I=;
        b=eSKozO1mL9UnUFh1UhpLErfHJ1t6mzkLR1c6GPtBt2yjR2ytOlChYq85pAyNZS870k
         CldqLzRkyKXn/z/J+oaia0Rs7LinXQeg/aXo7ZZAHvcukBoD1e2J2H0pWNAgHbxHftGE
         Ir1p9VrzSCEYLgog+OfEoP9Y5Md7tT0oLdJBe4yYLTblvGcHesIe5IDvKnkxwJBqnf5i
         Z8yxfeixeYxEFUPRHjCawSCBU7K6hf5kzoegNbftt4r30uQOldXg1VTsN5ZC9vpT0IxA
         /LchyHPigxLRZJ43Q/eXiGvaEIn/zEab7r3ne9djH70QcMEbH55BW/2My0Z3+N6tPV6p
         9HRw==
X-Gm-Message-State: APjAAAUnaIDZJvn6xr8R08gP1q+CxIyR6RKkpA1PWWRWEV+XbTiuw5d3
        hsl52nB7fxt2u/IRmgynimVZA9tf
X-Google-Smtp-Source: APXvYqzxNfYUeQPKEfHm11BNLPHtdaRoG0oDRvWdcFYfHEy5dbahZDUKE2b+2g5lZcbEDfmXMxPRIQ==
X-Received: by 2002:a17:902:b108:: with SMTP id q8mr81677417plr.110.1558489832732;
        Tue, 21 May 2019 18:50:32 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id u134sm32855756pfc.61.2019.05.21.18.50.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 18:50:31 -0700 (PDT)
Date:   Wed, 22 May 2019 10:50:25 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190522015025.GA29449@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-8-minchan@kernel.org>
 <20190520092801.GA6836@dhcp22.suse.cz>
 <20190521025533.GH10039@google.com>
 <20190521153310.GA3218@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521153310.GA3218@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 21, 2019 at 11:33:10AM -0400, Johannes Weiner wrote:
> On Tue, May 21, 2019 at 11:55:33AM +0900, Minchan Kim wrote:
> > On Mon, May 20, 2019 at 11:28:01AM +0200, Michal Hocko wrote:
> > > [cc linux-api]
> > > 
> > > On Mon 20-05-19 12:52:54, Minchan Kim wrote:
> > > > System could have much faster swap device like zRAM. In that case, swapping
> > > > is extremely cheaper than file-IO on the low-end storage.
> > > > In this configuration, userspace could handle different strategy for each
> > > > kinds of vma. IOW, they want to reclaim anonymous pages by MADV_COLD
> > > > while it keeps file-backed pages in inactive LRU by MADV_COOL because
> > > > file IO is more expensive in this case so want to keep them in memory
> > > > until memory pressure happens.
> > > > 
> > > > To support such strategy easier, this patch introduces
> > > > MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER options in madvise(2) like
> > > > that /proc/<pid>/clear_refs already has supported same filters.
> > > > They are filters could be Ored with other existing hints using top two bits
> > > > of (int behavior).
> > > 
> > > madvise operates on top of ranges and it is quite trivial to do the
> > > filtering from the userspace so why do we need any additional filtering?
> > > 
> > > > Once either of them is set, the hint could affect only the interested vma
> > > > either anonymous or file-backed.
> > > > 
> > > > With that, user could call a process_madvise syscall simply with a entire
> > > > range(0x0 - 0xFFFFFFFFFFFFFFFF) but either of MADV_ANONYMOUS_FILTER and
> > > > MADV_FILE_FILTER so there is no need to call the syscall range by range.
> > > 
> > > OK, so here is the reason you want that. The immediate question is why
> > > cannot the monitor do the filtering from the userspace. Slightly more
> > > work, all right, but less of an API to expose and that itself is a
> > > strong argument against.
> > 
> > What I should do if we don't have such filter option is to enumerate all of
> > vma via /proc/<pid>/maps and then parse every ranges and inode from string,
> > which would be painful for 2000+ vmas.
> 
> Just out of curiosity, how do you get to 2000+ distinct memory regions
> in the address space of a mobile app? I'm assuming these aren't files,
> but rather anon objects with poor grouping. Is that from guard pages
> between individual heap allocations or something?

Android uses preload library model to speed up app launch so it loads
all of library in advance on zygote and forks new app based on it.
