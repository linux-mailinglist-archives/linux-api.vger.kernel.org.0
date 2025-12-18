Return-Path: <linux-api+bounces-5557-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F94CCCD9A9
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 21:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA669304DEE3
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE02E7F27;
	Thu, 18 Dec 2025 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm6VCal9"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9F2DA76F;
	Thu, 18 Dec 2025 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090571; cv=none; b=KQGZzd6lS6wXELOmEB07ota3rnUkvLMbXzBxJsbRXRtoF5PM7qs7LwQdLehcUcGoS/I1wKvqTdFkreIV256FkOhkrtZz4glcXS1q8mY3oy2yayrpmD12tpaPLGD/M7jvX3ZHlDCsOlWfn2uq61OKdqKk/3WsniXIKruycCpkpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090571; c=relaxed/simple;
	bh=oadfCL6p3szPYR2rpUi6FOTD0UWKkS2PI57OHH5y6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RANKyyTVymGQ14OeywkXkaXpnXO1VDcVl6hJSn22Ev9S30E1X8gMqEiw3HNHbUJdkdFHa9+/3gOyojVRayhrZb9QkQt2yc4Zgo2STnSqfIxP4WaiqwH39W6Pc6O0hHx/TgRZQ+sX4PiCffXNDsI8N6d0gIdEEmJUUmUfkVOEzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm6VCal9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6AFC19423;
	Thu, 18 Dec 2025 20:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090571;
	bh=oadfCL6p3szPYR2rpUi6FOTD0UWKkS2PI57OHH5y6lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fm6VCal9OVCusmvNBANryV9Ku48KmSgUngHs6E9F9poBj/ENW8+xW3bdhfePPfrnc
	 ub9jivnDRBaNuMVq66Sxj7ZAADm5y2EReU2qsber1EMth8JhXo8b/IU6wp3RYHn0Do
	 5p9OXfqEcQ/JhfwXcWJyp8ZSe/tQ0UxloTleGr1adR60QIwFGI3+l6hwyPwnRc0R4A
	 e2G5m/mdx0T3olPLGGocY1v7fd1c6GAS3s5yBDlg8bj8/rKjD1yRtk8VFAb/Lx9VRs
	 wDVr2rVoY742WUaQYU4VvXfHC+phLNtAqFoFv0ZOb24IWtkahCmThWfuxkvi6BUXDO
	 htch9anzS6V6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 06/15] kernel/api: add API specification for io_destroy
Date: Thu, 18 Dec 2025 15:42:28 -0500
Message-ID: <20251218204239.4159453-7-sashal@kernel.org>
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
 fs/aio.c | 189 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 184 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 36556e7a8e2c0..ff2a8527e1b85 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1646,11 +1646,190 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 }
 #endif
 
-/* sys_io_destroy:
- *	Destroy the aio_context specified.  May cancel any outstanding 
- *	AIOs and block on completion.  Will fail with -ENOSYS if not
- *	implemented.  May fail with -EINVAL if the context pointed to
- *	is invalid.
+/**
+ * sys_io_destroy - Destroy an asynchronous I/O context
+ * @ctx: AIO context handle returned by io_setup
+ *
+ * long-desc: Destroys the asynchronous I/O context identified by ctx. This
+ *   syscall will attempt to cancel all outstanding asynchronous I/O operations
+ *   against the context and block until all operations have completed. Once
+ *   this syscall returns successfully, the context handle becomes invalid and
+ *   must not be used with any other io_* syscalls.
+ *
+ *   The context's memory-mapped ring buffer is unmapped from the process address
+ *   space, and all associated kernel resources are freed. The system-wide AIO
+ *   event counter (aio_nr) is decremented by the original nr_events value that
+ *   was passed to io_setup when creating this context.
+ *
+ *   This syscall blocks until all in-flight I/O operations have completed. This
+ *   ensures that userspace buffers passed to io_submit are no longer accessed
+ *   by the kernel after io_destroy returns. The wait is NOT interruptible by
+ *   signals, so callers cannot cancel this blocking behavior.
+ *
+ *   If two threads call io_destroy on the same context simultaneously, only the
+ *   first call will succeed; subsequent calls return -EINVAL as the context is
+ *   already marked as dead.
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: ctx
+ *   type: KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Must be a valid context handle previously returned by io_setup.
+ *     The handle is actually the virtual address of the ring buffer mapping in
+ *     the calling process's address space. A value of 0 is always invalid.
+ *     The context must not have been previously destroyed.
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_ERROR_CHECK
+ *   success: 0
+ *   desc: Returns 0 on success. After successful return, the context handle is
+ *     invalid and all resources have been released. All outstanding I/O
+ *     operations have completed.
+ *
+ * error: EINVAL, Invalid context
+ *   desc: The ctx argument does not refer to a valid AIO context in the calling
+ *     process. This can occur if: (1) ctx was never returned by io_setup,
+ *     (2) ctx was returned by io_setup in a different process, (3) ctx was
+ *     already destroyed by a previous io_destroy call, (4) ctx is 0 or an
+ *     arbitrary invalid value, or (5) the ring buffer at the ctx address has
+ *     been corrupted (e.g., the id field no longer matches).
+ *
+ * lock: mm->ioctx_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   desc: Per-mm spinlock protecting the ioctx_table. Held briefly while
+ *     marking the context as dead and removing it from the process's AIO
+ *     context table.
+ *
+ * lock: RCU read lock
+ *   type: KAPI_LOCK_RCU
+ *   desc: RCU read-side critical section held during context lookup in
+ *     lookup_ioctx(). Protects against concurrent modification of the
+ *     ioctx_table.
+ *
+ * lock: ctx->ctx_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   desc: Per-context spinlock held while cancelling outstanding I/O requests
+ *     in free_ioctx_users(). Protects the active_reqs list.
+ *
+ * lock: mmap_lock
+ *   type: KAPI_LOCK_RWLOCK
+ *   desc: Process memory map write lock acquired during vm_munmap() when
+ *     unmapping the ring buffer. May contend with other memory operations
+ *     in the same process.
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: ctx->dead flag
+ *   desc: Atomically sets the context's dead flag to 1, marking it as being
+ *     destroyed. This prevents new I/O submissions and ensures subsequent
+ *     io_destroy calls return -EINVAL.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: mm->ioctx_table
+ *   desc: Removes the context from the process's AIO context table by setting
+ *     the corresponding table entry to NULL. After this, lookup_ioctx will
+ *     no longer find this context.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: aio_nr (global counter)
+ *   desc: Decrements the system-wide AIO context counter by the context's
+ *     max_reqs value (the nr_events originally passed to io_setup). This
+ *     counter is visible via /proc/sys/fs/aio-nr.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: process virtual memory
+ *   desc: Unmaps the ring buffer from the process's address space via
+ *     vm_munmap(). The memory region at ctx becomes invalid.
+ *   condition: ctx->mmap_size > 0
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_FREE_MEMORY
+ *   target: kioctx structure and associated resources
+ *   desc: Frees the AIO context structure, percpu data, ring buffer pages, and
+ *     the anonymous file backing the ring buffer. Deferred via RCU work queue
+ *     to ensure safe cleanup after all references are dropped.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_SIGNAL_SEND
+ *   target: outstanding AIO operations
+ *   desc: Cancels all outstanding asynchronous I/O operations by invoking their
+ *     ki_cancel callbacks. The specific effect depends on the operation type
+ *     (read, write, fsync, poll).
+ *   condition: active_reqs list is not empty
+ *   reversible: no
+ *
+ * state-trans: AIO context state
+ *   from: alive (ctx->dead == 0)
+ *   to: dead (ctx->dead == 1)
+ *   condition: successful atomic exchange in kill_ioctx
+ *   desc: The context transitions from usable to destroyed. Once dead, the
+ *     context cannot be used for any operations and will be freed after all
+ *     references are dropped.
+ *
+ * state-trans: process AIO state
+ *   from: has AIO context(s)
+ *   to: context removed (or no contexts)
+ *   condition: successful io_destroy
+ *   desc: The destroyed context is removed from the process's context table.
+ *     If this was the only context, the process no longer has any active
+ *     AIO contexts.
+ *
+ * state-trans: system AIO resources
+ *   from: aio_nr = N
+ *   to: aio_nr = N - max_reqs
+ *   condition: successful io_destroy
+ *   desc: System-wide AIO resource counter decreases, making room for other
+ *     processes to create new AIO contexts.
+ *
+ * constraint: CONFIG_AIO required
+ *   desc: The kernel must be compiled with CONFIG_AIO=y for this syscall to be
+ *     available. If not configured, the syscall returns -ENOSYS. This is
+ *     typically enabled by default but may be disabled on embedded systems.
+ *
+ * constraint: Context must belong to calling process
+ *   desc: Each AIO context is bound to a specific process (mm_struct). A context
+ *     created by one process cannot be destroyed by another process, even if
+ *     the context handle value is somehow known.
+ *   expr: ctx belongs to current->mm
+ *
+ * examples: io_destroy(ctx);  // Destroy context and wait for completion
+ *   if (io_destroy(ctx) == -EINVAL) handle_error();  // Invalid context
+ *
+ * notes: The man page documents EFAULT as a possible error, but code analysis
+ *   shows that EFAULT conditions (e.g., invalid ring buffer pointer) actually
+ *   result in EINVAL being returned, as lookup_ioctx returns NULL on any
+ *   failure to access the ring buffer header.
+ *
+ *   This syscall blocks in TASK_UNINTERRUPTIBLE state while waiting for
+ *   outstanding I/O operations to complete. This means the process cannot be
+ *   interrupted by signals during this wait. In extreme cases with very slow
+ *   I/O devices, this could cause the process to appear hung.
+ *
+ *   Historical note: Before kernel 3.11, io_destroy blocked waiting for I/O
+ *   completion. A refactoring in 3.11 accidentally removed this behavior,
+ *   creating a race where userspace buffers could be freed while the kernel
+ *   was still using them. This was fixed by commit e02ba72aabfa that blocks
+ *   io_destroy until all context requests are completed.
+ *
+ *   Race condition handling: A race between io_destroy and io_submit was fixed
+ *   by commit 7137c6bd4552. A race between io_setup and io_destroy was fixed
+ *   by commit 86b62a2cb4fc. Both fixes ensure proper synchronization via
+ *   reference counting.
+ *
+ *   io_uring (since Linux 5.1) is a more modern alternative that provides better
+ *   performance and more features. Consider using io_uring for new applications.
+ *
+ *   There is no glibc wrapper for this syscall. Use syscall(SYS_io_destroy, ctx)
+ *   or the libaio library wrapper io_destroy(). Note: libaio has slightly
+ *   different error semantics, returning negative error numbers directly instead
+ *   of -1 with errno.
+ *
+ * since-version: 2.5
  */
 SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
 {
-- 
2.51.0


