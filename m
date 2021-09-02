Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FBB3FEEE6
	for <lists+linux-api@lfdr.de>; Thu,  2 Sep 2021 15:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhIBNpi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Sep 2021 09:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234188AbhIBNpi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 2 Sep 2021 09:45:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0605161056;
        Thu,  2 Sep 2021 13:44:36 +0000 (UTC)
Date:   Thu, 2 Sep 2021 15:44:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dmitry V. Levin" <ldv@strace.io>, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4] uapi/linux/prctl: provide macro definitions for the
 PR_SCHED_CORE type argument
Message-ID: <20210902134434.gdctjkc5pvrwm3db@wittgenstein>
References: <20210825170613.GA3884@asgard.redhat.com>
 <20210826100025.pdakvmg24gomnuk5@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210826100025.pdakvmg24gomnuk5@wittgenstein>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 26, 2021 at 12:00:25PM +0200, Christian Brauner wrote:
> On Wed, Aug 25, 2021 at 07:06:13PM +0200, Eugene Syromiatnikov wrote:
> > Commit 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
> > made use of enum pid_type in prctl's arg4; this type and the associated
> > enumeration definitions are not exposed to userspace.  Christian
> > has suggested to provide additional macro definitions that convey
> > the meaning of the type argument more in alignment with its actual
> > usage, and this patch does exactly that.
> > 
> > Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Complements: 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
> > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > ---
> 
> I mean, I proposed the names so I'm ok with them. :)
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Peter et al. are you ok with this and do the names make sense to you?

I'll pick this up once the merge window closes then.

Thanks!
Christian

> 
> Christian
> 
> > v4:
> >   - Rewritten in accordance with Christian Brauner's suggestion to provide
> >     macro definitions that are explicitly tailored for the prctl op.
> > 
> > v3: https://lore.kernel.org/lkml/20210807120905.GA14706@asgard.redhat.com/
> >   - Fixed header guard macro: s/_UAPI_LINUX_PID_H/_UAPI_LINUX_PIDTYPE_H/,
> >     as noted by Dmitry Levin.
> > 
> > v2: https://lore.kernel.org/lkml/20210807104800.GA22620@asgard.redhat.com/
> >   - Header file is renamed from pid.h to pidtype.h to avoid collisions
> >     with include/linux/pid.h when included from uapi headers;
> >   - The enum type has renamed from __kernel_pid_type to __kernel_pidtype
> >     to avoid possible confusion with __kernel_pid_t.
> > 
> > v1: https://lore.kernel.org/lkml/20210807010123.GA5174@asgard.redhat.com/
> > ---
> >  Documentation/admin-guide/hw-vuln/core-scheduling.rst | 5 +++--
> >  include/uapi/linux/prctl.h                            | 3 +++
> >  kernel/sched/core_sched.c                             | 4 ++++
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> > index 7b410ae..9a65fed 100644
> > --- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> > +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> > @@ -61,8 +61,9 @@ arg3:
> >      ``pid`` of the task for which the operation applies.
> >  
> >  arg4:
> > -    ``pid_type`` for which the operation applies. It is of type ``enum pid_type``.
> > -    For example, if arg4 is ``PIDTYPE_TGID``, then the operation of this command
> > +    ``pid_type`` for which the operation applies. It is one of
> > +    ``PR_SCHED_CORE_SCOPE_``-prefixed macro constants.  For example, if arg4
> > +    is ``PR_SCHED_CORE_SCOPE_THREAD_GROUP``, then the operation of this command
> >      will be performed for all tasks in the task group of ``pid``.
> >  
> >  arg5:
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index 967d9c5..644a3b4 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -266,5 +266,8 @@ struct prctl_mm_map {
> >  # define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
> >  # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
> >  # define PR_SCHED_CORE_MAX		4
> > +# define PR_SCHED_CORE_SCOPE_THREAD		0
> > +# define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1
> > +# define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2
> >  
> >  #endif /* _LINUX_PRCTL_H */
> > diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> > index 9a80e9a..20f6409 100644
> > --- a/kernel/sched/core_sched.c
> > +++ b/kernel/sched/core_sched.c
> > @@ -134,6 +134,10 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
> >  	if (!static_branch_likely(&sched_smt_present))
> >  		return -ENODEV;
> >  
> > +	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_THREAD != PIDTYPE_PID);
> > +	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_THREAD_GROUP != PIDTYPE_TGID);
> > +	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_PROCESS_GROUP != PIDTYPE_PGID);
> > +
> >  	if (type > PIDTYPE_PGID || cmd >= PR_SCHED_CORE_MAX || pid < 0 ||
> >  	    (cmd != PR_SCHED_CORE_GET && uaddr))
> >  		return -EINVAL;
> > -- 
> > 2.1.4
> > 
