Return-Path: <linux-api+bounces-589-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A70AA839DD2
	for <lists+linux-api@lfdr.de>; Wed, 24 Jan 2024 01:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FEA6B284E8
	for <lists+linux-api@lfdr.de>; Wed, 24 Jan 2024 00:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D990E15C4;
	Wed, 24 Jan 2024 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="IOGSE3p/"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E24C78;
	Wed, 24 Jan 2024 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057923; cv=none; b=LLkN7N6cpP9SLBFcfqKIHq1H8uL3md/oU6+jyw0tsJcEHNUBsDkE3aaVpUalEllKBqpD5/wnfw+MQnVBP0PEW6jc0/q6fyF+8stYZ+kXXMUdCX56rXGLqFeYMXDYK4s2dvGBbrgZyIbhzsviwu6SEqJXskDKjJ/65akS15ATS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057923; c=relaxed/simple;
	bh=1PoVRiq9uKUZYi4V4WUdlXLfdCr9s7ZAFXEMf3qda60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqMTpBG4vBiYv2VSrq9/4rEOTRsTOLuWi76IOeB9raTjAsP/+lpOGu9r39Yi28Q769gMDK9VqN3zc5OHOAqQ6WWkYvF0O0YcL+NrWJscLdkVIu04rxgunoh43n5/h8xkkWtXGUtTjiKt8dEU8KeWoYp5pgPgxvEGmBXwowVE7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=IOGSE3p/; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=eSHiOwdmwzGTK6aa3cqA4OMSW9jJsH6a23aKWFD9RUA=; b=IOGSE3p/uwf8X4MRPFrVuy34OR
	cTV/tLiFcYvqZeHWDkMeqpUGvvx5/ky+lA0R0TKqJLaS0PeE4naC6KBL1CiZeRTHq4neTCD0UKDt7
	WzQKS452lpelJ9FjFLrUOVdQdvlWdeVJM7b6ci5MxmP5kYhyECzKWtfJB2SHWgB4AzHwQXWtgE6Z9
	lIArIn0hJaQj37MG6sw3ovRCXeZulQulb+NWCs7LqcYj4tmjezvqDqKrxaEr0fged4vmbJnVvNX9F
	BIc22vz1k9kPmSoo9g+opjIkzzVlxDLLmF1F9k8b65TjLXuzqNzyrOjRzOsL6ajra7ZUIxpIm2aiZ
	KFJT1wrQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSRLB-00DVeW-2e;
	Tue, 23 Jan 2024 18:42:05 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [RFC PATCH 5/9] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Date: Tue, 23 Jan 2024 18:40:24 -0600
Message-ID: <20240124004028.16826-6-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124004028.16826-1-zfigura@codeweavers.com>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corresponds to part of the functionality of the NT syscall
NtWaitForMultipleObjects(). Specifically, it implements the behaviour where
the third argument (wait_any) is TRUE, and it does not handle alertable waits.
Those features have been split out into separate patches to ease review.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 229 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  13 ++
 2 files changed, 242 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index d1c91c2a4f1a..2e8d3c2d51a4 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -23,6 +23,8 @@ struct ntsync_obj {
 	struct kref refcount;
 	spinlock_t lock;
 
+	struct list_head any_waiters;
+
 	enum ntsync_type type;
 
 	/* The following fields are protected by the object lock. */
@@ -34,6 +36,28 @@ struct ntsync_obj {
 	} u;
 };
 
+struct ntsync_q_entry {
+	struct list_head node;
+	struct ntsync_q *q;
+	struct ntsync_obj *obj;
+	__u32 index;
+};
+
+struct ntsync_q {
+	struct task_struct *task;
+	__u32 owner;
+
+	/*
+	 * Protected via atomic_cmpxchg(). Only the thread that wins the
+	 * compare-and-swap may actually change object states and wake this
+	 * task.
+	 */
+	atomic_t signaled;
+
+	__u32 count;
+	struct ntsync_q_entry entries[];
+};
+
 struct ntsync_device {
 	struct xarray objects;
 };
@@ -109,6 +133,26 @@ static void init_obj(struct ntsync_obj *obj)
 {
 	kref_init(&obj->refcount);
 	spin_lock_init(&obj->lock);
+	INIT_LIST_HEAD(&obj->any_waiters);
+}
+
+static void try_wake_any_sem(struct ntsync_obj *sem)
+{
+	struct ntsync_q_entry *entry;
+
+	lockdep_assert_held(&sem->lock);
+
+	list_for_each_entry(entry, &sem->any_waiters, node) {
+		struct ntsync_q *q = entry->q;
+
+		if (!sem->u.sem.count)
+			break;
+
+		if (atomic_cmpxchg(&q->signaled, -1, entry->index) == -1) {
+			sem->u.sem.count--;
+			wake_up_process(q->task);
+		}
+	}
 }
 
 static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
@@ -194,6 +238,8 @@ static int ntsync_put_sem(struct ntsync_device *dev, void __user *argp)
 
 	prev_count = sem->u.sem.count;
 	ret = put_sem_state(sem, args.count);
+	if (!ret)
+		try_wake_any_sem(sem);
 
 	spin_unlock(&sem->lock);
 
@@ -205,6 +251,187 @@ static int ntsync_put_sem(struct ntsync_device *dev, void __user *argp)
 	return ret;
 }
 
+static int ntsync_schedule(const struct ntsync_q *q, ktime_t *timeout)
+{
+	int ret = 0;
+
+	do {
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (atomic_read(&q->signaled) != -1) {
+			ret = 0;
+			break;
+		}
+		ret = schedule_hrtimeout(timeout, HRTIMER_MODE_ABS);
+	} while (ret < 0);
+	__set_current_state(TASK_RUNNING);
+
+	return ret;
+}
+
+/*
+ * Allocate and initialize the ntsync_q structure, but do not queue us yet.
+ * Also, calculate the relative timeout.
+ */
+static int setup_wait(struct ntsync_device *dev,
+		      const struct ntsync_wait_args *args,
+		      ktime_t *ret_timeout, struct ntsync_q **ret_q)
+{
+	const __u32 count = args->count;
+	struct ntsync_q *q;
+	ktime_t timeout = 0;
+	__u32 *ids;
+	__u32 i, j;
+
+	if (!args->owner || args->pad)
+		return -EINVAL;
+
+	if (args->count > NTSYNC_MAX_WAIT_COUNT)
+		return -EINVAL;
+
+	if (args->timeout) {
+		struct timespec64 to;
+
+		if (get_timespec64(&to, u64_to_user_ptr(args->timeout)))
+			return -EFAULT;
+		if (!timespec64_valid(&to))
+			return -EINVAL;
+
+		timeout = timespec64_to_ns(&to);
+	}
+
+	ids = kmalloc_array(count, sizeof(*ids), GFP_KERNEL);
+	if (!ids)
+		return -ENOMEM;
+	if (copy_from_user(ids, u64_to_user_ptr(args->objs),
+			   array_size(count, sizeof(*ids)))) {
+		kfree(ids);
+		return -EFAULT;
+	}
+
+	q = kmalloc(struct_size(q, entries, count), GFP_KERNEL);
+	if (!q) {
+		kfree(ids);
+		return -ENOMEM;
+	}
+	q->task = current;
+	q->owner = args->owner;
+	atomic_set(&q->signaled, -1);
+	q->count = count;
+
+	for (i = 0; i < count; i++) {
+		struct ntsync_q_entry *entry = &q->entries[i];
+		struct ntsync_obj *obj = get_obj(dev, ids[i]);
+
+		if (!obj)
+			goto err;
+
+		entry->obj = obj;
+		entry->q = q;
+		entry->index = i;
+	}
+
+	kfree(ids);
+
+	*ret_q = q;
+	*ret_timeout = timeout;
+	return 0;
+
+err:
+	for (j = 0; j < i; j++)
+		put_obj(q->entries[j].obj);
+	kfree(ids);
+	kfree(q);
+	return -EINVAL;
+}
+
+static void try_wake_any_obj(struct ntsync_obj *obj)
+{
+	switch (obj->type) {
+	case NTSYNC_TYPE_SEM:
+		try_wake_any_sem(obj);
+		break;
+	}
+}
+
+static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_wait_args args;
+	struct ntsync_q *q;
+	ktime_t timeout;
+	int signaled;
+	__u32 i;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	ret = setup_wait(dev, &args, &timeout, &q);
+	if (ret < 0)
+		return ret;
+
+	/* queue ourselves */
+
+	for (i = 0; i < args.count; i++) {
+		struct ntsync_q_entry *entry = &q->entries[i];
+		struct ntsync_obj *obj = entry->obj;
+
+		spin_lock(&obj->lock);
+		list_add_tail(&entry->node, &obj->any_waiters);
+		spin_unlock(&obj->lock);
+	}
+
+	/* check if we are already signaled */
+
+	for (i = 0; i < args.count; i++) {
+		struct ntsync_obj *obj = q->entries[i].obj;
+
+		if (atomic_read(&q->signaled) != -1)
+			break;
+
+		spin_lock(&obj->lock);
+		try_wake_any_obj(obj);
+		spin_unlock(&obj->lock);
+	}
+
+	/* sleep */
+
+	ret = ntsync_schedule(q, args.timeout ? &timeout : NULL);
+
+	/* and finally, unqueue */
+
+	for (i = 0; i < args.count; i++) {
+		struct ntsync_q_entry *entry = &q->entries[i];
+		struct ntsync_obj *obj = entry->obj;
+
+		spin_lock(&obj->lock);
+		list_del(&entry->node);
+		spin_unlock(&obj->lock);
+
+		put_obj(obj);
+	}
+
+	signaled = atomic_read(&q->signaled);
+	if (signaled != -1) {
+		struct ntsync_wait_args __user *user_args = argp;
+
+		/* even if we caught a signal, we need to communicate success */
+		ret = 0;
+
+		if (put_user(signaled, &user_args->index))
+			ret = -EFAULT;
+	} else if (!ret) {
+		ret = -ETIMEDOUT;
+	}
+
+	kfree(q);
+	return ret;
+}
+
 static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long parm)
 {
@@ -218,6 +445,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_delete(dev, argp);
 	case NTSYNC_IOC_PUT_SEM:
 		return ntsync_put_sem(dev, argp);
+	case NTSYNC_IOC_WAIT_ANY:
+		return ntsync_wait_any(dev, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 8c610d65f8ef..10f07da7864e 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -16,6 +16,17 @@ struct ntsync_sem_args {
 	__u32 max;
 };
 
+struct ntsync_wait_args {
+	__u64 timeout;
+	__u64 objs;
+	__u32 count;
+	__u32 owner;
+	__u32 index;
+	__u32 pad;
+};
+
+#define NTSYNC_MAX_WAIT_COUNT 64
+
 #define NTSYNC_IOC_BASE 0xf7
 
 #define NTSYNC_IOC_CREATE_SEM		_IOWR(NTSYNC_IOC_BASE, 0, \
@@ -23,5 +34,7 @@ struct ntsync_sem_args {
 #define NTSYNC_IOC_DELETE		_IOW (NTSYNC_IOC_BASE, 1, __u32)
 #define NTSYNC_IOC_PUT_SEM		_IOWR(NTSYNC_IOC_BASE, 2, \
 					      struct ntsync_sem_args)
+#define NTSYNC_IOC_WAIT_ANY		_IOWR(NTSYNC_IOC_BASE, 3, \
+					      struct ntsync_wait_args)
 
 #endif
-- 
2.43.0


