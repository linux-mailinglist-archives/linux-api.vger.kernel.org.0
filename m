Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEE84955F2
	for <lists+linux-api@lfdr.de>; Thu, 20 Jan 2022 22:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377883AbiATV1S (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jan 2022 16:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377873AbiATV1P (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jan 2022 16:27:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B172C06173F;
        Thu, 20 Jan 2022 13:27:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF65761763;
        Thu, 20 Jan 2022 21:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A0BC340E0;
        Thu, 20 Jan 2022 21:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1642714034;
        bh=UF0J49HkTNgbP4QTXtrj0hgTqdLOzHUFrn27n+ynFi8=;
        h=Date:From:To:Subject:From;
        b=drlOc0/KGfBQfxKR7pTAm6ar4HB990Im5a8yDzgqLhSuLBzdqmunVdp51TeQ6OzpQ
         jNlx/jssW8z8jER4zpackmY0X1RgcfD6waLekThNGf3/7lTqM1nIxuBbbTP0UASqq6
         yRRHEzkAtI0s6P+Z6ONxzS8VbdBpJXyY3PUTajG8=
Date:   Thu, 20 Jan 2022 13:27:13 -0800
From:   akpm@linux-foundation.org
To:     aarcange@redhat.com, ak@linux.intel.com,
        aneesh.kumar@linux.ibm.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        feng.tang@intel.com, linux-api@vger.kernel.org,
        mgorman@techsingularity.net, mhocko@kernel.org,
        mike.kravetz@oracle.com, mm-commits@vger.kernel.org,
        rdunlap@infradead.org, vbabka@suse.cz, ying.huang@intel.com
Subject:  [merged]
 mm-mempolicy-wire-up-syscall-set_mempolicy_home_node.patch removed from -mm
 tree
Message-ID: <20220120212713.AcmVicne5%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


The patch titled
     Subject: mm/mempolicy: wire up syscall set_mempolicy_home_node
has been removed from the -mm tree.  Its filename was
     mm-mempolicy-wire-up-syscall-set_mempolicy_home_node.patch

This patch was dropped because it was merged into mainline or a subsystem tree

------------------------------------------------------
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: mm/mempolicy: wire up syscall set_mempolicy_home_node

Link: https://lkml.kernel.org/r/20211202123810.267175-4-aneesh.kumar@linux.ibm.com
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: <linux-api@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
 arch/arm/tools/syscall.tbl                  |    1 +
 arch/arm64/include/asm/unistd.h             |    2 +-
 arch/arm64/include/asm/unistd32.h           |    2 ++
 arch/ia64/kernel/syscalls/syscall.tbl       |    1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 +
 arch/s390/kernel/syscalls/syscall.tbl       |    1 +
 arch/sh/kernel/syscalls/syscall.tbl         |    1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 +
 include/linux/syscalls.h                    |    3 +++
 include/uapi/asm-generic/unistd.h           |    5 ++++-
 kernel/sys_ni.c                             |    1 +
 21 files changed, 27 insertions(+), 2 deletions(-)

--- a/arch/alpha/kernel/syscalls/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/alpha/kernel/syscalls/syscall.tbl
@@ -489,3 +489,4 @@
 # 557 reserved for memfd_secret
 558	common	process_mrelease		sys_process_mrelease
 559	common  futex_waitv                     sys_futex_waitv
+560	common	set_mempolicy_home_node		sys_ni_syscall
--- a/arch/arm64/include/asm/unistd32.h~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/arm64/include/asm/unistd32.h
@@ -905,6 +905,8 @@ __SYSCALL(__NR_landlock_restrict_self, s
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 #define __NR_futex_waitv 449
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
+#define __NR_set_mempolicy_home_node 450
+__SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
 /*
  * Please add new compat syscalls above this comment and update
--- a/arch/arm64/include/asm/unistd.h~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		450
+#define __NR_compat_syscalls		451
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
--- a/arch/arm/tools/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/arm/tools/syscall.tbl
@@ -463,3 +463,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/ia64/kernel/syscalls/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/ia64/kernel/syscalls/syscall.tbl
@@ -370,3 +370,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/m68k/kernel/syscalls/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/m68k/kernel/syscalls/syscall.tbl
@@ -449,3 +449,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/microblaze/kernel/syscalls/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -388,3 +388,4 @@
 # 447 reserved for memfd_secret
 448	n32	process_mrelease		sys_process_mrelease
 449	n32	futex_waitv			sys_futex_waitv
+450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -364,3 +364,4 @@
 # 447 reserved for memfd_secret
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -437,3 +437,4 @@
 # 447 reserved for memfd_secret
 448	o32	process_mrelease		sys_process_mrelease
 449	o32	futex_waitv			sys_futex_waitv
+450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/parisc/kernel/syscalls/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/parisc/kernel/syscalls/syscall.tbl
@@ -447,3 +447,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/powerpc/kernel/syscalls/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -529,3 +529,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
+450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/s390/kernel/syscalls/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/s390/kernel/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 # 447 reserved for memfd_secret
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
+450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
--- a/arch/sh/kernel/syscalls/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/sh/kernel/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/sparc/kernel/syscalls/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/sparc/kernel/syscalls/syscall.tbl
@@ -495,3 +495,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/x86/entry/syscalls/syscall_32.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/x86/entry/syscalls/syscall_32.tbl
@@ -454,3 +454,4 @@
 447	i386	memfd_secret		sys_memfd_secret
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
+450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/arch/x86/entry/syscalls/syscall_64.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/x86/entry/syscalls/syscall_64.tbl
@@ -371,6 +371,7 @@
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
+450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
--- a/arch/xtensa/kernel/syscalls/syscall.tbl~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -420,3 +420,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
--- a/include/linux/syscalls.h~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/include/linux/syscalls.h
@@ -1057,6 +1057,9 @@ asmlinkage long sys_landlock_add_rule(in
 		const void __user *rule_attr, __u32 flags);
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
 asmlinkage long sys_memfd_secret(unsigned int flags);
+asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
+					    unsigned long home_node,
+					    unsigned long flags);
 
 /*
  * Architecture-specific system calls
--- a/include/uapi/asm-generic/unistd.h~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/include/uapi/asm-generic/unistd.h
@@ -883,8 +883,11 @@ __SYSCALL(__NR_process_mrelease, sys_pro
 #define __NR_futex_waitv 449
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 
+#define __NR_set_mempolicy_home_node 450
+__SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
+
 #undef __NR_syscalls
-#define __NR_syscalls 450
+#define __NR_syscalls 451
 
 /*
  * 32 bit systems traditionally used different
--- a/kernel/sys_ni.c~mm-mempolicy-wire-up-syscall-set_mempolicy_home_node
+++ a/kernel/sys_ni.c
@@ -297,6 +297,7 @@ COND_SYSCALL(get_mempolicy);
 COND_SYSCALL(set_mempolicy);
 COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
+COND_SYSCALL(set_mempolicy_home_node);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
_

Patches currently in -mm which might be from aneesh.kumar@linux.ibm.com are


