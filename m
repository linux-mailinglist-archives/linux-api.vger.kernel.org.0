Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47AA0162A3
	for <lists+linux-api@lfdr.de>; Tue,  7 May 2019 13:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEGLNx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 May 2019 07:13:53 -0400
Received: from foss.arm.com ([217.140.101.70]:51200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfEGLNx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 May 2019 07:13:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA8A8374;
        Tue,  7 May 2019 04:13:52 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F3D3F5AF;
        Tue,  7 May 2019 04:13:49 -0700 (PDT)
Date:   Tue, 7 May 2019 12:13:47 +0100
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
Subject: Re: [PATCH v8 06/16] sched/core: uclamp: Extend sched_setattr() to
 support utilization clamping
Message-ID: <20190507111347.4ivnjwbymsf7i3e6@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-7-patrick.bellasi@arm.com>
 <CAJuCfpH3htcr3xB_Y4nr7HXCdQd1hOdOAXbtZJB1SOt7Of_qbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH3htcr3xB_Y4nr7HXCdQd1hOdOAXbtZJB1SOt7Of_qbw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 17-Apr 15:26, Suren Baghdasaryan wrote:
> On Tue, Apr 2, 2019 at 3:42 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:

[...]

> > Do not allow to change sched class specific params and non class
> > specific params (i.e. clamp values) at the same time.  This keeps things
> > simple and still works for the most common cases since we are usually
> > interested in just one of the two actions.
> 
> Sorry, I can't find where you are checking to eliminate the
> possibility of simultaneous changes to both sched class specific
> params and non class specific params... Am I too tired or they are
> indeed missing?

No, you right... that limitation has been removed in v8 :)

I'll remove the above paragraph in v9, thanks for spotting it.

[...]

> > +static int uclamp_validate(struct task_struct *p,
> > +                          const struct sched_attr *attr)
> > +{
> > +       unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
> > +       unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
> > +
> > +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> > +               lower_bound = attr->sched_util_min;
> > +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> > +               upper_bound = attr->sched_util_max;
> > +
> > +       if (lower_bound > upper_bound)
> > +               return -EINVAL;
> > +       if (upper_bound > SCHED_CAPACITY_SCALE)
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}

[...]

> >  static void uclamp_fork(struct task_struct *p)
> >  {
> >         unsigned int clamp_id;
> > @@ -1056,6 +1100,13 @@ static void __init init_uclamp(void)
> >  #else /* CONFIG_UCLAMP_TASK */
> >  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
> >  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
> > +static inline int uclamp_validate(struct task_struct *p,
> > +                                 const struct sched_attr *attr)
> > +{
> > +       return -ENODEV;
> 
> ENOSYS might be more appropriate?

Yep, agree, thanks!

> 
> > +}
> > +static void __setscheduler_uclamp(struct task_struct *p,
> > +                                 const struct sched_attr *attr) { }
> >  static inline void uclamp_fork(struct task_struct *p) { }
> >  static inline void init_uclamp(void) { }
> >  #endif /* CONFIG_UCLAMP_TASK */
> > @@ -4424,6 +4475,13 @@ static void __setscheduler_params(struct task_struct *p,
> >  static void __setscheduler(struct rq *rq, struct task_struct *p,
> >                            const struct sched_attr *attr, bool keep_boost)
> >  {
> > +       /*
> > +        * If params can't change scheduling class changes aren't allowed
> > +        * either.
> > +        */
> > +       if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)
> > +               return;
> > +
> >         __setscheduler_params(p, attr);
> >
> >         /*
> > @@ -4561,6 +4619,13 @@ static int __sched_setscheduler(struct task_struct *p,
> >                         return retval;
> >         }
> >
> > +       /* Update task specific "requested" clamps */
> > +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
> > +               retval = uclamp_validate(p, attr);
> > +               if (retval)
> > +                       return retval;
> > +       }
> > +
> >         /*
> >          * Make sure no PI-waiters arrive (or leave) while we are
> >          * changing the priority of the task:

[...]

-- 
#include <best/regards.h>

Patrick Bellasi
