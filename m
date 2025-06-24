Return-Path: <linux-api+bounces-3969-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B0FAE6E2B
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A88C7AA76C
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1736B2EA473;
	Tue, 24 Jun 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh5v1JMH"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E742E9ED8;
	Tue, 24 Jun 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788472; cv=none; b=R3qVLtaK9nntfN0UrhnAMGTqb+3wZEfWn8wRq5J7KurNgp/eOzYyM2LmrKBGRA+Clha/4hJKTFbbAYo5njtIMOImJ5+pSB5nVUcpii20IwCYSjBsCF7FcTuYywZuOIeQ4E6FbbWg6WgqFPXQiuqe+1n46DmVPPJBhPz0bVevMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788472; c=relaxed/simple;
	bh=d37laSc6+StOOJRmFoIGdCTladx2Ghurdi15ka4ESf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9by8ltmVNjK3BwiUIcmXyEDXCIpK2vallG6KZhJPlPn9+GiMv7k2juK2x0QbABXInFio+8pH57wbtk3kivld38MaQmyP+vKGPXTJ9y3C/es/3ky2hJ9fHgkyw1MLNsATEFttFI0Tm4AkwodyS9fKzpYaGrJ0qSy3tLNE06tGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh5v1JMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66628C4CEF0;
	Tue, 24 Jun 2025 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788471;
	bh=d37laSc6+StOOJRmFoIGdCTladx2Ghurdi15ka4ESf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vh5v1JMHSjB0KuGDHElm6aF5uVwoOX8F9iL07smihsFORxzMfxax8idqokKdCx4Ew
	 9elowxCW8HXRklhkM3zqy97XiWO9gIczNKm23ySLrlqxYnFAeSdM77e5An8u0YM28D
	 f19S1ddhXyytRDGIF7lU7n3Stz93Vp+qmNx27HzvvsfjEGfAoDv7oewQuS0fAbCNUw
	 RQbKlmH61bllhCfb1FrqhaI8l8U3mSmk2Um1gn2wW836Rw4nJClRHvC5ObR0zW+i8G
	 atBSWa68J2CFK3m/uQ+4pRTaFbQy3IncuzPKgoP4WsqTxLracOs0VVDzcbBNv4PilS
	 iYq2vohtlPb+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 08/22] exec: add API specification for execve
Date: Tue, 24 Jun 2025 14:07:28 -0400
Message-Id: <20250624180742.5795-9-sashal@kernel.org>
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

Add comprehensive kernel API specification for the execve() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 364 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 364 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 1f5fdd2e096e3..fd0c88f7be33b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -52,6 +52,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/syscall_api_spec.h>
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
@@ -1997,7 +1998,370 @@ void set_dumpable(struct mm_struct *mm, int value)
 	set_mask_bits(&mm->flags, MMF_DUMPABLE_MASK, value);
 }
 
+
+DEFINE_KERNEL_API_SPEC(sys_execve)
+	KAPI_DESCRIPTION("Execute a new program")
+	KAPI_LONG_DESC("Executes the program referred to by filename. This causes the program "
+		       "that is currently being run by the calling process to be replaced with "
+		       "a new program, with newly initialized stack, heap, and (initialized and "
+		       "uninitialized) data segments. The process ID remains the same.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	KAPI_PARAM(0, "filename", "const char __user *", "Pathname of the program to execute")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER)
+		KAPI_PARAM_TYPE(KAPI_TYPE_PATH)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("Must be a valid pathname to an executable file or script")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "argv", "const char __user *const __user *", "Array of argument strings passed to the new program")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER)
+		KAPI_PARAM_TYPE(KAPI_TYPE_USER_PTR)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("NULL-terminated array of pointers to null-terminated strings")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "envp", "const char __user *const __user *", "Array of environment strings for the new program")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER)
+		KAPI_PARAM_TYPE(KAPI_TYPE_USER_PTR)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("NULL-terminated array of pointers to null-terminated strings in form key=value")
+	KAPI_PARAM_END
+
+	KAPI_RETURN("long", "Does not return on success; negative error code on error")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+	KAPI_RETURN_END
+
+	KAPI_ERROR(0, -E2BIG, "E2BIG", "Argument list too long",
+		   "The total size of argv and envp exceeds the system limit.")
+	KAPI_ERROR(1, -EACCES, "EACCES", "Permission denied",
+		   "Search permission denied on a component of the path, file is not regular, "
+		   "or execute permission denied for file or interpreter.")
+	KAPI_ERROR(2, -EFAULT, "EFAULT", "Bad address",
+		   "filename, argv, or envp points outside accessible address space.")
+	KAPI_ERROR(3, -EINVAL, "EINVAL", "Invalid executable format",
+		   "An ELF executable has more than one PT_INTERP segment.")
+	KAPI_ERROR(4, -EIO, "EIO", "I/O error",
+		   "An I/O error occurred while reading from the file system.")
+	KAPI_ERROR(5, -EISDIR, "EISDIR", "Is a directory",
+		   "An ELF interpreter was a directory.")
+	KAPI_ERROR(6, -ELIBBAD, "ELIBBAD", "Invalid ELF interpreter",
+		   "An ELF interpreter was not in a recognized format.")
+	KAPI_ERROR(7, -ELOOP, "ELOOP", "Too many symbolic links",
+		   "Too many symbolic links encountered while resolving filename or interpreter.")
+	KAPI_ERROR(8, -EMFILE, "EMFILE", "Too many open files",
+		   "The per-process limit on open file descriptors has been reached.")
+	KAPI_ERROR(9, -ENAMETOOLONG, "ENAMETOOLONG", "Filename too long",
+		   "filename or one of the strings in argv or envp is too long.")
+	KAPI_ERROR(10, -ENFILE, "ENFILE", "System file table overflow",
+		   "The system-wide limit on open files has been reached.")
+	KAPI_ERROR(11, -ENOENT, "ENOENT", "File not found",
+		   "The file filename or an interpreter does not exist.")
+	KAPI_ERROR(12, -ENOEXEC, "ENOEXEC", "Exec format error",
+		   "An executable is not in a recognized format, is for wrong architecture, "
+		   "or has other format errors preventing execution.")
+	KAPI_ERROR(13, -ENOMEM, "ENOMEM", "Out of memory",
+		   "Insufficient kernel memory available.")
+	KAPI_ERROR(14, -ENOTDIR, "ENOTDIR", "Not a directory",
+		   "A component of the path prefix is not a directory.")
+	KAPI_ERROR(15, -EPERM, "EPERM", "Operation not permitted",
+		   "The filesystem is mounted nosuid, the user is not root, and the file has "
+		   "set-user-ID or set-group-ID bit set.")
+	KAPI_ERROR(16, -ETXTBSY, "ETXTBSY", "Text file busy",
+		   "The executable was open for writing by one or more processes.")
+	KAPI_ERROR(17, -EAGAIN, "EAGAIN", "Resource temporarily unavailable",
+		   "RLIMIT_NPROC limit exceeded - too many processes for this user.")
+
+	KAPI_ERROR_COUNT(18)
+	KAPI_PARAM_COUNT(3)
+	KAPI_SINCE_VERSION("1.0")
+	KAPI_EXAMPLES("char *argv[] = { \"echo\", \"hello\", \"world\", NULL };\n"
+		      "char *envp[] = { \"PATH=/bin\", NULL };\n"
+		      "execve(\"/bin/echo\", argv, envp);\n"
+		      "/* This point is only reached on error */\n"
+		      "perror(\"execve failed\");\n"
+		      "exit(EXIT_FAILURE);")
+	KAPI_NOTES("On success, execve() does not return; the new program is executed. "
+		   "File descriptors remain open unless marked close-on-exec. "
+		   "Signal handling undergoes major changes: handlers reset to default (except SIG_IGN), "
+		   "pending signals cleared, alternate signal stack removed, but signal mask preserved. "
+		   "Fatal signals can interrupt exec causing process termination. "
+		   "Multi-threaded programs: all threads except caller are killed with SIGKILL. "
+		   "Traced processes receive SIGTRAP after successful exec. "
+		   "Point of no return: if exec fails after destroying old image, SIGSEGV is forced.")
+
+	/* Fatal signals can interrupt exec */
+	KAPI_SIGNAL(0, 0, "FATAL_SIGNALS", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_CONDITION("Fatal signal pending during exec setup")
+		KAPI_SIGNAL_DESC("Fatal signals (checked via fatal_signal_pending()) can interrupt "
+				 "exec during setup phases like de_thread(). This causes exec to fail "
+				 "and the process to exit.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_INTERRUPTIBLE
+		KAPI_SIGNAL_ERROR(-EINTR)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+	KAPI_SIGNAL_END
+
+	/* SIGKILL sent to other threads */
+	KAPI_SIGNAL(1, SIGKILL, "SIGKILL", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_TARGET("All other threads in the thread group")
+		KAPI_SIGNAL_CONDITION("Multi-threaded process doing exec")
+		KAPI_SIGNAL_DESC("During de_thread(), zap_other_threads() sends SIGKILL to all "
+				 "other threads in the thread group to ensure only the execing "
+				 "thread survives.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE(KAPI_SIGNAL_QUEUE_STANDARD)
+	KAPI_SIGNAL_END
+
+	/* Signal handlers reset */
+	KAPI_SIGNAL(2, 0, "ALL_HANDLERS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Signal has a handler installed")
+		KAPI_SIGNAL_DESC("flush_signal_handlers() resets all signal handlers to SIG_DFL "
+				 "except for signals that are ignored (SIG_IGN). This happens "
+				 "after de_thread() completes.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("Handler information cleared from signal struct")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_SA_FLAGS_FORBID(SA_RESTART | SA_NODEFER | SA_RESETHAND | SA_SIGINFO | SA_ONSTACK)
+	KAPI_SIGNAL_END
+
+	/* Ignored signals preserved */
+	KAPI_SIGNAL(3, 0, "IGNORED_SIGNALS", KAPI_SIGNAL_IGNORE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Signal disposition is SIG_IGN")
+		KAPI_SIGNAL_DESC("Signals set to SIG_IGN are preserved across exec. This is "
+				 "POSIX-compliant behavior allowing parent processes to ignore "
+				 "signals in children.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("Ignored signals remain ignored")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	/* Pending signals cleared */
+	KAPI_SIGNAL(4, 0, "PENDING_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_DISCARD)
+		KAPI_SIGNAL_CONDITION("Any pending signals")
+		KAPI_SIGNAL_DESC("All pending signals are cleared during exec. This includes "
+				 "both thread-specific and process-wide pending signals.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("All pending signals discarded")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	/* Timer signals cleared */
+	KAPI_SIGNAL(5, 0, "TIMER_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Timer-generated signals pending")
+		KAPI_SIGNAL_DESC("flush_itimer_signals() clears any pending timer signals "
+				 "(SIGALRM, SIGVTALRM, SIGPROF) to prevent confusion in the "
+				 "new program.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("Timer signals cleared from pending queue")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	/* Exit signal set to SIGCHLD */
+	KAPI_SIGNAL(6, SIGCHLD, "SIGCHLD", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_TARGET("Parent process when this process exits")
+		KAPI_SIGNAL_CONDITION("Process exit after exec")
+		KAPI_SIGNAL_DESC("The exit_signal is set to SIGCHLD during exec, ensuring the "
+				 "parent will receive SIGCHLD when this process terminates.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_EXIT)
+		KAPI_SIGNAL_PRIORITY(2)
+		KAPI_SIGNAL_QUEUE("Standard signal delivery to parent")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	/* Alternate signal stack cleared */
+	KAPI_SIGNAL(7, 0, "SIGALTSTACK", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Process had alternate signal stack")
+		KAPI_SIGNAL_DESC("Any alternate signal stack (sigaltstack) is not preserved "
+				 "across exec. The new program starts with no alternate stack.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE("Alternate stack configuration cleared")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_SA_FLAGS_FORBID(SA_ONSTACK)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	/* SIGTRAP sent when process is being traced */
+	KAPI_SIGNAL(8, SIGTRAP, "SIGTRAP", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_TARGET("Current process")
+		KAPI_SIGNAL_CONDITION("Process is being traced (PTRACE_ATTACH or PTRACE_TRACEME)")
+		KAPI_SIGNAL_DESC("If the process is being traced, a SIGTRAP is sent to the "
+				 "process after successful exec. This allows debuggers to gain "
+				 "control after the new program is loaded but before it starts executing.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_EXIT)
+		KAPI_SIGNAL_PRIORITY(10)
+		KAPI_SIGNAL_QUEUE(KAPI_SIGNAL_QUEUE_STANDARD)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_TRACED)
+	KAPI_SIGNAL_END
+
+	/* SIGSEGV sent on point of no return failure */
+	KAPI_SIGNAL(9, SIGSEGV, "SIGSEGV", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_COREDUMP)
+		KAPI_SIGNAL_TARGET("Current process")
+		KAPI_SIGNAL_CONDITION("Exec fails after point of no return")
+		KAPI_SIGNAL_DESC("If exec fails after the point of no return (when the old "
+				 "process image has been destroyed), force_fatal_sig(SIGSEGV) "
+				 "is called to terminate the process since it cannot continue.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_EXIT)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_STATE_FORBID(KAPI_SIGNAL_STATE_ZOMBIE | KAPI_SIGNAL_STATE_DEAD)
+	KAPI_SIGNAL_END
+
+	/* Signal mask preserved */
+	KAPI_SIGNAL(10, 0, "SIGNAL_MASK", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Process has blocked signals")
+		KAPI_SIGNAL_DESC("The signal mask (blocked signals) is preserved across exec. "
+				 "This allows processes to block signals before exec and have "
+				 "them remain blocked in the new program.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(2)
+		KAPI_SIGNAL_QUEUE("Signal mask preserved across exec")
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	/* Realtime signal queues cleared */
+	KAPI_SIGNAL(11, 0, "REALTIME_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_DISCARD)
+		KAPI_SIGNAL_CONDITION("Realtime signals queued")
+		KAPI_SIGNAL_DESC("All queued realtime signals (SIGRTMIN to SIGRTMAX) are "
+				 "discarded during exec. The realtime signal queue is cleared.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_QUEUE(KAPI_SIGNAL_QUEUE_REALTIME)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	.signal_count = 12,
+
+	/* Signal masks */
+	KAPI_SIGNAL_MASK(0, "critical_section_mask", "Signals blocked during critical exec sections")
+		/* During de_thread and other critical sections, certain signals may be blocked */
+	KAPI_SIGNAL_MASK_END
+
+	KAPI_SIGNAL_MASK_COUNT(1)
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
+	KAPI_SIDE_EFFECT(6, KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_FREE_MEMORY,
+			 "shared memory",
+			 "Detaches and unmaps all POSIX shared memory regions (shm_open/mmap)")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(7)
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
+	KAPI_STATE_TRANS_COUNT(4)
+
+	/* Additional constraints */
+	KAPI_CONSTRAINT(0, "Argument Size Limits",
+			"Total size of argv[] and envp[] is limited by ARG_MAX (usually 2MB on "
+			"modern systems). This includes both the string data and the pointer "
+			"arrays. The limit is checked early to prevent excessive memory allocation. "
+			"Individual argument strings are limited to MAX_ARG_STRLEN (131072 bytes).")
+		KAPI_CONSTRAINT_EXPR("total_arg_size <= ARG_MAX && each_arg_len <= MAX_ARG_STRLEN")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(1, "RLIMIT_NPROC Process Limit",
+			"The RLIMIT_NPROC limit is enforced during execve() to prevent fork bombs. "
+			"If the user would exceed their process limit after exec, the PF_NPROC_EXCEEDED "
+			"flag is set and exec may fail. This check happens even though exec doesn't "
+			"create new processes, to catch programs that exec after fork.")
+		KAPI_CONSTRAINT_EXPR("user_processes < RLIMIT_NPROC || PF_NPROC_EXCEEDED")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(2, "Binary Format Handlers",
+			"The kernel tries binary format handlers in order: built-in formats "
+			"(ELF, script, etc.), then modular formats. Script interpreters can "
+			"recurse up to 5 levels deep (BINPRM_MAX_RECURSION). Each recursion "
+			"consumes one argv slot for the interpreter path.")
+		KAPI_CONSTRAINT_EXPR("recursion_depth <= 5")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(3, "Security Transitions",
+			"Security modules (SELinux, AppArmor, etc.) may deny exec based on "
+			"policy. Capabilities are recalculated based on file capabilities "
+			"and setuid/setgid bits. The dumpable flag is cleared for security "
+			"transitions. AT_SECURE is set in auxiliary vector for secure execs.")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(4, "Stack Size Calculation",
+			"Stack size is limited by RLIMIT_STACK but adjusted based on "
+			"personality flags and architecture requirements. The stack must "
+			"accommodate argv, envp, auxiliary vector, and initial program stack. "
+			"On some architectures, executable stack is determined by PT_GNU_STACK.")
+		KAPI_CONSTRAINT_EXPR("stack_size >= ARG_MAX && stack_size <= RLIMIT_STACK")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT_COUNT(5)
+
+KAPI_END_SPEC;
 SYSCALL_DEFINE3(execve,
+
 		const char __user *, filename,
 		const char __user *const __user *, argv,
 		const char __user *const __user *, envp)
-- 
2.39.5


