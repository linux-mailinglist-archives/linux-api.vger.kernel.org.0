Return-Path: <linux-api+bounces-1830-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965B4926843
	for <lists+linux-api@lfdr.de>; Wed,  3 Jul 2024 20:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6B9B25204
	for <lists+linux-api@lfdr.de>; Wed,  3 Jul 2024 18:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897A8188CA5;
	Wed,  3 Jul 2024 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l2KVI/Q1"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED6187543;
	Wed,  3 Jul 2024 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031513; cv=none; b=ZlLIsPRH4WDLRLyB+3fkb71tuxEGPDY/ZhuMrcpSpmq3oTAWMsGmKHij5dbn0RQ82BRdyfl+k+sIS/SAS62ROffr0yZkaaX6dC8eRhkFW7ApSe09o0pXW/MCque/x68F+O8crf0t0jQ3oPgnBbFoRm3parWNmwn7kFj1Usmt65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031513; c=relaxed/simple;
	bh=mlKrlZsM2kxxH+2KQS5wVbypnk5Nt1Pj/gYe5SLqVyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nB4/b+WLg9hBC3Ppmvz5R8Ak236U+R53uoPG0LwsPFuJMtbLimzllnlPzLk9OFzbjZlXJHFjYrq7GaYi/gZaQdei6tLrh30NlZW+teFV8eVVoaprcAk8Et84D2BQGPlcOid7Dx+zj1NpE91774yweegiozLq3TZpmDYT33FrjS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=l2KVI/Q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A276CC32781;
	Wed,  3 Jul 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l2KVI/Q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720031510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTGFstFNiRrivg7s+0hzqneNA0GxmnYcJcWIVfMpi9Q=;
	b=l2KVI/Q1PfUrSRtHhsE7tPhNKAjeLKQgSySG8N5E/9FDRzwhUWCstSy1ua3aBaceHarLSG
	CtN955DzrLjxjsusgWBspKRLwos0LAcwTdnZztYJLKc1vIkL15MQK72sFzlljYXItZ0DZI
	qPPdFvLSjW5f+wEdH7O3Nw2sV+WV3ak=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6853b275 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jul 2024 18:31:49 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	tglx@linutronix.de
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v20 3/5] arch: allocate vgetrandom_alloc() syscall number
Date: Wed,  3 Jul 2024 20:31:12 +0200
Message-ID: <20240703183115.1075219-4-Jason@zx2c4.com>
In-Reply-To: <20240703183115.1075219-1-Jason@zx2c4.com>
References: <20240703183115.1075219-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vgetrandom_alloc() as syscall 463 (or 573 on alpha) by adding it to
all of the various syscall.tbl and unistd.h files.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl              | 1 +
 arch/arm/tools/syscall.tbl                          | 1 +
 arch/arm64/include/asm/unistd.h                     | 2 +-
 arch/arm64/include/asm/unistd32.h                   | 2 ++
 arch/m68k/kernel/syscalls/syscall.tbl               | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl         | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl           | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl           | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl           | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl             | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl            | 1 +
 arch/s390/kernel/syscalls/syscall.tbl               | 1 +
 arch/sh/kernel/syscalls/syscall.tbl                 | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl              | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl              | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl              | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl             | 1 +
 include/uapi/asm-generic/unistd.h                   | 5 ++++-
 tools/include/uapi/asm-generic/unistd.h             | 5 ++++-
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 1 +
 23 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 74720667fe09..8c38193bf86a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -502,3 +502,4 @@
 570	common	lsm_set_self_attr		sys_lsm_set_self_attr
 571	common	lsm_list_modules		sys_lsm_list_modules
 572	common  mseal				sys_mseal
+573	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 2ed7d229c8f9..118e41178905 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -476,3 +476,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 1346579f802f..6067f617273f 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		463
+#define __NR_compat_syscalls		464
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 1386e8e751f2..f7a45c1788b3 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -931,6 +931,8 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 #define __NR_mseal 462
 __SYSCALL(__NR_mseal, sys_mseal)
+#define __NR_vgetrandom_alloc 463
+__SYSCALL(__NR_vgetrandom_alloc, sys_vgetrandom_alloc)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 22a3cbd4c602..bd919d1a8231 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -462,3 +462,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 2b81a6bd78b2..d3d3c017a5bb 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -468,3 +468,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 953f5b7dc723..502cedc0f84d 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -401,3 +401,4 @@
 460	n32	lsm_set_self_attr		sys_lsm_set_self_attr
 461	n32	lsm_list_modules		sys_lsm_list_modules
 462	n32	mseal				sys_mseal
+463	n32	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 1464c6be6eb3..33710f855c46 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -377,3 +377,4 @@
 460	n64	lsm_set_self_attr		sys_lsm_set_self_attr
 461	n64	lsm_list_modules		sys_lsm_list_modules
 462	n64	mseal				sys_mseal
+463	n64	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 2439a2491cff..f342d3f26396 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -450,3 +450,4 @@
 460	o32	lsm_set_self_attr		sys_lsm_set_self_attr
 461	o32	lsm_list_modules		sys_lsm_list_modules
 462	o32	mseal				sys_mseal
+463	o32	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 66dc406b12e4..cddae8bc6fd5 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -461,3 +461,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index ebae8415dfbb..5c01ec49f510 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -553,3 +553,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 01071182763e..f5abf7e496ee 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -465,3 +465,4 @@
 460  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
 461  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
 462  common	mseal			sys_mseal			sys_mseal
+463  common	vgetrandom_alloc	sys_vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c55fd7696d40..b911231478ee 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -466,3 +466,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index cfdfb3707c16..7578d0dee5b1 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -508,3 +508,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal 				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index d6ebcab1d8b2..c4fc7c4f65c3 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -467,3 +467,4 @@
 460	i386	lsm_set_self_attr	sys_lsm_set_self_attr
 461	i386	lsm_list_modules	sys_lsm_list_modules
 462	i386	mseal 			sys_mseal
+463	i386	vgetrandom_alloc	sys_vgetrandom_alloc
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index a396f6e6ab5b..441443ba2ae6 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -384,6 +384,7 @@
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
 462 	common  mseal			sys_mseal
+463	common	vgetrandom_alloc	sys_vgetrandom_alloc
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 67083fc1b2f5..b9f64edd0b18 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -433,3 +433,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal 				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index d4cc26932ff4..57371c90dc13 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -845,8 +845,11 @@ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 #define __NR_mseal 462
 __SYSCALL(__NR_mseal, sys_mseal)
 
+#define __NR_vgetrandom_alloc 463
+__SYSCALL(__NR_vgetrandom_alloc, sys_vgetrandom_alloc)
+
 #undef __NR_syscalls
-#define __NR_syscalls 463
+#define __NR_syscalls 464
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index d983c48a3b6a..e94210483f60 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -845,8 +845,11 @@ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 #define __NR_mseal 462
 __SYSCALL(__NR_mseal, sys_mseal)
 
+#define __NR_vgetrandom_alloc 463
+__SYSCALL(__NR_vgetrandom_alloc, sys_vgetrandom_alloc)
+
 #undef __NR_syscalls
-#define __NR_syscalls 463
+#define __NR_syscalls 464
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 1464c6be6eb3..33710f855c46 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -377,3 +377,4 @@
 460	n64	lsm_set_self_attr		sys_lsm_set_self_attr
 461	n64	lsm_list_modules		sys_lsm_list_modules
 462	n64	mseal				sys_mseal
+463	n64	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 3656f1ca7a21..b1c3ae68014c 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -549,3 +549,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index bd0fee24ad10..1188429316c1 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -465,3 +465,4 @@
 460  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
 461  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
 462  common	mseal			sys_mseal			sys_mseal
+463  common	vgetrandom_alloc	sys_vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index a396f6e6ab5b..441443ba2ae6 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -384,6 +384,7 @@
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
 462 	common  mseal			sys_mseal
+463	common	vgetrandom_alloc	sys_vgetrandom_alloc
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.45.2


