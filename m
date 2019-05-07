Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F34161B9
	for <lists+linux-api@lfdr.de>; Tue,  7 May 2019 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfEGKKr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 May 2019 06:10:47 -0400
Received: from foss.arm.com ([217.140.101.70]:49178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfEGKKq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 May 2019 06:10:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FE5F374;
        Tue,  7 May 2019 03:10:46 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A6553F5AF;
        Tue,  7 May 2019 03:10:43 -0700 (PDT)
Date:   Tue, 7 May 2019 11:10:37 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v8 03/16] sched/core: uclamp: Enforce last task's
 UCLAMP_MAX
Message-ID: <20190507101037.zmkp4trqr4de5yws@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-4-patrick.bellasi@arm.com>
 <CAJuCfpHN4kMBScdEdJodtmbHQ2qhVDnXrJKFDdaSYyjWH0JH5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHN4kMBScdEdJodtmbHQ2qhVDnXrJKFDdaSYyjWH0JH5Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 17-Apr 13:36, Suren Baghdasaryan wrote:
>  Hi Patrick,
> 
> On Tue, Apr 2, 2019 at 3:42 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > When a task sleeps it removes its max utilization clamp from its CPU.
> > However, the blocked utilization on that CPU can be higher than the max
> > clamp value enforced while the task was running. This allows undesired
> > CPU frequency increases while a CPU is idle, for example, when another
> > CPU on the same frequency domain triggers a frequency update, since
> > schedutil can now see the full not clamped blocked utilization of the
> > idle CPU.
> >
> > Fix this by using
> >   uclamp_rq_dec_id(p, rq, UCLAMP_MAX)
> >     uclamp_rq_max_value(rq, UCLAMP_MAX, clamp_value)
> > to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
> > condition.
> >
> 
> If I understand the intent correctly, you are trying to exclude idle
> CPUs from affecting calculations of rq UCLAMP_MAX value. If that is
> true I think description can be simplified a bit :)

That's not entirely correct. What I want to avoid is an OPP increase
because of an idle CPU. Maybe an example can explain it better,
consider this sequence:

 1. A task is running unconstrained on a CPUx and it generates a 100%
    utilization
 2. The task is now constrained by setting util_max=20
 3. We now select an OPP which provides 20% capacity on CPUx

In this scenario the task is still running flat out on that CPUx which
will keep it's util_avg to 1024. Note that after Vincet's PELT rewrite
we don't converge down to the current capacity.

 4. The task sleep, it's removed from CPUx but the "blocked
    utilization" is still 1024

After this point: the CPU is idle, its "blocked utilization" starts
to "slowly" decay but we _already_ removed the 20% util_max constraint
on that CPU since there are no RUNNABLE tasks (i.e no active buckets).

At this point in time, if there is a schedutil update requested from
another CPU of the same frequency domain, by looking at CPUx we will
see its full "blocked utilization" signal, which can be above 20%.

> In particular it took me some time to understand what "blocked
> utilization" means, however if it's a widely accepted term then feel
> free to ignore my input.

Yes, "blocked utilization" is a commonly used term to refer to the
utilization generated by tasks executed on a CPU.

[...]

> > +static inline unsigned int
> > +uclamp_idle_value(struct rq *rq, unsigned int clamp_id, unsigned int clamp_value)
> > +{
> > +       /*
> > +        * Avoid blocked utilization pushing up the frequency when we go
> > +        * idle (which drops the max-clamp) by retaining the last known
> > +        * max-clamp.
> > +        */
> > +       if (clamp_id == UCLAMP_MAX) {
> > +               rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
> > +               return clamp_value;
> > +       }
> > +
> > +       return uclamp_none(UCLAMP_MIN);
> > +}
> > +
> > +static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
> > +                                    unsigned int clamp_value)
> > +{
> > +       /* Reset max-clamp retention only on idle exit */
> > +       if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
> > +               return;
> > +
> > +       WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
> > +}
> > +
> >  static inline
> > -unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
> > +unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
> > +                                unsigned int clamp_value)
> 
> IMHO the name of uclamp_rq_max_value() is a bit misleading because:

That's very similar to what you proposed in:

   https://lore.kernel.org/lkml/20190314122256.7wb3ydswpkfmntvf@e110439-lin/

> 1. It does not imply that it has to be called only when there are no
> more runnable tasks on a CPU. This is currently the case because it's
> called only from uclamp_rq_dec_id() and only when bucket->tasks==0 but
> nothing in the name of this function indicates that it can't be called
> from other places.
> 2. It does not imply that it marks rq UCLAMP_FLAG_IDLE.

Even if you call it from other places, which is not required, it does
not arm. That function still return the current max clamp for a CPU
given its current state. If the CPU is idle we set the flag one more
time but that's not a problem too.

However, do you have any other proposal for a better name ?

> >  {
> >         struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> >         int bucket_id = UCLAMP_BUCKETS - 1;
> > @@ -771,7 +798,7 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
> >         }
> >
> >         /* No tasks -- default clamp values */
> > -       return uclamp_none(clamp_id);
> > +       return uclamp_idle_value(rq, clamp_id, clamp_value);
> >  }

[...]

-- 
#include <best/regards.h>

Patrick Bellasi
