Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEFDF18A0B
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 14:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEIMvP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 08:51:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfEIMvO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 May 2019 08:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t0R1VUJJpsY1eusaHX/1WZb8mvW8M0k/0c+bY4+19pk=; b=L/7bDbphkzq4BzbOgQs8HTsnG
        0GBm3lkiGp7zTZbYCswxeJDVmOkma4KoRHropEotGvYjQmCM0HeoVx2CLF9Bb7pwFjqA/STo9r6ae
        /Itil4rq6feK6pSNYAe0ubtxQrThrLnz98WNVgF2lUIOWdCAjpkLvvfStCl7pKS4bPfYi5EvfPJgk
        UaSxkDOVGOK3JEP4VGPEBhjIc7HiFg6PAHRDbJ8e2YZnDrT65kdaER1wIYeYvv4FwjUVm+WGiNyge
        oHkL+lG6z7Az5XHSODakI72uVu/fzkynhCFKY/eAWGpcqSoxijxkf2ZvIk50xB/LOQiP6wYSfCZQi
        jgH3gWQkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOiVu-0003BH-Qz; Thu, 09 May 2019 12:51:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 940FB22158200; Thu,  9 May 2019 14:51:05 +0200 (CEST)
Date:   Thu, 9 May 2019 14:51:05 +0200
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
Subject: Re: [PATCH v8 11/16] sched/fair: uclamp: Add uclamp support to
 energy_compute()
Message-ID: <20190509125105.GU2623@hirez.programming.kicks-ass.net>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-12-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402104153.25404-12-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 02, 2019 at 11:41:47AM +0100, Patrick Bellasi wrote:
> @@ -6484,11 +6494,29 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  		 * it will not appear in its pd list and will not be accounted
>  		 * by compute_energy().
>  		 */
> -		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
> -			util = cpu_util_next(cpu, p, dst_cpu);
> -			util = schedutil_energy_util(cpu, util);
> -			max_util = max(util, max_util);
> -			sum_util += util;
> +		for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
> +			util_cfs = cpu_util_next(cpu, p, dst_cpu);
> +
> +			/*
> +			 * Busy time computation: utilization clamping is not
> +			 * required since the ratio (sum_util / cpu_capacity)
> +			 * is already enough to scale the EM reported power
> +			 * consumption at the (eventually clamped) cpu_capacity.
> +			 */
> +			sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
> +						       ENERGY_UTIL, NULL);
> +
> +			/*
> +			 * Performance domain frequency: utilization clamping
> +			 * must be considered since it affects the selection
> +			 * of the performance domain frequency.
> +			 * NOTE: in case RT tasks are running, by default the
> +			 * FREQUENCY_UTIL's utilization can be max OPP.
> +			 */
> +			tsk = cpu == dst_cpu ? p : NULL;
> +			cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
> +						      FREQUENCY_UTIL, tsk);
> +			max_util = max(max_util, cpu_util);
>  		}

That's a bit unfortunate; having to do both variants here, but I see
why. Nothing to be done about it I suppose.
