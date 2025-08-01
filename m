Return-Path: <linux-api+bounces-4277-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4866B18200
	for <lists+linux-api@lfdr.de>; Fri,  1 Aug 2025 14:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EDB4E78CA
	for <lists+linux-api@lfdr.de>; Fri,  1 Aug 2025 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905372494F0;
	Fri,  1 Aug 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfJxHhi0"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C12475F2
	for <linux-api@vger.kernel.org>; Fri,  1 Aug 2025 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754052807; cv=none; b=UVMIZJUg0dVOnW6bnSutbB6j9mzTGyCt+vZcFVml0boq8cRZ/CH0H2b+FXXgDc/8wyxBmOJ3wspn+qZJTmNdOzVw31IXXAb+l3nuuuFIjG+efjq4QrhsP+Qu+eUdAbS21LHv/CuDa3/7fCi+8XV726Cx2BaMt1yl8fkKdBy2tKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754052807; c=relaxed/simple;
	bh=XtWgiIWMoJllV9e1y806U0puc+WrmW9T2bEvClGfLOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnX3DZJ2KdWQ3lV9TtgpELVFwMZsDmeIF6GeAMg4pXWPTebfXG0chfSTNGieS6xf19pUlm9kayoqsZSBp/vfFUqClk0aBhUbrUZgN7WY3OFGOQkD0zM8xR0LcVCQJI1hmI0Gq9N84yMJR25JcYWrrbNVgC1R2MiSbfxOMyIWN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfJxHhi0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754052804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ToMkPcgkrGjaTE7xYaILR6bhh6LbYVJ5c41vC3bW6kU=;
	b=PfJxHhi0OjKNLFw57XFNUFJfc3iJrOpVQjMAV1/MpKYv65IF0ikoyvtJWE+33ZivITC0q4
	4wpyIPMbEU0Ylkza5TArI6969f/I+RAKTRYTjOEe47se6XsfDtpQL/m7NFPjRjJQLeJIkN
	8Oej92Z8GDKnvn7PiLD6ZaR+8BUG4bI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-kxTbSELUPZOgHLlfp24BLw-1; Fri, 01 Aug 2025 08:53:22 -0400
X-MC-Unique: kxTbSELUPZOgHLlfp24BLw-1
X-Mimecast-MFC-AGG-ID: kxTbSELUPZOgHLlfp24BLw_1754052802
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7851a096fso1123779f8f.1
        for <linux-api@vger.kernel.org>; Fri, 01 Aug 2025 05:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754052802; x=1754657602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToMkPcgkrGjaTE7xYaILR6bhh6LbYVJ5c41vC3bW6kU=;
        b=u25NIXBtoQ/PL0ZY/GAm9hsfnzeKVMD+1Wk0O6lFE9STi0ig5/WVZme+clPcQgHmKa
         PVBzQJIW0Z1Gww0LLdYZS+XSDv04qXftb++zUelbrG23063qEgqXwMY9zTYskH4set0Q
         Yz/9FS7ZmMaEoJuBzPsEGiU3pMH93KwBh2yvhFZ8oO8PPCVFe58VhVupMs6VwVKKFDr7
         iguPBQQFzmTUJ1BuPp4+yLpThG37LwrdkGHHPP75X9mb1TYk24Y5hLhY+J+5899lzgM6
         vCLHFKpfyG/vVk6d+sxyFEr+bacpCaTEmUEkuhMNAczWIDANyw7RKQPnMFhKD2Pp+XBq
         oPmg==
X-Forwarded-Encrypted: i=1; AJvYcCWzr3Gxj3TrEU6GCIoXBB44vFqXZyFBpqlJFHHjMZjWjibWAPRgCsl3UG1cHu1N268dKUhTvLynVl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq9/k8P3oxz7CvBues6P6qbPKl2srTPllZyEth7Yhc3OZsLyHg
	bbzWj8exfCF6GRdxcUUl8iGy7nuOSe4iqTT/TN8d56FHn//oSN9uVpPVpDy6FDMNLyZ4nZ7ghOP
	mZa63mrvJHTznQLzZc0ph7EALxdhr5IJ0fvoQ0PRyxewWbh1y5FRgZyJE8Nk7JA==
X-Gm-Gg: ASbGnctO3iiMchY3lVt1DEMPyFhtwwG04U6lzVUxs8KyUpCtyQxOgjG+fA6k84yxRRL
	VyiCWkEwHlaEbCsMhyn/dvAKGzYZEiok+JyzFF2CxYgGVTwOhxWkz5Er1uxbtikN4TJCqq4d6U5
	BchaUCsbNvw/0Tq4l1pxadOZLh7SjWNKU6igZWM8iQLpXVV0YlYfOZxgE5IhX6DLgjOk8WMTTQe
	j5j3kdRuTlgcJVk8imp/j9Amp9IPjWZ1ShqKdtsiQR63bJM5cFw+wgS/4cJhYfjb4u+ek+PUbZ3
	X8PI9siH/UoEnOadZCp8mSVc4KdG3IqlD3qn/wPNZnkB+h+OFe0DHf8h+tJ7phGroQPTYw==
X-Received: by 2002:a05:6000:25c8:b0:3b6:1e6:c9fb with SMTP id ffacd0b85a97d-3b8d343ae4dmr2383016f8f.11.1754052801528;
        Fri, 01 Aug 2025 05:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg2ppPHTB4DYsb+w8Pi4WsTxsBWXyjNMNbInSaCwaEGMEhkeo7Iy3wCsgRDqHOwV/P+Dk9Bw==
X-Received: by 2002:a05:6000:25c8:b0:3b6:1e6:c9fb with SMTP id ffacd0b85a97d-3b8d343ae4dmr2382992f8f.11.1754052801028;
        Fri, 01 Aug 2025 05:53:21 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.46.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaed4sm98611525e9.27.2025.08.01.05.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 05:53:20 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:53:18 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [PATCH] sched/deadline: sched_getattr(...flags=1) returns the
 runtime left and abs deadline for DEADLINE tasks
Message-ID: <aIy4vmuBh9QemI63@jlelli-thinkpadt14gen4.remote.csb>
References: <20250715164148.1151620-1-tommaso.cucinotta@santannapisa.it>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715164148.1151620-1-tommaso.cucinotta@santannapisa.it>

Hi Tommaso,

On 15/07/25 18:39, Tommaso Cucinotta wrote:
> The SCHED_DEADLINE scheduler allows reading the statically configured
> run-time, deadline, and period parameters through the sched_getattr()
> system call. However, there is no immediate way to access, from user space,
> the current parameters used within the scheduler: the instantaneous runtime
> left in the current cycle, as well as the current absolute deadline.
> 
> The `flags' sched_getattr() parameter, so far mandated to contain zero,
> now supports the SCHED_GETATTR_FLAG_DL_DYNAMIC=1 flag, to request
> retrieval of the leftover runtime and absolute deadline, converted to a
> CLOCK_MONOTONIC reference, instead of the statically configured parameters.
> 
> This feature is useful for adaptive SCHED_DEADLINE tasks that need to
> modify their behavior depending on whether or not there is enough runtime
> left in the current period, and/or what is the current absolute deadline.
> 
> Notes:
> - before returning the instantaneous parameters, the runtime is updated;
> - the abs deadline is returned shifted from rq_clock() to ktime_get_ns(),
>   in CLOCK_MONOTONIC reference; this causes multiple invocations from the
>   same period to return values that may differ for a few ns (showing some
>   small drift), albeit the deadline doesn't move, in rq_clock() reference;
> - the abs deadline value returned to user-space, as unsigned 64-bit value,
>   can represent nearly 585 years since boot time;
> - setting flags=0 provides the old behavior (retrieve static parameters).

As we discussed this offline before your submission you know that I was
already on board with the idea, so I would really like to hear what
Peter and others think about this.

Still a few comments below.

$SUBJECT can maybe simply be "sched/deadline: Add reporting of remaining
time/abs deadline to sched_getattr".

> See also the notes from discussion held at OSPM 2025 on the topic
> "Making user space aware of current deadline-scheduler parameters":
> https://lwn.net/Articles/1022054/

I would probably remove the link from the changelog as it might
disappear/change in the future.

> Signed-off-by: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
> ---
>  include/uapi/linux/sched.h |  3 +++
>  kernel/sched/deadline.c    | 18 +++++++++++++++---
>  kernel/sched/sched.h       |  2 +-
>  kernel/sched/syscalls.c    | 16 +++++++++++-----
>  4 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 359a14cc..52b69ce8 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -146,4 +146,7 @@ struct clone_args {
>  			 SCHED_FLAG_KEEP_ALL		| \
>  			 SCHED_FLAG_UTIL_CLAMP)
>  
> +/* Only for sched_getattr() own flag param, if task is SCHED_DEADLINE */
> +#define SCHED_GETATTR_FLAG_DL_DYNAMIC	0x01
> +
>  #endif /* _UAPI_LINUX_SCHED_H */
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 9c7d9528..1b5cd7fa 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3290,13 +3290,25 @@ void __setparam_dl(struct task_struct *p, const struct sched_attr *attr)
>  	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
>  }
>  
> -void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
> +void __getparam_dl(struct task_struct *p, struct sched_attr *attr, unsigned int flags)
>  {
>  	struct sched_dl_entity *dl_se = &p->dl;
> +	struct rq *rq = task_rq(p);
> +	u64 adj_deadline;
>  
>  	attr->sched_priority = p->rt_priority;
> -	attr->sched_runtime = dl_se->dl_runtime;
> -	attr->sched_deadline = dl_se->dl_deadline;
> +	if (flags & SCHED_GETATTR_FLAG_DL_DYNAMIC) {
> +		guard(raw_spinlock_irq)(&rq->__lock);
> +		update_rq_clock(rq);
> +		update_curr_dl(rq);

I p is not current maybe we don't need to call update_curr_dl() as p
will still have sensible dynamic parameters updated last time it
blocked?

Also, even though this is superuser stuff and all, mildly fear this
could be used as a DOS attack vector? Do we want to be super defensive
and add some kind of rate limiting?

> +
> +		attr->sched_runtime = dl_se->runtime;
> +		adj_deadline = dl_se->deadline - rq_clock(rq) + ktime_get_ns();
> +		attr->sched_deadline = adj_deadline;
> +	} else {
> +		attr->sched_runtime = dl_se->dl_runtime;
> +		attr->sched_deadline = dl_se->dl_deadline;
> +	}
>  	attr->sched_period = dl_se->dl_period;
>  	attr->sched_flags &= ~SCHED_DL_FLAGS;
>  	attr->sched_flags |= dl_se->flags;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3058fb62..f69bf019 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -353,7 +353,7 @@ extern int  sched_dl_global_validate(void);
>  extern void sched_dl_do_global(void);
>  extern int  sched_dl_overflow(struct task_struct *p, int policy, const struct sched_attr *attr);
>  extern void __setparam_dl(struct task_struct *p, const struct sched_attr *attr);
> -extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
> +extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr, unsigned int flags);
>  extern bool __checkparam_dl(const struct sched_attr *attr);
>  extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
>  extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 77ae87f3..c80b3568 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -928,10 +928,10 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
>  	return -E2BIG;
>  }
>  
> -static void get_params(struct task_struct *p, struct sched_attr *attr)
> +static void get_params(struct task_struct *p, struct sched_attr *attr, unsigned int flags)
>  {
>  	if (task_has_dl_policy(p)) {
> -		__getparam_dl(p, attr);
> +		__getparam_dl(p, attr, flags);
>  	} else if (task_has_rt_policy(p)) {
>  		attr->sched_priority = p->rt_priority;
>  	} else {
> @@ -997,7 +997,7 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
>  		return -ESRCH;
>  
>  	if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
> -		get_params(p, &attr);
> +		get_params(p, &attr, 0);
>  
>  	return sched_setattr(p, &attr);
>  }
> @@ -1082,7 +1082,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	int retval;
>  
>  	if (unlikely(!uattr || pid < 0 || usize > PAGE_SIZE ||
> -		      usize < SCHED_ATTR_SIZE_VER0 || flags))
> +		     usize < SCHED_ATTR_SIZE_VER0))
>  		return -EINVAL;
>  
>  	scoped_guard (rcu) {
> @@ -1090,6 +1090,12 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  		if (!p)
>  			return -ESRCH;
>  
> +		if (flags) {
> +			if (!task_has_dl_policy(p)
> +			    || flags != SCHED_GETATTR_FLAG_DL_DYNAMIC)

Nit pick. Formatting usually has line break after '||'.

> +				return -EINVAL;
> +		}
> +

Thanks!
Juri


