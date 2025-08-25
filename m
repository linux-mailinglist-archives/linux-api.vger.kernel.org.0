Return-Path: <linux-api+bounces-4583-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A66B349EB
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916C42A41F4
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2436B3101DF;
	Mon, 25 Aug 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvOCtSFD"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09F3101B9;
	Mon, 25 Aug 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145681; cv=none; b=tNXxhHj6rOylKpjUlR7WprNIiZs33nyzbrQwy4xJ1zWRy9LDBrNjSAE3nzuIUPI+TecXyO9Yg5o0CoVRuNEM5uZ257a5zV5DSVtCevPXmBrEf0XTsjFigySik6YvCBs4PV+rYwAT73cZbQvE6xJ0vt/StRzLwaGzhlY4yTWC+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145681; c=relaxed/simple;
	bh=zpS3J9kawTcgszjNsvRuGRvLsrFI0Wmdk3/XvHx6XPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWj7VKQG2UASl8Vk1UN+ah07Enpyl1QwvWP/gCppEc6c3r9DQAfEnJMPp8yrqRrhJ11ujvtLS2puYFj8TVKlZIeFC4d5uBamAnMxLq/A+juaDTuTQuyrOf0uN8JX/EOnzcaCUf4EeAmPoeBs0nhIT6s5pGf9KQSZEwVqNvnWWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvOCtSFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147D6C4CEF1;
	Mon, 25 Aug 2025 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145680;
	bh=zpS3J9kawTcgszjNsvRuGRvLsrFI0Wmdk3/XvHx6XPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvOCtSFDsqZp1xL+QH+K1kXTEa3FwQGXbtAAP6wyJSrpg+XodyPcHap81TVoZn372
	 fSGxNIBNKZHSqGENAV0t86pRfZRQydfGswqJF4XaZvZR2c4XIUzJYv8R95qtBZE8vD
	 wv0xlU43DfNZcPNwL3mju9mgwpgZsJtXqqKXv2XnD8lZHGaWxIDuC4O9snzNc9Mlgr
	 u07Y8aHsm7/CVZsZNTQ1UJZvY7rz/6/PFEPQ7E5E4uJd58QdjFaIFEF62V9GmwaOjP
	 ld/9y9B9qXT1XRCbQdarWoulqi9oXyJROpD47dU/pvf2IlHq2ZMgfRAoxE+fY8aft9
	 gGR0+DqzKYFxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v4 4/7] kernel/sched: add specs for sys_sched_setattr()
Date: Mon, 25 Aug 2025 14:14:31 -0400
Message-ID: <20250825181434.3340805-5-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825181434.3340805-1-sashal@kernel.org>
References: <20250825181434.3340805-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/syscalls.c | 315 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 314 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f36e84..c5eb0facdc3a 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -969,10 +969,323 @@ SYSCALL_DEFINE2(sched_setparam, pid_t, pid, struct sched_param __user *, param)
 }
 
 /**
- * sys_sched_setattr - same as above, but with extended sched_attr
+ * sys_sched_setattr - set/change scheduling policy and attributes
  * @pid: the pid in question.
  * @uattr: structure containing the extended parameters.
  * @flags: for future extension.
+ *
+ * long-desc: Sets the scheduling policy and attributes for a process,
+ *   supporting multiple scheduling classes including real-time,
+ *   deadline, and normal policies. Performs capability checks,
+ *   validates parameters, enforces resource limits, and ensures
+ *   bandwidth constraints for deadline tasks.
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param-count: 3
+ *
+ * param: pid
+ *   type: KAPI_TYPE_INT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 0, INT_MAX
+ *   constraint: Must be >= 0, where 0 means current process
+ *
+ * param: uattr
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Valid user pointer to struct sched_attr
+ *
+ * struct: struct sched_attr
+ *   size: 120
+ *   alignment: 8
+ *   field: size
+ *     type: __u32
+ *     desc: Structure size for version compatibility
+ *     constraint-type: KAPI_CONSTRAINT_RANGE
+ *     range: 48, 512
+ *     constraint: Must be at least SCHED_ATTR_SIZE_VER0
+ *   field: sched_policy
+ *     type: __u32
+ *     desc: Scheduling policy selector
+ *     constraint-type: KAPI_CONSTRAINT_ENUM
+ *     enum: SCHED_NORMAL(0), SCHED_FIFO(1), SCHED_RR(2), SCHED_BATCH(3), SCHED_IDLE(5), SCHED_DEADLINE(6), SCHED_EXT(7)
+ *   field: sched_flags
+ *     type: __u64
+ *     desc: Policy modifier flags
+ *     constraint-type: KAPI_CONSTRAINT_MASK
+ *     mask: SCHED_FLAG_ALL
+ *   field: sched_nice
+ *     type: __s32
+ *     desc: Nice value for CFS policies
+ *     constraint-type: KAPI_CONSTRAINT_RANGE
+ *     range: -20, 19
+ *     constraint: Only used for SCHED_NORMAL, SCHED_BATCH, SCHED_IDLE
+ *   field: sched_priority
+ *     type: __u32
+ *     desc: Priority for RT policies
+ *     constraint-type: KAPI_CONSTRAINT_RANGE
+ *     range: 1, 99
+ *     constraint: Only used for SCHED_FIFO, SCHED_RR
+ *   field: sched_runtime
+ *     type: __u64
+ *     desc: Runtime budget in nanoseconds
+ *     constraint: Only used for SCHED_DEADLINE
+ *   field: sched_deadline
+ *     type: __u64
+ *     desc: Deadline in nanoseconds
+ *     constraint: Only used for SCHED_DEADLINE
+ *   field: sched_period
+ *     type: __u64
+ *     desc: Period in nanoseconds (0 = use deadline)
+ *     constraint: Only used for SCHED_DEADLINE
+ *   field: sched_util_min
+ *     type: __u32
+ *     desc: Minimum utilization hint (v1+)
+ *     constraint-type: KAPI_CONSTRAINT_RANGE
+ *     range: 0, 1024
+ *     constraint: Requires struct version >= 1 and SCHED_FLAG_UTIL_CLAMP_MIN
+ *   field: sched_util_max
+ *     type: __u32
+ *     desc: Maximum utilization hint (v1+)
+ *     constraint-type: KAPI_CONSTRAINT_RANGE
+ *     range: 0, 1024
+ *     constraint: Requires struct version >= 1 and SCHED_FLAG_UTIL_CLAMP_MAX
+ *
+ * param: flags
+ *   type: KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   range: 0, 0
+ *   constraint: Must be 0 (reserved for future use)
+ *
+ * validation-group: RT Policies
+ *   policy: SCHED_FIFO, SCHED_RR
+ *   rule: sched_priority must be in [1,99]
+ *   rule: sched_nice must be 0
+ *   rule: No deadline parameters
+ *
+ * validation-group: CFS Policies
+ *   policy: SCHED_NORMAL, SCHED_BATCH, SCHED_IDLE
+ *   rule: sched_priority must be 0
+ *   rule: sched_nice must be in [-20,19]
+ *   rule: No deadline parameters
+ *
+ * validation-group: Deadline Policy
+ *   policy: SCHED_DEADLINE
+ *   rule: sched_runtime > 0
+ *   rule: sched_deadline >= sched_runtime
+ *   rule: sched_period == 0 || sched_period >= sched_deadline
+ *   rule: sched_priority must be 0
+ *   rule: sched_nice must be 0
+ *
+ * validation-group: Utilization Clamping
+ *   flag: SCHED_FLAG_UTIL_CLAMP_MIN, SCHED_FLAG_UTIL_CLAMP_MAX
+ *   rule: Requires struct version >= 1 (size >= 56)
+ *   rule: util values must be in [0,1024]
+ *   rule: util_min <= util_max
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_ERROR_CHECK
+ *   success: 0
+ *
+ * error: EINVAL, Invalid parameters
+ *   desc: Returned when uattr is NULL, pid < 0, flags != 0,
+ *     attr.size < SCHED_ATTR_SIZE_VER0, invalid scheduling policy,
+ *     invalid priority for policy, invalid sched_flags, or malformed
+ *     sched_attr structure (e.g., DL runtime > deadline)
+ *
+ * error: ESRCH, Process not found
+ *   desc: Returned when the specified pid does not exist
+ *
+ * error: EPERM, Insufficient privileges
+ *   desc: Returned when lacking CAP_SYS_NICE for privileged operations,
+ *     trying to change another user's process without CAP_SYS_NICE,
+ *     or resetting SCHED_RESET_ON_FORK flag without privileges
+ *
+ * error: E2BIG, Structure size mismatch
+ *   desc: Returned when sched_attr size is larger than kernel expects
+ *
+ * error: EFAULT, Bad user pointer
+ *   desc: Returned when copying from user space fails or uattr is not
+ *     a valid readable user pointer
+ *
+ * error: EBUSY, Bandwidth exceeded
+ *   desc: Returned when SCHED_DEADLINE bandwidth would be exceeded or
+ *     deadline admission test fails
+ *
+ * error: EAGAIN, Transient failure
+ *   desc: Returned when unable to change cpus_allowed due to transient
+ *     cpuset or CPU hotplug conditions
+ *
+ * error: ENOMEM, Memory allocation failed
+ *   desc: Returned when unable to allocate memory for CPU masks
+ *
+ * error: EOPNOTSUPP, Feature not supported
+ *   desc: Returned when utilization clamping is requested but
+ *     CONFIG_UCLAMP_TASK is not enabled
+ *
+ * since-version: 3.14
+ *
+ * lock: rq->lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Process runqueue lock for scheduler state changes
+ *
+ * lock: p->pi_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Priority inheritance lock for PI chain adjustments
+ *
+ * lock: cpuset_mutex
+ *   type: KAPI_LOCK_MUTEX
+ *   acquired: true
+ *   released: true
+ *   desc: Cpuset mutex for SCHED_DEADLINE bandwidth checks
+ *
+ *
+ * signal: SIGXCPU
+ *   direction: KAPI_SIGNAL_SEND
+ *   action: KAPI_SIGNAL_ACTION_DEFAULT
+ *   condition: SCHED_FLAG_DL_OVERRUN is set and deadline is missed
+ *   desc: Sent to task when it exceeds its SCHED_DEADLINE runtime.
+ *     The signal is sent asynchronously from the scheduler tick or
+ *     deadline timer. Unlike other scheduling policies, SCHED_DEADLINE
+ *     can generate SIGXCPU for runtime overruns rather than just
+ *     CPU time limit violations.
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   priority: 0
+ *   interruptible: no
+ *   state-req: KAPI_SIGNAL_STATE_RUNNING
+ *
+ * examples: sched_setattr(0, &attr, 0);  // Set attributes for current task
+ *   sched_setattr(pid, &attr, 0);  // Set attributes for specific task
+ *
+ * notes: The sched_attr structure supports forward/backward compatibility
+ *   through its size field. Older kernels ignore newer fields. The syscall
+ *   validates all parameters based on the scheduling policy. For SCHED_DEADLINE,
+ *   it performs CBS (Constant Bandwidth Server) admission control. Priority
+ *   changes may trigger immediate reschedule. RT policies require sched_priority
+ *   in range [1,99]. Normal policies use nice values [-20,19] mapped to
+ *   static_prio. Changes are atomic - either all succeed or none are applied.
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_PROCESS_STATE
+ *   target: task scheduling attributes
+ *   desc: Updates policy/priority/deadline parameters atomically
+ *   reversible: yes
+ *
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_SCHEDULE
+ *   target: runqueue
+ *   desc: May requeue task with new priority and trigger reschedule
+ *   condition: Task is runnable
+ *
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: deadline bandwidth
+ *   desc: Allocates CBS bandwidth for SCHED_DEADLINE tasks
+ *   condition: Policy is SCHED_DEADLINE
+ *   reversible: yes
+ *
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: timer slack
+ *   desc: Sets timer slack to 0 for RT/DL policies
+ *   condition: RT or DEADLINE policy
+ *
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: PI chain
+ *   desc: Updates priority inheritance chain if task has PI waiters
+ *   condition: Task has PI waiters
+ *
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_SCHEDULE
+ *   target: CPU
+ *   desc: May migrate task to different CPU based on affinity/bandwidth
+ *   condition: SCHED_DEADLINE or cpuset changes
+ *
+ *
+ * state-trans: task->policy
+ *   from: any policy
+ *   to: new policy
+ *   desc: Task scheduling policy changes per sched_attr
+ *
+ *
+ * state-trans: task->rt_priority
+ *   from: any
+ *   to: 0-99 or 0
+ *   desc: RT priority updated for RT policies, 0 for others
+ *
+ *
+ * state-trans: task->normal_prio
+ *   from: any
+ *   to: recalculated
+ *   desc: Normal priority recalculated based on policy/nice
+ *
+ *
+ * state-trans: task->sched_reset_on_fork
+ *   from: 0/1
+ *   to: 0/1
+ *   desc: Reset-on-fork flag updated per SCHED_FLAG_RESET_ON_FORK
+ *
+ *
+ * state-trans: task->dl
+ *   from: inactive/active
+ *   to: active/inactive
+ *   desc: Deadline entity activated for SCHED_DEADLINE
+ *
+ *
+ * capability: CAP_SYS_NICE
+ *   type: KAPI_CAP_BYPASS_CHECK
+ *   desc: CAP_SYS_NICE capability
+ *   allows: Set RT/DL policies, increase priority, nice < 0, change other users' tasks, remove SCHED_FLAG_RESET_ON_FORK
+ *   without: Can only set SCHED_NORMAL/BATCH/IDLE, decrease priority, nice >= 0, modify own tasks
+ *   condition: Checked when setting RT/DL policy, decreasing nice, or modifying other user's tasks
+ *   priority: 0
+ *
+ *
+ * constraint: Valid Scheduling Policy
+ *   desc: The sched_policy field must be one of: SCHED_NORMAL (0), SCHED_FIFO (1), SCHED_RR (2),
+ *     SCHED_BATCH (3), SCHED_IDLE (5), SCHED_DEADLINE (6), or SCHED_EXT (7) if configured.
+ *     Invalid policies result in -EINVAL.
+ *   expr: uattr->sched_policy >= 0 && (uattr->sched_policy <= SCHED_DEADLINE || (uattr->sched_policy == SCHED_EXT && IS_ENABLED(CONFIG_SCHED_CLASS_EXT)))
+ *
+ *
+ * constraint: RT Priority Range
+ *   desc: For SCHED_FIFO and SCHED_RR policies, sched_priority must be in range [1, 99]
+ *     where 1 is lowest and 99 is highest RT priority. For other policies, sched_priority must be 0.
+ *   expr: rt_policy(uattr->sched_policy) ? (uattr->sched_priority >= 1 && uattr->sched_priority <= 99) : (uattr->sched_priority == 0)
+ *
+ *
+ * constraint: Nice Value Range
+ *   desc: For SCHED_NORMAL, SCHED_BATCH, and SCHED_IDLE policies, the nice value must be in range [-20, 19]
+ *     where -20 is highest priority (least nice) and 19 is lowest priority (most nice).
+ *   expr: fair_policy(uattr->sched_policy) ? (uattr->sched_nice >= MIN_NICE && uattr->sched_nice <= MAX_NICE) : 1
+ *
+ *
+ * constraint: SCHED_DEADLINE CBS Rules
+ *   desc: For SCHED_DEADLINE, must satisfy: sched_runtime > 0, sched_deadline >= sched_runtime,
+ *     sched_period >= sched_deadline. If period is 0, it defaults to deadline.
+ *   expr: dl_policy(uattr->sched_policy) ? (uattr->sched_runtime > 0 && uattr->sched_runtime <= uattr->sched_deadline && (uattr->sched_period == 0 || uattr->sched_period >= uattr->sched_deadline)) : 1
+ *
+ *
+ * constraint: Utilization Clamping Range
+ *   desc: If sched_flags includes SCHED_FLAG_UTIL_CLAMP_MIN/MAX, the util_min and util_max values
+ *     must be in range [0, 1024] where 1024 represents 100% utilization.
+ *   expr: (uattr->sched_flags & SCHED_FLAG_UTIL_CLAMP) ? (uattr->sched_util_min >= 0 && uattr->sched_util_min <= SCHED_CAPACITY_SCALE && uattr->sched_util_max >= 0 && uattr->sched_util_max <= SCHED_CAPACITY_SCALE && uattr->sched_util_min <= uattr->sched_util_max) : 1
+ *
+ *
+ * constraint: SCHED_DEADLINE Bandwidth
+ *   desc: The sum of runtime/period ratios for all SCHED_DEADLINE tasks on the system
+ *     must not exceed the available CPU capacity. This global bandwidth check prevents system overload.
+ *
+ *
+ * constraint: Structure Size Compatibility
+ *   desc: The attr.size field must be at least SCHED_ATTR_SIZE_VER0 (48 bytes) and no larger than
+ *     the kernel's known structure size to ensure forward/backward compatibility.
  */
 SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 			       unsigned int, flags)
-- 
2.50.1


