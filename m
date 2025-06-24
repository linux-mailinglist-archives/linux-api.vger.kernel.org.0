Return-Path: <linux-api+bounces-3971-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90326AE6E2A
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEAC189AD95
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570622EAD0C;
	Tue, 24 Jun 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gajpN+Lu"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4C2EACEB;
	Tue, 24 Jun 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788473; cv=none; b=VEsxFioiAQubAVavPGwoN+SO5ehrL1Hf5wDoqJ/ILDzMxtwzqzJaxurlfI5cN4/E7C5ewro7hOknRuWlVxe15CUA0vaDxpyK+mSzbfv8xUfOO1qmdmaR6ubdh9jgON1SQJkgC4Tt/K+QQ8vQ8sfjNcK9L01+hH6BCQPNY+56ENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788473; c=relaxed/simple;
	bh=4ncdpXSO1AcorBFghjh4VdlegUm8B8gFpzFE2L5+6uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUgsLcaqfp7QpPmfKPXmfir5uxxgBEc2JBEOAy29xOMhFcwbb3NHGI8rvlM61/p6c0866pm0ffY3jme/DpHaSM3ilQpKFvMlWP++9K4CKuCZEtt0NCuXGys4Yvupqe7DkfmZTmFnRoE9wh2sl1QPIzIPwsjoo3nzojpdWjpdhOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gajpN+Lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D00C4CEF4;
	Tue, 24 Jun 2025 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788472;
	bh=4ncdpXSO1AcorBFghjh4VdlegUm8B8gFpzFE2L5+6uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gajpN+LuSjZRo0h+9xASTgvhhTtmmjBz6ZmJlpH5lSJRXlpu66qHk6EKUgIjLNRaN
	 7iwBebip/tW37TgS4bZVKWQre1H/NwCbbXHUbRf8wg8ViwYfZ861OkMeB/5P5MU6rA
	 0XTGIRTBq4DkiejqdS5qS1rpI87waYWE6Ie08bXhfYGSB6txiXUONEekLo/hNbNyaK
	 k6CTn5cX8ynuOJC9Du0O4urkIGO9r2dnu7OD0EI74sjk2ReatbRQI/MnSa1KTucN7x
	 044jcES/ejVW/1avpA9cSAo5iZbT5PZlyrxRrEkZsF/xPZ9x7PRtrAXM8xR8XdQT7B
	 TI5PfnLqPA3dQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 09/22] exec: add API specification for execveat
Date: Tue, 24 Jun 2025 14:07:29 -0400
Message-Id: <20250624180742.5795-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624180742.5795-1-sashal@kernel.org>
References: <20250624180742.5795-1-sashal@kernel.org>
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
 fs/exec.c | 342 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 340 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fd0c88f7be33b..078781d4510f0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2029,8 +2029,8 @@ DEFINE_KERNEL_API_SPEC(sys_execve)
 	KAPI_PARAM_END
 
 	KAPI_RETURN("long", "Does not return on success; negative error code on error")
-		.type = KAPI_TYPE_INT,
-		.check_type = KAPI_RETURN_ERROR_CHECK,
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
 	KAPI_RETURN_END
 
 	KAPI_ERROR(0, -E2BIG, "E2BIG", "Argument list too long",
@@ -2369,6 +2369,344 @@ SYSCALL_DEFINE3(execve,
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
+		KAPI_PARAM_TYPE(KAPI_TYPE_FD)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("AT_FDCWD for current directory, or valid directory file descriptor")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "filename", "const char __user *", "Pathname of the program to execute")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER | KAPI_PARAM_OPTIONAL)
+		KAPI_PARAM_TYPE(KAPI_TYPE_PATH)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("Relative or absolute path; empty string with AT_EMPTY_PATH to use fd directly")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "argv", "const char __user *const __user *", "Array of argument strings passed to the new program")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER)
+		KAPI_PARAM_TYPE(KAPI_TYPE_USER_PTR)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("NULL-terminated array of pointers to null-terminated strings")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(3, "envp", "const char __user *const __user *", "Array of environment strings for the new program")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER)
+		KAPI_PARAM_TYPE(KAPI_TYPE_USER_PTR)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("NULL-terminated array of pointers to null-terminated strings in form key=value")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(4, "flags", "int", "Execution flags")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_MASK)
+		KAPI_PARAM_VALID_MASK(AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW | AT_EXECVE_CHECK)
+		KAPI_PARAM_CONSTRAINT("0 or combination of AT_EMPTY_PATH, AT_SYMLINK_NOFOLLOW, and AT_EXECVE_CHECK")
+	KAPI_PARAM_END
+
+	/* Return specification */
+	KAPI_RETURN("long", "Does not return on success (except with AT_EXECVE_CHECK which returns 0); negative error code on error")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+	KAPI_RETURN_END
+
+	/* Error codes */
+	KAPI_ERROR(0, -E2BIG, "E2BIG", "Argument list too long", "The total size of argv and envp exceeds the system limit.")
+	KAPI_ERROR(1, -EACCES, "EACCES", "Permission denied", "Search permission denied on a component of the path, file is not regular, or execute permission denied for file or interpreter.")
+	KAPI_ERROR(2, -EBADF, "EBADF", "Bad file descriptor", "fd is not a valid file descriptor, or (rare bug) all file descriptors are closed when executing a script.")
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
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_INTERRUPTIBLE
+		KAPI_SIGNAL_ERROR(-EINTR)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(1, SIGKILL, "SIGKILL", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_TARGET("All other threads in the thread group")
+		KAPI_SIGNAL_CONDITION("Multi-threaded process doing exec")
+		KAPI_SIGNAL_DESC("During de_thread(), zap_other_threads() sends SIGKILL to all other threads in the thread group to ensure only the execing thread survives.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_QUEUE("Cannot be blocked, caught, or ignored")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(2, 0, "ALL_HANDLERS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Signal has a handler installed")
+		KAPI_SIGNAL_DESC("flush_signal_handlers() resets all signal handlers to SIG_DFL except for signals that are ignored (SIG_IGN). This happens after de_thread() completes.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("Handler information cleared from signal struct")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_SA_FLAGS_FORBID(SA_SIGINFO | SA_ONSTACK | SA_RESTART | SA_NODEFER | SA_RESETHAND)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(3, 0, "IGNORED_SIGNALS", KAPI_SIGNAL_IGNORE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Signal disposition is SIG_IGN")
+		KAPI_SIGNAL_DESC("Signals set to SIG_IGN are preserved across exec. This is POSIX-compliant behavior allowing parent processes to ignore signals in children.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("Ignored signals remain ignored")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(4, 0, "PENDING_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Any pending signals")
+		KAPI_SIGNAL_DESC("All pending signals are cleared during exec. This includes both thread-specific and process-wide pending signals.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("All pending signals discarded")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(5, 0, "TIMER_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Timer-generated signals pending")
+		KAPI_SIGNAL_DESC("flush_itimer_signals() clears any pending timer signals (SIGALRM, SIGVTALRM, SIGPROF) to prevent confusion in the new program.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("Timer signals cleared from pending queue")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(6, SIGCHLD, "SIGCHLD", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_TARGET("Parent process when this process exits")
+		KAPI_SIGNAL_CONDITION("Process exit after exec")
+		KAPI_SIGNAL_DESC("The exit_signal is set to SIGCHLD during exec, ensuring the parent will receive SIGCHLD when this process terminates.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_EXIT)
+		KAPI_SIGNAL_PRIORITY(2)
+		KAPI_SIGNAL_QUEUE("Standard signal delivery to parent")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(7, 0, "SIGALTSTACK", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Process had alternate signal stack")
+		KAPI_SIGNAL_DESC("Any alternate signal stack (sigaltstack) is not preserved across exec. The new program starts with no alternate stack.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("Alternate stack configuration cleared")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_SA_FLAGS_FORBID(SA_ONSTACK)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(8, SIGTRAP, "SIGTRAP", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_TARGET("Current process")
+		KAPI_SIGNAL_CONDITION("Process is being traced (PTRACE_ATTACH or PTRACE_TRACEME)")
+		KAPI_SIGNAL_DESC("If the process is being traced, a SIGTRAP is sent to the process after successful exec. This allows debuggers to gain control after the new program is loaded but before it starts executing.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_EXIT)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("Standard signal delivery")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_TRACED)
+		KAPI_SIGNAL_SA_FLAGS_REQ(SA_SIGINFO)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(9, SIGSEGV, "SIGSEGV", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_COREDUMP)
+		KAPI_SIGNAL_TARGET("Current process")
+		KAPI_SIGNAL_CONDITION("Past point-of-no-return and exec fails")
+		KAPI_SIGNAL_DESC("If exec fails after the point-of-no-return (after de_thread() or exec_mmap()), SIGSEGV is sent to terminate the process with a core dump.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_ERROR(-EINTR)
+		KAPI_SIGNAL_QUEUE("Cannot be blocked")
+		KAPI_SIGNAL_STATE_FORBID(KAPI_SIGNAL_STATE_ZOMBIE | KAPI_SIGNAL_STATE_DEAD)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(10, 0, "BLOCKED_SIGNALS", KAPI_SIGNAL_BLOCK, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Signal mask inherited from caller")
+		KAPI_SIGNAL_DESC("The signal mask is preserved across exec. Blocked signals remain blocked in the new program unless it explicitly changes the mask.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ANYTIME)
+		KAPI_SIGNAL_PRIORITY(2)
+		KAPI_SIGNAL_QUEUE("Signal mask preserved across exec")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(11, 0, "REALTIME_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Realtime signals (SIGRTMIN-SIGRTMAX)")
+		KAPI_SIGNAL_DESC("Realtime signals are handled like standard signals - handlers reset to default, pending signals cleared, but signal mask preserved.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("Pending realtime signals discarded")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
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
+	KAPI_SIDE_EFFECT(7, KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_FREE_MEMORY,
+			 "shared memory",
+			 "Detaches and unmaps all POSIX shared memory regions (shm_open/mmap)")
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
+	KAPI_SIDE_EFFECT_COUNT(8)
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
+	KAPI_NOTES("execveat() was added to allow fexecve() to be implemented on systems that "
+		   "do not have /proc mounted. When filename is an empty string and AT_EMPTY_PATH "
+		   "is specified, the file descriptor fd specifies the file to be executed. "
+		   "AT_SYMLINK_NOFOLLOW prevents following symbolic links. "
+		   "AT_EXECVE_CHECK (since Linux 6.12) only checks if execution would be allowed "
+		   "without actually executing. Like execve(), on success execveat() does not return "
+		   "(except with AT_EXECVE_CHECK which returns 0).\n\n"
+		   "Known bug: If a script is executed and the close-on-exec flag is set for all "
+		   "file descriptors (including 0, 1, and 2), the execveat() call can fail with "
+		   "EBADF when the kernel tries to open the interpreter, as it needs an available "
+		   "file descriptor slot.")
+	.signal_count = 9,
+	.lock_count = 2,
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE5(execveat,
 		int, fd, const char __user *, filename,
 		const char __user *const __user *, argv,
-- 
2.39.5


