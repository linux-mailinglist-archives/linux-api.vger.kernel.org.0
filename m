Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DFC3D3128
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 03:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhGWAeK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Jul 2021 20:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbhGWAeJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Jul 2021 20:34:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFE4C061757
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 18:14:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s186-20020a252cc30000b029055bc7fcfebdso9620682ybs.12
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 18:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qf81cBp3skjOtiuzq6c2Xo+gih+lqRUyIFxlMzZHuco=;
        b=fXKit0DpC2SRjeRGutNxFE5XLB/h6edT4L+dOTwnx2292LDS4Qab1imrzzQST5IZwb
         2S2sG1eiVK743H95pRW2mgCGu3M4/1+k75Yq99cxD7ZQHlpX3O18CHWTLS3Jc1425+D9
         2ojwlJtFSMdcxBd5uzabe8rL16luBycfja7bLgsDuOGYLR4cfocwtLJsC74yAx40kiZE
         Hg/BXJR3UlxPoXwxWssI5F0LMV2arQ6F9vdxUJCrYX6K6gmhRkRwuWvoE3l5+i/1rV2Z
         U/BtM6I/ItUYEu51Yrv/evx4E7tb2tJXoAqtvR3KMMAFKXCO44sLRtoJnOM6dFouU8lB
         urbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qf81cBp3skjOtiuzq6c2Xo+gih+lqRUyIFxlMzZHuco=;
        b=PCZmuStxqlTRqVdyEpuOEiUv4MIUixSN/+p13UA5vsD21Lkq68HlQls7uALloMBP7T
         xWlqr+35O9r6AOPRzHvuxNJh/eyc2rNaDk+/LeMb4hmZ4T11PGbJmYkl9uFTkAOSNxWt
         20/8Dwg3AnuVvDPinaXVTYoprqsdSrsB6+8DDkSwwByqp87nJYlXywJw8+Wr8/Qnp2Lb
         ddKbrbTTVzDl9pJo4o8l5cNtPEyeHzAegD7m8dcFDtNuf4xuGeo+sbMs4y7dDYcgqfdx
         g9IQSe9wlfw6aEdFNnvREIXdVAHsASOgL3+hrVLL2GzCYWFxYRCS0K6U8cMnOWLAEIru
         GP1w==
X-Gm-Message-State: AOAM530Ct+kzywan61IxEIjF/WbleugZPx4H4rhl7rvWQE3c46kYsEEP
        UtYHR9H8EooGVcxi3dnOFTnKhcsE3W4=
X-Google-Smtp-Source: ABdhPJxWbM4I6UDxplIbV9P1VyEjvwzUIIfmCm8CVkL7ecy+h7icYkm5iNrnZqIU0w9gB8QVQHhQXZwUNA8=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:9b49:cc32:b051:fd83])
 (user=surenb job=sendgmr) by 2002:a5b:4c8:: with SMTP id u8mr3214158ybp.255.1627002882102;
 Thu, 22 Jul 2021 18:14:42 -0700 (PDT)
Date:   Thu, 22 Jul 2021 18:14:36 -0700
In-Reply-To: <20210723011436.60960-1-surenb@google.com>
Message-Id: <20210723011436.60960-2-surenb@google.com>
Mime-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 2/2] mm: wire up syscall process_mrelease
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Split off from prev patch in the series that implements the syscall.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 2 ++
 arch/arm/tools/syscall.tbl                  | 2 ++
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 2 ++
 arch/ia64/kernel/syscalls/syscall.tbl       | 2 ++
 arch/m68k/kernel/syscalls/syscall.tbl       | 2 ++
 arch/microblaze/kernel/syscalls/syscall.tbl | 2 ++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 2 ++
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 2 ++
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 2 ++
 arch/parisc/kernel/syscalls/syscall.tbl     | 2 ++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 2 ++
 arch/s390/kernel/syscalls/syscall.tbl       | 2 ++
 arch/sh/kernel/syscalls/syscall.tbl         | 2 ++
 arch/sparc/kernel/syscalls/syscall.tbl      | 2 ++
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 2 ++
 include/linux/syscalls.h                    | 1 +
 include/uapi/asm-generic/unistd.h           | 4 +++-
 kernel/sys_ni.c                             | 1 +
 21 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index a17687ed4b51..605645eae04c 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -486,3 +486,5 @@
 554	common	landlock_create_ruleset		sys_landlock_create_ruleset
 555	common	landlock_add_rule		sys_landlock_add_rule
 556	common	landlock_restrict_self		sys_landlock_restrict_self
+# 557 reserved for memfd_secret
+558	common	process_mrelease		sys_process_mrelease
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index c5df1179fc5d..2f32eb8beca8 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -460,3 +460,5 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 727bfc3be99b..3cb206aea3db 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		447
+#define __NR_compat_syscalls		449
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 99ffcafc736c..0f49cdb180dd 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -901,6 +901,8 @@ __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
 __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
 #define __NR_landlock_restrict_self 446
 __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
+#define __NR_process_mrelease 448
+__SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 6d07742c57b8..9bf45f2be966 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -367,3 +367,5 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 541bc1b3a8f9..f1f98ee6c82d 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -446,3 +446,5 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index a176faca2927..da49ddd4bb54 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -452,3 +452,5 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index c2d2e19abea8..56c8d3cf42ed 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -385,3 +385,5 @@
 444	n32	landlock_create_ruleset		sys_landlock_create_ruleset
 445	n32	landlock_add_rule		sys_landlock_add_rule
 446	n32	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	n32	process_mrelease		sys_process_mrelease
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index ac653d08b1ea..1ca7bc337932 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -361,3 +361,5 @@
 444	n64	landlock_create_ruleset		sys_landlock_create_ruleset
 445	n64	landlock_add_rule		sys_landlock_add_rule
 446	n64	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	n64	process_mrelease		sys_process_mrelease
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 253f2cd70b6b..fd3a9df60ec2 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -434,3 +434,5 @@
 444	o32	landlock_create_ruleset		sys_landlock_create_ruleset
 445	o32	landlock_add_rule		sys_landlock_add_rule
 446	o32	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	o32	process_mrelease		sys_process_mrelease
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index e26187b9ab87..040df1b7a589 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -444,3 +444,5 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index aef2a290e71a..d8ebd7d37c0f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -526,3 +526,5 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 64d51ab5a8b4..57233ace30cb 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -449,3 +449,5 @@
 444  common	landlock_create_ruleset	sys_landlock_create_ruleset	sys_landlock_create_ruleset
 445  common	landlock_add_rule	sys_landlock_add_rule		sys_landlock_add_rule
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index e0a70be77d84..2f6e95eb4690 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -449,3 +449,5 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 603f5a821502..42fc2906215d 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -492,3 +492,5 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ce763a12311c..661a03bcfbd1 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -452,3 +452,4 @@
 445	i386	landlock_add_rule	sys_landlock_add_rule
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
 447	i386	memfd_secret		sys_memfd_secret
+448	i386	process_mrelease	sys_process_mrelease
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f6b57799c1ea..807b6a1de8e8 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -369,6 +369,7 @@
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
 447	common	memfd_secret		sys_memfd_secret
+448	common	process_mrelease	sys_process_mrelease
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 235d67d6ceb4..f4384951f393 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -417,3 +417,5 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 69c9a7010081..00bc170a50f0 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -915,6 +915,7 @@ asmlinkage long sys_mincore(unsigned long start, size_t len,
 asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
 asmlinkage long sys_process_madvise(int pidfd, const struct iovec __user *vec,
 			size_t vlen, int behavior, unsigned int flags);
+asmlinkage long sys_process_mrelease(int pidfd, unsigned int flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a9d6fcd95f42..14c8fe863c6d 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -877,9 +877,11 @@ __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 #define __NR_memfd_secret 447
 __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #endif
+#define __NR_process_mrelease 448
+__SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 
 #undef __NR_syscalls
-#define __NR_syscalls 448
+#define __NR_syscalls 449
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 30971b1dd4a9..18a9c2cde767 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -289,6 +289,7 @@ COND_SYSCALL(munlockall);
 COND_SYSCALL(mincore);
 COND_SYSCALL(madvise);
 COND_SYSCALL(process_madvise);
+COND_SYSCALL(process_mrelease);
 COND_SYSCALL(remap_file_pages);
 COND_SYSCALL(mbind);
 COND_SYSCALL_COMPAT(mbind);
-- 
2.32.0.432.gabb21c7263-goog

