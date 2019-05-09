Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1157187A8
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 11:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfEIJYs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 05:24:48 -0400
Received: from foss.arm.com ([217.140.101.70]:35686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfEIJYs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 9 May 2019 05:24:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 779D1374;
        Thu,  9 May 2019 02:24:47 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 835003F575;
        Thu,  9 May 2019 02:24:44 -0700 (PDT)
Date:   Thu, 9 May 2019 10:24:42 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
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
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v8 06/16] sched/core: uclamp: Extend sched_setattr() to
 support utilization clamping
Message-ID: <20190509092442.3avaelrsxd2l5dfl@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-7-patrick.bellasi@arm.com>
 <CAJuCfpH3htcr3xB_Y4nr7HXCdQd1hOdOAXbtZJB1SOt7Of_qbw@mail.gmail.com>
 <20190507111347.4ivnjwbymsf7i3e6@e110439-lin>
 <20190508194439.GF32547@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508194439.GF32547@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 08-May 21:44, Peter Zijlstra wrote:
> On Tue, May 07, 2019 at 12:13:47PM +0100, Patrick Bellasi wrote:
> > On 17-Apr 15:26, Suren Baghdasaryan wrote:
> > > On Tue, Apr 2, 2019 at 3:42 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> 
> > > > @@ -1056,6 +1100,13 @@ static void __init init_uclamp(void)
> > > >  #else /* CONFIG_UCLAMP_TASK */
> > > >  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
> > > >  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
> > > > +static inline int uclamp_validate(struct task_struct *p,
> > > > +                                 const struct sched_attr *attr)
> > > > +{
> > > > +       return -ENODEV;
> > > 
> > > ENOSYS might be more appropriate?
> > 
> > Yep, agree, thanks!
> 
> No, -ENOSYS (see the comment) is special in that it indicates the whole
> system call is unavailable; that is most certainly not the case!

Yep, noted. Thanks.

-- 
#include <best/regards.h>

Patrick Bellasi
