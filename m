Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19951620B
	for <lists+linux-api@lfdr.de>; Tue,  7 May 2019 12:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEGKiv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 May 2019 06:38:51 -0400
Received: from foss.arm.com ([217.140.101.70]:49674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfEGKiv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 May 2019 06:38:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B637374;
        Tue,  7 May 2019 03:38:50 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A21333F5AF;
        Tue,  7 May 2019 03:38:47 -0700 (PDT)
Date:   Tue, 7 May 2019 11:38:45 +0100
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
Subject: Re: [PATCH v8 04/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190507103845.tejg55wfsu3l3jwh@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-5-patrick.bellasi@arm.com>
 <CAJuCfpGcN-CWCoo16_xKzohUbBTCY3W5D1E8izhA8wtEjCtF+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGcN-CWCoo16_xKzohUbBTCY3W5D1E8izhA8wtEjCtF+Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 17-Apr 17:51, Suren Baghdasaryan wrote:
> On Tue, Apr 2, 2019 at 3:42 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:

[...]

> > +/*
> > + * The effective clamp bucket index of a task depends on, by increasing
> > + * priority:
> > + * - the task specific clamp value, when explicitly requested from userspace
> > + * - the system default clamp value, defined by the sysadmin
> > + */
> > +static inline struct uclamp_se
> > +uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
> > +{
> > +       struct uclamp_se uc_req = p->uclamp_req[clamp_id];
> > +       struct uclamp_se uc_max = uclamp_default[clamp_id];
> > +
> > +       /* System default restrictions always apply */
> > +       if (unlikely(uc_req.value > uc_max.value))
> > +               return uc_max;
> > +
> > +       return uc_req;
> > +}
> > +
> > +static inline unsigned int
> > +uclamp_eff_bucket_id(struct task_struct *p, unsigned int clamp_id)
> 
> This function is not used anywhere AFAIKT.

Right, this is the dual of uclamp_eff_value() but, since we don't
actually use it in the corrent code, let's remove it and keep only the
latter.

> uclamp_eff_bucket_id() and
> uclamp_eff_value() look very similar, maybe they can be combined into
> one function returning struct uclamp_se?

I would prefer not since at the callsites of uclamp_eff_value() we
actually need just the value.

> > +{
> > +       struct uclamp_se uc_eff;
> > +
> > +       /* Task currently refcounted: use back-annotated (effective) bucket */
> > +       if (p->uclamp[clamp_id].active)
> > +               return p->uclamp[clamp_id].bucket_id;
> > +
> > +       uc_eff = uclamp_eff_get(p, clamp_id);
> > +
> > +       return uc_eff.bucket_id;
> > +}
> > +
> > +unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
> > +{
> > +       struct uclamp_se uc_eff;
> > +
> > +       /* Task currently refcounted: use back-annotated (effective) value */
> > +       if (p->uclamp[clamp_id].active)
> > +               return p->uclamp[clamp_id].value;
> > +
> > +       uc_eff = uclamp_eff_get(p, clamp_id);
> > +
> > +       return uc_eff.value;
> > +}
> > +

-- 
#include <best/regards.h>

Patrick Bellasi
