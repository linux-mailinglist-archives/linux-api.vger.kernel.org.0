Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B926632FA0
	for <lists+linux-api@lfdr.de>; Mon,  3 Jun 2019 14:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFCM3h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Jun 2019 08:29:37 -0400
Received: from foss.arm.com ([217.140.101.70]:50214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfFCM3h (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 3 Jun 2019 08:29:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6E6C15A2;
        Mon,  3 Jun 2019 05:29:36 -0700 (PDT)
Received: from darkstar (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 867063F5AF;
        Mon,  3 Jun 2019 05:29:32 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:29:29 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
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
Message-ID: <20190603122929.GC19426@darkstar>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531153545.GE374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 31-May 08:35, Tejun Heo wrote:
> Hello, Patrick.
> 
> On Wed, May 15, 2019 at 10:44:55AM +0100, Patrick Bellasi wrote:

[...]

> For proportions (as opposed to weights), we use percentage rational
> numbers - e.g. 38.44 for 38.44%.  I have parser and doc update commits
> pending.  I'll put them on cgroup/for-5.3.

That's a point worth discussing with Peter, we already changed one
time from percentages to 1024 scale.

Utilization clamps are expressed as percentages by definition,
they are just expressed in a convenient 1024 scale which should not be
alien to people using those knobs.

If we wanna use a "more specific" name like uclamp.{min,max} then we
should probably also accept to use a "more specific" metric, don't we?

I personally like the [0..1024] range, but I guess that's really up to
you and Peter to agree upon.

> Thanks.
> 
> --
> tejun

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
