Return-Path: <linux-api+bounces-4345-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC98B1D057
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 03:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DEF568FD0
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC6221545;
	Thu,  7 Aug 2025 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jHxeYx+a"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF521B9E7
	for <linux-api@vger.kernel.org>; Thu,  7 Aug 2025 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531107; cv=none; b=EEP2wX2LKrPMzdAc6r5493EdD4MhbQkt9dsQaAzQpNk/3JhmKIaHNeGXYWfsnPdT5YXsq3KgH2QlQm9hVJUMp5rKdyqdYplr6hJQcpo5FHxg++Dg/mq06EmcKpFDbtpAGx8MzsV+hO8dbpzOuiZ5WvQZ1CmYtcRVfyRyYOaIhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531107; c=relaxed/simple;
	bh=T9mSQcqqhj5wozcCZeXjtsKsPvQoMlz6uMFHkaNKny0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAS6e+SjNAOe3ZBVhSWLi/LQnKr6on9mHjCAovvZVAbFRJHOBYzbNp6BhdXVyNKUpotEbChvvY9I5Qlw+HeMXKedPvMgL+H/EuiSEBMcgdN3SBRt2II+bk6ZbNbm69FnnnC06UcvfFIpNMZf8dzbIUYPoDXRUa9gwTNc4oSCLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jHxeYx+a; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70748a0e13dso4959376d6.1
        for <linux-api@vger.kernel.org>; Wed, 06 Aug 2025 18:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531104; x=1755135904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQpmpulpEMbleZBgXGFUqWXbMNM3g038MqdeBg/kxjU=;
        b=jHxeYx+aIajj5KA7QJ5yGEJbgNTPGOet5S+wgm0iul1wAeOx5HDP2t/vcVUHEJHPq3
         pUmHFAnFppE51LDbeCeXmE+R5gzNiTBUdhTivkYerrfVrJLVubSEtfivId+KphPQVEpg
         BFDxw5w7TPtXLNtgPNCiXzu/55s0x7OVUNAlS6aE1ZrWVEI6/SsfVPL7zUMZWq/50NNi
         UwoHiVCDwy+Vbt72PcGOT8lN0OcGTNcJ2HOp3xoMVyh7BvKLIERqznJDTpuuwTDN5E5T
         iOT7V6Zem42nZg7yYOYbW6Bo9PYpu7lVmkByvAkkmEEYopCJnhixWLxNbob3S4O9UBwU
         c6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531104; x=1755135904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQpmpulpEMbleZBgXGFUqWXbMNM3g038MqdeBg/kxjU=;
        b=NQRUWd4xtjeeTjGV7iW0/vAHcJ0X+3llN5B8GWkTJK8RUCSkMY67/3jaq5L4ey6t3T
         650gCOoVzEjYSKJKawwvmSZjaE/0xS/iH1OGjxsJhWXEiY4fbxd4I6ChRVUtOtOxR/nm
         tGVd6OEZknCHrXQkSgVcNy8uNJNCyVxusZEMvwhwK8ISa+3TWfr+OzP2Q3YAZ0apC8z4
         uWhT+4ij0QWMFOjK0uNOV5HC43A0EHscJi0aPIDsadt7SzDIb+oXiUvZ+ylpsehIIZzz
         bkxKH9t7VNEOUvJTPzeWZPLfXSvW5A4Ww89n0dpUlKLk48V3A3Q8Y1cLjvmbvZ0GyJb6
         cHvA==
X-Forwarded-Encrypted: i=1; AJvYcCXl1fx4G7Od02rGOy6/PvWxNvbRx+WmepATJpOXRzA/wvWUdleKW15qk3Ax3puDq+kXPswmJ1LIvXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qZuHLgWO12kXVWZt0HA5Mnag0+e9+/qurtYQvmcFH56I7r9o
	ig62GnwOz3z3eiRBH8KZ7IQo1P9C8WFv6tgdpz4F4+Y+dB+vPg7cwclGZCb90sW5JRI=
X-Gm-Gg: ASbGncv0dxL6oO/iP6G3YI2Fu6EP0T6rC5uPWGX4y5IGGZKtqXhHzA53IXVKiXFtO/E
	7PPAzxgM/JaxsJV0q6FjU/bPqsUa/XSKb4FnsvF2DdLbUyZEvyxaJdLN8WNxUBKDeGoJZ1Cwmch
	wKykVdxJwVmMSELysFRxc91qqbEhkfdh+lSKZfBI84NioBOL/JjU8iengWIcZ+wW0bdCkVzwaA3
	8FP0FzmhynY5Q0YuM2/6SyC3o+euoIUw3WsnogQND1l9Q7vlXbQc59WsGlEgKzPgZoFmEQEiHdA
	MZjbJSjMvoTGQFttXSoDd60py0XvfGeE9Yb69GVS+H1SED8Xx+qG4Id1yVDpWvCZq73d8YHJ4Yr
	wLU0iU949d+DA3Q4yndYbORW9qAOi1eT8GkThnfzuR8eyYeZ3svNzQqwjmfZQQTbnCPZqGgk8tt
	ECrJ8zFkXfXbgk+ObrIQeyodM=
X-Google-Smtp-Source: AGHT+IG4qF76mfK0ckCdhvAOyM6dk3CxZ2iK62x6AwDVufRrHJI4s1ZiTk8d/a3ypIjxis075X7CBg==
X-Received: by 2002:a05:6214:6005:b0:709:8672:dd84 with SMTP id 6a1803df08f44-7098672df63mr40806146d6.21.1754531103493;
        Wed, 06 Aug 2025 18:45:03 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:03 -0700 (PDT)
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
	witu@nvidia.com
Subject: [PATCH v3 11/30] liveupdate: luo_core: integrate with KHO
Date: Thu,  7 Aug 2025 01:44:17 +0000
Message-ID: <20250807014442.3829950-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate the LUO with the KHO framework to enable passing LUO state
across a kexec reboot.

When LUO is transitioned to a "prepared" state, it tells KHO to
finalize, so all memory segments that were added to KHO preservation
list are getting preserved. After "Prepared" state no new segments
can be preserved. If LUO is canceled, it also tells KHO to cancel the
serialization, and therefore, later LUO can go back into the prepared
state.

This patch introduces the following changes:
- During the KHO finalization phase allocate FDT blob.
- Populate this FDT with a LUO compatibility string ("luo-v1").

LUO now depends on `CONFIG_KEXEC_HANDOVER`. The core state transition
logic (`luo_do_*_calls`) remains unimplemented in this patch.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_core.c     | 210 ++++++++++++++++++++++++++++++-
 kernel/liveupdate/luo_internal.h |   9 ++
 2 files changed, 216 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index c77e540e26f8..951422e51dd3 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -47,9 +47,12 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/err.h>
+#include <linux/kexec_handover.h>
 #include <linux/kobject.h>
+#include <linux/libfdt.h>
 #include <linux/liveupdate.h>
 #include <linux/rwsem.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
 #include "luo_internal.h"
 
@@ -67,6 +70,21 @@ static const char *const luo_state_str[] = {
 
 static bool luo_enabled;
 
+static void *luo_fdt_out;
+static void *luo_fdt_in;
+
+/*
+ * The LUO FDT size depends on the number of participating subsystems,
+ *
+ * The current fixed size (4K) is large enough to handle reasonable number of
+ * preserved entities. If this size ever becomes insufficient, it can either be
+ * increased, or a dynamic size calculation mechanism could be implemented in
+ * the future.
+ */
+#define LUO_FDT_SIZE		PAGE_SIZE
+#define LUO_KHO_ENTRY_NAME	"LUO"
+#define LUO_COMPATIBLE		"luo-v1"
+
 static int __init early_liveupdate_param(char *buf)
 {
 	return kstrtobool(buf, &luo_enabled);
@@ -91,6 +109,60 @@ static inline void luo_set_state(enum liveupdate_state state)
 	__luo_set_state(state);
 }
 
+/* Called during the prepare phase, to create LUO fdt tree */
+static int luo_fdt_setup(void)
+{
+	void *fdt_out;
+	int ret;
+
+	fdt_out = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					   get_order(LUO_FDT_SIZE));
+	if (!fdt_out) {
+		pr_err("failed to allocate FDT memory\n");
+		return -ENOMEM;
+	}
+
+	ret = fdt_create_empty_tree(fdt_out, LUO_FDT_SIZE);
+	if (ret)
+		goto exit_free;
+
+	ret = fdt_setprop_string(fdt_out, 0, "compatible", LUO_COMPATIBLE);
+	if (ret)
+		goto exit_free;
+
+	ret = kho_preserve_phys(__pa(fdt_out), LUO_FDT_SIZE);
+	if (ret)
+		goto exit_free;
+
+	ret = kho_add_subtree(LUO_KHO_ENTRY_NAME, fdt_out);
+	if (ret)
+		goto exit_unpreserve;
+	luo_fdt_out = fdt_out;
+
+	return 0;
+
+exit_unpreserve:
+	WARN_ON_ONCE(kho_unpreserve_phys(__pa(fdt_out), LUO_FDT_SIZE));
+exit_free:
+	free_pages((unsigned long)fdt_out, get_order(LUO_FDT_SIZE));
+	pr_err("failed to prepare LUO FDT: %d\n", ret);
+
+	return ret;
+}
+
+static void luo_fdt_destroy(void)
+{
+	WARN_ON_ONCE(kho_unpreserve_phys(__pa(luo_fdt_out), LUO_FDT_SIZE));
+	kho_remove_subtree(luo_fdt_out);
+	free_pages((unsigned long)luo_fdt_out, get_order(LUO_FDT_SIZE));
+	luo_fdt_out = NULL;
+}
+
+static int luo_do_prepare_calls(void)
+{
+	return 0;
+}
+
 static int luo_do_freeze_calls(void)
 {
 	return 0;
@@ -100,6 +172,71 @@ static void luo_do_finish_calls(void)
 {
 }
 
+static void luo_do_cancel_calls(void)
+{
+}
+
+static int __luo_prepare(void)
+{
+	int ret;
+
+	if (down_write_killable(&luo_state_rwsem)) {
+		pr_warn("[prepare] event canceled by user\n");
+		return -EAGAIN;
+	}
+
+	if (!is_current_luo_state(LIVEUPDATE_STATE_NORMAL)) {
+		pr_warn("Can't switch to [%s] from [%s] state\n",
+			luo_state_str[LIVEUPDATE_STATE_PREPARED],
+			luo_current_state_str());
+		ret = -EINVAL;
+		goto exit_unlock;
+	}
+
+	ret = luo_fdt_setup();
+	if (ret)
+		goto exit_unlock;
+
+	ret = luo_do_prepare_calls();
+	if (ret) {
+		luo_fdt_destroy();
+		goto exit_unlock;
+	}
+
+	luo_set_state(LIVEUPDATE_STATE_PREPARED);
+
+exit_unlock:
+	up_write(&luo_state_rwsem);
+
+	return ret;
+}
+
+static int __luo_cancel(void)
+{
+	if (down_write_killable(&luo_state_rwsem)) {
+		pr_warn("[cancel] event canceled by user\n");
+		return -EAGAIN;
+	}
+
+	if (!is_current_luo_state(LIVEUPDATE_STATE_PREPARED) &&
+	    !is_current_luo_state(LIVEUPDATE_STATE_FROZEN)) {
+		pr_warn("Can't switch to [%s] from [%s] state\n",
+			luo_state_str[LIVEUPDATE_STATE_NORMAL],
+			luo_current_state_str());
+		up_write(&luo_state_rwsem);
+
+		return -EINVAL;
+	}
+
+	luo_do_cancel_calls();
+	luo_fdt_destroy();
+	luo_set_state(LIVEUPDATE_STATE_NORMAL);
+
+	up_write(&luo_state_rwsem);
+
+	return 0;
+}
+
 /* Get the current state as a string */
 const char *luo_current_state_str(void)
 {
@@ -111,9 +248,28 @@ enum liveupdate_state liveupdate_get_state(void)
 	return READ_ONCE(luo_state);
 }
 
+/**
+ * luo_prepare - Initiate the live update preparation phase.
+ *
+ * This function is called to begin the live update process. It attempts to
+ * transition the luo to the ``LIVEUPDATE_STATE_PREPARED`` state.
+ *
+ * If the calls complete successfully, the orchestrator state is set
+ * to ``LIVEUPDATE_STATE_PREPARED``. If any  call fails a
+ * ``LIVEUPDATE_CANCEL`` is sent to roll back any actions.
+ *
+ * @return 0 on success, ``-EAGAIN`` if the state change was cancelled by the
+ * user while waiting for the lock, ``-EINVAL`` if the orchestrator is not in
+ * the normal state, or a negative error code returned by the calls.
+ */
 int luo_prepare(void)
 {
-	return 0;
+	int err = __luo_prepare();
+
+	if (err)
+		return err;
+
+	return kho_finalize();
 }
 
 /**
@@ -193,9 +349,28 @@ int luo_finish(void)
 	return 0;
 }
 
+/**
+ * luo_cancel - Cancel the ongoing live update from prepared or frozen states.
+ *
+ * This function is called to abort a live update that is currently in the
+ * ``LIVEUPDATE_STATE_PREPARED`` state.
+ *
+ * If the state is correct, it triggers the ``LIVEUPDATE_CANCEL`` notifier chain
+ * to allow subsystems to undo any actions performed during the prepare or
+ * freeze events. Finally, the orchestrator state is transitioned back to
+ * ``LIVEUPDATE_STATE_NORMAL``.
+ *
+ * @return 0 on success, or ``-EAGAIN`` if the state change was cancelled by the
+ * user while waiting for the lock.
+ */
 int luo_cancel(void)
 {
-	return 0;
+	int err =  kho_abort();
+
+	if (err)
+		return err;
+
+	return __luo_cancel();
 }
 
 void luo_state_read_enter(void)
@@ -210,7 +385,36 @@ void luo_state_read_exit(void)
 
 static int __init luo_startup(void)
 {
-	__luo_set_state(LIVEUPDATE_STATE_NORMAL);
+	phys_addr_t fdt_phys;
+	int ret;
+
+	if (!kho_is_enabled()) {
+		if (luo_enabled)
+			pr_warn("Disabling liveupdate because KHO is disabled\n");
+		luo_enabled = false;
+		return 0;
+	}
+
+	/* Retrieve LUO subtree, and verify its format. */
+	ret = kho_retrieve_subtree(LUO_KHO_ENTRY_NAME, &fdt_phys);
+	if (ret) {
+		if (ret != -ENOENT) {
+			luo_restore_fail("failed to retrieve FDT '%s' from KHO: %d\n",
+					 LUO_KHO_ENTRY_NAME, ret);
+		}
+		__luo_set_state(LIVEUPDATE_STATE_NORMAL);
+
+		return 0;
+	}
+
+	luo_fdt_in = __va(fdt_phys);
+	ret = fdt_node_check_compatible(luo_fdt_in, 0, LUO_COMPATIBLE);
+	if (ret) {
+		luo_restore_fail("FDT '%s' is incompatible with '%s' [%d]\n",
+				 LUO_KHO_ENTRY_NAME, LUO_COMPATIBLE, ret);
+	}
+
+	__luo_set_state(LIVEUPDATE_STATE_UPDATED);
 
 	return 0;
 }
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 3d10f3eb20a7..b61c17b78830 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -8,6 +8,15 @@
 #ifndef _LINUX_LUO_INTERNAL_H
 #define _LINUX_LUO_INTERNAL_H
 
+/*
+ * Handles a deserialization failure: devices and memory is in unpredictable
+ * state.
+ *
+ * Continuing the boot process after a failure is dangerous because it could
+ * lead to leaks of private data.
+ */
+#define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)
+
 int luo_cancel(void);
 int luo_prepare(void);
 int luo_freeze(void);
-- 
2.50.1.565.gc32cd1483b-goog


