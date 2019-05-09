Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7318947
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 13:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfEILx2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 07:53:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfEILx2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 May 2019 07:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WEmDk6UA0mKEAIOMzekDc5S1hEk04SivBh1zhxTc3zI=; b=Wm1dH3s9bdRNqyyTki9T0RnUc
        8jrBIACYi/tZ6usBaEfAoRS/f0oz0FV3xupnk8a/Dsz459j7txFBPigZuHGdZfPh5dr8Cg6ekYhoq
        lVhbZgWKqv8kIAgaO2M+5gS5OGNKobAbQ3HI2tw1w8inhvG3sfESnF9DQgw8qajnAlHak+/hL+pqs
        puC3Q/+utjJWUAXlY3WNSI5JnszSlEoqG9a1qV7qBdLe0memcpibzZ5Tgv1B4umRNh/QJvhYjvfyx
        UtWcaR0YGZXPr9D2DhmsRP2Z/mIA4LaJMlrnL0V+4t/jVFXn173CtbwJO085Viy9T1+ooZMRSR+64
        mHXlmnZCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOhbs-0002ix-D0; Thu, 09 May 2019 11:53:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6619A2029F87E; Thu,  9 May 2019 13:53:07 +0200 (CEST)
Date:   Thu, 9 May 2019 13:53:07 +0200
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
Subject: Re: [PATCH v8 04/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190509115307.GS2623@hirez.programming.kicks-ass.net>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-5-patrick.bellasi@arm.com>
 <20190508190733.GC32547@worktop.programming.kicks-ass.net>
 <20190508191529.GA26813@worktop.programming.kicks-ass.net>
 <20190509091057.ckef2ley4eswyzds@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509091057.ckef2ley4eswyzds@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 09, 2019 at 10:10:57AM +0100, Patrick Bellasi wrote:
> On 08-May 21:15, Peter Zijlstra wrote:
> > On Wed, May 08, 2019 at 09:07:33PM +0200, Peter Zijlstra wrote:
> > > On Tue, Apr 02, 2019 at 11:41:40AM +0100, Patrick Bellasi wrote:
> > > > +static inline struct uclamp_se
> > > > +uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
> > > > +{
> > > > +	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
> > > > +	struct uclamp_se uc_max = uclamp_default[clamp_id];
> > > > +
> > > > +	/* System default restrictions always apply */
> > > > +	if (unlikely(uc_req.value > uc_max.value))
> > > > +		return uc_max;
> > > > +
> > > > +	return uc_req;
> > > > +}
> > > > +
> > > > +static inline unsigned int
> > > > +uclamp_eff_bucket_id(struct task_struct *p, unsigned int clamp_id)
> > > > +{
> > > > +	struct uclamp_se uc_eff;
> > > > +
> > > > +	/* Task currently refcounted: use back-annotated (effective) bucket */
> > > > +	if (p->uclamp[clamp_id].active)
> > > > +		return p->uclamp[clamp_id].bucket_id;
> > > > +
> > > > +	uc_eff = uclamp_eff_get(p, clamp_id);
> > > > +
> > > > +	return uc_eff.bucket_id;
> > > > +}
> > > > +
> > > > +unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
> > > > +{
> > > > +	struct uclamp_se uc_eff;
> > > > +
> > > > +	/* Task currently refcounted: use back-annotated (effective) value */
> > > > +	if (p->uclamp[clamp_id].active)
> > > > +		return p->uclamp[clamp_id].value;
> > > > +
> > > > +	uc_eff = uclamp_eff_get(p, clamp_id);
> > > > +
> > > > +	return uc_eff.value;
> > > > +}
> > > 
> > > This is 'wrong' because:
> > > 
> > >   uclamp_eff_value(p,id) := uclamp_eff(p,id).value
> > 
> > Clearly I means to say the above does not hold with the given
> > implementation, while the naming would suggest it does.
> 
> Not sure to completely get your point...

the point is that uclamp_eff_get() doesn't do the back annotate thing
and therefore returns something entirely different from
uclamp_eff_{bucket_id,value}(), where the naming would suggest it in
fact returns the same thing.

> > > Which seems to suggest the uclamp_eff_*() functions want another name.
> 
> That function returns the effective value of a task, which is either:
>  1. the back annotated value for a RUNNABLE task
> or
>  2. the aggregation of task-specific, system-default and cgroup values
>     for a non RUNNABLE task.

Right, but uclamp_eff_get() doesn't do 1, while the other two do do it.
And that is confusing.

> > > Also, suppose the above would be true; does GCC really generate better
> > > code for the LHS compared to the RHS?
> 
> It generate "sane" code which implements the above logic and allows
> to know that whenever we call uclamp_eff_value(p,id) we get the most
> updated effective value for a task, independently from its {!}RUNNABLE
> state.
> 
> I would keep the function but, since Suren also complained also about
> the name... perhaps I should come up with a better name? Proposals?

Right, so they should move to the patch where they're needed, but I was
wondering why you'd not written something like:

static inline
struct uclamp_se uclamp_active(struct task_struct *p, unsigned int clamp_id)
{
	if (p->uclamp[clamp_id].active)
		return p->uclamp[clamp_id];

	return uclamp_eff(p, clamp_id);
}

And then used:

	uclamp_active(p, id).{value,bucket_id}

- OR -

have uclamp_eff() include the active thing, afaict the callsite in
uclamp_rq_inc_id() guarantees !active.

In any case, I'm thinking the foo().member notation saves us from having
to have two almost identical functions and the 'inline' part should get
GCC to generate sane code.
