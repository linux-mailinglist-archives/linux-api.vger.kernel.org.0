Return-Path: <linux-api+bounces-6020-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L3JA7jdv2m69QMAu9opvQ
	(envelope-from <linux-api+bounces-6020-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 13:16:56 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 603AD2E91D5
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 13:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB0FA3010D8B
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7353806CD;
	Sun, 22 Mar 2026 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o19YDNd5"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DD37F74A;
	Sun, 22 Mar 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181453; cv=none; b=FiZewJ6gCJP00e5DmHERpwCK187FytbDkx1CV/u9rdDiehz4aKnV8cjN761j1XTetngbogFDQzgKoiMezG8wPQfIQT+jitbnIYLkqBdfHXmhoA/UmpjBXoZ/uiCyI0XDYC4evULUVcq4dm9CCfzPXu44qqVVyCrZ2rQUOOp22hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181453; c=relaxed/simple;
	bh=9wfYBB4Iv8NMQdqH6lmlA+BhijBZ/I2z1A5bOlZW4uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAm7n0e5OfjtpRJyK3XCnx7iz9bN5qsLMMX4W776iYPmvV9CWrEpno0xPD884zoL/rafZ+4429Xa5a3q7RwaTg64VOOaqoMJmyZ1C3tHNjRkdPmXgNZ8Uj7ELOO53wgqNChN5p8OR4ppsQk2kr1apEKJzX2lE04S4bfNWarbFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o19YDNd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C642C2BCB1;
	Sun, 22 Mar 2026 12:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774181453;
	bh=9wfYBB4Iv8NMQdqH6lmlA+BhijBZ/I2z1A5bOlZW4uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o19YDNd5XBlWEGO+gaNKZIlmiMu7I8+LwseiJoRc7veK+FT3B3io68vXtAu2g2y0V
	 ycaSDxckQidb1KnJlcM9LqLIb0erHY4hyPwDQ4tCHaHk3GXx3ja0DKwOhcx8xp8m4I
	 kaoHoLWapuH5Wuy9DIHC+pnfSMzTdjM1Jo+b/FVFs82EpZzlzhjt0ay8Waso5Fa6NH
	 PjMLgNamkzHvPVh/UQO8UG1XECtkBxwjeiyAcC1jm/WYfLmuY3/dHDbiNDRmQa5/wc
	 D4xsSdg63tHbvwgW/ym+EcQsTssV88djHcynkcVlRcUt61zat/LERi4JhgKObR32NZ
	 WDcaHdCmSbkOg==
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
Subject: [PATCH v2 7/9] kernel/api: add API specification for sys_read
Date: Sun, 22 Mar 2026 08:10:21 -0400
Message-ID: <20260322121026.869758-8-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-6020-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 603AD2E91D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add KAPI-annotated kerneldoc for the sys_read system call in
fs/read_write.c.

The specification documents parameter constraints (fd, user buffer,
count), error conditions, locking requirements, signal handling
behavior, and short read semantics.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/read_write.c | 303 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 303 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 50bff7edc91f3..bee19b7ddadcf 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -721,6 +721,304 @@ ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
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
+ *   cdesc: Must be a valid, open file descriptor with read permission.
+ *     The file must have been opened with O_RDONLY or O_RDWR. Special values
+ *     like AT_FDCWD are not valid. File descriptors for directories return
+ *     EISDIR. Standard file descriptors 0 (stdin), 1 (stdout), 2 (stderr) are
+ *     valid if open and readable.
+ *
+ * param: buf
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_OUT | KAPI_PARAM_USER
+ *   constraint-type: KAPI_CONSTRAINT_BUFFER
+ *   size-param: 2
+ *   cdesc: Must point to a valid, writable user-space memory region of at
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
+ *   cdesc: Maximum number of bytes to read. Clamped internally to
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
+ * error: ENODATA, No data available
+ *   desc: Returned when reading from files backed by fscache/cachefiles
+ *     and the requested data range is not available in the cache
+ *     (e.g., beyond EOF or in an uncached region). Also returned by
+ *     some filesystem-specific read handlers (e.g., xattr reads).
+ *
+ * error: EOPNOTSUPP, Operation not supported
+ *   desc: Returned when the file descriptor does not support the read
+ *     operation, such as reading from certain special files or when the
+ *     filesystem does not implement read for this file type.
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
+ *     (read characters) is incremented by bytes read via add_rchar() only on
+ *     successful reads (ret > 0). The syscr field (syscall read count) is
+ *     incremented unconditionally via inc_syscr(). These statistics are visible
+ *     in /proc/[pid]/io.
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
+ */
 SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
 {
 	return ksys_read(fd, buf, count);
@@ -1821,3 +2119,8 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(generic_atomic_write_valid);
+
+/* Include auto-generated API specifications from kerneldoc annotations */
+#if IS_ENABLED(CONFIG_KAPI_SPEC)
+#include "read_write.apispec.h"
+#endif
-- 
2.51.0


