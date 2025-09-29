Return-Path: <linux-api+bounces-4964-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF5EBA7B3E
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 03:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A7A3BBDD3
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 01:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C926A1A3;
	Mon, 29 Sep 2025 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RxEmgXlF"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2102571D8
	for <linux-api@vger.kernel.org>; Mon, 29 Sep 2025 01:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107881; cv=none; b=h36AEgkBll9FiqRBRBS0KMFaGFmBWFVg1Wm2ZkxjxxyJMyuUuBU7Tx6yNYZA2gDuUnhguvMUA6OYZo1QyisqHLpORKowyuSdHzKwI70xzde2+2y17X5mofkjBsL8jNY3p7FBY3/VSocpEG3p79p7mugNoQZbiiRfY8tz2UMxP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107881; c=relaxed/simple;
	bh=3gwWJy7+z6EF8lOvRyZj4VhN2DeytbPF5iMG3aF/JqQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYyESxNc9nkpc8paKvsuYlN8YhwZOhgMu1mKTdMEGucfrlvsZCe9Ty7P4olvTou401ecZpOXZnHInM7O59Lfclb6OQPaflGwMW7u0b1nzorGCLSo03zxJs+6Iq+bZjvOIZDzKsK2upmG0VXU/gvj6uoUMCUGbl5qFOs+CmOiuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=RxEmgXlF; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4d142e9903fso26843381cf.0
        for <linux-api@vger.kernel.org>; Sun, 28 Sep 2025 18:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107878; x=1759712678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SG9/lgBnsjBu7n3rYE1T/HXPjWC8Lull3DU31VlVdZs=;
        b=RxEmgXlFzaYGr8Lsn0mPk41DSW22CAJYCxjUqZiDg6AEEoJu9EELaEWVCaTeF7Qdva
         nJTfK5tVsF4tfwisKBEVj0vVkX+Yjy5B2t70UHjGUwmBSwfe+jO0JUvPoyWdYjNfFex4
         rmpk5q6YpUMHbNBzVj6BU7p1hLCzMB1GcRHm0MHGl/LtfQRUz+X1q6DoeP7CZ8YeTp7Q
         L36DTBlN6cyUDLpAID6mcAsdcz7losQYtpzgylvggeQOo5cfUmjSZnAh+fb8Wmm2pSo/
         rDpbVBOxRclg4vKmvt6aTJ3pOY4xyuysr55t84itEPXRog0w/+Zhxx4YZ9jVZoetvue5
         wdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107878; x=1759712678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SG9/lgBnsjBu7n3rYE1T/HXPjWC8Lull3DU31VlVdZs=;
        b=ib54u5+xUgbo7759kJa48kCqvkhWn+CBUP268EDW9K+lq/zVGfuqf7o58h8e2KFbYq
         WTOaGoDutQR6AJxD2P0sri2piMtmHi9AnNE06GZ+VXqPgpKJYC+JHPrLIcRajBA3DPD3
         vdDz3GJWQhCyuOSTCwwJJXCWdcGyJccnHDDMg7pXbhCTsaX0PLs08FznKGlI9J/QZ4um
         HQiO67wJovFe4V6K3Vbm/0wEj3dKLhRrH3ebih2Ky8TYdmpThScXxsVxEANr1VLwryGL
         HfMMYV9DmBFNmFSPhfnoGjr0XHHs6q2EaZrpfbKVuL0MH1OUqVVgW+yDDrlcSs+9xYbV
         hJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD9O3wGYbO8BhhWbIMoesupGBK9xpkqfWTtNlWYNfhQme4mKPrsAqiFBg26eDyoBcEDssM0C6WHlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwIDArvwz7YHls+vBodZAv6aClbVX4wOvk+SBsF/2pytCzY1yH
	nmrbdB9CqrLQREHKT+kPZTxBkpfhdh5JtfC7AYuwsUS6bnTrx0WE2/UpWU2W9b4PlK4=
X-Gm-Gg: ASbGncunhYbj6WJsH7GWfaQSmkXy6RMv0jqxLZ06JNcB4+xiBJNRRcAPxaDU9exMPS2
	vljH1i95lTgrA1EzW1bx6T9XYk8Mnxj9KZlijQv0NbCDhaVDP58yM4iRcep1F1FUnPOnIeOGq7v
	ELhRTsHkevlFzt+Af4UIcMReXjEc8QZ+PwBwipIkfrsLsfxVDLZ4ZrSzpygjcLswC0SqdQI1Udv
	nd2ZWLJWjFSEQH7SOj48t0Wf8mTqfVffybakf4re6oG02gH2+536V3RikA2eh18juy/LmipiKQx
	2TMtUOFUr33NcnXeDg7jtqLWLcCyFxF+7IKMhq/BmkwFm9q7hJGvGVNwj2pXUXz2yMhrumzhzWa
	lmMdtnErSETT/x0FHV9SZWJUNncIjA5qlD8nQTKRXo5rOAWR15D/DmuAEWbFp+B0MYJU9aIGQVD
	L97oi0Ejo=
X-Google-Smtp-Source: AGHT+IFBSJGsiJuTnL3aTk6ORRLg5HvmtexVkNoDC0xgqOUWiBHy/Femj87R1xZ3CMujKVmOA+t67A==
X-Received: by 2002:ac8:7e89:0:b0:4dd:c935:93cc with SMTP id d75a77b69052e-4ddc944e0d0mr126398441cf.84.1759107877691;
        Sun, 28 Sep 2025 18:04:37 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:37 -0700 (PDT)
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
Subject: [PATCH v4 17/30] liveupdate: add selftests for subsystems un/registration
Date: Mon, 29 Sep 2025 01:03:08 +0000
Message-ID: <20250929010321.3462457-18-pasha.tatashin@soleen.com>
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

Introduce a self-test mechanism for the LUO to allow verification of
core subsystem management functionality. This is primarily intended
for developers and system integrators validating the live update
feature.

The tests are enabled via the new Kconfig option
CONFIG_LIVEUPDATE_SELFTESTS (default 'n') and are triggered through
a new ioctl command, LIVEUPDATE_IOCTL_SELFTESTS, added to the
/dev/liveupdate device node.

This ioctl accepts commands defined in luo_selftests.h to:
- LUO_CMD_SUBSYSTEM_REGISTER: Creates and registers a dummy LUO
  subsystem using the liveupdate_register_subsystem() function. It
  allocates a data page and copies initial data from userspace.
- LUO_CMD_SUBSYSTEM_UNREGISTER: Unregisters the specified dummy
  subsystem using the liveupdate_unregister_subsystem() function and
  cleans up associated test resources.
- LUO_CMD_SUBSYSTEM_GETDATA: Copies the data page associated with a
  registered test subsystem back to userspace, allowing verification of
  data potentially modified or preserved by test callbacks.

This provides a way to test the fundamental registration and
unregistration flows within the LUO framework from userspace without
requiring a full live update sequence.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/Kconfig         |  15 ++
 kernel/liveupdate/Makefile        |   1 +
 kernel/liveupdate/luo_selftests.c | 345 ++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_selftests.h |  84 ++++++++
 4 files changed, 445 insertions(+)
 create mode 100644 kernel/liveupdate/luo_selftests.c
 create mode 100644 kernel/liveupdate/luo_selftests.h

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index f6b0bde188d9..8311c2593d32 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -29,6 +29,21 @@ config LIVEUPDATE
 
 	  If unsure, say N.
 
+config LIVEUPDATE_SELFTESTS
+	bool "Live Update Orchestrator - self-tests"
+	depends on LIVEUPDATE
+	help
+	  Say Y here to build self-tests for the LUO framework. When enabled,
+	  these tests can be initiated via the ioctl interface to help verify
+	  the core live update functionality.
+
+	  This option is primarily intended for developers working on the
+	  live update feature or for validation purposes during system
+	  integration.
+
+	  If you are unsure or are building a production kernel where size
+	  or attack surface is a concern, say N.
+
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index 282d36a18993..2df7dfdf45c1 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
+obj-$(CONFIG_LIVEUPDATE_SELFTESTS)	+= luo_selftests.o
diff --git a/kernel/liveupdate/luo_selftests.c b/kernel/liveupdate/luo_selftests.c
new file mode 100644
index 000000000000..a476b88468fa
--- /dev/null
+++ b/kernel/liveupdate/luo_selftests.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: LUO Selftests
+ *
+ * We provide ioctl-based selftest interface for the LUO. It provides a
+ * mechanism to test core LUO functionality, particularly the registration,
+ * unregistration, and data handling aspects of LUO subsystems, without
+ * requiring a full live update event sequence.
+ *
+ * The tests are intended primarily for developers working on the LUO framework
+ * or for validation purposes during system integration. This functionality is
+ * conditionally compiled based on the `CONFIG_LIVEUPDATE_SELFTESTS` Kconfig
+ * option and should typically be disabled in production kernels.
+ *
+ * Interface:
+ * The selftests are accessed via the `/dev/liveupdate` character device using
+ * the `LIVEUPDATE_IOCTL_SELFTESTS` ioctl command. The argument to the ioctl
+ * is a pointer to a `struct liveupdate_selftest` structure (defined in
+ * `uapi/linux/liveupdate.h`), which contains:
+ * - `cmd`: The specific selftest command to execute (e.g.,
+ * `LUO_CMD_SUBSYSTEM_REGISTER`).
+ * - `arg`: A pointer to a command-specific argument structure. For subsystem
+ * tests, this points to a `struct luo_arg_subsystem` (defined in
+ * `luo_selftests.h`).
+ *
+ * Commands:
+ * - `LUO_CMD_SUBSYSTEM_REGISTER`:
+ * Registers a new dummy LUO subsystem. It allocates kernel memory for test
+ * data, copies initial data from the user-provided `data_page`, sets up
+ * simple logging callbacks, and calls the core
+ * `liveupdate_register_subsystem()`
+ * function. Requires `arg` pointing to `struct luo_arg_subsystem`.
+ * - `LUO_CMD_SUBSYSTEM_UNREGISTER`:
+ * Unregisters a previously registered dummy subsystem identified by `name`.
+ * It calls the core `liveupdate_unregister_subsystem()` function and then
+ * frees the associated kernel memory and internal tracking structures.
+ * Requires `arg` pointing to `struct luo_arg_subsystem` (only `name` used).
+ * - `LUO_CMD_SUBSYSTEM_GETDATA`:
+ * Copies the content of the kernel data page associated with the specified
+ * dummy subsystem (`name`) back to the user-provided `data_page`. This allows
+ * userspace to verify the state of the data after potential test operations.
+ * Requires `arg` pointing to `struct luo_arg_subsystem`.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/debugfs.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/kexec_handover.h>
+#include <linux/liveupdate.h>
+#include <linux/mutex.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/liveupdate.h>
+#include "luo_internal.h"
+#include "luo_selftests.h"
+
+static struct luo_subsystems {
+	struct liveupdate_subsystem handle;
+	char name[LUO_NAME_LENGTH];
+	void *data;
+	bool in_use;
+	bool preserved;
+} luo_subsystems[LUO_MAX_SUBSYSTEMS];
+
+/* Only allow one selftest ioctl operation at a time */
+static DEFINE_MUTEX(luo_ioctl_mutex);
+
+static int luo_subsystem_prepare(struct liveupdate_subsystem *h, u64 *data)
+{
+	struct luo_subsystems *s = container_of(h, struct luo_subsystems,
+						handle);
+	unsigned long phys_addr = __pa(s->data);
+	int ret;
+
+	ret = kho_preserve_pages(phys_to_page(phys_addr), 1);
+	if (ret)
+		return ret;
+
+	s->preserved = true;
+	*data = phys_addr;
+	pr_info("Subsystem '%s' prepare data[%lx]\n",
+		s->name, phys_addr);
+
+	if (strstr(s->name, NAME_PREPARE_FAIL))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static int luo_subsystem_freeze(struct liveupdate_subsystem *h, u64 *data)
+{
+	struct luo_subsystems *s = container_of(h, struct luo_subsystems,
+						handle);
+
+	pr_info("Subsystem '%s' freeze data[%llx]\n", s->name, *data);
+
+	return 0;
+}
+
+static void luo_subsystem_cancel(struct liveupdate_subsystem *h, u64 data)
+{
+	struct luo_subsystems *s = container_of(h, struct luo_subsystems,
+						handle);
+
+	pr_info("Subsystem '%s' canel data[%llx]\n", s->name, data);
+	s->preserved = false;
+	WARN_ON(kho_unpreserve_pages(phys_to_page(data), 1));
+}
+
+static void luo_subsystem_finish(struct liveupdate_subsystem *h, u64 data)
+{
+	struct luo_subsystems *s = container_of(h, struct luo_subsystems,
+						handle);
+
+	pr_info("Subsystem '%s' finish data[%llx]\n", s->name, data);
+}
+
+static const struct liveupdate_subsystem_ops luo_selftest_subsys_ops = {
+	.prepare = luo_subsystem_prepare,
+	.freeze = luo_subsystem_freeze,
+	.cancel = luo_subsystem_cancel,
+	.finish = luo_subsystem_finish,
+	.owner = THIS_MODULE,
+};
+
+static int luo_subsystem_idx(char *name)
+{
+	int i;
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++) {
+		if (luo_subsystems[i].in_use &&
+		    !strcmp(luo_subsystems[i].name, name))
+			break;
+	}
+
+	if (i == LUO_MAX_SUBSYSTEMS) {
+		pr_warn("Subsystem with name '%s' is not registred\n", name);
+
+		return -EINVAL;
+	}
+
+	return i;
+}
+
+static void luo_put_and_free_subsystem(char *name)
+{
+	int i = luo_subsystem_idx(name);
+
+	if (i < 0)
+		return;
+
+	if (luo_subsystems[i].preserved)
+		kho_unpreserve_pages(virt_to_page(luo_subsystems[i].data), 1);
+	free_page((unsigned long)luo_subsystems[i].data);
+	luo_subsystems[i].in_use = false;
+	luo_subsystems[i].preserved = false;
+}
+
+static int luo_get_and_alloc_subsystem(char *name, void __user *data,
+				       struct liveupdate_subsystem **hp)
+{
+	unsigned long page_addr, i;
+
+	page_addr = get_zeroed_page(GFP_KERNEL);
+	if (!page_addr) {
+		pr_warn("Failed to allocate memory for subsystem data\n");
+		return -ENOMEM;
+	}
+
+	if (copy_from_user((void *)page_addr, data, PAGE_SIZE)) {
+		free_page(page_addr);
+		return -EFAULT;
+	}
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++) {
+		if (!luo_subsystems[i].in_use)
+			break;
+	}
+
+	if (i == LUO_MAX_SUBSYSTEMS) {
+		pr_warn("Maximum number of subsystems registered\n");
+		free_page(page_addr);
+		return -ENOMEM;
+	}
+
+	luo_subsystems[i].in_use = true;
+	luo_subsystems[i].handle.ops = &luo_selftest_subsys_ops;
+	luo_subsystems[i].handle.name = luo_subsystems[i].name;
+	strscpy(luo_subsystems[i].name, name, LUO_NAME_LENGTH);
+	luo_subsystems[i].data = (void *)page_addr;
+
+	*hp = &luo_subsystems[i].handle;
+
+	return 0;
+}
+
+static int luo_cmd_subsystem_unregister(void __user *argp)
+{
+	struct luo_arg_subsystem arg;
+	int ret, i;
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	i = luo_subsystem_idx(arg.name);
+	if (i < 0)
+		return i;
+
+	ret = liveupdate_unregister_subsystem(&luo_subsystems[i].handle);
+	if (ret)
+		return ret;
+
+	luo_put_and_free_subsystem(arg.name);
+
+	return 0;
+}
+
+static int luo_cmd_subsystem_register(void __user *argp)
+{
+	struct liveupdate_subsystem *h;
+	struct luo_arg_subsystem arg;
+	int ret;
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	ret = luo_get_and_alloc_subsystem(arg.name,
+					  (void __user *)arg.data_page, &h);
+	if (ret)
+		return ret;
+
+	ret = liveupdate_register_subsystem(h);
+	if (ret)
+		luo_put_and_free_subsystem(arg.name);
+
+	return ret;
+}
+
+static int luo_cmd_subsystem_getdata(void __user *argp)
+{
+	struct luo_arg_subsystem arg;
+	int i;
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	i = luo_subsystem_idx(arg.name);
+	if (i < 0)
+		return i;
+
+	if (copy_to_user(arg.data_page, luo_subsystems[i].data,
+			 PAGE_SIZE)) {
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int luo_ioctl_selftests(void __user *argp)
+{
+	struct liveupdate_selftest luo_st;
+	void __user *cmd_argp;
+	int ret = 0;
+
+	if (copy_from_user(&luo_st, argp, sizeof(luo_st)))
+		return -EFAULT;
+
+	cmd_argp = (void __user *)luo_st.arg;
+
+	mutex_lock(&luo_ioctl_mutex);
+	switch (luo_st.cmd) {
+	case LUO_CMD_SUBSYSTEM_REGISTER:
+		ret =  luo_cmd_subsystem_register(cmd_argp);
+		break;
+
+	case LUO_CMD_SUBSYSTEM_UNREGISTER:
+		ret =  luo_cmd_subsystem_unregister(cmd_argp);
+		break;
+
+	case LUO_CMD_SUBSYSTEM_GETDATA:
+		ret = luo_cmd_subsystem_getdata(cmd_argp);
+		break;
+
+	default:
+		pr_warn("ioctl: unknown self-test command nr: 0x%llx\n",
+			luo_st.cmd);
+		ret = -ENOTTY;
+		break;
+	}
+	mutex_unlock(&luo_ioctl_mutex);
+
+	return ret;
+}
+
+static long luo_selftest_ioctl(struct file *filep, unsigned int cmd,
+			       unsigned long arg)
+{
+	int ret = 0;
+
+	if (_IOC_TYPE(cmd) != LIVEUPDATE_IOCTL_TYPE)
+		return -ENOTTY;
+
+	switch (cmd) {
+	case LIVEUPDATE_IOCTL_FREEZE:
+		ret = luo_freeze();
+		break;
+
+	case LIVEUPDATE_IOCTL_SELFTESTS:
+		ret = luo_ioctl_selftests((void __user *)arg);
+		break;
+
+	default:
+		pr_warn("ioctl: unknown command nr: 0x%x\n", _IOC_NR(cmd));
+		ret = -ENOTTY;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations luo_selftest_fops = {
+	.open = nonseekable_open,
+	.unlocked_ioctl = luo_selftest_ioctl,
+};
+
+static int __init luo_seltesttest_init(void)
+{
+	if (!liveupdate_debugfs_root) {
+		pr_err("liveupdate root is not set\n");
+		return 0;
+	}
+	debugfs_create_file_unsafe("luo_selftest", 0600,
+				   liveupdate_debugfs_root, NULL,
+				   &luo_selftest_fops);
+	return 0;
+}
+
+late_initcall(luo_seltesttest_init);
diff --git a/kernel/liveupdate/luo_selftests.h b/kernel/liveupdate/luo_selftests.h
new file mode 100644
index 000000000000..098f2e9e6a78
--- /dev/null
+++ b/kernel/liveupdate/luo_selftests.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _LINUX_LUO_SELFTESTS_H
+#define _LINUX_LUO_SELFTESTS_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* Maximum number of subsystem self-test can register */
+#define LUO_MAX_SUBSYSTEMS		16
+#define LUO_NAME_LENGTH			32
+
+#define LUO_CMD_SUBSYSTEM_REGISTER	0
+#define LUO_CMD_SUBSYSTEM_UNREGISTER	1
+#define LUO_CMD_SUBSYSTEM_GETDATA	2
+struct luo_arg_subsystem {
+	char name[LUO_NAME_LENGTH];
+	void *data_page;
+};
+
+/*
+ * Test name prefixes:
+ * normal: prepare and freeze callbacks do not fail
+ * prepare_fail: prepare callback fails for this test.
+ * freeze_fail: freeze callback fails for this test
+ */
+#define NAME_NORMAL		"ksft_luo"
+#define NAME_PREPARE_FAIL	"ksft_prepare_fail"
+#define NAME_FREEZE_FAIL	"ksft_freeze_fail"
+
+/**
+ * struct liveupdate_selftest - Holds directions for the self-test operations.
+ * @cmd:    Selftest comman defined in luo_selftests.h.
+ * @arg:    Argument for the self test command.
+ *
+ * This structure is used only for the selftest purposes.
+ */
+struct liveupdate_selftest {
+	__u64		cmd;
+	__u64		arg;
+};
+
+/**
+ * LIVEUPDATE_IOCTL_FREEZE - Notify subsystems of imminent reboot
+ * transition.
+ *
+ * Argument: None.
+ *
+ * Notifies the live update subsystem and associated components that the kernel
+ * is about to execute the final reboot transition into the new kernel (e.g.,
+ * via kexec). This action triggers the internal %LIVEUPDATE_FREEZE kernel
+ * event. This event provides subsystems a final, brief opportunity (within the
+ * "blackout window") to save critical state or perform last-moment quiescing.
+ * Any remaining or deferred state saving for items marked via the PRESERVE
+ * ioctls typically occurs in response to the %LIVEUPDATE_FREEZE event.
+ *
+ * This ioctl should only be called when the system is in the
+ * %LIVEUPDATE_STATE_PREPARED state. This command does not transfer data.
+ *
+ * Return: 0 if the notification is successfully processed by the kernel (but
+ * reboot follows). Returns a negative error code if the notification fails
+ * or if the system is not in the %LIVEUPDATE_STATE_PREPARED state.
+ */
+#define LIVEUPDATE_IOCTL_FREEZE						\
+	_IO(LIVEUPDATE_IOCTL_TYPE, 0x05)
+
+/**
+ * LIVEUPDATE_IOCTL_SELFTESTS - Interface for the LUO selftests
+ *
+ * Argument: Pointer to &struct liveupdate_selftest.
+ *
+ * Use by LUO selftests, commands are declared in luo_selftests.h
+ *
+ * Return: 0 on success, negative error code on failure (e.g., invalid token).
+ */
+#define LIVEUPDATE_IOCTL_SELFTESTS					\
+	_IOWR(LIVEUPDATE_IOCTL_TYPE, 0x08, struct liveupdate_selftest)
+
+#endif /* _LINUX_LUO_SELFTESTS_H */
-- 
2.51.0.536.g15c5d4f767-goog


