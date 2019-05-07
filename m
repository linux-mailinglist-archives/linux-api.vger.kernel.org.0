Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B59B162C1
	for <lists+linux-api@lfdr.de>; Tue,  7 May 2019 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfEGLZ2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 May 2019 07:25:28 -0400
Received: from foss.arm.com ([217.140.101.70]:51482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfEGLZ2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 May 2019 07:25:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAE0B374;
        Tue,  7 May 2019 04:25:27 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCE833F5AF;
        Tue,  7 May 2019 04:25:24 -0700 (PDT)
Date:   Tue, 7 May 2019 12:25:22 +0100
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
Subject: Re: [PATCH v8 08/16] sched/core: uclamp: Set default clamps for RT
 tasks
Message-ID: <20190507112522.g2gaydwfkczb33je@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-9-patrick.bellasi@arm.com>
 <CAJuCfpH9E2Khc1WP8MZgLK+yF7GgwW29ECES4hqPN3jaB34RqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH9E2Khc1WP8MZgLK+yF7GgwW29ECES4hqPN3jaB34RqA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 17-Apr 16:07, Suren Baghdasaryan wrote:
> On Tue, Apr 2, 2019 at 3:42 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > By default FAIR tasks start without clamps, i.e. neither boosted nor
> > capped, and they run at the best frequency matching their utilization
> > demand.  This default behavior does not fit RT tasks which instead are
> > expected to run at the maximum available frequency, if not otherwise
> > required by explicitly capping them.
> >
> > Enforce the correct behavior for RT tasks by setting util_min to max
> > whenever:
> >
> >  1. the task is switched to the RT class and it does not already have a
> >     user-defined clamp value assigned.
> >
> >  2. an RT task is forked from a parent with RESET_ON_FORK set.
> >
> > NOTE: utilization clamp values are cross scheduling class attributes and
> > thus they are never changed/reset once a value has been explicitly
> > defined from user-space.
> >
> > Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  kernel/sched/core.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index bdebdabe9bc4..71c9dd6487b1 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1042,6 +1042,28 @@ static int uclamp_validate(struct task_struct *p,
> >  static void __setscheduler_uclamp(struct task_struct *p,
> >                                   const struct sched_attr *attr)
> >  {
> > +       unsigned int clamp_id;
> > +
> > +       /*
> > +        * On scheduling class change, reset to default clamps for tasks
> > +        * without a task-specific value.
> > +        */
> > +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> > +               struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
> > +               unsigned int clamp_value = uclamp_none(clamp_id);
> > +
> > +               /* Keep using defined clamps across class changes */
> > +               if (uc_se->user_defined)
> > +                       continue;
> > +
> > +               /* By default, RT tasks always get 100% boost */
> > +               if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > +                       clamp_value = uclamp_none(UCLAMP_MAX);
> > +
> > +               uc_se->bucket_id = uclamp_bucket_id(clamp_value);
> > +               uc_se->value = clamp_value;
> 
> Is it possible for p->uclamp_req[UCLAMP_MAX].value to be less than
> uclamp_none(UCLAMP_MAX) for this RT task? If that's a possibility then
> I think we will end up with a case of
>   p->uclamp_req[UCLAMP_MIN].value > p->uclamp_req[UCLAMP_MAX].value
> after these assignments are done.
> 

The util_max for an RT task can be less then uclamp_none(UCLAMP_MAX),
however, requesting a task specific util_max which is smaller then the
current util_min will fail in:

   __sched_setscheduler()
      uclamp_validate()

since we only allow util_min <= util_max for all task specific values.

> > +       }
> > +
> >         if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> >                 return;
> >
> > @@ -1077,6 +1099,10 @@ static void uclamp_fork(struct task_struct *p)
> >         for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> >                 unsigned int clamp_value = uclamp_none(clamp_id);
> >
> > +               /* By default, RT tasks always get 100% boost */
> > +               if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > +                       clamp_value = uclamp_none(UCLAMP_MAX);
> > +
> >                 p->uclamp_req[clamp_id].user_defined = false;
> >                 p->uclamp_req[clamp_id].value = clamp_value;
> >                 p->uclamp_req[clamp_id].bucket_id = uclamp_bucket_id(clamp_value);
> > --
> > 2.20.1
> >

-- 
#include <best/regards.h>

Patrick Bellasi
