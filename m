Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB7459679
	for <lists+linux-api@lfdr.de>; Mon, 22 Nov 2021 22:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbhKVVQs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Nov 2021 16:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbhKVVQp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Nov 2021 16:16:45 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7DFC061756
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 13:13:37 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q12so16346802pgh.5
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 13:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKSb/V9pWPXfIUxuyorKDioL/30MA/sUKKbzmiv6cug=;
        b=X/NkfJQgY+6lqUSEm6TXUSFt+L5F29FFtJc8CK7bLVHFyH84TyFPsIzGK70TRgk8qt
         Tj59EABU/ALfRRa3dMk72zLfzsbsg9t7vf+q13duEgbAKTPZvrV85W6NaHw0Y0hZ3/Ci
         kYkNtDgt8TxFqAODV9UkdWbTwteVK3mZhI8FDKI7mC+aq7o4pTdFEYtO4mGZTq4uuw4G
         SUH06Iob0SxcAO/BtBMSe7T0lfyDKr8CUSarD55b3hMypebJiFKVl5sglSbhh1E/QbU9
         LE7Tqo+1FyHdtWaybpcsaKLZgpBbwbMbrCLoRHvjF1lGx2W0KDF2LyugrjKb54uCzEPb
         J6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oKSb/V9pWPXfIUxuyorKDioL/30MA/sUKKbzmiv6cug=;
        b=lGVpIAAY1IbcgTsu1sIzrb9ovigwdrIoY5fOF662hljRKPQVo3icEFVSe15aODGjDw
         s3mAyyhiw/xASstFv2uJoP2vPDnrOw/Ib2ViIzYw5/gIht8Fm63j0J39lxeFu/DwM8Zp
         hW9L0ZDKMlx+aAAKaEwyNWfCEFLZo6gFsf1F3kXDcwM5kmTQ3f+l0oVyTBsOW/OgNUyC
         p2AD8sXpF6Lx/GgNAWPfKu8orbf1L9v3xofjGJ76MoYc+fa2CvNDB8ttKn5gVLmvRuKM
         3haQdk1lH2Vng7LxUTPlL2bcJsqdJSmVMHVlNo0UfL0bTKikQ3HMVDeR7TC7gdq8TT88
         x+Fg==
X-Gm-Message-State: AOAM5318m8h66ugi/ePlKvXEOcBaMnItIPfOkaU87ZlqOO7uVFP6xEml
        RP3Om4skRCvjombYngXeSquxdg==
X-Google-Smtp-Source: ABdhPJydZ1Rl8jHsF1DYpvt/pEEI5SL5CZEmimZTX8jrWZFS80hGZob2tK8mP22yZEM54hlVQTovmQ==
X-Received: by 2002:a05:6a00:26e3:b0:49f:c0ca:850e with SMTP id p35-20020a056a0026e300b0049fc0ca850emr87696142pfw.4.1637615617001;
        Mon, 22 Nov 2021 13:13:37 -0800 (PST)
Received: from posk-p1g4.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id h3sm10453671pfi.207.2021.11.22.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:13:36 -0800 (PST)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH v0.9.1 5/6] sched/umcg: add Documentation/userspace-api/umcg.txt
Date:   Mon, 22 Nov 2021 13:13:26 -0800
Message-Id: <20211122211327.5931-6-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122211327.5931-1-posk@google.com>
References: <20211122211327.5931-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Document User Managed Concurrency Groups syscalls, data structures,
state transitions, etc. in UMGG kernel API.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 Documentation/userspace-api/umcg.txt | 598 +++++++++++++++++++++++++++
 1 file changed, 598 insertions(+)
 create mode 100644 Documentation/userspace-api/umcg.txt

diff --git a/Documentation/userspace-api/umcg.txt b/Documentation/userspace-api/umcg.txt
new file mode 100644
index 000000000000..539b7c6a8962
--- /dev/null
+++ b/Documentation/userspace-api/umcg.txt
@@ -0,0 +1,598 @@
+UMCG API (KERNEL)
+
+User Managed Concurrency Groups (UMCG) is an M:N threading
+subsystem/toolkit that lets user space application developers implement
+in-process user space schedulers.
+
+See tools/lib/umcg/umcg.txt for LIBUMCG API, as opposed to UMCG API (kernel)
+described here. The first three subsections are the same in both documents.
+
+
+CONTENTS
+
+    WHY? HETEROGENEOUS IN-PROCESS WORKLOADS
+    REQUIREMENTS
+    WHY TWO APIS: UMCG (KERNEL) AND LIBUMCG (USERSPACE)?
+    UMCG API (KERNEL)
+    SERVERS
+    WORKERS
+    UMCG TASK STATES
+    STRUCT UMCG_TASK
+    SYS_UMCG_CTL()
+    SYS_UMCG_WAIT()
+    STATE TRANSITIONS
+    SERVER-ONLY USE CASES
+
+
+WHY? HETEROGENEOUS IN-PROCESS WORKLOADS
+
+Linux kernel's CFS scheduler is designed for the "common" use case, with
+efficiency/throughput in mind. Work isolation and workloads of different
+"urgency" are addressed by tools such as cgroups, CPU affinity, priorities,
+etc., which are difficult or impossible to efficiently use in-process.
+
+For example, a single DBMS process may receive tens of thousands requests
+per second; some of these requests may have strong response latency
+requirements as they serve live user requests (e.g. login authentication);
+some of these requests may not care much about latency but must be served
+within a certain time period (e.g. an hourly aggregate usage report); some
+of these requests are to be served only on a best-effort basis and can be
+NACKed under high load (e.g. an exploratory research/hypothesis testing
+workload).
+
+Beyond different work item latency/throughput requirements as outlined
+above, the DBMS may need to provide certain guarantees to different users;
+for example, user A may "reserve" 1 CPU for their high-priority/low-latency
+requests, 2 CPUs for mid-level throughput workloads, and be allowed to send
+as many best-effort requests as possible, which may or may not be served,
+depending on the DBMS load. Besides, the best-effort work, started when the
+load was low, may need to be delayed if suddenly a large amount of
+higher-priority work arrives. With hundreds or thousands of users like
+this, it is very difficult to guarantee the application's responsiveness
+using standard Linux tools while maintaining high CPU utilization.
+
+Gaming is another use case: some in-process work must be completed before a
+certain deadline dictated by frame rendering schedule, while other work
+items can be delayed; some work may need to be cancelled/discarded because
+the deadline has passed; etc.
+
+User Managed Concurrency Groups is an M:N threading toolkit that allows
+constructing user space schedulers designed to efficiently manage
+heterogeneous in-process workloads described above while maintaining high
+CPU utilization (95%+).
+
+
+REQUIREMENTS
+
+One relatively established way to design high-efficiency, low-latency
+systems is to split all work into small on-cpu work items, with
+asynchronous I/O and continuations, all executed on a thread pool with the
+number of threads not exceeding the number of available CPUs. Although this
+approach works, it is quite difficult to develop and maintain such a
+system, as, for example, small continuations are difficult to piece
+together when debugging. Besides, such asynchronous callback-based systems
+tend to be somewhat cache-inefficient, as continuations can get scheduled
+on any CPU regardless of cache locality.
+
+M:N threading and cooperative user space scheduling enables controlled CPU
+usage (minimal OS preemption), synchronous coding style, and better cache
+locality.
+
+Specifically:
+
+* a variable/fluctuating number M of "application" threads should be
+  "scheduled over" a relatively fixed number N of "kernel" threads, where
+  N is less than or equal to the number of CPUs available;
+* only those application threads that are attached to kernel threads are
+  scheduled "on CPU";
+* application threads should be able to cooperatively yield to each other;
+* when an application thread blocks in kernel (e.g. in I/O), this becomes
+  a scheduling event ("block") that the userspace scheduler should be able
+  to efficiently detect, and reassign a waiting application thread to the
+  freeded "kernel" thread;
+* when a blocked application thread wakes (e.g. its I/O operation
+  completes), this event ("wake") should also be detectable by the
+  userspace scheduler, which should be able to either quickly dispatch the
+  newly woken thread to an idle "kernel" thread or, if all "kernel"
+  threads are busy, put it in the waiting queue;
+* in addition to the above, it would be extremely useful for a separate
+  in-process "watchdog" facility to be able to monitor the state of each
+  of the M+N threads, and to intervene in case of runaway workloads
+  (interrupt/preempt).
+
+
+WHY THE TWO APIS: UMCG (KERNEL) AND LIBUMCG (USERSPACE)?
+
+UMCG syscalls, sys_umcg_ctl() and sys_umcg_wait(), are designed to make
+the kernel-side UMCG implementation as lightweight as possible. LIBUMCG,
+on the other hand, is designed to expose the key abstractions to users
+in a much more usable, higher-level way.
+
+See tools/lib/umcg/libumcg.txt for more details on LIBUMCG API.
+
+
+UMCG API (KERNEL)
+
+Based on the requrements above, UMCG API (kernel) is build around the
+following ideas:
+
+* UMCG server: a task/thread representing "kernel threads", or CPUs from
+  the requirements above;
+* UMCG worker: a task/thread representing "application threads", to be
+  scheduled over servers;
+* UMCG task state: (NONE), RUNNING, BLOCKED, IDLE: states a UMCG task (a
+  server or a worker) can be in;
+* UMCG task state flag: LOCKED, PREEMPTED: additional state flags that
+  can be ORed with the task state to communicate additional information to
+  the kernel;
+* struct umcg_task: a per-task userspace set of data fields, usually
+  residing in the TLS, that fully reflects the current task's UMCG state
+  and controls the way the kernel manages the task;
+* sys_umcg_ctl(): a syscall used to register the current task/thread as a
+  server or a worker, or to unregister a UMCG task;
+* sys_umcg_wait(): a syscall used to put the current task to sleep and/or
+  wake another task, pontentially context-switching between the two tasks
+  on-CPU synchronously.
+
+
+SERVERS
+
+When a task/thread is registered as a server, it is in RUNNING state and
+behaves like any other normal task/thread. In addition, servers can
+interact with other UMCG tasks via sys_umcg_wait():
+
+* servers can voluntarily suspend their execution (wait), becoming IDLE;
+* servers can wake other IDLE servers;
+* servers can context-switch between each other.
+
+Note that if a server blocks in the kernel not via sys_umcg_wait(), it
+still retains its RUNNING state.
+
+
+WORKERS
+
+A worker cannot be RUNNING without having a server associated with it, so
+when a task is first registered as a worker, it enters the IDLE state.
+
+* a worker becomes RUNNING when a server calls sys_umcg_wait to
+  context-switch into it; the server goes IDLE, and the worker becomes
+  RUNNING in its place;
+* when a RUNNING worker blocks in the kernel, it becomes BLOCKED, its
+  associated server becomes RUNNING and the server's sys_umcg_wait() call
+  from the bullet above returns; this transition is sometimes called
+  "block detection";
+* when the syscall on which a BLOCKED worker completes, the worker
+  becomes IDLE and is added to the list of idle workers; if there is an
+  idle server waiting, the kernel wakes it; this transition is sometimes
+  called "wake detection";
+* RUNNING workers can voluntarily suspend their execution (wait),
+  becoming IDLE; their associated servers are woken;
+* a RUNNING worker can context-switch with an IDLE worker; the server of
+  the switched-out worker is transferred to the switched-in worker;
+* any UMCG task can "wake" an IDLE worker via sys_umcg_wait(); unless
+  this is a server running the worker as described in the first bullet in
+  this list, the worker remain IDLE but is added to the idle workers list;
+  this "wake" operation exists for completeness, to make sure
+  wait/wake/context-switch operations are available for all UMCG tasks;
+* the userspace can preempt a RUNNING worker by marking it
+  RUNNING|PREEMPTED and sending a signal to it; the userspace should have
+  installed a NOP signal handler for the signal; the kernel will then
+  transition the worker into IDLE|PREEMPTED state and wake its associated
+  server.
+
+
+UMCG TASK STATES
+
+Important: all state transitions described below involve at least two
+steps: the change of the state field in struct umcg_task, for example
+RUNNING to IDLE, and the corresponding change in struct task_struct state,
+for example a transition between the task running on CPU and being
+descheduled and removed from the kernel runqueue. The key principle of UMCG
+API design is that the party initiating the state transition modifies the
+state variable.
+
+For example, a task going IDLE first changes its state from RUNNING to IDLE
+in the userpace and then calls sys_umcg_wait(), which completes the
+transition.
+
+Note on documentation: in include/uapi/linux/umcg.h, task states have the
+form UMCG_TASK_RUNNING, UMCG_TASK_BLOCKED, etc. In this document these are
+usually referred to simply RUNNING and BLOCKED, unless it creates
+ambiguity. Task state flags, e.g. UMCG_TF_PREEMPTED, are treated similarly.
+
+UMCG task states reflect the view from the userspace, rather than from the
+kernel. There are three fundamental task states:
+
+* RUNNING: indicates that the task is schedulable by the kernel; applies
+  to both servers and workers;
+* IDLE: indicates that the task is not schedulable by the kernel (see
+  umcg_idle_loop() in kernel/sched/umcg.c); applies to both servers and
+  workers;
+* BLOCKED: indicates that the worker is blocked in the kernel; does not
+  apply to servers.
+
+In addition to the three states above, two state flags help with state
+transitions:
+
+* LOCKED: the userspace is preparing the worker for a state transition
+  and "locks" the worker until the worker is ready for the kernel to act
+  on the state transition; used similarly to preempt_disable or
+  irq_disable in the kernel; applies only to workers in RUNNING or IDLE
+  state; RUNNING|LOCKED means "this worker is about to become RUNNING,
+  while IDLE|LOCKED means "this worker is about to become IDLE or
+  unregister;
+* PREEMPTED: the userspace indicates it wants the worker to be preempted;
+  there are no situations when both LOCKED and PREEMPTED flags are set at
+  the same time.
+
+
+STRUCT UMCG_TASK
+
+From include/uapi/linux/umcg.h:
+
+struct umcg_task {
+      uint64_t        state_ts;               /* r/w */
+      uint32_t        next_tid;               /* r   */
+      uint32_t        flags;                  /* reserved */
+      uint64_t        idle_workers_ptr;       /* r/w */
+      uint64_t        idle_server_tid_ptr;    /* r*  */
+};
+
+Each UMCG task is identified by struct umcg_task, which is provided to the
+kernel when the task is registered via sys_umcg_ctl().
+
+* uint64_t state_ts: the current state of the task this struct
+  identifies, as described in the previous section, combined with a
+  unique timestamp indicating when the last state change happened.
+
+  Readable/writable by both the kernel and the userspace.
+
+    bits  0 -  5: task state (RUNNING, IDLE, BLOCKED);
+    bits  6 -  7: state flags (LOCKED, PREEMPTED);
+    bits  8 - 12: reserved; must be zeroes;
+    bits 13 - 17: for userspace use;
+    bits 18 - 63: timestamp.
+
+   Timestamp: a 46-bit CLOCK_MONOTONIC timestamp, at 16ns resolution.
+
+   It is highly benefitical to tag each state change with a unique
+   timestamp:
+
+   - timestamps will naturally provide instrumentation to measure
+     scheduling delays, both in the kernel and in the userspace;
+   - uniqueness of timestamps (module overflow) guarantees that state
+     change races, especially ABA races, are easily detected and avoided.
+
+   Each timestamp represents the moment in time the state change happened,
+   in nanoseconds, with the lower 4 bits and the upper 16 bits stripped.
+
+   In this document 'umcg_task.state' is often used to talk about
+   'umcg_task.state_ts' field, as timestamps do not carry semantic
+   meaning at the moment.
+
+   This is how umcg_task.state_ts is updated in the kernel:
+
+    /* kernel side */
+    /**
+     * umcg_update_state: atomically update umcg_task.state_ts, set new timestamp.
+     * @state_ts   - points to the state_ts member of struct umcg_task to update;
+     * @expected   - the expected value of state_ts, including the timestamp;
+     * @desired    - the desired value of state_ts, state part only;
+     * @may_fault  - whether to use normal or _nofault cmpxchg.
+     *
+     * The function is basically cmpxchg(state_ts, expected, desired), with extra
+     * code to set the timestamp in @desired.
+     */
+    static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired,
+                                    bool may_fault)
+    {
+            u64 curr_ts = (*expected) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
+            u64 next_ts = ktime_get_ns() >> UMCG_STATE_TIMESTAMP_GRANULARITY;
+
+            /* Cut higher order bits. */
+            next_ts &= ((1ULL << UMCG_STATE_TIMESTAMP_BITS) - 1);
+
+            if (next_ts == curr_ts)
+                    ++next_ts;
+
+            /* Remove an old timestamp, if any. */
+            desired &= ((1ULL << (64 - UMCG_STATE_TIMESTAMP_BITS)) - 1);
+
+            /* Set the new timestamp. */
+            desired |= (next_ts << (64 - UMCG_STATE_TIMESTAMP_BITS));
+
+            if (may_fault)
+                    return cmpxchg_user_64(state_ts, expected, desired);
+
+            return cmpxchg_user_64_nofault(state_ts, expected, desired);
+    }
+
+* uint32_t next_tid: contains the TID of the task to context-switch-into
+  in sys_umcg_wait(); can be zero; writable by the userspace, readable by
+  the kernel; if this is a RUNNING worker, this field contains the TID of
+  the server that should be woken when this worker blocks; see
+  sys_umcg_wait() for more details;
+
+* uint32_t flags: reserved; must be zero.
+
+* uint64_t idle_workers_ptr: this field forms a single-linked list of
+  idle workers: all RUNNING workers have this field set to point to the
+  head of the list (a pointer variable in the userspace).
+
+  When a worker's blocking operation in the kernel completes, the kernel
+  changes the worker's state from BLOCKED to IDLE and adds the worker to
+  the top of the list of idle workers using this logic:
+
+    /* kernel side */
+    /**
+     * enqueue_idle_worker - push an idle worker onto idle_workers_ptr
+     * list/stack.
+     *
+     * Returns true on success, false on a fatal failure.
+     */
+    static bool enqueue_idle_worker(struct umcg_task __user *ut_worker)
+    {
+        u64 __user *node = &ut_worker->idle_workers_ptr;
+        u64 __user *head_ptr;
+        u64 first = (u64)node;
+        u64 head;
+
+        if (get_user_nosleep(head, node) || !head)
+                return false;
+
+        head_ptr = (u64 __user *)head;
+
+        if (put_user_nosleep(UMCG_IDLE_NODE_PENDING, node))
+                return false;
+
+        if (xchg_user_64(head_ptr, &first))
+                return false;
+
+        if (put_user_nosleep(first, node))
+                return false;
+
+        return true;
+    }
+
+  In the userspace the list is cleared atomically using this logic:
+
+    /* userspace side */
+    uint64_t *idle_workers = (uint64_t *)*head;
+
+    atomic_exchange(&idle_workers, NULL);
+
+  The userspace re-points workers' idle_workers_ptr to the list head
+  variable before the worker is allowed to become RUNNING again.
+
+  When processing the idle workers list, the userspace should wait for
+  workers marked as UMCG_IDLE_NODE_PENDING to have the flag cleared (see
+  enqueue_idle_worker() above).
+
+* uint64_t idle_server_tid_ptr: points to a variable in the userspace
+  that points to an idle server, i.e. a server in IDLE state waiting in
+  sys_umcg_wait(); read-only; workers must have this field set; not used
+  in servers.
+
+  When a worker's blocking operation in the kernel completes, the kernel
+  changes the worker's state from BLOCKED to IDLE, adds the worker to the
+  list of idle workers, and wakes the idle server if present; the kernel
+  atomically exchanges (*idle_server_tid_ptr) with 0, thus waking the idle
+  server, if present, only once. See State transitions below for more
+  details.
+
+
+SYS_UMCG_CTL()
+
+int sys_umcg_ctl(uint32_t flags, struct umcg_task *self) is used to
+register or unregister the current task as a worker or server. Flags can be
+one of the following:
+
+    UMCG_CTL_REGISTER: register a server;
+    UMCG_CTL_REGISTER | UMCG_CTL_WORKER: register a worker;
+    UMCG_CTL_UNREGISTER: unregister the current server or worker.
+
+When registering a task, self must point to struct umcg_task describing
+this server or worker; the pointer must remain valid until the task is
+unregistered.
+
+When registering a server, self->state must be RUNNING; all other fields in
+self must be zeroes.
+
+When registering a worker, self->state must be BLOCKED;
+self->idle_server_tid_ptr and self->idle_workers_ptr must be valid pointers
+as described in struct umcg_task; self->next_tid must be zero.
+
+When unregistering a task, self must be NULL.
+
+
+SYS_UMCG_WAIT()
+
+int sys_umcg_wait(uint32_t flags, uint64_t abs_timeout) operates on
+registered UMCG servers and workers: struct umcg_task *self provided to
+sys_umcg_ctl() when registering the current task is consulted in addition
+to flags and abs_timeout parameters.
+
+The function can be used to perform one of the three operations:
+
+* wait: if self->next_tid is zero, sys_umcg_wait() puts the current
+  task to sleep;
+* wake: if self->next_tid is not zero, and flags & UMCG_WAIT_WAKE_ONLY,
+  the task identified by next_tid is woken;
+* context switch: if self->next_tid is not zero, and !(flags &
+  UMCG_WAIT_WAKE_ONLY), the current task is put to sleep and the next task
+  is woken, synchronously switching between the tasks on the current CPU
+  on the fast path.
+
+Flags can be zero or a combination of the following values:
+
+* UMCG_WAIT_WAKE_ONLY: wake the next task, don't put the current task to
+  sleep;
+* UMCG_WAIT_WF_CURRENT_CPU: wake the next task on the curent CPU; this
+  flag has an effect only if UMCG_WAIT_WAKE_ONLY is set: context switching
+  is always attempted to happen on the curent CPU.
+
+The section below provides more details on how servers and workers interact
+via sys_umcg_wait(), during worker block/wake events, and during worker
+preemption.
+
+
+STATE TRANSITIONS
+
+As mentioned above, the key principle of UMCG state transitions is that the
+party initiating the state transition modifies the state of affected tasks.
+
+Below, "TASK:STATE" indicates a task T, where T can be either W for worker
+or S for server, in state S, where S can be one of the three states,
+potentially ORed with a state flag. Each individual state transition is an
+atomic operation (cmpxchg) unless indicated otherwise. Also note that the
+order of state transitions is important and is part of the contract between
+the userspace and the kernel. The kernel is free to kill the task (SIGKILL)
+if the contract is broken.
+
+Some worker state transitions below include adding LOCKED flag to worker
+state. This is done to indicate to the kernel that the worker is
+transitioning state and should not participate in the block/wake detection
+routines, which can happen due to interrupts/pagefaults/signals.
+
+IDLE|LOCKED means that a running worker is preparing to sleep, so
+interrupts should not lead to server wakeup; RUNNING|LOCKED means that an
+idle worker is going to be "scheduled to run", but may not yet have its
+server set up properly.
+
+The key invariant: a RUNNING worker (not LOCKED) must have a server
+assigned to it.
+
+Key state transitions:
+
+* server to worker context switch ("schedule a worker to run"):
+  S:RUNNING+W:IDLE => S:IDLE+W:RUNNING:
+        in the userspace, in the context of the server S running:
+            S:RUNNING => S:IDLE (mark self as idle)
+            W:IDLE => W:RUNNING|LOCKED (mark the worker as running)
+            W.next_tid := S.tid; S.next_tid := W.tid (link the server with
+                the worker)
+            W:RUNNING|LOCKED => W:RUNNING (unlock the worker)
+            S: sys_umcg_wait() (make the syscall)
+        the kernel context switches from the server to the worker; the
+        server sleeps until it becomes RUNNING during one of the
+        transitions below;
+
+* worker to server context switch (worker "yields"): S:IDLE+W:RUNNING =>
+S:RUNNING+W:IDLE:
+        in the userspace, in the context of the worker W running (note that
+        a running worker has its next_tid set to point to its server):
+            W:RUNNING => W:IDLE|LOCKED (mark self as idle)
+            S:IDLE => S:RUNNING (mark the server as running)
+            W: sys_umcg_wait() (make the syscall)
+        the kernel removes the LOCKED flag from the worker's state and
+        context switches from the worker to the server; the worker sleeps
+        until it becomes RUNNING;
+
+* worker to worker context switch: W1:RUNNING+W2:IDLE =>
+  W1:IDLE+W2:RUNNING:
+        in the userspace, in the context of W1 running:
+            W2:IDLE => W2:RUNNING|LOCKED (mark W2 as running)
+            W1:RUNNING => W1:IDLE|LOCKED (mark self as idle)
+            W2.next_tid := W1.next_tid; S.next_tid := W2.tid (transfer the
+                server W1 => W2)
+            W1:next_tid := W2.tid (indicate that W1 should context-switch
+                into W2)
+            W2:RUNNING|LOCKED => W2:RUNNING (unlock W2)
+            W1: sys_umcg_wait() (make the syscall)
+        same as above, the kernel removes the LOCKED flag from the W1's
+        state and context switches to next_tid;
+
+* worker wakeup: W:IDLE => W:IDLE, W queued into the idle worker list:
+        in the userspace, a server S can wake a worker W sleeping in
+        sys_umcg_wait() without "running" it. This is a purely
+        userspace operation that adds the worker to the idle worker list.
+
+* block detection: worker blocks in the kernel: S:IDLE+W:RUNNING =>
+  S:RUNNING+W:BLOCKED:
+        when a worker blocks in the kernel in RUNNING state (not LOCKED),
+        before descheduling the task from the CPU the kernel performs
+        these operations:
+            W:RUNNING => W:BLOCKED
+            S := W.next_tid
+            S:IDLE => S:RUNNING
+            try_to_wake_up(S)
+        if any of the first three operations above fail, the worker is
+        killed via SIGKILL. Note that ttwu(S) is not required to succeed,
+        as the server may still be transitioning to sleep in
+        sys_umcg_wait(); before actually putting the server to sleep its
+        UMCG state is checked and, if it is RUNNING, sys_umcg_wait()
+        returns to the userspace;
+        if the worker has its LOCKED flag set, block detection does not
+        trigger, as the worker is assumed to be in the userspace
+        scheduling code.
+
+* wake detection: worker wakes in the kernel: W:BLOCKED => W:IDLE:
+        all workers' returns to the userspace are intercepted:
+            start: (a label)
+            if W:RUNNING & W.next_tid != 0: let the worker exit to the
+                userspace, as this is a RUNNING worker with a server;
+            W:* => W:IDLE (previously blocked or woken without servers
+                workers are not allowed to return to the userspace);
+            the worker is appended to W.idle_workers_ptr idle workers list;
+            S := *W.idle_server_tid_ptr; if (S != 0) S:IDLE => S.RUNNING;
+                ttwu(S)
+            idle_loop(W): this is the same idle loop that sys_umcg_wait()
+                uses: it breaks only when the worker becomes RUNNING; when
+                the idle loop exits, it is assumed that the userspace has
+                properly removed the worker from the idle workers list
+                before marking it RUNNING;
+            goto start; (repeat from the beginning).
+
+        the logic above is a bit more complicated in the presence of
+        LOCKED or PREEMPTED flags, but the main invariants
+        stay the same:
+            only RUNNING workers with servers assigned are allowed to run
+                in the userspace (unless LOCKED);
+            newly IDLE workers are added to the idle workers list; any
+                user-initiated state change assumes the userspace
+                properly removed the worker from the list;
+            as with wake detection, any "breach of contract" by the
+                userspace will result in the task termination via SIGKILL.
+
+* worker preemption: S:IDLE+W:RUNNING => S:RUNNING+W:IDLE|PREEMPTED:
+        when the userspace wants to preempt a RUNNING worker, it changes it
+        state, atomically, RUNNING => RUNNING|PREEMPTED and sends a
+        signal to the worker via tgkill(); the signal handler, previously
+        set up by the userspace, can be a NOP (note that only RUNNING
+        workers can be preempted);
+
+        if the worker, at the moment the signal arrived, continued to be
+        running on-CPU in the userspace, the "wake detection" code will be
+        triggered that, in addition to what was described above, will
+        check if the worker is in RUNNING|PREEMPTED state:
+            W:RUNNING|PREEMPTED => W:IDLE|PREEMPTED
+            S := W.next_tid
+            S:IDLE => S:RUNNING
+            try_to_wakeup(S)
+
+        if the signal arrives after the worker blocks in the kernel,
+        the "block detection" happened as described above, with the
+        following change:
+            W:RUNNING|PREEMPTED => W:BLOCKED|PREEMPTED
+            S := W.next_tid
+            S:IDLE => S:RUNNING
+            try_to_wake_up(S)
+
+        in any case, the worker's server is woken, with its attached
+        worker (S.next_tid) either in BLOCKED|PREEMPTED or IDLE|PREEMPTED
+        state.
+
+
+SERVER-ONLY USE CASES
+
+Some workloads/applications may benefit from fast and synchronous on-CPU
+user-initiated context switches without the need for full userspace
+scheduling (block/wake detection). These applications can use "standalone"
+UMCG servers to wait/wake/context-switch. At the moment only in-process
+operations are allowed. In the future this restriction will be lifted,
+and wait/wake/context-switch operations between servers in related processes
+be permitted (when it is safe to do so, e.g. if the processes belong
+to the same user and/or cgroup).
+
+These "worker-less" operations involve trivial RUNNING <==> IDLE state
+changes, not discussed here for brevity.
--
2.25.1

