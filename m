Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A113E4151
	for <lists+linux-api@lfdr.de>; Mon,  9 Aug 2021 10:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhHIIFA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Aug 2021 04:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233677AbhHIIFA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 9 Aug 2021 04:05:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8AF760E93;
        Mon,  9 Aug 2021 08:04:35 +0000 (UTC)
Date:   Mon, 9 Aug 2021 10:04:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dmitry V. Levin" <ldv@strace.io>, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        libc-alpha@sourceware.org, fweimer@redhat.com
Subject: Re: [PATCH] uapi: expose enum pid_type
Message-ID: <20210809080432.l3rf6e5fzjqlz42f@wittgenstein>
References: <20210807010123.GA5174@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210807010123.GA5174@asgard.redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Aug 07, 2021 at 03:01:23AM +0200, Eugene Syromiatnikov wrote:
> Commit 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
> made use of enum pid_type in prctl's arg4; this type and the associated

(Hm, I thought we were trying to stop exposing the thread-group leader
concept directly to userspace. But that ship probably has sailed now.)

> +	__PIDTYPE_PID,
> +	__PIDTYPE_TGID,
> +	__PIDTYPE_PGID,

What's rather odd is that the interface seems to not be using
PIDTYPE_PID, PIDTYPE_TGID, or PIDTYPE_PGID to indicate the type of the
pid but rather the scope of the operation which conflicts with the
names in the enum.

So I think exposing these values as PIDTYPE_* is misleading as it
doesn't really apply to the passed in pid. For example, if I pass in a
non-thread group leader and specify PIDTYPE_TGID then this interface
goes and digs out the thread-group leader from signal->pids when
arguably it should've failed because I passed in a non-thread-group
leader pid. So I think we shouldn't expose the enum with __PIDTYPE_*
prefix.

I think there's two ways. First, the prctl() would need to change a bit
and then we could use the P_PID, P_PGID definitions from wait.h that we
already expose to userspace (adding a P_TGID). But that would mean a
uapi change for the prctl() and I've never really liked those defines
anyway as they are equally strangely named.
So I would suggest we expose a custom enum or a set of defines in
prctl.h. Like (sorry, probably terrible names):

#define PR_SCHED_CORE_SCOPE_THREAD
#define PR_SCHED_CORE_SCOPE_THREADGROUP
#define PR_SCHED_CORE_SCOPE_PROCESSGROUP

that have the same values as PIDTYPE_* but express clearly that this
indicates the scope of the operation independent of whether or not the
passed in pid is a thread-group leader, process-group leader or not.

Thoughts?

Christian

> enumeration definitions are not exposed to userspace.  Try to fix that
> by providing enum _kernel_pid_type and tying in-kernel enum pid_type
> definitions to it.  Note that enum pid_type cannot be exposed as is,
> since "enum pid_type" is already exists in various projects [1] (notably
> gcc and strace), and "enum __pid_type" is defined by glibc and uclibc
> for fcntl(F_SETOWN_EX) owner ID type.
> 
> [1] https://codesearch.debian.net/search?q=enum+pid_type
> 
> Complements: 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>  .../admin-guide/hw-vuln/core-scheduling.rst          |  7 ++++---
>  include/linux/pid.h                                  | 12 +++++++-----
>  include/uapi/linux/pid.h                             | 20 ++++++++++++++++++++
>  include/uapi/linux/prctl.h                           |  1 +
>  4 files changed, 32 insertions(+), 8 deletions(-)
>  create mode 100644 include/uapi/linux/pid.h
> 
> diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> index 7b410ae..3eb2b7c 100644
> --- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> @@ -61,9 +61,10 @@ arg3:
>      ``pid`` of the task for which the operation applies.
>  
>  arg4:
> -    ``pid_type`` for which the operation applies. It is of type ``enum pid_type``.
> -    For example, if arg4 is ``PIDTYPE_TGID``, then the operation of this command
> -    will be performed for all tasks in the task group of ``pid``.
> +    ``pid_type`` for which the operation applies. It is of type
> +    ``enum __kernel_pid_type``.  For example, if arg4 is ``__PIDTYPE_TGID``,
> +    then the operation of this command will be performed for all tasks
> +    in the task group of ``pid``.
>  
>  arg5:
>      userspace pointer to an unsigned long for storing the cookie returned by
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index fa10acb..f8ca4c9 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -5,14 +5,16 @@
>  #include <linux/rculist.h>
>  #include <linux/wait.h>
>  #include <linux/refcount.h>
> +#include <uapi/linux/pid.h>
>  
>  enum pid_type
>  {
> -	PIDTYPE_PID,
> -	PIDTYPE_TGID,
> -	PIDTYPE_PGID,
> -	PIDTYPE_SID,
> -	PIDTYPE_MAX,
> +	PIDTYPE_PID = __PIDTYPE_PID,
> +	PIDTYPE_TGID = __PIDTYPE_TGID,
> +	PIDTYPE_PGID = __PIDTYPE_PGID,
> +	PIDTYPE_SID = __PIDTYPE_SID,
> +
> +	PIDTYPE_MAX = __PIDTYPE_MAX
>  };
>  
>  /*
> diff --git a/include/uapi/linux/pid.h b/include/uapi/linux/pid.h
> new file mode 100644
> index 0000000..91d08e4
> --- /dev/null
> +++ b/include/uapi/linux/pid.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_PID_H
> +#define _UAPI_LINUX_PID_H
> +
> +/*
> + * Type of process-related ID.  So far, it is used only for prctl(PR_SCHED_CORE);
> + * not to be confused with type field of f_owner_ex structure argument
> + * of fcntl(F_SETOWN_EX).
> + */
> +enum __kernel_pid_type
> +{
> +	__PIDTYPE_PID,
> +	__PIDTYPE_TGID,
> +	__PIDTYPE_PGID,
> +	__PIDTYPE_SID,
> +
> +	__PIDTYPE_MAX /* Non-UAPI */
> +};
> +
> +#endif /* _UAPI_LINUX_PID_H */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 967d9c5..4e794aa 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_PRCTL_H
>  
>  #include <linux/types.h>
> +#include <linux/pid.h> /* enum __kernel_pid_type */
>  
>  /* Values to pass as first argument to prctl() */
>  
> -- 
> 2.1.4
> 
