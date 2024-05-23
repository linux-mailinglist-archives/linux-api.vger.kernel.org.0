Return-Path: <linux-api+bounces-1592-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57E8CDB35
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 22:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D6B237A8
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC49584A4A;
	Thu, 23 May 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PWEQh5uT"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1051535D4;
	Thu, 23 May 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494860; cv=none; b=E5JloG92r+Z5LuMsPDsp1FCD7N8lIRgWppt3dY8pKjA+Nvm25PZmz8s0CkMpaobNi4avcgsUIsGuRXzlscbUAEHGswxXFLZmILq2mPzzGEvi0Y9NPQqO0+ldA2ASwGLPldnx8hd1jr9H7MnAVIk43V3DuUzwAeUSqvNTkGfQjMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494860; c=relaxed/simple;
	bh=Opd2bSlYcIyMBwk1KoGA72+CQf9BDRA2NiY+NSNklQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQVJzZgyqpd/j39Sc88dvfi2xQqF3sJo462/afFWvRwE/153qdkgVTpH5CGz0tmH5nMEbkBzA3uSIl6AdZGjemgQdkEFEO7mXZ7E3u0GjOBsvTqfnlnrI/9FkhCeruIwP6A88uAgViVMCClRbBMHyRNAdGl+WHoM6Eg04Lfd3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PWEQh5uT; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dGvuPgGsg0VxczO9LN+XhOWYu9n5IUtz1G620Nf/Nuk=; b=PWEQh5uThVxdrbuQH4ohp4U9R8
	gnq4XROotBE3zo3BSuC2NAqC1tvDbOXX8B+8HgaoDEKshIodHRP9L/bWiHPhEF7j4d/c4p+9EMaqm
	Ed27V8n7UYu32NgVaoYbaiyZ/JQuxnJnXzSU5c/2oJNanXl4zZqjkBrVT31WHxJe4rb2v6SVZGgRX
	4e8AIEdeySt/Ec28+DTslnjz6yWOYt0L7cY4uuxQHJc8nJ9VBbCknW72msAaYvWPMbKF3XXm1x1A1
	j4Xv4yiEO2RdSwdZ+C0/wWxDfAZvzMzRL5Zw2LIH1vrNZcunF+K4/Tu4qJ7kiv6RIB6NF7P3mfNxM
	j3AQWYfQ==;
Received: from [191.8.29.37] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sAEig-00BhS0-Oi; Thu, 23 May 2024 22:07:23 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	"Boqun Feng" <boqun.feng@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Paul Turner" <pjt@google.com>,
	linux-api@vger.kernel.org,
	"Christian Brauner" <brauner@kernel.org>,
	"Florian Weimer" <fw@deneb.enyo.de>,
	David.Laight@ACULAB.COM,
	carlos@redhat.com,
	"Peter Oskolkov" <posk@posk.io>,
	"Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
	"Chris Kennelly" <ckennelly@google.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Darren Hart" <dvhart@infradead.org>,
	"Davidlohr Bueso" <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	libc-alpha@sourceware.org,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Noah Goldstein" <goldstein.w.n@gmail.com>,
	"Daniel Colascione" <dancol@google.com>,
	longman@redhat.com,
	kernel-dev@igalia.com
Subject: [PATCH v2 1/1] futex: Add FUTEX_SPIN operation
Date: Thu, 23 May 2024 17:07:04 -0300
Message-ID: <20240523200704.281514-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523200704.281514-1-andrealmeid@igalia.com>
References: <20240523200704.281514-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new mode for futex wait, the futex spin.

Given the FUTEX2_SPIN flag, parse the futex value as the TID of the lock
owner. Then, before going to the normal wait path, spins while the lock
owner is running in a different CPU, to avoid the whole context switch
operation and to quickly return to userspace. If the lock owner is not
running, just sleep as the normal futex wait path.

The user value is masked with FUTEX_TID_MASK, to allow some bits for
future use.

The check for the owner to be running or not is important to avoid
spinning for something that won't be released quickly. Userspace is
responsible on providing the proper TID, the kernel does a basic check.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/uapi/linux/futex.h |  2 +-
 kernel/futex/futex.h       |  6 ++-
 kernel/futex/waitwake.c    | 78 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index d2ee625ea189..d77d692ffac2 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -63,7 +63,7 @@
 #define FUTEX2_SIZE_U32		0x02
 #define FUTEX2_SIZE_U64		0x03
 #define FUTEX2_NUMA		0x04
-			/*	0x08 */
+#define FUTEX2_SPIN		0x08
 			/*	0x10 */
 			/*	0x20 */
 			/*	0x40 */
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 8b195d06f4e8..180c1c10dc81 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -37,6 +37,7 @@
 #define FLAGS_HAS_TIMEOUT	0x0040
 #define FLAGS_NUMA		0x0080
 #define FLAGS_STRICT		0x0100
+#define FLAGS_SPIN		0x0200
 
 /* FUTEX_ to FLAGS_ */
 static inline unsigned int futex_to_flags(unsigned int op)
@@ -52,7 +53,7 @@ static inline unsigned int futex_to_flags(unsigned int op)
 	return flags;
 }
 
-#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE | FUTEX2_SPIN)
 
 /* FUTEX2_ to FLAGS_ */
 static inline unsigned int futex2_to_flags(unsigned int flags2)
@@ -65,6 +66,9 @@ static inline unsigned int futex2_to_flags(unsigned int flags2)
 	if (flags2 & FUTEX2_NUMA)
 		flags |= FLAGS_NUMA;
 
+	if (flags2 & FUTEX2_SPIN)
+		flags |= FLAGS_SPIN;
+
 	return flags;
 }
 
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 3a10375d9521..276c03804b92 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -372,6 +372,73 @@ void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
 	__set_current_state(TASK_RUNNING);
 }
 
+static inline bool task_on_cpu(struct task_struct *p)
+{
+#ifdef CONFIG_SMP
+	return !!(p->on_cpu);
+#else
+	return false;
+#endif
+}
+
+static int futex_spin(struct futex_hash_bucket *hb, struct futex_q *q,
+		       struct hrtimer_sleeper *timeout, u32 uval)
+{
+	struct task_struct *p;
+	pid_t pid = uval & FUTEX_TID_MASK;
+
+	p = find_get_task_by_vpid(pid);
+
+	/* no task found, maybe it already exited */
+	if (!p) {
+		futex_q_unlock(hb);
+		return -EAGAIN;
+	}
+
+	/* can't spin in a kernel task */
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		put_task_struct(p);
+		futex_q_unlock(hb);
+		return -EPERM;
+	}
+
+	futex_queue(q, hb);
+
+	if (timeout)
+		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
+
+	while (1) {
+		if (likely(!plist_node_empty(&q->list))) {
+			if (timeout && !timeout->task)
+				goto exit;
+
+			if (task_on_cpu(p)) {
+				/* spin */
+				continue;
+			} else {
+				/* task is not running, sleep */
+				break;
+			}
+		} else {
+			goto exit;
+		}
+	}
+
+	/* spinning didn't work, go to the normal path */
+	set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+
+	if (likely(!plist_node_empty(&q->list))) {
+		if (!timeout || timeout->task)
+			schedule();
+	}
+
+	__set_current_state(TASK_RUNNING);
+
+exit:
+	put_task_struct(p);
+	return 0;
+}
+
 /**
  * futex_unqueue_multiple - Remove various futexes from their hash bucket
  * @v:	   The list of futexes to unqueue
@@ -665,8 +732,15 @@ int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	if (ret)
 		return ret;
 
-	/* futex_queue and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue(hb, &q, to);
+	if (flags & FLAGS_SPIN) {
+		ret = futex_spin(hb, &q, to, val);
+
+		if (ret)
+			return ret;
+	} else {
+		/* futex_queue and wait for wakeup, timeout, or a signal. */
+		futex_wait_queue(hb, &q, to);
+	}
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	if (!futex_unqueue(&q))
-- 
2.45.1


