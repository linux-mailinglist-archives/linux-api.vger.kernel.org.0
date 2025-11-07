Return-Path: <linux-api+bounces-5158-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DEDC41ACB
	for <lists+linux-api@lfdr.de>; Fri, 07 Nov 2025 22:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0418423193
	for <lists+linux-api@lfdr.de>; Fri,  7 Nov 2025 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AEB310645;
	Fri,  7 Nov 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YaeAaHcY"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AC309DA1
	for <linux-api@vger.kernel.org>; Fri,  7 Nov 2025 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549539; cv=none; b=Ed9kv9C0zpCqSyWyU9BCsWRvkH6u77zH9CAewFZawTB+7mLoOwVtXW589fvfFArJe6mPBIrtcIVqMNJ+aRd0W/RjLWUTImjNuOyZvVpR3XdqFIXjG62dNsSgFHpysBj0U5eStUzAgh12gL/LT4ZaIs4kJP+igDzBteXmvcV3SfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549539; c=relaxed/simple;
	bh=XJDPtcEja0bEI+2/3EfwT35vgulH1PsXK2lUYfeZtv0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkmWwqKGp5P9zq1MKxT43SIiOp9fnR2B2tWZA8sakpCWK4coqgfu2K4K2rCfO2urtuwTl3WqQpEGjYKd2hH3+nzkSh9aJay+5LPbCVUBJP1oKd6uiH75TOBnIQqw2dmGrk2SyXM59Yb78klAjYqDW5nnmo3WSxC3Y4APn5QhiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YaeAaHcY; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63f96d5038dso1191754d50.1
        for <linux-api@vger.kernel.org>; Fri, 07 Nov 2025 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549536; x=1763154336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DFrgL9rmFv8Z3TsA72WaRzW9XWB4UJiC+A2rA/G5Wg=;
        b=YaeAaHcYtFIV5h+bh674QfITo1UoKAyEoUpN2bwKMDdZXgP40uzbKKGTlAGe1JRZLT
         ZK5awINfy5ASyYF4t4I84kdD/zA9JhzO9yf4hVNXozUebk064Mp1ChjI+VYLT3IGeg4H
         qKToilTLSjcSOXd9imQxtwNDR/hKsewJ76VPwsydeATb/g+D8Ey62mPgdsM2fqHHoaJ/
         buDzeZz3k0RAQpQMaw7sAAdoUFGtUomNFSFEwodIFw50PITBKgxfUeQDZVwYdR61T+px
         ZIpwR/IBehXGg++ExpW4wFPqn2sqVzFDiv/mM14tVLtIzxrDLST8O3/YWRNUWvOpNcp+
         5SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549536; x=1763154336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8DFrgL9rmFv8Z3TsA72WaRzW9XWB4UJiC+A2rA/G5Wg=;
        b=U9w/U3TCtS4p8Wp/eD+12xJjhljFkkM4a05hz7hK+IhXU/sz3PhsncbvVrRiBGk5kT
         AD4OZykZJcE1xxz5A0Y61ONPiNqMU5kKbrKb564UpL2necXXWRr/OOyvA1tUqakQWtpe
         c0H+I93I4l2NH1qz4qjPwyLguI7MgV6q4SVcg3jJfKF/uIiIWSzbME4jUKrJj8MEHxZt
         Xszu0AuzSJC/sz9KPJ5IBVVAkEWtbFioOuvzh+TkJWeQAoCXPSEpYKKj42h3YVELR7I1
         LOu6YzH9PloA9GHrSsaqoddAE3upqRO+6/Nxy3cg5UCO4S3M3IUSHrhMTplrF29VG98y
         e57Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGIhMjblY3DfgOKRRYvNTyoCgm9snYhmkqbislIJ+Wtq5TPXll1X/ENKouom+idcar498UeYnLO0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNckRpmJVSgojy7A4t+6ZRzdhjsqYK5rkBV8SYRYbAj8Z8Xjlo
	NdnQW53fxXRT0lcb0H0ua5YNsdbquSpmKDAfFtRF5b8XH2YWWAMnKlkv3Yh7azG4esw=
X-Gm-Gg: ASbGncuZk9kACkt37CXMY0OpTn3X+4EjxrHQIO5clt/9oNj0QacH2SiF1GmFK3OnBFp
	Uq4VD3nQM7xqieGUGDfY64uAzmWCjS+2al+ogsSbSv9HTkDah0oEg505PFf3TS9GdXNJtNrRKbw
	A5gLvdYRxN1mAzvzoBlUxlJMUkcFxZ0CFZ1yUic5nL42Qxrxw03Q4wxORcUipdu/fWVaOAbPic4
	Bn/tTBEZiMe6o4oTGqG9Ze+Gf1er4hxQhwsfWkJFVsfy3q1wZtFhBIeQN3UpwK5iP6oyMz5hqpz
	DpZkFOt46Vm79fp45p9mTliZEZmaMqgem5R60CVlJyl68QsSWqoZVKQRK3TVYvncBQiOqdffmCx
	hHOs64yX8xtw1KotHxJpYGRTUfB/Pp1FMjyPVMtVNgJb9BWtYFEUuxkYAacGOnCjJDhAHP4uD4E
	wX7OXhe8YQBh6vsZNuW9oPBp6BdwAbrZmTyFG8aWaykaVw81rf5OCOoog6vHBoc+g=
X-Google-Smtp-Source: AGHT+IEMk80coTnlUDmPPQWbhE5B5F4oVkxuYy4WClnNTFRgaSNjVcVYPgxObppzl4xgqVZVarxCQQ==
X-Received: by 2002:a05:690e:160f:b0:640:a958:f599 with SMTP id 956f58d0204a3-640d45cec8amr310541d50.46.1762549535914;
        Fri, 07 Nov 2025 13:05:35 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:35 -0800 (PST)
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
	chrisl@kernel.org
Subject: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
Date: Fri,  7 Nov 2025 16:03:00 -0500
Message-ID: <20251107210526.257742-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
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
 include/linux/liveupdate.h         |   6 +
 include/linux/liveupdate/abi/luo.h |  54 +++++++
 kernel/liveupdate/luo_core.c       | 243 ++++++++++++++++++++++++++++-
 kernel/liveupdate/luo_internal.h   |  17 ++
 mm/mm_init.c                       |   4 +
 5 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/liveupdate/abi/luo.h
 create mode 100644 kernel/liveupdate/luo_internal.h

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 730b76625fec..0be8804fc42a 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -13,6 +13,8 @@
 
 #ifdef CONFIG_LIVEUPDATE
 
+void __init liveupdate_init(void);
+
 /* Return true if live update orchestrator is enabled */
 bool liveupdate_enabled(void);
 
@@ -21,6 +23,10 @@ int liveupdate_reboot(void);
 
 #else /* CONFIG_LIVEUPDATE */
 
+static inline void liveupdate_init(void)
+{
+}
+
 static inline bool liveupdate_enabled(void)
 {
 	return false;
diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupdate/abi/luo.h
new file mode 100644
index 000000000000..9483a294287f
--- /dev/null
+++ b/include/linux/liveupdate/abi/luo.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: Live Update Orchestrator ABI
+ *
+ * This header defines the stable Application Binary Interface used by the
+ * Live Update Orchestrator to pass state from a pre-update kernel to a
+ * post-update kernel. The ABI is built upon the Kexec HandOver framework
+ * and uses a Flattened Device Tree to describe the preserved data.
+ *
+ * This interface is a contract. Any modification to the FDT structure, node
+ * properties, compatible strings, or the layout of the `__packed` serialization
+ * structures defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the relevant `_COMPATIBLE` string to
+ * prevent a new kernel from misinterpreting data from an old kernel.
+ *
+ * FDT Structure Overview:
+ *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
+ *   This entry contains an FDT with the following layout:
+ *
+ *   .. code-block:: none
+ *
+ *     / {
+ *         compatible = "luo-v1";
+ *         liveupdate-number = <...>;
+ *     };
+ *
+ * Main LUO Node (/):
+ *
+ *   - compatible: "luo-v1"
+ *     Identifies the overall LUO ABI version.
+ *   - liveupdate-number: u64
+ *     A counter tracking the number of successful live updates performed.
+ */
+
+#ifndef _LINUX_LIVEUPDATE_ABI_LUO_H
+#define _LINUX_LIVEUPDATE_ABI_LUO_H
+
+/*
+ * The LUO FDT hooks all LUO state for sessions, fds, etc.
+ * In the root it allso carries "liveupdate-number" 64-bit property that
+ * corresponds to the number of live-updates performed on this machine.
+ */
+#define LUO_FDT_SIZE		PAGE_SIZE
+#define LUO_FDT_KHO_ENTRY_NAME	"LUO"
+#define LUO_FDT_COMPATIBLE	"luo-v1"
+#define LUO_FDT_LIVEUPDATE_NUM	"liveupdate-number"
+
+#endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 0e1ab19fa1cd..c1bd236bccb0 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -42,11 +42,23 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/kexec_handover.h>
 #include <linux/kobject.h>
+#include <linux/libfdt.h>
 #include <linux/liveupdate.h>
+#include <linux/liveupdate/abi/luo.h>
+#include <linux/mm.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#include "luo_internal.h"
+#include "kexec_handover_internal.h"
 
 static struct {
 	bool enabled;
+	void *fdt_out;
+	void *fdt_in;
+	u64 liveupdate_num;
 } luo_global;
 
 static int __init early_liveupdate_param(char *buf)
@@ -55,6 +67,122 @@ static int __init early_liveupdate_param(char *buf)
 }
 early_param("liveupdate", early_liveupdate_param);
 
+static int __init luo_early_startup(void)
+{
+	phys_addr_t fdt_phys;
+	int err, ln_size;
+	const void *ptr;
+
+	if (!kho_is_enabled()) {
+		if (liveupdate_enabled())
+			pr_warn("Disabling liveupdate because KHO is disabled\n");
+		luo_global.enabled = false;
+		return 0;
+	}
+
+	/* Retrieve LUO subtree, and verify its format. */
+	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys);
+	if (err) {
+		if (err != -ENOENT) {
+			pr_err("failed to retrieve FDT '%s' from KHO: %pe\n",
+			       LUO_FDT_KHO_ENTRY_NAME, ERR_PTR(err));
+			return err;
+		}
+
+		return 0;
+	}
+
+	luo_global.fdt_in = __va(fdt_phys);
+	err = fdt_node_check_compatible(luo_global.fdt_in, 0,
+					LUO_FDT_COMPATIBLE);
+	if (err) {
+		pr_err("FDT '%s' is incompatible with '%s' [%d]\n",
+		       LUO_FDT_KHO_ENTRY_NAME, LUO_FDT_COMPATIBLE, err);
+
+		return -EINVAL;
+	}
+
+	ln_size = 0;
+	ptr = fdt_getprop(luo_global.fdt_in, 0, LUO_FDT_LIVEUPDATE_NUM,
+			  &ln_size);
+	if (!ptr || ln_size != sizeof(luo_global.liveupdate_num)) {
+		pr_err("Unable to get live update number '%s' [%d]\n",
+		       LUO_FDT_LIVEUPDATE_NUM, ln_size);
+
+		return -EINVAL;
+	}
+	memcpy(&luo_global.liveupdate_num, ptr,
+	       sizeof(luo_global.liveupdate_num));
+	pr_info("Retrieved live update data, liveupdate number: %lld\n",
+		luo_global.liveupdate_num);
+
+	return 0;
+}
+
+void __init liveupdate_init(void)
+{
+	int err;
+
+	err = luo_early_startup();
+	if (err) {
+		pr_err("The incoming tree failed to initialize properly [%pe], disabling live update\n",
+		       ERR_PTR(err));
+		luo_global.enabled = false;
+	}
+}
+
+/* Called during boot to create LUO fdt tree */
+static int __init luo_fdt_setup(void)
+{
+	const u64 ln = luo_global.liveupdate_num + 1;
+	void *fdt_out;
+	int err;
+
+	fdt_out = luo_alloc_preserve(LUO_FDT_SIZE);
+	if (IS_ERR(fdt_out)) {
+		pr_err("failed to allocate/preserve FDT memory\n");
+		return PTR_ERR(fdt_out);
+	}
+
+	err = fdt_create(fdt_out, LUO_FDT_SIZE);
+	err |= fdt_finish_reservemap(fdt_out);
+	err |= fdt_begin_node(fdt_out, "");
+	err |= fdt_property_string(fdt_out, "compatible", LUO_FDT_COMPATIBLE);
+	err |= fdt_property(fdt_out, LUO_FDT_LIVEUPDATE_NUM, &ln, sizeof(ln));
+	err |= fdt_end_node(fdt_out);
+	err |= fdt_finish(fdt_out);
+	if (err)
+		goto exit_free;
+
+	err = kho_add_subtree(LUO_FDT_KHO_ENTRY_NAME, fdt_out);
+	if (err)
+		goto exit_free;
+	luo_global.fdt_out = fdt_out;
+
+	return 0;
+
+exit_free:
+	luo_free_unpreserve(fdt_out, LUO_FDT_SIZE);
+	pr_err("failed to prepare LUO FDT: %d\n", err);
+
+	return err;
+}
+
+static int __init luo_late_startup(void)
+{
+	int err;
+
+	if (!liveupdate_enabled())
+		return 0;
+
+	err = luo_fdt_setup();
+	if (err)
+		luo_global.enabled = false;
+
+	return err;
+}
+late_initcall(luo_late_startup);
+
 /* Public Functions */
 
 /**
@@ -69,7 +197,22 @@ early_param("liveupdate", early_liveupdate_param);
  */
 int liveupdate_reboot(void)
 {
-	return 0;
+	int err;
+
+	if (!liveupdate_enabled())
+		return 0;
+
+	err = kho_finalize();
+	if (err) {
+		pr_err("kho_finalize failed %d\n", err);
+		/*
+		 * kho_finalize() may return libfdt errors, to aboid passing to
+		 * userspace unknown errors, change this to EAGAIN.
+		 */
+		err = -EAGAIN;
+	}
+
+	return err;
 }
 
 /**
@@ -84,3 +227,101 @@ bool liveupdate_enabled(void)
 {
 	return luo_global.enabled;
 }
+
+/**
+ * luo_alloc_preserve - Allocate, zero, and preserve memory.
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
+void *luo_alloc_preserve(size_t size)
+{
+	struct folio *folio;
+	int order, ret;
+
+	if (!size)
+		return ERR_PTR(-EINVAL);
+
+	order = get_order(size);
+	if (order > MAX_PAGE_ORDER)
+		return ERR_PTR(-E2BIG);
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
+	if (!folio)
+		return ERR_PTR(-ENOMEM);
+
+	ret = kho_preserve_folio(folio);
+	if (ret) {
+		folio_put(folio);
+		return ERR_PTR(ret);
+	}
+
+	return folio_address(folio);
+}
+
+/**
+ * luo_free_unpreserve - Unpreserve and free memory.
+ * @mem:  Pointer to the memory allocated by luo_alloc_preserve().
+ * @size: The original size requested during allocation. This is used to
+ *        recalculate the correct order for freeing the pages.
+ *
+ * Unregisters the memory from KHO preservation and frees the underlying
+ * pages back to the system. This function should be called to clean up
+ * memory allocated with luo_alloc_preserve().
+ */
+void luo_free_unpreserve(void *mem, size_t size)
+{
+	struct folio *folio;
+
+	unsigned int order;
+
+	if (!mem || !size)
+		return;
+
+	order = get_order(size);
+	if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
+		return;
+
+	folio = virt_to_folio(mem);
+	WARN_ON_ONCE(kho_unpreserve_folio(folio));
+	folio_put(folio);
+}
+
+/**
+ * luo_free_restore - Restore and free memory after kexec.
+ * @mem:  Pointer to the memory (in the new kernel's address space)
+ * that was allocated by the old kernel.
+ * @size: The original size requested during allocation. This is used to
+ * recalculate the correct order for freeing the pages.
+ *
+ * This function is intended to be called in the new kernel (post-kexec)
+ * to take ownership of and free a memory region that was preserved by the
+ * old kernel using luo_alloc_preserve().
+ *
+ * It first restores the pages from KHO (using their physical address)
+ * and then frees the pages back to the new kernel's page allocator.
+ */
+void luo_free_restore(void *mem, size_t size)
+{
+	struct folio *folio;
+	unsigned int order;
+
+	if (!mem || !size)
+		return;
+
+	order = get_order(size);
+	if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
+		return;
+
+	folio = kho_restore_folio(__pa(mem));
+	if (!WARN_ON(!folio))
+		free_pages((unsigned long)mem, order);
+}
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
new file mode 100644
index 000000000000..29f47a69be0b
--- /dev/null
+++ b/kernel/liveupdate/luo_internal.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _LINUX_LUO_INTERNAL_H
+#define _LINUX_LUO_INTERNAL_H
+
+#include <linux/liveupdate.h>
+
+void *luo_alloc_preserve(size_t size);
+void luo_free_unpreserve(void *mem, size_t size);
+void luo_free_restore(void *mem, size_t size);
+
+#endif /* _LINUX_LUO_INTERNAL_H */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index c6812b4dbb2e..20c850a52167 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -21,6 +21,7 @@
 #include <linux/buffer_head.h>
 #include <linux/kmemleak.h>
 #include <linux/kfence.h>
+#include <linux/liveupdate.h>
 #include <linux/page_ext.h>
 #include <linux/pti.h>
 #include <linux/pgtable.h>
@@ -2703,6 +2704,9 @@ void __init mm_core_init(void)
 	 */
 	kho_memory_init();
 
+	/* Live Update should follow right after KHO is initialized */
+	liveupdate_init();
+
 	memblock_free_all();
 	mem_init();
 	kmem_cache_init();
-- 
2.51.2.1041.gc1ab5b90ca-goog


