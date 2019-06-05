Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D070835FD8
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2019 17:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfFEPGh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 11:06:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33090 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbfFEPGg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 5 Jun 2019 11:06:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C82B374;
        Wed,  5 Jun 2019 08:06:36 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A32C3F246;
        Wed,  5 Jun 2019 08:06:33 -0700 (PDT)
Date:   Wed, 5 Jun 2019 16:06:30 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20190605150630.vh5pyfpd6y3mfcaa@e110439-lin>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
 <20190603122929.GC19426@darkstar>
 <20190605140943.GM374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605140943.GM374014@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 05-Jun 07:09, Tejun Heo wrote:
> Hello,

Hi,

> On Mon, Jun 03, 2019 at 01:29:29PM +0100, Patrick Bellasi wrote:
> > On 31-May 08:35, Tejun Heo wrote:
> > > Hello, Patrick.
> > > 
> > > On Wed, May 15, 2019 at 10:44:55AM +0100, Patrick Bellasi wrote:
> > 
> > [...]
> > 
> > > For proportions (as opposed to weights), we use percentage rational
> > > numbers - e.g. 38.44 for 38.44%.  I have parser and doc update commits
> > > pending.  I'll put them on cgroup/for-5.3.
> > 
> > That's a point worth discussing with Peter, we already changed one
> > time from percentages to 1024 scale.
> 
> cgroup tries to uss uniform units for its interface files as much as
> possible even when that deviates from non-cgroup interface.  We can
> bikeshed the pros and cons for that design choice for sure but I don't
> think it makes sense to deviate from that at this point unless there
> are really strong reasons to do so.

that makes sense to me, having a uniform interface has certainly a
value.

The only additional point I can think about as a (slightly) stronger
reason is that I guess we would like to have the same API for cgroups
as well as for the task specific and the system wide settings.

The task specific values comes in via the sched_setattr() syscall:

   [PATCH v9 06/16] sched/core: uclamp: Extend sched_setattr() to support utilization clamping
   https://lore.kernel.org/lkml/20190515094459.10317-7-patrick.bellasi@arm.com/

where we need to encode each clamp into a __u32 value.

System wide settings are expose similarly to these:

   grep '' /proc/sys/kernel/sched_*

where we have always integer numbers.

AFAIU your proposal will require to use a "scaled percentage" - e.g.
3844 for 38.44% which however it's still not quite the same as writing
the string "38.44".

Not sure that's a strong enough argument, is it?

> > Utilization clamps are expressed as percentages by definition,
> > they are just expressed in a convenient 1024 scale which should not be
> > alien to people using those knobs.
> > 
> > If we wanna use a "more specific" name like uclamp.{min,max} then we
> > should probably also accept to use a "more specific" metric, don't we?
> 
> Heh, this actually made me chuckle.

:)

> It's an interesting bargaining take but I don't think that same word
> being in two different places makes them tradable entities.

Sure, that was not my intention.

I was just trying to see if the need to be more specific could
be an argument for having also a more specific value.

> We can go into the weeds with the semantics but how about us using
> an alternative adjective "misleading" for the cpu.util.min/max names
> to short-circuit that?

Not quite sure to get what you mean here. Are you pointing out that
with clamps we don't strictly enforce a bandwidth but we just set a
bias?

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
