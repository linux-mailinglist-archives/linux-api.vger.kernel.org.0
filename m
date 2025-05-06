Return-Path: <linux-api+bounces-3701-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EB8AAC847
	for <lists+linux-api@lfdr.de>; Tue,  6 May 2025 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93ABC1C41DF2
	for <lists+linux-api@lfdr.de>; Tue,  6 May 2025 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF0928314A;
	Tue,  6 May 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="toccOJQ6"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC58145B3E;
	Tue,  6 May 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542407; cv=none; b=NLq/9Cz4HTzmUV1X4Gj5UpUM9GCwVvkRICyu6WyYPL67JCIPDybIuFijP33DIczXoRxKhDFq04bHg3HsudqNxtbSRRzTPQRbIltAgcQfUE1e7rbGf1XrNxSClMf3m0LoibbWsRt6rCpU95Bn4UTwptlUmfs+lhe5ziUwM/soy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542407; c=relaxed/simple;
	bh=a0rorzYw29UDb+FASDv3uzcLWeZh4M+87aqv97iHKrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eqb3cHMky6yBXqMMoY8C9ysDbILigXBMXZteDWZPRWkbdR+wMEJx0mRbHPIoN2Rbr9AzQf4v/ItfDGDvCmtMMU9/2J39A87ZpfdcxWZhNW8x1Sn9W9KbANcxbArJVZRO6ps+nD6BKldAMnT73KAUuarkWXZGrewo/MJZ/A+Wfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=toccOJQ6; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A2E3C3F9D9;
	Tue,  6 May 2025 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746542031;
	bh=ai07KyAEUxYQ8qo4RopzxQQq8pFMPKovPFICzv+mCvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=toccOJQ697NpgL+02HMfxlAA+++TCJXPXO2XB/2G667t0H+yvg6XJ0f6a4d4wXuoG
	 N7UoKFJtMmusAHe0eBh2QydugG9tlg8TQRs86hBIniK73l4X9B2RRetO7h2jRaHGqD
	 Ki88IdfDwptqgwBJT6TGG7HxtqE7FAJ3EA/qmEtz+bFieUPa7Om+eTFh+nPETFj7uw
	 /6sWWiUQSzg+vt1+9v4yeM6Zuop+WNEfZW71polXQZFKU30YfxpxAI2tyjxcRR5eab
	 h1MGU3bZod424mCHpWM7ywLYLyT2i5B/R3dbm/Co6/2mVveAxwZGKPkokF4rRHUPbh
	 fA9UwhvzcNUXA==
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	mic@digikod.net,
	kees@kernel.org,
	stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp,
	linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH 1/3] Wire up the lsm_manage_policy syscall
Date: Tue,  6 May 2025 16:32:28 +0200
Message-ID: <20250506143254.718647-2-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250506143254.718647-1-maxime.belair@canonical.com>
References: <20250506143254.718647-1-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the new lsm_manage_policy syscall, providing a unified
API for loading and modifying LSM policies without requiring the LSM’s
pseudo-filesystem.

Benefits:
  - Works even if the LSM pseudo-filesystem isn’t mounted or available
    (e.g. in containers)
  - Offers a logical and unified interface rather than multiple
    heterogeneous pseudo-filesystems.
  - Avoids overhead of other kernel interfaces for better efficiency

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl            | 1 +
 arch/arm/tools/syscall.tbl                        | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl            | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl            | 1 +
 include/linux/syscalls.h                          | 4 ++++
 include/uapi/asm-generic/unistd.h                 | 4 +++-
 kernel/sys_ni.c                                   | 1 +
 security/lsm_syscalls.c                           | 6 ++++++
 tools/include/uapi/asm-generic/unistd.h           | 4 +++-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 10 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 2dd6340de6b4..dfe6cd43c584 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -507,3 +507,4 @@
 575	common	listxattrat			sys_listxattrat
 576	common	removexattrat			sys_removexattrat
 577	common	open_tree_attr			sys_open_tree_attr
+578	common	lsm_manage_policy		sys_lsm_manage_policy
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 27c1d5ebcd91..60abcb3a8a1b 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -482,3 +482,4 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	lsm_manage_policy		sys_lsm_manage_policy
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ac007ea00979..bb91a929757a 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -473,3 +473,4 @@
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
 467	i386	open_tree_attr		sys_open_tree_attr
+468	i386	lsm_manage_policy	sys_lsm_manage_policy
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index cfb5ca41e30d..83819d4a5c8a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -391,6 +391,7 @@
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
 467	common	open_tree_attr		sys_open_tree_attr
+468	common	lsm_manage_policy	sys_lsm_manage_policy
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e5603cc91963..f52a0678b1d0 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -989,6 +989,10 @@ asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *
 				      u32 size, u32 flags);
 asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
 
+asmlinkage long sys_lsm_manage_policy(u32 lsm_id, u32 op, void __user *buf,
+		u32 __user *size, u32 flags);
+
+
 /*
  * Architecture-specific system calls
  */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2892a45023af..b94369baded8 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -851,9 +851,11 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
 #define __NR_open_tree_attr 467
 __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
+#define __NR_lsm_manage_policy 468
+__SYSCALL(__NR_lsm_manage_policy, lsm_manage_policy)
 
 #undef __NR_syscalls
-#define __NR_syscalls 468
+#define __NR_syscalls 469
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index c00a86931f8c..e556b07d8716 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -172,6 +172,7 @@ COND_SYSCALL_COMPAT(fadvise64_64);
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
 COND_SYSCALL(lsm_list_modules);
+COND_SYSCALL(lsm_manage_policy);
 
 /* CONFIG_MMU only */
 COND_SYSCALL(swapon);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 8440948a690c..dcaad8818679 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -118,3 +118,9 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
 
 	return lsm_active_cnt;
 }
+
+SYSCALL_DEFINE5(lsm_manage_policy, u32, lsm_id, u32, op, void __user *, buf, u32
+		__user *, size, u32, flags)
+{
+	return 0;
+}
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 2892a45023af..b94369baded8 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -851,9 +851,11 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
 #define __NR_open_tree_attr 467
 __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
+#define __NR_lsm_manage_policy 468
+__SYSCALL(__NR_lsm_manage_policy, lsm_manage_policy)
 
 #undef __NR_syscalls
-#define __NR_syscalls 468
+#define __NR_syscalls 469
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index cfb5ca41e30d..83819d4a5c8a 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -391,6 +391,7 @@
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
 467	common	open_tree_attr		sys_open_tree_attr
+468	common	lsm_manage_policy	sys_lsm_manage_policy
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.48.1


