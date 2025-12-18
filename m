Return-Path: <linux-api+bounces-5562-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D56CCD915
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 21:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C03830AF833
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8358130FC20;
	Thu, 18 Dec 2025 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti1XsvOl"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567AE2DF15C;
	Thu, 18 Dec 2025 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090576; cv=none; b=EAXcYqbd7TTTSbCD5Vo6cqQ3sHu6m65wZ3sZL4IlbUEBVYDKBZwN01WM/VH9SWcxIQ8H+GMtY4P3TdtYIKtN3ecO0M604AjXEy173Z6cgufyRpVGneKKe1RTck9HyLIS4uiLrnfg6vGPEw1Vi/5KRdw3F2Vc791dubFVJmz2Sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090576; c=relaxed/simple;
	bh=UressouWWb0CVfcr/8Lw1heICtBbKVFNZZUC5WY7CNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHV5vGNEfITPxSwJz+1KFWeMWtUITorV81tVWuVTyiOUSPdRax17iCgjKabx9rzApnyzUSyUsDxrJqvJ2miLy2RiG1q64eWDu/RYvBonAdgwWdued/7QnQAII7XbVuAE47STtnSNR++xgc0L/+gvoO2P5nYmCIDaMRUvVEdjPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti1XsvOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFCDC4CEFB;
	Thu, 18 Dec 2025 20:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090576;
	bh=UressouWWb0CVfcr/8Lw1heICtBbKVFNZZUC5WY7CNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ti1XsvOlWeDwUMnXGbMLW56pQkKeKOzYCzBZaiHxuN4MeK+7os/YgKuBOm+jHZVfP
	 b3ipD28uEzsWLzSN1qpUuE+SXqG5SU5Y/4ck80cW+uG6ZL2l3IqUM+GfXOdbaaJFY0
	 ded6pi9w7cr1FYRE9LNVVkBXaYxFYWdkcLNk8iP23JqA7h5I7MB1uy5B3NXPxJHnrA
	 QRqDysT3JjDjo8WIvaiO5Y+qcrbGYNZdw1lo1TwNvl0yL66GRYC0n2cqimDV5k7uTC
	 8zQO54JwFjOzUrGrfOi0pvouPlitVCwW3lWJnY8VDClQNUTFLcsBRX5PFShpjq6ScX
	 sXQ0f6xJKY77w==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 11/15] kernel/api: add API specification for fsetxattr
Date: Thu, 18 Dec 2025 15:42:33 -0500
Message-ID: <20251218204239.4159453-12-sashal@kernel.org>
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
 fs/xattr.c | 322 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 322 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 466dcaf7ba83e..8a27c11905f7e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1392,6 +1392,328 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 			       value, size, flags);
 }
 
+/**
+ * sys_fsetxattr - Set an extended attribute value on an open file descriptor
+ * @fd: File descriptor of the file on which to set the extended attribute
+ * @name: Null-terminated name of the extended attribute (includes namespace prefix)
+ * @value: Buffer containing the attribute value to set
+ * @size: Size of the value buffer in bytes
+ * @flags: Flags controlling attribute creation/replacement behavior
+ *
+ * long-desc: Sets the value of an extended attribute identified by name on
+ *   the file referred to by the open file descriptor fd. Extended attributes
+ *   are name:value pairs associated with inodes (files, directories, symbolic
+ *   links, etc.) that extend the normal attributes (stat data) associated with
+ *   all inodes.
+ *
+ *   This syscall is similar to setxattr() but operates on an already-open file
+ *   descriptor rather than a pathname. This is useful when the file is already
+ *   open, when the caller wants to avoid race conditions between opening and
+ *   setting attributes, or when operating on file descriptors that cannot be
+ *   easily reopened.
+ *
+ *   The attribute name must include a namespace prefix. Valid namespaces are:
+ *   - "user." - User-defined attributes (regular files and directories only)
+ *   - "trusted." - Trusted attributes (requires CAP_SYS_ADMIN)
+ *   - "security." - Security module attributes (e.g., SELinux, Smack, capabilities)
+ *   - "system." - System attributes (e.g., POSIX ACLs via system.posix_acl_access)
+ *
+ *   The value can be arbitrary binary data or text. A zero-length value is
+ *   permitted and creates an attribute with an empty value (different from
+ *   removing the attribute).
+ *
+ *   The file descriptor must have been opened for writing to modify extended
+ *   attributes. The file descriptor cannot be an O_PATH file descriptor.
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: fd
+ *   type: KAPI_TYPE_FD
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Must be a valid file descriptor returned by open(), creat(),
+ *     or similar syscalls. The file descriptor cannot be an O_PATH file
+ *     descriptor. The file must be on a filesystem that is not mounted
+ *     read-only. AT_FDCWD (-100) is NOT valid for this syscall as it operates
+ *     on file descriptors, not directory handles.
+ *
+ * param: name
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER
+ *   constraint-type: KAPI_CONSTRAINT_USER_STRING
+ *   range: 1, 255
+ *   constraint: Must be a valid null-terminated string in user memory containing
+ *     the extended attribute name with namespace prefix (e.g., "user.myattr").
+ *     The name (including prefix) must be between 1 and XATTR_NAME_MAX (255)
+ *     characters. An empty name returns ERANGE.
+ *
+ * param: value
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER | KAPI_PARAM_OPTIONAL
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Must be a valid pointer to user memory containing the attribute
+ *     value, or NULL if size is 0. When size is non-zero, the pointer must be
+ *     valid and accessible for size bytes.
+ *
+ * param: size
+ *   type: KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 0, 65536
+ *   constraint: Size of the value in bytes. Must not exceed XATTR_SIZE_MAX
+ *     (65536 bytes). Zero is permitted and creates an attribute with empty value.
+ *     Filesystem-specific limits may be smaller (e.g., ext4 limits total xattr
+ *     space to one filesystem block, typically 4KB).
+ *
+ * param: flags
+ *   type: KAPI_TYPE_INT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_MASK
+ *   valid-mask: XATTR_CREATE | XATTR_REPLACE
+ *   constraint: Controls creation/replacement behavior. Valid values are 0,
+ *     XATTR_CREATE (0x1), or XATTR_REPLACE (0x2). XATTR_CREATE fails if the
+ *     attribute already exists. XATTR_REPLACE fails if the attribute does not
+ *     exist. With flags=0, the attribute is created if it doesn't exist or
+ *     replaced if it does. XATTR_CREATE and XATTR_REPLACE are mutually exclusive.
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_ERROR_CHECK
+ *   success: 0
+ *   desc: Returns 0 on success. The extended attribute is set with the specified
+ *     value. Any previous value for the attribute is replaced.
+ *
+ * error: EBADF, Bad file descriptor
+ *   desc: The file descriptor fd is not valid or is not open for writing. This
+ *     is returned from the fd class lookup when the file descriptor does not
+ *     refer to an open file.
+ *
+ * error: EPERM, Operation not permitted
+ *   desc: Returned when: (1) file is immutable or append-only, (2) trusted.*
+ *     without CAP_SYS_ADMIN, (3) security.* (except capability) without
+ *     CAP_SYS_ADMIN, (4) user.* on sticky dir without ownership/CAP_FOWNER,
+ *     (5) unmapped ID in idmapped mount, (6) user.* on non-regular/non-dir.
+ *
+ * error: ENODATA, Attribute not found
+ *   desc: XATTR_REPLACE was specified but the named attribute does not exist on
+ *     the file. Also returned when reading trusted.* without CAP_SYS_ADMIN.
+ *
+ * error: EEXIST, Attribute already exists
+ *   desc: XATTR_CREATE was specified but the named attribute already exists on
+ *     the file.
+ *
+ * error: ERANGE, Name out of range
+ *   desc: The attribute name is empty (zero length) or exceeds XATTR_NAME_MAX
+ *     (255 characters). Returned from import_xattr_name() via strncpy_from_user().
+ *
+ * error: E2BIG, Value too large
+ *   desc: The size parameter exceeds XATTR_SIZE_MAX (65536 bytes). Returned from
+ *     setxattr_copy() before attempting to copy the value from userspace.
+ *
+ * error: EINVAL, Invalid argument
+ *   desc: The flags parameter contains bits other than XATTR_CREATE and
+ *     XATTR_REPLACE. Also returned for malformed capability values when setting
+ *     security.capability (invalid header format, invalid rootid mapping), or
+ *     when the xattr name doesn't match any handler prefix.
+ *
+ * error: EFAULT, Bad address
+ *   desc: One of the user pointers (name or value) is invalid or points to
+ *     memory that cannot be accessed. Returned from strncpy_from_user() for
+ *     name or vmemdup_user()/copy_from_user() for value.
+ *
+ * error: ENOMEM, Out of memory
+ *   desc: Kernel could not allocate memory to copy the attribute value from
+ *     userspace (via vmemdup_user), or for namespace capability conversion
+ *     (cap_convert_nscap allocates memory for v3 capability format).
+ *
+ * error: EOPNOTSUPP, Operation not supported
+ *   desc: The filesystem does not support extended attributes (IOP_XATTR not set),
+ *     or no xattr handler exists for the given namespace prefix, or the handler
+ *     does not implement the set operation. Also returned for POSIX ACL xattrs
+ *     (system.posix_acl_*) when CONFIG_FS_POSIX_ACL is disabled.
+ *
+ * error: EROFS, Read-only filesystem
+ *   desc: The filesystem containing the file is mounted read-only. Returned from
+ *     mnt_want_write_file() before attempting any modification.
+ *
+ * error: EIO, I/O error
+ *   desc: The inode is marked as bad (is_bad_inode), indicating filesystem
+ *     corruption or I/O failure. Also may be returned by filesystem-specific
+ *     xattr handler operations.
+ *
+ * error: EDQUOT, Disk quota exceeded
+ *   desc: The user's disk quota for extended attributes has been exceeded.
+ *     Filesystem-specific error returned from the handler's set operation.
+ *
+ * error: ENOSPC, No space left on device
+ *   desc: The filesystem has insufficient space to store the extended attribute.
+ *     Filesystem-specific error from handler's set operation.
+ *
+ * error: EACCES, Permission denied
+ *   desc: Write access to the file is denied based on DAC permissions. The caller
+ *     does not have appropriate permission to modify xattrs on this file.
+ *
+ * lock: inode->i_rwsem
+ *   type: KAPI_LOCK_MUTEX
+ *   acquired: true
+ *   released: true
+ *   desc: The inode's read-write semaphore is acquired exclusively via inode_lock()
+ *     before calling __vfs_setxattr_locked() and released via inode_unlock() after.
+ *     This serializes concurrent xattr modifications on the same inode.
+ *
+ * lock: sb->s_writers (superblock freeze protection)
+ *   type: KAPI_LOCK_SEMAPHORE
+ *   acquired: true
+ *   released: true
+ *   desc: Write access to the mount is acquired via mnt_want_write_file() which
+ *     calls sb_start_write(). This prevents filesystem freeze during the operation.
+ *     Released via mnt_drop_write_file() after the operation completes.
+ *
+ * lock: file_rwsem (delegation breaking)
+ *   type: KAPI_LOCK_SEMAPHORE
+ *   acquired: true
+ *   released: true
+ *   desc: If the file has NFSv4 delegations, the percpu file_rwsem is acquired
+ *     during delegation breaking in __break_lease(). The syscall may wait for
+ *     delegation holders to acknowledge the break.
+ *
+ * signal: Any
+ *   direction: KAPI_SIGNAL_RECEIVE
+ *   action: KAPI_SIGNAL_ACTION_RESTART
+ *   condition: Signal arrives during interruptible wait for delegation breaking
+ *   desc: The syscall may wait for NFSv4 delegation holders to release their
+ *     delegations via wait_event_interruptible_timeout() in __break_lease().
+ *     During this wait, signals can interrupt the operation. If a signal is
+ *     pending, the wait is interrupted and the operation may be retried by
+ *     the kernel automatically if the signal disposition allows (SA_RESTART).
+ *   error: -ERESTARTSYS
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   restartable: yes
+ *
+ * side-effect: KAPI_EFFECT_ALLOC_MEMORY
+ *   target: Kernel buffer for attribute value
+ *   desc: The attribute value is copied from userspace to a kernel buffer
+ *     allocated via vmemdup_user(). This memory is freed (kvfree) after the
+ *     operation completes, regardless of success or failure.
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_FILESYSTEM
+ *   target: File's extended attributes
+ *   desc: On success, the specified extended attribute is created or modified.
+ *     The change is typically persisted to storage synchronously or asynchronously
+ *     depending on filesystem and mount options.
+ *   reversible: yes
+ *   condition: Operation succeeds
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: Inode flags (S_NOSEC)
+ *   desc: When setting security.* attributes, the S_NOSEC flag is cleared from
+ *     the inode. This flag is an optimization that indicates no security xattrs
+ *     exist; clearing it ensures proper security checks on subsequent accesses.
+ *   condition: Setting security.* namespace attribute
+ *   reversible: no
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: fsnotify event
+ *   desc: On success, fsnotify_xattr() is called to notify any registered
+ *     watchers (inotify, fanotify) of the extended attribute modification.
+ *     This generates an IN_ATTRIB event.
+ *   condition: Operation succeeds
+ *
+ * state-trans: extended attribute
+ *   from: nonexistent or has old value
+ *   to: has new value
+ *   condition: Operation succeeds with flags=0 or appropriate flags
+ *   desc: The extended attribute transitions from not existing (or having its
+ *     previous value) to containing the new value. With XATTR_CREATE, the
+ *     attribute must not exist beforehand. With XATTR_REPLACE, it must exist.
+ *
+ * capability: CAP_SYS_ADMIN
+ *   type: KAPI_CAP_GRANT_PERMISSION
+ *   allows: Setting trusted.* namespace attributes and most security.* attributes
+ *   without: Setting trusted.* returns EPERM. Setting security.* (except
+ *     security.capability) returns EPERM. The check uses ns_capable() against
+ *     the filesystem's user namespace.
+ *   condition: Attribute name starts with "trusted." or "security." (except
+ *     security.capability)
+ *
+ * capability: CAP_SETFCAP
+ *   type: KAPI_CAP_GRANT_PERMISSION
+ *   allows: Setting the security.capability extended attribute
+ *   without: Setting security.capability returns EPERM
+ *   condition: Attribute name is "security.capability". Checked via
+ *     capable_wrt_inode_uidgid() which considers the inode's ownership.
+ *
+ * capability: CAP_FOWNER
+ *   type: KAPI_CAP_BYPASS_CHECK
+ *   allows: Bypassing owner check for user.* on sticky directories
+ *   without: Non-owners cannot set user.* attributes on files in sticky
+ *     directories without this capability
+ *   condition: Setting user.* namespace attribute on a file in a sticky directory
+ *
+ * constraint: Filesystem support
+ *   desc: The filesystem must support extended attributes (have IOP_XATTR flag
+ *     set and provide xattr handlers). Common filesystems supporting xattrs
+ *     include ext4, XFS, Btrfs, and tmpfs. Some filesystems (e.g., FAT, older
+ *     ext2) do not support extended attributes.
+ *
+ * constraint: Filesystem-specific size limits
+ *   desc: While the VFS limit is 64KB (XATTR_SIZE_MAX), filesystems may impose
+ *     smaller limits. For example, ext4 limits all xattrs on an inode to fit
+ *     in a single filesystem block (typically 4KB). XFS and ReiserFS support
+ *     the full 64KB. Exceeding filesystem limits returns ENOSPC or E2BIG.
+ *
+ * constraint: user.* namespace restrictions
+ *   desc: The user.* namespace is only supported on regular files and directories.
+ *     Attempting to set user.* attributes on other file types (symlinks, devices,
+ *     sockets, FIFOs) returns EPERM (for write) or ENODATA (for read).
+ *
+ * constraint: LSM checks
+ *   desc: Linux Security Modules (SELinux, Smack, AppArmor) may impose additional
+ *     restrictions via security_inode_setxattr() hook. These can return various
+ *     error codes depending on the security policy. The LSM is called after
+ *     permission checks but before the actual xattr modification.
+ *
+ * constraint: File descriptor must not be O_PATH
+ *   desc: The file descriptor must be a regular file descriptor, not one opened
+ *     with O_PATH. O_PATH file descriptors do not provide access to the file
+ *     contents or metadata modification operations.
+ *
+ * examples: fsetxattr(fd, "user.comment", "test", 4, 0);  // Set user attr
+ *   fsetxattr(fd, "user.new", "val", 3, XATTR_CREATE);  // Create only, fail if exists
+ *   fsetxattr(fd, "user.existing", "new", 3, XATTR_REPLACE);  // Replace only
+ *   fsetxattr(fd, "user.empty", "", 0, 0);  // Create attribute with empty value
+ *
+ * notes: Extended attributes provide a way to associate arbitrary metadata with
+ *   files beyond the standard stat attributes. They are commonly used for:
+ *   - SELinux security contexts (security.selinux)
+ *   - File capabilities (security.capability)
+ *   - POSIX ACLs (system.posix_acl_access, system.posix_acl_default)
+ *   - User-defined metadata (user.* namespace)
+ *
+ *   Using fsetxattr() with an already-open file descriptor avoids potential
+ *   TOCTOU (time-of-check-time-of-use) race conditions that can occur when
+ *   using setxattr() with a pathname, where the file might be replaced between
+ *   opening and setting the attribute.
+ *
+ *   The trusted.* namespace is designed for use by privileged processes to store
+ *   data that should not be accessible to unprivileged users (e.g., during
+ *   backup/restore operations).
+ *
+ *   NFSv4 delegation support means this syscall may need to wait for remote
+ *   clients to release their delegations before the operation can complete.
+ *   This can introduce unbounded delays in pathological cases.
+ *
+ *   For security.capability specifically, the kernel may convert between v2
+ *   (non-namespaced) and v3 (namespaced) capability formats depending on the
+ *   filesystem's user namespace and caller's capabilities.
+ *
+ *   Unlike setxattr() and lsetxattr(), fsetxattr() does not involve path
+ *   resolution, so errors related to path traversal (ENOENT, ENOTDIR,
+ *   ENAMETOOLONG, ELOOP, ESTALE) are not possible.
+ *
+ * since-version: 2.4
+ */
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
-- 
2.51.0


