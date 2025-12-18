Return-Path: <linux-api+bounces-5559-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD4CCD8F4
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 21:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A563087F7C
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B22F6560;
	Thu, 18 Dec 2025 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9x40JpJ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD332DC774;
	Thu, 18 Dec 2025 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090573; cv=none; b=Gl7UNtW5015L0MhbvgV/FJuwsiL1jxH+qRIVljKJz6aiUrkeXVCozhT5Mn0ZHFTykxx6IH1kShvS/kXAVzKPEao7KpvG/inxmq+IEALfcDsuptEW3z+ZFgje87pKsXMAOyZx9DBrRuz2iWXrTMyglpLaxYXYFa8vxbBZ71aOLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090573; c=relaxed/simple;
	bh=TWRyLzOK+gmM4eFtawhYOHlyCd0Mmshknky6n5T1bvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKz7Jy6px1QwN4pjoW4PujLdbIZqRrKFxBFLxBpmAsCr/mU3hvzRMQFAmvu9U4pXf/b/0xQIML2cLUcnDL6Yy2QCS933+Thi4Ey2bwyTJX1YP7qJ2FvPv4zTrDxSBs1bIx2qC0TPkQT9cvAkTMT8+qrS2uyrZGauw077bBhATUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9x40JpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51C5C16AAE;
	Thu, 18 Dec 2025 20:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090573;
	bh=TWRyLzOK+gmM4eFtawhYOHlyCd0Mmshknky6n5T1bvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9x40JpJzNzswbsy0KgfTXDPQ+7AX/0Cb23mAAxbniebGBmJroQoF6ztOd1IbJ05q
	 2QNRSt22Fd1ZXIbpxPMGH3u2RqmR+YAHzwbyVaVVTMj9rvhsjHS1sXPB+R31/0uwFc
	 ik7zr1FK3s8tVRl4bKhflAfh6MUW523SmtWAzQ0HRck+hbiAG+ZXoNMXqTD6tq57AJ
	 90oM0JljpKVftqKgnBGojSs3ga6DMg/h41bz2GUAG46lwu5QiSWJNUXK04cz/ZPp7k
	 mp96toMdHgXqN+9b3WGEJQbs9fRlqXlKAAclomIir0NndPOHsftP52k9HUT8UWFxMp
	 TSssBV800vqCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 08/15] kernel/api: add API specification for io_cancel
Date: Thu, 18 Dec 2025 15:42:30 -0500
Message-ID: <20251218204239.4159453-9-sashal@kernel.org>
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
 fs/aio.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 237 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index f6f1b3790c88b..710517c9a990d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2843,15 +2843,243 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 }
 #endif
 
-/* sys_io_cancel:
- *	Attempts to cancel an iocb previously passed to io_submit.  If
- *	the operation is successfully cancelled, the resulting event is
- *	copied into the memory pointed to by result without being placed
- *	into the completion queue and 0 is returned.  May fail with
- *	-EFAULT if any of the data structures pointed to are invalid.
- *	May fail with -EINVAL if aio_context specified by ctx_id is
- *	invalid.  May fail with -EAGAIN if the iocb specified was not
- *	cancelled.  Will fail with -ENOSYS if not implemented.
+/**
+ * sys_io_cancel - Attempt to cancel an outstanding asynchronous I/O operation
+ * @ctx_id: AIO context handle returned by io_setup
+ * @iocb: Pointer to the iocb structure that was previously submitted
+ * @result: Unused parameter (historically for result storage, now ignored)
+ *
+ * long-desc: Attempts to cancel an asynchronous I/O operation that was
+ *   previously submitted via io_submit(). The syscall searches for the
+ *   specified iocb in the context's active request list and invokes the
+ *   operation-specific cancellation callback if found.
+ *
+ *   The cancellation behavior depends on the type of I/O operation:
+ *   - For poll operations (IOCB_CMD_POLL): The request is marked as cancelled
+ *     and a work item is scheduled to complete the cancellation.
+ *   - For USB gadget I/O: The USB endpoint dequeue function is called, which
+ *     triggers the completion callback with -ECONNRESET status.
+ *   - For most direct I/O operations: Cancellation is typically not supported
+ *     as these operations do not register a cancel callback.
+ *
+ *   If the iocb is found and has a registered cancellation callback, that
+ *   callback is invoked and the iocb is removed from the active request list.
+ *   The completion event is delivered via the ring buffer (not via the result
+ *   parameter, which is now unused for this purpose).
+ *
+ *   On successful cancellation initiation, the syscall returns -EINPROGRESS
+ *   (not 0) to indicate that cancellation is in progress. This is because
+ *   the actual completion may occur asynchronously via the cancel callback.
+ *
+ *   Important limitations:
+ *   - Most file I/O operations do not support cancellation
+ *   - The iocb must still be pending (not yet completed)
+ *   - The iocb must have been submitted via io_submit (aio_key == KIOCB_KEY)
+ *   - Only operations that register a ki_cancel callback can be cancelled
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_ATOMIC
+ *
+ * param: ctx_id
+ *   type: KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Must be a valid AIO context handle previously returned by
+ *     io_setup() for the current process. The context must not have been
+ *     destroyed via io_destroy(). A value of 0 is always invalid. The handle
+ *     is actually the virtual address of the ring buffer mapping, and must
+ *     belong to the calling process's address space.
+ *
+ * param: iocb
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER
+ *   size: sizeof(struct iocb)
+ *   constraint-type: KAPI_CONSTRAINT_USER_PTR
+ *   constraint: Must be a valid userspace pointer to a struct iocb that was
+ *     previously submitted via io_submit(). The iocb's aio_key field must
+ *     contain KIOCB_KEY (0), which is written by the kernel during io_submit.
+ *     A NULL pointer will result in EFAULT. The iocb must still be pending
+ *     (present in the context's active_reqs list) for cancellation to succeed.
+ *
+ * param: result
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER | KAPI_PARAM_OPTIONAL
+ *   constraint-type: KAPI_CONSTRAINT_NONE
+ *   constraint: This parameter is no longer used by the kernel. It was
+ *     historically intended to receive the io_event result on successful
+ *     cancellation, but completion events are now always delivered via the
+ *     ring buffer. May be NULL.
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_ERROR_CHECK
+ *   success: -EINPROGRESS
+ *   desc: Returns -EINPROGRESS when the cancellation callback was successfully
+ *     invoked and the request is being cancelled. This is the expected return
+ *     value on successful cancellation initiation. The completion event will
+ *     be delivered via the ring buffer. Note that this is different from the
+ *     man page which claims 0 is returned on success.
+ *
+ * error: EFAULT, Cannot read iocb from userspace
+ *   desc: Returned if the iocb pointer is invalid or points to memory that
+ *     cannot be read. Specifically, the kernel attempts to read the aio_key
+ *     field from the iocb via get_user() and returns EFAULT if this fails.
+ *     A NULL iocb pointer will trigger this error.
+ *
+ * error: EINVAL, iocb not submitted via io_submit
+ *   desc: Returned if the aio_key field of the iocb does not contain KIOCB_KEY
+ *     (which is 0). The kernel sets aio_key to KIOCB_KEY when an iocb is
+ *     successfully submitted via io_submit(). If aio_key contains a different
+ *     value, it indicates the iocb was never successfully submitted, is
+ *     corrupted, or the memory has been reused.
+ *
+ * error: EINVAL, Invalid AIO context
+ *   desc: Returned if ctx_id does not refer to a valid AIO context. This can
+ *     occur if: (1) the context was never created, (2) the context was
+ *     destroyed via io_destroy(), (3) the ctx_id is 0, (4) the ring buffer
+ *     header cannot be read from userspace, (5) the context belongs to a
+ *     different process, or (6) the context's internal ID doesn't match.
+ *
+ * error: EINVAL, iocb not found or not cancellable
+ *   desc: Returned if the specified iocb is not present in the context's
+ *     active request list. This occurs when: (1) the operation has already
+ *     completed and the completion event is in the ring buffer, (2) the
+ *     operation was never submitted to this context, (3) the iocb pointer
+ *     does not match any pending operation (comparison is by pointer value
+ *     converted to u64), or (4) the operation did not register a cancellation
+ *     callback (though in this case EINVAL comes from the default ret value).
+ *     Note: The man page documents EAGAIN for this case, but the actual
+ *     implementation returns EINVAL.
+ *
+ * error: ENOSYS, AIO not implemented
+ *   desc: Returned if the kernel was compiled without CONFIG_AIO support.
+ *     This error is returned by the syscall dispatch mechanism before the
+ *     io_cancel implementation is even reached.
+ *
+ * error: (driver-specific), Cancellation callback failed
+ *   desc: If the iocb is found and its ki_cancel callback is invoked, the
+ *     callback's return value is propagated to userspace if non-zero. For
+ *     USB gadget operations, usb_ep_dequeue() may return various errors
+ *     including EINVAL if the request wasn't queued. The aio_poll_cancel
+ *     callback always returns 0. Driver-specific cancellation functions
+ *     may return other error codes.
+ *
+ * lock: RCU read lock
+ *   type: KAPI_LOCK_RCU
+ *   desc: Acquired in lookup_ioctx() during context lookup. Protects against
+ *     concurrent modification of the mm->ioctx_table while searching for the
+ *     context. Released before any spinlocks are acquired.
+ *
+ * lock: ctx->ctx_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   desc: Per-context spinlock acquired with interrupts disabled via
+ *     spin_lock_irq(). Held while iterating through the active_reqs list
+ *     searching for the iocb, while invoking the ki_cancel callback, and
+ *     while removing the iocb from the list. The cancel callback is invoked
+ *     with this lock held, so callbacks must not sleep and must be IRQ-safe.
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: ctx->active_reqs list
+ *   desc: If the iocb is found and its cancellation callback is invoked, the
+ *     kiocb is removed from the context's active_reqs list via list_del_init().
+ *     This prevents the iocb from being found by subsequent io_cancel calls.
+ *   condition: iocb found and ki_cancel callback invoked
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: Pending I/O operation
+ *   desc: The cancellation callback may modify the state of the underlying
+ *     I/O operation. For poll operations, the cancelled flag is set. For USB
+ *     operations, the USB request is dequeued which triggers the completion
+ *     callback. The completion event is delivered via the ring buffer.
+ *   condition: ki_cancel callback is invoked
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_SCHEDULE
+ *   target: aio_poll work queue
+ *   desc: For poll operations (IOCB_CMD_POLL), the aio_poll_cancel callback
+ *     schedules a work item via schedule_work() to complete the cancellation
+ *     asynchronously. This work item will eventually deliver the completion
+ *     event to the ring buffer.
+ *   condition: Cancelling a poll operation
+ *   reversible: no
+ *
+ * state-trans: kiocb state
+ *   from: in_flight (in active_reqs list)
+ *   to: cancelling (removed from list, cancel callback invoked)
+ *   condition: iocb found and ki_cancel invoked
+ *   desc: When the iocb is found in the active_reqs list and its cancellation
+ *     callback is invoked, the kiocb transitions from in-flight to cancelling
+ *     state. The kiocb is removed from the active_reqs list, preventing
+ *     duplicate cancellation attempts. Final completion occurs asynchronously.
+ *
+ * state-trans: poll_iocb cancelled flag
+ *   from: false
+ *   to: true
+ *   condition: aio_poll_cancel is invoked
+ *   desc: For poll operations, the aio_poll_cancel callback sets the cancelled
+ *     flag on the poll_iocb structure. This signals to the poll completion
+ *     handler that the operation was cancelled rather than completed normally.
+ *
+ * constraint: Operation must support cancellation
+ *   desc: Only operations that register a ki_cancel callback can be cancelled.
+ *     Operations that don't set this callback (most direct I/O operations)
+ *     will never appear in the active_reqs list and thus cannot be cancelled.
+ *     Currently, only IOCB_CMD_POLL operations in the kernel AIO subsystem
+ *     and USB gadget operations support cancellation.
+ *
+ * constraint: Timing window for cancellation
+ *   desc: The iocb must still be pending at the time io_cancel is called.
+ *     There is an inherent race condition: the operation may complete
+ *     naturally between the time the application decides to cancel and when
+ *     io_cancel is invoked. In this case, EINVAL is returned because the
+ *     iocb is no longer in the active_reqs list.
+ *
+ * constraint: CONFIG_AIO required
+ *   desc: The kernel must be compiled with CONFIG_AIO=y for this syscall
+ *     to be available. If not configured, ENOSYS is returned.
+ *
+ * examples: io_cancel(ctx, &iocb, NULL);  // Cancel with unused result param
+ *   if (io_cancel(ctx, &iocb, NULL) == -EINPROGRESS) handle_cancellation();
+ *   ret = io_cancel(ctx, &iocb, NULL); if (ret && ret != -EINPROGRESS) error();
+ *
+ * notes: The return value semantics are unusual: -EINPROGRESS indicates
+ *   successful cancellation initiation, not an error. This is because the
+ *   actual cancellation may complete asynchronously, with the completion
+ *   event delivered via the ring buffer.
+ *
+ *   The result parameter is completely ignored by current kernels. It was
+ *   historically used to return the io_event directly, but since commit
+ *   28468cbed92e ("Revert 'fs/aio: Make io_cancel() generate completions
+ *   again'"), completion events are always delivered via the ring buffer.
+ *   Applications should use io_getevents() to retrieve the cancelled
+ *   operation's completion event.
+ *
+ *   The man page documents EAGAIN as a possible error when "the iocb specified
+ *   was not cancelled", but code analysis shows that EINVAL is actually
+ *   returned in this case. The man page is outdated in this regard.
+ *
+ *   The aio_key field must equal KIOCB_KEY (0) because the kernel writes this
+ *   value during io_submit. If an application attempts to cancel an iocb
+ *   before submitting it, or after the memory has been reused, this check
+ *   will fail with EINVAL.
+ *
+ *   For poll operations specifically, the cancellation is marked but the
+ *   actual completion may be delayed until a worker processes it. The
+ *   -EINPROGRESS return value reflects this asynchronous completion model.
+ *
+ *   USB gadget operations are an exception: when usb_ep_dequeue() is called,
+ *   it typically completes the request synchronously with -ECONNRESET status
+ *   in the completion callback.
+ *
+ *   There is no glibc wrapper for this syscall. Applications must use
+ *   syscall(SYS_io_cancel, ...) or the libaio library. The libaio wrapper
+ *   returns negative error numbers directly rather than returning -1 and
+ *   setting errno.
+ *
+ *   io_uring (since Linux 5.1) provides a more capable and widely-supported
+ *   async I/O interface with better cancellation support via IORING_OP_ASYNC_CANCEL.
+ *
+ * since-version: 2.5
  */
 SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		struct io_event __user *, result)
-- 
2.51.0


