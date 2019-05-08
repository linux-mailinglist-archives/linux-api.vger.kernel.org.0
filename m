Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E6F18069
	for <lists+linux-api@lfdr.de>; Wed,  8 May 2019 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfEHTVl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 May 2019 15:21:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52460 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEHTVl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 May 2019 15:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k86bIbJQYyAtCnJQ/9r7wNszrHqG9KBOaSii4mKHzlw=; b=SVVtCFeU3ylj97tn0HhXzkEUO
        dP3wY5ZEVrg1Zjk/SewUndpbZJYyav5FsXRHnS7xXFnDgaSHrrOPALGEH0HnZH27IVZ4MjclKV83K
        kYv0WFJK9t0WsOf3TWiv1X2PLSQAcK4TVbauzOsfdkdQV+iZVpsjqfUWb2sKdfWBKQbo7f4PSWjtE
        yE9LYpGpEjXMIkmNKu7AsHHUgx1NpdTsQE7PURNLqaoJ1YJ7obGfNwq4iRxY+Z0OLilehI0XD4L7y
        +J/SbWmLOvHCI7hUOp8F/GKZbEFe+KYnimnUCsbmfcrhB0w6qi2q5mFZ0gnC13mHsVq5hbW/ioHje
        100YUWVtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOS8D-0003hQ-6K; Wed, 08 May 2019 19:21:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 368AD98030A; Wed,  8 May 2019 21:21:31 +0200 (CEST)
Date:   Wed, 8 May 2019 21:21:31 +0200
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
Subject: Re: [PATCH v8 05/16] sched/core: Allow sched_setattr() to use the
 current policy
Message-ID: <20190508192131.GD32547@worktop.programming.kicks-ass.net>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-6-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402104153.25404-6-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 02, 2019 at 11:41:41AM +0100, Patrick Bellasi wrote:
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 22627f80063e..075c610adf45 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -40,6 +40,8 @@
>  /* SCHED_ISO: reserved but not implemented yet */
>  #define SCHED_IDLE		5
>  #define SCHED_DEADLINE		6
> +/* Must be the last entry: used to sanity check attr.policy values */
> +#define SCHED_POLICY_MAX	SCHED_DEADLINE

This is a wee bit sad to put in a uapi header; but yeah, where else :/

Another option would be something like:

enum {
	SCHED_NORMAL = 0,
	SCHED_FIFO = 1,
	SCHED_RR = 2,
	SCHED_BATCH = 3,
	/* SCHED_ISO = 4, reserved */
	SCHED_IDLE = 5,
	SCHED_DEADLINE = 6,
	SCHED_POLICY_NR
};

>  /* Can be ORed in to make sure the process is reverted back to SCHED_NORMAL on fork */
>  #define SCHED_RESET_ON_FORK     0x40000000
> @@ -50,9 +52,11 @@
>  #define SCHED_FLAG_RESET_ON_FORK	0x01
>  #define SCHED_FLAG_RECLAIM		0x02
>  #define SCHED_FLAG_DL_OVERRUN		0x04
> +#define SCHED_FLAG_KEEP_POLICY		0x08
>  
>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
>  			 SCHED_FLAG_RECLAIM		| \
> -			 SCHED_FLAG_DL_OVERRUN)
> +			 SCHED_FLAG_DL_OVERRUN		| \
> +			 SCHED_FLAG_KEEP_POLICY)
>  
>  #endif /* _UAPI_LINUX_SCHED_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d368ac26b8aa..20efb32e1a7e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4907,8 +4907,17 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	if (retval)
>  		return retval;
>  
> -	if ((int)attr.sched_policy < 0)
> +	/*
> +	 * A valid policy is always required from userspace, unless
> +	 * SCHED_FLAG_KEEP_POLICY is set and the current policy
> +	 * is enforced for this call.
> +	 */
> +	if (attr.sched_policy > SCHED_POLICY_MAX &&
> +	    !(attr.sched_flags & SCHED_FLAG_KEEP_POLICY)) {
>  		return -EINVAL;
> +	}

And given I just looked at those darn SCHED_* things, I now note the
above does 'funny' things when passed: attr.policy=4.

> +	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
> +		attr.sched_policy = SETPARAM_POLICY;
>  
>  	rcu_read_lock();
>  	retval = -ESRCH;
