Return-Path: <linux-api+bounces-6340-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFUMMvsKCmouwQQAu9opvQ
	(envelope-from <linux-api+bounces-6340-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2026 20:37:47 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2215632F6
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2026 20:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35DB9301D4CD
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2026 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422B3CFF4F;
	Sun, 17 May 2026 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VOnrAJZI"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA313B52E2;
	Sun, 17 May 2026 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043044; cv=none; b=ttZTkltvAEL3sb0QDITmXlZku8pE76Z9XQN0q1mFPFf4cTXqZmYTUF209hHVYlbZLysAKfo10JXk7CtBBn2bCjwrxqI09KjVfM7AiUiO55J5i2udYgJwNeKtRAhVPeCgVaaJdyXRDa8Kr5BMuvKYUUzeFLRs4JuHpJShUajCcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043044; c=relaxed/simple;
	bh=kVodm9LMpgNVXUQFAY7Q3oZjOCA1cRri8mhLSWd3dyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZ/bOz+usgGznJHSPOyRAw9VJKaQ75MZvmKxBixwRcKQ3qHEfRkzBnk6cWpf4s6j5BzhzlBMc0ltSOyKQeWKq0K8gOrlFOsgeRWFXHPuMNL2WWtRcWTosOBwiztm4Oe8Lb3Jl6XzuL+C1B9Nrz6ndXBE1NKkT5X/K+vtsP4igYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VOnrAJZI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FlZNLnmdjy9yDSd4c5nakFinf3LBKF7+LBofFSSFz3c=; b=VOnrAJZIgoRLkq2fAPAElAvtiJ
	JeJ6mawddx1kS/5cPoKOGKqIGPwEU7FEqDzbRA6QuA5rXEEhIglPbneNMiCJcRl12izuzUPtPmvYg
	uMwSm5hniWPk5YG9ReKCtWrMBVQbp9C6PWBOFfJx+3rujwocoKc2g06QFth0yWIN5xWBrKH7YG5Af
	gta3qWW401sVs6tMH+HUT9mL/peYi+jSBbwHKiDLfMZyeFP4fCp2iA19jlRRlmgZK93iDKGMbYDyv
	ZfUsscH9L8XOyNqdvoLWDoaMCmvj+4YWnrdPDfbnz1Kp5YpV5jbxyVe2xJmDldy1xlJBhqtMI8iaJ
	YZTA2Hkg==;
Received: from [179.193.2.40] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wOgMJ-001cLz-Kp; Sun, 17 May 2026 20:37:03 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 17 May 2026 15:36:13 -0300
Subject: [PATCH 3/6] string: Introduce strtostr() for safe and performance
 string copies
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-tonyk-long_name-v1-3-3c282eaa91e2@igalia.com>
References: <20260517-tonyk-long_name-v1-0-3c282eaa91e2@igalia.com>
In-Reply-To: <20260517-tonyk-long_name-v1-0-3c282eaa91e2@igalia.com>
To: Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, willy@infradead.org, 
 mathieu.desnoyers@efficios.com, David Laight <david.laight.linux@gmail.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, 
 Yafang Shao <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com, 
 arnaldo.melo@gmail.com, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, kernel-dev@igalia.com, linux-mm@kvack.org, 
 linux-api@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 4E2215632F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6340-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,gmail.com,linux-foundation.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Some parts of the kernel uses memcpy() instead of strscpy() because they
are performance sensitive and doesn't care about the return value of
strscpy(). One such common case is to copy current->comm to a different
buffer.

As the command name is guaranteed to be NUL-terminated in the range of
TASK_COMM_LEN, this is safe enough and doesn't create unterminated
strings. However, in order to expand the size of current->comm, this
expectation will be broken and those memcpy() could create such strings
without trailing NUL byte.

In order to support a fast and safe string copy, create strtostr(), to copy
a NUL-terminated string to a new string buffer. If the destination buffer
is bigger than the source, no pad is applied, but the string is
NUL-terminated. If the destination buffer is smaller, the string is
truncated. The last byte of the destination is always set to NUL for safety.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/coredump.h                           |  2 +-
 include/linux/string.h                             | 28 ++++++++++++++++++++++
 include/linux/tracepoint.h                         |  4 ++--
 include/trace/events/block.h                       | 10 ++++----
 include/trace/events/coredump.h                    |  2 +-
 include/trace/events/f2fs.h                        |  4 ++--
 include/trace/events/oom.h                         |  2 +-
 include/trace/events/osnoise.h                     |  2 +-
 include/trace/events/sched.h                       | 10 ++++----
 include/trace/events/signal.h                      |  2 +-
 include/trace/events/task.h                        |  4 ++--
 kernel/printk/nbcon.c                              |  2 +-
 kernel/printk/printk.c                             |  2 +-
 tools/bpf/bpftool/pids.c                           |  4 ++--
 .../selftests/bpf/test_kmods/bpf_testmod-events.h  |  2 +-
 15 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 68861da4cf7c..b370ef69f673 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -54,7 +54,7 @@ extern void vfs_coredump(const kernel_siginfo_t *siginfo);
 	do {	\
 		char comm[TASK_COMM_LEN];	\
 		/* This will always be NUL terminated. */ \
-		memcpy(comm, current->comm, sizeof(comm)); \
+		strtostr(comm, current->comm); \
 		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
 			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
 	} while (0)	\
diff --git a/include/linux/string.h b/include/linux/string.h
index b850bd91b3d8..ff1f59f4139c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -445,6 +445,34 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
 	memcpy(dest, src, strnlen(src, min(_src_len, _dest_len)));	\
 } while (0)
 
+/**
+ * strtostr - Copy NUL-terminanted string to NUL-terminate string
+ *
+ * @dest: Pointer of destination string
+ * @src: Pointer to NUL-terminates string
+ *
+ * This is a replacement for strcpy() where the caller doesn't care about the
+ * return value and if the string is going to be truncated, albeit it needs
+ * to mark sure that it will be NUL-terminated. Intended for performance
+ * sensitive cases, such as tracing.
+ *
+ * If the destination is bigger than the source, no padding happens. It it's
+ * smaller the strings gets truncated.
+ *
+ * Both arguments needs to be arrays with lengths discoverable by the compiler.
+ */
+#define strtostr(dest, src)	do {					\
+	const size_t _dest_len = __must_be_cstr(dest) +			\
+				 ARRAY_SIZE(dest);			\
+	const size_t _src_len = __must_be_cstr(src) +			\
+				__builtin_object_size(src, 1);		\
+									\
+	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
+		     _dest_len == (size_t)-1);				\
+	memcpy(dest, src, strnlen(src, min(_src_len, _dest_len)));	\
+	dest[_dest_len - 1] = '\0';						\
+} while (0)
+
 /**
  * memtostr - Copy a possibly non-NUL-term string to a NUL-term string
  * @dest: Pointer to destination NUL-terminates string
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 763eea4d80d8..19e3cb4ca487 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -615,10 +615,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  *	*
  *
  *	TP_fast_assign(
- *		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+ *		strtostr(__entry->next_comm, next->comm);
  *		__entry->prev_pid	= prev->pid;
  *		__entry->prev_prio	= prev->prio;
- *		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+ *		strtostr(__entry->prev_comm, prev->comm);
  *		__entry->next_pid	= next->pid;
  *		__entry->next_prio	= next->prio;
  *	),
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 6aa79e2d799c..779622cadee3 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -213,7 +213,7 @@ DECLARE_EVENT_CLASS(block_rq,
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, current->comm);
 	),
 
 	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u,%u [%s]",
@@ -351,7 +351,7 @@ DECLARE_EVENT_CLASS(block_bio,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, current->comm);
 	),
 
 	TP_printk("%d,%d %s %llu + %u [%s]",
@@ -434,7 +434,7 @@ TRACE_EVENT(block_plug,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, current->comm);
 	),
 
 	TP_printk("[%s]", __entry->comm)
@@ -453,7 +453,7 @@ DECLARE_EVENT_CLASS(block_unplug,
 
 	TP_fast_assign(
 		__entry->nr_rq = depth;
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, current->comm);
 	),
 
 	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
@@ -504,7 +504,7 @@ TRACE_EVENT(block_split,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->new_sector	= new_sector;
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, current->comm);
 	),
 
 	TP_printk("%d,%d %s %llu / %llu [%s]",
diff --git a/include/trace/events/coredump.h b/include/trace/events/coredump.h
index c7b9c53fc498..581768a122f8 100644
--- a/include/trace/events/coredump.h
+++ b/include/trace/events/coredump.h
@@ -32,7 +32,7 @@ TRACE_EVENT(coredump,
 
 	TP_fast_assign(
 		__entry->sig = sig;
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, current->comm);
 	),
 
 	TP_printk("sig=%d comm=%s",
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index b5188d2671d7..cc1fd1e01541 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2505,7 +2505,7 @@ TRACE_EVENT(f2fs_lock_elapsed_time,
 
 	TP_fast_assign(
 		__entry->dev		= sbi->sb->s_dev;
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, p->comm);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio;
 		__entry->ioprio_class	= IOPRIO_PRIO_CLASS(ioprio);
@@ -2558,7 +2558,7 @@ DECLARE_EVENT_CLASS(f2fs_priority_update,
 
 	TP_fast_assign(
 		__entry->dev		= sbi->sb->s_dev;
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, p->comm);
 		__entry->pid		= p->pid;
 		__entry->lock_name	= lock_name;
 		__entry->is_write	= is_write;
diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 9f0a5d1482c4..61b66928de4d 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -23,7 +23,7 @@ TRACE_EVENT(oom_score_adj_update,
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, task->comm);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index 3f4273623801..26e42fd1a084 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -116,7 +116,7 @@ TRACE_EVENT(thread_noise,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, t->comm);
 		__entry->pid = t->pid;
 		__entry->start = start;
 		__entry->duration = duration;
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 535860581f15..91bc5931e2a3 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -152,7 +152,7 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, p->comm);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->target_cpu	= task_cpu(p);
@@ -237,11 +237,11 @@ TRACE_EVENT(sched_switch,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+		strtostr(__entry->prev_comm, prev->comm);
 		__entry->prev_pid	= prev->pid;
 		__entry->prev_prio	= prev->prio;
 		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
-		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		strtostr(__entry->next_comm, next->comm);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
 		/* XXX SCHED_DEADLINE */
@@ -346,7 +346,7 @@ TRACE_EVENT(sched_process_exit,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, p->comm);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->group_dead	= group_dead;
@@ -787,7 +787,7 @@ TRACE_EVENT(sched_skip_cpuset_numa,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, tsk->comm);
 		__entry->pid		 = task_pid_nr(tsk);
 		__entry->tgid		 = task_tgid_nr(tsk);
 		__entry->ngid		 = task_numa_group_id(tsk);
diff --git a/include/trace/events/signal.h b/include/trace/events/signal.h
index 1db7e4b07c01..8759078b0da9 100644
--- a/include/trace/events/signal.h
+++ b/include/trace/events/signal.h
@@ -67,7 +67,7 @@ TRACE_EVENT(signal_generate,
 	TP_fast_assign(
 		__entry->sig	= sig;
 		TP_STORE_SIGINFO(__entry, info);
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, task->comm);
 		__entry->pid	= task->pid;
 		__entry->group	= group;
 		__entry->result	= result;
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index b9a129eb54d9..8636ead17cd8 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -21,7 +21,7 @@ TRACE_EVENT(task_newtask,
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, task->comm);
 		__entry->clone_flags = clone_flags;
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
@@ -46,7 +46,7 @@ TRACE_EVENT(task_rename,
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
+		strtostr(entry->oldcomm, task->comm);
 		strscpy(entry->newcomm, comm, TASK_COMM_LEN);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d7044a7a214b..5b0c54082876 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -952,7 +952,7 @@ static void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
 {
 	wctxt->cpu = pmsg->cpu;
 	wctxt->pid = pmsg->pid;
-	memcpy(wctxt->comm, pmsg->comm, sizeof(wctxt->comm));
+	strtostr(wctxt->comm, pmsg->comm);
 	static_assert(sizeof(wctxt->comm) == sizeof(pmsg->comm));
 }
 #else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1f04e753ca02..231c4d7c3580 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2255,7 +2255,7 @@ static void pmsg_load_execution_ctx(struct printk_message *pmsg,
 {
 	pmsg->cpu = printk_info_get_cpu(info);
 	pmsg->pid = printk_info_get_pid(info);
-	memcpy(pmsg->comm, info->comm, sizeof(pmsg->comm));
+	strtostr(pmsg->comm, info->comm);
 	static_assert(sizeof(pmsg->comm) == sizeof(info->comm));
 }
 #else
diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 23f488cf1740..46b62f65dc43 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -53,7 +53,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 		refs->refs = tmp;
 		ref = &refs->refs[refs->ref_cnt];
 		ref->pid = e->pid;
-		memcpy(ref->comm, e->comm, sizeof(ref->comm));
+		strtostr(ref->comm, e->comm);
 		ref->comm[sizeof(ref->comm) - 1] = '\0';
 		refs->ref_cnt++;
 
@@ -77,7 +77,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	}
 	ref = &refs->refs[0];
 	ref->pid = e->pid;
-	memcpy(ref->comm, e->comm, sizeof(ref->comm));
+	strtostr(ref->comm, e->comm);
 	ref->comm[sizeof(ref->comm) - 1] = '\0';
 	refs->ref_cnt = 1;
 	refs->has_bpf_cookie = e->has_bpf_cookie;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
index 45a5e41f3a92..72c865ccf1b5 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
@@ -20,7 +20,7 @@ TRACE_EVENT(bpf_testmod_test_read,
 	),
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		strtostr(__entry->comm, task->comm);
 		__entry->off = ctx->off;
 		__entry->len = ctx->len;
 	),

-- 
2.54.0


