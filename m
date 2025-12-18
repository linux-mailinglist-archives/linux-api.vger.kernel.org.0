Return-Path: <linux-api+bounces-5565-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AB4CCD96A
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 21:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7DA53074A94
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D733121B;
	Thu, 18 Dec 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A41kOROO"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1513933064A;
	Thu, 18 Dec 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090579; cv=none; b=lRPkZNcyuwnlMnmolwHXWbsLCQ2w4ks1jm8b6elSedaybn/hHvOoKGHvggNOCuKoWZKAt27303QqCda5xSWEAi7CXIvU57LlEacP4uciDP3k0qcU9qmIWxVO/UHMXoHUrhnELU0eqsZsvR3gv1L0PybqljTT2E3QB2Hp1nYKnqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090579; c=relaxed/simple;
	bh=iJZKXJCaRCjR9e8zmoORtXZj353a0RM7OTM7Pkd37e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaKG7Yukh0Ol0wPYhfySmGBxdToAcvEzLo+CsktRIC/YRiZSSLkHAf0bhWcIRpnC+jSQ6o03SQkZ/c357w9VGMwMsVGsHDiIHCvsvTtOpv2NH3Z4JeC6Jk/upqQaFPBl6/qZ3icz9jcymbv0JKgm/JVgiVCotqk+ndo7PGdrXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A41kOROO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9A5C113D0;
	Thu, 18 Dec 2025 20:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090579;
	bh=iJZKXJCaRCjR9e8zmoORtXZj353a0RM7OTM7Pkd37e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A41kOROOnYPnHtXpGMwOokIa6i5Y69O6hfthXj12fcY3I3O4ycsdnDU1D+bXKQRfk
	 I60IaMqOqYigaC6PihwirdKyesBa3zmEPU2aDBxboXeJWpxM5h7JXB/rABMjPoUZyW
	 oE+DbCRDeuOevHs2bt3SRyGM3A4hcZvj+VClGY5R8klElhwOYVa4D3o3zOR+xqlHSe
	 Stu+FsbwhUUB1dqg1+Jq4xseXRaCi4c2EVx2X5at4SMoZECNFEmO8rHhY/w6fSdG32
	 KNPEq8A9usV+2rTwdzq3jWj6Rfo2u4XWsWcWrUUwB+aI0eDABDgq1c0DNo5sngApFC
	 kV43OcoSiBUVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 14/15] kernel/api: add API specification for sys_read
Date: Thu, 18 Dec 2025 15:42:36 -0500
Message-ID: <20251218204239.4159453-15-sashal@kernel.org>
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
 fs/read_write.c | 287 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 287 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770a..422046a666b1d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -719,6 +719,293 @@ ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 	return ret;
 }
 
+/**
+ * sys_read - Read data from a file descriptor
+ * @fd: File descriptor to read from
+ * @buf: User-space buffer to read data into
+ * @count: Maximum number of bytes to read
+ *
+ * long-desc: Attempts to read up to count bytes from file descriptor fd into
+ *   the buffer starting at buf. For seekable files (regular files, block
+ *   devices), the read begins at the current file offset, and the file offset
+ *   is advanced by the number of bytes read. For non-seekable files (pipes,
+ *   FIFOs, sockets, character devices), the file offset is not used.
+ *
+ *   If count is zero and fd refers to a regular file, read() may detect errors
+ *   as described below. In the absence of errors, or if read() does not check
+ *   for errors, a read() with a count of 0 returns zero and has no other effects.
+ *
+ *   On success, the number of bytes read is returned (zero indicates end of
+ *   file for regular files). It is not an error if this number is smaller than
+ *   the number of bytes requested; this may happen because fewer bytes are
+ *   actually available right now (maybe because we were close to end-of-file,
+ *   or because we are reading from a pipe, socket, or terminal), or because
+ *   read() was interrupted by a signal.
+ *
+ *   On Linux, read() transfers at most MAX_RW_COUNT (0x7ffff000, approximately
+ *   2GB) bytes per call, regardless of whether the filesystem would allow more.
+ *   This is to avoid issues with signed arithmetic overflow on 32-bit systems.
+ *
+ *   POSIX allows reads that are interrupted after reading some data to either
+ *   return -1 (with errno set to EINTR) or return the number of bytes already
+ *   read. Linux follows the latter behavior: if data has been read before a
+ *   signal arrives, the call returns the bytes read rather than failing.
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: fd
+ *   type: KAPI_TYPE_FD
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 0, INT_MAX
+ *   constraint: Must be a valid, open file descriptor with read permission.
+ *     The file must have been opened with O_RDONLY or O_RDWR. Special values
+ *     like AT_FDCWD are not valid. File descriptors for directories return
+ *     EISDIR. Standard file descriptors 0 (stdin), 1 (stdout), 2 (stderr) are
+ *     valid if open and readable.
+ *
+ * param: buf
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_OUT | KAPI_PARAM_USER
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Must point to a valid, writable user-space memory region of at
+ *     least count bytes. The buffer is validated via access_ok() before any
+ *     read operation. NULL is invalid and will return EFAULT. The buffer may
+ *     be partially written if an error occurs mid-read. For O_DIRECT reads,
+ *     the buffer may need to be aligned to the filesystem's block size (varies
+ *     by filesystem, check via statx() with STATX_DIOALIGN).
+ *
+ * param: count
+ *   type: KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 0, SIZE_MAX
+ *   constraint: Maximum number of bytes to read. Clamped internally to
+ *     MAX_RW_COUNT (INT_MAX & PAGE_MASK, approximately 0x7ffff000 bytes) to
+ *     prevent signed overflow issues. A count of 0 returns immediately with 0
+ *     without accessing the file (but may still detect errors). Large values
+ *     are not errors but will be clamped. Cast to ssize_t must not be negative.
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_RANGE
+ *   success: >= 0
+ *   desc: On success, returns the number of bytes read (non-negative). Zero
+ *     indicates end-of-file (EOF) for regular files, or no data available
+ *     from a device that does not block. The return value may be less than
+ *     count if fewer bytes were available (short read). Partial reads are
+ *     not errors. On error, returns a negative error code.
+ *
+ * error: EBADF, Bad file descriptor
+ *   desc: fd is not a valid file descriptor, or fd was not opened for reading.
+ *     This includes file descriptors opened with O_WRONLY, O_PATH, or file
+ *     descriptors that have been closed. Also returned if the file structure
+ *     does not have FMODE_READ set.
+ *
+ * error: EFAULT, Bad address
+ *   desc: buf points outside the accessible address space. The buffer address
+ *     failed access_ok() validation. Can also occur if a fault happens during
+ *     copy_to_user() when transferring data to user space after the read
+ *     completes in kernel space.
+ *
+ * error: EINVAL, Invalid argument
+ *   desc: Returned in several cases: (1) The file descriptor refers to an
+ *     object that is not suitable for reading (no read or read_iter method).
+ *     (2) The file was opened with O_DIRECT and the buffer alignment, offset,
+ *     or count does not meet the filesystem's alignment requirements. (3) For
+ *     timerfd file descriptors, the buffer is smaller than 8 bytes. (4) The
+ *     count argument, when cast to ssize_t, is negative.
+ *
+ * error: EISDIR, Is a directory
+ *   desc: fd refers to a directory. Directories cannot be read using read();
+ *     use getdents64() instead. This error is returned by the generic_read_dir()
+ *     handler installed for directory file operations.
+ *
+ * error: EAGAIN, Resource temporarily unavailable
+ *   desc: fd refers to a file (pipe, socket, device) that is marked non-blocking
+ *     (O_NONBLOCK) and the read would block. Also returned with IOCB_NOWAIT
+ *     when data is not immediately available. Equivalent to EWOULDBLOCK.
+ *     The application should retry the read later or use select/poll/epoll.
+ *
+ * error: EINTR, Interrupted system call
+ *   desc: The call was interrupted by a signal before any data was read. This
+ *     only occurs if no data has been transferred; if some data was read before
+ *     the signal, the call returns the number of bytes read. The caller should
+ *     typically restart the read.
+ *
+ * error: EIO, Input/output error
+ *   desc: A low-level I/O error occurred. For regular files, this typically
+ *     indicates a hardware error on the storage device, a filesystem error,
+ *     or a network filesystem timeout. For terminals, this may indicate the
+ *     controlling terminal has been closed for a background process.
+ *
+ * error: EOVERFLOW, Value too large for defined data type
+ *   desc: The file position plus count would exceed LLONG_MAX. Also returned
+ *     when reading from certain files (e.g., some /proc files) where the file
+ *     position would overflow. For files without FOP_UNSIGNED_OFFSET flag,
+ *     negative file positions are not allowed.
+ *
+ * error: ENOBUFS, No buffer space available
+ *   desc: Returned when reading from pipe-based watch queues (CONFIG_WATCH_QUEUE)
+ *     when the buffer is too small to hold a complete notification, or when
+ *     reading packets from pipes with PIPE_BUF_FLAG_WHOLE set.
+ *
+ * error: ERESTARTSYS, Restart system call (internal)
+ *   desc: Internal error code indicating the syscall should be restarted. This
+ *     is typically translated to EINTR if SA_RESTART is not set on the signal
+ *     handler, or the syscall is transparently restarted if SA_RESTART is set.
+ *     User space should not see this error code directly.
+ *
+ * error: EACCES, Permission denied
+ *   desc: The security subsystem (LSM such as SELinux or AppArmor) denied
+ *     the read operation via security_file_permission(). This can occur even
+ *     if the file was successfully opened, as LSM policies may enforce per-
+ *     operation checks.
+ *
+ * error: EPERM, Operation not permitted
+ *   desc: Returned by fanotify permission events (CONFIG_FANOTIFY_ACCESS_PERMISSIONS)
+ *     when a user-space fanotify listener denies the read operation via
+ *     fsnotify_file_area_perm().
+ *
+ * lock: file->f_pos_lock
+ *   type: KAPI_LOCK_MUTEX
+ *   acquired: conditional
+ *   released: true
+ *   desc: For regular files that require atomic position updates (FMODE_ATOMIC_POS),
+ *     the f_pos_lock mutex is acquired by fdget_pos() at syscall entry and released
+ *     by fdput_pos() at syscall exit. This serializes concurrent reads that share
+ *     the same file description. Not acquired for files opened with FMODE_STREAM
+ *     (pipes, sockets) or when the file is not shared.
+ *
+ * lock: Filesystem-specific locks
+ *   type: KAPI_LOCK_CUSTOM
+ *   acquired: conditional
+ *   released: true
+ *   desc: The filesystem's read_iter or read method may acquire additional locks.
+ *     For regular files, this typically includes the inode's i_rwsem for certain
+ *     operations. For pipes, the pipe->mutex is acquired. For sockets, socket
+ *     lock is acquired. These are internal to the file operation and released
+ *     before return.
+ *
+ * lock: RCU read-side
+ *   type: KAPI_LOCK_RCU
+ *   acquired: conditional
+ *   released: true
+ *   desc: Used during file descriptor lookup via fdget(). RCU read lock protects
+ *     access to the file descriptor table. Released by fdput() at syscall exit.
+ *
+ * signal: Any signal
+ *   direction: KAPI_SIGNAL_RECEIVE
+ *   action: KAPI_SIGNAL_ACTION_RETURN
+ *   condition: When blocked waiting for data on interruptible operations
+ *   desc: The syscall may be interrupted by signals while waiting for data to
+ *     become available (pipes, sockets, terminals) or waiting for locks. If
+ *     interrupted before any data is read, returns -EINTR or -ERESTARTSYS.
+ *     If data has already been read, returns the number of bytes read.
+ *   error: -EINTR
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   restartable: yes
+ *
+ * side-effect: KAPI_EFFECT_FILE_POSITION
+ *   target: file->f_pos
+ *   condition: For seekable files when read succeeds (returns > 0)
+ *   desc: The file offset (f_pos) is advanced by the number of bytes read.
+ *     For stream files (FMODE_STREAM such as pipes and sockets), the offset
+ *     is not used or modified. The offset update is protected by f_pos_lock
+ *     when the file is shared between threads/processes.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: inode access time (atime)
+ *   condition: When read succeeds and O_NOATIME is not set
+ *   desc: Updates the file's access time (atime) via touch_atime(). The update
+ *     may be suppressed by mount options (noatime, relatime), the O_NOATIME
+ *     flag, or if the filesystem does not support atime. Relatime only updates
+ *     atime if it is older than mtime or ctime, or more than a day old.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: task I/O accounting
+ *   condition: Always
+ *   desc: Updates the current task's I/O accounting statistics. The rchar field
+ *     (read characters) is incremented by bytes read via add_rchar(). The syscr
+ *     field (syscall read count) is incremented via inc_syscr(). These statistics
+ *     are visible in /proc/[pid]/io. Updated regardless of success or failure.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: fsnotify events
+ *   condition: When read returns > 0
+ *   desc: Generates an FS_ACCESS fsnotify event via fsnotify_access() allowing
+ *     inotify, fanotify, and dnotify watchers to be notified of the read. This
+ *     occurs after data transfer completes successfully.
+ *   reversible: no
+ *
+ * capability: CAP_DAC_OVERRIDE
+ *   type: KAPI_CAP_BYPASS_CHECK
+ *   allows: Bypass discretionary access control on read permission
+ *   without: Standard DAC checks are enforced
+ *   condition: Checked via security_file_permission() during rw_verify_area()
+ *
+ * capability: CAP_DAC_READ_SEARCH
+ *   type: KAPI_CAP_BYPASS_CHECK
+ *   allows: Bypass read permission checks on regular files
+ *   without: Must have read permission on file
+ *   condition: Checked by LSM hooks during the read operation
+ *
+ * constraint: MAX_RW_COUNT
+ *   desc: The count parameter is silently clamped to MAX_RW_COUNT (INT_MAX &
+ *     PAGE_MASK, approximately 2GB minus one page) to prevent integer overflow
+ *     in internal calculations. This is transparent to the caller; the syscall
+ *     succeeds but reads at most MAX_RW_COUNT bytes.
+ *   expr: actual_count = min(count, MAX_RW_COUNT)
+ *
+ * constraint: File must be open for reading
+ *   desc: The file descriptor must have been opened with O_RDONLY or O_RDWR.
+ *     Files opened with O_WRONLY or O_PATH cannot be read and return EBADF.
+ *     The file must have both FMODE_READ and FMODE_CAN_READ flags set.
+ *   expr: (file->f_mode & FMODE_READ) && (file->f_mode & FMODE_CAN_READ)
+ *
+ * examples: n = read(fd, buf, sizeof(buf));  // Basic read
+ *   n = read(STDIN_FILENO, buf, 1024);  // Read from stdin
+ *   while ((n = read(fd, buf, 4096)) > 0) { process(buf, n); }  // Read loop
+ *   if (read(fd, buf, count) == 0) { handle_eof(); }  // Check for EOF
+ *
+ * notes: The behavior of read() varies significantly depending on the type of
+ *   file descriptor:
+ *
+ *   - Regular files: Reads from current position, advances position, returns 0
+ *     at EOF. Short reads are rare but possible near EOF or on signal.
+ *
+ *   - Pipes and FIFOs: Blocking by default. Returns available data (up to count)
+ *     or blocks until data is available. Returns 0 when all writers have closed.
+ *     O_NONBLOCK returns EAGAIN when empty instead of blocking.
+ *
+ *   - Sockets: Similar to pipes. Specific behavior depends on socket type and
+ *     protocol. MSG_* flags can be specified via recv() for more control.
+ *
+ *   - Terminals: Line-buffered in canonical mode; read returns when newline is
+ *     entered or buffer is full. Raw mode returns immediately when data available.
+ *     Special handling for signals (SIGINT on Ctrl+C, etc.).
+ *
+ *   - Device special files: Behavior is device-specific. Some devices support
+ *     seeking, others do not. Read size may be constrained by device.
+ *
+ *   Race condition: Concurrent reads from the same file description (not just
+ *   file descriptor) can race on the file position. Linux 3.14+ provides atomic
+ *   position updates for regular files via f_pos_lock, but applications should
+ *   use pread() for concurrent positioned reads.
+ *
+ *   O_DIRECT reads bypass the page cache and typically require aligned buffers
+ *   and positions. Alignment requirements are filesystem-specific; use statx()
+ *   with STATX_DIOALIGN (Linux 6.1+) to query. Unaligned O_DIRECT reads fail
+ *   with EINVAL on most filesystems.
+ *
+ *   For splice(2)-like zero-copy reads, consider using splice(), sendfile(),
+ *   or copy_file_range() instead of read() + write().
+ *
+ * since-version: 1.0
+ */
 SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
 {
 	return ksys_read(fd, buf, count);
-- 
2.51.0


