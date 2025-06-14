Return-Path: <linux-api+bounces-3914-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9226AD9D1B
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A4B3B82A8
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F000E2E6D37;
	Sat, 14 Jun 2025 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FukOVZmc"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28952E6D2F;
	Sat, 14 Jun 2025 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908949; cv=none; b=inWSN7tqEuWIT07oBrkku9Y4EEtEI4EcZTZAq4m+6bql+DaVsQiEs2mtYiLn0GgM5AK6cQJWxvA7UtIwWBvABkJdT7UCPpSC9wi+6ORIwkottBfwrKcBj32kWvzA9Vz4auM1hCCHcflv4jcUAXuflG1EKwNprGyH8NL8rGiawdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908949; c=relaxed/simple;
	bh=HR3jSxpUUdGXQ0QKpM97JMgGl4QSqTNmyU2iIOv1VtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5GH5umDD3iVXnsfAtbl2vawWla7lUWCO7iWuERGc4fgUABFIsn8Y69E3RpnqgGuP8RfApyj+AREWx8W3SyuA3sE/M5mmzc7Bivxg/feYrGC11jn1nOwI8Ws6bnme58klNKEihcg0j4c3/3PY7yemY6dvHGzWaJb4RF+ENnx0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FukOVZmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5050C4CEEE;
	Sat, 14 Jun 2025 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908949;
	bh=HR3jSxpUUdGXQ0QKpM97JMgGl4QSqTNmyU2iIOv1VtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FukOVZmcFAf0VQiVgCCp3/r9fELg0NqZSl5ITpxOcef9+t5SgAw2D4aMc62zpknis
	 /MbKLDiH6qyc+ATgMSPoA6H4RYz1pUgxTHAZ2Mcv1wxwGYM6z12NCS3PYUfhLQ9sZ5
	 JjCV1aZNDO0W+YIsdGkmjM8+uwM8Vuk0ZZsLmbL+C3PMTtyuECInDoAL8SVbyMJxUC
	 hbTwDrWJQxeAfp3isnrC6FVngWRM2uOMwIBP++f5kVYVIYKhZfproNjPBInVwbgsfi
	 w6HEzXaZob4/jknyC+/2DmRcoipwwsZZ6ASQS5xu4GyQNhdSIoHF3XOjvRGrOs2g4L
	 wmZy/kFgA31cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 09/19] exec: add API specification for execveat
Date: Sat, 14 Jun 2025 09:48:48 -0400
Message-Id: <20250614134858.790460-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614134858.790460-1-sashal@kernel.org>
References: <20250614134858.790460-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive kernel API specification for the execveat() system
call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 245 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 3d006105ab23d..49d8647c053ef 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2223,6 +2223,251 @@ SYSCALL_DEFINE3(execve,
 	return do_execve(getname(filename), argv, envp);
 }
 
+
+/* Valid flag combinations for execveat */
+static const s64 execveat_valid_flags[] = {
+	0,
+	AT_EMPTY_PATH,
+	AT_SYMLINK_NOFOLLOW,
+	AT_EXECVE_CHECK,
+	AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW,
+	AT_EMPTY_PATH | AT_EXECVE_CHECK,
+	AT_SYMLINK_NOFOLLOW | AT_EXECVE_CHECK,
+	AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW | AT_EXECVE_CHECK,
+};
+
+DEFINE_KERNEL_API_SPEC(sys_execveat)
+	KAPI_DESCRIPTION("Execute a new program relative to a directory file descriptor")
+	KAPI_LONG_DESC("Executes the program referred to by the combination of fd and filename. "
+		       "This system call is useful when implementing a secure execution environment "
+		       "or when the calling process has an open file descriptor but no access to "
+		       "the corresponding pathname. Like execve(), it replaces the current process "
+		       "image with a new process image.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	KAPI_PARAM(0, "fd", "int", "Directory file descriptor")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_FD,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "AT_FDCWD for current directory, or valid directory file descriptor",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "filename", "const char __user *", "Pathname of the program to execute")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER | KAPI_PARAM_OPTIONAL)
+		.type = KAPI_TYPE_PATH,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "Relative or absolute path; empty string with AT_EMPTY_PATH to use fd directly",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "argv", "const char __user *const __user *", "Array of argument strings passed to the new program")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER)
+		.type = KAPI_TYPE_USER_PTR,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "NULL-terminated array of pointers to null-terminated strings",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(3, "envp", "const char __user *const __user *", "Array of environment strings for the new program")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER)
+		.type = KAPI_TYPE_USER_PTR,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "NULL-terminated array of pointers to null-terminated strings in form key=value",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(4, "flags", "int", "Execution flags")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_INT,
+		.constraint_type = KAPI_CONSTRAINT_MASK,
+		.valid_mask = AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW | AT_EXECVE_CHECK,
+		.constraints = "0 or combination of AT_EMPTY_PATH, AT_SYMLINK_NOFOLLOW, and AT_EXECVE_CHECK",
+	KAPI_PARAM_END
+
+	/* Return specification */
+	KAPI_RETURN("long", "Does not return on success (except with AT_EXECVE_CHECK which returns 0); returns -1 on error")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+	KAPI_RETURN_END
+
+	/* Error codes */
+	KAPI_ERROR(0, -E2BIG, "E2BIG", "Argument list too long", "The total size of argv and envp exceeds the system limit.")
+	KAPI_ERROR(1, -EACCES, "EACCES", "Permission denied", "Search permission denied on a component of the path, file is not regular, or execute permission denied for file or interpreter.")
+	KAPI_ERROR(2, -EBADF, "EBADF", "Bad file descriptor", "fd is not a valid file descriptor.")
+	KAPI_ERROR(3, -EFAULT, "EFAULT", "Bad address", "filename, argv, or envp points outside accessible address space.")
+	KAPI_ERROR(4, -EINVAL, "EINVAL", "Invalid flags or executable format", "Invalid flags specified, or ELF executable has more than one PT_INTERP segment.")
+	KAPI_ERROR(5, -EIO, "EIO", "I/O error", "An I/O error occurred while reading from the file system.")
+	KAPI_ERROR(6, -EISDIR, "EISDIR", "Is a directory", "An ELF interpreter was a directory.")
+	KAPI_ERROR(7, -ELIBBAD, "ELIBBAD", "Invalid ELF interpreter", "An ELF interpreter was not in a recognized format.")
+	KAPI_ERROR(8, -ELOOP, "ELOOP", "Too many symbolic links", "Too many symbolic links encountered, or AT_SYMLINK_NOFOLLOW was specified but filename refers to a symbolic link.")
+	KAPI_ERROR(9, -EMFILE, "EMFILE", "Too many open files", "The per-process limit on open file descriptors has been reached.")
+	KAPI_ERROR(10, -ENAMETOOLONG, "ENAMETOOLONG", "Filename too long", "filename or one of the strings in argv or envp is too long.")
+	KAPI_ERROR(11, -ENFILE, "ENFILE", "System file table overflow", "The system-wide limit on open files has been reached.")
+	KAPI_ERROR(12, -ENOENT, "ENOENT", "File not found", "The file filename or an interpreter does not exist, or filename is empty and AT_EMPTY_PATH was not specified in flags.")
+	KAPI_ERROR(13, -ENOEXEC, "ENOEXEC", "Exec format error", "An executable is not in a recognized format, is for wrong architecture, or has other format errors preventing execution.")
+	KAPI_ERROR(14, -ENOMEM, "ENOMEM", "Out of memory", "Insufficient kernel memory available.")
+	KAPI_ERROR(15, -ENOTDIR, "ENOTDIR", "Not a directory", "A component of the path prefix is not a directory, or fd is not a directory when a relative path is given.")
+	KAPI_ERROR(16, -EPERM, "EPERM", "Operation not permitted", "The filesystem is mounted nosuid, the user is not root, and the file has set-user-ID or set-group-ID bit set.")
+	KAPI_ERROR(17, -ETXTBSY, "ETXTBSY", "Text file busy", "The executable was open for writing by one or more processes.")
+	KAPI_ERROR(18, -EAGAIN, "EAGAIN", "Resource temporarily unavailable", "RLIMIT_NPROC limit exceeded - too many processes for this user.")
+	KAPI_ERROR(19, -EINTR, "EINTR", "Interrupted by signal", "The exec was interrupted by a signal during setup phase.")
+
+	/* Signal specifications */
+	KAPI_SIGNAL(0, 0, "FATAL_SIGNALS", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_CONDITION("Fatal signal pending during exec setup")
+		KAPI_SIGNAL_DESC("Fatal signals (checked via fatal_signal_pending()) can interrupt exec during setup phases like de_thread(). This causes exec to fail and the process to exit.")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(1, SIGKILL, "SIGKILL", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_TARGET("All other threads in the thread group")
+		KAPI_SIGNAL_CONDITION("Multi-threaded process doing exec")
+		KAPI_SIGNAL_DESC("During de_thread(), zap_other_threads() sends SIGKILL to all other threads in the thread group to ensure only the execing thread survives.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(2, 0, "ALL_HANDLERS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Signal has a handler installed")
+		KAPI_SIGNAL_DESC("flush_signal_handlers() resets all signal handlers to SIG_DFL except for signals that are ignored (SIG_IGN). This happens after de_thread() completes.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(3, 0, "IGNORED_SIGNALS", KAPI_SIGNAL_IGNORE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Signal disposition is SIG_IGN")
+		KAPI_SIGNAL_DESC("Signals set to SIG_IGN are preserved across exec. This is POSIX-compliant behavior allowing parent processes to ignore signals in children.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(4, 0, "PENDING_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Any pending signals")
+		KAPI_SIGNAL_DESC("All pending signals are cleared during exec. This includes both thread-specific and process-wide pending signals.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(5, 0, "TIMER_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Timer-generated signals pending")
+		KAPI_SIGNAL_DESC("flush_itimer_signals() clears any pending timer signals (SIGALRM, SIGVTALRM, SIGPROF) to prevent confusion in the new program.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(6, SIGCHLD, "SIGCHLD", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_TARGET("Parent process when this process exits")
+		KAPI_SIGNAL_CONDITION("Process exit after exec")
+		KAPI_SIGNAL_DESC("The exit_signal is set to SIGCHLD during exec, ensuring the parent will receive SIGCHLD when this process terminates.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(7, 0, "SIGALTSTACK", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Process had alternate signal stack")
+		KAPI_SIGNAL_DESC("Any alternate signal stack (sigaltstack) is not preserved across exec. The new program starts with no alternate stack.")
+	KAPI_SIGNAL_END
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_PROCESS_STATE | KAPI_EFFECT_FREE_MEMORY | KAPI_EFFECT_ALLOC_MEMORY,
+			 "process image",
+			 "Replaces entire process image including code, data, heap, and stack")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_RESOURCE_DESTROY,
+			 "file descriptors",
+			 "Closes all file descriptors with close-on-exec flag set")
+		KAPI_EFFECT_CONDITION("FD_CLOEXEC flag set")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_MODIFY_STATE,
+			 "signal handlers",
+			 "Resets all signal handlers to default, preserves ignored signals")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(3, KAPI_EFFECT_PROCESS_STATE | KAPI_EFFECT_SIGNAL_SEND,
+			 "thread group",
+			 "Kills all other threads in the thread group with SIGKILL")
+		KAPI_EFFECT_CONDITION("Multi-threaded process")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(4, KAPI_EFFECT_MODIFY_STATE,
+			 "process attributes",
+			 "Clears pending signals, timers, alternate signal stack, and various process attributes")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(5, KAPI_EFFECT_FILESYSTEM,
+			 "executable file",
+			 "Opens and reads the executable file, may trigger filesystem operations")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(6, KAPI_EFFECT_MODIFY_STATE,
+			 "security context",
+			 "May change SELinux/AppArmor context based on file labels and transitions")
+		KAPI_EFFECT_CONDITION("LSM enabled")
+	KAPI_SIDE_EFFECT_END
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "process memory",
+			 "old program image", "new program image",
+			 "Complete replacement of process address space with new program")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "process credentials",
+			 "current credentials", "potentially modified credentials",
+			 "May change effective UID/GID based on file permissions")
+		KAPI_STATE_TRANS_COND("setuid/setgid binary")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "thread state",
+			 "multi-threaded", "single-threaded",
+			 "Process becomes single-threaded after killing other threads")
+		KAPI_STATE_TRANS_COND("Multi-threaded process")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(3, "signal state",
+			 "custom handlers and pending signals", "default handlers, no pending signals",
+			 "Signal handling reset to clean state for new program")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(4, "file descriptor table",
+			 "contains close-on-exec FDs", "close-on-exec FDs closed",
+			 "All file descriptors marked FD_CLOEXEC are closed during exec")
+		KAPI_STATE_TRANS_COND("FDs with FD_CLOEXEC")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(5, "working directory",
+			 "fd-relative operations", "resolved to absolute paths",
+			 "Directory fd operations resolved before exec completes")
+		KAPI_STATE_TRANS_COND("Using dirfd != AT_FDCWD")
+	KAPI_STATE_TRANS_END
+
+	/* Locking information */
+	KAPI_LOCK(0, "cred_guard_mutex", KAPI_LOCK_MUTEX)
+		KAPI_LOCK_DESC("Protects against concurrent credential changes during exec")
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_DESC("Ensures atomic credential transition during exec process")
+	KAPI_LOCK_END
+
+	KAPI_LOCK(1, "sighand->siglock", KAPI_LOCK_SPINLOCK)
+		KAPI_LOCK_DESC("Protects signal handler modifications")
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Taken during signal handler reset and pending signal clearing")
+	KAPI_LOCK_END
+
+	KAPI_SIDE_EFFECT_COUNT(7)
+	KAPI_STATE_TRANS_COUNT(6)
+
+	.error_count = 20,
+	.param_count = 5,
+	.since_version = "3.19",
+	.examples = "/* Execute /bin/echo using AT_FDCWD */\n"
+		    "char *argv[] = { \"echo\", \"hello\", NULL };\n"
+		    "char *envp[] = { \"PATH=/bin\", NULL };\n"
+		    "execveat(AT_FDCWD, \"/bin/echo\", argv, envp, 0);\n\n"
+		    "/* Execute via file descriptor */\n"
+		    "int fd = open(\"/bin/echo\", O_PATH);\n"
+		    "execveat(fd, \"\", argv, envp, AT_EMPTY_PATH);\n\n"
+		    "/* Execute relative to directory fd */\n"
+		    "int dirfd = open(\"/bin\", O_RDONLY | O_DIRECTORY);\n"
+		    "execveat(dirfd, \"echo\", argv, envp, 0);",
+	.notes = "execveat() was added to allow fexecve() to be implemented on systems that "
+		 "do not have /proc mounted. When filename is an empty string and AT_EMPTY_PATH "
+		 "is specified, the file descriptor fd specifies the file to be executed. "
+		 "AT_SYMLINK_NOFOLLOW prevents following symbolic links. "
+		 "AT_EXECVE_CHECK (since Linux 6.12) only checks if execution would be allowed "
+		 "without actually executing. Like execve(), on success execveat() does not return "
+		 "(except with AT_EXECVE_CHECK which returns 0).",
+	.signal_count = 8,
+	.lock_count = 2,
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE5(execveat,
 		int, fd, const char __user *, filename,
 		const char __user *const __user *, argv,
-- 
2.39.5


