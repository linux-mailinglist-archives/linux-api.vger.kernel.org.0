Return-Path: <linux-api+bounces-3946-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D7DAE0CC9
	for <lists+linux-api@lfdr.de>; Thu, 19 Jun 2025 20:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B76117A6658
	for <lists+linux-api@lfdr.de>; Thu, 19 Jun 2025 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872323C50B;
	Thu, 19 Jun 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MX3cQRa0"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF628D8D9;
	Thu, 19 Jun 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750357039; cv=none; b=kRDRbgPsCr2mXo7WAI1chB7Zli6G7vw3yvZyq4XrB30uevjSMOmi8twAy2vDAORYwcO2aGFkFcE5AXL37oqRjhTgfAtPdaYdhcsjKc9tKhJ3Vf2oX+e4rX8+fpvW9Ywsyu/sl8jQCTch5SoY5ybV1CDF7zEWfxDSaWtiovHypyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750357039; c=relaxed/simple;
	bh=8Ba/iUV8KxOwbPI5k+ksoH4gA6gnBCmY9MCf/lyBN3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3oUobT5Ffm2MEy2MW4WKiiQxiYfkMazLt8/X4VMWph2y02JnqG+1qnHPp0NDH1bbQU9IDpa+2C8Pi2OiTdZhCHOl6taytGAeEQ76QnD3vozUyYxRn3rC9qlBICHbv/XrU8qPvKU1UZtEnDdDNMFE9OZ9FqIrgbooQ+1ggGeL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MX3cQRa0; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 01A8E3F9D7;
	Thu, 19 Jun 2025 18:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1750357027;
	bh=gN5JUBqYStlK2RpnTIQjOj6RzVWh26VE7Kpa1MyH6GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=MX3cQRa0Qxz1Z4Vmxxs1iwoDEE4GkqZkxFj/aZ3IcGAPuhb+Tj+/bCQI2umBK1IGJ
	 3ViavU+e76AuoBwL0jFq93GdPr+oPeqGHXs1nJN76CBRs0mbHHLoDddewF76qFv5NK
	 P+L+CukR+gInY1XpSciBdECAk8+7Qj1T3QieDVC+6tCvBcMRj1vY9c2UMh4LAyjeEc
	 E034LNDMcnWkBsmt8tYLStZOs58FvIM25FCFWtmz0z4c5mrYdue+0655/tUuaqxVq3
	 g1HYquWg0Yaqc+0BNXssqjd7TWJ/GmoNMlbUYEHihtlxxWFYWafZnYRIZ6y8ewNnuE
	 3HgiqnjqTGlVQ==
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
	song@kernel.org,
	linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH v2 1/3] Wire up lsm_config_self_policy and lsm_config_system_policy syscalls
Date: Thu, 19 Jun 2025 20:15:31 +0200
Message-ID: <20250619181600.478038-2-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250619181600.478038-1-maxime.belair@canonical.com>
References: <20250619181600.478038-1-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the new lsm_config_self_policy and
lsm_config_system_policy syscalls, providing a unified API for loading
and modifying LSM policies, for the current user and for the entire
system, respectively without requiring the LSM’s pseudo-filesystems.

Benefits:
  - Works even if the LSM pseudo-filesystem isn’t mounted or available
    (e.g. in containers)
  - Offers a logical and unified interface rather than multiple
    heterogeneous pseudo-filesystems
  - Avoids the overhead of other kernel interfaces for better efficiency

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl            |  2 ++
 arch/arm/tools/syscall.tbl                        |  2 ++
 arch/m68k/kernel/syscalls/syscall.tbl             |  2 ++
 arch/microblaze/kernel/syscalls/syscall.tbl       |  2 ++
 arch/mips/kernel/syscalls/syscall_n32.tbl         |  2 ++
 arch/mips/kernel/syscalls/syscall_n64.tbl         |  2 ++
 arch/mips/kernel/syscalls/syscall_o32.tbl         |  2 ++
 arch/parisc/kernel/syscalls/syscall.tbl           |  2 ++
 arch/powerpc/kernel/syscalls/syscall.tbl          |  2 ++
 arch/s390/kernel/syscalls/syscall.tbl             |  2 ++
 arch/sh/kernel/syscalls/syscall.tbl               |  2 ++
 arch/sparc/kernel/syscalls/syscall.tbl            |  2 ++
 arch/x86/entry/syscalls/syscall_32.tbl            |  2 ++
 arch/x86/entry/syscalls/syscall_64.tbl            |  2 ++
 arch/xtensa/kernel/syscalls/syscall.tbl           |  2 ++
 include/linux/syscalls.h                          |  5 +++++
 include/uapi/asm-generic/unistd.h                 |  6 +++++-
 kernel/sys_ni.c                                   |  2 ++
 security/lsm_syscalls.c                           | 12 ++++++++++++
 tools/include/uapi/asm-generic/unistd.h           |  6 +++++-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |  2 ++
 21 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 2dd6340de6b4..4fc75352220d 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -507,3 +507,5 @@
 575	common	listxattrat			sys_listxattrat
 576	common	removexattrat			sys_removexattrat
 577	common	open_tree_attr			sys_open_tree_attr
+578	common	lsm_config_self_policy		sys_lsm_config_self_policy
+579	common	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 27c1d5ebcd91..326483cb94a4 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -482,3 +482,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	lsm_config_self_policy		sys_lsm_config_self_policy
+469	common	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 9fe47112c586..d37364df1cd7 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -467,3 +467,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	lsm_config_self_policy		sys_lsm_config_self_policy
+469	common	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 7b6e97828e55..9d58ebfcf967 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -473,3 +473,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	lsm_config_self_policy		sys_lsm_config_self_policy
+469	common	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index aa70e371bb54..8627b5f56280 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -406,3 +406,5 @@
 465	n32	listxattrat			sys_listxattrat
 466	n32	removexattrat			sys_removexattrat
 467	n32	open_tree_attr			sys_open_tree_attr
+468	n32	lsm_config_self_policy		sys_lsm_config_self_policy
+469	n32	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 1e8c44c7b614..813207b61f58 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -382,3 +382,5 @@
 465	n64	listxattrat			sys_listxattrat
 466	n64	removexattrat			sys_removexattrat
 467	n64	open_tree_attr			sys_open_tree_attr
+468	n64	lsm_config_self_policy		sys_lsm_config_self_policy
+469	n64	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 114a5a1a6230..9cd0946b4370 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -455,3 +455,5 @@
 465	o32	listxattrat			sys_listxattrat
 466	o32	removexattrat			sys_removexattrat
 467	o32	open_tree_attr			sys_open_tree_attr
+468	o32	lsm_config_self_policy		sys_lsm_config_self_policy
+469	o32	lsm_config_system_policy		sys_lsm_config_system_policy
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 94df3cb957e9..9db01dd55793 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -466,3 +466,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	lsm_config_self_policy		sys_lsm_config_self_policy
+469	common	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 9a084bdb8926..97714acb39ab 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -558,3 +558,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	lsm_config_self_policy		sys_lsm_config_self_policy
+469	common	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index a4569b96ef06..d2b0f14fb516 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -470,3 +470,5 @@
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
 467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
+468  common	lsm_config_self_policy	sys_lsm_config_self_policy		sys_lsm_config_self_policy
+469  common	lsm_config_system_policy	sys_lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 52a7652fcff6..210d7118ce16 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -471,3 +471,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	lsm_config_self_policy		sys_lsm_config_self_policy
+469	common	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 83e45eb6c095..494417d80680 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -513,3 +513,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	lsm_config_self_policy		sys_lsm_config_self_policy
+469	common	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ac007ea00979..36c2c538e04f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -473,3 +473,5 @@
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
 467	i386	open_tree_attr		sys_open_tree_attr
+468	i386	lsm_config_self_policy	sys_lsm_config_self_policy
+469	i386	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index cfb5ca41e30d..7eefbccfe531 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -391,6 +391,8 @@
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
 467	common	open_tree_attr		sys_open_tree_attr
+468	common	lsm_config_self_policy	sys_lsm_config_self_policy
+469	common	lsm_config_system_policy	sys_lsm_config_system_policy
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index f657a77314f8..90d86a54a952 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -438,3 +438,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	lsm_config_self_policy		sys_lsm_config_self_policy
+469	common	lsm_config_system_policy	sys_lsm_config_system_policy
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e5603cc91963..15b0f35c42fe 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -988,6 +988,11 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx __user *
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
 				      u32 size, u32 flags);
 asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
+asmlinkage long sys_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
+					   u32 __user *size, u32 flags);
+asmlinkage long sys_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
+					     u32 __user *size, u32 flags);
+
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2892a45023af..34278cc6a476 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -851,9 +851,13 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
 #define __NR_open_tree_attr 467
 __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
+#define __NR_lsm_config_self_policy 468
+__SYSCALL(__NR_lsm_config_self_policy, lsm_config_self_policy)
+#define __NR_lsm_config_system_policy 469
+__SYSCALL(__NR_lsm_config_system_policy, lsm_config_system_policy)
 
 #undef __NR_syscalls
-#define __NR_syscalls 468
+#define __NR_syscalls 470
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index c00a86931f8c..3ecebcd3fbe0 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -172,6 +172,8 @@ COND_SYSCALL_COMPAT(fadvise64_64);
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
 COND_SYSCALL(lsm_list_modules);
+COND_SYSCALL(lsm_config_self_policy);
+COND_SYSCALL(lsm_config_system_policy);
 
 /* CONFIG_MMU only */
 COND_SYSCALL(swapon);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 8440948a690c..a3cb6dab8102 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -118,3 +118,15 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
 
 	return lsm_active_cnt;
 }
+
+SYSCALL_DEFINE5(lsm_config_self_policy, u32, lsm_id, u32, op, void __user *,
+		buf, u32 __user *, size, u32, flags)
+{
+	return 0;
+}
+
+SYSCALL_DEFINE5(lsm_config_system_policy, u32, lsm_id, u32, op, void __user *,
+		buf, u32 __user *, size, u32, flags)
+{
+	return 0;
+}
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 2892a45023af..34278cc6a476 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -851,9 +851,13 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
 #define __NR_open_tree_attr 467
 __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
+#define __NR_lsm_config_self_policy 468
+__SYSCALL(__NR_lsm_config_self_policy, lsm_config_self_policy)
+#define __NR_lsm_config_system_policy 469
+__SYSCALL(__NR_lsm_config_system_policy, lsm_config_system_policy)
 
 #undef __NR_syscalls
-#define __NR_syscalls 468
+#define __NR_syscalls 470
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index cfb5ca41e30d..7eefbccfe531 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -391,6 +391,8 @@
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
 467	common	open_tree_attr		sys_open_tree_attr
+468	common	lsm_config_self_policy	sys_lsm_config_self_policy
+469	common	lsm_config_system_policy	sys_lsm_config_system_policy
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.48.1


