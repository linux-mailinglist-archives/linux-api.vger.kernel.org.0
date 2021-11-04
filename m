Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E044445AD5
	for <lists+linux-api@lfdr.de>; Thu,  4 Nov 2021 20:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhKDUBS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Nov 2021 16:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhKDUA4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Nov 2021 16:00:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95657C06120C
        for <linux-api@vger.kernel.org>; Thu,  4 Nov 2021 12:58:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p18so9009845plf.13
        for <linux-api@vger.kernel.org>; Thu, 04 Nov 2021 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B00tJn5rnYuWYSpk3zTcunA3N+4r514ND/7t0xIcXv8=;
        b=ShUZ5B1XhwuMGvWWFnCKj17Or2bjFt5ogDB9XoG9JFtn1ISgGtznB2xI6DRyqrr5v5
         mPD4HFYlq977Z59e6v1Qc7nitUg+LOkql47m+x20o7hxvvKcVclX0gYXPITTh5gnPaC3
         GMaobeg7HRkPgrx3DJwLT7wzdvWluSJC0eg9niStV9/rhZVjPWpFZ1TgN/42ImhSfU5r
         txina07rQXhpCyXKtyTrd/B9zvb5V8Iv9P7YGxGG4LLWKVnvIaE2HxPFXdW9qvyJ/BwC
         AR2xNNKq9I6/zrEx7TVgFp3sdCktqfQbAFzEdjXjP4HIKYwFQE8YkEtoloYkRI1htCHp
         qSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B00tJn5rnYuWYSpk3zTcunA3N+4r514ND/7t0xIcXv8=;
        b=FpQUXUWZz13r0VpqknvZyMiEsBmpxLiyjClL9D6Z3ZoUEGChy8qGKfCyiCW+mxXJlt
         XfT9h8qZiLV9HsJEhI8tn/fxIAt78GAp/h5L3c/ETnrd4XfYpUk9rVUlZTgpLTejivzr
         y1hQhIM4UVsNu7TqHRCW0VqUnBPCbV4fBl3HYEbldFZAgp2HFB6zaLOp7pkfUU0+SowJ
         /v1pZtuRK9IeXaieO3Rytc0QE+bP5NGpeXTI0KI1WV5sGlIg4Z7LKX5NAs2mV0OTC53R
         wkfeOcF/7PHhCDHjISk+bUIl4ReSPwS8AP3hpv7Zi6FinYq1j3w9fVe4D34VjWjjKqBh
         7teQ==
X-Gm-Message-State: AOAM530BU//d4rR1Af4VSmaMgjKjVrPkG6LI8sMsDPm58mJTcqfjpSv6
        n2RYB7G95XGedDHHUds/OeHquQ==
X-Google-Smtp-Source: ABdhPJw6DxvrsZ+nRqV0+hsU0V3j2lz0cnHEyutLBt7+C5pF4D98c+1BT8Lv6cuBHJKavnKvym5W1w==
X-Received: by 2002:a17:903:2291:b0:142:b53:6e08 with SMTP id b17-20020a170903229100b001420b536e08mr18969482plh.10.1636055896673;
        Thu, 04 Nov 2021 12:58:16 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id w185sm5487853pfb.38.2021.11.04.12.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 12:58:16 -0700 (PDT)
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
Subject: [PATCH v0.8 6/6] sched/umcg, lib/umcg: add tools/lib/umcg/libumcg.txt
Date:   Thu,  4 Nov 2021 12:58:04 -0700
Message-Id: <20211104195804.83240-7-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104195804.83240-1-posk@google.com>
References: <20211104195804.83240-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Document libumcg.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 tools/lib/umcg/libumcg.txt | 438 +++++++++++++++++++++++++++++++++++++
 1 file changed, 438 insertions(+)
 create mode 100644 tools/lib/umcg/libumcg.txt

diff --git a/tools/lib/umcg/libumcg.txt b/tools/lib/umcg/libumcg.txt
new file mode 100644
index 000000000000..06f509bf5341
--- /dev/null
+++ b/tools/lib/umcg/libumcg.txt
@@ -0,0 +1,438 @@
+LIBUMCG API (USERSPACE)
+
+User Managed Concurrency Groups (UMCG) is an M:N threading
+subsystem/toolkit that lets user space application developers implement
+in-process user space schedulers.
+
+See Documentation/userspace-api/umcg.txt for UMCG API (kernel), as opposed
+to LIBUMCG API described here. The first three subsections are the
+same in both documents.
+
+
+CONTENTS
+
+    WHY? HETEROGENEOUS IN-PROCESS WORKLOADS
+    REQUIREMENTS
+    WHY THE TWO APIS: UMCG (KERNEL) AND LIBUMCG (USERSPACE)?
+    LIBUMCG API (USERSPACE)
+        SERVERS
+        WORKERS
+        BASIC UMCG TASKS
+    LIBUMCG API
+        umcg_t
+        umcg_tid
+        UMCG_NONE
+        umcg_enabled()
+        umcg_get_utid()
+        umcg_set_task_tag()
+        umcg_get_task_tag()
+        umcg_create_group()
+        umcg_destroy_group()
+        umcg_register_basic_task()
+        umcg_register_worker()
+        umcg_register_server()
+        umcg_unregister_task()
+        umcg_wait()
+        umcg_wake()
+        umcg_swap()
+        umcg_get_idle_worker()
+        umcg_run_worker()
+        umcg_preempt_worker()
+        umcg_get_time_ns()
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
+See Documentation/userspace-api/umcg.txt for more details on
+UMCG API (kernel).
+
+Please note that LIBUMCG API is itself a rather low-level API intended
+to be used to construct higher-level userspace schedulers.
+
+Note: to avoid confusion, in this document "UMCG servers/workers" refer
+UMCG tasks when considered in the context of the kernel UMCG API (syscalls),
+while "LIBUMCG servers/workers" refer to the same tasks when considered
+in the context of the userspace LIBUMC API outlined below. When the
+distinction is not important, "UMCG servers/workers" is used generically.
+
+
+LIBUMCG API (USERSPACE)
+
+Based on the requrements above, LIBUMCG API (userspace) is build around the
+following ideas:
+
+* UMCG server: a thread representing "kernel threads", or CPUs from
+  the requirements above;
+* UMCG worker: a thread representing "application threads", to be
+  scheduled over servers;
+* UMCG group: a collection of servers and workers that can interact with
+  each other; a single process may contain several UMCG groups (e.g. a
+  group per NUMA node);
+* a set of functions (API) that allows workers to be "scheduled" over
+  servers and to interact with one another cooperatively.
+
+
+LIBUMCG SERVERS
+
+When a thread is registered as a server, it behaves like any other normal
+thread.
+
+Servers can interact with other servers in the same UMCG group:
+
+* servers can voluntarily suspend their execution by calling umcg_wait();
+* servers can wake other servers by calling umcg_wake();
+* servers can context-switch between each other by calling umcg_swap().
+
+Servers can also interact with workers in their UMCG group:
+
+* servers can schedule ("run") workers in their place by calling
+  umcg_run_worker(); when the worker blocks, the function returns;
+* servers can query for workers that finished their blocking operations
+  by calling umcg_get_idle_worker();
+* servers can force running workers into idle state and have the
+  servers running those workers to wakeup by calling umcg_preempt_worker().
+
+
+LIBUMCG WORKERS
+
+A worker cannot be running without having a server associated with it, so
+when a task is first registered as a worker, it is blocked until a server
+"runs" it (new workers are added to the idle worker list).
+
+Workers can interact with other workers in their UMCG group:
+
+* workers can voluntarily suspend their execution by calling umcg_wait();
+* workers can wake other workers by calling umcg_wake();
+* workers can context-switch between each other by calling umcg_swap().
+
+
+LIBUMCG BASIC UMCG TASKS
+
+If the application is only interested in server-to-server interactions,
+it does not need to create a UMCG group and may register a server as a
+"basic UMCG task". Same umcg_[wait|wake|swap] functions are available.
+
+
+LIBUMCG API: umcg_t
+
+umcg_t is an opaque pointer indicating a UMCG group.
+
+
+LIBUMCG API: umcg_tid
+
+umcg_tid is an opaque pointer indicating a UMCG task (a basic task,
+a server, or a worker).
+
+
+LIBUMCG API: UMCG_NONE
+
+UMCG_NONE holds a NULL value for variables of type umcg_t or umcg_tid.
+
+
+LIBUMCG API: umcg_enabled()
+
+bool umcg_enabled(void) - returns true if the running kernel exposes
+                          UMCG kernel API (sys_umcg_ctl and sys_umcg_wait).
+
+
+LIBUMCG API: umcg_get_utid
+
+umcg_tid umcg_get_utid(void) - returns the umcg_tid value identifying
+                               the current thread as a UMCG task. The value
+                               is guaranteed to be stable over the life
+                               of the thread, but may be reused between
+                               different threads (it is a pointer to a TLS
+                               variable).
+
+
+LIBUMCG API: umg_set_task_tag()
+
+void umcg_set_task_tag(umcg_tid utid, intptr_t tag) - a helper function
+                       used to associate an arbitrary user-provided value
+                       with a umcg task/thread.
+
+
+LIBUMCG API: umcg_get_task_tag()
+
+intptr_t umcg_get_task_tag(umcg_tid utid) - returns a previously set
+                           task tag, or zero.
+
+
+LIBUMCG API: umcg_create_group()
+
+umcg_t umcg_create_group(uint32_t flags) - create a UMCG group.
+
+    UMCG servers and workers at LIBUMCG level must belong to the same UMCG
+    group to interact; note that this is different from UMCG kernel API,
+    where servers and workers can all interact within the same process.
+
+    UMCG groups are used to partition UMCG tasks (servers and workers) within
+    a process, e.g. to allow NUMA-aware scheduling.
+
+
+LIBUMCG API: umcg_destroy_group()
+
+int umcg_destroy_group(umcg_t umcg) - destroy a UMCG group. The group must
+                       be empty, i.e. all its servers and workers must have
+                       unregistered.
+
+
+LIBUMCG API: umcg_register_basic_task()
+
+umcg_tid umcg_register_basic_task(intptr_t tag) - register the current
+                                  thread as a basic LIBUMCG task.
+
+    Basic LIBUMCG tasks do not belong to UMCG groups, and thus cannot
+    interact with LIBUMCG workers.
+
+    At the kernel level basic LIBUMCG tasks are servers.
+
+
+LIBUMCG API: umcg_register_worker()
+
+umcg_tid umcg_register_worker(umcg_t group_id, intptr_t tag) - register
+                              the current thread as a LIBUMCG worker in a group.
+
+    LIBUMCG workers, once registered, can forget about being UMCG workers,
+    as the only difference vs "normal" threads is that now workers are
+    scheduled not by the kernel, but by servers in their UMCG group, which
+    happens "transparently" to UMCG workers.
+
+    LIBUMCG workers may call umcg_[wait|wake|swap] to cooperatively share
+    workload with other LIBUMCG workers in the same group.
+
+    Note: at the moment UMCG workers, once registered, cannnot receive
+    non-fatal signals.
+
+
+LIBUMCG API: umcg_register_server()
+
+umcg_tid umcg_register_server(umcg_t group_id, intptr_t tag) - register
+                              the current thread as a LIBUMCG server in a group.
+
+    LIBUMCG servers schedule LIBUMCG workers in the same group via
+        umcg_get_idle_worker(), umcg_run_worker(), and umcg_preempt_worker().
+        See descriptions of these functions below for more details.
+
+
+LIBUMCG API: umcg_unregister_task()
+
+int umcg_unregister_task(void) - unregister the current thread as a UMCG task.
+
+   A thread can be only one type of a UMCG task at a time. Once unregistered,
+   a thread can register again as a different UMCG task type, in the same
+   or a different group.
+
+
+LIBUMCG API: umcg_wait()
+
+int umcg_wait(uint64_t timeout) - block the current UMCG task until
+              the timeout expires or it is woken via umcg_wake() or umcg_swap().
+
+    All UMCG task types can call umcg_wait().
+
+
+LIBUMCG API: umcg_wake()
+
+int umcg_wake(umcg_tid next, bool wf_current_cpu) - wake a UMCG task.
+
+    Wake a umcg task if it is blocked as a result of calling umcg_wait() or
+    umcg_swap(). If @next is NOT blocked in umcg_wait() or umcg_swap(),
+    it will be marked as "wakeup queued"; when @next calls umcg_wait() or
+    umcg_swap() later, the "wakeup queued" flag will be removed and
+    the function will not block.
+
+    Only one wakeup can be queued per task, so calling umcg_wake for
+    a task with a wakeup queued will spin (in the userspace) until the
+    wakeup flag is cleared.
+
+    If @next is a worker blocked in umcg_wait(), the worker is added
+    to the idle workers list so that it will the be picked up by
+    umcg_get_idle_worker().
+
+    Note that "wakeup queued" is a purely LIBUMCG (userspace) concept:
+    the kernel (UMCG kernel API) is unaware of it.
+
+
+LIBUMCG API: umcg_swap()
+
+int umcg_swap(umcg_tid next, u64 timeout) - block the current task; wake @next.
+
+    umcg_swap() can be used for server-to-server or worker-to-worker
+    context switches, but NOT server-to-worker or worker-to-server.
+    If a server wants to context switch with a worker, the server
+    should call umcg_run_worker(). If a worker wants to context switch
+    to its server, it should call umcg_wait().
+
+    In server-to-server context switches, the switching-out server
+    is RUNNING; the switching-in server can either be IDLE or RUNNING.
+    If the switching-in server is running, it will have a wakeup queued.
+    If the switching-out server has a wakeup queued, umcg_swap() will
+    consume the wakeup.
+
+    In worker-to-worker context switches, the "normal" behavior is that
+    the RUNNING switching-out worker becomes IDLE, its server is
+    transferred to the IDLE switching-in worker, and the switching-in
+    worker becomes RUNNING.
+
+    The switching-in worker MUST NOT be in the idle worker list: it
+    can either be in umcg_wait(), or pulled out of the idle worker list
+    previously.
+
+    Same wakeup-queued rules apply to swapping workers as they apply
+    to swapping servers.
+
+    Note that while with servers umcg_swap() is technically equivalent
+    to { umcg_wake(); umcg_wait(); }, with possible on-cpu optimizations,
+    with workers there is a difference, as umcg_swap() will RUN an
+    idle worker, while umcg_wake() will add it to the idle worker list.
+
+    This difference, however, is transparent for workers: workers
+    engaging is cooperative scheduling via wait/wake/swap will observe
+    exactly the same behavior as if they were servers or basic UMCG tasks.
+
+
+LIBUMCG API: umcg_get_idle_worker()
+
+umcg_tid umcg_get_idle_worker(bool wait) - get an idle worker from
+                                           the idle worker list.
+
+    Servers can query for unblocked workers by calling umcg_get_idle_worker().
+
+    There are two idle worker lists per UMCG group; the kernel-side list,
+    as described in Documentation/userspace-api/umcg.txt, and the
+    userspace-side list. umcg_get_idle_worker() first checks the userspace
+    list and, if it is not empty, returns the first available idle worker,
+    removing it from the list.
+
+    If the userspace list is empty, the function swaps it with the kernel-side
+    list of empty workers, and then checks the userspace list again.
+
+    If @wait is true, the function blocks if there are no idle workers
+    available. The server will be added to the group's idle server list.
+    The server may also be pointed at by struct umcg_task.idle_server_tid_ptr.
+
+    It is safe to call umcg_get_idle_worker() concurrently.
+
+
+LIBUMCG API: umcg_run_worker()
+
+umcg_tid umcg_run_worker(umcg_tid worker) - run the worker.
+
+    Servers "run" workers by calling umcg_run_worker(). @worker must be
+    IDLE, and must NOT be in the idle worker list. I.e. a server may
+    run a worker that is blocked in umcg_wait() either if umcg_wake()
+    has NOT been called on the @worker, or if umcg_wake() HAD been
+    called, and the worker then was returned via umcg_get_idle_worker().
+
+    umcg_run_worker() will block; if the worker the server is running
+    swaps with another worker, the server will get reassigned to that
+    new worker.
+
+    When the worker the server is running blocks, umcg_run_worker returns
+    the worker's umcg_tid, or UMCG_NONE if the worker unregisters.
+
+
+LIBUMCG API: umcg_preempt_worker()
+
+int umcg_preempt_worker(umcg_tid worker) - preempt a RUNNING worker.
+
+    The function interrupgs a RUNNING worker and wakes its server. If
+    the worker is not RUNNING (i.e. BLOCKED or IDLE), the function
+    returns an error with errno set to EAGAIN.
+
+    The group the worker belongs to must be created with
+    UMCG_GROUP_ENABLE_PREEMPTION flag set.
+
+    The function may be called from any thread in the process that
+    @worker belongs to.
+
+
+LIBUMCG API: umcg_get_time_ns()
+
+uint64_t umcg_get_time_ns(void) - return the current absolute time.
+
+    This function can be used to calculate the absolute timeouts passed
+    to umcg_wait() and umcg_swap().
--
2.25.1

