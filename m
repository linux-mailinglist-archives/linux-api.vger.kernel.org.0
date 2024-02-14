Return-Path: <linux-api+bounces-955-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A0855791
	for <lists+linux-api@lfdr.de>; Thu, 15 Feb 2024 00:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AB51F2181E
	for <lists+linux-api@lfdr.de>; Wed, 14 Feb 2024 23:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF3145B1F;
	Wed, 14 Feb 2024 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="dW0ckDBB"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41633145B0E;
	Wed, 14 Feb 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954799; cv=none; b=LE2Z8RiXI+T28PzBI0oM7A3CHovvbgQdIv4fFDjFQXY1Pj3QYEF6/Zi0yZ8XEva2+Q4h0yMSimUPmwqHKrvNRMqakYq1aUKgO/fn+IblMVFfPHfKCrv/j0W21qCRolRaIPnoCYbDJzgdQeHzZNaOuk1v78j7jy/88hnsR15apeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954799; c=relaxed/simple;
	bh=Ny4Ci7/Bf+MThJse/6wJNKGtKOLPatN9/l94Q+XkAJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmzYnc29pMUrnn4rHckghbDmVdvABpnpkCb0ZsAgmWj0uIA8MeCy2ruisWGzoMYhDQqlBgDA3uBTP2U0APTjiLyx0cbYVJwXjcAmhgUmX2Xsmpfk2g79+gcWmS65Eumtlc09I/QMV2mspJCk/mKctR72XgGmElqCmdY98cdoeCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=dW0ckDBB; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=YtvcNT1nJgwYe+S6BR4d8dQs6sl/vLgKx6v9T6c9bhY=; b=dW0ckDBBbcBtc8f2rK1xkogp7Q
	Q86RM2jvUDOP1zqngVfG2qkqx9K+c6bn87KKXHYqFxW3ul3pBAlFIv+wsBnz9uUXAdHi5YSRgyo8E
	Wg7p/FMFxTVjlup3z4IeN5tWm1KXQ4tLfSropWlea7tx2lv//tMqABxVjGP73kwc8oR9BmjUqSCK4
	t/xbwncLLCbJoh3sa2vM8XqPZBd6yvTCBsGbZMnwZRkg+TVm5hYBVgt5bDSAtZDO8pgr7btBT5pFT
	ACNqpOLj4+fgzoNDmDMLOLjFZ9SUkgptY0F9CpLw5OTq5sjePoQBb85MTyYimpwZIMDxreYVAvo0V
	89aXrtvQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raOoW-00GbiL-2e;
	Wed, 14 Feb 2024 17:37:16 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH 03/31] ntsync: Introduce NTSYNC_IOC_SEM_POST.
Date: Wed, 14 Feb 2024 17:36:39 -0600
Message-ID: <20240214233645.9273-4-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214233645.9273-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corresponds to the NT syscall NtReleaseSemaphore().

This increases the semaphore's internal counter by the given value, and returns
the previous value. If the counter would overflow the defined maximum, the
function instead fails and returns -EOVERFLOW.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 72 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/ntsync.h |  2 ++
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 3ad86d98b82d..01556475f5cc 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -10,7 +10,9 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <uapi/linux/ntsync.h>
 
 #define NTSYNC_NAME	"ntsync"
@@ -20,23 +22,70 @@ enum ntsync_type {
 };
 
 struct ntsync_obj {
+	spinlock_t lock;
+
 	enum ntsync_type type;
 
+	struct file *file;
+	struct ntsync_device *dev;
+
+	/* The following fields are protected by the object lock. */
 	union {
 		struct {
 			__u32 count;
 			__u32 max;
 		} sem;
 	} u;
-
-	struct file *file;
-	struct ntsync_device *dev;
 };
 
 struct ntsync_device {
 	struct file *file;
 };
 
+/*
+ * Actually change the semaphore state, returning -EOVERFLOW if it is made
+ * invalid.
+ */
+static int post_sem_state(struct ntsync_obj *sem, __u32 count)
+{
+	__u32 sum;
+
+	lockdep_assert_held(&sem->lock);
+
+	if (check_add_overflow(sem->u.sem.count, count, &sum) ||
+	    sum > sem->u.sem.max)
+		return -EOVERFLOW;
+
+	sem->u.sem.count = sum;
+	return 0;
+}
+
+static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
+{
+	__u32 __user *user_args = argp;
+	__u32 prev_count;
+	__u32 args;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (sem->type != NTSYNC_TYPE_SEM)
+		return -EINVAL;
+
+	spin_lock(&sem->lock);
+
+	prev_count = sem->u.sem.count;
+	ret = post_sem_state(sem, args);
+
+	spin_unlock(&sem->lock);
+
+	if (!ret && put_user(prev_count, user_args))
+		ret = -EFAULT;
+
+	return ret;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -47,9 +96,25 @@ static int ntsync_obj_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long parm)
+{
+	struct ntsync_obj *obj = file->private_data;
+	void __user *argp = (void __user *)parm;
+
+	switch (cmd) {
+	case NTSYNC_IOC_SEM_POST:
+		return ntsync_sem_post(obj, argp);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 static const struct file_operations ntsync_obj_fops = {
 	.owner		= THIS_MODULE,
 	.release	= ntsync_obj_release,
+	.unlocked_ioctl	= ntsync_obj_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= no_llseek,
 };
 
@@ -64,6 +129,7 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
 	obj->type = type;
 	obj->dev = dev;
 	get_file(dev->file);
+	spin_lock_init(&obj->lock);
 
 	return obj;
 }
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index f38818e7759d..878ec4f0f2e8 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -18,4 +18,6 @@ struct ntsync_sem_args {
 
 #define NTSYNC_IOC_CREATE_SEM		_IOWR('N', 0x80, struct ntsync_sem_args)
 
+#define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
+
 #endif
-- 
2.43.0


