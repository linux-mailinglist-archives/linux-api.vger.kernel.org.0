Return-Path: <linux-api+bounces-4355-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 393ABB1D082
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 03:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199E47A7940
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 01:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3FE24DCEF;
	Thu,  7 Aug 2025 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MFNdTEfK"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3623FC42
	for <linux-api@vger.kernel.org>; Thu,  7 Aug 2025 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531122; cv=none; b=qnqQX7KZTvfnz1ZyZma5dT/2qecYdnA0On69cAV3FsSBloxPd/lUzNoIppQbRmmGQKg4LpPusp4VyMh12oEoW5CrVTa/51mygJvfUzcSdlsSes6VxAlrmwPyFf3ao2ns6CEkdp4q+7hTLnexE2mgaG0nITnEgwVcdrF7rOG7Ais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531122; c=relaxed/simple;
	bh=wD6I1RCn0+c99seXGKswy1P0OxmegImcJk+Lb6MyVL4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prVWDfo01aj58OAC+pqkcqhfDWHLFVfjFCxOcwQQ5hXrK7r2QWBH+xlP3XVb5txiNKQnmy3mBwlNnLyng2bUO8M6Dgk1TCPg5ffnJSz0ny2rmy2fsBP9IZVmpUA8ZNmJhpXQthQg9Kp25roLVdIeBWi5SVfGhfzPOP5Y+Nj/Y0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=MFNdTEfK; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-709233a8609so6454066d6.1
        for <linux-api@vger.kernel.org>; Wed, 06 Aug 2025 18:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531118; x=1755135918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7wVeHC0BKF0BnkzpBtVk7MqDMjUeUEopTUe1tEjQ6M=;
        b=MFNdTEfKSm2hUchTLiu6Ij1W/TBQNRDaQN+pCacJgQOflejZHgqP9ol3PV3efPQajz
         iv5P8wvV6TWKMk12ES2+Em/t5GONl4QEAjwJkvWWwXS6u9OhEF3FmBHghh3g+9VwZtOS
         82TqhrIyRw7ODJrtv/D0eWYpr8XQVdN6n6Lu02vFyMRO9Ymo83UfHLp53WgBA+OVfDtc
         rjIw7AHcgq9hwHxLPGrS+X0fK/q4bCTt3HzNO4x/eVIpJ42qGZX6820eQP57nIQF6xc2
         9VRADA3IVm3wO0oDA7ZwKaoG+ld51sQHOQv5SK+/NL/DQuWVG+oMBqwUiXuFsAp/xgCN
         GvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531118; x=1755135918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7wVeHC0BKF0BnkzpBtVk7MqDMjUeUEopTUe1tEjQ6M=;
        b=BNAHM4vW6tZ+aeh6lUln0UlV3iAlhVDi37M2+d9FNPkmbVSzKmnYuxqTu3oGoflZpZ
         Uk6N7XeNco/4W/kJhKUJ7q/vfULCU8EZ3QIw00bLxEw4k9IbCdwrr/Ei1q3guhrh+TTZ
         hqjm/uhKQMyG2/Hyu7KDA6m39wtPqMqX4vbHBrOXrlEc7vyfP8wBVmS9wGDD45K7jjaO
         sPoViBklqapUZY7zeMrxamStV6WK2SqUWakQnDaDx14OXqMoNRGj980URq+sp3XvYk2n
         8+bayuYPBraHn17D+EV4l2ljiT58Ele5I58kQiINxGvkvwjHgcfpLTg4vpN1yjEl3ker
         Me6A==
X-Forwarded-Encrypted: i=1; AJvYcCXr3SoCCZ4XcBb3TluavH7Nhd0cuGR7BNQOf/AC2Hmt/tAMWnVfTijQn9Sn/IahIGc076qEwdnZ8KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQ296imibDmKdGmKTyY7LOVF8msr6Spy+MnaABfpX6gpRjCyD
	9bf9vqX0/Z6FCKsLzPNd6QL/JPJhEBhfwYyg3TtmdAFu9tEVeFNyUrm7w1ShEeb8x5s=
X-Gm-Gg: ASbGncuVrhtauXMmAJZXNTtD/5SrqS5PEf1FCWpWk0bLe7OOQew1iURJLeMNJcJanPG
	b6oAtIdcbz5V3Yov2sFX2cYXtnOHI6gtzH3lec4opd9HkJFbnE0DpRttU9+XABiGPLzado+KmLy
	DPU6D5RVMTnqHiNMFCgtAR9JMZFo7NjFXY5mYaBm+UEyYzT6ZQj7Ps2Lv3T1lNxom7pnh8pheai
	2Yrs7Xu/RCmX7TJQy1X3enFuJUjLKKFJNP7mlrNChFJWtbBjUDWQMb+1r36G2CNsM9HVjmx4WuH
	pO28orvwp23FNSCDef1KR0va9hynnbU9veTxi+fn45DlE/vz4eU2iaWR5FAMRdYhujtLMF02z5E
	hAvRpPPd6ULACyACbd3pIBmHjo6AhTvVBLwUI1qfPG9lBV1BqKV52AuVRcijrXwTvwtzRj8jtSE
	xX4DqA5j0wSabD
X-Google-Smtp-Source: AGHT+IGUMFTnXz7aA5TeYDEGpdy4VXQ/e6kO5So5tD5I7KBD7rTcRc491fmczfxSCGd/3u9GjXp5RA==
X-Received: by 2002:a05:6214:2587:b0:709:65cf:be98 with SMTP id 6a1803df08f44-7097ae1016dmr57649496d6.8.1754531118246;
        Wed, 06 Aug 2025 18:45:18 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:17 -0700 (PDT)
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
Subject: [PATCH v3 21/30] kho: move kho debugfs directory to liveupdate
Date: Thu,  7 Aug 2025 01:44:27 +0000
Message-ID: <20250807014442.3829950-22-pasha.tatashin@soleen.com>
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
index 9091ed04c606..78bea012c383 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -53,4 +53,8 @@ void luo_sysfs_notify(void);
 static inline void luo_sysfs_notify(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+extern struct dentry *liveupdate_debugfs_root;
+#endif
+
 #endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.50.1.565.gc32cd1483b-goog


