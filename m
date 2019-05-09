Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F419918A41
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 15:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfEINEv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 09:04:51 -0400
Received: from foss.arm.com ([217.140.101.70]:40882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfEINEv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 9 May 2019 09:04:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6261B374;
        Thu,  9 May 2019 06:04:50 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D1673F7BD;
        Thu,  9 May 2019 06:04:47 -0700 (PDT)
Date:   Thu, 9 May 2019 14:04:44 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20190509130444.4yawtbpjx2y7pp7g@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-5-patrick.bellasi@arm.com>
 <20190508190733.GC32547@worktop.programming.kicks-ass.net>
 <20190508191529.GA26813@worktop.programming.kicks-ass.net>
 <20190509091057.ckef2ley4eswyzds@e110439-lin>
 <20190509115307.GS2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509115307.GS2623@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 09-May 13:53, Peter Zijlstra wrote:
> On Thu, May 09, 2019 at 10:10:57AM +0100, Patrick Bellasi wrote:
> > On 08-May 21:15, Peter Zijlstra wrote:
> > > On Wed, May 08, 2019 at 09:07:33PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Apr 02, 2019 at 11:41:40AM +0100, Patrick Bellasi wrote:
> > > > > +static inline struct uclamp_se
> > > > > +uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
> > > > > +{
> > > > > +	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
> > > > > +	struct uclamp_se uc_max = uclamp_default[clamp_id];
> > > > > +
> > > > > +	/* System default restrictions always apply */
> > > > > +	if (unlikely(uc_req.value > uc_max.value))
> > > > > +		return uc_max;
> > > > > +
> > > > > +	return uc_req;
> > > > > +}
> > > > > +
> > > > > +static inline unsigned int
> > > > > +uclamp_eff_bucket_id(struct task_struct *p, unsigned int clamp_id)
> > > > > +{
> > > > > +	struct uclamp_se uc_eff;
> > > > > +
> > > > > +	/* Task currently refcounted: use back-annotated (effective) bucket */
> > > > > +	if (p->uclamp[clamp_id].active)
> > > > > +		return p->uclamp[clamp_id].bucket_id;
> > > > > +
> > > > > +	uc_eff = uclamp_eff_get(p, clamp_id);
> > > > > +
> > > > > +	return uc_eff.bucket_id;
> > > > > +}
> > > > > +
> > > > > +unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
> > > > > +{
> > > > > +	struct uclamp_se uc_eff;
> > > > > +
> > > > > +	/* Task currently refcounted: use back-annotated (effective) value */
> > > > > +	if (p->uclamp[clamp_id].active)
> > > > > +		return p->uclamp[clamp_id].value;
> > > > > +
> > > > > +	uc_eff = uclamp_eff_get(p, clamp_id);
> > > > > +
> > > > > +	return uc_eff.value;
> > > > > +}
> > > > 
> > > > This is 'wrong' because:
> > > > 
> > > >   uclamp_eff_value(p,id) := uclamp_eff(p,id).value
> > > 
> > > Clearly I means to say the above does not hold with the given
> > > implementation, while the naming would suggest it does.
> > 
> > Not sure to completely get your point...
> 
> the point is that uclamp_eff_get() doesn't do the back annotate thing
> and therefore returns something entirely different from
> uclamp_eff_{bucket_id,value}(), where the naming would suggest it in
> fact returns the same thing.
> 
> > > > Which seems to suggest the uclamp_eff_*() functions want another name.
> > 
> > That function returns the effective value of a task, which is either:
> >  1. the back annotated value for a RUNNABLE task
> > or
> >  2. the aggregation of task-specific, system-default and cgroup values
> >     for a non RUNNABLE task.
> 
> Right, but uclamp_eff_get() doesn't do 1, while the other two do do it.
> And that is confusing.

I see, right.

> > > > Also, suppose the above would be true; does GCC really generate better
> > > > code for the LHS compared to the RHS?
> > 
> > It generate "sane" code which implements the above logic and allows
> > to know that whenever we call uclamp_eff_value(p,id) we get the most
> > updated effective value for a task, independently from its {!}RUNNABLE
> > state.
> > 
> > I would keep the function but, since Suren also complained also about
> > the name... perhaps I should come up with a better name? Proposals?
> 
> Right, so they should move to the patch where they're needed, but I was

Yes, I'll move _value() to 10/16:

   sched/core: uclamp: Add uclamp_util_with()

where we actually need to access the clamp value and...

> wondering why you'd not written something like:
> 
> static inline
> struct uclamp_se uclamp_active(struct task_struct *p, unsigned int clamp_id)
> {
> 	if (p->uclamp[clamp_id].active)
> 		return p->uclamp[clamp_id];
> 
> 	return uclamp_eff(p, clamp_id);
> }
> 
> And then used:
> 
> 	uclamp_active(p, id).{value,bucket_id}
> 
> - OR -
> 
> have uclamp_eff() include the active thing, afaict the callsite in
> uclamp_rq_inc_id() guarantees !active.
> 
> In any case, I'm thinking the foo().member notation saves us from having
> to have two almost identical functions and the 'inline' part should get
> GCC to generate sane code.

... look into this approach, seems reasonable and actually better to read.

Thanks

-- 
#include <best/regards.h>

Patrick Bellasi
