Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E19145114
	for <lists+linux-api@lfdr.de>; Wed, 22 Jan 2020 10:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbgAVJvi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Jan 2020 04:51:38 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:10183 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbgAVJhH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 Jan 2020 04:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579685828; x=1611221828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=K9Kz0EYeQrURGwTjiRNoD6do9zmd0lXIO7vywrJCJO8=;
  b=uRp6jW4JGtw9vMYS5hPKvfYGsFkEcaruIt126ZG1o9X5RVoBqVguBtnE
   1TKWRcNJtLVSoog3HSFjAVTs40TJB4RmCnMlBCgnm7x2aTObplckddkKS
   8mx9sabNgPXaGiJXhXxBoFCS1cCrNymVQH9sa77bMnnv+mkT9vRY8JD3Y
   k=;
IronPort-SDR: +ZLstp77iXAZO+vQ5DM0SWDzWs9fWxGYhsX8L1GfAcFYl7ljZWGWoubEp3F+ZLyxkgUzMc616p
 ILsZ+kD1SJBg==
X-IronPort-AV: E=Sophos;i="5.70,349,1574121600"; 
   d="scan'208";a="11919547"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Jan 2020 09:36:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 2D141A1780;
        Wed, 22 Jan 2020 09:36:48 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 22 Jan 2020 09:36:48 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.224) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Jan 2020 09:36:40 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Minchan Kim <minchan@kernel.org>, <sspatil@google.com>,
        <kirill@shutemov.name>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-api@vger.kernel.org>, <oleksandr@redhat.com>,
        <surenb@google.com>, <timmurray@google.com>, <dancol@google.com>,
        <sonnyrao@google.com>, <bgeffon@google.com>, <hannes@cmpxchg.org>,
        <shakeelb@google.com>, <joaodias@google.com>,
        <ktkhai@virtuozzo.com>, <christian.brauner@ubuntu.com>,
        <sjpark@amazon.de>
Subject: Re: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Date:   Wed, 22 Jan 2020 10:36:24 +0100
Message-ID: <20200122093624.14799-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122082853.GS29276@dhcp22.suse.cz> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.224]
X-ClientProxiedBy: EX13d09UWA004.ant.amazon.com (10.43.160.158) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 22 Jan 2020 09:28:53 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> On Tue 21-01-20 10:32:12, Minchan Kim wrote:
> > On Mon, Jan 20, 2020 at 08:58:25AM +0100, Michal Hocko wrote:
> [...]
> > > The interface really has to be robust to future potential usecases.
> > 
> > I do understand your concern but for me, it's chicken and egg problem.
> > We usually do best effort to make something perfect as far as possible
> > but we also don't do over-engineering without real usecase from the
> > beginning.
> > 
> > I already told you how we could synchronize among processes and potential
> > way to be extended Daniel suggested(That's why current API has extra field
> > for the cookie) even though we don't need it right now.
> 
> If you can synchronize with the target task then you do not need a
> remote interface. Just use ptrace and you are done with it.
> 
> > If you want to suggest the other way, please explain why your idea is
> > better and why we need it at this moment.
> 
> I believe I have explained my concerns and why they matter. All you are
> saying is that you do not care because your particular usecase doesn't
> care. And that is a first signal of a future disaster when we end up
> with a broken and unfixable interface we have to maintain for ever.
> 
> I will not go as far as to nack this but you should seriously think
> about other potential usecases and how they would work and what we are
> going to do when a first non-cooperative userspace memory management
> usecase materializes.

Beside of the specific environment of Android, I think there are many ways to
know the address space layout and access patterns of other processes.  The
idle_page_tracking might be an example that widelay available.

Of course, the information might not strictly correct due to the timing issue,
but could be still worth to be used under some extreme situations, such as
memory pressure or fragmentation.  For the same reason, ptrace() would not be
sufficient, as we have no perfect control, but only some level of control that
would be useful under specific situations.

I assume the users of this systemcall would understand the tradeoff and make
decisions.  Also, as the users already have the right to do the tradeoff, I
think it's fair.  In other words, I think the caller has both the power and the
responsibility to deal with the time-to-check-time-to-react problem.

Nonetheless, I also agree this is important concern and the patch would be
better if it adds more detailed documentation regarding this issue.

If I'm missing some points or you have different opinions, please let me know.


Thanks,
SeongJae Park

> -- 
> Michal Hocko
> SUSE Labs
> 
