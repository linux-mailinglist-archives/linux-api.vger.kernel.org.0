Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0541877D
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 11:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfEIJLE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 05:11:04 -0400
Received: from foss.arm.com ([217.140.101.70]:35286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfEIJLE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 9 May 2019 05:11:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BF4B374;
        Thu,  9 May 2019 02:11:03 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D13F3F575;
        Thu,  9 May 2019 02:11:00 -0700 (PDT)
Date:   Thu, 9 May 2019 10:10:57 +0100
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
Message-ID: <20190509091057.ckef2ley4eswyzds@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-5-patrick.bellasi@arm.com>
 <20190508190733.GC32547@worktop.programming.kicks-ass.net>
 <20190508191529.GA26813@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508191529.GA26813@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 08-May 21:15, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 09:07:33PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 02, 2019 at 11:41:40AM +0100, Patrick Bellasi wrote:
> > > +static inline struct uclamp_se
> > > +uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
> > > +{
> > > +	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
> > > +	struct uclamp_se uc_max = uclamp_default[clamp_id];
> > > +
> > > +	/* System default restrictions always apply */
> > > +	if (unlikely(uc_req.value > uc_max.value))
> > > +		return uc_max;
> > > +
> > > +	return uc_req;
> > > +}
> > > +
> > > +static inline unsigned int
> > > +uclamp_eff_bucket_id(struct task_struct *p, unsigned int clamp_id)
> > > +{
> > > +	struct uclamp_se uc_eff;
> > > +
> > > +	/* Task currently refcounted: use back-annotated (effective) bucket */
> > > +	if (p->uclamp[clamp_id].active)
> > > +		return p->uclamp[clamp_id].bucket_id;
> > > +
> > > +	uc_eff = uclamp_eff_get(p, clamp_id);
> > > +
> > > +	return uc_eff.bucket_id;
> > > +}
> > > +
> > > +unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
> > > +{
> > > +	struct uclamp_se uc_eff;
> > > +
> > > +	/* Task currently refcounted: use back-annotated (effective) value */
> > > +	if (p->uclamp[clamp_id].active)
> > > +		return p->uclamp[clamp_id].value;
> > > +
> > > +	uc_eff = uclamp_eff_get(p, clamp_id);
> > > +
> > > +	return uc_eff.value;
> > > +}
> > 
> > This is 'wrong' because:
> > 
> >   uclamp_eff_value(p,id) := uclamp_eff(p,id).value
> 
> Clearly I means to say the above does not hold with the given
> implementation, while the naming would suggest it does.

Not sure to completely get your point...

AFAIU, what you call uclamp_eff(p, id).value is the "value" member of
the struct returned by uclamp_eff_get(p,id), which is back annotate
by uclamp_rq_inc_id(p, rq, id) in:

   p->uclamp[clamp_id].value

when a task becomes RUNNABLE.

> > Which seems to suggest the uclamp_eff_*() functions want another name.

That function returns the effective value of a task, which is either:
 1. the back annotated value for a RUNNABLE task
or
 2. the aggregation of task-specific, system-default and cgroup values
    for a non RUNNABLE task.

> > Also, suppose the above would be true; does GCC really generate better
> > code for the LHS compared to the RHS?

It generate "sane" code which implements the above logic and allows
to know that whenever we call uclamp_eff_value(p,id) we get the most
updated effective value for a task, independently from its {!}RUNNABLE
state.

I would keep the function but, since Suren also complained also about
the name... perhaps I should come up with a better name? Proposals?

-- 
#include <best/regards.h>

Patrick Bellasi
