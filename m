Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDFCB1659F6
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 10:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgBTJRK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 04:17:10 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:50344 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgBTJRK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 04:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582190230; x=1613726230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=3DR/UH6MEPv43yGUiIRitijjOdGjwQGa0V2AAfInCYM=;
  b=jXYZt7ecjO//M2DtZFe7S/88uwuivVGtxYP3w9IjYHXziFkxMPac4syI
   EWmZDMaR9G5fERwQUBrT8aq1hlnq/C56fODq1+OFLaBVuHjywne3dGBe2
   s0fI66AolilQBh16dLwToq9TucNLCTg5tAkg8aALGNMMjwtU/fB+aoGNf
   M=;
IronPort-SDR: wz79lME026lmGTeEOVhzNMQUXbePBwBbna1HEI5VzRyyhMCftsQsZad6YIlel6EqMNx4l17IFr
 UdYdDtsWdvnQ==
X-IronPort-AV: E=Sophos;i="5.70,463,1574121600"; 
   d="scan'208";a="18729860"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 20 Feb 2020 09:16:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 537CAA2660;
        Thu, 20 Feb 2020 09:16:54 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 20 Feb 2020 09:16:54 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.45) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 20 Feb 2020 09:16:45 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, <linux-api@vger.kernel.org>,
        <oleksandr@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, <sj38.park@gmail.com>,
        <alexander.h.duyck@linux.intel.com>, Jann Horn <jannh@google.com>
Subject: Re: Re: [PATCH v6 0/7] introduce memory hinting API for external process
Date:   Thu, 20 Feb 2020 10:16:31 +0100
Message-ID: <20200220091631.31949-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219120123.07dda51c29006a892059ccde@linux-foundation.org> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.45]
X-ClientProxiedBy: EX13D06UWA002.ant.amazon.com (10.43.160.143) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 19 Feb 2020 12:01:23 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 18 Feb 2020 17:44:26 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> > application could give hints to kernel what memory range are preferred to be
> > reclaimed. However, in some platform(e.g., Android), the information
> > required to make the hinting decision is not known to the app.
> > Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without any app
> > involvement.
> > 
> 
> This patchset doesn't seem to be getting a lot of interest from other
> potential users?  It seems very specialized.  Are there or will there
> ever be any users of this apart from one Android daemon?
> 
> Also, it doesn't terribly hard for ActivityManagerService to tell
> another process "now run madvise with these arguments".  Please explain
> why this is not practical in ActivityManagerService and also within
> other potential users of this syscall.

I personally have interest in and hope successful development/merge of this
patchset.

The interested usecases of 'madvise_process()' for me is optimizations of
general memory-intensive workloads having dynamic data access patterns on
hierarchical memory systems (e.g., multi-tier memory or fast storage based swap
devices).  In more detail, I'm already using a part of this patchset for my RFC
patchset implementing Data Access Monitoring-based Operation Schemes[1].  For
my specific case, I don't need new system call but only target task argument,
though.

Once in a past, before joining my current company, I tried using 'madvise()' to
optimize some scientific HPC programs.  The improvement results were clear, but
optimizing each of the workloads was challenging and time-consuming.  I believe
this new systemcall to be very helpful for such cases, either.

[1] https://lore.kernel.org/linux-mm/20200218085309.18346-1-sjpark@amazon.com/


Thanks,
SeongJae Park
