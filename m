Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCA71456B7
	for <lists+linux-api@lfdr.de>; Wed, 22 Jan 2020 14:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgAVN2w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Jan 2020 08:28:52 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:13019 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgAVN2w (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 Jan 2020 08:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579699731; x=1611235731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=ey5rjg4mda5FhTLJWi1oq6Krp59ycus1HT0dQ739AXY=;
  b=GDoX0rS0g7Bgl6Msw+ER+sczNg11mIxNhIIYX2OcdQEpLOoIH5oon+ID
   mOLxlRE0DzfUe1VUAhAb/QVp4oXlHuPUXllsXcsJ/KvwlSiEUYsT2Y0UQ
   /Aoasn2KzNWIldjo6GmBGAaxyduXuwc8z+rnak0owxHU/F+g3RkY6v+sh
   E=;
IronPort-SDR: HiUJIsusC/kKMOyUWLsjcfATwG4l6ckaqzbkN0XGdVQ/Dqilutw6gaCaKrUGvqQUEBjxqcR0Cr
 G5ccOjyeb07g==
X-IronPort-AV: E=Sophos;i="5.70,350,1574121600"; 
   d="scan'208";a="12762489"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 22 Jan 2020 13:28:50 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id A1B3CA2210;
        Wed, 22 Jan 2020 13:28:44 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 22 Jan 2020 13:28:43 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.16) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Jan 2020 13:28:35 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     SeongJae Park <sjpark@amazon.com>,
        Minchan Kim <minchan@kernel.org>, <sspatil@google.com>,
        <kirill@shutemov.name>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-api@vger.kernel.org>, <oleksandr@redhat.com>,
        <surenb@google.com>, <timmurray@google.com>, <dancol@google.com>,
        <sonnyrao@google.com>, <bgeffon@google.com>, <hannes@cmpxchg.org>,
        <shakeelb@google.com>, <joaodias@google.com>,
        <ktkhai@virtuozzo.com>, <christian.brauner@ubuntu.com>,
        <sjpark@amazon.de>
Subject: Re: Re: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Date:   Wed, 22 Jan 2020 14:28:20 +0100
Message-ID: <20200122132820.29180-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122100233.GT29276@dhcp22.suse.cz> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.16]
X-ClientProxiedBy: EX13D08UWB001.ant.amazon.com (10.43.161.104) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 22 Jan 2020 11:02:33 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 22-01-20 10:36:24, SeongJae Park wrote:
> > On Wed, 22 Jan 2020 09:28:53 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > > On Tue 21-01-20 10:32:12, Minchan Kim wrote:
> > > > On Mon, Jan 20, 2020 at 08:58:25AM +0100, Michal Hocko wrote:
> > > [...]
> > > > > The interface really has to be robust to future potential usecases.
> > > > 
> > > > I do understand your concern but for me, it's chicken and egg problem.
> > > > We usually do best effort to make something perfect as far as possible
> > > > but we also don't do over-engineering without real usecase from the
> > > > beginning.
> > > > 
> > > > I already told you how we could synchronize among processes and potential
> > > > way to be extended Daniel suggested(That's why current API has extra field
> > > > for the cookie) even though we don't need it right now.
> > > 
> > > If you can synchronize with the target task then you do not need a
> > > remote interface. Just use ptrace and you are done with it.
> > > 
> > > > If you want to suggest the other way, please explain why your idea is
> > > > better and why we need it at this moment.
> > > 
> > > I believe I have explained my concerns and why they matter. All you are
> > > saying is that you do not care because your particular usecase doesn't
> > > care. And that is a first signal of a future disaster when we end up
> > > with a broken and unfixable interface we have to maintain for ever.
> > > 
> > > I will not go as far as to nack this but you should seriously think
> > > about other potential usecases and how they would work and what we are
> > > going to do when a first non-cooperative userspace memory management
> > > usecase materializes.
> > 
> > Beside of the specific environment of Android, I think there are many ways to
> > know the address space layout and access patterns of other processes.  The
> > idle_page_tracking might be an example that widelay available.
> > 
> > Of course, the information might not strictly correct due to the timing issue,
> > but could be still worth to be used under some extreme situations, such as
> > memory pressure or fragmentation.  For the same reason, ptrace() would not be
> > sufficient, as we have no perfect control, but only some level of control that
> > would be useful under specific situations.
> 
> I am not sure I see your point. I am talking about races where a remote
> task is operating on a completely different object because the one it
> checked for has been unmapped and new one mapped over it. Memory
> pressure or a fragmentation will not change the object itself. Sure the
> memory might be reclaimed but that should be completely OK unless I am
> missing something.

Thank you for pointing out your concerns in more detail.  I was assuming a case
using MADV_PAGEOUT or MADV_HUGEPAGE like hints under access frequency
monitoring for better performance under memory pressure or fragmentation,
respectively.  Under the race, such hints might incur some performance
degradation, but no critical problem such as SEGV.  I previously implemented
such optimization for research purpose and it was worthy.  Nonetheless, it was
just a research purpose hack.

MADV_FREE like hints might result in SEGV and thus of course should be avoided.
But, to my perspective, the 4 hints madvise_process() is currently supporting
(COLD, PAGEOUT, MERGEABLE, UNMERGEABLE) are not too risky even under the race.
That's why I said the incorrect information could be worth to be used under
some extreme situations.

> 
> > I assume the users of this systemcall would understand the tradeoff and make
> > decisions.
> 
> I disagree. My experience tells me that users tend to squeeze the
> maximum and beyond and hope they get what they want.
> 
> > Also, as the users already have the right to do the tradeoff, I
> > think it's fair.  In other words, I think the caller has both the power and the
> > responsibility to deal with the time-to-check-time-to-react problem.
> > 
> > Nonetheless, I also agree this is important concern and the patch would be
> > better if it adds more detailed documentation regarding this issue.
> 
> If there is _really_ a strong consensus that the racy interface is
> reasonable then it absolutely has to be described with a clearly state
> that those races might result in hard to predict behavior unless all
> tasks sharing the address space are blocked between the check and the
> madvise call.

So, it's still too risky to simply believe users to do the things well on their
responsibility, but a strong real consensus on needs and clear description
might justify this.  I also agreed.


Thanks,
SeongJae Park

> -- 
> Michal Hocko
> SUSE Labs
> 
