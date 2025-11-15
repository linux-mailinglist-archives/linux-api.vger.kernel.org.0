Return-Path: <linux-api+bounces-5288-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B911FC60DEF
	for <lists+linux-api@lfdr.de>; Sun, 16 Nov 2025 00:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0739635369E
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 23:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A727B4EB;
	Sat, 15 Nov 2025 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hKfJiWAO"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052A2777FD
	for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 23:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249671; cv=none; b=CqHn38JU5w8xLZKOEc1OS3P+8sxqsCV7r0lZW3ueFUwU3tjQeNhEUpnYTDiplxK19UzzT2hbeDqCOwKDsxjFrmbtXSR0AsO+/ytz/J+/H/EX2NqsVaAxzqL+yWGqAY0hOQ37sX2AGxHBQ35fgUHSPqzXZqbbKWYR3n8YoTH6fAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249671; c=relaxed/simple;
	bh=EV1FJvnBwce/3tH7ZYd0IU8CiUPzD4risoW1Ylp6BnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2DieBQNhKAoerHgmOrDyTeKMNlds218w7n/BJQG3E0CRYIG5C4kcMsYCuNLvvmCGFyzY1zKb8Cwcu2QoWNNU/oSTAzqlzYn0p13MlzYlmcjIF8J6JqZbOQ7qmRXRHzj0RksCqgE4ZVYNiYWrOaFaBTQfd/RlajI0ao3Ey9BwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=hKfJiWAO; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64107188baeso2858447d50.3
        for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 15:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249668; x=1763854468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhpBAGvtCaN4/zg4Hr4ieTycke69MZ3f5SdTyIeLbQM=;
        b=hKfJiWAOMkFsfDt+3prXLGJKRJ59NPyADIvUXUqEH09UMjSW8Yv0I924sUR8++up2G
         QjQbAH2PERoMeE9u3zNrU6cqXmWQv1JpkeJT4T0s5xL6bHpa4gOzRbUv8ihS2dG1ihWh
         zzi5JKsJPuEdgMb6joVDdqOXgA7Kofixd8aR916yMpLxsPqFonA/d40bzVQ9Nw18kodL
         jXJSxLP08bQIDq3kg3LOJDz7swc3/MhlC4fwvh+r5M6IB4JBdkFigXb9yY6TH6uHUoUb
         xBC4rw1G8Bt3L2mn3wl8WJB11/XNH1mZ6S+u7Q4Sgz7Er2TytggO728k+2vawFvz5Ygu
         W7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249668; x=1763854468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uhpBAGvtCaN4/zg4Hr4ieTycke69MZ3f5SdTyIeLbQM=;
        b=EumiF2TGz+JK0FE6Oux1ImN8mKIrRrL02l+BaHAuFRfbPYjouUbJ92sJZv5+WwuGUL
         J2YweS/03ojQEzA9FdtKasmQGHxNicQmLMNnSghLBOXLZC8srPjVR9/XhWU7urVv+0ij
         vYlBHmKNGSHT2qG59zTBtmtL1LY2T/VGTQIbpziH7JPVxQOwtnmX3ACCtgkj8qm62Zg7
         DlUtPHbEjA/DoQJgScYxhtg37lBE9lJwMc2DS0sg1wWhScI/wVV+4nVvsMFGs4xK+75T
         GObZ21eZj03SbXT8mf2S+39Y3Dx/yRJ6o0P0/ObqCSXgjBndpswX36CTEjV/q9Y4qdCJ
         vpxg==
X-Forwarded-Encrypted: i=1; AJvYcCVKXPoYTx7lvT6tr4UEMd7TZYoi9sZ67t0ArQ9Ht3V2tnPrFeYg40JgTi//LKkMVMK3UeOqFJ+NXe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4l2BNlbSP0iXMiqhSPj1J5JFauKzdKg9YpqI5o2yGKiVJlDJ
	QyT5tlFkM8YUofbuBRbkKmfoxTQWeHYV2CWIp9m1yYt2wjjzqFa9+uU3w0hh+hmbLzo=
X-Gm-Gg: ASbGncuPqAD3nkvP7FUc79KLrtrGJdvwb2F3tJT8MS92PieHOrf27NkiD5AqKWaCxuz
	I3AkFHYq7cHUOAtDZjExsyh099rLrt8nWwDmrRCmCbjsMD/rtEByyUWznZEKjLEkcDG7o9fLODE
	unPjrHM+KBbCE0oHbbq39u51gdom9N78yMi4TUkJtleOmyCdBnItw0cxHpNxcGJBHyjm5Akm/8X
	555lnqOaPAHWa3fIkiPYB8zDbvpXVWAQAeSdbXfUobZauqrO9UHDhmuWtny8UJNyzwB8qs4/vn7
	riHT1TQrDJeivESXS0R9VBih7T40Lgf5dA33QdsNd3zGuMHTBrlYoIBO+krC2VCT2WKhzTCqtzh
	GTNmLwlqIggtIFESH0zaPGW9l3F0qUuM2Q2p5G8CDMvRRSSSARuKwKPLZAxS5Nf3JgFQtbfgYvR
	AfWT6NdZIWXgZTttUFehZA/KLZuje32sOPc5LQWT+6OOgPxOr4eV4Z9pO6rcCihxiefkNelTc2i
	tQB7yY=
X-Google-Smtp-Source: AGHT+IFJMBrnhF+4OSns1bp7GpeFjnjXMcyVeEY2io2SABiWcTnwBJHtxWD+Dg9xZPdnxm6Uu5PmeA==
X-Received: by 2002:a53:b428:0:b0:63f:bc75:6ee0 with SMTP id 956f58d0204a3-641e74a3600mr4321309d50.10.1763249668108;
        Sat, 15 Nov 2025 15:34:28 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:26 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v6 05/20] liveupdate: luo_ioctl: add user interface
Date: Sat, 15 Nov 2025 18:33:51 -0500
Message-ID: <20251115233409.768044-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the user-space interface for the Live Update Orchestrator
via ioctl commands, enabling external control over the live update
process and management of preserved resources.

The idea is that there is going to be a single userspace agent driving
the live update, therefore, only a single process can ever hold this
device opened at a time.

The following ioctl commands are introduced:

LIVEUPDATE_IOCTL_CREATE_SESSION
Provides a way for userspace to create a named session for grouping file
descriptors that need to be preserved. It returns a new file descriptor
representing the session.

LIVEUPDATE_IOCTL_RETRIEVE_SESSION
Allows the userspace agent in the new kernel to reclaim a preserved
session by its name, receiving a new file descriptor to manage the
restored resources.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/uapi/linux/liveupdate.h  |  66 +++++++++++-
 kernel/liveupdate/luo_internal.h |  21 ++++
 kernel/liveupdate/luo_ioctl.c    | 178 +++++++++++++++++++++++++++++++
 3 files changed, 264 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index d2ef2f7e0dbd..6e04254ee535 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -44,6 +44,70 @@
 #define LIVEUPDATE_IOCTL_TYPE		0xBA
 
 /* The maximum length of session name including null termination */
-#define LIVEUPDATE_SESSION_NAME_LENGTH 56
+#define LIVEUPDATE_SESSION_NAME_LENGTH 64
+
+/* The /dev/liveupdate ioctl commands */
+enum {
+	LIVEUPDATE_CMD_BASE = 0x00,
+	LIVEUPDATE_CMD_CREATE_SESSION = LIVEUPDATE_CMD_BASE,
+	LIVEUPDATE_CMD_RETRIEVE_SESSION = 0x01,
+};
+
+/**
+ * struct liveupdate_ioctl_create_session - ioctl(LIVEUPDATE_IOCTL_CREATE_SESSION)
+ * @size:	Input; sizeof(struct liveupdate_ioctl_create_session)
+ * @fd:		Output; The new file descriptor for the created session.
+ * @name:	Input; A null-terminated string for the session name, max
+ *		length %LIVEUPDATE_SESSION_NAME_LENGTH including termination
+ *		char.
+ *
+ * Creates a new live update session for managing preserved resources.
+ * This ioctl can only be called on the main /dev/liveupdate device.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+struct liveupdate_ioctl_create_session {
+	__u32		size;
+	__s32		fd;
+	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
+};
+
+#define LIVEUPDATE_IOCTL_CREATE_SESSION					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_CREATE_SESSION)
+
+/**
+ * struct liveupdate_ioctl_retrieve_session - ioctl(LIVEUPDATE_IOCTL_RETRIEVE_SESSION)
+ * @size:    Input; sizeof(struct liveupdate_ioctl_retrieve_session)
+ * @fd:      Output; The new file descriptor for the retrieved session.
+ * @name:    Input; A null-terminated string identifying the session to retrieve.
+ *           The name must exactly match the name used when the session was
+ *           created in the previous kernel.
+ *
+ * Retrieves a handle (a new file descriptor) for a preserved session by its
+ * name. This is the primary mechanism for a userspace agent to regain control
+ * of its preserved resources after a live update.
+ *
+ * The userspace application provides the null-terminated `name` of a session
+ * it created before the live update. If a preserved session with a matching
+ * name is found, the kernel instantiates it and returns a new file descriptor
+ * in the `fd` field. This new session FD can then be used for all file-specific
+ * operations, such as restoring individual file descriptors with
+ * LIVEUPDATE_SESSION_RETRIEVE_FD.
+ *
+ * It is the responsibility of the userspace application to know the names of
+ * the sessions it needs to retrieve. If no session with the given name is
+ * found, the ioctl will fail with -ENOENT.
+ *
+ * This ioctl can only be called on the main /dev/liveupdate device when the
+ * system is in the LIVEUPDATE_STATE_UPDATED state.
+ */
+struct liveupdate_ioctl_retrieve_session {
+	__u32		size;
+	__s32		fd;
+	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
+};
+
+#define LIVEUPDATE_IOCTL_RETRIEVE_SESSION \
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_RETRIEVE_SESSION)
 
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 245373edfa6f..5185ad37a8c1 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -9,6 +9,27 @@
 #define _LINUX_LUO_INTERNAL_H
 
 #include <linux/liveupdate.h>
+#include <linux/uaccess.h>
+
+struct luo_ucmd {
+	void __user *ubuffer;
+	u32 user_size;
+	void *cmd;
+};
+
+static inline int luo_ucmd_respond(struct luo_ucmd *ucmd,
+				   size_t kernel_cmd_size)
+{
+	/*
+	 * Copy the minimum of what the user provided and what we actually
+	 * have.
+	 */
+	if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
+			 min_t(size_t, ucmd->user_size, kernel_cmd_size))) {
+		return -EFAULT;
+	}
+	return 0;
+}
 
 /**
  * struct luo_session - Represents an active or incoming Live Update session.
diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
index 44d365185f7c..367385efa962 100644
--- a/kernel/liveupdate/luo_ioctl.c
+++ b/kernel/liveupdate/luo_ioctl.c
@@ -5,15 +5,192 @@
  * Pasha Tatashin <pasha.tatashin@soleen.com>
  */
 
+/**
+ * DOC: LUO ioctl Interface
+ *
+ * The IOCTL user-space control interface for the LUO subsystem.
+ * It registers a character device, typically found at ``/dev/liveupdate``,
+ * which allows a userspace agent to manage the LUO state machine and its
+ * associated resources, such as preservable file descriptors.
+ *
+ * To ensure that the state machine is controlled by a single entity, access
+ * to this device is exclusive: only one process is permitted to have
+ * ``/dev/liveupdate`` open at any given time. Subsequent open attempts will
+ * fail with -EBUSY until the first process closes its file descriptor.
+ * This singleton model simplifies state management by preventing conflicting
+ * commands from multiple userspace agents.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/liveupdate.h>
 #include <linux/miscdevice.h>
+#include <uapi/linux/liveupdate.h>
+#include "luo_internal.h"
 
 struct luo_device_state {
 	struct miscdevice miscdev;
+	atomic_t in_use;
+};
+
+static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
+	struct file *file;
+	int err;
+
+	argp->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (argp->fd < 0)
+		return argp->fd;
+
+	err = luo_session_create(argp->name, &file);
+	if (err)
+		goto err_put_fd;
+
+	err = luo_ucmd_respond(ucmd, sizeof(*argp));
+	if (err)
+		goto err_put_file;
+
+	fd_install(argp->fd, file);
+
+	return 0;
+
+err_put_file:
+	fput(file);
+err_put_fd:
+	put_unused_fd(argp->fd);
+
+	return err;
+}
+
+static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_retrieve_session *argp = ucmd->cmd;
+	struct file *file;
+	int err;
+
+	argp->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (argp->fd < 0)
+		return argp->fd;
+
+	err = luo_session_retrieve(argp->name, &file);
+	if (err < 0)
+		goto err_put_fd;
+
+	err = luo_ucmd_respond(ucmd, sizeof(*argp));
+	if (err)
+		goto err_put_file;
+
+	fd_install(argp->fd, file);
+
+	return 0;
+
+err_put_file:
+	fput(file);
+err_put_fd:
+	put_unused_fd(argp->fd);
+
+	return err;
+}
+
+static int luo_open(struct inode *inodep, struct file *filep)
+{
+	struct luo_device_state *ldev = container_of(filep->private_data,
+						     struct luo_device_state,
+						     miscdev);
+
+	if (atomic_cmpxchg(&ldev->in_use, 0, 1))
+		return -EBUSY;
+
+	luo_session_deserialize();
+
+	return 0;
+}
+
+static int luo_release(struct inode *inodep, struct file *filep)
+{
+	struct luo_device_state *ldev = container_of(filep->private_data,
+						     struct luo_device_state,
+						     miscdev);
+	atomic_set(&ldev->in_use, 0);
+
+	return 0;
+}
+
+union ucmd_buffer {
+	struct liveupdate_ioctl_create_session create;
+	struct liveupdate_ioctl_retrieve_session retrieve;
+};
+
+struct luo_ioctl_op {
+	unsigned int size;
+	unsigned int min_size;
+	unsigned int ioctl_num;
+	int (*execute)(struct luo_ucmd *ucmd);
+};
+
+#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
+	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_BASE] = {                            \
+		.size = sizeof(_struct) +                                      \
+			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
+					  sizeof(_struct)),                    \
+		.min_size = offsetofend(_struct, _last),                       \
+		.ioctl_num = _ioctl,                                           \
+		.execute = _fn,                                                \
+	}
+
+static const struct luo_ioctl_op luo_ioctl_ops[] = {
+	IOCTL_OP(LIVEUPDATE_IOCTL_CREATE_SESSION, luo_ioctl_create_session,
+		 struct liveupdate_ioctl_create_session, name),
+	IOCTL_OP(LIVEUPDATE_IOCTL_RETRIEVE_SESSION, luo_ioctl_retrieve_session,
+		 struct liveupdate_ioctl_retrieve_session, name),
 };
 
+static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	const struct luo_ioctl_op *op;
+	struct luo_ucmd ucmd = {};
+	union ucmd_buffer buf;
+	unsigned int nr;
+	int err;
+
+	nr = _IOC_NR(cmd);
+	if (nr < LIVEUPDATE_CMD_BASE ||
+	    (nr - LIVEUPDATE_CMD_BASE) >= ARRAY_SIZE(luo_ioctl_ops)) {
+		return -EINVAL;
+	}
+
+	ucmd.ubuffer = (void __user *)arg;
+	err = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
+	if (err)
+		return err;
+
+	op = &luo_ioctl_ops[nr - LIVEUPDATE_CMD_BASE];
+	if (op->ioctl_num != cmd)
+		return -ENOIOCTLCMD;
+	if (ucmd.user_size < op->min_size)
+		return -EINVAL;
+
+	ucmd.cmd = &buf;
+	err = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
+				    ucmd.user_size);
+	if (err)
+		return err;
+
+	return op->execute(&ucmd);
+}
+
 static const struct file_operations luo_fops = {
 	.owner		= THIS_MODULE,
+	.open		= luo_open,
+	.release	= luo_release,
+	.unlocked_ioctl	= luo_ioctl,
 };
 
 static struct luo_device_state luo_dev = {
@@ -22,6 +199,7 @@ static struct luo_device_state luo_dev = {
 		.name  = "liveupdate",
 		.fops  = &luo_fops,
 	},
+	.in_use = ATOMIC_INIT(0),
 };
 
 static int __init liveupdate_ioctl_init(void)
-- 
2.52.0.rc1.455.g30608eb744-goog


