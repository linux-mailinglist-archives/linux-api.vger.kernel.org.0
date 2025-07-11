Return-Path: <linux-api+bounces-4153-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4711FB01AF1
	for <lists+linux-api@lfdr.de>; Fri, 11 Jul 2025 13:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BBF18925C0
	for <lists+linux-api@lfdr.de>; Fri, 11 Jul 2025 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF87C2C1599;
	Fri, 11 Jul 2025 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR1V+OIW"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B202C08D7;
	Fri, 11 Jul 2025 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234178; cv=none; b=B+AIhU8YvFQUreqHJm/CFoZqP8jfJr5WiIrXoG8t1DPkwPxYY43BPvu+Haq/AKdw/tk4knMq6d+cyqhVeULMsOTOYsYRHj88EjwrlWfFRFEZZUEj4qlwLqEGTOziZ9liYVYrbZi6HPKWmgNYfSIWS0tSJz+DF6FU+9P7neLOm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234178; c=relaxed/simple;
	bh=mH4DxSeqFEiPV+0p291Gj/PBkUkh2yw262PHRRCfYVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P5LI4QnGUMMP/JQRfJrfaygJ8/IlkcJ/6ADK6VtIcwXokJ4lD0SQ0aUqrnImfIGhQZTSrOclj7PjBJEyr2cVPfcd26kkYDuIqgwbowe0YlCLGpGp9TsySjFR0wLOuCbuKRhlk7bG819tmWVI77Cq5Yn3Kx6eBCua5ODlKGgxFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR1V+OIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10288C4CEF7;
	Fri, 11 Jul 2025 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234178;
	bh=mH4DxSeqFEiPV+0p291Gj/PBkUkh2yw262PHRRCfYVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SR1V+OIWdC+q4GTaWsscWQKoXEYWpe35hKlqHuGH52p0ZXfIeK6zlVawkrF28bfvl
	 k1T0c2qR0RozExW6kZzoivSnhIECyD6uwWSXqskGbvyoSPPTc2jUVQvC1FSwHROyym
	 Gvg+DFhg6Iy7lRc3qcpfKwg6oura9pPxs/I3pjzGHvjOySUh0z4PITTfIOZT9trvaQ
	 4XAUZPt11BaH6Sb3voKOgZhuj2SnQeXNt3xgohAE7KQzUZrZ+wuxFM90nr70vcCxDH
	 W0SqK6EjwkZuRjoiyugUfCkVvVRtDO7cvLEJ6RRA8t5sfON9Uei7oGIihC6oX8YAe5
	 gxaPaH/ng0T1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v3 4/4] kernel/sched: add specs for sys_sched_setattr()
Date: Fri, 11 Jul 2025 07:42:48 -0400
Message-Id: <20250711114248.2288591-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711114248.2288591-1-sashal@kernel.org>
References: <20250711114248.2288591-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/syscalls.c | 168 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 547c1f05b667e..c9e0af72b5d4f 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -974,10 +974,176 @@ SYSCALL_DEFINE2(sched_setparam, pid_t, pid, struct sched_param __user *, param)
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
+ * param-count: 3
+ * param-type: pid, KAPI_TYPE_INT
+ * param-flags: pid, KAPI_PARAM_IN
+ * param-constraint-type: pid, KAPI_CONSTRAINT_RANGE
+ * param-range: pid, 0, INT_MAX
+ * param-constraint: pid, Must be >= 0, where 0 means current process
+ * param-type: uattr, KAPI_TYPE_USER_PTR
+ * param-flags: uattr, KAPI_PARAM_IN | KAPI_PARAM_USER
+ * param-constraint-type: uattr, KAPI_CONSTRAINT_CUSTOM
+ * param-constraint: uattr, Valid user pointer to struct sched_attr
+ * struct-type: uattr, struct sched_attr
+ * struct-field: size, __u32, Structure size for version compatibility
+ * struct-field-range: size, 48, 512
+ * struct-field-validate: size, uattr->size >= SCHED_ATTR_SIZE_VER0
+ * struct-field: sched_policy, __u32, Scheduling policy selector
+ * struct-field-enum: sched_policy, SCHED_NORMAL(0), SCHED_FIFO(1), SCHED_RR(2), SCHED_BATCH(3), SCHED_IDLE(5), SCHED_DEADLINE(6), SCHED_EXT(7)
+ * struct-field: sched_flags, __u64, Policy modifier flags
+ * struct-field-mask: sched_flags, SCHED_FLAG_ALL
+ * struct-field: sched_nice, __s32, Nice value for CFS policies
+ * struct-field-range: sched_nice, -20, 19
+ * struct-field-policy: sched_nice, SCHED_NORMAL, SCHED_BATCH, SCHED_IDLE
+ * struct-field: sched_priority, __u32, Priority for RT policies
+ * struct-field-range: sched_priority, 1, 99
+ * struct-field-policy: sched_priority, SCHED_FIFO, SCHED_RR
+ * struct-field: sched_runtime, __u64, Runtime budget in nanoseconds
+ * struct-field-policy: sched_runtime, SCHED_DEADLINE
+ * struct-field: sched_deadline, __u64, Deadline in nanoseconds
+ * struct-field-policy: sched_deadline, SCHED_DEADLINE
+ * struct-field: sched_period, __u64, Period in nanoseconds (0 = use deadline)
+ * struct-field-policy: sched_period, SCHED_DEADLINE
+ * struct-field: sched_util_min, __u32, Minimum utilization hint (v1+)
+ * struct-field-range: sched_util_min, 0, 1024
+ * struct-field-version: sched_util_min, 1
+ * struct-field-flag: sched_util_min, SCHED_FLAG_UTIL_CLAMP_MIN
+ * struct-field: sched_util_max, __u32, Maximum utilization hint (v1+)
+ * struct-field-range: sched_util_max, 0, 1024
+ * struct-field-version: sched_util_max, 1
+ * struct-field-flag: sched_util_max, SCHED_FLAG_UTIL_CLAMP_MAX
+ * param-type: flags, KAPI_TYPE_UINT
+ * param-flags: flags, KAPI_PARAM_IN
+ * param-range: flags, 0, 0
+ * param-constraint: flags, Must be 0 (reserved for future use)
+ * validation-group: RT Policies
+ * validation-policy: SCHED_FIFO, SCHED_RR
+ * validation-rule: sched_priority must be in [1,99]
+ * validation-rule: sched_nice must be 0
+ * validation-rule: No deadline parameters
+ * validation-group: CFS Policies
+ * validation-policy: SCHED_NORMAL, SCHED_BATCH, SCHED_IDLE
+ * validation-rule: sched_priority must be 0
+ * validation-rule: sched_nice must be in [-20,19]
+ * validation-rule: No deadline parameters
+ * validation-group: Deadline Policy
+ * validation-policy: SCHED_DEADLINE
+ * validation-rule: sched_runtime > 0
+ * validation-rule: sched_deadline >= sched_runtime
+ * validation-rule: sched_period == 0 || sched_period >= sched_deadline
+ * validation-rule: sched_priority must be 0
+ * validation-rule: sched_nice must be 0
+ * validation-group: Utilization Clamping
+ * validation-flag: SCHED_FLAG_UTIL_CLAMP_MIN, SCHED_FLAG_UTIL_CLAMP_MAX
+ * validation-rule: Requires struct version >= 1 (size >= 56)
+ * validation-rule: util values must be in [0,1024]
+ * validation-rule: util_min <= util_max
+ * return-type: KAPI_TYPE_INT
+ * return-check-type: KAPI_RETURN_ERROR_CHECK
+ * return-success: 0
+ * error-code: -EINVAL, EINVAL, Invalid parameters,
+ *   Returned when uattr is NULL, pid < 0, flags != 0,
+ *   attr.size < SCHED_ATTR_SIZE_VER0, invalid scheduling policy,
+ *   invalid priority for policy, invalid sched_flags, or malformed
+ *   sched_attr structure (e.g., DL runtime > deadline)
+ * error-code: -ESRCH, ESRCH, Process not found,
+ *   Returned when the specified pid does not exist
+ * error-code: -EPERM, EPERM, Insufficient privileges,
+ *   Returned when lacking CAP_SYS_NICE for privileged operations,
+ *   trying to change another user's process without CAP_SYS_NICE,
+ *   or resetting SCHED_RESET_ON_FORK flag without privileges
+ * error-code: -E2BIG, E2BIG, Structure size mismatch,
+ *   Returned when sched_attr size is larger than kernel expects
+ * error-code: -EFAULT, EFAULT, Bad user pointer,
+ *   Returned when copying from user space fails or uattr is not
+ *   a valid readable user pointer
+ * error-code: -EBUSY, EBUSY, Bandwidth exceeded,
+ *   Returned when SCHED_DEADLINE bandwidth would be exceeded or
+ *   deadline admission test fails
+ * error-code: -EAGAIN, EAGAIN, Transient failure,
+ *   Returned when unable to change cpus_allowed due to transient
+ *   cpuset or CPU hotplug conditions
+ * error-code: -ENOMEM, ENOMEM, Memory allocation failed,
+ *   Returned when unable to allocate memory for CPU masks
+ * error-code: -EOPNOTSUPP, EOPNOTSUPP, Feature not supported,
+ *   Returned when utilization clamping is requested but
+ *   CONFIG_UCLAMP_TASK is not enabled
+ * since-version: 3.14
+ * lock: rq->lock, KAPI_LOCK_SPINLOCK
+ * lock-acquired: true
+ * lock-released: true
+ * lock-desc: Process runqueue lock for scheduler state changes
+ * lock: p->pi_lock, KAPI_LOCK_SPINLOCK
+ * lock-acquired: true
+ * lock-released: true
+ * lock-desc: Priority inheritance lock for PI chain adjustments
+ * lock: cpuset_mutex, KAPI_LOCK_MUTEX
+ * lock-acquired: true
+ * lock-released: true
+ * lock-desc: Cpuset mutex for SCHED_DEADLINE bandwidth checks
+ * signal: SIGXCPU
+ * signal-direction: KAPI_SIGNAL_SEND
+ * signal-action: KAPI_SIGNAL_ACTION_DEFAULT
+ * signal-condition: SCHED_FLAG_DL_OVERRUN is set and deadline is missed
+ * signal-desc: Sent to task when it exceeds its SCHED_DEADLINE runtime.
+ *   The signal is sent asynchronously from the scheduler tick or
+ *   deadline timer. Unlike other scheduling policies, SCHED_DEADLINE
+ *   can generate SIGXCPU for runtime overruns rather than just
+ *   CPU time limit violations.
+ * signal-timing: KAPI_SIGNAL_TIME_DURING
+ * signal-priority: 0
+ * signal-interruptible: no
+ * signal-state-req: KAPI_SIGNAL_STATE_RUNNING
+ * examples: sched_setattr(0, &attr, 0);  // Set attributes for current task
+ *   sched_setattr(pid, &attr, 0);  // Set attributes for specific task
+ * notes: The sched_attr structure supports forward/backward compatibility
+ *   through its size field. Older kernels ignore newer fields. The syscall
+ *   validates all parameters based on the scheduling policy. For SCHED_DEADLINE,
+ *   it performs CBS (Constant Bandwidth Server) admission control. Priority
+ *   changes may trigger immediate reschedule. RT policies require sched_priority
+ *   in range [1,99]. Normal policies use nice values [-20,19] mapped to
+ *   static_prio. Changes are atomic - either all succeed or none are applied.
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_PROCESS_STATE, task scheduling attributes, Updates policy/priority/deadline parameters atomically, reversible=yes
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_SCHEDULE, runqueue, May requeue task with new priority and trigger reschedule, condition=Task is runnable
+ * side-effect: KAPI_EFFECT_MODIFY_STATE, deadline bandwidth, Allocates CBS bandwidth for SCHED_DEADLINE tasks, condition=Policy is SCHED_DEADLINE, reversible=yes
+ * side-effect: KAPI_EFFECT_MODIFY_STATE, timer slack, Sets timer slack to 0 for RT/DL policies, condition=RT or DEADLINE policy
+ * side-effect: KAPI_EFFECT_MODIFY_STATE, PI chain, Updates priority inheritance chain if task has PI waiters, condition=Task has PI waiters
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_SCHEDULE, CPU, May migrate task to different CPU based on affinity/bandwidth, condition=SCHED_DEADLINE or cpuset changes
+ * state-trans: task->policy, any policy, new policy, Task scheduling policy changes per sched_attr
+ * state-trans: task->rt_priority, any, 0-99 or 0, RT priority updated for RT policies, 0 for others
+ * state-trans: task->normal_prio, any, recalculated, Normal priority recalculated based on policy/nice
+ * state-trans: task->sched_reset_on_fork, 0/1, 0/1, Reset-on-fork flag updated per SCHED_FLAG_RESET_ON_FORK
+ * state-trans: task->dl, inactive/active, active/inactive, Deadline entity activated for SCHED_DEADLINE
+ * capability: CAP_SYS_NICE, KAPI_CAP_BYPASS_CHECK, CAP_SYS_NICE capability
+ * capability-allows: Set RT/DL policies, increase priority, nice < 0, change other users' tasks, remove SCHED_FLAG_RESET_ON_FORK
+ * capability-without: Can only set SCHED_NORMAL/BATCH/IDLE, decrease priority, nice >= 0, modify own tasks
+ * capability-condition: Checked when setting RT/DL policy, decreasing nice, or modifying other user's tasks
+ * capability-priority: 0
+ * constraint: Valid Scheduling Policy, The sched_policy field must be one of: SCHED_NORMAL (0), SCHED_FIFO (1), SCHED_RR (2), SCHED_BATCH (3), SCHED_IDLE (5), SCHED_DEADLINE (6), or SCHED_EXT (7) if configured. Invalid policies result in -EINVAL.
+ * constraint-expr: Valid Scheduling Policy, uattr->sched_policy >= 0 && (uattr->sched_policy <= SCHED_DEADLINE || (uattr->sched_policy == SCHED_EXT && IS_ENABLED(CONFIG_SCHED_CLASS_EXT)))
+ * constraint: RT Priority Range, For SCHED_FIFO and SCHED_RR policies, sched_priority must be in range [1, 99] where 1 is lowest and 99 is highest RT priority. For other policies, sched_priority must be 0.
+ * constraint-expr: RT Priority Range, rt_policy(uattr->sched_policy) ? (uattr->sched_priority >= 1 && uattr->sched_priority <= 99) : (uattr->sched_priority == 0)
+ * constraint: Nice Value Range, For SCHED_NORMAL, SCHED_BATCH, and SCHED_IDLE policies, the nice value must be in range [-20, 19] where -20 is highest priority (least nice) and 19 is lowest priority (most nice).
+ * constraint-expr: Nice Value Range, fair_policy(uattr->sched_policy) ? (uattr->sched_nice >= MIN_NICE && uattr->sched_nice <= MAX_NICE) : 1
+ * constraint: SCHED_DEADLINE CBS Rules, For SCHED_DEADLINE, must satisfy: sched_runtime > 0, sched_deadline >= sched_runtime, sched_period >= sched_deadline. If period is 0, it defaults to deadline.
+ * constraint-expr: SCHED_DEADLINE CBS Rules, dl_policy(uattr->sched_policy) ? (uattr->sched_runtime > 0 && uattr->sched_runtime <= uattr->sched_deadline && (uattr->sched_period == 0 || uattr->sched_period >= uattr->sched_deadline)) : 1
+ * constraint: Utilization Clamping Range, If sched_flags includes SCHED_FLAG_UTIL_CLAMP_MIN/MAX, the util_min and util_max values must be in range [0, 1024] where 1024 represents 100% utilization.
+ * constraint-expr: Utilization Clamping Range, (uattr->sched_flags & SCHED_FLAG_UTIL_CLAMP) ? (uattr->sched_util_min >= 0 && uattr->sched_util_min <= SCHED_CAPACITY_SCALE && uattr->sched_util_max >= 0 && uattr->sched_util_max <= SCHED_CAPACITY_SCALE && uattr->sched_util_min <= uattr->sched_util_max) : 1
+ * constraint: SCHED_DEADLINE Bandwidth, The sum of runtime/period ratios for all SCHED_DEADLINE tasks on the system must not exceed the available CPU capacity. This global bandwidth check prevents system overload.
+ * constraint: Structure Size Compatibility, The attr.size field must be at least SCHED_ATTR_SIZE_VER0 (48 bytes) and no larger than the kernel's known structure size to ensure forward/backward compatibility.
+ *
+ * Context: Process context. May sleep. Takes various scheduler locks.
  */
 SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 			       unsigned int, flags)
-- 
2.39.5


