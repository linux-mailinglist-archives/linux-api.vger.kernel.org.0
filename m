Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787D735F69
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2019 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfFEOkA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 10:40:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32884 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfFEOkA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 5 Jun 2019 10:40:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 796AA374;
        Wed,  5 Jun 2019 07:39:59 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8515E3F246;
        Wed,  5 Jun 2019 07:39:56 -0700 (PDT)
Date:   Wed, 5 Jun 2019 15:39:50 +0100
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
Message-ID: <20190605143805.olk2ta5p2jnd4mjt@e110439-lin>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
 <20190603122725.GB19426@darkstar>
 <20190605140324.GL374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605140324.GL374014@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 05-Jun 07:03, Tejun Heo wrote:
> Hello,

Hi!

> On Mon, Jun 03, 2019 at 01:27:25PM +0100, Patrick Bellasi wrote:
> > All the above, to me it means that:
> >  - cgroups are always capped by system clamps
> >  - cgroups can further restrict system clamps
> > 
> > Does that match with your view?
> 
> Yeah, as long as what's defined at system level clamps everything in
> the system whether they're in cgroups or not, it's all good.

Right, then we are good with v9 on this point.

> > > * Limits (high / max) default to max.  Protections (low / min) 0.  A
> > >   new cgroup by default doesn't constrain itself further and doesn't
> > >   have any protection.
> > 
> > Example 2
> > ---------
> > 
> > Let say we have:
> > 
> >   /tg1:
> >         util_min=200 (as a protection)
> >         util_max=800 (as a limit)
> > 
> > the moment we create a subgroup /tg1/tg11, in v9 it is initialized
> > with the same limits _and protections_ of its father:
> > 
> >   /tg1/tg11:
> >         util_min=200 (protection inherited from /tg1)
> >         util_max=800 (limit inherited from /tg1)
> > 
> > Do you mean that we should have instead:
> > 
> >   /tg1/tg11:
> >         util_min=0   (no protection by default at creation time)
> >         util_max=800 (limit inherited from /tg1)
> > 
> > 
> > i.e. we need to reset the protection of a newly created subgroup?
> 
> The default value for limits should be max, protections 0.  Don't
> inherit config values from the parent.  That gets confusing super fast
> because when the parent config is set and each child is created plays
> into the overall configuration.  Hierarchical confinements should
> always be enforced and a new cgroup should always start afresh in
> terms of its own configuration.

Got it, so in the example above we will create:

   /tg1/tg11:
         util_min=0    (no requested protection by default at creation time)
         util_max=1024 (no requests limit by default at creation time)

That's it for the "requested" values side, while the "effective"
values are enforced by the hierarchical confinement rules since
creation time.
Which means we will enforce the effective values as:

   /tg1/tg11:

         util_min.effective=0
            i.e. keep the child protection since smaller than parent

         util_max.effective=800
            i.e. keep parent limit since stricter than child

Please shout if I got it wrong, otherwise I'll update v10 to
implement the above logic.

> > > * A limit defines the upper ceiling for the subtree.  If an ancestor
> > >   has a limit of X, none of its descendants can have more than X.
> > 
> > That's correct, however we distinguish between "requested" and
> > "effective" values.
> 
> Sure, all property propagating controllers should.

Right.

> > > Note that there's no way for an ancestor to enforce protection its
> > > descendants.  It can only allow them to claim some.  This is
> > > intentional as the other end of the spectrum is either descendants
> > > losing the ability to further distribute protections as they see fit.
> > 
> > Ok, that means I need to update in v10 the initialization of subgroups
> > min clamps to be none by default as discussed in the above Example 2,
> > right?
> 
> Yeah and max to max.

Right, I've got it now.


> Thanks.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
