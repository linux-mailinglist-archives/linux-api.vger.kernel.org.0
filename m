Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22590253F6
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 17:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfEUPdO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 11:33:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40343 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfEUPdN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 May 2019 11:33:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so9258968pfn.7
        for <linux-api@vger.kernel.org>; Tue, 21 May 2019 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JdJVvAGyNC8PSXsjfUN8u+zmKF1hLoAAqIvD329Mjs=;
        b=rnqXgMMhyVETxYuovuKic/EJW9jX8R4OBSqbR8Ns4TCHRCgBy8Sb1k0zAYZ59/J94S
         6Iy/Sm1itRyXny9cYzoIGNEtsR/bRvQoGUIh852eQWPsq5aGavHDwD0W6w2MpswU3Coc
         y5ymxRJjWQkhYAf0ob40InCjHd1X+a9yIvvmOF7KY43VbWNgKA5IAyDiqwOLKg6lUoqL
         77/P03tIKEXYXyvDAoD5fDljlvUS67qiJRndivR1QEvDomd3Shrbs0vyHhTytRp2wLB5
         JUozEO+U/NShOuhdDwTC0JpBQoX+2f8Vk6Ht9mI5S7oyQrykqElGO8iOhesf6Ir1faQS
         V5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JdJVvAGyNC8PSXsjfUN8u+zmKF1hLoAAqIvD329Mjs=;
        b=L4pvYCpeLdt9FaUFsSrpaGPY24CFiBTf1fl37aE57mE1aGkXc09eYDSf18VUsuz/Ih
         TRq6ZlUpDg3hORJpD3wzXy299sRiIE4qW2ZTDoDxvqHOT0i/2lf5N4CqoVQTs8aq3Nhn
         MJPjon1sart994OntZf0/56kPebL/nUE3HnIHGloRXmZ2GDTXkNTiIBQn+yqN/Oyjq/4
         eRV9M0irdoEnn1rSmW6/aHLwRue3Pvsp21QY5Hw+qeDfCKA7Y7mCw2lyZv3k1v+6tIwB
         3zUeh4Z4UhafWckv+sNUEmi31DKa0Fdmb3Fs7TGr/tUCTP5UCeUp1M9pI3u/WVEYSCgv
         pq+g==
X-Gm-Message-State: APjAAAULzDkHFt0HSl/7Da1MXLdIC9AZZDO390202YZc5e2Ey2CWUAAp
        io/4qMr4rub+PO34NKY2+5ZygA==
X-Google-Smtp-Source: APXvYqwlng0s4LJPDKCEGz+dJqb/FMYHQKwaVN6ia1yxZapGNrVbL/8WU/wAPFu2zQ4PE5OMy57Bpw==
X-Received: by 2002:a63:d901:: with SMTP id r1mr45310557pgg.271.1558452793234;
        Tue, 21 May 2019 08:33:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5a76])
        by smtp.gmail.com with ESMTPSA id 135sm38967196pfb.97.2019.05.21.08.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 08:33:12 -0700 (PDT)
Date:   Tue, 21 May 2019 11:33:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
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
Message-ID: <20190521153310.GA3218@cmpxchg.org>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-8-minchan@kernel.org>
 <20190520092801.GA6836@dhcp22.suse.cz>
 <20190521025533.GH10039@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521025533.GH10039@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 21, 2019 at 11:55:33AM +0900, Minchan Kim wrote:
> On Mon, May 20, 2019 at 11:28:01AM +0200, Michal Hocko wrote:
> > [cc linux-api]
> > 
> > On Mon 20-05-19 12:52:54, Minchan Kim wrote:
> > > System could have much faster swap device like zRAM. In that case, swapping
> > > is extremely cheaper than file-IO on the low-end storage.
> > > In this configuration, userspace could handle different strategy for each
> > > kinds of vma. IOW, they want to reclaim anonymous pages by MADV_COLD
> > > while it keeps file-backed pages in inactive LRU by MADV_COOL because
> > > file IO is more expensive in this case so want to keep them in memory
> > > until memory pressure happens.
> > > 
> > > To support such strategy easier, this patch introduces
> > > MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER options in madvise(2) like
> > > that /proc/<pid>/clear_refs already has supported same filters.
> > > They are filters could be Ored with other existing hints using top two bits
> > > of (int behavior).
> > 
> > madvise operates on top of ranges and it is quite trivial to do the
> > filtering from the userspace so why do we need any additional filtering?
> > 
> > > Once either of them is set, the hint could affect only the interested vma
> > > either anonymous or file-backed.
> > > 
> > > With that, user could call a process_madvise syscall simply with a entire
> > > range(0x0 - 0xFFFFFFFFFFFFFFFF) but either of MADV_ANONYMOUS_FILTER and
> > > MADV_FILE_FILTER so there is no need to call the syscall range by range.
> > 
> > OK, so here is the reason you want that. The immediate question is why
> > cannot the monitor do the filtering from the userspace. Slightly more
> > work, all right, but less of an API to expose and that itself is a
> > strong argument against.
> 
> What I should do if we don't have such filter option is to enumerate all of
> vma via /proc/<pid>/maps and then parse every ranges and inode from string,
> which would be painful for 2000+ vmas.

Just out of curiosity, how do you get to 2000+ distinct memory regions
in the address space of a mobile app? I'm assuming these aren't files,
but rather anon objects with poor grouping. Is that from guard pages
between individual heap allocations or something?
