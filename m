Return-Path: <linux-api+bounces-6338-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBheAuoLCmouwQQAu9opvQ
	(envelope-from <linux-api+bounces-6338-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2026 20:41:46 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3DB5634AA
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2026 20:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 175D530580BA
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2026 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0533CF66A;
	Sun, 17 May 2026 18:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jYvt3RcS"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657563CEB84;
	Sun, 17 May 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043043; cv=none; b=lQVE0xQTunFX/N3SgRk89jwMgBZxPFs76sXORfojKqxgEn6+hUQSoo8PSCjwnV5ymjfz2CM0/3ltUGBGKBJAgB0i9FMHiU2AHiC9SIvtVRXNDYFmJDTVxySsw+17QNAfXJI8q5FqeBVXPn7kbV6QE9hsDa9pFgmYoYwLKx1LuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043043; c=relaxed/simple;
	bh=wTGET38CD6COu11C+GfxiQLuwWdWIja53YJgU+fO9Ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhLZCM0sxbWZTSkt737Wp0KxlH0JHYjUfBu1UXLQl5ACIpt0o+2TMVRzMNhsShCnKAnWTEc21ikv8ooCerOrbDQGXC/XCbalB6Nj0NZ8kp8ytv9oxBbAgXvArhFYlxGpainAm4+r2SsE1cR73vigv0qg6MMubHFF/ecVgHsXE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jYvt3RcS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mTm1itVUL5+eVJJJDMx7jNDUCkEzXL7A51fiJoig9I0=; b=jYvt3RcSvTnOoaO46YZIWqLtZF
	Jcaxk+Y3HCUWarNvWwQkb8inBe04XwyaEGiIfRRWaixV2Dx3bB1jMlqZ9U51R0GMy34P+je5ttt1K
	VeJfYi+cko+AAe3cf0tyRHwknRu/DoL0gkfGbJETg5b0uY6UK+YS77bswwr8MHXhBmYLMh32NJ0Hg
	fzg+1dHm0WfdsBWDjKvKNUlodpVKNPmBy35FgnxDAdU2dkIJ49doxNfgZrS0/drvfaAVqw/qq5uUs
	7kcAV2HUdxLB5bIWuk2olWe+etvVOG2We+PCCQ+1OoOHjsRzOsFkSIinTPmLfJRlga5TSwI24TG4n
	LOUus7LQ==;
Received: from [179.193.2.40] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wOgMP-001cLz-0b; Sun, 17 May 2026 20:37:09 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 17 May 2026 15:36:14 -0300
Subject: [PATCH 4/6] sched: Extend task command name to 64 bytes
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-tonyk-long_name-v1-4-3c282eaa91e2@igalia.com>
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
 linux-api@vger.kernel.org, Bhupesh <bhupesh@igalia.com>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 9A3DB5634AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6338-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,gmail.com,linux-foundation.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.931];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email,igalia.com:mid]
X-Rspamd-Action: no action

Command name has been restrict to only 16 bytes, which is too limiting,
specially when debugging and tracing complex software with thousands of
threads and the need to differentiate them.

Just as it was done with kthreads in commit 6b59808bfe48 ("workqueue:
Show the latest workqueue name in /proc/PID/{comm,stat,status}"), support
long names for userspace threads as well.

To avoid buffer overflows, cap all existing userspace APIs to
TASK_COMM_LEN, and leave the full extended name for a new interface.

Co-developed-by: Bhupesh <bhupesh@igalia.com>
Signed-off-by: Bhupesh <bhupesh@igalia.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/proc/array.c       |  2 +-
 include/linux/sched.h |  3 ++-
 kernel/sys.c          | 10 +++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index c8c3fbd9bfa9..312371eddc7f 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -110,7 +110,7 @@ void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 	else if (p->flags & PF_KTHREAD)
 		get_kthread_comm(tcomm, sizeof(tcomm), p);
 	else
-		strscpy_pad(tcomm, p->comm);
+		strscpy_pad(tcomm, p->comm, TASK_COMM_LEN);
 
 	if (escape)
 		seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b6de742b1155..f7fd2b7d131d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -323,6 +323,7 @@ struct user_event_mm;
  */
 enum {
 	TASK_COMM_LEN = 16,
+	TASK_COMM_EXT_LEN = 64,
 };
 
 extern void sched_tick(void);
@@ -1167,7 +1168,7 @@ struct task_struct {
 	 * - set it with set_task_comm() to ensure it is always
 	 *   NUL-terminated and zero-padded
 	 */
-	char				comm[TASK_COMM_LEN];
+	char				comm[TASK_COMM_EXT_LEN];
 
 	struct nameidata		*nameidata;
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 1d5152d2395e..76d77218ab19 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2535,7 +2535,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
 	struct task_struct *me = current;
-	unsigned char comm[sizeof(me->comm)];
+	unsigned char comm[TASK_COMM_LEN];
 	long error;
 
 	error = security_task_prctl(option, arg2, arg3, arg4, arg5);
@@ -2601,16 +2601,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = -EINVAL;
 		break;
 	case PR_SET_NAME:
-		comm[sizeof(me->comm) - 1] = 0;
+		comm[TASK_COMM_LEN - 1] = 0;
 		if (strncpy_from_user(comm, (char __user *)arg2,
-				      sizeof(me->comm) - 1) < 0)
+				      TASK_COMM_LEN - 1) < 0)
 			return -EFAULT;
 		set_task_comm(me, comm);
 		proc_comm_connector(me);
 		break;
 	case PR_GET_NAME:
-		strscpy_pad(comm, me->comm);
-		if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
+		strscpy_pad(comm, me->comm, TASK_COMM_LEN);
+		if (copy_to_user((char __user *)arg2, comm, TASK_COMM_LEN))
 			return -EFAULT;
 		break;
 	case PR_GET_ENDIAN:

-- 
2.54.0


