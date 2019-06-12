Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605ED4300D
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfFLT2J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:28:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46374 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfFLT0y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so18091352wrw.13
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FC3oeW86TpoUhU2u+XmSM3ET8u46Qh/OH954yneG6/w=;
        b=N9xvVDlb5zlpNNgnCRHpPRe5qEmjICcbTocDNAph0T09EjCkkfC+FWUyYK8FdzSW5/
         OBhgu4q2TAU26iuGISdlpUt0V21+bKSXEmBStwGXoGPNFBo2WWUAXPQVyYFRzbz/9DZk
         +qY1ot+CqEQorvwAXKZXZOKGi72hEF7x+TH2PGha0RZVhO8rVkODZRraW24NLZwGQ5cR
         ke3J0Vc0dS2C/01HgN3Wv98ReX1uNM0Y3roK/zu+Y+3foriFoNl6UEgpbNO5W+gvyDPH
         oA6Qpy5BT3mKUutoOIYmuIfKEXhtdM6wnvl6i3i33LYFcHL4bEuc5K13pPprsBc4U6R0
         u/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FC3oeW86TpoUhU2u+XmSM3ET8u46Qh/OH954yneG6/w=;
        b=hGtHL0h3+USOlDpJT7p3hv7pU8tb/pmV6uCzZLvb5WHoGuGNZ+9YSdXL5GBCouZdIk
         txhZJtbc+5i0gBhV3QwemyPWR13W+RlZVd7qMRrhKUxOSILv02q5sxfE+5/mBvFsg/+6
         FrSsbv+rcGebTh3GlWPX7pAOi1EK31l5QY1F44fQzbNZw75dyt+pJLlqJ5F+w7dtF+zk
         NnaTVWAHQniPp9+PtyFQkrpk+9Ej0RMTLSYvUyFCrPD1Nv10BIOFomgb3Aaxb8A3ycVU
         8//NW2QTZIBRshDDnLSZd5v/JM8QNUK2mAivK2gUqUqOc3kWDYt0YPbgTJ/0MQlMnhV+
         BTWQ==
X-Gm-Message-State: APjAAAWgUVl0CFOGZjSi4HdxKH5HxFLsiG3O2hH/CVrlSmIIWFHQnMqG
        zpkQrkLuCZjkQXFfCFcr/PNYTg==
X-Google-Smtp-Source: APXvYqxiGsluolQMy5fKcAC5qndDyYqfkbZOGX7+Gpqn37PWdstABJ3BBwWbxIopYZxjBdfkYMv6og==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr8961147wrq.251.1560367611639;
        Wed, 12 Jun 2019 12:26:51 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:50 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv4 15/28] x86/vdso: Add offsets page in vvar
Date:   Wed, 12 Jun 2019 20:26:14 +0100
Message-Id: <20190612192628.23797-16-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

As modern applications fetch time from VDSO without entering the kernel,
it's needed to provide offsets for userspace code inside time namespace.

A page for timens offsets is allocated on time namespace construction.
Put that page into VVAR for tasks inside timens and zero page for
host processes.

As VDSO code is already optimized as much as possible in terms of speed,
any new if-condition in VDSO code is undesirable; the goal is to provide
two .so(s), as was originally suggested by Andy and Thomas:
- for host tasks with optimized-out clk_to_ns() without any penalty
- for processes inside timens with clk_to_ns()
For this purpose, define clk_to_ns() under CONFIG_TIME_NS.

To eliminate any performance regression, clk_to_ns() will be called
under static_branch with follow-up patches, that adds support for
patching vdso.

VDSO mappings are platform-specific, add Kconfig dependency for arch.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/Kconfig                          |  5 ++++
 arch/x86/Kconfig                      |  1 +
 arch/x86/entry/vdso/vclock_gettime.c  | 43 +++++++++++++++++++++++++++
 arch/x86/entry/vdso/vdso-layout.lds.S |  9 +++++-
 arch/x86/entry/vdso/vdso2c.c          |  3 ++
 arch/x86/entry/vdso/vma.c             | 12 ++++++++
 arch/x86/include/asm/vdso.h           |  1 +
 init/Kconfig                          |  1 +
 8 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c47b328eada0..503a4113dc6c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -734,6 +734,11 @@ config HAVE_ARCH_NVRAM_OPS
 config ISA_BUS_API
 	def_bool ISA
 
+config ARCH_HAS_VDSO_TIME_NS
+	bool
+	help
+	 VDSO can add time-ns offsets without entering kernel.
+
 #
 # ABI hall of shame
 #
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1ba31..da70b320eb09 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -79,6 +79,7 @@ config X86
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VDSO_TIME_NS
 	select ARCH_HAS_ZONE_DEVICE		if X86_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 0f82a70c7682..e2d93628c0dd 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -21,6 +21,7 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <linux/timens_offsets.h>
 
 #define gtod (&VVAR(vsyscall_gtod_data))
 
@@ -38,6 +39,11 @@ extern u8 hvclock_page[PAGE_SIZE]
 	__attribute__((visibility("hidden")));
 #endif
 
+#ifdef CONFIG_TIME_NS
+extern u8 timens_page
+	__attribute__((visibility("hidden")));
+#endif
+
 #ifndef BUILD_VDSO32
 
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
@@ -139,6 +145,39 @@ notrace static inline u64 vgetcyc(int mode)
 	return U64_MAX;
 }
 
+#ifdef CONFIG_TIME_NS
+notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts)
+{
+	struct timens_offsets *timens = (struct timens_offsets *) &timens_page;
+	struct timespec64 *offset64;
+
+	switch (clk) {
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_COARSE:
+	case CLOCK_MONOTONIC_RAW:
+		offset64 = &timens->monotonic;
+		break;
+	case CLOCK_BOOTTIME:
+		offset64 = &timens->boottime;
+	default:
+		return;
+	}
+
+	ts->tv_nsec += offset64->tv_nsec;
+	ts->tv_sec += offset64->tv_sec;
+	if (ts->tv_nsec >= NSEC_PER_SEC) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+	if (ts->tv_nsec < 0) {
+		ts->tv_nsec += NSEC_PER_SEC;
+		ts->tv_sec--;
+	}
+}
+#else
+notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts) {}
+#endif
+
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
 	struct vgtod_ts *base = &gtod->basetime[clk];
@@ -165,6 +204,8 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
 	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
+	clk_to_ns(clk, ts);
+
 	return 0;
 }
 
@@ -178,6 +219,8 @@ notrace static void do_coarse(clockid_t clk, struct timespec *ts)
 		ts->tv_sec = base->sec;
 		ts->tv_nsec = base->nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
+
+	clk_to_ns(clk, ts);
 }
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 93c6dc7812d0..ba216527e59f 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -7,6 +7,12 @@
  * This script controls its layout.
  */
 
+#ifdef CONFIG_TIME_NS
+# define TIMENS_SZ	PAGE_SIZE
+#else
+# define TIMENS_SZ	0
+#endif
+
 SECTIONS
 {
 	/*
@@ -16,7 +22,7 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - 3 * PAGE_SIZE;
+	vvar_start = . - (3 * PAGE_SIZE + TIMENS_SZ);
 	vvar_page = vvar_start;
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
@@ -28,6 +34,7 @@ SECTIONS
 
 	pvclock_page = vvar_start + PAGE_SIZE;
 	hvclock_page = vvar_start + 2 * PAGE_SIZE;
+	timens_page = vvar_start + 3 * PAGE_SIZE;
 
 	. = SIZEOF_HEADERS;
 
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index ce67370d14e5..7380908045c7 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -75,12 +75,14 @@ enum {
 	sym_vvar_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 const int special_pages[] = {
 	sym_vvar_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 struct vdso_sym {
@@ -93,6 +95,7 @@ struct vdso_sym required_syms[] = {
 	[sym_vvar_page] = {"vvar_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_hvclock_page] = {"hvclock_page", true},
+	[sym_timens_page] = {"timens_page", true},
 	{"VDSO32_NOTE_MASK", true},
 	{"__kernel_vsyscall", true},
 	{"__kernel_sigreturn", true},
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index c30a33b2963b..8a7f4cfe1fad 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -14,6 +14,7 @@
 #include <linux/elf.h>
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
+#include <linux/time_namespace.h>
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 #include <asm/proto.h>
@@ -23,6 +24,7 @@
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
 #include <asm/mshyperv.h>
+#include <asm/page.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
@@ -135,6 +137,16 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address,
 					vmalloc_to_pfn(tsc_pg));
+	} else if (sym_offset == image->sym_timens_page) {
+		struct time_namespace *ns = current->nsproxy->time_ns;
+		unsigned long pfn;
+
+		if (!ns->offsets)
+			pfn = page_to_pfn(ZERO_PAGE(0));
+		else
+			pfn = page_to_pfn(virt_to_page(ns->offsets));
+
+		return vmf_insert_pfn(vma, vmf->address, pfn);
 	}
 
 	return VM_FAULT_SIGBUS;
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index dffdc12cc7d6..9d420c545607 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -21,6 +21,7 @@ struct vdso_image {
 	long sym_vvar_page;
 	long sym_pvclock_page;
 	long sym_hvclock_page;
+	long sym_timens_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;
diff --git a/init/Kconfig b/init/Kconfig
index 098fe185360c..3d9497241394 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -993,6 +993,7 @@ config UTS_NS
 
 config TIME_NS
 	bool "TIME namespace"
+	depends on ARCH_HAS_VDSO_TIME_NS
 	default y
 	help
 	  In this namespace boottime and monotonic clocks can be set.
-- 
2.22.0

