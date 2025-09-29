Return-Path: <linux-api+bounces-4956-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5D6BA7AE1
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 03:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7A77AB57F
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 01:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D5722D792;
	Mon, 29 Sep 2025 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XCOZm/G+"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA2221265
	for <linux-api@vger.kernel.org>; Mon, 29 Sep 2025 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107828; cv=none; b=E3/aSYFO2EOKWirkFC2GNNtnoJbWY7ybDj/iZS+P9X/8QE7lJOZEioGVaYa4FN92R/HXMX2Byyy1xF4rdv1bFOU85HeD0RD4LrIJfplfGnJyuWS9xYlcXQIHJm29EvA4ikTY14T8rRyP2UuVQc4nu0JbkxNGoDG9XrcDsVmiwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107828; c=relaxed/simple;
	bh=+sjjN122RdXtJfHWbdGdwjJQhTnn9dy9doHBJONF8gc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RH7Gaj0889Rp0RZFh3UEfxLO2UajGoZSKjyhosotWsyqEkMy7rmTm/OFK+ytC1Cvx3I0q2gWsu4od9V0xxxOB2/2UZzPLo/E9EViEQCSCXjgFOdE1NSjiUJpvJ8Uf6fU406MZ0VQEfXKaiXwyvMemJ9s5+7q2ep74xh99v4stBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=XCOZm/G+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4d9bcc2368eso44132051cf.2
        for <linux-api@vger.kernel.org>; Sun, 28 Sep 2025 18:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107823; x=1759712623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2J5W7RP3mcD6qfnmKA/9lO7swWy58O6Kyen5gVTP9fM=;
        b=XCOZm/G+U5cS7RMtM3Xq7GpL3MgxI77b+WNiH7vNr91NQTQn3UE7d97TjHREsKsI5K
         Auu1xWipP09dcV7xNt1R57lWrTWBKHPCqmALm+2Xk+3hBMWfTRhXQYWtAclN9pKo9dGn
         5P/km+i+yKJ6wparvtUeQiAjVa0PjpFlaH74CLLXmz5/ym5KGfvMMnRGwdJBiliL+TzA
         rD/+iyDKZ83NI/QXZ/RQHa/b/53D2sOenIu2GlWqif5gxEQcsto/ojl3lI3HL6MdfBC9
         ZxDQ4thZY6Igafv8PHgWlUfQUHrqSXVqVWbyitfSiWyj5F1WPiEgYhI/zhqcuGoBiZUY
         JZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107823; x=1759712623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J5W7RP3mcD6qfnmKA/9lO7swWy58O6Kyen5gVTP9fM=;
        b=sFWw93GKsZywS10a3OQw7z8tNpzry+X0gxYzerneJbfLnJc821umtsNK/JpyrhmcMG
         pEmYuTYl0RhEOmu2Fd4fYa9dOPmC/Ue4PHzt4sT0jO1uS4HD1ZNNVnC6Z/cSFRXZGbv3
         9hpcyFvTs4sdU7f58WCiJEsvALtFhWu4cj9kkXbPqY1eHi8cS/tLK3jJdkJ8oRbbe6BP
         GQKHgYF4QARdESacPT9aIRsgCWLsS0rEjBUU7+5V4XxBnZJXno4FtVlL6ndxSQYjLUA9
         6BBqmf+IpEJfclZx1zEG29vEVBbUSwuP0Cn3dwa2OP064waSqqt4lhTGubtshTlytDZ4
         2CoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW/YeeTivHd2YY6Svb0XXHFFLsjx9Zl2UpzEKm2J7dYttpodBQyt+LGiY/br01j/MXbsTvAb9ZHzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKrQXRwp8YjO9+/+SegleiDhO42dlSP8RoedIIEc8f1oHnjc9
	vNtF/56TqAaPii2M+3wLJqSLOIm8imb5LSsFEhe9/G6RSnNiq6cnQxXLqZZlCgZWELU=
X-Gm-Gg: ASbGncu+lFnbF0bG/RjsY1nVCVbK9PS142et453MNm8dGC+ToH5UhcEm67oxMEH1nxA
	RdBbyF7B5Jgm4VDN/cmhv+CzMTjSnUxgg+Me4pvMNDYVTBiwefClRXA8w2XxYuSRdwOawOYKzc7
	lkuQ3fhRq4ChxzcE0yX3N3j32MHfnK8dzb4g0tm9PRX1rbXkc8x1Ohysrr5+OAKTKmY6VbJZtYz
	91s4qHG7dauOTrIDZrArarfap5CigJaSYTdFqS+JHIkLkEnWeA8fKwNkew5EgkGcz7zTfjJhdQi
	3jdASyRb4bC5zjRRy6z3EncfBiNOA5tl0HITyvBvxO+zfHtWjDzbVb1VlrxzSCYERdqQoLTCcmR
	3piRBEnhjsKNXfGOrilaNocEvEwLHF8bwXBInkR4Ai32tFJSl3hhKdUGQ7zkBmnidADMQA7kftp
	z8E/zSECiXfY73sI3NAA==
X-Google-Smtp-Source: AGHT+IGaV3SESLMA5+DIYYmSBm152vC0KVkg9BHG7ku4t1EPFpwQC7mmZrH2IaNVGBpmOmq3lM96pA==
X-Received: by 2002:ac8:5f84:0:b0:4b4:8e38:8f96 with SMTP id d75a77b69052e-4da4d8e3cbamr195662391cf.83.1759107822880;
        Sun, 28 Sep 2025 18:03:42 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:03:42 -0700 (PDT)
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
Subject: [PATCH v4 08/30] liveupdate: luo_core: integrate with KHO
Date: Mon, 29 Sep 2025 01:02:59 +0000
Message-ID: <20250929010321.3462457-9-pasha.tatashin@soleen.com>
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
 kernel/liveupdate/luo_core.c     | 282 ++++++++++++++++++++++++++++++-
 kernel/liveupdate/luo_internal.h |  13 ++
 2 files changed, 292 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 954d533bd8c4..10796481447a 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -47,9 +47,13 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/err.h>
+#include <linux/kexec_handover.h>
 #include <linux/kobject.h>
+#include <linux/libfdt.h>
 #include <linux/liveupdate.h>
+#include <linux/mm.h>
 #include <linux/rwsem.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
 #include "luo_internal.h"
 
@@ -67,6 +71,21 @@ static const char *const luo_state_str[] = {
 
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
@@ -91,6 +110,52 @@ static inline void luo_set_state(enum liveupdate_state state)
 	__luo_set_state(state);
 }
 
+/* Called during the prepare phase, to create LUO fdt tree */
+static int luo_fdt_setup(void)
+{
+	void *fdt_out;
+	int ret;
+
+	fdt_out = luo_contig_alloc_preserve(LUO_FDT_SIZE);
+	if (IS_ERR(fdt_out)) {
+		pr_err("failed to allocate/preserve FDT memory\n");
+		return PTR_ERR(fdt_out);
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
+	ret = kho_add_subtree(LUO_KHO_ENTRY_NAME, fdt_out);
+	if (ret)
+		goto exit_free;
+	luo_fdt_out = fdt_out;
+
+	return 0;
+
+exit_free:
+	luo_contig_free_unpreserve(fdt_out, LUO_FDT_SIZE);
+	pr_err("failed to prepare LUO FDT: %d\n", ret);
+
+	return ret;
+}
+
+static void luo_fdt_destroy(void)
+{
+	kho_remove_subtree(luo_fdt_out);
+	luo_contig_free_unpreserve(luo_fdt_out, LUO_FDT_SIZE);
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
@@ -100,6 +165,71 @@ static void luo_do_finish_calls(void)
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
@@ -111,9 +241,28 @@ enum liveupdate_state liveupdate_get_state(void)
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
@@ -193,9 +342,28 @@ int luo_finish(void)
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
@@ -210,7 +378,36 @@ void luo_state_read_exit(void)
 
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
@@ -295,3 +492,82 @@ bool liveupdate_enabled(void)
 {
 	return luo_enabled;
 }
+
+/**
+ * luo_contig_alloc_preserve - Allocate, zero, and preserve contiguous memory.
+ * @size: The number of bytes to allocate.
+ *
+ * Allocates a physically contiguous block of zeroed pages that is large
+ * enough to hold @size bytes. The allocated memory is then registered with
+ * KHO for preservation across a kexec.
+ *
+ * Note: The actual allocated size will be rounded up to the nearest
+ * power-of-two page boundary.
+ *
+ * @return A virtual pointer to the allocated and preserved memory on success,
+ * or an ERR_PTR() encoded error on failure.
+ */
+void *luo_contig_alloc_preserve(size_t size)
+{
+	int order, ret;
+	void *mem;
+
+	if (!size)
+		return ERR_PTR(-EINVAL);
+
+	order = get_order(size);
+	if (order > MAX_PAGE_ORDER)
+		return ERR_PTR(-E2BIG);
+
+	mem = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!mem)
+		return ERR_PTR(-ENOMEM);
+
+	ret = kho_preserve_pages(virt_to_page(mem), 1 << order);
+	if (ret) {
+		free_pages((unsigned long)mem, order);
+		return ERR_PTR(ret);
+	}
+
+	return mem;
+}
+
+/**
+ * luo_contig_free_unpreserve - Unpreserve and free contiguous memory.
+ * @mem:  Pointer to the memory allocated by luo_contig_alloc_preserve().
+ * @size: The original size requested during allocation. This is used to
+ *        recalculate the correct order for freeing the pages.
+ *
+ * Unregisters the memory from KHO preservation and frees the underlying
+ * pages back to the system. This function should be called to clean up
+ * memory allocated with luo_contig_alloc_preserve().
+ */
+void luo_contig_free_unpreserve(void *mem, size_t size)
+{
+	unsigned int order;
+
+	if (!mem || !size)
+		return;
+
+	order = get_order(size);
+	if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
+		return;
+
+	WARN_ON_ONCE(kho_unpreserve_pages(virt_to_page(mem), 1 << order));
+	free_pages((unsigned long)mem, order);
+}
+
+void luo_contig_free_restore(void *mem, size_t size)
+{
+	unsigned int order;
+
+	if (!mem || !size)
+		return;
+
+	order = get_order(size);
+	if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
+		return;
+
+	WARN_ON_ONCE(!kho_restore_pages(__pa(mem), 1 << order));
+	free_pages((unsigned long)mem, order);
+}
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 2e0861781673..c98842caa4a0 100644
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
@@ -19,4 +28,8 @@ extern struct rw_semaphore luo_state_rwsem;
 
 const char *luo_current_state_str(void);
 
+void *luo_contig_alloc_preserve(size_t size);
+void luo_contig_free_unpreserve(void *mem, size_t size);
+void luo_contig_free_restore(void *mem, size_t size);
+
 #endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.51.0.536.g15c5d4f767-goog


