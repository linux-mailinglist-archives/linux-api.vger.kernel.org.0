Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BABB12FA0F
	for <lists+linux-api@lfdr.de>; Thu, 30 May 2019 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfE3KPw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 May 2019 06:15:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3KPw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 May 2019 06:15:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C25D9374;
        Thu, 30 May 2019 03:15:51 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E2533F5AF;
        Thu, 30 May 2019 03:15:50 -0700 (PDT)
Date:   Thu, 30 May 2019 11:15:45 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v9 00/16] Add utilization clamping support
Message-ID: <20190530101545.gdznufqxeddl3rjp@e110439-lin>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Tejun,
this is just a gentle ping.

I had a chance to speak with Peter and Rafael at the last OSPM and
they both seems to be reasonably happy with the current status of the
core bits.

Thus, it would be very useful if you can jump into the discussion and
start the review of the cgroups integration bits.
You can find them in the last 5 patches of this series.

Luckily on the CGroup side, we don't start from ground zero.
Many aspects and pain points have been already discussed in the past
and have been addressed by the current version.

For you benefit, here is a list of previously discussed items:

 - A child can never obtain more than its ancestors
   https://lore.kernel.org/lkml/20180426185845.GO1911913@devbig577.frc2.facebook.com/

 - Enforcing consistency rules among parent-child groups
   https://lore.kernel.org/lkml/20180410200514.GA793541@devbig577.frc2.facebook.com/

 - Use "effective" attributes to enforce restrictions:
   https://lore.kernel.org/lkml/20180409222417.GK3126663@devbig577.frc2.facebook.com
   https://lore.kernel.org/lkml/20180410200514.GA793541@devbig577.frc2.facebook.com

 - Tasks on a subgroup can only be more boosted and/or capped,
   i.e. parent always set an upper bound on both max and min clamps
   https://lore.kernel.org/lkml/20180409222417.GK3126663@devbig577.frc2.facebook.com
   https://lore.kernel.org/lkml/20180410200514.GA793541@devbig577.frc2.facebook.com

 - Put everything at system level outside of the cgroup interface,
   i.e. no root group tunable attributes
   https://lore.kernel.org/lkml/20180409222417.GK3126663@devbig577.frc2.facebook.com/

 - CGroups don't need any hierarchical behaviors on their own
   https://lore.kernel.org/lkml/20180723153040.GG1934745@devbig577.frc2.facebook.com/

Looking forward to get some more feedbacks from you.

Cheers,
Patrick

On 15-May 10:44, Patrick Bellasi wrote:
> Hi all, this is a respin of:
> 
>   https://lore.kernel.org/lkml/20190402104153.25404-1-patrick.bellasi@arm.com/
> 
> which includes the following main changes:
> 
>  - fix "max local update" by moving into uclamp_rq_inc_id()
>  - use for_each_clamp_id() and uclamp_se_set() to make code less fragile
>  - rename sysfs node: s/sched_uclamp_util_{min,max}/sched_util_clamp_{min,max}/
>  - removed not used uclamp_eff_bucket_id()
>  - move uclamp_bucket_base_value() definition into patch using it
>  - get rid of not necessary SCHED_POLICY_MAX define
>  - update sched_setattr() syscall to just force the current policy on
>    SCHED_FLAG_KEEP_POLICY
>  - return EOPNOTSUPP from uclamp_validate() on !CONFIG_UCLAMP_TASK
>  - make alloc_uclamp_sched_group() a void function
>  - simplify bits_per() definition
>  - add rq's lockdep assert to uclamp_rq_{inc,dec}_id()
> 
> With the above, I think we captured all the major inputs from Peter [1].
> Thus, this v9 is likely the right version to unlock Tejun's review [2] on the
> remaining cgroup related bits, i.e. patches [12-16].
> 
> Cheers Patrick
> 
> 
> Series Organization
> ===================
> 
> The series is organized into these main sections:
> 
>  - Patches [01-07]: Per task (primary) API
>  - Patches [08-09]: Schedutil integration for FAIR and RT tasks
>  - Patches [10-11]: Integration with EAS's energy_compute()
>  - Patches [12-16]: Per task group (secondary) API
> 
> It is based on today's tip/sched/core and the full tree is available here:
> 
>    git://linux-arm.org/linux-pb.git   lkml/utilclamp_v9
>    http://www.linux-arm.org/git?p=linux-pb.git;a=shortlog;h=refs/heads/lkml/utilclamp_v9
> 
> 
> Newcomer's Short Abstract
> =========================
> 
> The Linux scheduler tracks a "utilization" signal for each scheduling entity
> (SE), e.g. tasks, to know how much CPU time they use. This signal allows the
> scheduler to know how "big" a task is and, in principle, it can support
> advanced task placement strategies by selecting the best CPU to run a task.
> Some of these strategies are represented by the Energy Aware Scheduler [3].
> 
> When the schedutil cpufreq governor is in use, the utilization signal allows
> the Linux scheduler to also drive frequency selection. The CPU utilization
> signal, which represents the aggregated utilization of tasks scheduled on that
> CPU, is used to select the frequency which best fits the workload generated by
> the tasks.
> 
> The current translation of utilization values into a frequency selection is
> simple: we go to max for RT tasks or to the minimum frequency which can
> accommodate the utilization of DL+FAIR tasks.
> However, utilization values by themselves cannot convey the desired
> power/performance behaviors of each task as intended by user-space.
> As such they are not ideally suited for task placement decisions.
> 
> Task placement and frequency selection policies in the kernel can be improved
> by taking into consideration hints coming from authorized user-space elements,
> like for example the Android middleware or more generally any "System
> Management Software" (SMS) framework.
> 
> Utilization clamping is a mechanism which allows to "clamp" (i.e. filter) the
> utilization generated by RT and FAIR tasks within a range defined by user-space.
> The clamped utilization value can then be used, for example, to enforce a
> minimum and/or maximum frequency depending on which tasks are active on a CPU.
> 
> The main use-cases for utilization clamping are:
> 
>  - boosting: better interactive response for small tasks which
>    are affecting the user experience.
> 
>    Consider for example the case of a small control thread for an external
>    accelerator (e.g. GPU, DSP, other devices). Here, from the task utilization
>    the scheduler does not have a complete view of what the task's requirements
>    are and, if it's a small utilization task, it keeps selecting a more energy
>    efficient CPU, with smaller capacity and lower frequency, thus negatively
>    impacting the overall time required to complete task activations.
> 
>  - capping: increase energy efficiency for background tasks not affecting the
>    user experience.
> 
>    Since running on a lower capacity CPU at a lower frequency is more energy
>    efficient, when the completion time is not a main goal, then capping the
>    utilization considered for certain (maybe big) tasks can have positive
>    effects, both on energy consumption and thermal headroom.
>    This feature allows also to make RT tasks more energy friendly on mobile
>    systems where running them on high capacity CPUs and at the maximum
>    frequency is not required.
> 
> From these two use-cases, it's worth noticing that frequency selection
> biasing, introduced by patches 9 and 10 of this series, is just one possible
> usage of utilization clamping. Another compelling extension of utilization
> clamping is in helping the scheduler in making tasks placement decisions.
> 
> Utilization is (also) a task specific property the scheduler uses to know
> how much CPU bandwidth a task requires, at least as long as there is idle time.
> Thus, the utilization clamp values, defined either per-task or per-task_group,
> can represent tasks to the scheduler as being bigger (or smaller) than what
> they actually are.
> 
> Utilization clamping thus enables interesting additional optimizations, for
> example on asymmetric capacity systems like Arm big.LITTLE and DynamIQ CPUs,
> where:
> 
>  - boosting: try to run small/foreground tasks on higher-capacity CPUs to
>    complete them faster despite being less energy efficient.
> 
>  - capping: try to run big/background tasks on low-capacity CPUs to save power
>    and thermal headroom for more important tasks
> 
> This series does not present this additional usage of utilization clamping but
> it's an integral part of the EAS feature set, where [4] is one of its main
> components.
> 
> Android kernels use SchedTune, a solution similar to utilization clamping, to
> bias both 'frequency selection' and 'task placement'. This series provides the
> foundation to add similar features to mainline while focusing, for the
> time being, just on schedutil integration.
> 
> 
> References
> ==========
> 
> [1] Message-ID: <20190509130215.GV2623@hirez.programming.kicks-ass.net>
>     https://lore.kernel.org/lkml/20190509130215.GV2623@hirez.programming.kicks-ass.net/
> 
> [2] Message-ID: <20180911162827.GJ1100574@devbig004.ftw2.facebook.com>
>     https://lore.kernel.org/lkml/20180911162827.GJ1100574@devbig004.ftw2.facebook.com/
> 
> [3] Energy Aware Scheduling
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/scheduler/sched-energy.txt?h=v5.1
> 
> [4] Expressing per-task/per-cgroup performance hints
>     Linux Plumbers Conference 2018
>     https://linuxplumbersconf.org/event/2/contributions/128/
> 
> 
> Patrick Bellasi (16):
>   sched/core: uclamp: Add CPU's clamp buckets refcounting
>   sched/core: uclamp: Add bucket local max tracking
>   sched/core: uclamp: Enforce last task's UCLAMP_MAX
>   sched/core: uclamp: Add system default clamps
>   sched/core: Allow sched_setattr() to use the current policy
>   sched/core: uclamp: Extend sched_setattr() to support utilization
>     clamping
>   sched/core: uclamp: Reset uclamp values on RESET_ON_FORK
>   sched/core: uclamp: Set default clamps for RT tasks
>   sched/cpufreq: uclamp: Add clamps for FAIR and RT tasks
>   sched/core: uclamp: Add uclamp_util_with()
>   sched/fair: uclamp: Add uclamp support to energy_compute()
>   sched/core: uclamp: Extend CPU's cgroup controller
>   sched/core: uclamp: Propagate parent clamps
>   sched/core: uclamp: Propagate system defaults to root group
>   sched/core: uclamp: Use TG's clamps to restrict TASK's clamps
>   sched/core: uclamp: Update CPU's refcount on TG's clamp changes
> 
>  Documentation/admin-guide/cgroup-v2.rst |  46 ++
>  include/linux/log2.h                    |  34 ++
>  include/linux/sched.h                   |  58 ++
>  include/linux/sched/sysctl.h            |  11 +
>  include/linux/sched/topology.h          |   6 -
>  include/uapi/linux/sched.h              |  14 +-
>  include/uapi/linux/sched/types.h        |  66 ++-
>  init/Kconfig                            |  75 +++
>  kernel/sched/core.c                     | 754 +++++++++++++++++++++++-
>  kernel/sched/cpufreq_schedutil.c        |  22 +-
>  kernel/sched/fair.c                     |  44 +-
>  kernel/sched/rt.c                       |   4 +
>  kernel/sched/sched.h                    | 123 +++-
>  kernel/sysctl.c                         |  16 +
>  14 files changed, 1229 insertions(+), 44 deletions(-)
> 
> -- 
> 2.21.0
> 

-- 
#include <best/regards.h>

Patrick Bellasi
