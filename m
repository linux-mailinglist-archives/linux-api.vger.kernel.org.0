Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D444331164
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 17:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEaPfv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 11:35:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42934 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfEaPfu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 11:35:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so1331928qtk.9;
        Fri, 31 May 2019 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a6YwIIJc8LPr9G8BXrNtxAA4AtOs9+lI2cdNOdpA3Q0=;
        b=BAc+ougURJ//27itXmCiZ/hU4b6VQWx20DqetuxCoOrzZFDHn6zHMQjyqBaZ4k26lz
         X4JG0L42/1KfcfaJHRoGM8cNOS/CJWY8anDBsELhNCL680ziHCEP+iw3DR20vIS6MgpR
         TpcV2r86X1blXIh+RfkXB1h9iSFGMttjOXnR4j4MWDYFA9daNTEhe7P5umDRvUUZrbg2
         qs0vDhSXQpdB9nc7GgvXtPdZmD/mhAUgFUdxjpmbM0adJn6wuGJ/mfeYpcymgvmz+YbF
         xV5PVOMw6X/EGp+S/ol872hO80QHKUg7lGe2KOfch27FKvUFDANfj4zIdRAWn3Lg2e0C
         Cjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a6YwIIJc8LPr9G8BXrNtxAA4AtOs9+lI2cdNOdpA3Q0=;
        b=unzdv7jHssqwjwZdNtFrnel7pgg5ZtQpvuzsut9bN15vuzgbJeImdMMwdky2ovPwGE
         miy2MwBeEmJMePzncKYiYHe5A0H20DjwXUAFOYlzGyBNjYq/sl/lnHkLKhIohtHFoi53
         nCW2oaqAoANnzmbBt6+Jj3ItbtrCNuTdsmBczNtxLJx/KowhSZAyyv1j1pstW1SpTUxU
         LfX664m3Xv8Zb0Q4u3b07bJ5QRrkGEiZGwKF5h/gVx+yJR+RRYx1DpXZ/a1Sb9MdGIpH
         ep47yHi9dFSecs3YfZrzD57xhDxzp5Jf9pjO3cDXRCkIfLkrpsuPoQQGu+lLtunMTb4F
         /nYQ==
X-Gm-Message-State: APjAAAUE0By7QUOOfQJOiSnLakw1BMfm6HplkQxbgDnRURkLBEVryESC
        tN9PilXOOocKiCWfa1cHHaM=
X-Google-Smtp-Source: APXvYqwXrOp+84AjrsXS4B7qfXNV01vDvagtkapssCObEwv2Hle4FplLiTJrDwe7OFh5FsQKOxiVuw==
X-Received: by 2002:ac8:eca:: with SMTP id w10mr4936223qti.81.1559316949131;
        Fri, 31 May 2019 08:35:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::39c9])
        by smtp.gmail.com with ESMTPSA id p4sm3449792qkb.84.2019.05.31.08.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 08:35:47 -0700 (PDT)
Date:   Fri, 31 May 2019 08:35:45 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20190531153545.GE374014@devbig004.ftw2.facebook.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515094459.10317-13-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello, Patrick.

On Wed, May 15, 2019 at 10:44:55AM +0100, Patrick Bellasi wrote:
> Extend the CPU controller with a couple of new attributes util.{min,max}
> which allows to enforce utilization boosting and capping for all the
> tasks in a group. Specifically:
> 
> - util.min: defines the minimum utilization which should be considered
> 	    i.e. the RUNNABLE tasks of this group will run at least at a
> 		 minimum frequency which corresponds to the util.min
> 		 utilization
> 
> - util.max: defines the maximum utilization which should be considered
> 	    i.e. the RUNNABLE tasks of this group will run up to a
> 		 maximum frequency which corresponds to the util.max
> 		 utilization

Let's please use a prefix which is more specific.  It's clamping the
utilization estimates of the member tasks which in turn affect
scheduling / frequency decisions but cpu.util.max reads like it's
gonna limit the cpu utilization directly.  Maybe just use uclamp?

> These attributes:
> 
> a) are available only for non-root nodes, both on default and legacy
>    hierarchies, while system wide clamps are defined by a generic
>    interface which does not depends on cgroups. This system wide
>    interface enforces constraints on tasks in the root node.

I'd much prefer if they weren't entangled this way.  The system wide
limits should work the same regardless of cgroup's existence.  cgroup
can put further restriction on top but mere creation of cgroups with
cpu controller enabled shouldn't take them out of the system-wide
limits.

> b) enforce effective constraints at each level of the hierarchy which
>    are a restriction of the group requests considering its parent's
>    effective constraints. Root group effective constraints are defined
>    by the system wide interface.
>    This mechanism allows each (non-root) level of the hierarchy to:
>    - request whatever clamp values it would like to get
>    - effectively get only up to the maximum amount allowed by its parent

I'll come back to this later.

> c) have higher priority than task-specific clamps, defined via
>    sched_setattr(), thus allowing to control and restrict task requests

This sounds good.

> Add two new attributes to the cpu controller to collect "requested"
> clamp values. Allow that at each non-root level of the hierarchy.
> Validate local consistency by enforcing util.min < util.max.
> Keep it simple by do not caring now about "effective" values computation
> and propagation along the hierarchy.

So, the followings are what we're doing for hierarchical protection
and limit propgations.

* Limits (high / max) default to max.  Protections (low / min) 0.  A
  new cgroup by default doesn't constrain itself further and doesn't
  have any protection.

* A limit defines the upper ceiling for the subtree.  If an ancestor
  has a limit of X, none of its descendants can have more than X.

* A protection defines the upper ceiling of protections for the
  subtree.  If an andester has a protection of X, none of its
  descendants can have more protection than X.

Note that there's no way for an ancestor to enforce protection its
descendants.  It can only allow them to claim some.  This is
intentional as the other end of the spectrum is either descendants
losing the ability to further distribute protections as they see fit.

For proportions (as opposed to weights), we use percentage rational
numbers - e.g. 38.44 for 38.44%.  I have parser and doc update commits
pending.  I'll put them on cgroup/for-5.3.

Thanks.

-- 
tejun
