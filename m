Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6E818C8D
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEIO7I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 10:59:08 -0400
Received: from foss.arm.com ([217.140.101.70]:43652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfEIO7I (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 9 May 2019 10:59:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 372C6374;
        Thu,  9 May 2019 07:59:07 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 402583F6C4;
        Thu,  9 May 2019 07:59:04 -0700 (PDT)
Date:   Thu, 9 May 2019 15:59:01 +0100
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
Subject: Re: [PATCH v8 05/16] sched/core: Allow sched_setattr() to use the
 current policy
Message-ID: <20190509145901.um7rrsslg7de4blf@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-6-patrick.bellasi@arm.com>
 <20190508192131.GD32547@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508192131.GD32547@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 08-May 21:21, Peter Zijlstra wrote:
> On Tue, Apr 02, 2019 at 11:41:41AM +0100, Patrick Bellasi wrote:
> > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > index 22627f80063e..075c610adf45 100644
> > --- a/include/uapi/linux/sched.h
> > +++ b/include/uapi/linux/sched.h
> > @@ -40,6 +40,8 @@
> >  /* SCHED_ISO: reserved but not implemented yet */
> >  #define SCHED_IDLE		5
> >  #define SCHED_DEADLINE		6
> > +/* Must be the last entry: used to sanity check attr.policy values */
> > +#define SCHED_POLICY_MAX	SCHED_DEADLINE
> 
> This is a wee bit sad to put in a uapi header; but yeah, where else :/
> 
> Another option would be something like:
> 
> enum {
> 	SCHED_NORMAL = 0,
> 	SCHED_FIFO = 1,
> 	SCHED_RR = 2,
> 	SCHED_BATCH = 3,
> 	/* SCHED_ISO = 4, reserved */
> 	SCHED_IDLE = 5,
> 	SCHED_DEADLINE = 6,
> 	SCHED_POLICY_NR
> };
> 
> >  /* Can be ORed in to make sure the process is reverted back to SCHED_NORMAL on fork */
> >  #define SCHED_RESET_ON_FORK     0x40000000
> > @@ -50,9 +52,11 @@
> >  #define SCHED_FLAG_RESET_ON_FORK	0x01
> >  #define SCHED_FLAG_RECLAIM		0x02
> >  #define SCHED_FLAG_DL_OVERRUN		0x04
> > +#define SCHED_FLAG_KEEP_POLICY		0x08
> >  
> >  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
> >  			 SCHED_FLAG_RECLAIM		| \
> > -			 SCHED_FLAG_DL_OVERRUN)
> > +			 SCHED_FLAG_DL_OVERRUN		| \
> > +			 SCHED_FLAG_KEEP_POLICY)
> >  
> >  #endif /* _UAPI_LINUX_SCHED_H */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index d368ac26b8aa..20efb32e1a7e 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4907,8 +4907,17 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
> >  	if (retval)
> >  		return retval;
> >  
> > -	if ((int)attr.sched_policy < 0)
> > +	/*
> > +	 * A valid policy is always required from userspace, unless
> > +	 * SCHED_FLAG_KEEP_POLICY is set and the current policy
> > +	 * is enforced for this call.
> > +	 */
> > +	if (attr.sched_policy > SCHED_POLICY_MAX &&
> > +	    !(attr.sched_flags & SCHED_FLAG_KEEP_POLICY)) {
> >  		return -EINVAL;
> > +	}
> 
> And given I just looked at those darn SCHED_* things, I now note the
> above does 'funny' things when passed: attr.policy=4.

Looking better at the code, I see now that we don't really need that
check anymore. Indeed, v8 introduced the support to change policy
specific and independent attributes at the same time. Thus:

1. the policy validity is already checked in:

     sched_setattr()
       sched_setattr()
         __sched_setscheduler()
            valid_policy()

   which knows how to deal with attr.policy=4 (i.e. -EINVAL)

2. when we pass in SCHED_FLAG_KEEP_POLICY we force the current policy
   by setting attr.sched_policy = SETPARAM_POLICY, so we just need a
   non negative policy being defined (usually 0 by default).

Thus, I'll remove the new #define and update the check above to be just:

	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
		attr.sched_policy = SETPARAM_POLICY;
	else if ((int)attr.sched_policy < 0)
		return -EINVAL;

which should cover the additional case:

   you can syscall with just SCHED_FLAG_KEEP_POLICY set if you want to
   change only cross-policy attributes.

> > +	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
> > +		attr.sched_policy = SETPARAM_POLICY;
> >  
> >  	rcu_read_lock();
> >  	retval = -ESRCH;

-- 
#include <best/regards.h>

Patrick Bellasi
