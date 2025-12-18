Return-Path: <linux-api+bounces-5566-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C1CCD9D7
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 22:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F703035D17
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34090339842;
	Thu, 18 Dec 2025 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI1Szzzi"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334C336EEE;
	Thu, 18 Dec 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090580; cv=none; b=ijXn4NCD+2F4Y6wIphe4sgO6RyPA9KtBTYWn3a0c3Vo0oRrHdelqaEP5i7u5e5Q5M9e9nHGt5cIIvGSWiRGETnAaiTvwBgWrqKVB6eLLzjlUodumbL2snZlK9LiYPlf1STdK2Qjr5JTVBce+i8Vxr2IpUy7QvrAATHxR1b25cas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090580; c=relaxed/simple;
	bh=oL3b1IdHz7HdHacAQkdzJP1OcLLI3zfDFml5NRFS38s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTh8wiAF+0gXyfcUYX03To0JtNlPRequnsbqi/UPRghXzdNdC2r0ZS2d+vwAVy9iMBQ8c0pgXIaV5LlL45yHvEgkcg+KUnhqQYDY99qPkVLDOPWzf4h6TNcHJqdbAeGRpmewSlaI+1JNSWgH4A/+hRpvFcn6Mrg0VfLfkO5gxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI1Szzzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36279C19421;
	Thu, 18 Dec 2025 20:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090579;
	bh=oL3b1IdHz7HdHacAQkdzJP1OcLLI3zfDFml5NRFS38s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rI1Szzzice7aDP+OFJBuhoZ3KxNQ4WkxGN3J9nLZNLSTWQBmiaVB7hRwBPajFFOUf
	 YmsG+f/3uaIq3WZCqQzFgihxRzaDsNmNTBUegYtv/+czHsxU6vh6IgIwNOU9isPLKR
	 CO4E3CuOlOGSsZbn52k4nh7+/NHdVZII59C5MOsNyEix/8K2Vjp4/sVsEBtZWxQ8GA
	 uxK/Ry6vsaDLl+OPcvfMLBERZqTC7VcG+1T7FWQXMHM20r9UPnDYtfvMCOg8gnVRyg
	 Lh7duABLHg9rBVnh1Yb7W9SZLO2EzqGjKCcv+wE41QhNR/Z+PmKUOs+NZqa0sRtE8t
	 egq+peiDyNtjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 15/15] kernel/api: add API specification for sys_write
Date: Thu, 18 Dec 2025 15:42:37 -0500
Message-ID: <20251218204239.4159453-16-sashal@kernel.org>
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
 fs/read_write.c | 377 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 377 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 422046a666b1d..685bf6b9bd3b1 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1030,6 +1030,383 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 	return ret;
 }
 
+/**
+ * sys_write - Write data to a file descriptor
+ * @fd: File descriptor to write to
+ * @buf: User-space buffer containing data to write
+ * @count: Maximum number of bytes to write
+ *
+ * long-desc: Attempts to write up to count bytes from the buffer starting at
+ *   buf to the file referred to by the file descriptor fd. For seekable files
+ *   (regular files, block devices), the write begins at the current file offset,
+ *   and the file offset is advanced by the number of bytes written. If the file
+ *   was opened with O_APPEND, the file offset is first set to the end of the
+ *   file before writing. For non-seekable files (pipes, FIFOs, sockets, character
+ *   devices), the file offset is not used and writing occurs at the current
+ *   position as defined by the device.
+ *
+ *   The number of bytes written may be less than count if, for example, there is
+ *   insufficient space on the underlying physical medium, or the RLIMIT_FSIZE
+ *   resource limit is encountered, or the call was interrupted by a signal
+ *   handler after having written less than count bytes. In the event of a
+ *   successful partial write, the caller should make another write() call to
+ *   transfer the remaining bytes. This behavior is called a "short write."
+ *
+ *   On Linux, write() transfers at most MAX_RW_COUNT (0x7ffff000, approximately
+ *   2GB minus one page) bytes per call, regardless of whether the file or
+ *   filesystem would allow more. This prevents signed arithmetic overflow.
+ *
+ *   For regular files, a successful write() does not guarantee that data has been
+ *   committed to disk. Use fsync(2) or fdatasync(2) if durability is required.
+ *   For O_SYNC or O_DSYNC files, the kernel automatically syncs data on write.
+ *
+ *   POSIX permits writes that are interrupted after partial writes to either
+ *   return -1 with errno=EINTR, or to return the count of bytes already written.
+ *   Linux implements the latter behavior: if some data has been written before
+ *   a signal arrives, write() returns the number of bytes written rather than
+ *   failing with EINTR.
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: fd
+ *   type: KAPI_TYPE_FD
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 0, INT_MAX
+ *   constraint: Must be a valid, open file descriptor with write permission.
+ *     The file must have been opened with O_WRONLY or O_RDWR. File descriptors
+ *     opened with O_RDONLY, O_PATH, or that have been closed return EBADF.
+ *     Standard file descriptors 0 (stdin), 1 (stdout), 2 (stderr) are valid if
+ *     open and writable. AT_FDCWD and other special values are not valid.
+ *
+ * param: buf
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Must point to a valid, readable user-space memory region of at
+ *     least count bytes. The buffer is validated via access_ok() before any
+ *     write operation. NULL is invalid and returns EFAULT. For O_DIRECT writes,
+ *     the buffer may need to be aligned to the filesystem's block size (varies
+ *     by filesystem; query with statx() using STATX_DIOALIGN on Linux 6.1+).
+ *
+ * param: count
+ *   type: KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 0, SIZE_MAX
+ *   constraint: Maximum number of bytes to write. Clamped internally to
+ *     MAX_RW_COUNT (INT_MAX & PAGE_MASK, approximately 0x7ffff000 bytes) to
+ *     prevent signed overflow. A count of 0 returns 0 immediately without any
+ *     file operations. Cast to ssize_t must not be negative.
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_RANGE
+ *   success: >= 0
+ *   desc: On success, returns the number of bytes written (non-negative). Zero
+ *     indicates that nothing was written (count was 0, or no space available
+ *     for non-blocking writes). The return value may be less than count due to
+ *     resource limits, signal interruption, or device constraints (short write).
+ *     On error, returns a negative error code.
+ *
+ * error: EBADF, Bad file descriptor
+ *   desc: fd is not a valid file descriptor, or fd was not opened for writing.
+ *     This includes file descriptors opened with O_RDONLY, O_PATH, or file
+ *     descriptors that have been closed. Also returned if the file structure
+ *     does not have FMODE_WRITE or FMODE_CAN_WRITE set.
+ *
+ * error: EFAULT, Bad address
+ *   desc: buf points outside the accessible address space. The buffer address
+ *     failed access_ok() validation. Can also occur if a fault happens during
+ *     copy_from_user() when reading data from user space.
+ *
+ * error: EINVAL, Invalid argument
+ *   desc: Returned in several cases: (1) The file descriptor refers to an
+ *     object that is not suitable for writing (no write or write_iter method).
+ *     (2) The file was opened with O_DIRECT and the buffer alignment, offset,
+ *     or count does not meet the filesystem's alignment requirements. (3) The
+ *     count argument, when cast to ssize_t, is negative. (4) For IOCB_NOWAIT
+ *     operations on non-O_DIRECT files that don't support WASYNC.
+ *
+ * error: EAGAIN, Resource temporarily unavailable
+ *   desc: fd refers to a file (pipe, socket, device) that is marked non-blocking
+ *     (O_NONBLOCK) and the write would block because the buffer is full. Also
+ *     returned with IOCB_NOWAIT when data cannot be written immediately.
+ *     Equivalent to EWOULDBLOCK. The application should retry later or use
+ *     select/poll/epoll to wait for writability.
+ *
+ * error: EINTR, Interrupted system call
+ *   desc: The call was interrupted by a signal before any data was written. This
+ *     only occurs if no data has been transferred; if some data was written
+ *     before the signal, the call returns the number of bytes written. The
+ *     caller should typically restart the write.
+ *
+ * error: EPIPE, Broken pipe
+ *   desc: fd refers to a pipe or socket whose reading end has been closed.
+ *     When this condition occurs, the calling process also receives a SIGPIPE
+ *     signal unless MSG_NOSIGNAL is used (for sockets) or IOCB_NOSIGNAL is set.
+ *     If the signal is caught or ignored, EPIPE is still returned.
+ *
+ * error: EFBIG, File too large
+ *   desc: An attempt was made to write a file that exceeds the implementation-
+ *     defined maximum file size or the file size limit (RLIMIT_FSIZE) of the
+ *     process. When RLIMIT_FSIZE is exceeded, the process also receives SIGXFSZ.
+ *     For files not opened with O_LARGEFILE on 32-bit systems, the limit is 2GB.
+ *
+ * error: ENOSPC, No space left on device
+ *   desc: The device containing the file has no room for the data. This can
+ *     occur mid-write resulting in a short write followed by ENOSPC on retry.
+ *
+ * error: EDQUOT, Disk quota exceeded
+ *   desc: The user's quota of disk blocks on the filesystem has been exhausted.
+ *     Like ENOSPC, this can result in a short write.
+ *
+ * error: EIO, Input/output error
+ *   desc: A low-level I/O error occurred while modifying the inode or writing
+ *     data. This typically indicates hardware failure, filesystem corruption,
+ *     or network filesystem timeout. Some data may have been written.
+ *
+ * error: EPERM, Operation not permitted
+ *   desc: The operation was prevented: (1) by a file seal (F_SEAL_WRITE or
+ *     F_SEAL_FUTURE_WRITE on memfd/shmem), (2) writing to an immutable inode
+ *     (IS_IMMUTABLE), (3) by an LSM hook denying the operation, or (4) by a
+ *     fanotify permission event denying the write.
+ *
+ * error: EOVERFLOW, Value too large for defined data type
+ *   desc: The file position plus count would exceed LLONG_MAX. Also returned
+ *     when the offset would exceed filesystem limits after the write.
+ *
+ * error: EDESTADDRREQ, Destination address required
+ *   desc: fd is a datagram socket for which no peer address has been set using
+ *     connect(2). Use sendto(2) to specify the destination address.
+ *
+ * error: ETXTBSY, Text file busy
+ *   desc: The file is being used as a swap file (IS_SWAPFILE).
+ *
+ * error: EXDEV, Cross-device link
+ *   desc: When writing to a pipe that has been configured as a watch queue
+ *     (CONFIG_WATCH_QUEUE), direct write() calls are not supported.
+ *
+ * error: ENOMEM, Out of memory
+ *   desc: Insufficient kernel memory was available for the write operation.
+ *     For pipes, this occurs when allocating pages for the pipe buffer.
+ *
+ * error: ERESTARTSYS, Restart system call (internal)
+ *   desc: Internal error code indicating the syscall should be restarted. This
+ *     is converted to EINTR if SA_RESTART is not set on the signal handler, or
+ *     the syscall is transparently restarted if SA_RESTART is set. User space
+ *     should not see this error code directly.
+ *
+ * error: EACCES, Permission denied
+ *   desc: The security subsystem (LSM such as SELinux or AppArmor) denied the
+ *     write operation via security_file_permission(). This can occur even if
+ *     the file was successfully opened.
+ *
+ * lock: file->f_pos_lock
+ *   type: KAPI_LOCK_MUTEX
+ *   acquired: conditional
+ *   released: true
+ *   desc: For regular files that require atomic position updates (FMODE_ATOMIC_POS),
+ *     the f_pos_lock mutex is acquired by fdget_pos() at syscall entry and released
+ *     by fdput_pos() at syscall exit. This serializes concurrent writes sharing
+ *     the same file description. Not acquired for stream files (FMODE_STREAM like
+ *     pipes and sockets) or when the file is not shared.
+ *
+ * lock: sb->s_writers (freeze protection)
+ *   type: KAPI_LOCK_CUSTOM
+ *   acquired: conditional
+ *   released: true
+ *   desc: For regular files, file_start_write() acquires freeze protection on
+ *     the superblock via sb_start_write() before the write, and file_end_write()
+ *     releases it after. This prevents writes during filesystem freeze. Not
+ *     acquired for non-regular files (pipes, sockets, devices).
+ *
+ * lock: inode->i_rwsem
+ *   type: KAPI_LOCK_RWLOCK
+ *   acquired: conditional
+ *   released: true
+ *   desc: For regular files using generic_file_write_iter(), the inode's i_rwsem
+ *     is acquired in write mode before modifying file data. This is internal to
+ *     the filesystem and released before return. Not all filesystems use this
+ *     pattern.
+ *
+ * lock: pipe->mutex
+ *   type: KAPI_LOCK_MUTEX
+ *   acquired: conditional
+ *   released: true
+ *   desc: For pipes and FIFOs, the pipe's mutex is held while modifying pipe
+ *     buffers. Released temporarily while waiting for space, then reacquired.
+ *
+ * lock: RCU read-side
+ *   type: KAPI_LOCK_RCU
+ *   acquired: conditional
+ *   released: true
+ *   desc: Used during file descriptor lookup via fdget(). RCU read lock protects
+ *     access to the file descriptor table. Released by fdput() at syscall exit.
+ *
+ * signal: SIGPIPE
+ *   direction: KAPI_SIGNAL_SEND
+ *   action: KAPI_SIGNAL_ACTION_TERMINATE
+ *   condition: Writing to a pipe or socket with no readers
+ *   desc: When writing to a pipe whose read end is closed, or a socket whose
+ *     peer has closed, SIGPIPE is sent to the calling process. The default
+ *     action terminates the process. Use signal(SIGPIPE, SIG_IGN) or set
+ *     IOCB_NOSIGNAL/MSG_NOSIGNAL to suppress. EPIPE is returned regardless.
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *
+ * signal: SIGXFSZ
+ *   direction: KAPI_SIGNAL_SEND
+ *   action: KAPI_SIGNAL_ACTION_COREDUMP
+ *   condition: Writing exceeds RLIMIT_FSIZE
+ *   desc: When a write would exceed the soft file size limit (RLIMIT_FSIZE),
+ *     SIGXFSZ is sent. The default action terminates with a core dump. The
+ *     write returns EFBIG. If RLIMIT_FSIZE is RLIM_INFINITY, no signal is sent.
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *
+ * signal: Any signal
+ *   direction: KAPI_SIGNAL_RECEIVE
+ *   action: KAPI_SIGNAL_ACTION_RETURN
+ *   condition: While blocked waiting for space (pipes, sockets)
+ *   desc: The syscall may be interrupted by signals while waiting for buffer
+ *     space to become available. If interrupted before any data is written,
+ *     returns -EINTR or -ERESTARTSYS. If data was already written, returns the
+ *     byte count. Restartable if SA_RESTART is set and no data was written.
+ *   error: -EINTR
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   restartable: yes
+ *
+ * side-effect: KAPI_EFFECT_FILE_POSITION
+ *   target: file->f_pos
+ *   condition: For seekable files when write succeeds (returns > 0)
+ *   desc: The file offset (f_pos) is advanced by the number of bytes written.
+ *     For files opened with O_APPEND, f_pos is first set to file size. For
+ *     stream files (FMODE_STREAM such as pipes and sockets), the offset is not
+ *     used or modified. Position updates are protected by f_pos_lock when
+ *     shared.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: inode timestamps (mtime, ctime)
+ *   condition: When write succeeds (returns > 0)
+ *   desc: Updates the file's modification time (mtime) and change time (ctime)
+ *     via file_update_time(). The update precision depends on filesystem mount
+ *     options (fine-grained timestamps for multigrain inodes).
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: SUID/SGID bits (mode)
+ *   condition: When writing to a setuid/setgid file
+ *   desc: The SUID bit is cleared when a non-root user writes to a file with
+ *     the bit set. The SGID bit may also be cleared. This is a security feature
+ *     to prevent privilege escalation via modified setuid binaries. Done via
+ *     file_remove_privs().
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: file data
+ *   condition: When write succeeds (returns > 0)
+ *   desc: Modifies the file's data content. For regular files, data is written
+ *     to the page cache (buffered I/O) or directly to storage (O_DIRECT).
+ *     Data may not be persistent until fsync() is called or the file is closed.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: task I/O accounting
+ *   condition: Always
+ *   desc: Updates the current task's I/O accounting statistics. The wchar field
+ *     (write characters) is incremented by bytes written via add_wchar(). The
+ *     syscw field (syscall write count) is incremented via inc_syscw(). These
+ *     statistics are visible in /proc/[pid]/io.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: fsnotify events
+ *   condition: When write returns > 0
+ *   desc: Generates an FS_MODIFY fsnotify event via fsnotify_modify(), allowing
+ *     inotify, fanotify, and dnotify watchers to be notified of the write.
+ *
+ * capability: CAP_DAC_OVERRIDE
+ *   type: KAPI_CAP_BYPASS_CHECK
+ *   allows: Bypass discretionary access control on write permission
+ *   without: Standard DAC checks are enforced
+ *   condition: Checked via security_file_permission() during rw_verify_area()
+ *
+ * capability: CAP_FOWNER
+ *   type: KAPI_CAP_BYPASS_CHECK
+ *   allows: Bypass ownership checks for SUID/SGID clearing
+ *   without: SUID/SGID bits are cleared on write by non-owner
+ *   condition: Checked during file_remove_privs()
+ *
+ * constraint: MAX_RW_COUNT
+ *   desc: The count parameter is silently clamped to MAX_RW_COUNT (INT_MAX &
+ *     PAGE_MASK, approximately 2GB minus one page) to prevent integer overflow
+ *     in internal calculations. This is transparent to the caller.
+ *   expr: actual_count = min(count, MAX_RW_COUNT)
+ *
+ * constraint: File must be open for writing
+ *   desc: The file descriptor must have been opened with O_WRONLY or O_RDWR.
+ *     Files opened with O_RDONLY or O_PATH cannot be written and return EBADF.
+ *     The file must have both FMODE_WRITE and FMODE_CAN_WRITE flags set.
+ *   expr: (file->f_mode & FMODE_WRITE) && (file->f_mode & FMODE_CAN_WRITE)
+ *
+ * constraint: RLIMIT_FSIZE
+ *   desc: The size of data written is constrained by the RLIMIT_FSIZE resource
+ *     limit. If writing would exceed this limit, SIGXFSZ is sent and EFBIG is
+ *     returned. The limit does not apply to files beyond the limit - only to
+ *     writes that would cross it.
+ *   expr: pos + count <= rlimit(RLIMIT_FSIZE) || rlimit(RLIMIT_FSIZE) == RLIM_INFINITY
+ *
+ * constraint: File seals
+ *   desc: For memfd or shmem files with F_SEAL_WRITE or F_SEAL_FUTURE_WRITE
+ *     seals applied, all write operations fail with EPERM. With F_SEAL_GROW,
+ *     writes that would extend file size fail with EPERM.
+ *
+ * examples: n = write(fd, buf, sizeof(buf));  // Basic write
+ *   n = write(STDOUT_FILENO, msg, strlen(msg));  // Write to stdout
+ *   while (total < len) { n = write(fd, buf+total, len-total); if (n<0) break; total += n; }  // Handle short writes
+ *   if (write(pipefd[1], &byte, 1) < 0 && errno == EPIPE) { handle_broken_pipe(); }  // Pipe error handling
+ *
+ * notes: The behavior of write() varies significantly depending on the type of
+ *   file descriptor:
+ *
+ *   - Regular files: Writes to the page cache (buffered) or directly to storage
+ *     (O_DIRECT). Short writes are rare except near RLIMIT_FSIZE or disk full.
+ *     O_APPEND is atomic for determining write position.
+ *
+ *   - Pipes and FIFOs: Blocking by default. Writes up to PIPE_BUF (4096 bytes
+ *     on Linux) are guaranteed atomic. Larger writes may be interleaved with
+ *     writes from other processes. Blocks if pipe is full; returns EAGAIN with
+ *     O_NONBLOCK. SIGPIPE/EPIPE if no readers.
+ *
+ *   - Sockets: Behavior depends on socket type and protocol. Stream sockets
+ *     (TCP) may return partial writes. Datagram sockets (UDP) typically write
+ *     complete messages or fail. SIGPIPE/EPIPE for broken connections (unless
+ *     MSG_NOSIGNAL). EDESTADDRREQ for unconnected datagram sockets.
+ *
+ *   - Terminals: May block on flow control. Canonical vs raw mode affects
+ *     behavior. Special characters may be interpreted.
+ *
+ *   - Device special files: Behavior is device-specific. Block devices behave
+ *     similarly to regular files. Character device behavior varies.
+ *
+ *   Race condition considerations: Concurrent writes from threads sharing a
+ *   file description race on the file position. Linux 3.14+ provides atomic
+ *   position updates via f_pos_lock for regular files (FMODE_ATOMIC_POS), but
+ *   for maximum safety, use pwrite() for concurrent positioned writes.
+ *
+ *   O_DIRECT writes bypass the page cache and typically require buffer and
+ *   offset alignment to filesystem block size. Query requirements via statx()
+ *   with STATX_DIOALIGN (Linux 6.1+). Unaligned O_DIRECT writes return EINVAL
+ *   on most filesystems.
+ *
+ *   For zero-copy writes, consider using splice(2), sendfile(2), or vmsplice(2)
+ *   instead of copying data through user-space buffers with write().
+ *
+ *   Partial writes (short writes) must be handled by application code.
+ *   Applications should loop until all data is written or an error occurs.
+ *
+ * since-version: 1.0
+ */
 SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
 		size_t, count)
 {
-- 
2.51.0


