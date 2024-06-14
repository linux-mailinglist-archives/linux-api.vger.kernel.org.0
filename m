Return-Path: <linux-api+bounces-1742-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F909092C2
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2024 21:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C191C20C73
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2024 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69E91A2FC0;
	Fri, 14 Jun 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gab0yCyn"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B51A0AF0;
	Fri, 14 Jun 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392049; cv=none; b=HXzXTdDuF+ZhcnKfaEV/sVq9Js/20A1HnPvvoyO10xFiJ3r7vSbCqdaA9xuvr71BTM2w4GEoq5Eq64FfP03kqFgEZ/Ipfrhrb0CUXObkrY1UXAxVwmbEFaIm9rhrCoTTpfHp4xHNJrddz7Gej1S2ZQup/5xPtg/9XkLchQjIxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392049; c=relaxed/simple;
	bh=+VwfXW4VMlkJBydXwuXQw0Kma0zfq2BtR7bH+hwjmPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/peZuFiL0litUtLujBzRntLz4fSzKX+t1paXvuEJQ4R2JyYvjhkHhLNmzxiNdoKTlR2O6KoJawnyiL+YUti8MUuy4k7YXl9RXX3IiP/tG1s1zmnxwIwH8CfghV2RODMcIF4fj+Sc75XgHULGTaDe6qGQH6MJfA8JBgO5y8uIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Gab0yCyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41436C4AF4D;
	Fri, 14 Jun 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gab0yCyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718392047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/zOZOY+4oMO/AcAO2q91em/I4IHX2env/b0ApBbdD+Q=;
	b=Gab0yCynC0Jy+Qzv9HejX3Lfwy6L9DsYttnFUXjAAPXKxgULSFMj7fOudVoAX4kPJO80Mq
	mijQsf46U4txx6hJl8u/69tj1UqLPmy8I4Ud6PaVAPZMAqsANdUc+SSl7UXabuz5qKgq1b
	jU+5p+k4z3bDlPpifZjYO+QQ1z6dYIo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 02cd6e3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 19:07:27 +0000 (UTC)
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
Subject: [PATCH v17 3/5] arch: allocate vgetrandom_alloc() syscall number
Date: Fri, 14 Jun 2024 21:06:38 +0200
Message-ID: <20240614190646.2081057-4-Jason@zx2c4.com>
In-Reply-To: <20240614190646.2081057-1-Jason@zx2c4.com>
References: <20240614190646.2081057-1-Jason@zx2c4.com>
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
 22 files changed, 29 insertions(+), 2 deletions(-)

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
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 266b96acc014..e84fa30ccd30 100644
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
index cc869f5d5693..9b1bda3d8383 100644
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
index 008ebe60263e..97698956cdce 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -450,3 +450,4 @@
 460	o32	lsm_set_self_attr		sys_lsm_set_self_attr
 461	o32	lsm_list_modules		sys_lsm_list_modules
 462	o32	mseal				sys_mseal
+463	o32	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index b13c21373974..5fbbb25699b9 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -461,3 +461,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 3656f1ca7a21..b1c3ae68014c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -549,3 +549,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index bd0fee24ad10..1188429316c1 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -465,3 +465,4 @@
 460  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
 461  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
 462  common	mseal			sys_mseal			sys_mseal
+463  common	vgetrandom_alloc	sys_vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index bbf83a2db986..06cec74502f7 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -465,3 +465,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index ac6c281ccfe0..a3816995d08c 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -508,3 +508,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal 				sys_mseal
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 7fd1f57ad3d3..821990638567 100644
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
index d983c48a3b6a..e94210483f60 100644
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
index 75f00965ab15..93ad41d563a1 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
+#define __NR_vgetrandom_alloc 463
+__SYSCALL(__NR_vgetrandom_alloc, sys_vgetrandom_alloc)
+
 #undef __NR_syscalls
-#define __NR_syscalls 462
+#define __NR_syscalls 464
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 532b855df589..e22932472146 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -376,3 +376,4 @@
 459	n64	lsm_get_self_attr		sys_lsm_get_self_attr
 460	n64	lsm_set_self_attr		sys_lsm_set_self_attr
 461	n64	lsm_list_modules		sys_lsm_list_modules
+463	n64	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 17173b82ca21..ebdb199833d8 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -548,3 +548,4 @@
 459	common	lsm_get_self_attr		sys_lsm_get_self_attr
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
+463	common	vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 095bb86339a7..ccb29b16fe80 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -464,3 +464,4 @@
 459  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
 460  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
 461  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
+463  common	vgetrandom_alloc	sys_vgetrandom_alloc		sys_vgetrandom_alloc
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..eb42a7b284ca 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -383,6 +383,7 @@
 459	common	lsm_get_self_attr	sys_lsm_get_self_attr
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
+463	common	vgetrandom_alloc	sys_vgetrandom_alloc
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.45.2


