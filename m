Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A501A186E8
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 10:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfEIInV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 04:43:21 -0400
Received: from foss.arm.com ([217.140.101.70]:34356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfEIInU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 9 May 2019 04:43:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D0A3374;
        Thu,  9 May 2019 01:43:20 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78DEF3F575;
        Thu,  9 May 2019 01:43:17 -0700 (PDT)
Date:   Thu, 9 May 2019 09:43:11 +0100
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
Subject: Re: [PATCH v8 04/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190509084311.clpvno6am7bxo5wz@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-5-patrick.bellasi@arm.com>
 <20190508184202.GA32547@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508184202.GA32547@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 08-May 20:42, Peter Zijlstra wrote:
> On Tue, Apr 02, 2019 at 11:41:40AM +0100, Patrick Bellasi wrote:
> > Add a privileged interface to define a system default configuration via:
> > 
> >   /proc/sys/kernel/sched_uclamp_util_{min,max}
> 
> Isn't the 'u' in "uclamp" already for util?

Yes, right... I've just wanted to keep the same "uclamp" prefix used
by all related kernel symbols. But, since that's user-space API we can
certainly drop it and go for either:

      /proc/sys/kernel/sched_clamp_util_{min,max}
      /proc/sys/kernel/sched_util_clamp_{min,max}

Preference?

-- 
#include <best/regards.h>

Patrick Bellasi
