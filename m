Return-Path: <linux-api+bounces-4585-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8D4B349F7
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 20:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986E77A41F4
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 18:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD1311591;
	Mon, 25 Aug 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cojoGZ6A"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262C3112A4;
	Mon, 25 Aug 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145682; cv=none; b=DhhvaOUmVPo59kadReJ8selPveYCXhPt7vGGQAUKr6gsIyuLnt2PaTh3cLj7sWl6OrFPdmUI0hgHlcCAr8FNttLRQ83e5LT9noLRtWr5d2/aghw8NjT+UdB/c251QiqMwg3xPTO2EC+tNWGlRjtPNoQH3nsfTahJQ8z4cKbDroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145682; c=relaxed/simple;
	bh=VvyKPfcvg5F50OLEFSTbrQ14FSKsl0j68hi40MPHzpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmIfteDTm1P0Ft9Voohkx69zrrF/D4NF8x4ii7YNWjnw1NXKA2Ox1/B6LCfgC2p0974W+R/i62BR1u3PwAF/Kw4Ejuk9+8URi52FCTk91iqf5Pa2i7oA4dv85uv36AzZn8fGl3g+fyadDLKOIxnZNNkVOIp95SDvTDwtRk72DYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cojoGZ6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBB0C113D0;
	Mon, 25 Aug 2025 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145682;
	bh=VvyKPfcvg5F50OLEFSTbrQ14FSKsl0j68hi40MPHzpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cojoGZ6AcKBSntLTxTKyH7FUcymGqdJbrZuwt/hbdvGkFJdAbi3DZKz1D0u9BX3M5
	 WTzIBBzaZfeCR5CygFZ4JOxCtmUgiGH+o7Edb0HQNJG9OhjHtrR27ugbkLp795KQR/
	 u03DgNF2VEJRjMVGOQwfq0/pfImPjb8QNppJB2l2CFjWzDOizLGF6Id15La0zzh6y3
	 MN6wUVygY/DxBRsT4/7pp1I7pWJ7m+AmegI4CuJQjIC/xMVHRQj/qBoTmIs4Yd1yDE
	 QRqxscyNHANsDZ4O2FejH1uiP4/L5JZhlnuVWm1t8w87W+/G/hsawu/FnVcEMgzlwd
	 OrPda9UIpTfGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v4 6/7] fs/exec: add API specification for execveat
Date: Mon, 25 Aug 2025 14:14:33 -0400
Message-ID: <20250825181434.3340805-7-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825181434.3340805-1-sashal@kernel.org>
References: <20250825181434.3340805-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel API specification for the execveat() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 594 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 594 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 2a1e5e4042a1..5dab6a801040 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2010,6 +2010,600 @@ SYSCALL_DEFINE3(execve,
 	return do_execve(getname(filename), argv, envp);
 }
 
+/**
+ * sys_execveat - Execute program relative to directory file descriptor
+ * @fd: File descriptor of directory for relative pathname
+ * @filename: Pathname of program to execute
+ * @argv: Argument vector for new program
+ * @envp: Environment vector for new program
+ * @flags: Execution flags
+ *
+ * long-desc: Executes a new program, replacing the current process image with a new
+ *   process image. Similar to execve(), but the program is specified via a
+ *   directory file descriptor and pathname. Supports execution of scripts,
+ *   ELF binaries, and other registered binary formats. Handles setuid/setgid
+ *   executables with appropriate privilege transitions. The execveat() system
+ *   call combines and extends the functionality of execve() and fexecve().
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: fd
+ *   type: KAPI_TYPE_INT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Valid file descriptor or AT_FDCWD (-100) for current directory
+ *
+ * param: filename
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: Can be relative (to fd), absolute, or empty if AT_EMPTY_PATH is set
+ *
+ * param: argv
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: NULL-terminated array of strings, total size < MAX_ARG_STRLEN * MAX_ARG_STRINGS
+ *
+ * param: envp
+ *   type: KAPI_TYPE_USER_PTR
+ *   flags: KAPI_PARAM_IN | KAPI_PARAM_USER
+ *   constraint-type: KAPI_CONSTRAINT_CUSTOM
+ *   constraint: NULL-terminated array of strings, total size < MAX_ARG_STRLEN * MAX_ARG_STRINGS
+ *
+ * param: flags
+ *   type: KAPI_TYPE_INT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_BITMASK
+ *   valid-mask: AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW | AT_EXECVE_CHECK
+ *   constraint: AT_* flag validation
+ *   constraint: AT_EMPTY_PATH allows empty filename
+ *   constraint: AT_SYMLINK_NOFOLLOW prevents following symlinks
+ *   constraint: AT_EXECVE_CHECK only checks if execution would succeed
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_NO_RETURN
+ *   success: 0
+ *   desc: On success, execveat() does not return (except with AT_EXECVE_CHECK which returns 0). On error, -1 is returned and errno is set
+ *
+ * error: E2BIG, Argument list too long
+ *   desc: Total size of argument and environment strings exceeds MAX_ARG_STRLEN * MAX_ARG_STRINGS
+ *     or a single string exceeds MAX_ARG_STRLEN, or too many arguments (> MAX_ARG_STRINGS)
+ *
+ * error: EACCES, Permission denied
+ *   desc: Execute permission denied on file, or search permission denied on path component
+ *     or file is not regular file, or filesystem mounted noexec
+ *     or file on read-only filesystem and requires writing
+ *
+ * error: EAGAIN, Resource limit exceeded
+ *   desc: RLIMIT_NPROC resource limit exceeded and process lacks CAP_SYS_ADMIN and CAP_SYS_RESOURCE
+ *     or cannot allocate necessary kernel structures due to memory pressure
+ *
+ * error: EBADF, Bad file descriptor
+ *   desc: The fd argument is not a valid file descriptor, or is not open
+ *     or filename is empty and AT_EMPTY_PATH not specified
+ *
+ * error: EFAULT, Bad address
+ *   desc: filename, argv, or envp points outside accessible address space
+ *     or argv/envp element points to invalid memory
+ *
+ * error: EINTR, Interrupted by signal
+ *   desc: A signal was caught during execution of execveat()
+ *     typically during the security checks or while setting up the new program
+ *
+ * error: EINVAL, Invalid argument
+ *   desc: Invalid flags specified, or ELF interpreter invalid
+ *     or incompatible architecture, or fd refers to something that cannot be executed
+ *
+ * error: EIO, I/O error
+ *   desc: An I/O error occurred while reading from the file system
+ *
+ * error: EISDIR, Is a directory
+ *   desc: The final component of filename or the file referred to by fd is a directory
+ *     or an ELF interpreter was a directory
+ *
+ * error: ELIBBAD, Invalid ELF interpreter
+ *   desc: An ELF interpreter was not in a recognized format
+ *
+ * error: ELOOP, Too many symbolic links
+ *   desc: Too many symbolic links encountered in resolving filename or fd
+ *     or maximum recursion depth exceeded in script interpreter resolution
+ *
+ * error: EMFILE, Too many open files
+ *   desc: The per-process limit on open file descriptors has been reached
+ *
+ * error: ENAMETOOLONG, Filename too long
+ *   desc: filename is too long, or a component of the pathname exceeds NAME_MAX
+ *     or pathname exceeds PATH_MAX
+ *
+ * error: ENFILE, System file table overflow
+ *   desc: The system-wide limit on the total number of open files has been reached
+ *
+ * error: ENOENT, No such file or directory
+ *   desc: filename or a component of the path does not exist
+ *     or the file referred to by fd does not exist (when AT_EMPTY_PATH)
+ *     or interpreter does not exist
+ *
+ * error: ENOEXEC, Exec format error
+ *   desc: The file is not in a recognized executable format, is for wrong architecture
+ *     or has some other format error that prevents execution
+ *
+ * error: ENOMEM, Out of memory
+ *   desc: Insufficient kernel memory available to execute the new program
+ *     cannot allocate page tables, or other memory structures
+ *
+ * error: ENOTDIR, Not a directory
+ *   desc: A component of the path prefix of filename or fd is not a directory
+ *
+ * error: EPERM, Operation not permitted
+ *   desc: The filesystem is mounted nosuid, the user is not root, and the file has
+ *     set-user-ID or set-group-ID bit set, or file is on a filesystem mounted
+ *     with MS_NOEXEC, or the process is being traced
+ *
+ * error: ETXTBSY, Text file busy
+ *   desc: The executable was open for writing by one or more processes
+ *
+ *
+ * lock: cred_guard_mutex
+ *   type: KAPI_LOCK_MUTEX
+ *   acquired: true
+ *   released: true
+ *   desc: Process credential guard mutex - prevents concurrent credential changes during exec
+ *
+ * lock: exec_update_lock
+ *   type: KAPI_LOCK_RWLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Signal exec update lock - taken for write during exec to prevent racing changes
+ *
+ * lock: sighand->siglock
+ *   type: KAPI_LOCK_SPINLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Signal handler spinlock - protects signal handler updates during exec
+ *
+ * lock: tasklist_lock
+ *   type: KAPI_LOCK_RWLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Global task list lock - taken for write when updating thread group during exec
+ *
+ * lock: binfmt_lock
+ *   type: KAPI_LOCK_RWLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Binary format list lock - taken for read when searching for binary handlers
+ *
+ * lock: mmap_lock
+ *   type: KAPI_LOCK_RWLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Memory map lock - taken when setting up new memory layout for executed program
+ *
+ * signal: SIGKILL
+ *   direction: KAPI_SIGNAL_RECEIVE
+ *   action: KAPI_SIGNAL_ACTION_TERMINATE
+ *   condition: Process killed during exec
+ *   desc: If the process is killed (SIGKILL) during execution, the exec
+ *     operation is aborted. This can happen at various points including
+ *     credential changes, memory setup, or binary loading. The process
+ *     terminates immediately without returning from execveat().
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   priority: 0
+ *   restartable: no
+ *   state-req: KAPI_SIGNAL_STATE_RUNNING
+ *
+ * signal: FATAL
+ *   direction: KAPI_SIGNAL_RECEIVE
+ *   action: KAPI_SIGNAL_ACTION_RETURN
+ *   condition: Fatal signal pending
+ *   desc: Fatal signals interrupt execveat at specific checkpoints:
+ *     during argument copying, credential setup, and binary loading.
+ *     Returns -EINTR or -ERESTARTNOINTR. After point of no return,
+ *     signals cause the process to terminate rather than return.
+ *   error: -EINTR
+ *   timing: KAPI_SIGNAL_TIME_BEFORE
+ *   priority: 1
+ *   interruptible: yes
+ *   state-req: KAPI_SIGNAL_STATE_RUNNING
+ *
+ * signal: SIGKILL_THREADS
+ *   direction: KAPI_SIGNAL_SEND
+ *   action: KAPI_SIGNAL_ACTION_TERMINATE
+ *   condition: Multi-threaded process doing exec
+ *   desc: During de_thread(), zap_other_threads() sends SIGKILL to all
+ *     other threads in the thread group to ensure only the execing thread
+ *     survives. This ensures the process becomes single-threaded.
+ *   target: All other threads in thread group
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   priority: 0
+ *
+ * signal: HANDLERS_RESET
+ *   direction: KAPI_SIGNAL_HANDLE
+ *   action: KAPI_SIGNAL_ACTION_CUSTOM
+ *   condition: Signal has a handler installed
+ *   desc: flush_signal_handlers() resets all signal handlers to SIG_DFL
+ *     except for signals that are ignored (SIG_IGN). This happens after
+ *     de_thread() completes to give the new program a clean signal state.
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *
+ *
+ * signal: IGNORED_PRESERVED
+ *   direction: KAPI_SIGNAL_IGNORE
+ *   action: KAPI_SIGNAL_ACTION_CUSTOM
+ *   condition: Signal disposition is SIG_IGN
+ *   desc: Signals set to SIG_IGN are preserved across exec. This is
+ *     POSIX-compliant behavior allowing parent processes to control
+ *     signal handling in children.
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *
+ *
+ * signal: PENDING_CLEARED
+ *   direction: KAPI_SIGNAL_HANDLE
+ *   action: KAPI_SIGNAL_ACTION_CUSTOM
+ *   condition: Any pending signals
+ *   desc: All pending signals are cleared during exec. This includes
+ *     both thread-specific and process-wide pending signals to prevent
+ *     unexpected signal delivery to the new program.
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *
+ *
+ * signal: TIMER_SIGNALS
+ *   direction: KAPI_SIGNAL_HANDLE
+ *   action: KAPI_SIGNAL_ACTION_CUSTOM
+ *   condition: Timer-generated signals pending
+ *   desc: flush_itimer_signals() clears any pending timer signals
+ *     (SIGALRM, SIGVTALRM, SIGPROF) to prevent confusion in the new program.
+ *     Timer settings are also reset.
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *
+ *
+ * signal: SIGCHLD_SETUP
+ *   direction: KAPI_SIGNAL_SEND
+ *   action: KAPI_SIGNAL_ACTION_DEFAULT
+ *   condition: Process exit after exec
+ *   desc: The exit_signal is set to SIGCHLD during exec, ensuring the
+ *     parent will receive SIGCHLD when this process terminates.
+ *   target: Parent process
+ *   timing: KAPI_SIGNAL_TIME_AFTER
+ *
+ *
+ * signal: SIGALTSTACK_CLEARED
+ *   direction: KAPI_SIGNAL_HANDLE
+ *   action: KAPI_SIGNAL_ACTION_CUSTOM
+ *   condition: Process had alternate signal stack
+ *   desc: Any alternate signal stack (sigaltstack) is not preserved
+ *     across exec. The new program starts with no alternate stack.
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *
+ *
+ * signal: SIGSEGV_FORCED
+ *   direction: KAPI_SIGNAL_SEND
+ *   action: KAPI_SIGNAL_ACTION_TERMINATE
+ *   condition: Error after point of no return
+ *   desc: If an error occurs after the point of no return and no fatal
+ *     signal is already pending, force_fatal_sig(SIGSEGV) is called to
+ *     terminate the process since it cannot return to the old state.
+ *   target: Current process
+ *   timing: KAPI_SIGNAL_TIME_AFTER
+ *   priority: 0
+ *
+ * side-effect: KAPI_EFFECT_PROCESS_STATE | KAPI_EFFECT_IRREVERSIBLE
+ *   target: process image
+ *   desc: Completely replaces the process image with new program.
+ *     The entire process address space, including code, data, heap,
+ *     and stack are replaced. Only PID, parent PID, and some signal
+ *     dispositions are preserved. This is irreversible once past the
+ *     point of no return.
+ *
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_CREDS
+ *   target: process credentials
+ *   desc: Updates process credentials for setuid/setgid executables.
+ *     Effective UID/GID are changed to file owner/group if setuid/setgid
+ *     bits are set and filesystem allows. Real UID/GID unchanged unless
+ *     explicitly set. Saved set-user-ID updated. Capabilities may be
+ *     gained or lost. AT_SECURE is set for security transitions.
+ *   condition: File has setuid or setgid bits
+ *   reversible: no
+ *
+ *
+ * side-effect: KAPI_EFFECT_CLOSE_FD
+ *   target: file descriptors
+ *   desc: Closes file descriptors marked with FD_CLOEXEC.
+ *     All file descriptors with FD_CLOEXEC flag are automatically closed.
+ *     Other file descriptors remain open and available to new program.
+ *     Standard streams (0,1,2) typically preserved unless explicitly marked.
+ *   reversible: no
+ *
+ *
+ * side-effect: KAPI_EFFECT_SIGNAL_STATE
+ *   target: signal handlers
+ *   desc: Resets signal handlers to default.
+ *     All caught signals are reset to default disposition (SIG_DFL).
+ *     Ignored signals (SIG_IGN) remain ignored except in special cases.
+ *     Signal mask is preserved. Pending signals are preserved unless
+ *     they would be ignored by the new program.
+ *   reversible: no
+ *
+ *
+ * side-effect: KAPI_EFFECT_MEMORY_MAP
+ *   target: memory mappings
+ *   desc: Destroys all existing memory mappings.
+ *     All memory mappings including shared memory, mmapped files, and
+ *     anonymous mappings are unmapped. New mappings are created for
+ *     the executed program's code, data, and stack. Shared memory
+ *     attachments are detached.
+ *   reversible: no
+ *
+ *
+ * side-effect: KAPI_EFFECT_THREAD_STATE
+ *   target: thread group
+ *   desc: Terminates all other threads in thread group.
+ *     If the calling thread is part of a multi-threaded process,
+ *     all other threads are terminated. The thread group becomes
+ *     single-threaded with only the execing thread surviving.
+ *     Thread group leader transfers if necessary.
+ *   condition: Multi-threaded process
+ *   reversible: no
+ *
+ *
+ * side-effect: KAPI_EFFECT_RLIMIT
+ *   target: resource limits
+ *   desc: Preserves most resource limits.
+ *     Resource limits (RLIMIT_*) are generally preserved across exec.
+ *     RLIMIT_CPU timer is reset. RLIMIT_STACK may be adjusted for
+ *     the new program's requirements.
+ *
+ *
+ * side-effect: KAPI_EFFECT_FILESYSTEM
+ *   target: working directory
+ *   desc: Preserves working directory and root.
+ *     Current working directory and root directory are preserved.
+ *     Umask is preserved. Close-on-exec file descriptors are closed.
+ *     File locks are preserved if not associated with closed descriptors.
+ *
+ *
+ * side-effect: KAPI_EFFECT_ACCOUNTING
+ *   target: process accounting
+ *   desc: Updates accounting information.
+ *     Process accounting records exec event. CPU timers reset.
+ *     Start time updated. Command name (comm) changed to new program.
+ *     Audit events generated for security-relevant transitions.
+ *
+ *
+ * side-effect: KAPI_EFFECT_NAMESPACE
+ *   target: personality
+ *   desc: May change execution personality.
+ *     Execution personality (e.g., Linux, SVR4, etc.) may change based
+ *     on binary format. This affects system call behavior, signal
+ *     numbering, and other ABI details. Usually preserved but can
+ *     change for compatibility.
+ *   condition: Binary requires different personality
+ *
+ *
+ * side-effect: KAPI_EFFECT_IO_CANCEL
+ *   target: io_uring
+ *   desc: Cancels all io_uring operations.
+ *     io_uring_task_cancel() is called to cancel any pending
+ *     io_uring operations. This prevents the new program from inheriting
+ *     incomplete asynchronous I/O operations from the old program.
+ *
+ *
+ * side-effect: KAPI_EFFECT_FILES_UNSHARE
+ *   target: file table
+ *   desc: Unshares file descriptor table.
+ *     unshare_files() ensures the process has its own file
+ *     descriptor table, not shared with other processes. This is required
+ *     for security during credential changes.
+ *
+ *
+ * side-effect: KAPI_EFFECT_PTRACE
+ *   target: ptrace event
+ *   desc: Generates PTRACE_EVENT_EXEC.
+ *     ptrace_event(PTRACE_EVENT_EXEC) notifies any process
+ *     tracing this one that an exec has occurred. The tracer can then
+ *     update its state and continue tracing the new program.
+ *
+ *
+ * side-effect: KAPI_EFFECT_CONNECTOR
+ *   target: process connector
+ *   desc: Sends exec notification.
+ *     proc_exec_connector() sends a notification through
+ *     the process connector (cn_proc) subsystem to inform interested
+ *     listeners that an exec has occurred.
+ *
+ *
+ * side-effect: KAPI_EFFECT_SCHEDULER
+ *   target: scheduler state
+ *   desc: Updates scheduler state for exec.
+ *     sched_exec() performs scheduler operations for exec,
+ *     potentially migrating the task to a less loaded CPU. Also manages
+ *     MM context IDs via sched_mm_cid_before_execve/after_execve.
+ *
+ *
+ * side-effect: KAPI_EFFECT_RSEQ
+ *   target: restartable sequences
+ *   desc: Handles rseq for exec.
+ *     rseq_execve() handles restartable sequence
+ *     state during exec. The rseq area is cleared to prevent the new
+ *     program from using stale rseq data from the old program.
+ *
+ *
+ * side-effect: KAPI_EFFECT_USER_EVENTS
+ *   target: user events
+ *   desc: Notifies user event subsystem.
+ *     user_events_execve() notifies the user events
+ *     tracing subsystem that an exec has occurred, allowing userspace
+ *     tracing tools to track process transitions.
+ *
+ *
+ * side-effect: KAPI_EFFECT_NUMA
+ *   target: NUMA state
+ *   desc: Cleans up NUMA task state.
+ *     task_numa_free() releases NUMA-related task state
+ *     including fault statistics and placement information. The new
+ *     program starts with fresh NUMA placement decisions.
+ *
+ *
+ * state-trans: executing
+ *   to: new program
+ *   condition: exec succeeds
+ *   target: process image
+ *   desc: Process transitions from executing current program to executing new program
+ *
+ *
+ * state-trans: multi-threaded
+ *   to: single-threaded
+ *   condition: exec in threaded process
+ *   target: thread group
+ *   desc: Multi-threaded process becomes single-threaded as all other threads terminate
+ *
+ *
+ * state-trans: unprivileged
+ *   to: privileged
+ *   condition: setuid/setgid exec
+ *   target: process credentials
+ *   desc: Process may gain privileges through setuid/setgid execution
+ *
+ *
+ * state-trans: privileged
+ *   to: unprivileged
+ *   condition: capability drop
+ *   target: process capabilities
+ *   desc: Process may lose capabilities when executing non-privileged binary
+ *
+ *
+ * state-trans: dumpable
+ *   to: non-dumpable
+ *   condition: security transition
+ *   target: process dumpability
+ *   desc: Process becomes non-dumpable after setuid/setgid or capability changes
+ *
+ *
+ * capability: CAP_SYS_ADMIN
+ *   type: KAPI_CAP_BYPASS
+ *   desc: Allows exceeding RLIMIT_NPROC process limit
+ *   allows: Allows exceeding RLIMIT_NPROC process limit
+ *   without: Execution fails with EAGAIN if RLIMIT_NPROC exceeded
+ *   condition: Process count at or above RLIMIT_NPROC
+ *   priority: 0
+ *
+ *
+ * capability: CAP_SYS_RESOURCE
+ *   type: KAPI_CAP_BYPASS
+ *   desc: Allows exceeding RLIMIT_NPROC process limit
+ *   allows: Allows exceeding RLIMIT_NPROC process limit
+ *   without: Execution fails with EAGAIN if RLIMIT_NPROC exceeded
+ *   condition: Process count at or above RLIMIT_NPROC
+ *   priority: 0
+ *
+ *
+ * capability: CAP_DAC_OVERRIDE
+ *   type: KAPI_CAP_BYPASS
+ *   desc: Allows execution of files without execute permission
+ *   allows: Allows execution of files without execute permission
+ *   without: Must have execute permission on file
+ *   condition: File lacks execute permission
+ *   priority: 0
+ *
+ *
+ * capability: CAP_MAC_ADMIN
+ *   type: KAPI_CAP_BYPASS
+ *   desc: May bypass MAC policy restrictions on execution
+ *   allows: May bypass MAC policy restrictions on execution
+ *   without: Subject to mandatory access control policies
+ *   condition: MAC policy would deny execution
+ *   priority: 0
+ *
+ *
+ * constraint: Binary Format Support
+ *   desc: The kernel must have support for the binary format being executed (ELF, script, etc).
+ *     Binary format handlers are registered via register_binfmt().
+ *     If no handler recognizes the format, execution fails with ENOEXEC.
+ *   expr: binfmt_handler_exists(file)
+ *
+ * constraint: Stack Size Limits
+ *   desc: The combined size of arguments and environment cannot exceed the stack limit.
+ *     The kernel enforces MAX_ARG_STRLEN (32 pages) per string and MAX_ARG_STRINGS total strings.
+ *     Additionally respects RLIMIT_STACK.
+ *   expr: total_size <= min(RLIMIT_STACK/4, MAX_ARG_STRLEN * MAX_ARG_STRINGS)
+ *
+ *
+ * constraint: Process Count Limit
+ *   desc: If RLIMIT_NPROC is exceeded, execution fails with EAGAIN unless the process has
+ *     CAP_SYS_ADMIN or CAP_SYS_RESOURCE capabilities. This prevents fork bombs and resource exhaustion.
+ *   expr: user_processes < RLIMIT_NPROC || CAP_SYS_ADMIN || CAP_SYS_RESOURCE
+ *
+ *
+ * constraint: Setuid/Setgid Execution
+ *   desc: Setuid/setgid bits are honored only if: filesystem is not mounted nosuid,
+ *     file has appropriate bits set, and user namespace allows the mapping.
+ *     AT_SECURE flag is set for security-sensitive transitions.
+ *   expr: !nosuid_mount && (S_ISUID || S_ISGID) && uid_mappable && gid_mappable
+ *
+ *
+ * constraint: Script Interpreter Limits
+ *   desc: Script execution (#! interpreter) has a maximum recursion depth of 4 levels
+ *     to prevent infinite loops. The interpreter line is limited to BINPRM_BUF_SIZE (256) bytes.
+ *   expr: interpreter_depth <= 4 && shebang_len <= BINPRM_BUF_SIZE
+ *
+ *
+ * constraint: Memory Layout Requirements
+ *   desc: The new program requires sufficient virtual memory for code, data, stack, and heap.
+ *     The kernel must be able to set up page tables and allocate initial pages.
+ *     Fails with ENOMEM if insufficient.
+ *   expr: available_memory >= program_requirements
+ *
+ *
+ * constraint: Security Module Checks
+ *   desc: LSM (Linux Security Module) hooks are called at multiple points:
+ *     security_bprm_check(), security_bprm_creds_from_file(),
+ *     security_bprm_committing_creds(), security_bprm_committed_creds().
+ *     Any can deny execution.
+ *   expr: all_lsm_checks_pass()
+ *
+ *
+ * constraint: File Descriptor Preservation
+ *   desc: File descriptors marked FD_CLOEXEC are closed during exec.
+ *     Others remain open in the new program. The AT_EMPTY_PATH flag requires
+ *     the fd to refer to a regular file with execute permission.
+ *   expr: fd_valid && (filename || AT_EMPTY_PATH) && (!FD_CLOEXEC || will_close)
+ *
+ *
+ * constraint: Point of No Return
+ *   desc: Once the point of no return is reached (bprm->point_of_no_return set),
+ *     the exec cannot fail gracefully. Any errors after this point result in
+ *     process termination via force_fatal_sig(SIGSEGV) rather than returning an error to userspace.
+ *   expr: !point_of_no_return || (error => process_terminated)
+ *
+ * examples: execveat(AT_FDCWD, "/bin/ls", argv, envp, 0);  // Execute absolute path
+ *   execveat(dirfd, "bin/ls", argv, envp, 0);    // Execute relative to dirfd
+ *   execveat(fd, "", argv, envp, AT_EMPTY_PATH); // Execute file referenced by fd
+ *   execveat(dirfd, "script", argv, envp, AT_SYMLINK_NOFOLLOW); // Don't follow symlinks
+ *   execveat(AT_FDCWD, "/bin/test", argv, envp, AT_EXECVE_CHECK); // Check if exec would succeed
+ *
+ * notes: execveat() is the most flexible exec variant, allowing execution relative to
+ *   directory file descriptors and direct execution of already-open files. The
+ *   AT_EMPTY_PATH flag enables fexecve()-like behavior. AT_EXECVE_CHECK (since
+ *   Linux 6.12) only checks if execution would be allowed without actually executing,
+ *   returning 0 on success. The function never returns on success (except with
+ *   AT_EXECVE_CHECK) - the calling process image is completely replaced. Use fork() or
+ *   clone() first if you want to preserve the parent process.
+ *
+ *   Security considerations: Check-use race conditions are avoided when AT_EMPTY_PATH
+ *   is used with a pre-opened file descriptor. Setuid/setgid bits may be ignored
+ *   in various circumstances including nosuid mounts, user namespaces without
+ *   mappings, and certain security policies. The dumpability of the process
+ *   may change, affecting ptrace attachability and core dump generation.
+ *
+ *   All threads except the calling thread are terminated. Signal handlers are
+ *   reset but the signal mask is preserved. File descriptors are preserved
+ *   except those marked FD_CLOEXEC. The point of no return is reached during
+ *   binary loading - after this point, errors are fatal to the process.
+ *
+ * since-version: 3.19
+ */
 SYSCALL_DEFINE5(execveat,
 		int, fd, const char __user *, filename,
 		const char __user *const __user *, argv,
-- 
2.50.1


