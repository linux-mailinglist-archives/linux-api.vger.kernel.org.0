Return-Path: <linux-api+bounces-4158-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F684B06486
	for <lists+linux-api@lfdr.de>; Tue, 15 Jul 2025 18:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EA3188DE42
	for <lists+linux-api@lfdr.de>; Tue, 15 Jul 2025 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A662777F1;
	Tue, 15 Jul 2025 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMeWzDhg"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602E1EA7D2;
	Tue, 15 Jul 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597758; cv=none; b=JIBsuNM/jr0grusrzmkQT4SrvfSjOQA/mfGAm67NaeU81wF9ktiVGH5HaEPrV4IbG94WvzPH1//7PWQyUmi7TQgFGqgSb4JyKn40DaRK65XMoMp3CL1/XHOIImA91oVOGjnx/d/vzliIYe9hQXQWWrnPJnms4fn7ADbVDQMEr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597758; c=relaxed/simple;
	bh=TPUhTQYoGJnvLAjJ+OXXmgWuBxJHybKodUSVwfyXqRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qG8fw+Ch+WJsXzvWd9eo5UQXbsfkIt0OpuxULoTmOFxU3Ss2PAdXi0wTrmHwxH4p92c2rV8AX1K05XTgh/54LeTN5pSwPfdAw7YmSx4vnXkTuPBzx3od1NdMFYWtRYnOMB7coEGJKHZMKkWS2tepQSbz8TkDZHcQVzaboheqW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMeWzDhg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acb5ec407b1so1011471966b.1;
        Tue, 15 Jul 2025 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752597755; x=1753202555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SymSV/e36/hkT0Dwb30Y9z4/6bpYXKF6g8wiS6N+Kj0=;
        b=DMeWzDhgFhKsEBJutBKUIZPSE6uHBhe/ZGfdW55tQHwJmhFh9E+tavkbrqyjSs2CKn
         fQlJSqI1WqRM9QlrXrd+SGfPmc6LEgbUgRoaHNctOeZMw7xuSZidQstbXqZf7KJ+GVsW
         9EIlEf4qNFLCrtXXacj47XYGZVf+oayqEwzOiZFYgdsx7rae8k/0SJXi8mEj/gBX21hC
         RMTEm6EHHt0l1ak7EfnFGItymbQdwqfzU+37Y5QW9SOKA6xEILj3gUkC1BU9CDwFG+53
         1m1UF33igptEgemudROQNafExccrkgnF0+6w3RQUlbGfvxF5zWA7pAosuWL2dsmPpwjR
         qCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597755; x=1753202555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SymSV/e36/hkT0Dwb30Y9z4/6bpYXKF6g8wiS6N+Kj0=;
        b=SRCk+biRmrfebQ6SSfOdD4EDMo48UBiqOU/RG1wS3KfXOZCnVZMBLf445KwhvnKH7D
         QzEA2/wtyRyOvebX6SOSoiGivcpWPsj4dRCIwWUFfqtLdWvABbbc2K02VCnWpyueiQMv
         EE/lL2YctqC3vRw4L7I0BcZ+ElE5eN6RWmSMDWXgaIK+Q9u+FZVp5QvCJGnaAzsaJuB4
         V53AfakGkCYVk4kNFEnJaL2IdcfcoLpy/MYLp2E/GgubQMuT7B8wVjaONXxukbXPGDuW
         58hpg8OyTupB1//+Wldfo01LqqUz37w9p3vrB3DyL7HbFjVkPNjBSMlUAt2hefKQC953
         VaDg==
X-Forwarded-Encrypted: i=1; AJvYcCXRLcQ3HKH4u3oemiOpAG5w2Ug2i35Ty9hyGk0Uq3Mpd9g0ut0wvEr6qPlRUFw5r/920P+IG9Fxp8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFztrR5qwVPgtxZpitNT34mprki2vuwjm718dXZwXg/kwQ2lfE
	OqqQjwWgnxlCtR+1sfTrFnZzfGlf7al06LPXsvZEC7btdxxu3Fl5m4hC
X-Gm-Gg: ASbGncs04yQBP0tGqQmZRZ3cRPErCSaiS/NdjnwHv8wsYrHXplLSRhSB4Be/uByM92n
	WrEc1nYRrSkjCVGB3sJ9S7x7OsXv61nOm7CXVhRAal2r/bnjps6rgS/kCJMCvZFSwAvbCVCLpLp
	ce10IHCXgjNOoEXILbszTFJM/xyHvN7jc92mHhgia5M4LlCjFkju6TVVkockzh0f2yqo/54O0e2
	fvj6FSg2e+7WhumHQ3MeChZ4OyHJb+jyRZx44qMyGNsIbkrdUd93aedkvV2cfZ8qWmgKOqxs0xj
	/JChKdoHWejLuUkU2ZtzOBNMb8L9J5qUX63MCwSFdAgF0nX3EO0qnUA7/00D/iuNt3dQnnLOmST
	KAtWS29NDpR9oT9NJhCb+yqi12kYXUYNbJEdIIis=
X-Google-Smtp-Source: AGHT+IHlWkyrdZVzSfi18e1LifRy3TtQLG75/9l0Me07g3QsJX5sWOIj8V7lYPeTkSt/AIFSz1A6aw==
X-Received: by 2002:a17:907:d24:b0:ad5:a121:6ebc with SMTP id a640c23a62f3a-ae9c97a56bdmr25910966b.0.1752597754902;
        Tue, 15 Jul 2025 09:42:34 -0700 (PDT)
Received: from laptom.retis ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7c09dfdsm1021672766b.0.2025.07.15.09.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:42:34 -0700 (PDT)
From: Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
X-Google-Original-From: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: [PATCH] sched/deadline: sched_getattr(...flags=1) returns the runtime left and abs deadline for DEADLINE tasks
Date: Tue, 15 Jul 2025 18:39:29 +0200
Message-ID: <20250715164148.1151620-1-tommaso.cucinotta@santannapisa.it>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SCHED_DEADLINE scheduler allows reading the statically configured
run-time, deadline, and period parameters through the sched_getattr()
system call. However, there is no immediate way to access, from user space,
the current parameters used within the scheduler: the instantaneous runtime
left in the current cycle, as well as the current absolute deadline.

The `flags' sched_getattr() parameter, so far mandated to contain zero,
now supports the SCHED_GETATTR_FLAG_DL_DYNAMIC=1 flag, to request
retrieval of the leftover runtime and absolute deadline, converted to a
CLOCK_MONOTONIC reference, instead of the statically configured parameters.

This feature is useful for adaptive SCHED_DEADLINE tasks that need to
modify their behavior depending on whether or not there is enough runtime
left in the current period, and/or what is the current absolute deadline.

Notes:
- before returning the instantaneous parameters, the runtime is updated;
- the abs deadline is returned shifted from rq_clock() to ktime_get_ns(),
  in CLOCK_MONOTONIC reference; this causes multiple invocations from the
  same period to return values that may differ for a few ns (showing some
  small drift), albeit the deadline doesn't move, in rq_clock() reference;
- the abs deadline value returned to user-space, as unsigned 64-bit value,
  can represent nearly 585 years since boot time;
- setting flags=0 provides the old behavior (retrieve static parameters).

See also the notes from discussion held at OSPM 2025 on the topic
"Making user space aware of current deadline-scheduler parameters":
https://lwn.net/Articles/1022054/

Signed-off-by: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
---
 include/uapi/linux/sched.h |  3 +++
 kernel/sched/deadline.c    | 18 +++++++++++++++---
 kernel/sched/sched.h       |  2 +-
 kernel/sched/syscalls.c    | 16 +++++++++++-----
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 359a14cc..52b69ce8 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -146,4 +146,7 @@ struct clone_args {
 			 SCHED_FLAG_KEEP_ALL		| \
 			 SCHED_FLAG_UTIL_CLAMP)
 
+/* Only for sched_getattr() own flag param, if task is SCHED_DEADLINE */
+#define SCHED_GETATTR_FLAG_DL_DYNAMIC	0x01
+
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9c7d9528..1b5cd7fa 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3290,13 +3290,25 @@ void __setparam_dl(struct task_struct *p, const struct sched_attr *attr)
 	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
 }
 
-void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
+void __getparam_dl(struct task_struct *p, struct sched_attr *attr, unsigned int flags)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
+	struct rq *rq = task_rq(p);
+	u64 adj_deadline;
 
 	attr->sched_priority = p->rt_priority;
-	attr->sched_runtime = dl_se->dl_runtime;
-	attr->sched_deadline = dl_se->dl_deadline;
+	if (flags & SCHED_GETATTR_FLAG_DL_DYNAMIC) {
+		guard(raw_spinlock_irq)(&rq->__lock);
+		update_rq_clock(rq);
+		update_curr_dl(rq);
+
+		attr->sched_runtime = dl_se->runtime;
+		adj_deadline = dl_se->deadline - rq_clock(rq) + ktime_get_ns();
+		attr->sched_deadline = adj_deadline;
+	} else {
+		attr->sched_runtime = dl_se->dl_runtime;
+		attr->sched_deadline = dl_se->dl_deadline;
+	}
 	attr->sched_period = dl_se->dl_period;
 	attr->sched_flags &= ~SCHED_DL_FLAGS;
 	attr->sched_flags |= dl_se->flags;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3058fb62..f69bf019 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -353,7 +353,7 @@ extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
 extern int  sched_dl_overflow(struct task_struct *p, int policy, const struct sched_attr *attr);
 extern void __setparam_dl(struct task_struct *p, const struct sched_attr *attr);
-extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
+extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr, unsigned int flags);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f3..c80b3568 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -928,10 +928,10 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	return -E2BIG;
 }
 
-static void get_params(struct task_struct *p, struct sched_attr *attr)
+static void get_params(struct task_struct *p, struct sched_attr *attr, unsigned int flags)
 {
 	if (task_has_dl_policy(p)) {
-		__getparam_dl(p, attr);
+		__getparam_dl(p, attr, flags);
 	} else if (task_has_rt_policy(p)) {
 		attr->sched_priority = p->rt_priority;
 	} else {
@@ -997,7 +997,7 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 		return -ESRCH;
 
 	if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
-		get_params(p, &attr);
+		get_params(p, &attr, 0);
 
 	return sched_setattr(p, &attr);
 }
@@ -1082,7 +1082,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	int retval;
 
 	if (unlikely(!uattr || pid < 0 || usize > PAGE_SIZE ||
-		      usize < SCHED_ATTR_SIZE_VER0 || flags))
+		     usize < SCHED_ATTR_SIZE_VER0))
 		return -EINVAL;
 
 	scoped_guard (rcu) {
@@ -1090,6 +1090,12 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		if (!p)
 			return -ESRCH;
 
+		if (flags) {
+			if (!task_has_dl_policy(p)
+			    || flags != SCHED_GETATTR_FLAG_DL_DYNAMIC)
+				return -EINVAL;
+		}
+
 		retval = security_task_getscheduler(p);
 		if (retval)
 			return retval;
@@ -1097,7 +1103,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		kattr.sched_policy = p->policy;
 		if (p->sched_reset_on_fork)
 			kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
-		get_params(p, &kattr);
+		get_params(p, &kattr, flags);
 		kattr.sched_flags &= SCHED_FLAG_ALL;
 
 #ifdef CONFIG_UCLAMP_TASK
-- 
2.45.2


