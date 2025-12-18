Return-Path: <linux-api+bounces-5558-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15151CCD8F1
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 21:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB0743082FDA
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1A2EB874;
	Thu, 18 Dec 2025 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaJ3h4kz"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF42E92D4;
	Thu, 18 Dec 2025 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090572; cv=none; b=OdO/aE7E5I/uIR0IeMpEatCIPnrOWV0Gd9m2hRYtTM3q/JJJa3TlM7FiJ+gn7j6Z4QJB12ZimtHCu4RaKkLT7Kgnq9i5IrhhP1+THPEZq815vX5mp+RMbbByaAniidqcivlKTX9y3dECw4JwrxIcIDPtXysYJdFB7Lebkn33w4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090572; c=relaxed/simple;
	bh=15QMa2QRWzuHNFPoY2VDNiHPRh2YTSroy0oCN7V30og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg8S+JPgDJdv5vcpGyIabVpxw3HcDnjtzNer9AOrl6s19eJHWlFZNVn2+g4SjDAeeYELPJbRO/AzcFnNi0eE88f83Sa5LtB3jq+3sew28t93xZNBmNJX459+MVAogzaYHU4a8e7nrh4/TmBMRwetDRP86jM6q4MSEwF+GoyQ5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaJ3h4kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E831DC113D0;
	Thu, 18 Dec 2025 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090572;
	bh=15QMa2QRWzuHNFPoY2VDNiHPRh2YTSroy0oCN7V30og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WaJ3h4kzgOxMbfRPwjaKsQf1Q0ly1MlEO2Z6as2aBmSn2YHPh/S3laqZbnBjh0rNg
	 3fiKDg3f6HmZj8UKBTHgfzDR3lvymRX6uOKqyCxVX4Uq0/KKsHxIestUJ5y8NB/q/f
	 hQ+3qrQVFq2sNaTfXvx2Si/kbAz4m/8MZX0uJX5IWrPcfctHTpW7oC8ojb40zIL0Q1
	 wNHuHcRFtWzd4r9hepjKf3zIPrLodONtFc3oYWyEE3Am8WKdprLrnpv8iiQrPDEplk
	 L7lpLmhUz40izRmbA0Z0V8qZnANCmVZMpFua5MSResYufSi4AyPi6CadgERE8Aseb2
	 bqu9oatLRvmDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 07/15] kernel/api: add API specification for io_submit
Date: Thu, 18 Dec 2025 15:42:29 -0500
Message-ID: <20251218204239.4159453-8-sashal@kernel.org>
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
 fs/aio.c | 319 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 308 insertions(+), 11 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index ff2a8527e1b85..f6f1b3790c88b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2450,17 +2450,314 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	return err;
 }
 
-/* sys_io_submit:
- *	Queue the nr iocbs pointed to by iocbpp for processing.  Returns
- *	the number of iocbs queued.  May return -EINVAL if the aio_context
- *	specified by ctx_id is invalid, if nr is < 0, if the iocb at
- *	*iocbpp[0] is not properly initialized, if the operation specified
- *	is invalid for the file descriptor in the iocb.  May fail with
- *	-EFAULT if any of the data structures point to invalid data.  May
- *	fail with -EBADF if the file descriptor specified in the first
- *	iocb is invalid.  May fail with -EAGAIN if insufficient resources
- *	are available to queue any iocbs.  Will return 0 if nr is 0.  Will
- *	fail with -ENOSYS if not implemented.
+/**
+ * sys_io_submit - Submit asynchronous I/O operations for processing
+ * @ctx_id: AIO context handle returned by io_setup
+ * @nr: Number of I/O control blocks to submit
+ * @iocbpp: Array of pointers to iocb structures describing the operations
+ *
+ * long-desc: Submits one or more asynchronous I/O operations for processing
+ *   against a previously created AIO context. Each iocb structure describes
+ *   a single I/O operation including the operation type, file descriptor,
+ *   buffer, size, and offset.
+ *
+ *   The syscall processes iocbs sequentially from the array. If an error
+ *   occurs while processing an iocb, submission stops at that point and
+ *   the number of successfully submitted operations is returned. This means
+ *   partial submission is possible: if submitting 10 iocbs and the 5th fails,
+ *   4 is returned and iocbs 0-3 are queued for processing.
+ *
+ *   Supported operations (specified via aio_lio_opcode):
+ *   - IOCB_CMD_PREAD (0): Positioned read from file
+ *   - IOCB_CMD_PWRITE (1): Positioned write to file
+ *   - IOCB_CMD_FSYNC (2): Sync file data and metadata
+ *   - IOCB_CMD_FDSYNC (3): Sync file data only
+ *   - IOCB_CMD_POLL (5): Poll for events on file descriptor
+ *   - IOCB_CMD_NOOP (6): No operation (useful for testing)
+ *   - IOCB_CMD_PREADV (7): Positioned scatter read
+ *   - IOCB_CMD_PWRITEV (8): Positioned gather write
+ *
+ *   The iocb structure fields include:
+ *   - aio_data: User data copied to io_event on completion
+ *   - aio_lio_opcode: Operation type (one of IOCB_CMD_*)
+ *   - aio_fildes: File descriptor for the operation
+ *   - aio_buf: Buffer address (or iovec array for vectored ops)
+ *   - aio_nbytes: Buffer size (or iovec count for vectored ops)
+ *   - aio_offset: File offset for positioned operations
+ *   - aio_flags: Optional flags (IOCB_FLAG_RESFD, IOCB_FLAG_IOPRIO)
+ *   - aio_resfd: eventfd to signal on completion (if IOCB_FLAG_RESFD set)
+ *   - aio_rw_flags: Per-operation RWF_* flags
+ *   - aio_reqprio: I/O priority (if IOCB_FLAG_IOPRIO set)
+ *
+ *   After successful submission, operations complete asynchronously. Results
+ *   are delivered to the completion ring buffer and can be retrieved via
+ *   io_getevents(). If aio_resfd specifies a valid eventfd, it is signaled
+ *   when each operation completes.
+ *
+ *   The actual I/O may complete synchronously if the data is cached or if
+ *   the underlying filesystem doesn't support truly asynchronous I/O. In
+ *   such cases, the operation is still reported via the completion ring.
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: ctx_id
+ *   type: KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Must be a valid AIO context handle previously returned by
+ *     io_setup() for the current process. The context must not have been
+ *     destroyed. A value of 0 is always invalid. The handle is actually
+ *     the virtual address of the ring buffer mapping.
+ *
+ * param: nr
+ *   type: KAPI_TYPE_INT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 0, LONG_MAX
+ *   constraint: Must be >= 0. If 0, the syscall returns immediately with 0.
+ *     The actual number processed is capped to ctx->nr_events (the context's
+ *     capacity). Very large values are effectively limited by the context
+ *     capacity and available ring buffer slots.
+ *
+ * param: iocbpp
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Must be a valid userspace pointer to an array of nr pointers
+ *     to struct iocb. Each iocb pointer must itself be valid and point to a
+ *     properly initialized iocb structure. The iocb structures must have
+ *     aio_reserved2 set to 0 for forward compatibility.
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_RANGE
+ *   success: >= 0
+ *   desc: Returns the number of iocbs successfully submitted (0 to nr). If
+ *     partial submission occurs due to an error, returns the count of
+ *     successfully submitted operations. Returns 0 if nr is 0.
+ *
+ * error: EINVAL, Invalid context or parameter
+ *   desc: Returned if ctx_id is invalid, nr is negative, aio_reserved2 is
+ *     non-zero, aio_lio_opcode is invalid, aio_buf/aio_nbytes overflow,
+ *     aio_resfd is not an eventfd, conflicting aio_rw_flags, file lacks
+ *     required operation support, invalid POLL/FSYNC parameters, or
+ *     invalid aio_reqprio class.
+ *
+ * error: EFAULT, Invalid memory access
+ *   desc: Returned if: (1) iocbpp is not a valid userspace pointer, (2) any
+ *     pointer in the iocbpp array is invalid, (3) the iocb data cannot be
+ *     copied from userspace, (4) aio_buf points to invalid memory, or
+ *     (5) the kernel cannot write the aio_key field back to userspace.
+ *
+ * error: EBADF, Bad file descriptor
+ *   desc: Returned if: (1) aio_fildes in an iocb does not refer to an open
+ *     file, (2) aio_resfd does not refer to a valid file descriptor when
+ *     IOCB_FLAG_RESFD is set, (3) the file is not opened with appropriate
+ *     mode for the operation (e.g., read on write-only file).
+ *
+ * error: EAGAIN, Resource temporarily unavailable
+ *   desc: Returned if insufficient slots are available in the completion
+ *     ring buffer. This typically means too many operations are already
+ *     in flight and the application should call io_getevents() to consume
+ *     completed events before submitting more.
+ *
+ * error: EPERM, Operation not permitted
+ *   desc: Returned if: (1) IOCB_FLAG_IOPRIO is set and aio_reqprio specifies
+ *     IOPRIO_CLASS_RT (real-time I/O priority) but the process lacks
+ *     CAP_SYS_ADMIN or CAP_SYS_NICE capability, or (2) RWF_NOAPPEND is
+ *     specified but the file has the append-only attribute (IS_APPEND).
+ *
+ * error: EOPNOTSUPP, Operation not supported
+ *   desc: Returned if: (1) unsupported aio_rw_flags are specified, (2)
+ *     RWF_NOWAIT is specified but the file doesn't support non-blocking I/O
+ *     (FMODE_NOWAIT not set), (3) RWF_ATOMIC is specified for a read or
+ *     the file doesn't support atomic writes, or (4) RWF_DONTCACHE is
+ *     specified but not supported by the filesystem or file is DAX-mapped.
+ *
+ * error: EOVERFLOW, Value too large
+ *   desc: Returned if aio_offset plus aio_nbytes would overflow and the
+ *     file does not support unsigned offsets. This check prevents reading
+ *     or writing past the maximum representable file position.
+ *
+ * error: ENOMEM, Out of memory
+ *   desc: Returned if memory allocation fails when preparing credentials
+ *     for IOCB_CMD_FSYNC operations, or if vectored I/O (preadv/pwritev)
+ *     requires allocating iovec arrays larger than the stack buffer.
+ *
+ * lock: RCU read lock
+ *   type: KAPI_LOCK_RCU
+ *   desc: Acquired during context lookup in lookup_ioctx(). Protects against
+ *     concurrent modification of the ioctx_table while looking up the
+ *     context. Released before processing any iocbs.
+ *
+ * lock: ctx->completion_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   desc: Per-context spinlock acquired briefly during request slot allocation
+ *     via user_refill_reqs_available() if the percpu request counter is empty.
+ *     Protects the ring buffer tail and completed_events counters.
+ *
+ * lock: ctx->ctx_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   desc: Per-context spinlock acquired when adding cancellable requests to
+ *     the active_reqs list. This enables io_cancel() to find and cancel
+ *     in-flight operations.
+ *
+ * lock: blk_plug
+ *   type: KAPI_LOCK_CUSTOM
+ *   desc: Block layer plugging is enabled when nr > 2 (AIO_PLUG_THRESHOLD)
+ *     to batch block I/O requests for better performance. This is not a
+ *     traditional lock but affects I/O scheduling.
+ *
+ * signal: any
+ *   direction: KAPI_SIGNAL_RECEIVE
+ *   action: KAPI_SIGNAL_ACTION_TRANSFORM
+ *   condition: Signal arrives during underlying read/write operation
+ *   desc: If a signal arrives during the underlying file read/write operation
+ *     and the operation returns ERESTARTSYS/ERESTARTNOINTR/etc., the error
+ *     is transformed to EINTR for the completion event. AIO operations cannot
+ *     be restarted in the traditional sense because other operations may have
+ *     already been submitted. The syscall itself (io_submit) is NOT interrupted
+ *     by signals - only the individual async operations can be.
+ *   error: -EINTR (in io_event.res, not syscall return)
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   restartable: no
+ *
+ * side-effect: KAPI_EFFECT_ALLOC_MEMORY
+ *   target: aio_kiocb structures
+ *   desc: Allocates one aio_kiocb structure per submitted operation from the
+ *     kiocb_cachep slab cache. These structures track the in-flight operations
+ *     and are freed after completion is recorded in the ring buffer.
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: AIO context request counters
+ *   desc: Decrements the available request slot counter in the context.
+ *     Slots are reclaimed when completion events are consumed from the ring
+ *     buffer via io_getevents().
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: ctx->active_reqs list
+ *   desc: Cancellable operations (reads, writes, polls) are added to the
+ *     context's active_reqs list, enabling cancellation via io_cancel().
+ *   condition: Operation supports cancellation
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: iocb->aio_key field
+ *   desc: The kernel writes KIOCB_KEY (0) to the aio_key field of each
+ *     submitted iocb in userspace memory. This marks the iocb as submitted
+ *     and is checked by io_cancel() to validate the iocb.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: file reference count
+ *   desc: Increments the reference count of the file descriptor's struct file
+ *     via fget() for each submitted operation. The reference is released
+ *     when the operation completes (via fput() in iocb_destroy()).
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_FILESYSTEM
+ *   target: target file(s)
+ *   desc: For write operations, the file content may be modified. For fsync
+ *     operations, dirty data is flushed to storage. The actual I/O may
+ *     complete synchronously or asynchronously depending on the filesystem.
+ *   condition: IOCB_CMD_PWRITE, IOCB_CMD_PWRITEV, IOCB_CMD_FSYNC, IOCB_CMD_FDSYNC
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_SCHEDULE
+ *   target: fsync work queue
+ *   desc: FSYNC and FDSYNC operations are scheduled to run on a workqueue
+ *     because vfs_fsync() can block. The operation runs asynchronously and
+ *     completion is signaled via the ring buffer.
+ *   condition: IOCB_CMD_FSYNC or IOCB_CMD_FDSYNC
+ *   reversible: no
+ *
+ * state-trans: iocb state
+ *   from: user-prepared iocb
+ *   to: submitted (aio_key set to KIOCB_KEY)
+ *   condition: successful submission of each iocb
+ *   desc: Each successfully submitted iocb transitions from user-prepared
+ *     state to submitted state, marked by the kernel writing KIOCB_KEY to
+ *     aio_key. The iocb remains in submitted state until completion.
+ *
+ * state-trans: AIO context slot availability
+ *   from: slots_available = N
+ *   to: slots_available = N - submitted_count
+ *   condition: successful submission
+ *   desc: Available slots in the context decrease by the number of successfully
+ *     submitted operations. Slots are reclaimed when io_getevents() consumes
+ *     completion events.
+ *
+ * capability: CAP_SYS_ADMIN
+ *   type: KAPI_CAP_GRANT_PERMISSION
+ *   allows: Use of IOPRIO_CLASS_RT (real-time I/O priority class)
+ *   without: Returns EPERM when attempting to use RT I/O priority
+ *   condition: IOCB_FLAG_IOPRIO set and aio_reqprio specifies IOPRIO_CLASS_RT
+ *
+ * capability: CAP_SYS_NICE
+ *   type: KAPI_CAP_GRANT_PERMISSION
+ *   allows: Use of IOPRIO_CLASS_RT (alternative to CAP_SYS_ADMIN)
+ *   without: Returns EPERM when attempting to use RT I/O priority
+ *   condition: IOCB_FLAG_IOPRIO set and aio_reqprio specifies IOPRIO_CLASS_RT
+ *
+ * constraint: Ring buffer slot availability
+ *   desc: There must be available slots in the completion ring buffer for
+ *     each operation to be submitted. If all slots are occupied by pending
+ *     completion events, submission fails with EAGAIN. The number of slots
+ *     is determined by nr_events passed to io_setup(), though internal
+ *     doubling means more slots may be available.
+ *   expr: available_slots >= 1 for each submission
+ *
+ * constraint: Valid file descriptor per iocb
+ *   desc: Each iocb must reference a valid, open file descriptor via
+ *     aio_fildes. The file must be opened with appropriate access mode
+ *     for the requested operation (read access for PREAD, write access
+ *     for PWRITE, etc.).
+ *
+ * constraint: File must support operation
+ *   desc: For read/write operations, the underlying file must implement
+ *     read_iter/write_iter file operations. For fsync, the file must
+ *     implement fsync. For poll, the file must support vfs_poll().
+ *
+ * constraint: CONFIG_AIO required
+ *   desc: The kernel must be compiled with CONFIG_AIO=y for this syscall
+ *     to be available. If not configured, returns -ENOSYS.
+ *
+ * examples: struct iocb iocb, *iocbp = &iocb; io_submit(ctx, 1, &iocbp);
+ *   struct iocb iocbs[10], *ptrs[10]; io_submit(ctx, 10, ptrs);  // Batch submit
+ *
+ * notes: Unlike traditional synchronous I/O, errors from io_submit() indicate
+ *   submission failures, not I/O errors. Actual I/O errors are reported via
+ *   the res field of struct io_event when retrieved via io_getevents().
+ *
+ *   The return value indicates how many iocbs were successfully submitted.
+ *   If this is less than nr, the application should check which operation
+ *   failed (it's the one at index = return_value) and handle the error.
+ *   Previously submitted operations in the batch are still queued.
+ *
+ *   For vectored operations (PREADV/PWRITEV), aio_buf points to an array
+ *   of struct iovec and aio_nbytes contains the iovec count. The maximum
+ *   iovec count is UIO_MAXIOV (1024).
+ *
+ *   Block layer plugging is automatically enabled for batches larger than
+ *   2 operations, improving I/O merging and reducing per-I/O overhead.
+ *
+ *   The COMPAT_SYSCALL variant handles 32-bit userspace on 64-bit kernels,
+ *   using compat_uptr_t for the iocbpp array elements.
+ *
+ *   Historical note: commit d6b2615f7d31d ("aio: simplify - and fix - fget/fput
+ *   for io_submit()") fixed file descriptor reference counting issues. Earlier
+ *   kernels could leak file references on certain error paths.
+ *
+ *   io_uring (since Linux 5.1) is a more modern and performant alternative.
+ *   Consider using io_uring_enter() for new applications requiring async I/O.
+ *
+ *   There is no glibc wrapper; use syscall(SYS_io_submit, ...) or the libaio
+ *   library. The libaio wrapper io_submit() returns negative error numbers
+ *   directly rather than returning -1 and setting errno.
+ *
+ * since-version: 2.5
  */
 SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		struct iocb __user * __user *, iocbpp)
-- 
2.51.0


