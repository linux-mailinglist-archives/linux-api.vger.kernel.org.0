Return-Path: <linux-api+bounces-3913-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8BAD9D1A
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C685A18921E5
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4642E62D6;
	Sat, 14 Jun 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiEIIBis"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB8B2E62C5;
	Sat, 14 Jun 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908948; cv=none; b=i34vD3AmSoAvRxrN7AIq8F5h6197yGO/ELZET9iLFRFE291XdEjCb8F6OZpLpfpDjXFwri8DccU1LN8IivSV8dGxfSsmuHkVPRUUpanfL5BVQRDEC/WSqUn1i3rvu2K8wpto64/aCX5yo+A3YwPgV0VQDUfsTU9QvrcZxbA8D8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908948; c=relaxed/simple;
	bh=Su5C0ZLdpHBzNaB3tC3uk3Gzq0bkfxoEFcXkenceNw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrWaZCGYBqa7caFymR21Clfh3YqeAJZxlSVOnHW2NYJJu+uzs+2QtRW7d3W+gzMjeQyw6aWO1dRh7N9S5Ab/NhzoCjuzsjrCPJ7/ndcWxHjp7hn8/C0RjNmf2KBG8u47vl6zJvbZjIHxInK3kEYo9zuuXSOFzc0PnBypc2gnRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiEIIBis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67FBC4CEF4;
	Sat, 14 Jun 2025 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908948;
	bh=Su5C0ZLdpHBzNaB3tC3uk3Gzq0bkfxoEFcXkenceNw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IiEIIBisIpSWSPSkeX6Z5FrxTiWx86+35Tzr//92ZyjWERwcAoSA6DNtRbELGWLWq
	 PPVVL6FUVM1MxwiKEMNInS49k2eyI6O1QNWe5Q11+237RpBpuqTeJ8FkJNfrkCc0tD
	 lV2/g6MCk7x92nz7sMVdP+1N0vn7qxnrtt1U5oK2ckcPxuFlPbq3Mzg8yrhJk7yx8I
	 lqDU37FC3mI1+1/lNo6PimtiPq0hURMLba+EfdNDzQxLhQgTMBZc6gC7uwq9zXLVIy
	 irYDeCYFKCI/TynQU8NQLmzlGyU2KJ5dwZAcGYGVM3GSEYEo+aZgqY9g775Hhfa/dc
	 RR615vuJW6mtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 08/19] exec: add API specification for execve
Date: Sat, 14 Jun 2025 09:48:47 -0400
Message-Id: <20250614134858.790460-9-sashal@kernel.org>
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

Add comprehensive kernel API specification for the execve() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 1f5fdd2e096e3..3d006105ab23d 100644
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
@@ -1997,7 +1998,224 @@ void set_dumpable(struct mm_struct *mm, int value)
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
+		.type = KAPI_TYPE_PATH,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "Must be a valid pathname to an executable file or script",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "argv", "const char __user *const __user *", "Array of argument strings passed to the new program")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER)
+		.type = KAPI_TYPE_USER_PTR,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "NULL-terminated array of pointers to null-terminated strings",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "envp", "const char __user *const __user *", "Array of environment strings for the new program")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER)
+		.type = KAPI_TYPE_USER_PTR,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "NULL-terminated array of pointers to null-terminated strings in form key=value",
+	KAPI_PARAM_END
+
+	KAPI_RETURN("long", "Does not return on success; returns -1 on error")
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
+	.error_count = 18,
+	.param_count = 3,
+	.since_version = "1.0",
+	.examples = "char *argv[] = { \"echo\", \"hello\", \"world\", NULL };\n"
+		    "char *envp[] = { \"PATH=/bin\", NULL };\n"
+		    "execve(\"/bin/echo\", argv, envp);\n"
+		    "/* This point is only reached on error */\n"
+		    "perror(\"execve failed\");\n"
+		    "exit(EXIT_FAILURE);",
+	.notes = "On success, execve() does not return; the new program is executed. "
+		 "File descriptors remain open unless marked close-on-exec. "
+		 "Signal dispositions are reset to default except for ignored signals. "
+		 "Any alternate signal stack is not preserved. "
+		 "The process's set of pending signals is cleared. "
+		 "All threads except the calling thread are destroyed.",
+
+	/* Fatal signals can interrupt exec */
+	KAPI_SIGNAL(0, 0, "FATAL_SIGNALS", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_CONDITION("Fatal signal pending during exec setup")
+		KAPI_SIGNAL_DESC("Fatal signals (checked via fatal_signal_pending()) can interrupt "
+				 "exec during setup phases like de_thread(). This causes exec to fail "
+				 "and the process to exit.")
+	KAPI_SIGNAL_END
+
+	/* SIGKILL sent to other threads */
+	KAPI_SIGNAL(1, SIGKILL, "SIGKILL", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_TARGET("All other threads in the thread group")
+		KAPI_SIGNAL_CONDITION("Multi-threaded process doing exec")
+		KAPI_SIGNAL_DESC("During de_thread(), zap_other_threads() sends SIGKILL to all "
+				 "other threads in the thread group to ensure only the execing "
+				 "thread survives.")
+	KAPI_SIGNAL_END
+
+	/* Signal handlers reset */
+	KAPI_SIGNAL(2, 0, "ALL_HANDLERS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Signal has a handler installed")
+		KAPI_SIGNAL_DESC("flush_signal_handlers() resets all signal handlers to SIG_DFL "
+				 "except for signals that are ignored (SIG_IGN). This happens "
+				 "after de_thread() completes.")
+	KAPI_SIGNAL_END
+
+	/* Ignored signals preserved */
+	KAPI_SIGNAL(3, 0, "IGNORED_SIGNALS", KAPI_SIGNAL_IGNORE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Signal disposition is SIG_IGN")
+		KAPI_SIGNAL_DESC("Signals set to SIG_IGN are preserved across exec. This is "
+				 "POSIX-compliant behavior allowing parent processes to ignore "
+				 "signals in children.")
+	KAPI_SIGNAL_END
+
+	/* Pending signals cleared */
+	KAPI_SIGNAL(4, 0, "PENDING_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Any pending signals")
+		KAPI_SIGNAL_DESC("All pending signals are cleared during exec. This includes "
+				 "both thread-specific and process-wide pending signals.")
+	KAPI_SIGNAL_END
+
+	/* Timer signals cleared */
+	KAPI_SIGNAL(5, 0, "TIMER_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Timer-generated signals pending")
+		KAPI_SIGNAL_DESC("flush_itimer_signals() clears any pending timer signals "
+				 "(SIGALRM, SIGVTALRM, SIGPROF) to prevent confusion in the "
+				 "new program.")
+	KAPI_SIGNAL_END
+
+	/* Exit signal set to SIGCHLD */
+	KAPI_SIGNAL(6, SIGCHLD, "SIGCHLD", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_TARGET("Parent process when this process exits")
+		KAPI_SIGNAL_CONDITION("Process exit after exec")
+		KAPI_SIGNAL_DESC("The exit_signal is set to SIGCHLD during exec, ensuring the "
+				 "parent will receive SIGCHLD when this process terminates.")
+	KAPI_SIGNAL_END
+
+	/* Alternate signal stack cleared */
+	KAPI_SIGNAL(7, 0, "SIGALTSTACK", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+		KAPI_SIGNAL_CONDITION("Process had alternate signal stack")
+		KAPI_SIGNAL_DESC("Any alternate signal stack (sigaltstack) is not preserved "
+				 "across exec. The new program starts with no alternate stack.")
+	KAPI_SIGNAL_END
+
+	.signal_count = 8,
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
+	KAPI_SIDE_EFFECT_COUNT(6)
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
+KAPI_END_SPEC;
 SYSCALL_DEFINE3(execve,
+
 		const char __user *, filename,
 		const char __user *const __user *, argv,
 		const char __user *const __user *, envp)
-- 
2.39.5


