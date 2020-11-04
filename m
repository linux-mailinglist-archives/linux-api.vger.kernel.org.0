Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E22A5E6C
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 07:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgKDG6s (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 01:58:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:42912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgKDG6s (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Nov 2020 01:58:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604473126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ra0pA3cWeHuZF5CggPjlzz66mKrMQ6UHpHMF45ZqqGU=;
        b=fWPFaMDjoG2mAGPJzk2IauHuUwtE6UB3Ybx/QIP8FxN7cDFNu4xRNi8U+M/F7HNFmWTDLt
        80xjtoUzW8zNZRLqOS5lv2G8b2lEfJ+2z2p0uTBydm56Ef98soXF024ScQNlnKqMPiZ9S0
        Bdoq+TJzW7WZTspLNHF0lbKtUPLcP+k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31569ADE1;
        Wed,  4 Nov 2020 06:58:46 +0000 (UTC)
Date:   Wed, 4 Nov 2020 07:58:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC]: userspace memory reaping
Message-ID: <20201104065844.GM21990@dhcp22.suse.cz>
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz>
 <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz>
 <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz>
 <20201103213228.GB1631979@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103213228.GB1631979@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 03-11-20 13:32:28, Minchan Kim wrote:
> On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > [...]
> > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > which in addition to sending a kill signal would also reap the
> > > victim's mm in the context of the caller? Maybe having some code will
> > > get the discussion moving forward?
> > 
> > Yeah, having a code, even preliminary, might help here. This definitely
> > needs a good to go from process management people as that proper is land
> > full of surprises...
> 
> Just to remind a idea I suggested to reuse existing concept
> 
>     fd = pidfd_open(victim process)
>     fdatasync(fd);
>     close(fd);

I must have missed this proposal. Anyway, are you suggesting fdatasync
to act as a destructive operation?

-- 
Michal Hocko
SUSE Labs
