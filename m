Return-Path: <linux-api+bounces-5564-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B63CCD948
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 21:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317E83054830
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5846F328B4C;
	Thu, 18 Dec 2025 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjwuDJ3K"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5032573E;
	Thu, 18 Dec 2025 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090578; cv=none; b=C7aFOdq8aA5AtDfrGZ/z0suvXhE+TZtImsEmcvjji1GzmOmfTuDG10wpm678+c5WryUhEgvnQHWn+HFE+vLqkzL+2/28X3RwdTXMcnindG/mp9EYLWjNJmjrLzkJZJVNfyLgc/oFjaSSdhJZMYn8TKUeSl5U5MS5UkcuCN7Yx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090578; c=relaxed/simple;
	bh=6SDsm5fa4pPqv3CmHlvFDJLLRTXdJ+yKSKEOq2Xv97E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUh8iXPzEJFT/HvrI+HK0Wd26L/QfR0XRUwu/ZudOgsGuKd3AwsR/HOrsrRu0+IYyf/OXOWHjBcKclGtIaviNeHoSyusUcMRmjEmH9qWc2O98EqC6cC+TG9/vZ6ebHzq5CVJZKSsUFeVR1U42JQ8a8tP5FvtJi7y82RCyV+smBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjwuDJ3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D65C4CEFB;
	Thu, 18 Dec 2025 20:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090578;
	bh=6SDsm5fa4pPqv3CmHlvFDJLLRTXdJ+yKSKEOq2Xv97E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjwuDJ3KjYo/uHWrF0yaqJ1AjEOPb8wLbKcHMM6tzivdxRy0KvHCJOdIWigf3qMdZ
	 JR1bCTdU4a9aLRJVnlCWZwDkkj37UR7NRVwLauSp2yFXE+Z5iDuMhEcLvHZKVXBlxI
	 KQlkS/xLpUCxTASwAKQHisMxTESvySu/mgA2rlQP4cSbMSt43t0+ET3nH3vYJX/5zf
	 NdlsFZF42FIbQ3sO9+TV6G9IhgI/1ZcHOC18eG7ZSop92hfwhYjGI1esuGKxhjKZnU
	 klGm5aPvDJZfpa+7BX3HBONMHRklR9KS8XQmX2gCtwixiiVgNdbrsfHjjG32pRVeys
	 nO7QPEuUDqCgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 13/15] kernel/api: add API specification for sys_close
Date: Thu, 18 Dec 2025 15:42:35 -0500
Message-ID: <20251218204239.4159453-14-sashal@kernel.org>
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
 fs/open.c | 247 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 243 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 343e6d3798ec3..26d8ee8336405 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1868,10 +1868,249 @@ int filp_close(struct file *filp, fl_owner_t id)
 }
 EXPORT_SYMBOL(filp_close);
 
-/*
- * Careful here! We test whether the file pointer is NULL before
- * releasing the fd. This ensures that one clone task can't release
- * an fd while another clone is opening it.
+/**
+ * sys_close - Close a file descriptor
+ * @fd: The file descriptor to close
+ *
+ * long-desc: Terminates access to an open file descriptor, releasing the file
+ *   descriptor for reuse by subsequent open(), dup(), or similar syscalls. Any
+ *   advisory record locks (POSIX locks, OFD locks, and flock locks) held on the
+ *   associated file are released. When this is the last file descriptor
+ *   referring to the underlying open file description, associated resources are
+ *   freed. If the file was previously unlinked, the file itself is deleted when
+ *   the last reference is closed.
+ *
+ *   CRITICAL: The file descriptor is ALWAYS closed, even when close() returns
+ *   an error. This differs from POSIX semantics where the state of the file
+ *   descriptor is unspecified after EINTR. On Linux, the fd is released early
+ *   in close() processing before flush operations that may fail. Therefore,
+ *   retrying close() after an error return is DANGEROUS and may close an
+ *   unrelated file descriptor that was assigned to another thread.
+ *
+ *   Errors returned from close() (EIO, ENOSPC, EDQUOT) indicate that the final
+ *   flush of buffered data failed. These errors commonly occur on network
+ *   filesystems like NFS when write errors are deferred to close time. A
+ *   successful return from close() does NOT guarantee that data has been
+ *   successfully written to disk; the kernel uses buffer cache to defer writes.
+ *   To ensure data persistence, call fsync() before close().
+ *
+ *   On close, the following cleanup operations are performed: POSIX advisory
+ *   locks are removed, dnotify registrations are cleaned up, the file is
+ *   flushed if the file operations define a flush callback, and the file
+ *   reference is released. If this was the last reference, additional cleanup
+ *   includes: fsnotify close notification, epoll cleanup, flock and lease
+ *   removal, FASYNC cleanup, the file's release callback invocation, and
+ *   the file structure deallocation.
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: fd
+ *   type: KAPI_TYPE_FD
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 0, INT_MAX
+ *   constraint: Must be a valid, open file descriptor for the current process.
+ *     The value 0, 1, or 2 (stdin, stdout, stderr) may be closed like any other
+ *     fd, though this is unusual and may cause issues with libraries that assume
+ *     these descriptors are valid. The parameter is unsigned int to match kernel
+ *     file descriptor table indexing, but values exceeding INT_MAX are effectively
+ *     invalid due to internal checks.
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_EXACT
+ *   success: 0
+ *   desc: Returns 0 on success. On error, returns a negative error code.
+ *     IMPORTANT: Even when an error is returned, the file descriptor is still
+ *     closed and must not be used again. The error indicates a problem with
+ *     the final flush operation, not that the fd remains open.
+ *
+ * error: EBADF, Bad file descriptor
+ *   desc: The file descriptor fd is not a valid open file descriptor, or was
+ *     already closed. This is the only error that indicates the fd was NOT
+ *     closed (because it was never open to begin with). Occurs when fd is out
+ *     of range, has no file assigned, or was already closed.
+ *
+ * error: EINTR, Interrupted system call
+ *   desc: The flush operation was interrupted by a signal before completion.
+ *     This occurs when a file's flush callback (e.g., NFS) performs an
+ *     interruptible wait that receives a signal. IMPORTANT: Despite this error,
+ *     the file descriptor IS closed and must not be used again. This error
+ *     is generated by converting kernel-internal restart codes (ERESTARTSYS,
+ *     ERESTARTNOINTR, ERESTARTNOHAND, ERESTART_RESTARTBLOCK) to EINTR because
+ *     restarting the syscall would be incorrect once the fd is freed.
+ *
+ * error: EIO, I/O error
+ *   desc: An I/O error occurred during the flush of buffered data to the
+ *     underlying storage. This typically indicates a hardware error, network
+ *     failure on NFS, or other storage system error. The file descriptor is
+ *     still closed. Previously buffered write data may have been lost.
+ *
+ * error: ENOSPC, No space left on device
+ *   desc: There was insufficient space on the storage device to flush buffered
+ *     writes. This is common on NFS when the server runs out of space between
+ *     write() and close(). The file descriptor is still closed.
+ *
+ * error: EDQUOT, Disk quota exceeded
+ *   desc: The user's disk quota was exceeded while attempting to flush buffered
+ *     writes. Common on NFS when quota is exceeded between write() and close().
+ *     The file descriptor is still closed.
+ *
+ * lock: files->file_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Acquired via file_close_fd() to atomically lookup and remove the fd
+ *     from the file descriptor table. Held only during the table manipulation;
+ *     released before flush and final cleanup operations. This ensures that
+ *     another thread cannot allocate the same fd number while close is in
+ *     progress.
+ *
+ * lock: file->f_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Acquired during epoll cleanup (eventpoll_release_file) and dnotify
+ *     cleanup to safely unlink the file from monitoring structures. May also
+ *     be acquired during lock context operations.
+ *
+ * lock: ep->mtx
+ *   type: KAPI_LOCK_MUTEX
+ *   acquired: true
+ *   released: true
+ *   desc: Acquired during epoll cleanup if the file was monitored by epoll.
+ *     Used to safely remove the file from epoll interest lists.
+ *
+ * lock: flc_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: File lock context spinlock, acquired during locks_remove_file() to
+ *     safely remove POSIX, flock, and lease locks associated with the file.
+ *
+ * signal: pending_signals
+ *   direction: KAPI_SIGNAL_RECEIVE
+ *   action: KAPI_SIGNAL_ACTION_RETURN
+ *   condition: When flush callback performs interruptible wait
+ *   desc: If the file's flush callback (e.g., nfs_file_flush) performs an
+ *     interruptible wait and a signal is pending, the wait is interrupted.
+ *     Any kernel restart codes are converted to EINTR since close cannot be
+ *     restarted after the fd is freed.
+ *   error: -EINTR
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   restartable: no
+ *
+ * side-effect: KAPI_EFFECT_RESOURCE_DESTROY | KAPI_EFFECT_IRREVERSIBLE
+ *   target: File descriptor table entry
+ *   desc: The file descriptor is removed from the process's file descriptor
+ *     table, making the fd number available for reuse by subsequent open(),
+ *     dup(), or similar calls. This occurs BEFORE any flush or cleanup that
+ *     might fail, making the operation irreversible regardless of return value.
+ *   condition: Always (when fd is valid)
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_LOCK_RELEASE
+ *   target: POSIX advisory locks, OFD locks, flock locks
+ *   desc: All advisory locks held on the file by this process are removed.
+ *     POSIX locks are removed via locks_remove_posix() during filp_flush().
+ *     All lock types (POSIX, OFD, flock) are removed via locks_remove_file()
+ *     during __fput() when this is the last reference.
+ *   condition: File has FMODE_OPENED and !(FMODE_PATH)
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_RESOURCE_DESTROY
+ *   target: File leases
+ *   desc: Any file leases held on the file are removed during locks_remove_file()
+ *     when this is the last reference to the open file description.
+ *   condition: File had leases and this is the last close
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: dnotify registrations
+ *   desc: Directory notification (dnotify) registrations associated with this
+ *     file are cleaned up via dnotify_flush(). This only applies to directories.
+ *   condition: File is a directory with dnotify registrations
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: epoll interest lists
+ *   desc: If the file was being monitored by epoll instances, it is removed
+ *     from those interest lists via eventpoll_release().
+ *   condition: File was added to epoll instances
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_FILESYSTEM
+ *   target: Buffered data
+ *   desc: The file's flush callback is invoked if defined (e.g., NFS calls
+ *     nfs_file_flush). This attempts to write any buffered data to storage
+ *     and may return errors (EIO, ENOSPC, EDQUOT) if the flush fails. The
+ *     success of this flush is NOT guaranteed even with a 0 return; use
+ *     fsync() before close() to ensure data persistence.
+ *   condition: File has a flush callback and was opened for writing
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_FREE_MEMORY
+ *   target: struct file and related structures
+ *   desc: When this is the last reference to the file, __fput() is called
+ *     synchronously (fput_close_sync), which frees the file structure, releases
+ *     the dentry and mount references, and invokes the file's release callback.
+ *   condition: This is the last reference to the file
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_FILESYSTEM
+ *   target: Unlinked file deletion
+ *   desc: If the file was previously unlinked (deleted) but kept open, closing
+ *     the last reference causes the actual file data to be removed from the
+ *     filesystem and the inode to be freed.
+ *   condition: File was unlinked and this is the last reference
+ *   reversible: no
+ *
+ * state-trans: file_descriptor
+ *   from: open
+ *   to: closed/free
+ *   condition: Valid fd passed to close
+ *   desc: The file descriptor transitions from open (usable) to closed (invalid).
+ *     The fd number becomes available for reuse. This transition occurs early
+ *     in close() processing, before any operations that might fail.
+ *
+ * state-trans: file_reference_count
+ *   from: n
+ *   to: n-1 (or freed if n was 1)
+ *   condition: Always on successful fd lookup
+ *   desc: The file's reference count is decremented. If this was the last
+ *     reference, the file is fully cleaned up and freed.
+ *
+ * constraint: File Descriptor Reuse Race
+ *   desc: Because the fd is freed early in close() processing, another thread
+ *     may receive the same fd number from a concurrent open() before close()
+ *     returns. Applications must not retry close() after an error return, as
+ *     this could close an unrelated file opened by another thread.
+ *   expr: After close(fd) returns (even with error), fd is invalid
+ *
+ * examples: close(fd);  // Basic usage - ignore errors (common but not ideal)
+ *   if (close(fd) == -1) perror("close");  // Log errors for debugging
+ *   fsync(fd); close(fd);  // Ensure data persistence before closing
+ *
+ * notes: This syscall has subtle non-POSIX semantics: the fd is ALWAYS closed
+ *   regardless of the return value. POSIX specifies that on EINTR, the state
+ *   of the fd is unspecified, but Linux always closes it. HP-UX requires
+ *   retrying close() on EINTR, but doing so on Linux may close an unrelated
+ *   fd that was reassigned by another thread. For portable code, the safest
+ *   approach is to check for errors but never retry close().
+ *
+ *   Error codes from the flush callback (EIO, ENOSPC, EDQUOT) indicate that
+ *   previously written data may have been lost. These errors are particularly
+ *   common on NFS where write errors are often deferred to close time.
+ *
+ *   The driver's release() callback errors are explicitly ignored by the
+ *   kernel, so device driver cleanup errors are not propagated to userspace.
+ *
+ *   Calling close() on a file descriptor while another thread is using it
+ *   (e.g., in a blocking read() or write()) has implementation-defined
+ *   behavior. On Linux, the blocked operation continues on the underlying
+ *   file and may complete even after close() returns.
+ *
+ * since-version: 1.0
  */
 SYSCALL_DEFINE1(close, unsigned int, fd)
 {
-- 
2.51.0


