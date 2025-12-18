Return-Path: <linux-api+bounces-5556-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 411DFCCD8E5
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 21:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A83373074D2D
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA832E6CD5;
	Thu, 18 Dec 2025 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5IIw4FP"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91A2E62B4;
	Thu, 18 Dec 2025 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090571; cv=none; b=sRJY1uR2QIFk+4TCQ+7oi6AuN33hF+zm4g1JJGguyh/bUpirZ18ts7dj+Dk7OoK5nSBWo0sgpt4MagEoqYHnNFNQKhlZNVmXiwmaLWCwCLGaifkneBHaAoyloEXAIa2V5+OxwHJjWsQXpDrtnyu3w64adlpbNwGb95swcv0urFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090571; c=relaxed/simple;
	bh=201PmRgYE1b+3daKnu5U4am8WX5QK9hEVu07e1v1kmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlNTNwvHiidMPz+z4hEsthK3TjOhiD9uUE3ElU8YrzUZdKTvd/bN40QR6iln5yi/HK8MTCXPb5k53rV3ePBxnm4+GVQr8MKKw1FvWZH1en9QOLbkxfO74AUdGLp6RbLz8rtzNpyXvWaVAIO2pzPBVF2iPgrmOSuzncKk6ZYGkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5IIw4FP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24998C113D0;
	Thu, 18 Dec 2025 20:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090570;
	bh=201PmRgYE1b+3daKnu5U4am8WX5QK9hEVu07e1v1kmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5IIw4FPtkgCPI1cSTQmj9p+iSdliZmfR/xE2E1Ky0X3S46Uq8fzzwFSrrAd0dvvv
	 JZwydI5K9hjV42sQ2tRohvaKMNS25d3SH5JA8cFxwFxrYGXMgQwxkvz6BqWrg6dgZW
	 Ho1YUGSFgN5U0iDrSxapM7l2awMnaOtDYIsF3mmYPmMN1JrvhjWflW53w9Y5vt4+sb
	 rtqlUlecHoHMDw+AqBBrA3Gkr3fWPP19a/D2USVx++wO5YjscNDcX5tNZytIW4NRoK
	 MA3QKtCQWwtAKpzWIyM+omIXlTh6e8lWrbWPTkVJE5qL6Iboj2JHGBuBqfDaenC10e
	 vaYdebaL1YfGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 05/15] kernel/api: add API specification for io_setup
Date: Thu, 18 Dec 2025 15:42:27 -0500
Message-ID: <20251218204239.4159453-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218204239.4159453-1-sashal@kernel.org>
References: <20251218204239.4159453-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/aio.c | 228 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 216 insertions(+), 12 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 0a23a8c0717ff..36556e7a8e2c0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1366,18 +1366,222 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
-/* sys_io_setup:
- *	Create an aio_context capable of receiving at least nr_events.
- *	ctxp must not point to an aio_context that already exists, and
- *	must be initialized to 0 prior to the call.  On successful
- *	creation of the aio_context, *ctxp is filled in with the resulting 
- *	handle.  May fail with -EINVAL if *ctxp is not initialized,
- *	if the specified nr_events exceeds internal limits.  May fail 
- *	with -EAGAIN if the specified nr_events exceeds the user's limit 
- *	of available events.  May fail with -ENOMEM if insufficient kernel
- *	resources are available.  May fail with -EFAULT if an invalid
- *	pointer is passed for ctxp.  Will fail with -ENOSYS if not
- *	implemented.
+/**
+ * sys_io_setup - Create an asynchronous I/O context
+ * @nr_events: Minimum number of concurrent AIO operations the context should support
+ * @ctxp: Pointer to aio_context_t variable to receive the context handle
+ *
+ * long-desc: Creates an asynchronous I/O context capable of receiving at least
+ *   nr_events concurrent operations. The context handle is returned via ctxp,
+ *   which must be initialized to 0 prior to the call. The returned context
+ *   handle is used with subsequent AIO operations (io_submit, io_getevents,
+ *   io_cancel, io_destroy).
+ *
+ *   The AIO context consists of a memory-mapped ring buffer shared between
+ *   kernel and userspace for efficient completion notification. The kernel
+ *   internally allocates more capacity than requested to account for percpu
+ *   batching (approximately nr_events * 2, but at least num_cpus * 8).
+ *
+ *   The context is bound to the calling process and cannot be shared across
+ *   processes. Each process can have multiple AIO contexts, limited only by
+ *   the system-wide aio-max-nr sysctl.
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: nr_events
+ *   type: KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 1, 8388608
+ *   constraint: Must be greater than 0. Internal limit of approximately 8M events
+ *     prevents overflow when calculating ring buffer size (0x10000000 / 32 bytes
+ *     per io_event). The kernel may allocate more capacity than requested to
+ *     optimize for percpu batching.
+ *
+ * param: ctxp
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_INOUT | KAPI_PARAM_USER
+ *   size: sizeof(aio_context_t)
+ *   constraint-type: KAPI_CONSTRAINT_USER_PTR
+ *   constraint: Must be a valid userspace pointer to an aio_context_t variable.
+ *     The memory pointed to MUST be initialized to 0 before the call. On success,
+ *     receives the context handle (actually the mmap address of the ring buffer).
+ *     The context handle is opaque and should not be interpreted by userspace
+ *     except to pass to other io_* syscalls.
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_ERROR_CHECK
+ *   success: 0
+ *   desc: Returns 0 on success. On success, *ctxp contains the new context handle.
+ *
+ * error: EFAULT, Invalid pointer
+ *   desc: The ctxp pointer is invalid, not accessible, or points to memory that
+ *     cannot be read or written. Returned from get_user() when reading the
+ *     initial value or from put_user() when storing the context handle.
+ *
+ * error: EINVAL, Invalid parameter
+ *   desc: Either *ctxp is not initialized to 0 (indicating an existing context or
+ *     uninitialized memory), or nr_events is 0, or nr_events is too large causing
+ *     internal overflow when calculating ring buffer size. The internal limit is
+ *     approximately 0x10000000 / sizeof(struct io_event) events.
+ *
+ * error: EAGAIN, Resource limit exceeded
+ *   desc: The system-wide limit on AIO contexts would be exceeded. The limit is
+ *     controlled by /proc/sys/fs/aio-max-nr (default 65536). Each context counts
+ *     as nr_events toward this limit. Also returned if nr_events exceeds the
+ *     current aio-max-nr value. Unlike ENOMEM, this error indicates a policy
+ *     limit rather than physical resource exhaustion.
+ *
+ * error: ENOMEM, Insufficient memory
+ *   desc: Kernel could not allocate required memory for the AIO context. This
+ *     includes the kioctx structure, percpu data, ring buffer pages, or the
+ *     anonymous file backing the ring buffer. Also returned if the kernel could
+ *     not establish the memory mapping for the ring buffer, or if ioctx_table
+ *     expansion failed.
+ *
+ * error: EINTR, Interrupted by signal
+ *   desc: A fatal signal was received while attempting to acquire the mmap_lock
+ *     for the ring buffer memory mapping. The operation was aborted before any
+ *     state was modified. Only fatal signals (SIGKILL) can cause this error;
+ *     normal signals like SIGINT do not interrupt the operation.
+ *
+ * lock: aio_nr_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   desc: Global spinlock protecting the system-wide aio_nr counter. Held briefly
+ *     to check and update the system-wide AIO context count.
+ *
+ * lock: mm->ioctx_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   desc: Per-mm spinlock protecting the ioctx_table. Held while adding the new
+ *     context to the process's AIO context table.
+ *
+ * lock: ctx->ring_lock
+ *   type: KAPI_LOCK_MUTEX
+ *   desc: Per-context mutex protecting ring buffer setup. Held throughout context
+ *     initialization to prevent page migration during setup, then released once
+ *     the context is fully initialized.
+ *
+ * lock: mmap_lock
+ *   type: KAPI_LOCK_RWLOCK
+ *   desc: Process memory map write lock. Acquired via mmap_write_lock_killable()
+ *     during ring buffer mmap operation. This is where EINTR can occur.
+ *
+ * signal: SIGKILL
+ *   direction: KAPI_SIGNAL_RECEIVE
+ *   action: KAPI_SIGNAL_ACTION_RETURN
+ *   condition: Fatal signal pending during mmap_write_lock_killable
+ *   desc: Fatal signals can interrupt the context creation during the mmap phase.
+ *     The mmap_write_lock_killable() function checks for fatal signals and returns
+ *     -EINTR if one is pending. Non-fatal signals do not interrupt this syscall.
+ *   error: -EINTR
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   priority: 0
+ *   restartable: no
+ *
+ * side-effect: KAPI_EFFECT_ALLOC_MEMORY
+ *   target: kioctx structure
+ *   desc: Allocates the main AIO context structure from kioctx_cachep slab cache.
+ *     Contains ring buffer metadata, locks, and request tracking.
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_ALLOC_MEMORY
+ *   target: percpu kioctx_cpu structures
+ *   desc: Allocates per-CPU structures for request batching via alloc_percpu().
+ *     Used to reduce contention on the global request counter.
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_ALLOC_MEMORY
+ *   target: ring buffer pages
+ *   desc: Allocates pages for the completion event ring buffer. The ring is backed
+ *     by an anonymous file on the internal "aio" filesystem and memory-mapped into
+ *     the process address space.
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_RESOURCE_CREATE
+ *   target: anonymous inode and file
+ *   desc: Creates an anonymous inode and file on the internal aio filesystem to
+ *     back the ring buffer mapping. This enables proper page migration support.
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: process virtual memory
+ *   desc: Creates a new memory mapping (VMA) for the ring buffer in the process
+ *     address space. The mapping is marked VM_DONTEXPAND and uses aio_ring_vm_ops.
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: mm->ioctx_table
+ *   desc: Adds the new context to the process's AIO context table. The table is
+ *     dynamically expanded if needed (grows by 4x each time).
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: aio_nr (global counter)
+ *   desc: Increments the system-wide AIO context counter by nr_events. This counter
+ *     is visible via /proc/sys/fs/aio-nr and counts toward the aio-max-nr limit.
+ *   reversible: yes
+ *
+ * state-trans: process AIO state
+ *   from: no AIO context (or fewer contexts)
+ *   to: has AIO context
+ *   condition: successful io_setup
+ *   desc: Process gains an AIO context that can be used for asynchronous I/O
+ *     operations. The context remains until explicitly destroyed via io_destroy
+ *     or process exit.
+ *
+ * state-trans: system AIO resources
+ *   from: aio_nr = N
+ *   to: aio_nr = N + nr_events
+ *   condition: successful io_setup
+ *   desc: System-wide AIO resource counter increases. The counter tracks total
+ *     requested AIO capacity across all processes.
+ *
+ * constraint: System-wide AIO limit (aio-max-nr)
+ *   desc: The /proc/sys/fs/aio-max-nr sysctl (default 65536) limits the total
+ *     number of AIO events system-wide. Each io_setup call adds nr_events to
+ *     the aio_nr counter. If aio_nr + nr_events would exceed aio_max_nr, the
+ *     call fails with EAGAIN. Administrators can increase aio-max-nr if needed.
+ *   expr: aio_nr + nr_events <= aio_max_nr
+ *
+ * constraint: Per-process context limit
+ *   desc: Each process can have multiple AIO contexts, limited only by the
+ *     system-wide aio-max-nr limit and available memory. The ioctx_table grows
+ *     dynamically to accommodate new contexts.
+ *
+ * constraint: CONFIG_AIO required
+ *   desc: The kernel must be compiled with CONFIG_AIO=y for this syscall to be
+ *     available. If not configured, the syscall returns -ENOSYS. This is typically
+ *     enabled by default but may be disabled on embedded systems.
+ *
+ * constraint: Memory for ring buffer
+ *   desc: The kernel must be able to allocate sufficient contiguous pages for the
+ *     ring buffer and establish the memory mapping. Large nr_events values require
+ *     more memory and may fail with ENOMEM on memory-constrained systems.
+ *
+ * examples: aio_context_t ctx = 0; io_setup(128, &ctx);  // Create context for 128 events
+ *   aio_context_t ctx = 0; io_setup(1024, &ctx);  // Create context for 1024 events
+ *
+ * notes: The returned context handle is actually the virtual address of the ring
+ *   buffer mapping in the process address space. This allows userspace libraries
+ *   to directly access completion events without syscall overhead in some cases.
+ *
+ *   The kernel internally doubles nr_events and ensures a minimum of num_cpus * 8
+ *   events for percpu batching efficiency. This means the actual ring capacity may
+ *   be significantly larger than requested.
+ *
+ *   Historical note: A race condition between io_setup and io_destroy was fixed
+ *   in commit 86b62a2cb4fc ("aio: fix io_setup/io_destroy race"). Earlier kernels
+ *   could have the context freed while io_setup was still completing.
+ *
+ *   io_uring (since Linux 5.1) is a more modern alternative that provides better
+ *   performance and more features. Consider using io_uring for new applications.
+ *
+ *   There is no glibc wrapper for this syscall. Use syscall(SYS_io_setup, ...) or
+ *   the libaio library wrapper (note: libaio has slightly different error semantics,
+ *   returning negative error numbers directly instead of -1 with errno).
+ *
+ * since-version: 2.5
  */
 SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 {
-- 
2.51.0


