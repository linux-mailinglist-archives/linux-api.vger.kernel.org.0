Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0A162FB
	for <lists+linux-api@lfdr.de>; Tue,  7 May 2019 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfEGLmj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 May 2019 07:42:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51826 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfEGLmi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 May 2019 07:42:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD97D80D;
        Tue,  7 May 2019 04:42:37 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D739A3F5AF;
        Tue,  7 May 2019 04:42:34 -0700 (PDT)
Date:   Tue, 7 May 2019 12:42:32 +0100
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
Subject: Re: [PATCH v8 12/16] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190507114232.npsvba4itex5qpvl@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-13-patrick.bellasi@arm.com>
 <CAJuCfpFFSgRUFb9pyckpXWxr-z+mrrhcsLjZiVN5fZMvYC5XxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFFSgRUFb9pyckpXWxr-z+mrrhcsLjZiVN5fZMvYC5XxQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 17-Apr 17:12, Suren Baghdasaryan wrote:
> On Tue, Apr 2, 2019 at 3:43 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > The cgroup CPU bandwidth controller allows to assign a specified
> > (maximum) bandwidth to the tasks of a group. However this bandwidth is
> > defined and enforced only on a temporal base, without considering the
> > actual frequency a CPU is running on. Thus, the amount of computation
> > completed by a task within an allocated bandwidth can be very different
> > depending on the actual frequency the CPU is running that task.
> > The amount of computation can be affected also by the specific CPU a
> > task is running on, especially when running on asymmetric capacity
> > systems like Arm's big.LITTLE.
> >
> > With the availability of schedutil, the scheduler is now able
> > to drive frequency selections based on actual task utilization.
> > Moreover, the utilization clamping support provides a mechanism to
> > bias the frequency selection operated by schedutil depending on
> > constraints assigned to the tasks currently RUNNABLE on a CPU.
> >
> > Giving the mechanisms described above, it is now possible to extend the
> > cpu controller to specify the minimum (or maximum) utilization which
> > should be considered for tasks RUNNABLE on a cpu.
> > This makes it possible to better defined the actual computational
> > power assigned to task groups, thus improving the cgroup CPU bandwidth
> > controller which is currently based just on time constraints.
> >
> > Extend the CPU controller with a couple of new attributes util.{min,max}
> > which allows to enforce utilization boosting and capping for all the
> > tasks in a group. Specifically:
> >
> > - util.min: defines the minimum utilization which should be considered
> >             i.e. the RUNNABLE tasks of this group will run at least at a
> >                  minimum frequency which corresponds to the util.min
> >                  utilization
> >
> > - util.max: defines the maximum utilization which should be considered
> >             i.e. the RUNNABLE tasks of this group will run up to a
> >                  maximum frequency which corresponds to the util.max
> >                  utilization
> >
> > These attributes:
> >
> > a) are available only for non-root nodes, both on default and legacy
> >    hierarchies, while system wide clamps are defined by a generic
> >    interface which does not depends on cgroups. This system wide
> >    interface enforces constraints on tasks in the root node.
> >
> > b) enforce effective constraints at each level of the hierarchy which
> >    are a restriction of the group requests considering its parent's
> >    effective constraints. Root group effective constraints are defined
> >    by the system wide interface.
> >    This mechanism allows each (non-root) level of the hierarchy to:
> >    - request whatever clamp values it would like to get
> >    - effectively get only up to the maximum amount allowed by its parent
> >
> > c) have higher priority than task-specific clamps, defined via
> >    sched_setattr(), thus allowing to control and restrict task requests
> >
> > Add two new attributes to the cpu controller to collect "requested"
> > clamp values. Allow that at each non-root level of the hierarchy.
> > Validate local consistency by enforcing util.min < util.max.
> > Keep it simple by do not caring now about "effective" values computation
> > and propagation along the hierarchy.
> >
> > Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Tejun Heo <tj@kernel.org>
> >
> > --
> > Changes in v8:
> >  Message-ID: <20190214154817.GN50184@devbig004.ftw2.facebook.com>
> >  - update changelog description for points b), c) and following paragraph
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  27 +++++
> >  init/Kconfig                            |  22 ++++
> >  kernel/sched/core.c                     | 142 +++++++++++++++++++++++-
> >  kernel/sched/sched.h                    |   6 +
> >  4 files changed, 196 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 7bf3f129c68b..47710a77f4fa 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -909,6 +909,12 @@ controller implements weight and absolute bandwidth limit models for
> >  normal scheduling policy and absolute bandwidth allocation model for
> >  realtime scheduling policy.
> >
> > +Cycles distribution is based, by default, on a temporal base and it
> > +does not account for the frequency at which tasks are executed.
> > +The (optional) utilization clamping support allows to enforce a minimum
> > +bandwidth, which should always be provided by a CPU, and a maximum bandwidth,
> > +which should never be exceeded by a CPU.
> > +
> >  WARNING: cgroup2 doesn't yet support control of realtime processes and
> >  the cpu controller can only be enabled when all RT processes are in
> >  the root cgroup.  Be aware that system management software may already
> > @@ -974,6 +980,27 @@ All time durations are in microseconds.
> >         Shows pressure stall information for CPU. See
> >         Documentation/accounting/psi.txt for details.
> >
> > +  cpu.util.min
> > +        A read-write single value file which exists on non-root cgroups.
> > +        The default is "0", i.e. no utilization boosting.
> > +
> > +        The requested minimum utilization in the range [0, 1024].
> > +
> > +        This interface allows reading and setting minimum utilization clamp
> > +        values similar to the sched_setattr(2). This minimum utilization
> > +        value is used to clamp the task specific minimum utilization clamp.
> > +
> > +  cpu.util.max
> > +        A read-write single value file which exists on non-root cgroups.
> > +        The default is "1024". i.e. no utilization capping
> > +
> > +        The requested maximum utilization in the range [0, 1024].
> > +
> > +        This interface allows reading and setting maximum utilization clamp
> > +        values similar to the sched_setattr(2). This maximum utilization
> > +        value is used to clamp the task specific maximum utilization clamp.
> > +
> > +
> >
> >  Memory
> >  ------
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 7439cbf4d02e..33006e8de996 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -877,6 +877,28 @@ config RT_GROUP_SCHED
> >
> >  endif #CGROUP_SCHED
> >
> > +config UCLAMP_TASK_GROUP
> > +       bool "Utilization clamping per group of tasks"
> > +       depends on CGROUP_SCHED
> > +       depends on UCLAMP_TASK
> > +       default n
> > +       help
> > +         This feature enables the scheduler to track the clamped utilization
> > +         of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
> > +
> > +         When this option is enabled, the user can specify a min and max
> > +         CPU bandwidth which is allowed for each single task in a group.
> > +         The max bandwidth allows to clamp the maximum frequency a task
> > +         can use, while the min bandwidth allows to define a minimum
> > +         frequency a task will always use.
> > +
> > +         When task group based utilization clamping is enabled, an eventually
> > +         specified task-specific clamp value is constrained by the cgroup
> > +         specified clamp value. Both minimum and maximum task clamping cannot
> > +         be bigger than the corresponding clamping defined at task group level.
> > +
> > +         If in doubt, say N.
> > +
> >  config CGROUP_PIDS
> >         bool "PIDs controller"
> >         help
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 71c9dd6487b1..aeed2dd315cc 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1130,8 +1130,12 @@ static void __init init_uclamp(void)
> >         /* System defaults allow max clamp values for both indexes */
> >         uc_max.value = uclamp_none(UCLAMP_MAX);
> >         uc_max.bucket_id = uclamp_bucket_id(uc_max.value);
> > -       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> > +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> >                 uclamp_default[clamp_id] = uc_max;
> > +#ifdef CONFIG_UCLAMP_TASK_GROUP
> > +               root_task_group.uclamp_req[clamp_id] = uc_max;
> > +#endif
> > +       }
> >  }
> >
> >  #else /* CONFIG_UCLAMP_TASK */
> > @@ -6720,6 +6724,19 @@ void ia64_set_curr_task(int cpu, struct task_struct *p)
> >  /* task_group_lock serializes the addition/removal of task groups */
> >  static DEFINE_SPINLOCK(task_group_lock);
> >
> > +static inline int alloc_uclamp_sched_group(struct task_group *tg,
> > +                                          struct task_group *parent)
> > +{
> > +#ifdef CONFIG_UCLAMP_TASK_GROUP
> > +       int clamp_id;
> > +
> > +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> > +               tg->uclamp_req[clamp_id] = parent->uclamp_req[clamp_id];
> > +#endif
> > +
> > +       return 1;
> 
> Looks like you never return anything else neither here nor in the
> following patches I think...

That's right, I just preferred to keep the same structure in the
callsite below...

> > +}
> > +
> >  static void sched_free_group(struct task_group *tg)
> >  {
> >         free_fair_sched_group(tg);
> > @@ -6743,6 +6760,9 @@ struct task_group *sched_create_group(struct task_group *parent)
> >         if (!alloc_rt_sched_group(tg, parent))
> >                 goto err;
> >
> > +       if (!alloc_uclamp_sched_group(tg, parent))
> > +               goto err;
> > +

            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

... under the assumption the compiler is smart enough to optimized that.

But perhaps  it's less confusing to just use void, will update in v9.

> >         return tg;
> >
> >  err:
-- 
#include <best/regards.h>

Patrick Bellasi
