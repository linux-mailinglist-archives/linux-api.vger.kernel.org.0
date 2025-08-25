Return-Path: <linux-api+bounces-4591-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C8BB34EA0
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 00:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061192A23D1
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB062F83A5;
	Mon, 25 Aug 2025 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2+qNrEB"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA02EA17D;
	Mon, 25 Aug 2025 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159151; cv=none; b=UqQsen78pInCQWwu9i1I1vzhuLW/L9CHHayavkP/iHdXKfeaU1wlddSyWgM3BYWWq4q2iUS3qrg0hwehaI4MKW5EAQbkCqvl3m4Eit0VB/bQOwWevauqKo135Y6hdgzP4QbH63Ro0qNTjwlJP7WKfrj+o5CmxaWlEQzCjuCzPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159151; c=relaxed/simple;
	bh=fuWodoezyKYbYfnkUdVqccH9E/vnBfXHjLS7NnAZvqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJvHQ1IZsY12HbnL+b5QTmzFDlxuJn/5sX8sJFRaqiT6Pa+xw45v6NnOecVOKOX0RIkPPGaTtPDYQ3INJOBA7ZxT/9UmNJqXtbRqFjgKlsN3Zl69AOE4ocbElU/6boZeFFsS3WDTkh3ovuNoPuU1/aeNZJ1k9T3VbZE8xDZLAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2+qNrEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06F0C19424;
	Mon, 25 Aug 2025 21:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159151;
	bh=fuWodoezyKYbYfnkUdVqccH9E/vnBfXHjLS7NnAZvqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2+qNrEBufRq1nhjs2Ht3LnH8jbC2q0f2dNRFWVuNjutvTttheS+xpLnrZxO32Iv5
	 paMQAJdS7nmyWNsKiO1rH0jd7gdLxxm1vP+Nmbqbck0FQaoMSu83WIJrglSPI0idRL
	 1XqyhxhexSGS1hQsKquyVKD2eEBw1Nu6MQio80m3ikLowpu1ytaZxCzS2dO41HAHVK
	 Hoya3KSthExOTZgTY7rcN7Ht82oAJWRONoMokq5IANahzLN/FJaEicwc/yI479Zq4N
	 +oWXBlop4jC40xqgaMJXVgN3oPRSfDdojkCayNSBT2C3sfm8rifGB5R1lOj0NPSNYX
	 slYezDLv2Fejw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-api@vger.kernel.org
Subject: [PATCH 07/11] tools headers: Sync syscall tables with the kernel source
Date: Mon, 25 Aug 2025 14:58:59 -0700
Message-ID: <20250825215904.2594216-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
In-Reply-To: <20250825215904.2594216-1-namhyung@kernel.org>
References: <20250825215904.2594216-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  be7efb2d20d67f33 fs: introduce file_getattr and file_setattr syscalls

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
    diff -u tools/scripts/syscall.tbl scripts/syscall.tbl
    diff -u tools/perf/arch/x86/entry/syscalls/syscall_32.tbl arch/x86/entry/syscalls/syscall_32.tbl
    diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
    diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
    diff -u tools/perf/arch/arm/entry/syscalls/syscall.tbl arch/arm/tools/syscall.tbl
    diff -u tools/perf/arch/sh/entry/syscalls/syscall.tbl arch/sh/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/sparc/entry/syscalls/syscall.tbl arch/sparc/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/xtensa/entry/syscalls/syscall.tbl arch/xtensa/kernel/syscalls/syscall.tbl

Please see tools/include/uapi/README for further details.

Cc: Arnd Bergmann <arnd@arndb.de>
CC: linux-api@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/asm-generic/unistd.h             | 8 +++++++-
 tools/perf/arch/arm/entry/syscalls/syscall.tbl      | 2 ++
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 2 ++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 2 ++
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 2 ++
 tools/perf/arch/sh/entry/syscalls/syscall.tbl       | 2 ++
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl    | 2 ++
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl   | 2 ++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 2 ++
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl   | 2 ++
 tools/scripts/syscall.tbl                           | 2 ++
 11 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 2892a45023af6d3e..04e0077fb4c97a4d 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -852,8 +852,14 @@ __SYSCALL(__NR_removexattrat, sys_removexattrat)
 #define __NR_open_tree_attr 467
 __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 
+/* fs/inode.c */
+#define __NR_file_getattr 468
+__SYSCALL(__NR_file_getattr, sys_file_getattr)
+#define __NR_file_setattr 469
+__SYSCALL(__NR_file_setattr, sys_file_setattr)
+
 #undef __NR_syscalls
-#define __NR_syscalls 468
+#define __NR_syscalls 470
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/arm/entry/syscalls/syscall.tbl b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
index 27c1d5ebcd91c8c2..b07e699aaa3c2840 100644
--- a/tools/perf/arch/arm/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
@@ -482,3 +482,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 1e8c44c7b61492ea..7a7049c2c307885f 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -382,3 +382,5 @@
 465	n64	listxattrat			sys_listxattrat
 466	n64	removexattrat			sys_removexattrat
 467	n64	open_tree_attr			sys_open_tree_attr
+468	n64	file_getattr			sys_file_getattr
+469	n64	file_setattr			sys_file_setattr
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 9a084bdb892694bc..b453e80dfc003796 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -558,3 +558,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index a4569b96ef06c54c..8a6744d658db3986 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -470,3 +470,5 @@
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
 467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
+468  common	file_getattr		sys_file_getattr		sys_file_getattr
+469  common	file_setattr		sys_file_setattr		sys_file_setattr
diff --git a/tools/perf/arch/sh/entry/syscalls/syscall.tbl b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
index 52a7652fcff6394b..5e9c9eff5539e241 100644
--- a/tools/perf/arch/sh/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
@@ -471,3 +471,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
index 83e45eb6c095a36b..ebb7d06d1044fa9b 100644
--- a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
@@ -513,3 +513,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
index ac007ea00979dc28..4877e16da69a50f2 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
@@ -473,3 +473,5 @@
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
 467	i386	open_tree_attr		sys_open_tree_attr
+468	i386	file_getattr		sys_file_getattr
+469	i386	file_setattr		sys_file_setattr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index cfb5ca41e30de1a4..92cf0fe2291eb99b 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -391,6 +391,8 @@
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
 467	common	open_tree_attr		sys_open_tree_attr
+468	common	file_getattr		sys_file_getattr
+469	common	file_setattr		sys_file_setattr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
index f657a77314f8667f..374e4cb788d8a6d4 100644
--- a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
@@ -438,3 +438,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/tools/scripts/syscall.tbl b/tools/scripts/syscall.tbl
index 580b4e246aecd5f0..d1ae5e92c615b58e 100644
--- a/tools/scripts/syscall.tbl
+++ b/tools/scripts/syscall.tbl
@@ -408,3 +408,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
-- 
2.51.0.261.g7ce5a0a67e-goog


