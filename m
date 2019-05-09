Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475EA187A3
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 11:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfEIJXx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 05:23:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfEIJXx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 9 May 2019 05:23:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4768A374;
        Thu,  9 May 2019 02:23:53 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 528793F575;
        Thu,  9 May 2019 02:23:50 -0700 (PDT)
Date:   Thu, 9 May 2019 10:23:47 +0100
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
Subject: Re: [PATCH v8 06/16] sched/core: uclamp: Extend sched_setattr() to
 support utilization clamping
Message-ID: <20190509092347.2ny2kb74hrea323v@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-7-patrick.bellasi@arm.com>
 <20190508194107.GE32547@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508194107.GE32547@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 08-May 21:41, Peter Zijlstra wrote:
> On Tue, Apr 02, 2019 at 11:41:42AM +0100, Patrick Bellasi wrote:
> > @@ -1056,6 +1100,13 @@ static void __init init_uclamp(void)
> >  #else /* CONFIG_UCLAMP_TASK */
> >  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
> >  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
> > +static inline int uclamp_validate(struct task_struct *p,
> > +				  const struct sched_attr *attr)
> > +{
> > +	return -ENODEV;
> 
> Does that maybe want to be -EOPNOTSUPP ?

Suren propose ENOSYS for another similar case, i.e.
!CONFIG_UCLAMP_TASK definitions.

But EOPNOTSUPP seems more appropriate to me too.

-- 
#include <best/regards.h>

Patrick Bellasi
