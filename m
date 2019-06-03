Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8D932F8D
	for <lists+linux-api@lfdr.de>; Mon,  3 Jun 2019 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfFCM1d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Jun 2019 08:27:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfFCM1d (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 3 Jun 2019 08:27:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1205B15A2;
        Mon,  3 Jun 2019 05:27:33 -0700 (PDT)
Received: from darkstar (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BE4A3F5AF;
        Mon,  3 Jun 2019 05:27:28 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:27:25 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v9 12/16] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190603122725.GB19426@darkstar>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531153545.GE374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 31-May 08:35, Tejun Heo wrote:

[...]

> > These attributes:
> > 
> > a) are available only for non-root nodes, both on default and legacy
> >    hierarchies, while system wide clamps are defined by a generic
> >    interface which does not depends on cgroups. This system wide
> >    interface enforces constraints on tasks in the root node.
> 
> I'd much prefer if they weren't entangled this way.  The system wide
> limits should work the same regardless of cgroup's existence.  cgroup
> can put further restriction on top but mere creation of cgroups with
> cpu controller enabled shouldn't take them out of the system-wide
> limits.

That's correct and what you describe matches, at least on its
intents, the current implementation provided in:

   [PATCH v9 14/16] sched/core: uclamp: Propagate system defaults to root group
   https://lore.kernel.org/lkml/20190515094459.10317-15-patrick.bellasi@arm.com/

System clamps always work the same way, independently from cgroups:
they define the upper bound for both min and max clamps.

When cgroups are not available, tasks specific clamps are always
capped by system clamps.

When cgroups are available, the root task group clamps are capped by
the system clamps, which affects its "effective" clamps and propagate
them down the hierarchy to child's "effective" clamps.
That's done in:

   [PATCH v9 13/16] sched/core: uclamp: Propagate parent clamps
   https://lore.kernel.org/lkml/20190515094459.10317-14-patrick.bellasi@arm.com/


Example 1
---------

Here is an example of system and groups clamps aggregation:

        	        min                        max
system defaults         400                        600

cg_name        	        min       min.effective	   max	     max.effective
 /uclamp               1024       400              500       500
 /uclamp/app              512       400	             512       500
 /uclamp/app/pid_smalls	    100	      100              200       200
 /uclamp/app/pid_bigs       500	      400              700       500


The ".effective" clamps are used to define the actual clamp value to
apply to tasks, according to the aggregation rules defined in:

   [PATCH v9 15/16] sched/core: uclamp: Use TG's clamps to restrict TASK's clamps
   https://lore.kernel.org/lkml/20190515094459.10317-16-patrick.bellasi@arm.com/

All the above, to me it means that:
 - cgroups are always capped by system clamps
 - cgroups can further restrict system clamps

Does that match with your view?

> > b) enforce effective constraints at each level of the hierarchy which
> >    are a restriction of the group requests considering its parent's
> >    effective constraints. Root group effective constraints are defined
> >    by the system wide interface.
> >    This mechanism allows each (non-root) level of the hierarchy to:
> >    - request whatever clamp values it would like to get
> >    - effectively get only up to the maximum amount allowed by its parent
> 
> I'll come back to this later.
> 
> > c) have higher priority than task-specific clamps, defined via
> >    sched_setattr(), thus allowing to control and restrict task requests
> 
> This sounds good.
> 
> > Add two new attributes to the cpu controller to collect "requested"
> > clamp values. Allow that at each non-root level of the hierarchy.
> > Validate local consistency by enforcing util.min < util.max.
> > Keep it simple by do not caring now about "effective" values computation
> > and propagation along the hierarchy.
> 
> So, the followings are what we're doing for hierarchical protection
> and limit propgations.
> 
> * Limits (high / max) default to max.  Protections (low / min) 0.  A
>   new cgroup by default doesn't constrain itself further and doesn't
>   have any protection.

Example 2
---------

Let say we have:

  /tg1:
        util_min=200 (as a protection)
        util_max=800 (as a limit)

the moment we create a subgroup /tg1/tg11, in v9 it is initialized
with the same limits _and protections_ of its father:

  /tg1/tg11:
        util_min=200 (protection inherited from /tg1)
        util_max=800 (limit inherited from /tg1)

Do you mean that we should have instead:

  /tg1/tg11:
        util_min=0   (no protection by default at creation time)
        util_max=800 (limit inherited from /tg1)


i.e. we need to reset the protection of a newly created subgroup?


> * A limit defines the upper ceiling for the subtree.  If an ancestor
>   has a limit of X, none of its descendants can have more than X.

That's correct, however we distinguish between "requested" and
"effective" values.


Example 3
---------

We can have:

cg_name        	        max       max.effective
 /uclamp/app            400                 400
 /uclamp/app/pid_bigs     500	              400


Which means that a subgroup can "request" a limit (max=500) higher
then its father (max=400), while still getting only up to what its
father allows (max.effective = 400).


Example 4
---------

Tracking the actual requested limit (max=500) it's useful to enforce
it once the father limit should be relaxed, for example we will have:

cg_name        	        max       max.effective
 /uclamp/app            600                 600
 /uclamp/app/pid_bigs     500	              500

where a subgroup gets not more than what it has been configured for.

This is the logic implemented by cpu_util_update_eff() in:

   [PATCH v9 13/16] sched/core: uclamp: Propagate parent clamps
   https://lore.kernel.org/lkml/20190515094459.10317-14-patrick.bellasi@arm.com/


> * A protection defines the upper ceiling of protections for the
>   subtree.  If an andester has a protection of X, none of its
>   descendants can have more protection than X.

Right, that's the current behavior in v9.

> Note that there's no way for an ancestor to enforce protection its
> descendants.  It can only allow them to claim some.  This is
> intentional as the other end of the spectrum is either descendants
> losing the ability to further distribute protections as they see fit.

Ok, that means I need to update in v10 the initialization of subgroups
min clamps to be none by default as discussed in the above Example 2,
right?

[...]

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
