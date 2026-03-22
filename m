Return-Path: <linux-api+bounces-6019-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LdDAH/dv2m69QMAu9opvQ
	(envelope-from <linux-api+bounces-6019-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 13:15:59 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 746182E91BD
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 13:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087EA300EFA5
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B237FF69;
	Sun, 22 Mar 2026 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs4A0gue"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047E37187C;
	Sun, 22 Mar 2026 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181451; cv=none; b=bYn4QzRCtSmCYeViAhRWWKZriKw+lBhBtk+govKE+MyLgiiw5J0sxutMo8CowDYW9zG6KomlMmfPmOmL3xF22ljUY30T/bR/rOPYC0ucmFvmNK4aD0ElFRGfb+ePJumIPU2r7mf55IPCbNv5nulMUnqzez24XB5rMuvUmTYXZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181451; c=relaxed/simple;
	bh=mFeiW+a5Szy+aO6up2koNqNiZl7TRr1q5IpoZQyC/FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIkF5q56BvY88d5R6ca/Be2YVlKo+CPRzhYweN6Pe6NQyxAozjWC9N9z1TuEV+4yHsb1lLwDeHoFwqX6kgAaan5nZ0fKdKUQOV7SAZHg3gZQ1MPki0TixKPrMhZcR1Wc9hdVs+w30L3lx45eGJBbhW6OsScwBgnqZa1Pz0mMO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs4A0gue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A065C2BCB6;
	Sun, 22 Mar 2026 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774181450;
	bh=mFeiW+a5Szy+aO6up2koNqNiZl7TRr1q5IpoZQyC/FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fs4A0gueTQPClCZ7pBwyoULcB7j75OMOH2ZX272yZXUNkRl1AuFw36KRbfUoBfql6
	 M2Xa75T8esfaBDkcabNhFm9CZ+w+hq8seB5OYWKvGZvySaEvfm9GfYHbMgaV+6RZvY
	 p1XJrh/+ZkEv3rDHsj8rX6j5zkEC4PUcAFL74bMDNm9WcNDSvVp5sTryVwQGM/yVvw
	 uUad+0Jti0Z7NWh5qJyQ0RA6l9QFjNbZ0BdsgF9qjEBrek4/W/CQoOUMoCaTAC9j8J
	 nio+NCeSJAMkiRLRTlfwWJDgLl06enAzwXeDFEHjA+0ynP9JpbWvHFaGJ50wOw1EjY
	 3WuStSK/6v+nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 6/9] kernel/api: add API specification for sys_close
Date: Sun, 22 Mar 2026 08:10:20 -0400
Message-ID: <20260322121026.869758-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260322121026.869758-1-sashal@kernel.org>
References: <20260322121026.869758-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-6019-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 746182E91BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add KAPI-annotated kerneldoc for the sys_close system call in fs/open.c.

The specification documents the file descriptor parameter, error
conditions, locking requirements, side effects on pending I/O, and
the close-on-exec relationship.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/open.c | 238 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 234 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 8e805233a277b..cf74912d15eb5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1808,10 +1808,240 @@ int filp_close(struct file *filp, fl_owner_t id)
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
+ *   flushed to storage if applicable, and the file
+ *   reference is released. If this was the last reference, additional cleanup
+ *   includes: fsnotify close notification, epoll cleanup, flock and lease
+ *   removal, FASYNC cleanup, and the file structure deallocation.
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: fd
+ *   type: KAPI_TYPE_FD
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 0, INT_MAX
+ *   cdesc: Must be a valid, open file descriptor for the current process.
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
+ *     This occurs when the close-time flush operation (e.g., on NFS) performs an
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
+ *   condition: When close-time flush performs interruptible wait
+ *   desc: If the close-time flush operation (e.g., on NFS) performs an
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
+ *   desc: Any buffered data is flushed if applicable (e.g., on NFS). This
+ *     attempts to write any buffered data to storage
+ *     and may return errors (EIO, ENOSPC, EDQUOT) if the flush fails. The
+ *     success of this flush is NOT guaranteed even with a 0 return; use
+ *     fsync() before close() to ensure data persistence.
+ *   condition: File was opened for writing and has buffered data
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_FREE_MEMORY
+ *   target: struct file and related structures
+ *   desc: When this is the last reference to the file, the file structure is
+ *     freed and the dentry and mount references are released.
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
+ * notes: The fd is always freed regardless of the return value. POSIX
+ *   specifies that on EINTR the state of the fd is unspecified, but Linux
+ *   always closes it. Retrying close() after an error may close an unrelated
+ *   fd that was reassigned by another thread, so callers should never retry.
+ *
+ *   Error codes like EIO, ENOSPC, and EDQUOT indicate that previously buffered
+ *   writes may have failed to reach storage. These errors are particularly
+ *   common on NFS where write errors are often deferred to close time.
+ *
+ *   Calling close() on a file descriptor while another thread is using it
+ *   (e.g., in a blocking read() or write()) does not interrupt the blocked
+ *   operation. The blocked operation continues on the underlying file and
+ *   may complete even after close() returns.
  */
 SYSCALL_DEFINE1(close, unsigned int, fd)
 {
-- 
2.51.0


