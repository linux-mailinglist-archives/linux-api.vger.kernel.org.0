Return-Path: <linux-api+bounces-4216-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C378B0F60B
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E7547B7D77
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B089A2FE328;
	Wed, 23 Jul 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="XB4uIIXV"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FEE2FD87C
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282061; cv=none; b=ot7ZDeRH8EEHuKTFLZUx+pOMIeRIeJDepb6XLxmtdWQ1zhMAZj3Egm1JjEUDj5p0v3fzm36EOhh3v3Ay0elLt7/Lg7BXRY5Tuz4yY/wvlQuk0nzelniF/mgEKEKVYTklQx9Ii18ksffr2yfFZDZuaT91GWFIYScWhfH18DwpzNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282061; c=relaxed/simple;
	bh=0K/tRVmbaZ0VX6fH8M8cdhr3USMmOz4iPh58HsL+dDs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIkybwV4jKEoY+nuHp+V4jQUg/Ijb+uWVg1WeOmnxS3/Jw+lheszRtC73VdDXYeMc9vZ+WcUYE8k0aV8Dn79c7krbxb2KM91aafVllelcCgd2MD+jNPdl5gayg7P5d5S79i39BIqDRYnppGhhmIeCNnPG3Bs1MlrQLaKpHxNiTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=XB4uIIXV; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8d96ff2dfaso3533822276.2
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282055; x=1753886855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZJDnzlkjFdal2Rjq5d+u9z1RQAbXbOPFvsyuVPVQrw=;
        b=XB4uIIXVxAgp3MXXqcxtclS+QlBo1mLspvyfzGbSvVFh+GHYyLNz1SwbqG/ytQEcY2
         1uI+4xsyIxny4daZZil6Fk2YLl5b2T35jMwudWOY+tlb3MwYk2JJ6J/u/a5GxW38dc6S
         9nZrxs9olyr3opgLKdlqpTdGWyoaVsoHNY39fIO70reHcJl3TgND7hL78dZqsTYaDQKl
         y+kRVsAZ9+Jo8Elk9zUs4Xi+m23ZgPB7shObD65vLHkjZfBPs/toeb28MSINYLmfUKX3
         PdCM+bpADjJCSQzRde3rfdkTwXDLX4CzuCgBFpzsq5ax+BOT6uKsJFrht7gghAzgO8R3
         troQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282055; x=1753886855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZJDnzlkjFdal2Rjq5d+u9z1RQAbXbOPFvsyuVPVQrw=;
        b=SLy/z8bRcDlo8Its/OhVFmWT9G4NGar+SV4NlIUoiP3qWKZV4l1iPPDSzr0I8L3cTL
         93wjLB9X3pbHRdygasvExpBFyQjwVS4P0XUI53QxoTZlMA2UsXAzwA0KUQUQOLxOylXB
         Y76XMG3usd7/v9yCQUl6LxAnX++ZZDx2xHiF/vNgpm1om/2k2EFeeSRS62xQ7hmFemqe
         Q7wRbChS9AZo9C7z5ab61s94OvgKPMRby0xWKpkIrVlKCZgKvzlvGyPBUqyvgiPQQwn/
         Qjb5O8gBf8W5IP9ZdkmV/cDTH1zxsUljer4SZ74qP8OWbJkJgsHh8if+A7sHrPLT8JbG
         ztrw==
X-Forwarded-Encrypted: i=1; AJvYcCXySrwXGKRj+tDW1uAh3Tjvb9AAv6w3VhPTYq1uPQ7YXBmI7okf3jfgG7Vkg4xKSwNmYavleJcOusk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBHA/zv3Ut5Zw0L99IDW8hsCaZDdwT0KFIUQCcDFO2tMhDDFV
	WfCk19RWmuT4rBio9F1PLfQQIzut0nzN0JhTKZ6fDRemv66nRI3Zmn5RED41eW8tUY0=
X-Gm-Gg: ASbGncvMcewx3/ZeAxwTD3NiYipv/M8IMG73m6yeMHhKg+jXKzialvWWE6cO6u8YS1v
	4f4J0tGdcCaqApynvSWeV9IDCcENNYpbYOHwMdj2dc95tAzNody8gkbNsM7SsY5NjlaUqeWyAip
	9AO8zUdRiuMuGhR+Yvm87ky5lK/1iRNE/Va+ZxSNKAXersxmPkeMd1M7Soy1MuTLWECcjzaNTyM
	ebObmHQLl2YPqWd9IsnRgPyM2WMyqLqOt75dWQtVNiAkdpq0TcU/EPIvPG4khqCkMnRKpk9BhbL
	kZXmSUmE24jRMpMEycoUV2cLr3kUgwxmAhKK4Uo6WlIHZUP8n+Vw0+VAiEKbzqTUl58jqT0nJsB
	9QFAavWWwxzgXuovvdV8B9qeLIe3mIXmmPWs+2iz6P/WWMWFKT7lyt4XbSLoN7KN3APRTu2d+3O
	XhEn5qpYwnK67How==
X-Google-Smtp-Source: AGHT+IHlIrN5M9MAslsUdLs3lHTAX0ZWx0BjoPEfQHGEOchWYmIsSv7ekgCGt5Hg7CwZYoZ1gLsHVQ==
X-Received: by 2002:a05:690c:3804:b0:70e:7638:a3a9 with SMTP id 00721157ae682-719b4200595mr38740617b3.18.1753282055367;
        Wed, 23 Jul 2025 07:47:35 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:34 -0700 (PDT)
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
Subject: [PATCH v2 20/32] kho: move kho debugfs directory to liveupdate
Date: Wed, 23 Jul 2025 14:46:33 +0000
Message-ID: <20250723144649.1696299-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that LUO and KHO both live under kernel/liveupdate, it makes
sense to also move the kho debugfs files to liveupdate/

The old names:
/sys/kernel/debug/kho/out/
/sys/kernel/debug/kho/in/

The new names:
/sys/kernel/debug/liveupdate/kho_out/
/sys/kernel/debug/liveupdate/kho_in/

Also, export the liveupdate_debufs_root, so LUO selftests could use
it as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover_debug.c | 11 ++++++-----
 kernel/liveupdate/luo_internal.h         |  4 ++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
index af4bad225630..f06d6cdfeab3 100644
--- a/kernel/liveupdate/kexec_handover_debug.c
+++ b/kernel/liveupdate/kexec_handover_debug.c
@@ -14,8 +14,9 @@
 #include <linux/libfdt.h>
 #include <linux/mm.h>
 #include "kexec_handover_internal.h"
+#include "luo_internal.h"
 
-static struct dentry *debugfs_root;
+struct dentry *liveupdate_debugfs_root;
 
 struct fdt_debugfs {
 	struct list_head list;
@@ -120,7 +121,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("in", debugfs_root);
+	dir = debugfs_create_dir("in", liveupdate_debugfs_root);
 	if (IS_ERR(dir)) {
 		err = PTR_ERR(dir);
 		goto err_out;
@@ -180,7 +181,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("out", debugfs_root);
+	dir = debugfs_create_dir("out", liveupdate_debugfs_root);
 	if (IS_ERR(dir))
 		return -ENOMEM;
 
@@ -214,8 +215,8 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 __init int kho_debugfs_init(void)
 {
-	debugfs_root = debugfs_create_dir("kho", NULL);
-	if (IS_ERR(debugfs_root))
+	liveupdate_debugfs_root = debugfs_create_dir("liveupdate", NULL);
+	if (IS_ERR(liveupdate_debugfs_root))
 		return -ENOENT;
 	return 0;
 }
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 8fef414e7e3e..fbb9c6642d19 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -40,4 +40,8 @@ void luo_sysfs_notify(void);
 static inline void luo_sysfs_notify(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+extern struct dentry *liveupdate_debugfs_root;
+#endif
+
 #endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.50.0.727.gbf7dc18ff4-goog


