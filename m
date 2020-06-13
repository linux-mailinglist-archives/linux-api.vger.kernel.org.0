Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305821F8180
	for <lists+linux-api@lfdr.de>; Sat, 13 Jun 2020 09:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFMH0P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 13 Jun 2020 03:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgFMH0P (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 13 Jun 2020 03:26:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF42C08C5C1
        for <linux-api@vger.kernel.org>; Sat, 13 Jun 2020 00:26:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r18so5192917pgk.11
        for <linux-api@vger.kernel.org>; Sat, 13 Jun 2020 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0cxjUp60+np/6LLx5JQwEXzXhrQwCyrDeJc10UG6O/0=;
        b=EAWX93ym/2bBUo9RpNcNYYP4MvEN2zLYkwrJP78qMbbmnR/N0rbylR9kCG8ZKpzWmA
         ycgraTpkwgR8Qr3/TrXVqY8DN2cyKL6k5AKVzXgB/xP/+KRykql4SDqSqIWQXBJopl60
         5/YU+mnFmaua+8BkDdb+viFzvkT3XwKYlCoI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0cxjUp60+np/6LLx5JQwEXzXhrQwCyrDeJc10UG6O/0=;
        b=AY9z+1iEFnxK1TcGYwdMb0h55UbWpCWZaR2dvDUT92hVFWApTqUIyZZDu8ry/ouk1j
         UElUZRwSByr4bFLYAi0z5BjxveYc0JJ724khq4FhzNSQdTl82gHhg+78RvM4+TUpmA/D
         /U9NFqYf9hjd3CJBhNOpjKF2v+bGIgnWMjGkYijTDukEUMHwopLnHlYkUSJzLgkvn4Bu
         ggdt6ndK/qUsPNvpTJdNUT7yvAe3qad4WXrInPcXyrqWotDut9OxBe/gA+UTQdl1/1xr
         jLVjIYWylbN/nUf2YNWw5+esZs5TMpRLepV1BCkbHhNmt50zBiwdhWvwJmdjGIaoOkuo
         HXvA==
X-Gm-Message-State: AOAM5314atH9U+BBX5q2sUVp697ADk5KxEDrvS0wkhFEFY0Jbk+R3cIM
        A1HMXT+zFclkj+oe9INuMkn8hJsgK3I/s5Bg
X-Google-Smtp-Source: ABdhPJxPEvqgsQxKRExXJnfYxjV3lpLA41R4zCj1p6SeSuMwwfHECBoxF7Fzj2MiYHm314OeOBPB4Q==
X-Received: by 2002:a63:3d85:: with SMTP id k127mr9323226pga.29.1592033172469;
        Sat, 13 Jun 2020 00:26:12 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id i34sm7249227pje.10.2020.06.13.00.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 00:26:11 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, Tycho Andersen <tycho@tycho.ws>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: [RFC PATCH] seccomp: Add extensibility mechanism to read notifications
Date:   Sat, 13 Jun 2020 00:26:09 -0700
Message-Id: <20200613072609.5919-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This introduces an extensibility mechanism to receive seccomp
notifications. It uses read(2), as opposed to using an ioctl. The listener
must be first configured to write the notification via the
SECCOMP_IOCTL_NOTIF_CONFIG ioctl with the fields that the user is
interested in.

This is different than the old SECCOMP_IOCTL_NOTIF_RECV method as it allows
for more flexibility. It allows the user to opt into certain fields, and
not others. This is nice for users who want to opt into some fields like
thread group leader. In the future, this mechanism can be used to expose
file descriptors to users, such as a representation of the process's
memory. It also has good forwards and backwards compatibility guarantees.
Users with programs compiled against newer headers will work fine on older
kernels as long as they don't opt into any sizes, or optional fields that
are only available on newer kernels.

The ioctl method relies on an extensible struct[1]. This extensible struct
is slightly misleading[2] as the ioctl number changes when we extend it.
This breaks backwards compatibility with older kernels even if we're not
asking for any fields that we do not need. In order to deal with this, the
ioctl number would need to be dynamic, or the user would need to pass the
size they're expecting, and we would need to implemented "extended syscall"
semantics in ioctl. This potentially causes issue to future work of
kernel-assisted copying for ioctl user buffers.

read(2) offers slightly simpler semantics for the user, in that they do
not need to pass in the size they're expecting to the kernel. Only the
size of the buffer they have allocated. Since this information is passed
along with the read syscall there isn't a requirement to read it back from
userspace. It also doesn't get into the EA ioctl / dynamic ioctl number
shenanigans discussed above.

Also, it plugs in nicely to Golang (or othr high-level languages), as you
can just treat it like a normal file. Go will put it into the event poll
loop, and do a read on the buffer for you.

[1]: https://lore.kernel.org/linux-api/20181209182414.30862-4-tycho@tycho.ws/
[2]: https://lore.kernel.org/lkml/20200610081237.GA23425@ircssh-2.c.rugged-nimbus-611.internal/

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/uapi/linux/seccomp.h                  |  15 ++
 kernel/seccomp.c                              | 245 ++++++++++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c |  61 +++++
 3 files changed, 299 insertions(+), 22 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index c1735455bc53..75a6cb56db84 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -77,6 +77,19 @@ struct seccomp_notif {
 	struct seccomp_data data;
 };
 
+enum seccomp_data_version_size {
+	SECCOMP_DATA_SIZE_NOT_PRESENT = 0,
+	SECCOMP_DATA_SIZE_VER0 = 64,
+	SECCOMP_DATA_SIZE_LATEST = SECCOMP_DATA_SIZE_VER0,
+};
+
+#define SECCOMP_NOTIF_FIELD_PID	(1UL << 0)
+
+struct seccomp_notif_config {
+	__u32 optional_fields; /* OR'd SECCOMP_NOTIF_FIELD_* */
+	__u32 seccomp_data_size; /* seccomp_notif_field_data_version */
+};
+
 /*
  * Valid flags for struct seccomp_notif_resp
  *
@@ -124,4 +137,6 @@ struct seccomp_notif_resp {
 #define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
 						struct seccomp_notif_resp)
 #define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
+#define SECCOMP_IOCTL_NOTIF_CONFIG	SECCOMP_IOW(3, \
+						struct seccomp_notif_config)
 #endif /* _UAPI_LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 34dbf77569b3..006b387d3408 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -84,6 +84,27 @@ struct seccomp_knotif {
 	struct list_head list;
 };
 
+/* Returns bytes written, negative number for error code */
+typedef int (*seccomp_notification_appender_t)(struct seccomp_filter *filter,
+					       void *buf,
+					       struct seccomp_knotif *knotif);
+
+/**
+ * struct notification_read_config - configuration for read calls against
+ * seccomp listener FD. This is the specification of what the read size
+ * and read format is.
+ *
+ * @read_size: The size of the configured read. If it 0, it means that the
+ *             listener has not yet been configured.
+ * @optional_fields: Bitmask of enabled optional fields
+ * @seccomp_data: Callback to append seccomp_data to buffer
+ */
+struct notification_read_config {
+	u32 read_size;
+	u64 optional_fields;
+	seccomp_notification_appender_t seccomp_data;
+};
+
 /**
  * struct notification - container for seccomp userspace notifications. Since
  * most seccomp filters will not have notification listeners attached and this
@@ -100,6 +121,7 @@ struct notification {
 	struct semaphore request;
 	u64 next_id;
 	struct list_head notifications;
+	struct notification_read_config read_config;
 };
 
 /**
@@ -1086,11 +1108,49 @@ find_notification(struct seccomp_filter *filter, u64 id)
 	return NULL;
 }
 
+/*
+ * Return the next available notification. Must be called after decrementing
+ * filter->notif->request.
+ */
+static struct seccomp_knotif *seccomp_next_notif(struct seccomp_filter *filter)
+{
+	struct seccomp_knotif *cur;
+
+	lockdep_assert_held(&filter->notify_lock);
+
+	list_for_each_entry(cur, &filter->notif->notifications, list) {
+		if (cur->state == SECCOMP_NOTIFY_INIT) {
+			cur->state = SECCOMP_NOTIFY_SENT;
+			wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
+			return cur;
+		}
+	}
+
+	/*
+	 * If we didn't find a notification, it could be that the task was
+	 * interrupted by a fatal signal between the time we were woken and
+	 * when we were able to acquire the rw lock.
+	 */
+	return NULL;
+}
+
+static void seccomp_reset_notif(struct seccomp_filter *filter, u64 id)
+{
+	struct seccomp_knotif *knotif;
+
+	mutex_lock(&filter->notify_lock);
+	knotif = find_notification(filter, id);
+	if (knotif) {
+		knotif->state = SECCOMP_NOTIFY_INIT;
+		up(&filter->notif->request);
+	}
+	mutex_unlock(&filter->notify_lock);
+}
 
 static long seccomp_notify_recv(struct seccomp_filter *filter,
 				void __user *buf)
 {
-	struct seccomp_knotif *knotif, *cur;
+	struct seccomp_knotif *knotif;
 	struct seccomp_notif unotif;
 	ssize_t ret;
 
@@ -1108,18 +1168,7 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 		return ret;
 
 	mutex_lock(&filter->notify_lock);
-	list_for_each_entry(cur, &filter->notif->notifications, list) {
-		if (cur->state == SECCOMP_NOTIFY_INIT) {
-			knotif = cur;
-			break;
-		}
-	}
-
-	/*
-	 * If we didn't find a notification, it could be that the task was
-	 * interrupted by a fatal signal between the time we were woken and
-	 * when we were able to acquire the rw lock.
-	 */
+	knotif = seccomp_next_notif(filter);
 	if (!knotif) {
 		ret = -ENOENT;
 		goto out;
@@ -1129,8 +1178,6 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 	unotif.pid = task_pid_vnr(knotif->task);
 	unotif.data = *(knotif->data);
 
-	knotif->state = SECCOMP_NOTIFY_SENT;
-	wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
 	ret = 0;
 out:
 	mutex_unlock(&filter->notify_lock);
@@ -1144,13 +1191,7 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 		 * may have died when we released the lock, so we need to make
 		 * sure it's still around.
 		 */
-		mutex_lock(&filter->notify_lock);
-		knotif = find_notification(filter, unotif.id);
-		if (knotif) {
-			knotif->state = SECCOMP_NOTIFY_INIT;
-			up(&filter->notif->request);
-		}
-		mutex_unlock(&filter->notify_lock);
+		seccomp_reset_notif(filter, unotif.id);
 	}
 
 	return ret;
@@ -1224,6 +1265,162 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 	return ret;
 }
 
+static int append_noop(struct seccomp_filter *filter, void *buf,
+		       struct seccomp_knotif *knotif)
+{
+	lockdep_assert_held(&filter->notify_lock);
+
+	return 0;
+}
+
+static int append_seccomp_data_ver0(struct seccomp_filter *filter, void *buf,
+				    struct seccomp_knotif *knotif)
+{
+	lockdep_assert_held(&filter->notify_lock);
+
+	/*
+	 * Make sure the copy approach we're using here doesn't go out of sync
+	 * with what the user requested. If this breaks, this mechanism of
+	 * population needs to change.
+	 */
+	BUILD_BUG_ON(sizeof(*(knotif->data)) != SECCOMP_DATA_SIZE_VER0);
+	memcpy(buf, knotif->data, SECCOMP_DATA_SIZE_VER0);
+
+	return SECCOMP_DATA_SIZE_VER0;
+}
+
+static long seccomp_notify_config(struct seccomp_filter *filter,
+				  void __user *buf)
+{
+	int err;
+	struct seccomp_notif_config uconfig;
+	struct notification_read_config kread_config = {
+		/* The notification always includes ID */
+		.read_size	= sizeof(u64),
+	};
+
+	err = copy_from_user(&uconfig, buf, sizeof(uconfig));
+	if (err)
+		return err;
+
+	if (uconfig.optional_fields & ~SECCOMP_NOTIF_FIELD_PID)
+		return -ENOTSUPP;
+
+	kread_config.optional_fields = uconfig.optional_fields;
+	kread_config.read_size += 8 * __sw_hweight64(uconfig.optional_fields);
+
+	switch (uconfig.seccomp_data_size) {
+	case SECCOMP_DATA_SIZE_NOT_PRESENT:
+		kread_config.seccomp_data = append_noop;
+		break;
+	case SECCOMP_DATA_SIZE_VER0:
+		kread_config.seccomp_data = append_seccomp_data_ver0;
+		break;
+	default:
+		/* Invalid size */
+		return uconfig.seccomp_data_size > SECCOMP_DATA_SIZE_LATEST ?
+			-E2BIG : -EINVAL;
+	}
+	kread_config.read_size += uconfig.seccomp_data_size;
+
+	err = mutex_lock_interruptible(&filter->notify_lock);
+	if (err < 0)
+		return err;
+
+	filter->notif->read_config = kread_config;
+
+	mutex_unlock(&filter->notify_lock);
+
+	return kread_config.read_size;
+}
+
+static ssize_t seccomp_notify_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	struct seccomp_filter *filter = file->private_data;
+	struct notification_read_config read_config;
+	struct seccomp_knotif *knotif = NULL;
+	void *kbuf, *cursor;
+	int ret;
+	u64 id;
+
+	/* Get the seccomp read configuration */
+	ret = mutex_lock_interruptible(&filter->notify_lock);
+	if (ret)
+		return ret;
+
+	read_config = filter->notif->read_config;
+
+	mutex_unlock(&filter->notify_lock);
+
+	if (read_config.read_size == 0)
+		return -EINVAL;
+	if (count < read_config.read_size)
+		return -ENOSPC;
+
+	/*
+	 * Prepare a buffer. We populate this buffer as opposed to populating
+	 * user memory directly because we can't copy while we have the notify
+	 * mutex held (since we might sleep).
+	 */
+	kbuf = kmalloc(read_config.read_size, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	/* Get the notification */
+	ret = down_interruptible(&filter->notif->request);
+	if (ret < 0)
+		goto out;
+
+	mutex_lock(&filter->notify_lock);
+	knotif = seccomp_next_notif(filter);
+	if (!knotif) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	cursor = kbuf;
+	id = knotif->id;
+
+	/*
+	 * Build the buffer. All optional fields are 8-byte aligned. Thus,
+	 * individual fields that are smaller than 64-bit must be rounded up
+	 * to s64 / u64. If there is an optional field that is compromised of
+	 * multiple members, the entire size needs to be 8-byte aligned,
+	 * and it is not necccessary to 8-byte align each member.
+	 */
+	*(__u64 *)cursor = id;
+	cursor += sizeof(__u64);
+	if (read_config.optional_fields & SECCOMP_NOTIF_FIELD_PID) {
+		*(__u64 *)cursor = task_pid_vnr(knotif->task);
+		cursor += sizeof(__u64);
+	}
+
+	ret = read_config.seccomp_data(filter, cursor, knotif);
+	if (ret < 0)
+		goto out_unlock;
+	cursor += ret;
+
+	ret = 0;
+	WARN_ON(cursor != kbuf + read_config.read_size);
+
+out_unlock:
+	mutex_unlock(&filter->notify_lock);
+
+	if (ret == 0) {
+		ret = copy_to_user(buf, kbuf, read_config.read_size);
+		if (ret)
+			seccomp_reset_notif(filter, id);
+		else
+			ret = read_config.read_size;
+	} else if (knotif) {
+		seccomp_reset_notif(filter, id);
+	}
+out:
+	kfree(kbuf);
+	return ret;
+}
+
 static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg)
 {
@@ -1237,6 +1434,8 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 		return seccomp_notify_send(filter, buf);
 	case SECCOMP_IOCTL_NOTIF_ID_VALID:
 		return seccomp_notify_id_valid(filter, buf);
+	case SECCOMP_IOCTL_NOTIF_CONFIG:
+		return seccomp_notify_config(filter, buf);
 	default:
 		return -EINVAL;
 	}
@@ -1276,6 +1475,7 @@ static const struct file_operations seccomp_notify_ops = {
 	.release = seccomp_notify_release,
 	.unlocked_ioctl = seccomp_notify_ioctl,
 	.compat_ioctl = seccomp_notify_ioctl,
+	.read = seccomp_notify_read,
 };
 
 static struct file *init_listener(struct seccomp_filter *filter)
@@ -1640,6 +1840,7 @@ long seccomp_get_metadata(struct task_struct *task,
 	__put_seccomp_filter(filter);
 	return ret;
 }
+
 #endif
 
 #ifdef CONFIG_SYSCTL
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 402ccb3a4e52..3073d56e9ee0 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3822,6 +3822,67 @@ TEST(user_notification_filter_empty_threaded)
 	EXPECT_GT((pollfd.revents & POLLHUP) ?: 0, 0);
 }
 
+struct read_output_format {
+	__u64 id;
+	struct seccomp_data data;
+};
+
+TEST(user_notification_read)
+{
+	long ret;
+	int status, pid, listener, read_size;
+	struct seccomp_notif_config config = {};
+	struct seccomp_notif_resp resp = {};
+	struct read_output_format buf = {};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_trap_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	EXPECT_EQ(read(listener, &buf, sizeof(buf)), -1) {
+		EXPECT_EQ(errno, -EINVAL);
+	}
+
+	config.seccomp_data_size = sizeof(struct seccomp_data);
+	config.optional_fields = ~(0);
+	/* Make sure invalid fields are not accepted */
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_CONFIG, &config), -1);
+
+	config.optional_fields = 0;
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_CONFIG, &config), sizeof(buf)) {
+		TH_LOG("Errno: %s", strerror(errno));
+	}
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		exit(syscall(__NR_dup, 42, 1, 1, 1) != USER_NOTIF_MAGIC);
+
+	/* Passing a smaller value in should fail */
+	EXPECT_EQ(read(listener, &buf, sizeof(buf) - 1), -1) {
+		EXPECT_EQ(errno, -E2BIG);
+	}
+
+	/* Passing a larger value in should succeed */
+	ASSERT_EQ(read(listener, &buf, 200), sizeof(buf));
+	EXPECT_EQ(buf.data.args[0], 42);
+	EXPECT_EQ(buf.data.nr, __NR_dup);
+
+	resp.id = buf.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.25.1

