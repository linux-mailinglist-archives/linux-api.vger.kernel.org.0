Return-Path: <linux-api+bounces-4014-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42FFAE9263
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 01:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357D7168DC6
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 23:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00FE2E1C70;
	Wed, 25 Jun 2025 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="fZcXEyXH"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78912FCFC0
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893560; cv=none; b=sLlV0TYl20ZAbMekbuLVeZRGcF/egdM4858gz70PwQPvLFtXDCUgwBdteKaNsq6Pu/NR8qPw5mLHSci/C+dbvZLEh8Fiko4JGudE5t2WJm5A85nR7MiLk9grDiyaY1UlDzu3EXiaoUshN8kIICbTldnWZCnBvWUT9TutvAbzSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893560; c=relaxed/simple;
	bh=0K/tRVmbaZ0VX6fH8M8cdhr3USMmOz4iPh58HsL+dDs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyzOM3PaLTI/2URjfWhB4QJLIsV3rRghZyYYyL8u1YBri6mxwl184oQvFPDh/rpl4UcSOfLmaXcbwsLrgz+n/D+6z1Q7kvdDRNh4RDHti1Hxg/67402CbK0AHCEa4hxg9+XPXRD/Re82XbBKoH3r//RaQd89Fo68I099SPhKvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=fZcXEyXH; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71173646662so4930817b3.2
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 16:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893558; x=1751498358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZJDnzlkjFdal2Rjq5d+u9z1RQAbXbOPFvsyuVPVQrw=;
        b=fZcXEyXHF9NuvYm8Whls0JQk1JDl8m27PgnvY39aUbeV1Euuq9WgtTgh/xHZLi//YI
         BTaACvoBu5k510wQinRTpKUvGIIavm0n1sF1qxpz2c6delQeR6D5+fEoacCdF9bF570a
         xdIQ+RiSkCeTmcTZVapDE4eJptI3OLfLlf9sINNuYP8EeoR4+DN+i7lQOHu+eM0kFG36
         hZiTLNjYhdgIuqOQtQakDtOzQ8MC3pfCK+EgXumz98J8VrRo+cpBTWcsU7cL1Ot5LpW+
         GgWqy0q3zg1l8H8HIGy5PfBcgllc17jXLogviZhhNkswaIKuImunvyLFCdhbd3umzyX2
         iOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893558; x=1751498358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZJDnzlkjFdal2Rjq5d+u9z1RQAbXbOPFvsyuVPVQrw=;
        b=IXK0OoWKbNj9sLOXjEaQ0CNFpXeD+tqwSj++PiE/ubDyU1IVG7YGnDlMNCmdyPTYTc
         3yqW4lvNrglkK62z8/0pC5ukz1oC6vkmqM3e3Yxin95ReNJL2t/xtcG9W4wpkzGk9A2l
         iE/Ina1mqIb41Lbj4cw4NzbpT97+uYQvONvNWWxD2yTL+hxzwOPwE0/LeoVxU4PCI+7Q
         /lRVky+7gjnFIVGoqovgbelMwFgqgy7LHyPcLir7k8GkTKm5y5fHjdHKvWVmralEzDVc
         INzVh7zzyVpFWXrrpUhDestWu6W3oBA80fSvKjMgQge0OGZ1DzItIlV+r+SVJ/X833Zm
         IDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5PIiITOs0tqpIhazyVi6YikL3iDwbB9gevPH1/V2u7tzPOIx6ovsc6++5HDcGrbgZMSVx3IvM8xU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx85AnAPyo9ONAnZaysChXu4FrW3Sz8xkh0gblD0bgPPTtPpoQZ
	kn5P2lqaoMxL0FwMvPFrIJQ9eRhhf2kOhDT9Ql8GwnirqFsIsKFVztDqL1mNPmaAAlQ=
X-Gm-Gg: ASbGncsPKBLAI8cihBpKBfeHE7WFGt07amLyAva6r3qakcoqAL4o+AZbRfG49Mj/Mdu
	kB91KHrGfqbOI57M5hvuoJPvoczXTK7EUDqAkAgzuhTA4PhxbJMoCNMC7nFimd6uas0/ZHXFknE
	b4TSNOzscIVqps8zYdpgRBjnYpXIT/h/KkJ7ubZp3FnNe5pPcrMWd4LCJIQtDPS7I4P8puVn1Rl
	jkOP3IorZF6KpQVCS1bRt2Pug5HhyeU6mMxFWFp6UEcI28Q4os1F0a0vVTT44JASn6aZ6ORvVvq
	I5+Qk49/YI3F5IzifNDb1uWZazLmqh+zUGAmTvxy/HBZ52W/3ru9DY1cRj0KGnyer4o/itmXf9R
	8JdE/DCSGkh2hfMB8LowoFORj8aL3HdUIaz7Ie10+oY0vH3NJLgKG
X-Google-Smtp-Source: AGHT+IEy6gDp+TLxoQz7i8XJK92N1YqMToyOrPaa/RNISf+e+ji+erXXV1um4VBOajJ98t+L3IMAZw==
X-Received: by 2002:a05:690c:6089:b0:70e:1474:63f2 with SMTP id 00721157ae682-71406c7cfb8mr66969267b3.7.1750893557847;
        Wed, 25 Jun 2025 16:19:17 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:17 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 20/32] kho: move kho debugfs directory to liveupdate
Date: Wed, 25 Jun 2025 23:18:07 +0000
Message-ID: <20250625231838.1897085-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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


