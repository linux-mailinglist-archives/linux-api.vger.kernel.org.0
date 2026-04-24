Return-Path: <linux-api+bounces-6173-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID97IH+i62kbPgAAu9opvQ
	(envelope-from <linux-api+bounces-6173-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 19:03:59 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AA14618C5
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 19:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E99D3021C32
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580353ECBE6;
	Fri, 24 Apr 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnMcoCVg"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9553ECBD8;
	Fri, 24 Apr 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049515; cv=none; b=CSuRYqSmigEqDeEsco6+95afzPU23VUt0o1QPxDCfHTUigHKk+1s0SILf7U4bBlypSHZ0oMRJ7g102MtIqhXJX71Lx/O6CLmEPk7zABl/5jMrGCO5UH9kNBmQW/NqRR1iCXrCi79GTXmoescq2ZLNVhn5Z0vegq+/19H+kaHwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049515; c=relaxed/simple;
	bh=OvtZp4sfYE2T2BlAPDjeuju4mCI0zDKdzdsx0m/+q2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/UKGmU+wm86g1n444eGEPY66V2DMTdvMI/Qzqg5XhlXEAWO01R0/oefxAUTBqIMf52aeVnnca1ioUGJrzOYidXZUvrBumOPB8CGIiw07CFdLOkXKlgAjQctzlQsEzuyLTUSMuPejBimTDu73tjqVZ40H5jEAJ6HkzVSp76AwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnMcoCVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41726C2BCB2;
	Fri, 24 Apr 2026 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777049515;
	bh=OvtZp4sfYE2T2BlAPDjeuju4mCI0zDKdzdsx0m/+q2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnMcoCVg0jUHrFGkqt765pounKkbKbQT55DY1TF0exfzfZ0S1QsaKJjrEl7p5yTer
	 tE/AZkM9DglGWTx0xb0NS1/StQXQRnUYkfsU7zxga+PXelP6sSib058BIrbLXGNToZ
	 pZW2JenY+KK5nDL3cL9LAWs5asBjit/yraZfouE5htAnsftKqU6EE5YLIlNVBNz27D
	 A7YUDIUpW/0DSCjVIXJ3cWfi+AWBDWm+Jej+n/tJOUae1eU5LWCHF5MuyY0A79abGv
	 sXEchr8NMqfXJ9MFngrkFbAfW4tncTsrlh8aAcIz5iJTfakJeZqYv2U7Zmc4vLU1V8
	 17Qo5ayBhstFg==
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
Subject: [PATCH v3 6/9] kernel/api: add API specification for sys_close
Date: Fri, 24 Apr 2026 12:51:26 -0400
Message-ID: <20260424165130.2306833-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424165130.2306833-1-sashal@kernel.org>
References: <20260424165130.2306833-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9AA14618C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6173-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

Add KAPI-annotated kerneldoc for the sys_close system call in fs/open.c.

The specification documents the file descriptor parameter, error
conditions, locking requirements, side effects on pending I/O, and
the close-on-exec relationship.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/open.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 782883978c7b6..0c9c3a61eda26 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1808,6 +1808,250 @@ EXPORT_SYMBOL(filp_close);
  * releasing the fd. This ensures that one clone task can't release
  * an fd while another clone is opening it.
  */
+/**
+ * sys_close - Close a file descriptor
+ * @fd: The file descriptor to close
+ *
+ * long-desc: Terminates access to an open file descriptor, releasing the file
+ *   descriptor for reuse by subsequent open(), dup(), or similar syscalls.
+ *
+ *   Traditional POSIX advisory record locks held by the process on the
+ *   associated file are released (note: POSIX locks are released when ANY fd
+ *   for that inode is closed by the process, not just the last one). OFD locks
+ *   and flock locks are associated with the open file description and are only
+ *   released when the last file descriptor referring to that open file
+ *   description is closed.
+ *   When this is the last file descriptor
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
+ *   Note that close() does not affect the close-on-exec flag set via
+ *   fcntl(fd, F_SETFD, FD_CLOEXEC) or O_CLOEXEC on other file descriptors.
+ *   The close-on-exec flag only causes automatic close during exec(), not
+ *   during explicit close() calls.
+ *
+ *   On close, the following cleanup operations are performed: POSIX advisory
+ *   locks are removed, dnotify registrations are cleaned up, the file is
+ *   flushed to storage if applicable, and the file
+ *   reference is released. If this was the last reference, additional cleanup
+ *   includes: fsnotify close notification, epoll cleanup, flock and lease
+ *   removal, FASYNC cleanup, and the file structure deallocation.
+ *
+ * contexts: process, sleepable
+ *
+ * param: fd
+ *   type: fd, input
+ *   constraint-type: range(0, INT_MAX)
+ *   cdesc: Must be a valid, open file descriptor for the current process.
+ *     The value 0, 1, or 2 (stdin, stdout, stderr) may be closed like any other
+ *     fd, though this is unusual and may cause issues with libraries that assume
+ *     these descriptors are valid. The parameter is unsigned int to match kernel
+ *     file descriptor table indexing, but values exceeding INT_MAX are effectively
+ *     invalid due to internal checks.
+ *
+ * return:
+ *   type: int
+ *   check-type: exact
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
+ *   type: spinlock
+ *   acquired: true
+ *   released: true
+ *   desc: Acquired via file_close_fd() to atomically lookup and remove the fd
+ *     from the file descriptor table. Held only during the table manipulation;
+ *     released before flush and final cleanup operations. This ensures that
+ *     another thread cannot allocate the same fd number while close is in
+ *     progress.
+ *
+ * lock: file->f_lock
+ *   type: spinlock
+ *   acquired: true
+ *   released: true
+ *   desc: Acquired during epoll cleanup (eventpoll_release_file) and dnotify
+ *     cleanup to safely unlink the file from monitoring structures. May also
+ *     be acquired during lock context operations.
+ *
+ * lock: ep->mtx
+ *   type: mutex
+ *   acquired: true
+ *   released: true
+ *   desc: Acquired during epoll cleanup if the file was monitored by epoll.
+ *     Used to safely remove the file from epoll interest lists.
+ *
+ * lock: flc_lock
+ *   type: spinlock
+ *   acquired: true
+ *   released: true
+ *   desc: File lock context spinlock, acquired during locks_remove_file() to
+ *     safely remove POSIX, flock, and lease locks associated with the file.
+ *
+ * signal: pending_signals
+ *   direction: receive
+ *   action: return
+ *   condition: When close-time flush performs interruptible wait
+ *   desc: If the close-time flush operation (e.g., on NFS) performs an
+ *     interruptible wait and a signal is pending, the wait is interrupted.
+ *     Any kernel restart codes are converted to EINTR since close cannot be
+ *     restarted after the fd is freed.
+ *   errno: -EINTR
+ *   timing: during
+ *   restartable: no
+ *
+ * side-effect: resource_destroy | irreversible
+ *   target: File descriptor table entry
+ *   desc: The file descriptor is removed from the process's file descriptor
+ *     table, making the fd number available for reuse by subsequent open(),
+ *     dup(), or similar calls. This occurs BEFORE any flush or cleanup that
+ *     might fail, making the operation irreversible regardless of return value.
+ *   condition: Always (when fd is valid)
+ *   reversible: no
+ *
+ * side-effect: lock_release
+ *   target: POSIX advisory locks, OFD locks, flock locks
+ *   desc: All advisory locks held on the file by this process are removed.
+ *     POSIX locks are removed via locks_remove_posix() during filp_flush().
+ *     All lock types (POSIX, OFD, flock) are removed via locks_remove_file()
+ *     during __fput() when this is the last reference.
+ *   condition: File has FMODE_OPENED and !(FMODE_PATH)
+ *   reversible: no
+ *
+ * side-effect: resource_destroy
+ *   target: File leases
+ *   desc: Any file leases held on the file are removed during locks_remove_file()
+ *     when this is the last reference to the open file description.
+ *   condition: File had leases and this is the last close
+ *   reversible: no
+ *
+ * side-effect: modify_state
+ *   target: dnotify registrations
+ *   desc: Directory notification (dnotify) registrations associated with this
+ *     file are cleaned up via dnotify_flush(). This only applies to directories.
+ *   condition: File is a directory with dnotify registrations
+ *   reversible: no
+ *
+ * side-effect: modify_state
+ *   target: epoll interest lists
+ *   desc: If the file was being monitored by epoll instances, it is removed
+ *     from those interest lists via eventpoll_release().
+ *   condition: File was added to epoll instances
+ *   reversible: no
+ *
+ * side-effect: filesystem
+ *   target: Buffered data
+ *   desc: Any buffered data is flushed if applicable (e.g., on NFS). This
+ *     attempts to write any buffered data to storage
+ *     and may return errors (EIO, ENOSPC, EDQUOT) if the flush fails. The
+ *     success of this flush is NOT guaranteed even with a 0 return; use
+ *     fsync() before close() to ensure data persistence.
+ *   condition: File was opened for writing and has buffered data
+ *   reversible: no
+ *
+ * side-effect: free_memory
+ *   target: struct file and related structures
+ *   desc: When this is the last reference to the file, the file structure is
+ *     freed and the dentry and mount references are released.
+ *   condition: This is the last reference to the file
+ *   reversible: no
+ *
+ * side-effect: filesystem
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
+ */
 SYSCALL_DEFINE1(close, unsigned int, fd)
 {
 	int retval;
-- 
2.53.0


