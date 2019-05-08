Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 405211809B
	for <lists+linux-api@lfdr.de>; Wed,  8 May 2019 21:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfEHTlS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 May 2019 15:41:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52676 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfEHTlS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 May 2019 15:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WE7PWt8XQUOE1iIf+nqgocNKuCDwRmDW4pa8qW0IuZU=; b=wtLgATrII14gdyI/9X1YYN12B
        HTDrwNfjyilOXj7+MQJTZ91z7KGepszlLSmXSkvekXnAFWWjgBMdsfz6o62eUvIaU3YoUX86ybJAR
        39ZvGe66mPGJkxTmMmoXJlHbMiUKbvskQKYex7ba6mC59cpjSShQGuL+nSr/onCR/phYbk1lvUSTB
        ngsxzH3AGZSLy3leEdAkTb8rwoAs5p/eQe4NSPwyCArdEhxlLOPG2feLAiuE8ji25vxdUHM2WfCkw
        yDB7lEUWORWlsvjWWXYO7H19MhT/VJv9sG1NB28Os1FrtxoMsZ4gt6kN/i3IR3o3rcl2ylJEprwUR
        pGmZZH9+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOSRA-0003w1-Ul; Wed, 08 May 2019 19:41:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 358AF98030A; Wed,  8 May 2019 21:41:07 +0200 (CEST)
Date:   Wed, 8 May 2019 21:41:07 +0200
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
Subject: Re: [PATCH v8 06/16] sched/core: uclamp: Extend sched_setattr() to
 support utilization clamping
Message-ID: <20190508194107.GE32547@worktop.programming.kicks-ass.net>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-7-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402104153.25404-7-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 02, 2019 at 11:41:42AM +0100, Patrick Bellasi wrote:
> @@ -1056,6 +1100,13 @@ static void __init init_uclamp(void)
>  #else /* CONFIG_UCLAMP_TASK */
>  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
>  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
> +static inline int uclamp_validate(struct task_struct *p,
> +				  const struct sched_attr *attr)
> +{
> +	return -ENODEV;

Does that maybe want to be -EOPNOTSUPP ?

> +}
