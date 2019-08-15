Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E998F0F7
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbfHOQkW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:40:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35356 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732392AbfHOQjM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so1782027wmg.0
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vw8cWiq6O1PHMmBE5XFOVjM7O/opuNPGefHBQdaqx8M=;
        b=ex/8t2l825iu59GPaO0VO0g4+FpgUIqct4Xyl1daOSi9hZwirl26gkMRWeZBy9+vXo
         NmWVOLAAtKFNTWQtwU/hbSf3OPmyepWG4uF/3ggp4HA3IcuIfRIX0AsCTxvEHqESW1FD
         vXpLs4oE/a3g/1fEbdmUviAdsMNhaf4RvMaj6oQ/GIJ5JuxCF4PMp7BaXMSF7T3Hz7iA
         wCZ0Gf50m5K9EL9VKdyUwrnkMelI5U/Alyr1pE2QFZSPCGX+nxfQI1DxHndn90HXhrHu
         ciBms8zQWl+fX24+X6qPXXBfr5BR+x0ULyPfojhejE+q/614r55aIvH7KXzPWJNF2hRe
         4Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vw8cWiq6O1PHMmBE5XFOVjM7O/opuNPGefHBQdaqx8M=;
        b=YNbIsEXl2FYlUtmCOrD7riLI8csY2kjT5LaEvPO32lvjfHKTiRjKN/3dFEmn6QL62V
         TtqQGnbhj351Tl2QJhVpfTqWxVJvg2bQuMpVzmZhpIrp70gBSoFhZUWPRWFQklyDZHbf
         CjpxlZRcgS/MtlE8ofyxwBvMEgj3gWjsxD+cv4ZmXaVNMxMn3p/PaaEORC+9n8N7dQW8
         bTehrZjOUJWYisSHuQ4Dbn2wVyxh8QQhkpMT6rYMy2EmaTrJYqZMr5py04Xj95t1NCYR
         FHTj1ZbQBBTA/6MWVbdUB/GSTmVun1xSrlGXZK3ZTkyxKpWRHdThjdJhBo/0pTE62d6k
         YJkA==
X-Gm-Message-State: APjAAAVDAWsLIBoZo/Lbk/SYDAlNScD7RHtQVsEJEkUt5ciTVZOvSdb0
        W5kcPrS1YFNT0o4ME3s1nMaZQg==
X-Google-Smtp-Source: APXvYqw2tARBt5p9ezGF4CjhRdNxxy18LoOikBXK3bkk4Cz4oNgOT7JEBR18qHZxZJQeiE7Fg6f3iQ==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr3529661wmg.155.1565887149671;
        Thu, 15 Aug 2019 09:39:09 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:09 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
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
Subject: [PATCHv6 22/36] x86/vdso: Add offsets page in vvar
Date:   Thu, 15 Aug 2019 17:38:22 +0100
Message-Id: <20190815163836.2927-23-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
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
 arch/Kconfig                          |  5 +++
 arch/x86/Kconfig                      |  1 +
 arch/x86/entry/vdso/vdso-layout.lds.S |  9 ++++-
 arch/x86/entry/vdso/vdso2c.c          |  3 ++
 arch/x86/entry/vdso/vma.c             | 12 +++++++
 arch/x86/include/asm/vdso.h           |  1 +
 init/Kconfig                          |  1 +
 lib/vdso/gettimeofday.c               | 47 +++++++++++++++++++++++++++
 8 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 719b27275f86..5ddb92e6bfe0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -740,6 +740,11 @@ config HAVE_ARCH_NVRAM_OPS
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
index d685677d90f0..7ab810bc965d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -81,6 +81,7 @@ config X86
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VDSO_TIME_NS
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
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
index 2dc4f0b5481c..9bd66f84db5e 100644
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
 #include <clocksource/hyperv_timer.h>
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
index 525dc3ed86c4..7adf939eeaa8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1074,6 +1074,7 @@ config UTS_NS
 
 config TIME_NS
 	bool "TIME namespace"
+	depends on ARCH_HAS_VDSO_TIME_NS
 	default y
 	help
 	  In this namespace boottime and monotonic clocks can be set.
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index e630e7ff57f1..8589c66ff3e7 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -7,6 +7,7 @@
 #include <linux/time.h>
 #include <linux/kernel.h>
 #include <linux/hrtimer_defs.h>
+#include <linux/timens_offsets.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
@@ -38,6 +39,48 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 }
 #endif
 
+#ifdef CONFIG_TIME_NS
+extern u8 timens_page
+	__attribute__((visibility("hidden")));
+
+notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_timespec *ts)
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
+		break;
+	default:
+		return;
+	}
+
+	/*
+	 * The kernel allows to set a negative offset only if the current clock
+	 * value in a namespace is positive, so the result tv_sec can't be
+	 * negative here.
+	 */
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
+notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_timespec *ts) {}
+#endif
+
 static int do_hres(const struct vdso_data *vd, clockid_t clk,
 		   struct __kernel_timespec *ts)
 {
@@ -65,6 +108,8 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
+	clk_to_ns(clk, ts);
+
 	return 0;
 }
 
@@ -79,6 +124,8 @@ static void do_coarse(const struct vdso_data *vd, clockid_t clk,
 		ts->tv_sec = vdso_ts->sec;
 		ts->tv_nsec = vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	clk_to_ns(clk, ts);
 }
 
 static __maybe_unused int
-- 
2.22.0

