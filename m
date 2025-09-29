Return-Path: <linux-api+bounces-4960-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E1BA7B32
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 03:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7117AC2C4
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 01:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019F20409A;
	Mon, 29 Sep 2025 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cJ1jVEv+"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087881EFF8D
	for <linux-api@vger.kernel.org>; Mon, 29 Sep 2025 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107877; cv=none; b=HlDAdhS10Su3iaciVF1Ex6WfvEGLCHEgSvdV9s/VX0Uc10+wXxfjL/XPfYsp4UAJ0TANt8SL1+X/SwfIGkB1wiYA+Bm6GLr2eFNdBg8A4wmXnY51e7jfHWvjATixvXDYEkIU06AmmY+0ejxc6857mr/W4KGoEj64U4A90mel9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107877; c=relaxed/simple;
	bh=s7riUWIsmzempjfTg2DxymE7etahoAWCKxcbNfqLgO4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efwkiA89MCz1YTz64TNgotI5tVyEXZCkgYOv1u7wKEzFgLLSo5QXlwbcxyuhaYt+8XVbR+7jxTBcalkaSnJOmNEKo9IzHIs/AdcABGutOa2YcUOApF0vmiGYiKtSRqRAcMzmEoHUGgeCototYEUH88yCcCWzH7ijKc4m36Lrhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cJ1jVEv+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4dfd1f48d4cso7217371cf.0
        for <linux-api@vger.kernel.org>; Sun, 28 Sep 2025 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107872; x=1759712672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWmliTpIctCvQpdpBySgcvRmzR2McUJ9TQRf0sVYx5U=;
        b=cJ1jVEv+fnuHht9eHig52RAB+nz4Qn1ImXgM4YBOmnZ8l3mtyccf1yOlDjT1kxmRO6
         qptdG2P9q2nTEQFMXSdff3BFoCluLiuW5/LnEYBJtfaHGmmk5uDqI+lvlbY4Z1HHVM3N
         dpdBZKxGpflxeEVmJKejUhfAegjCzG+T2GCVQ1SUALD62BUHA5K7s7WbzvUK7vzLzaPX
         mFKjCEkKIdeqZxXIpEN/h9BiAYIkn2rktDEVEINqr52VCzwQ2If99OfBxK9MmHvIF/yb
         r68A4R50WbAlcsq1XHCw3VwB9kE07mWhgrWA9Ysk5ynKxruvvKny7E/8L41ef1MubORS
         bCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107872; x=1759712672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWmliTpIctCvQpdpBySgcvRmzR2McUJ9TQRf0sVYx5U=;
        b=EvbsG/17+N2UxjIvUYxyUvoUbTY4Lj84f70cFkk4kZFg26VG6bvPASCcuc4CAUsyQi
         CPLo7Qge90RVZg804xPjMCPVJqSvbYaUAGQYIsNxz29dZaKiEFr1BgtzWbNlI1GsAO5w
         PJ4vlpYbJn5fIt65h9zE4DB28Adf1k6qQyjL9hf7oLvKcNlpAfjAd42CV5ZgdnFxiOG4
         2IUJPANKBOUjtOHvqKjurnI297/49ynjQAF5jEYN6KDKspPZjwUJqVi5h3PeFdRw+4ib
         cPIfunXrQBGWKXwz7Dq+32QBO3AhWpPHTD9dL7aoVOu6PjX3KLdjc5DtDL69lSVdxI/S
         oL4A==
X-Forwarded-Encrypted: i=1; AJvYcCWwWnkfK77IznetwXTq1ehVU4oAsiFMK0ylOgx+XBYPozPlfZ4JPN4z2HGWFa+oMICDlT4eFD7yOmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjrFV+zqvpeml8hq9fF+Er+vdC8XXJrFOnF9n3ulCTGyftQGqc
	9vyaYIpS1sGfBM5BOkkw6KOMRFPYHi8uRR27TmGdNsoB9NXn+m5obb0LiwHWBPtA5FQ=
X-Gm-Gg: ASbGncuJLCMfKNUZOYr5xYs/61dPjPlN2NVDU3gER0mz4EB6pgbNrsZQXOYD37VYAXT
	RnlPdA+bA8Dbo5de/qmyaRfq3cRy9bJpFvOdY50md6Il3agEPpM0+u5FdjzbA01zWUppaXLWZIH
	yxvwSkJjrbNjwUScsPRk9MhaUSo+uL0jISp2MTgGCRdxsgCFDcxzj0FVW4NbUCkd7bS7kTgbt8L
	u7CBtKhXyQkvdDcbXzciKKLHnAwUWreT//ZfX1Quvzc9c7w0i4f6oKCVW5ndjn0MuMj4d63M8pq
	rVxQT67NNDxe019vT623Zcur/xC6sBF1sc1ic2eeq91DEe6jMiJJYYvgCi27RX+6ECSlVocl+Rs
	7LVwkuoD5kNR9ffzQ4LRM9jPq8+a5CofxuqVkw1kGWffQ4Vo3Hfoov7cE2oJYOajtCSQqk+kdIv
	j8Q1y+790F0IqxrIlRFQ==
X-Google-Smtp-Source: AGHT+IG0CVkGX/h5klhvmrp3PnurAX/EzEyivOu5tBhLiUlxcyjYS6JE/ZicsPVeRpadbDVekFht6w==
X-Received: by 2002:ac8:7d10:0:b0:4b5:4874:4f95 with SMTP id d75a77b69052e-4da4b13eca8mr179372601cf.51.1759107871010;
        Sun, 28 Sep 2025 18:04:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:30 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
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
	zhangguopeng@kylinos.cn,
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
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 13/30] liveupdate: luo_file: implement file systems callbacks
Date: Mon, 29 Sep 2025 01:03:04 +0000
Message-ID: <20250929010321.3462457-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements the core logic within luo_file.c to invoke the prepare,
reboot, finish, and cancel callbacks for preserved file instances,
replacing the previous stub implementations. It also handles
the persistence and retrieval of the u64 data payload associated with
each file via the LUO FDT.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h       |  79 ++++
 kernel/liveupdate/Makefile       |   1 +
 kernel/liveupdate/luo_file.c     | 599 +++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h |  14 +
 4 files changed, 693 insertions(+)
 create mode 100644 kernel/liveupdate/luo_file.c

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 4c378a986cfe..c0a7f8c40719 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -13,6 +13,72 @@
 #include <uapi/linux/liveupdate.h>
 
 struct liveupdate_subsystem;
+struct liveupdate_file_handler;
+struct file;
+
+/**
+ * struct liveupdate_file_ops - Callbacks for live-updatable files.
+ * @prepare:       Optional. Saves state for a specific file instance @file,
+ *                 before update, potentially returning value via @data.
+ *                 Returns 0 on success, negative errno on failure.
+ * @freeze:        Optional. Performs final actions just before kernel
+ *                 transition, potentially reading/updating the handle via
+ *                 @data.
+ *                 Returns 0 on success, negative errno on failure.
+ * @cancel:        Optional. Cleans up state/resources if update is aborted
+ *                 after prepare/freeze succeeded, using the @data handle (by
+ *                 value) from the successful prepare. Returns void.
+ * @finish:        Optional. Performs final cleanup in the new kernel using the
+ *                 preserved @data handle (by value). Returns void.
+ * @retrieve:      Retrieve the preserved file. Must be called before finish.
+ * @can_preserve:  callback to determine if @file can be preserved by this
+ *                 handler.
+ *                 Return bool (true if preservable, false otherwise).
+ * @owner:         Module reference
+ */
+struct liveupdate_file_ops {
+	int (*prepare)(struct liveupdate_file_handler *handler,
+		       struct file *file, u64 *data);
+	int (*freeze)(struct liveupdate_file_handler *handler,
+		      struct file *file, u64 *data);
+	void (*cancel)(struct liveupdate_file_handler *handler,
+		       struct file *file, u64 data);
+	void (*finish)(struct liveupdate_file_handler *handler,
+		       struct file *file, u64 data, bool reclaimed);
+	int (*retrieve)(struct liveupdate_file_handler *handler,
+			u64 data, struct file **file);
+	bool (*can_preserve)(struct liveupdate_file_handler *handler,
+			     struct file *file);
+	struct module *owner;
+};
+
+/* The max size is set so it can be reliably used during in serialization */
+#define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
+
+/**
+ * struct liveupdate_file_handler - Represents a handler for a live-updatable
+ * file type.
+ * @ops:           Callback functions
+ * @compatible:    The compatibility string (e.g., "memfd-v1", "vfiofd-v1")
+ *                 that uniquely identifies the file type this handler supports.
+ *                 This is matched against the compatible string associated with
+ *                 individual &struct liveupdate_file instances.
+ * @list:          used for linking this handler instance into a global list of
+ *                 registered file handlers.
+ * @count:         Atomic counter of number of files that are preserved and use
+ *                 this handler.
+ *
+ * Modules that want to support live update for specific file types should
+ * register an instance of this structure. LUO uses this registration to
+ * determine if a given file can be preserved and to find the appropriate
+ * operations to manage its state across the update.
+ */
+struct liveupdate_file_handler {
+	const struct liveupdate_file_ops *ops;
+	const char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
+	struct list_head list;
+	atomic_t count;
+};
 
 /**
  * struct liveupdate_subsystem_ops - LUO events callback functions
@@ -83,6 +149,9 @@ int liveupdate_register_subsystem(struct liveupdate_subsystem *h);
 int liveupdate_unregister_subsystem(struct liveupdate_subsystem *h);
 int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data);
 
+int liveupdate_register_file_handler(struct liveupdate_file_handler *h);
+int liveupdate_unregister_file_handler(struct liveupdate_file_handler *h);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline int liveupdate_reboot(void)
@@ -126,5 +195,15 @@ static inline int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h,
 	return -ENODATA;
 }
 
+static inline int liveupdate_register_file_handler(struct liveupdate_file_handler *h)
+{
+	return 0;
+}
+
+static inline int liveupdate_unregister_file_handler(struct liveupdate_file_handler *h)
+{
+	return 0;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index f64cfc92cbf0..282d36a18993 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -2,6 +2,7 @@
 
 luo-y :=								\
 		luo_core.o						\
+		luo_file.o						\
 		luo_ioctl.o						\
 		luo_session.o						\
 		luo_subsystems.o
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
new file mode 100644
index 000000000000..69f3acf90da5
--- /dev/null
+++ b/kernel/liveupdate/luo_file.c
@@ -0,0 +1,599 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: LUO file descriptors
+ *
+ * LUO provides the infrastructure necessary to preserve
+ * specific types of stateful file descriptors across a kernel live
+ * update transition. The primary goal is to allow workloads, such as virtual
+ * machines using vfio, memfd, or iommufd to retain access to their essential
+ * resources without interruption after the underlying kernel is  updated.
+ *
+ * The framework operates based on handler registration and instance tracking:
+ *
+ * 1. Handler Registration: Kernel modules responsible for specific file
+ * types (e.g., memfd, vfio) register a &struct liveupdate_file_handler
+ * handler. This handler contains callbacks
+ * (&liveupdate_file_handler.ops->prepare,
+ * &liveupdate_file_handler.ops->freeze,
+ * &liveupdate_file_handler.ops->finish, etc.) and a unique 'compatible' string
+ * identifying the file type. Registration occurs via
+ * liveupdate_register_file_handler().
+ *
+ * 2. File Instance Tracking: When a potentially preservable file needs to be
+ * managed for live update, the core LUO logic (luo_preserve_file()) finds a
+ * compatible registered handler using its
+ * &liveupdate_file_handler.ops->can_preserve callback. If found,  an internal
+ * &struct luo_file instance is created, assigned a unique u64 'token', and
+ * added to a list.
+ *
+ * 3. State Persistence ...
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/err.h>
+#include <linux/file.h>
+#include <linux/kexec_handover.h>
+#include <linux/liveupdate.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/xarray.h>
+#include "luo_internal.h"
+
+/* Registered files. */
+static DECLARE_RWSEM(luo_file_handler_list_rwsem);
+static LIST_HEAD(luo_file_handler_list);
+
+/**
+ * struct luo_file_ser - Represents the serialized preserves files.
+ * @compatible:  File handler compatabile string.
+ * @files:   Private data
+ * @token:   User provided token for this file
+ *
+ * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
+ */
+struct luo_file_ser {
+	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
+	u64 data;
+	u64 token;
+} __packed;
+
+/**
+ * struct luo_file - Represents a file descriptor instance preserved
+ * across live update.
+ * @fh:            Pointer to the &struct liveupdate_file_handler containing
+ *                 the implementation of prepare, freeze, cancel, and finish
+ *                 operations specific to this file's type.
+ * @file:          A pointer to the kernel's &struct file object representing
+ *                 the open file descriptor that is being preserved.
+ * @private_data:  Internal storage used by the live update core framework
+ *                 between phases.
+ * @reclaimed:     Flag indicating whether this preserved file descriptor has
+ *                 been successfully 'reclaimed' (e.g., requested via an ioctl)
+ *                 by user-space or the owning kernel subsystem in the new
+ *                 kernel after the live update.
+ * @state:         The current state of file descriptor, it is allowed to
+ *                 prepare, freeze, and finish FDs before the global state
+ *                 switch.
+ * @mutex:         Lock to protect FD state, and allow independently to change
+ *                 the FD state compared to global state.
+ *
+ * This structure holds the necessary callbacks and context for managing a
+ * specific open file descriptor throughout the different phases of a live
+ * update process. Instances of this structure are typically allocated,
+ * populated with file-specific details (&file, &arg, callbacks, compatibility
+ * string, token), and linked into a central list managed by the LUO. The
+ * private_data field is used internally by the core logic to store state
+ * between phases.
+ */
+struct luo_file {
+	struct liveupdate_file_handler *fh;
+	struct file *file;
+	u64 private_data;
+	bool reclaimed;
+	enum liveupdate_state state;
+	struct mutex mutex;
+};
+
+static int luo_file_prepare_one(struct luo_file *h)
+{
+	int ret = 0;
+
+	guard(mutex)(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_NORMAL) {
+		if (h->fh->ops->prepare) {
+			ret = h->fh->ops->prepare(h->fh, h->file,
+						  &h->private_data);
+		}
+		if (!ret)
+			h->state = LIVEUPDATE_STATE_PREPARED;
+	} else {
+		WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_PREPARED &&
+			     h->state != LIVEUPDATE_STATE_FROZEN);
+	}
+
+	return ret;
+}
+
+static int luo_file_freeze_one(struct luo_file *h)
+{
+	int ret = 0;
+
+	guard(mutex)(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_PREPARED) {
+		if (h->fh->ops->freeze) {
+			ret = h->fh->ops->freeze(h->fh, h->file,
+						 &h->private_data);
+		}
+		if (!ret)
+			h->state = LIVEUPDATE_STATE_FROZEN;
+	} else {
+		WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_FROZEN);
+	}
+
+	return ret;
+}
+
+static void luo_file_finish_one(struct luo_file *h)
+{
+	guard(mutex)(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_UPDATED) {
+		if (h->fh->ops->finish) {
+			h->fh->ops->finish(h->fh, h->file, h->private_data,
+					   h->reclaimed);
+		}
+		h->state = LIVEUPDATE_STATE_NORMAL;
+	} else {
+		WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_NORMAL);
+	}
+}
+
+static void luo_file_cancel_one(struct luo_file *h)
+{
+	guard(mutex)(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_NORMAL)
+		return;
+
+	if (WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_PREPARED &&
+			 h->state != LIVEUPDATE_STATE_FROZEN)) {
+		return;
+	}
+
+	if (h->fh->ops->cancel)
+		h->fh->ops->cancel(h->fh, h->file, h->private_data);
+
+	h->private_data = 0;
+	h->state = LIVEUPDATE_STATE_NORMAL;
+}
+
+static void __luo_file_cancel(struct luo_session *session)
+{
+	unsigned long token;
+	struct luo_file *h;
+
+	xa_for_each(&session->files_xa, token, h)
+		luo_file_cancel_one(h);
+}
+
+int luo_file_prepare(struct luo_session *session)
+{
+	struct luo_file *luo_file;
+	struct luo_file_ser *ser;
+	unsigned long token;
+	size_t ser_size;
+	int ret = 0;
+	int i;
+
+	if (!session->count)
+		return 0;
+
+	ser_size = session->count * sizeof(struct luo_file_ser);
+	ser = luo_contig_alloc_preserve(ser_size);
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	i = 0;
+	xa_for_each(&session->files_xa, token, luo_file) {
+		ret = luo_file_prepare_one(luo_file);
+		if (ret < 0) {
+			pr_err("Prepare failed for session[%s] token[%#0llx] handler[%s] ret[%d]\n",
+			       session->name, (u64)token, luo_file->fh->compatible, ret);
+			goto exit_cleanup;
+		}
+
+		strscpy(ser[i].compatible, luo_file->fh->compatible,
+			sizeof(ser[i].compatible));
+		ser[i].data = luo_file->private_data;
+		ser[i].token = token;
+		i++;
+	}
+
+	session->files = __pa(ser);
+
+	return 0;
+
+exit_cleanup:
+	__luo_file_cancel(session);
+	luo_contig_free_unpreserve(ser, ser_size);
+
+	return ret;
+}
+
+int luo_file_freeze(struct luo_session *session)
+{
+	struct luo_file *luo_file;
+	struct luo_file_ser *ser;
+	unsigned long token;
+	size_t ser_size;
+	int ret = 0;
+	int i;
+
+	if (!session->count)
+		return 0;
+
+	if (WARN_ON(!session->files))
+		return -EINVAL;
+
+	ser = __va(session->files);
+
+	i = 0;
+	xa_for_each(&session->files_xa, token, luo_file) {
+		ret = luo_file_freeze_one(luo_file);
+		if (ret < 0) {
+			pr_err("Freeze failed for session[%s] token[%#0llx] handler[%s] ret[%d]\n",
+			       session->name, (u64)token, luo_file->fh->compatible, ret);
+			goto exit_cleanup;
+		}
+		ser[i].data = luo_file->private_data;
+		i++;
+	}
+
+	return 0;
+
+exit_cleanup:
+	__luo_file_cancel(session);
+	ser_size = session->count * sizeof(struct luo_file_ser);
+	luo_contig_free_unpreserve(ser, ser_size);
+
+	return ret;
+}
+
+void luo_file_finish(struct luo_session *session)
+{
+	struct luo_file *luo_file;
+	struct luo_file_ser *ser;
+	unsigned long token;
+	size_t ser_size;
+
+	if (!session->count)
+		return;
+
+	xa_for_each(&session->files_xa, token, luo_file)
+		luo_file_finish_one(luo_file);
+
+	ser_size = session->count * sizeof(struct luo_file_ser);
+	ser = __va(session->files);
+	luo_contig_free_restore(ser, ser_size);
+}
+
+void luo_file_cancel(struct luo_session *session)
+{
+	struct luo_file_ser *ser;
+	size_t ser_size;
+
+	if (!session->count)
+		return;
+
+	__luo_file_cancel(session);
+
+	if (session->files) {
+		ser = __va(session->files);
+		ser_size = session->count * sizeof(struct luo_file_ser);
+		luo_contig_free_unpreserve(ser, ser_size);
+		session->files = 0;
+	}
+}
+
+void luo_file_deserialize(struct luo_session *session)
+{
+	struct luo_file_ser *ser;
+	u64 i;
+
+	if (!session->files)
+		return;
+
+	guard(rwsem_read)(&luo_file_handler_list_rwsem);
+	ser = __va(session->files);
+	for (i = 0; i < session->count; i++) {
+		struct liveupdate_file_handler *fh;
+		bool handler_found = false;
+		struct luo_file *luo_file;
+		int ret;
+
+		if (xa_load(&session->files_xa, ser[i].token)) {
+			luo_restore_fail("Duplicate token %llu found in incoming FDT for file descriptors.\n",
+					 ser[i].token);
+		}
+
+		list_for_each_entry(fh, &luo_file_handler_list, list) {
+			if (!strcmp(fh->compatible, ser[i].compatible)) {
+				handler_found = true;
+				break;
+			}
+		}
+
+		if (!handler_found) {
+			luo_restore_fail("No registered handler for compatible '%s'\n",
+					 ser[i].compatible);
+		}
+
+		luo_file = kzalloc(sizeof(*luo_file),
+				   GFP_KERNEL | __GFP_NOFAIL);
+		luo_file->fh = fh;
+		luo_file->file = NULL;
+		luo_file->private_data = ser[i].data;
+		luo_file->reclaimed = false;
+		mutex_init(&luo_file->mutex);
+		luo_file->state = LIVEUPDATE_STATE_UPDATED;
+		ret = xa_err(xa_store(&session->files_xa, ser[i].token,
+				      luo_file, GFP_KERNEL | __GFP_NOFAIL));
+		if (ret < 0) {
+			luo_restore_fail("Failed to store luo_file for token %llu in XArray: %d\n",
+					 ser[i].token, ret);
+		}
+	}
+}
+
+/**
+ * luo_preserve_file - Register a file descriptor for live update management.
+ * @token: Token value for this file descriptor.
+ * @fd: file descriptor to be preserved.
+ *
+ * Context: Must be called when LUO is in 'normal' state.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int luo_preserve_file(struct luo_session *session, u64 token, int fd)
+{
+	struct liveupdate_file_handler *fh;
+	struct luo_file *luo_file;
+	bool found = false;
+	int ret = -ENOENT;
+	struct file *file;
+
+	file = fget(fd);
+	if (!file) {
+		pr_err("Bad file descriptor\n");
+		return -EBADF;
+	}
+
+	guard(rwsem_read)(&luo_file_handler_list_rwsem);
+	list_for_each_entry(fh, &luo_file_handler_list, list) {
+		if (fh->ops->can_preserve(fh, file)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		goto exit_cleanup;
+
+	luo_file = kzalloc(sizeof(*luo_file), GFP_KERNEL);
+	if (!luo_file) {
+		ret = -ENOMEM;
+		goto exit_cleanup;
+	}
+
+	luo_file->private_data = 0;
+	luo_file->reclaimed = false;
+
+	luo_file->file = file;
+	luo_file->fh = fh;
+	mutex_init(&luo_file->mutex);
+	luo_file->state = LIVEUPDATE_STATE_NORMAL;
+
+	if (xa_load(&session->files_xa, token)) {
+		ret = -EEXIST;
+		pr_warn("Token %llu is already taken\n", token);
+		mutex_destroy(&luo_file->mutex);
+		kfree(luo_file);
+		goto exit_cleanup;
+	}
+
+	ret = xa_err(xa_store(&session->files_xa, token, luo_file,
+			      GFP_KERNEL));
+	if (ret < 0) {
+		pr_warn("Failed to store file for token %llu in XArray: %d\n",
+			token, ret);
+		mutex_destroy(&luo_file->mutex);
+		kfree(luo_file);
+		goto exit_cleanup;
+	}
+	atomic_inc(&luo_file->fh->count);
+	session->count++;
+
+exit_cleanup:
+	if (ret)
+		fput(file);
+
+	return ret;
+}
+
+/**
+ * luo_unpreserve_file - Unregister a file instance using its token.
+ * @token: The unique token of the file instance to unregister.
+ *
+ * Finds the &struct luo_file associated with the @token in the
+ * global list and removes it. This function *only* removes the entry from the
+ * list; it does *not* free the memory allocated for the &struct luo_file
+ * itself. The caller is responsible for freeing the structure after this
+ * function returns successfully.
+ *
+ * Context: Can be called when a preserved file descriptor is closed or
+ * no longer needs live update management.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int luo_unpreserve_file(struct luo_session *session, u64 token)
+{
+	struct luo_file *luo_file;
+
+	luo_file = xa_erase(&session->files_xa, token);
+	if (!luo_file)
+		return -ENOENT;
+
+	if (luo_file->file)
+		fput(luo_file->file);
+	mutex_destroy(&luo_file->mutex);
+	scoped_guard(rwsem_read, &luo_file_handler_list_rwsem)
+		atomic_dec(&luo_file->fh->count);
+	kfree(luo_file);
+	session->count--;
+
+	return 0;
+}
+
+/**
+ * luo_retrieve_file - Find a registered file instance by its token.
+ * @token: The unique token of the file instance to retrieve.
+ * @filep: Output parameter. On success (return value 0), this will point
+ * to the retrieved "struct file".
+ *
+ * Searches the global list for a &struct luo_file matching the @token. Uses a
+ * read lock, allowing concurrent retrievals.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int luo_retrieve_file(struct luo_session *session, u64 token,
+		      struct file **filep)
+{
+	struct luo_file *luo_file;
+	int ret = 0;
+
+	luo_file = xa_load(&session->files_xa, token);
+	if (!luo_file)
+		return -ENOENT;
+
+	if (luo_file->reclaimed)
+		return -EADDRINUSE;
+
+	guard(mutex)(&luo_file->mutex);
+	if (luo_file->reclaimed)
+		return -EADDRINUSE;
+
+	ret = luo_file->fh->ops->retrieve(luo_file->fh, luo_file->private_data,
+					  filep);
+	if (!ret) {
+		/* Get a reference so, we can keep this file in LUO */
+		luo_file->file = *filep;
+		get_file(luo_file->file);
+		luo_file->reclaimed = true;
+	}
+
+	return ret;
+}
+
+void luo_file_unpreserve_all_files(struct luo_session *session)
+{
+	unsigned long token;
+	struct luo_file *h;
+
+	xa_for_each(&session->files_xa, token, h)
+		luo_unpreserve_file(session, token);
+}
+
+void luo_file_unpreserve_unreclaimed_files(struct luo_session *session)
+{
+	unsigned long token;
+	struct luo_file *h;
+
+	xa_for_each(&session->files_xa, token, h) {
+		if (!h->reclaimed) {
+			pr_err("Unpreserving unreclaimed file, session[%s] token[%#0llx] handler[%s]\n",
+			       session->name, (u64)token, h->fh->compatible);
+			luo_unpreserve_file(session, token);
+		}
+	}
+}
+
+/**
+ * liveupdate_register_file_handler - Register a file handler with LUO.
+ * @fh: Pointer to a caller-allocated &struct liveupdate_file_handler.
+ * The caller must initialize this structure, including a unique
+ * 'compatible' string and a valid 'fh' callbacks. This function adds the
+ * handler to the global list of supported file handlers.
+ *
+ * Context: Typically called during module initialization for file types that
+ * support live update preservation.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
+{
+	struct liveupdate_file_handler *fh_iter;
+
+	guard(rwsem_read)(&luo_state_rwsem);
+	if (!liveupdate_state_normal() && !liveupdate_state_updated())
+		return -EBUSY;
+
+	guard(rwsem_write)(&luo_file_handler_list_rwsem);
+	list_for_each_entry(fh_iter, &luo_file_handler_list, list) {
+		if (!strcmp(fh_iter->compatible, fh->compatible)) {
+			pr_err("File handler registration failed: Compatible string '%s' already registered.\n",
+			       fh->compatible);
+			return -EEXIST;
+		}
+	}
+
+	if (!try_module_get(fh->ops->owner))
+		return -EAGAIN;
+
+	INIT_LIST_HEAD(&fh->list);
+	atomic_set(&fh->count, 0);
+	list_add_tail(&fh->list, &luo_file_handler_list);
+
+	return 0;
+}
+
+/**
+ * liveupdate_unregister_file - Unregister a file handler.
+ * @fh: Pointer to the specific &struct liveupdate_file_handler instance
+ * that was previously returned by or passed to
+ * liveupdate_register_file_handler.
+ *
+ * Removes the specified handler instance @fh from the global list of
+ * registered file handlers. This function only removes the entry from the
+ * list; it does not free the memory associated with @fh itself. The caller
+ * is responsible for freeing the structure memory after this function returns
+ * successfully.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
+{
+	guard(rwsem_read)(&luo_state_rwsem);
+	if (!liveupdate_state_normal() && !liveupdate_state_updated())
+		return -EBUSY;
+
+	guard(rwsem_write)(&luo_file_handler_list_rwsem);
+	if (atomic_read(&fh->count)) {
+		pr_warn("Unable to unregister file handler, files are preserved\n");
+		return -EBUSY;
+	}
+
+	list_del_init(&fh->list);
+	module_put(fh->ops->owner);
+
+	return 0;
+}
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index a14e0b685ccb..c9bce82aac22 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -8,6 +8,8 @@
 #ifndef _LINUX_LUO_INTERNAL_H
 #define _LINUX_LUO_INTERNAL_H
 
+#include <linux/liveupdate.h>
+
 /*
  * Handles a deserialization failure: devices and memory is in unpredictable
  * state.
@@ -93,4 +95,16 @@ int luo_do_subsystems_freeze_calls(void);
 void luo_do_subsystems_finish_calls(void);
 void luo_do_subsystems_cancel_calls(void);
 
+int luo_retrieve_file(struct luo_session *session, u64 token, struct file **filep);
+int luo_preserve_file(struct luo_session *session, u64 token, int fd);
+int luo_unpreserve_file(struct luo_session *session, u64 token);
+void luo_file_unpreserve_all_files(struct luo_session *session);
+void luo_file_unpreserve_unreclaimed_files(struct luo_session *session);
+
+int luo_file_prepare(struct luo_session *session);
+int luo_file_freeze(struct luo_session *session);
+void luo_file_finish(struct luo_session *session);
+void luo_file_cancel(struct luo_session *session);
+void luo_file_deserialize(struct luo_session *session);
+
 #endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.51.0.536.g15c5d4f767-goog


