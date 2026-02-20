Return-Path: <linux-api+bounces-5866-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KN9HMLDmGl/LwMAu9opvQ
	(envelope-from <linux-api+bounces-5866-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 21:27:46 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A676016A9FE
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 21:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 378E23016906
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED62FF147;
	Fri, 20 Feb 2026 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NszLq8Sj"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED4D2F5A1F;
	Fri, 20 Feb 2026 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619263; cv=none; b=LS4Lm4b6HZE23vXjo4acUGOrxvBLFCle0fG5/cj/F7c8/Qh6aIEzYwAUhhF6qNR2FhzYfu7VLzzx3n1MXAdKc1lLdQ1UAxHEI2QQeNv1NI/VUewnIivO1IC3k9abWOpZU2KfDP1zOaL0eMDwNGp62OEFjg2RGDWAVtVe0NZurxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619263; c=relaxed/simple;
	bh=zQ90A7PhGI/vVQKatiddeLn00Z5zIy+RVunNVR9GD1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YunF4/ufzJogaNt1/SvBER6v6IpKZ1XfG6aMPZcZNwZ8Mxvyi0VuTK5kgC+CYDxNVjmuS2f3VVp7mlSW7yO2zQDWOXxehJ8gnIEz99oah3h2oKhNRJYOMcSY3VvL45Xai6Zol5D/QQBory6SOOB4mD3qUeUkh93uwTnMmbUCYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NszLq8Sj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IniDsBH2iOsUsO3hzLdsQgJJn816ZqQiEcTVLPFvY6o=; b=NszLq8SjJiZuYARE6nJ0AD49TG
	6RvTWqS2bd9SnNzCMpod8tay+TWaXoixUlLKTV9gCzqyG+dWbBmIL+Md/nOq+LEHJZEvQs7l2XFs1
	kqSDsXtmpv9DCPJvVIXztTo/+9qml5jdhzMXRMKZqBlNshVqn4gIm1L9ipLqmYuqgrjWt90p7LuCW
	aYQtreWiTTRQeegD1BhK/w7njav7oSgIUtpJzZkmbagTAA7m5lqnB5dByFXarZCK+GSgzZmEzSuKF
	fPINf/0zQWkq6ZswiL5nRps8RFkdjJ0lHpjNje00uVB4gLCxjQDHgY8q1XCQ0xh6kCIf2FeK/EiqP
	ktsoo62g==;
Received: from [187.57.77.133] (helo=computador)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vtX5H-0036Zi-JX; Fri, 20 Feb 2026 21:26:44 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Carlos O'Donell <carlos@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Rich Felker <dalias@aerifal.cx>,
	Torvald Riegel <triegel@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: kernel-dev@igalia.com,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH 1/2] futex: Create reproducer for robust_list race condition
Date: Fri, 20 Feb 2026 17:26:19 -0300
Message-ID: <20260220202620.139584-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220202620.139584-1-andrealmeid@igalia.com>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5866-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sourceware.org:url,igalia.com:mid,igalia.com:email,list.next:url]
X-Rspamd-Queue-Id: A676016A9FE
X-Rspamd-Action: no action

Create a reproducer for https://sourceware.org/bugzilla/show_bug.cgi?id=14485

This is not supposed to be merged.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 robust_bug.c | 178 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 robust_bug.c

diff --git a/robust_bug.c b/robust_bug.c
new file mode 100644
index 000000000000..1ade4e6d66dd
--- /dev/null
+++ b/robust_bug.c
@@ -0,0 +1,178 @@
+/*
+ *  gcc robust_bug.c -o robust_bug
+ *
+ * This is a reproducer for "File corruption race condition in robust
+ * mutex unlocking" from https://sourceware.org/bugzilla/show_bug.cgi?id=14485
+ *
+ * To increase the changes of reaching the race condition, a delay can be added
+ * to the kernel function handle_futex_death(), just before the user memory
+ * write futex_cmpxchg_value_locked().
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/futex.h>
+#include <pthread.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <time.h>
+
+#define cpu_relax() asm volatile("rep; nop");
+
+/*
+ * This struct is an example of a lock struct, shared between the threads.
+ */
+struct lock_struct {
+	uint32_t 		futex;
+	struct robust_list	list;
+};
+
+static struct lock_struct *lock;
+
+/*
+ * This is the struct that we are going to use to allocate on top of the 
+ * freed memory to observe the race condition.
+ */
+struct another_struct {
+	uint64_t value;
+};
+
+static pthread_barrier_t barrier;
+
+static int set_robust_list(struct robust_list_head *head)
+{
+	return syscall(SYS_set_robust_list, head, sizeof(*head));
+}
+
+/*
+ * This thread emulates the behaviour of a thread releasing a robust mutex:
+ * - It starts by adding the mutex to the op_pending field
+ * - Remove the mutex from the robust list
+ * - Release the lock and wake up waiters
+ * - Remove the mutex from the op_pending field
+ *
+ * However, this thread dies before doing this last step, leaving the mutex
+ * behind in the op_pending field.
+ */
+void *func_b(void *arg)
+{
+	static struct robust_list_head head;
+	pid_t tid = gettid() | FUTEX_WAITERS;
+
+	/*
+	 * Initial thread setup. This would happen in an earlier stage of the
+	 * thread execution.
+	 */
+	set_robust_list(&head);
+	head.list.next = &head.list;
+	head.futex_offset = (size_t) offsetof(struct lock_struct, futex) -
+		(size_t) offsetof(struct lock_struct, list);
+
+	/* This thread takes the lock... */
+	lock->futex = tid;
+
+	/* ...would do some work here... */
+
+	/*
+	 * ...and starts the release process. Adds the mutex to be released on
+	 * the op_pending.
+	 */
+	head.list_op_pending = &lock->list;
+
+	/* Barrier to synchronize thread B taking the lock */
+	pthread_barrier_wait(&barrier);
+	usleep(100);
+
+	/*
+	 * Here we would release the lock and wake up any waiters.
+	 *
+	 * lock->futex = LOCK_FREE;
+	 * futex_wake(lock->futex, 1);
+	 */
+
+	/*
+	 * We would remove the lock from op_pending, but we emulate a thread
+	 * exiting before doing it.
+	 */
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	struct another_struct *new;
+	uint64_t original_val;
+	pthread_t thread_b;
+	uint32_t value;
+	int ret;
+
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	if (ret) {
+		puts("pthread_barrier_init failed");
+		return -1;
+	}
+
+	/* Initialize the lock */
+	lock = mmap(NULL, sizeof(struct lock_struct), PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (lock == MAP_FAILED) {
+		puts("mmap failed");
+		return -1;
+	}
+	memset(lock, 0, sizeof(*lock));
+
+	/* Create the thread B that will take the lock */
+	pthread_create(&thread_b, NULL, func_b, NULL);
+
+	/* Barrier to synchronize thread B taking the lock */
+	pthread_barrier_wait(&barrier);
+
+	/* Copy this value as we will use it later */
+	value = lock->futex;
+
+	/*
+	 * Here, this thread would do the following:
+	 * - It would wait for the lock, and be wake from thread B
+	 * - Take the lock, do some work, and release it
+	 * - After releasing the lock and being the last user, it can correctly
+	 *   free it
+	 */
+	munmap(lock, sizeof(struct lock_struct));
+
+	/*
+	 * After freeing the lock, this thread allocates memory, which
+	 * happens to be at the same address of the lock, and by chance, it fills
+	 * the memory with the TID of thread B.
+	 */
+	new = mmap(NULL, sizeof(struct another_struct), PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (new == MAP_FAILED) {
+		puts("mmap failed");
+		return -1;
+	}
+	if ((uintptr_t) lock != (uintptr_t) new) {
+		puts("mmap got a different address");
+		return -1;
+	}
+
+	new->value = ((uint64_t) value << 32) + value;
+
+	/* Create a backup of the current value */
+	original_val = new->value;
+
+	/* Wait for the memory corruption to happen... */	
+	while (new->value == original_val)
+		cpu_relax();
+
+	/* ...and now the kernel just overwrote an unrelated user memory! */
+	printf("Memory was corrupted by the kernel: %lx vs %lx\n",
+		original_val, new->value);
+
+	munmap(new, sizeof(struct another_struct));
+
+	return 0;
+}
-- 
2.53.0


