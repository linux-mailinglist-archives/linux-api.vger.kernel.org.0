Return-Path: <linux-api+bounces-5563-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 553ECCCD9B8
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 21:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E295E305FA8D
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83B318138;
	Thu, 18 Dec 2025 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1hfNbMR"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C932F8BC3;
	Thu, 18 Dec 2025 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090577; cv=none; b=Q0l2yfI0AyfXnQx7ro0linkunAGeKs+y/CS5MEUsBGHY25/sXq/2S9Tyw1RkQkoiqWCc9K7F++XnQ9rqhFO59e7/O17B+rlDDck0UlxBgHR7FpM8RHnpfUl28HnH96LYK3nRi97q0vV84fHhdjNeqXjTemKO8kPHC1V3S8VseFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090577; c=relaxed/simple;
	bh=BM0Tp6/hpETGMj8bjOuQYX6DLQT32oEdSKx7sQoel2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzQOnAFVMfQu0Iacq/+KfrIXJgx7Hhdy+3qHpzm+Qoib7kFo25mzPmCflo7vD14bWavGvgeSq9jE0h6eZ8B3nOGf5iSuEf5yRWqCmWL6Sfpbbwi94wE6JBvlFhue35al/zL2Fs2e3tmnTBrnTmtEyXRChUq3sGQ+q/ILln3Jr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1hfNbMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797B1C19421;
	Thu, 18 Dec 2025 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090577;
	bh=BM0Tp6/hpETGMj8bjOuQYX6DLQT32oEdSKx7sQoel2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1hfNbMRRXTJ9MDb15OkxqLB90RWP/BXKiBbTCybYy8o69bnOKc5T+zJbaAE9nKQv
	 FBhmc2IY52Qtpl4yYh4jkIwL486Ushx27gjTLJeHFbGVLbXckXUGFkqOrgc0yl2w/U
	 C6w+ixpfjcg9sxW0WZnZnFfp3yslcBEZflxpZE34quuELTRDN4uxH5MB6a0fSWOSdm
	 MbqtoCIu7NL66WThH8F7NrXgpQHeYI0yMiI9KesttRAIFLoHFFFIzI1y1RsPCjc5dh
	 cECeGN+76Tu1Gz+W26ETkONUtZxdWjjuAm+te+AC6n4288ezMFQAryxhNSrWJ5MYcR
	 mZU6RqnGKFAOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 12/15] kernel/api: add API specification for sys_open
Date: Thu, 18 Dec 2025 15:42:34 -0500
Message-ID: <20251218204239.4159453-13-sashal@kernel.org>
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
 fs/open.c | 318 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 318 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index f328622061c56..343e6d3798ec3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1437,6 +1437,324 @@ int do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 }
 
 
+/**
+ * sys_open - Open or create a file
+ * @filename: Pathname of the file to open or create
+ * @flags: File access mode and behavior flags (O_RDONLY, O_WRONLY, O_RDWR, etc.)
+ * @mode: File permission bits for newly created files (only with O_CREAT/O_TMPFILE)
+ *
+ * long-desc: Opens the file specified by pathname. If O_CREAT or O_TMPFILE is
+ *   specified in flags, the file is created if it does not exist; its mode is
+ *   set according to the mode parameter modified by the process's umask.
+ *
+ *   The flags argument must include one of the following access modes: O_RDONLY
+ *   (read-only), O_WRONLY (write-only), or O_RDWR (read/write). These are the
+ *   low-order two bits of flags. In addition, zero or more file creation and
+ *   file status flags can be bitwise-ORed in flags.
+ *
+ *   File creation flags: O_CREAT, O_EXCL, O_NOCTTY, O_TRUNC, O_DIRECTORY,
+ *   O_NOFOLLOW, O_CLOEXEC, O_TMPFILE. These flags affect open behavior.
+ *
+ *   File status flags: O_APPEND, O_ASYNC, O_DIRECT, O_DSYNC, O_LARGEFILE,
+ *   O_NOATIME, O_NONBLOCK (O_NDELAY), O_PATH, O_SYNC. These become part of the
+ *   file's open file description and can be retrieved/modified with fcntl().
+ *
+ *   The return value is a file descriptor, a small nonnegative integer used in
+ *   subsequent system calls (read, write, lseek, fcntl, etc.) to refer to the
+ *   open file. The file descriptor returned by a successful open is the lowest-
+ *   numbered file descriptor not currently open for the process.
+ *
+ *   On 64-bit systems, O_LARGEFILE is automatically added to the flags. On 32-bit
+ *   systems, files larger than 2GB require O_LARGEFILE to be explicitly set.
+ *
+ *   This syscall is a legacy interface. Modern code should prefer openat() for
+ *   relative path operations and openat2() for additional control via resolve
+ *   flags. The open() call is equivalent to openat(AT_FDCWD, pathname, flags).
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: filename
+ *   type: KAPI_TYPE_PATH
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER
+ *   constraint-type: KAPI_CONSTRAINT_USER_PATH
+ *   constraint: Must be a valid null-terminated path string in user memory.
+ *     Maximum path length is PATH_MAX (4096 bytes) including null terminator.
+ *     For relative paths, resolution starts from current working directory.
+ *     The path is followed (symlinks resolved) unless O_NOFOLLOW is specified.
+ *
+ * param: flags
+ *   type: KAPI_TYPE_INT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_MASK
+ *   valid-mask: O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY |
+ *               O_TRUNC | O_APPEND | O_NONBLOCK | O_DSYNC | O_SYNC | FASYNC |
+ *               O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | O_NOATIME |
+ *               O_CLOEXEC | O_PATH | O_TMPFILE
+ *   constraint: Must include exactly one of O_RDONLY (0), O_WRONLY (1), or
+ *     O_RDWR (2) as the access mode. Additional flags may be ORed. Invalid flag
+ *     combinations (e.g., O_DIRECTORY|O_CREAT, O_PATH with incompatible flags,
+ *     O_TMPFILE without O_DIRECTORY, O_TMPFILE with read-only mode) return
+ *     EINVAL. Unknown flags are silently ignored for backward compatibility
+ *     (unlike openat2 which rejects them).
+ *
+ * param: mode
+ *   type: KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_MASK
+ *   valid-mask: S_ISUID | S_ISGID | S_ISVTX | S_IRWXU | S_IRWXG | S_IRWXO
+ *   constraint: Only meaningful when O_CREAT or O_TMPFILE is specified in
+ *     flags. Specifies the file mode bits (permissions and setuid/setgid/sticky
+ *     bits) for a newly created file. The effective mode is (mode & ~umask).
+ *     When O_CREAT/O_TMPFILE is not set, mode is ignored. Mode values exceeding
+ *     S_IALLUGO (07777) are masked off.
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_FD
+ *   success: >= 0
+ *   desc: On success, returns a new file descriptor (non-negative integer).
+ *     The returned file descriptor is the lowest-numbered descriptor not
+ *     currently open for the process. On error, returns -1 and errno is set.
+ *
+ * error: EACCES, Permission denied
+ *   desc: The requested access to the file is not allowed, or search permission
+ *     is denied for one of the directories in the path prefix of pathname, or
+ *     the file did not exist yet and write access to the parent directory is
+ *     not allowed, or O_TRUNC is specified but write permission is denied, or
+ *     the file is on a filesystem mounted with noexec and MAY_EXEC was implied.
+ *
+ * error: EBUSY, Device or resource busy
+ *   desc: O_EXCL was specified in flags and pathname refers to a block device
+ *     that is in use by the system (e.g., it is mounted).
+ *
+ * error: EDQUOT, Disk quota exceeded
+ *   desc: O_CREAT is specified and the file does not exist, and the user's quota
+ *     of disk blocks or inodes on the filesystem has been exhausted.
+ *
+ * error: EEXIST, File exists
+ *   desc: O_CREAT and O_EXCL were specified in flags, but pathname already exists.
+ *     This error is atomic with respect to file creation - it prevents race
+ *     conditions (TOCTOU) when creating files.
+ *
+ * error: EFAULT, Bad address
+ *   desc: pathname points outside the process's accessible address space.
+ *
+ * error: EINTR, Interrupted system call
+ *   desc: The call was interrupted by a signal handler before completing file
+ *     open. This can occur during lock acquisition or when breaking leases.
+ *
+ * error: EINVAL, Invalid argument
+ *   desc: Returned for several conditions: (1) Invalid O_* flag combinations
+ *     (O_DIRECTORY|O_CREAT, O_TMPFILE without O_DIRECTORY, O_TMPFILE with
+ *     read-only access, O_PATH with flags other than O_DIRECTORY|O_NOFOLLOW|
+ *     O_CLOEXEC). (2) mode contains bits outside S_IALLUGO when O_CREAT/O_TMPFILE
+ *     is set (openat2 only). (3) O_DIRECT requested but filesystem doesn't
+ *     support it. (4) The filesystem does not support O_SYNC or O_DSYNC.
+ *
+ * error: EISDIR, Is a directory
+ *   desc: pathname refers to a directory and the access requested involved
+ *     writing (O_WRONLY, O_RDWR, or O_TRUNC). Also returned when O_TMPFILE is
+ *     used on a directory that doesn't support tmpfile operations.
+ *
+ * error: ELOOP, Too many symbolic links
+ *   desc: Too many symbolic links were encountered in resolving pathname, or
+ *     O_NOFOLLOW was specified but pathname refers to a symbolic link.
+ *
+ * error: EMFILE, Too many open files
+ *   desc: The per-process limit on the number of open file descriptors has been
+ *     reached. This limit is RLIMIT_NOFILE (default typically 1024, max set by
+ *     /proc/sys/fs/nr_open).
+ *
+ * error: ENAMETOOLONG, File name too long
+ *   desc: pathname was too long, exceeding PATH_MAX (4096) bytes, or a single
+ *     path component exceeded NAME_MAX (usually 255) bytes.
+ *
+ * error: ENFILE, Too many open files in system
+ *   desc: The system-wide limit on the total number of open files has been
+ *     reached (/proc/sys/fs/file-max). Processes with CAP_SYS_ADMIN can exceed
+ *     this limit.
+ *
+ * error: ENODEV, No such device
+ *   desc: pathname refers to a special file that has no corresponding device, or
+ *     the file's inode has no file operations assigned.
+ *
+ * error: ENOENT, No such file or directory
+ *   desc: A directory component in pathname does not exist or is a dangling
+ *     symbolic link, or O_CREAT is not set and the named file does not exist,
+ *     or pathname is an empty string (unless AT_EMPTY_PATH is used with openat2).
+ *
+ * error: ENOMEM, Out of memory
+ *   desc: The kernel could not allocate sufficient memory for the file structure,
+ *     path lookup structures, or the filename buffer.
+ *
+ * error: ENOSPC, No space left on device
+ *   desc: O_CREAT was specified and the file does not exist, and the directory
+ *     or filesystem containing the file has no room for a new file entry.
+ *
+ * error: ENOTDIR, Not a directory
+ *   desc: A component used as a directory in pathname is not actually a directory,
+ *     or O_DIRECTORY was specified and pathname was not a directory.
+ *
+ * error: ENXIO, No such device or address
+ *   desc: O_NONBLOCK | O_WRONLY is set and the named file is a FIFO and no
+ *     process has the FIFO open for reading. Also returned when opening a device
+ *     special file that does not exist.
+ *
+ * error: EOPNOTSUPP, Operation not supported
+ *   desc: The filesystem containing pathname does not support O_TMPFILE.
+ *
+ * error: EOVERFLOW, Value too large for defined data type
+ *   desc: pathname refers to a regular file that is too large to be opened.
+ *     This occurs on 32-bit systems without O_LARGEFILE when the file size
+ *     exceeds 2GB (2^31 - 1 bytes).
+ *
+ * error: EPERM, Operation not permitted
+ *   desc: O_NOATIME flag was specified but the effective UID of the caller did
+ *     not match the owner of the file and the caller is not privileged, or the
+ *     file is append-only and O_TRUNC was specified or write mode without
+ *     O_APPEND, or the file is immutable, or a seal prevents the operation.
+ *
+ * error: EROFS, Read-only file system
+ *   desc: pathname refers to a file on a read-only filesystem and write access
+ *     was requested.
+ *
+ * error: ETXTBSY, Text file busy
+ *   desc: pathname refers to an executable image which is currently being
+ *     executed, or to a swap file, and write access or truncation was requested.
+ *
+ * error: EWOULDBLOCK, Resource temporarily unavailable
+ *   desc: O_NONBLOCK was specified and an incompatible lease is held on the file.
+ *
+ * lock: files->file_lock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Acquired when allocating a file descriptor slot. Held briefly during
+ *     fd allocation via alloc_fd() and released before the syscall returns.
+ *
+ * lock: inode->i_rwsem (parent directory)
+ *   type: KAPI_LOCK_RWLOCK
+ *   acquired: conditional
+ *   released: true
+ *   desc: Write lock acquired on parent directory inode when creating a new file
+ *     (O_CREAT). Acquired via inode_lock_nested() in lookup path. May use
+ *     killable variant which can return EINTR on fatal signal.
+ *
+ * lock: RCU read-side
+ *   type: KAPI_LOCK_RCU
+ *   acquired: true
+ *   released: true
+ *   desc: Path lookup uses RCU mode initially for performance. If RCU lookup
+ *     fails (returns -ECHILD), falls back to reference-based lookup.
+ *
+ * signal: Any signal
+ *   direction: KAPI_SIGNAL_RECEIVE
+ *   action: KAPI_SIGNAL_ACTION_RETURN
+ *   condition: When blocked on interruptible or killable operations
+ *   desc: The syscall may be interrupted during path lookup, lock acquisition,
+ *     or lease breaking. Fatal signals (SIGKILL, etc.) will interrupt killable
+ *     operations. Non-fatal signals may interrupt interruptible operations.
+ *   error: -EINTR
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   restartable: yes
+ *
+ * side-effect: KAPI_EFFECT_RESOURCE_CREATE | KAPI_EFFECT_ALLOC_MEMORY
+ *   target: file descriptor, file structure, dentry cache
+ *   desc: Allocates a new file descriptor in the process's fd table. Allocates
+ *     a struct file from the filp slab cache. May allocate dentries and inodes
+ *     during path lookup. System-wide file count (nr_files) is incremented.
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_FILESYSTEM
+ *   target: filesystem, inode
+ *   condition: When O_CREAT is specified and file doesn't exist
+ *   desc: Creates a new file on the filesystem. Creates new inode, allocates
+ *     data blocks as needed, and creates directory entry. Updates parent
+ *     directory mtime and ctime.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_FILESYSTEM
+ *   target: file content
+ *   condition: When O_TRUNC is specified for existing file
+ *   desc: Truncates the file to zero length, releasing data blocks. Updates
+ *     file mtime and ctime. May trigger notifications to lease holders.
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: inode timestamps
+ *   condition: Unless O_NOATIME is specified
+ *   desc: Opens for reading may update inode access time (atime) unless mounted
+ *     with noatime/relatime or O_NOATIME is specified. Opens for writing that
+ *     truncate or create update mtime and ctime.
+ *
+ * capability: CAP_DAC_OVERRIDE
+ *   type: KAPI_CAP_BYPASS_CHECK
+ *   allows: Bypass file read, write, and execute permission checks
+ *   without: Standard DAC (discretionary access control) checks are applied
+ *   condition: Checked when file permission would otherwise deny access
+ *
+ * capability: CAP_DAC_READ_SEARCH
+ *   type: KAPI_CAP_BYPASS_CHECK
+ *   allows: Bypass read permission on files and search permission on directories
+ *   without: Must have read permission on file or search permission on directory
+ *   condition: Checked during path traversal and file open
+ *
+ * capability: CAP_FOWNER
+ *   type: KAPI_CAP_BYPASS_CHECK
+ *   allows: Use O_NOATIME on files not owned by caller
+ *   without: O_NOATIME returns EPERM if caller is not file owner
+ *   condition: Checked when O_NOATIME is specified and caller is not owner
+ *
+ * capability: CAP_SYS_ADMIN
+ *   type: KAPI_CAP_INCREASE_LIMIT
+ *   allows: Exceed the system-wide file limit (file-max)
+ *   without: Returns ENFILE when system limit is reached
+ *   condition: Checked in alloc_empty_file() when nr_files >= max_files
+ *
+ * constraint: RLIMIT_NOFILE (per-process fd limit)
+ *   desc: The returned file descriptor must be less than the process's
+ *     RLIMIT_NOFILE limit. Default is typically 1024, maximum is controlled
+ *     by /proc/sys/fs/nr_open (default 1048576). Exceeding returns EMFILE.
+ *   expr: fd < rlimit(RLIMIT_NOFILE)
+ *
+ * constraint: file-max (system-wide limit)
+ *   desc: System-wide limit on open files in /proc/sys/fs/file-max. Processes
+ *     without CAP_SYS_ADMIN receive ENFILE when this limit is reached. The
+ *     limit is computed based on system memory at boot time.
+ *   expr: nr_files < files_stat.max_files || capable(CAP_SYS_ADMIN)
+ *
+ * constraint: PATH_MAX
+ *   desc: Maximum length of pathname including null terminator is PATH_MAX
+ *     (4096 bytes). Individual path components must not exceed NAME_MAX (255).
+ *
+ * examples: fd = open("/etc/passwd", O_RDONLY);  // Read existing file
+ *   fd = open("/tmp/newfile", O_WRONLY | O_CREAT | O_TRUNC, 0644);  // Create/truncate
+ *   fd = open("/tmp/lockfile", O_WRONLY | O_CREAT | O_EXCL, 0600);  // Exclusive create
+ *   fd = open("/dev/null", O_RDWR);  // Open device
+ *   fd = open("/tmp", O_RDONLY | O_DIRECTORY);  // Open directory
+ *   fd = open("/tmp", O_TMPFILE | O_RDWR, 0600);  // Anonymous temp file
+ *
+ * notes: The distinction between O_RDONLY, O_WRONLY, and O_RDWR is critical.
+ *   O_RDONLY is defined as 0, so (flags & O_RDONLY) will be true for all flags.
+ *   Test access mode using (flags & O_ACCMODE) == O_RDONLY.
+ *
+ *   When O_CREAT is specified without O_EXCL, there is a race condition between
+ *   testing for file existence and creating it. Use O_CREAT | O_EXCL for atomic
+ *   exclusive file creation.
+ *
+ *   O_CLOEXEC should be used in multithreaded programs to prevent file descriptor
+ *   leaks to child processes between fork() and execve().
+ *
+ *   O_DIRECT has alignment requirements that vary by filesystem. Use statx()
+ *   with STATX_DIOALIGN (Linux 6.1+) to query requirements. Unaligned I/O may
+ *   fail with EINVAL or fall back to buffered I/O.
+ *
+ *   O_PATH opens a file descriptor that can be used only for certain operations
+ *   (fstat, dup, fcntl, close, fchdir on directories, as dirfd for *at() calls).
+ *   I/O operations will fail with EBADF.
+ *
+ * since-version: 1.0
+ */
 SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
 {
 	if (force_o_largefile())
-- 
2.51.0


