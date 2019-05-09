Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF3C1894E
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfEILz1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 07:55:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57712 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfEILz1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 May 2019 07:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hq8JE4thyp+lzrmCnHR5cSrNW6JqUDn9n8hfz4f5RFk=; b=pVD/QBmLIKMmuUuLka9RM28lB
        LIO/eId0a0sd1ITEKaO1oieQEi5M93xR67oGimnhC9suP1W6ExMN4kIlE1cpNGp7xT6zSYRKbL8DI
        wwzUhCQ4qLrQTMxNAvNIwpxu4Jpc3tTWio+wDhFkYpez3phumYCkEN4wg8prZeNNkW6W/F1Wl1SpZ
        vC/JmnDRXkzfoG08leRfHQIEUPnfGrgHz1A0xPpvxYuGG1rV+CBkKSlZeVJDkcaayERpcS1wzG8gV
        CZCfhmhcqzKxbWoDPjxhsnOXgyTUMQYiMw5mt90yWew6jnuLRbCiqpgb8KIgrT3RhkU7090mt+OEW
        Q0NhQdxsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOhdv-0002jd-7H; Thu, 09 May 2019 11:55:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E56932029F87C; Thu,  9 May 2019 13:55:17 +0200 (CEST)
Date:   Thu, 9 May 2019 13:55:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v8 05/16] sched/core: Allow sched_setattr() to use the
 current policy
Message-ID: <20190509115517.GT2623@hirez.programming.kicks-ass.net>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-6-patrick.bellasi@arm.com>
 <20190508192131.GD32547@worktop.programming.kicks-ass.net>
 <20190509091807.7d3iykkn3oj4b737@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509091807.7d3iykkn3oj4b737@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 09, 2019 at 10:18:07AM +0100, Patrick Bellasi wrote:
> On 08-May 21:21, Peter Zijlstra wrote:
> > On Tue, Apr 02, 2019 at 11:41:41AM +0100, Patrick Bellasi wrote:
> > > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > > index 22627f80063e..075c610adf45 100644
> > > --- a/include/uapi/linux/sched.h
> > > +++ b/include/uapi/linux/sched.h
> > > @@ -40,6 +40,8 @@
> > >  /* SCHED_ISO: reserved but not implemented yet */
> > >  #define SCHED_IDLE		5
> > >  #define SCHED_DEADLINE		6
> > > +/* Must be the last entry: used to sanity check attr.policy values */
> > > +#define SCHED_POLICY_MAX	SCHED_DEADLINE
> > 
> > This is a wee bit sad to put in a uapi header; but yeah, where else :/
> > 
> > Another option would be something like:
> > 
> > enum {
> > 	SCHED_NORMAL = 0,
> > 	SCHED_FIFO = 1,
> > 	SCHED_RR = 2,
> > 	SCHED_BATCH = 3,
> > 	/* SCHED_ISO = 4, reserved */
> > 	SCHED_IDLE = 5,
> > 	SCHED_DEADLINE = 6,
> > 	SCHED_POLICY_NR
> > };
> 
> I just wanted to minimize the changes by keeping the same structure...
> If you prefer the above I can add a refactoring patch just to update
> existing definitions before adding this patch...

Right; I've no idea really. The thing that started all this was adding
that define to UAPI. Maybe we can do without it and instead put in a
comment to check sched_setattr() any time we add a new policy and just
hard code the thing.

