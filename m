Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF0409DB1
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 22:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347833AbhIMUFv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 16:05:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:38692 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347783AbhIMUFr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 13 Sep 2021 16:05:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307336361"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307336361"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643909"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:30 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 03/13] x86/cpu: Enumerate User Interrupts support
Date:   Mon, 13 Sep 2021 13:01:22 -0700
Message-Id: <20210913200132.3396598-4-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

User Interrupts support including user IPIs is enumerated through cpuid.
The 'uintr' flag in /proc/cpuinfo can be used to identify it. The
recommended mechanism for user applications to detect support is calling
the uintr related syscalls.

Use CONFIG_X86_USER_INTERRUPTS to compile with User Interrupts support.
The feature can be disabled at boot time using the 'nouintr' kernel
parameter.

SENDUIPI is a special ring-3 instruction that makes a supervisor mode
memory access to the UPID and UITT memory. Currently, KPTI needs to be
off for User IPIs to work.  Processors that support user interrupts are
not affected by Meltdown so the auto mode of KPTI will default to off.

Users who want to force enable KPTI will need to wait for a later
version of this patch series that is compatible with KPTI. We need to
allocate the UPID and UITT structures from a special memory region that
has supervisor access but it is mapped into userspace. The plan is to
implement a mechanism similar to LDT.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 +
 arch/x86/Kconfig                              | 12 ++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/disabled-features.h      |  8 ++-
 arch/x86/include/asm/msr-index.h              |  8 +++
 arch/x86/include/uapi/asm/processor-flags.h   |  2 +
 arch/x86/kernel/cpu/common.c                  | 55 +++++++++++++++++++
 arch/x86/kernel/cpu/cpuid-deps.c              |  1 +
 8 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..471e82be87ff 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3288,6 +3288,8 @@
 
 	nofsgsbase	[X86] Disables FSGSBASE instructions.
 
+	nouintr		[X86-64] Disables User Interrupts support.
+
 	no_console_suspend
 			[HW] Never suspend the console
 			Disable suspending of consoles during suspend and
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4e001bbbb425..6f7f31e92f3e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1845,6 +1845,18 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 	  If unsure, say y.
 
+config X86_USER_INTERRUPTS
+	bool "User Interrupts (UINTR)"
+	depends on X86_LOCAL_APIC && X86_64
+	depends on CPU_SUP_INTEL
+	help
+	  User Interrupts are events that can be delivered directly to
+	  userspace without a transition through the kernel. The interrupts
+	  could be generated by another userspace application, kernel or a
+	  device.
+
+	  Refer, Documentation/x86/user-interrupts.rst for details.
+
 choice
 	prompt "TSX enable mode"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d0ce5cfd3ac1..634e80ee5db5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -375,6 +375,7 @@
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
 #define X86_FEATURE_FSRM		(18*32+ 4) /* Fast Short Rep Mov */
+#define X86_FEATURE_UINTR		(18*32+ 5) /* User Interrupts support */
 #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
 #define X86_FEATURE_SRBDS_CTRL		(18*32+ 9) /* "" SRBDS mitigation MSR available */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 8f28fafa98b3..27fb1c70ade6 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -65,6 +65,12 @@
 # define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
 #endif
 
+#ifdef CONFIG_X86_USER_INTERRUPTS
+# define DISABLE_UINTR		0
+#else
+# define DISABLE_UINTR		(1 << (X86_FEATURE_UINTR & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -87,7 +93,7 @@
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
 			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
-#define DISABLED_MASK18	0
+#define DISABLED_MASK18	(DISABLE_UINTR)
 #define DISABLED_MASK19	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a7c413432b33..4fdba281d002 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -375,6 +375,14 @@
 #define MSR_HWP_REQUEST 		0x00000774
 #define MSR_HWP_STATUS			0x00000777
 
+/* User Interrupt interface */
+#define MSR_IA32_UINTR_RR		0x985
+#define MSR_IA32_UINTR_HANDLER		0x986
+#define MSR_IA32_UINTR_STACKADJUST	0x987
+#define MSR_IA32_UINTR_MISC		0x988	/* 39:32-UINV, 31:0-UITTSZ */
+#define MSR_IA32_UINTR_PD		0x989
+#define MSR_IA32_UINTR_TT		0x98a
+
 /* CPUID.6.EAX */
 #define HWP_BASE_BIT			(1<<7)
 #define HWP_NOTIFICATIONS_BIT		(1<<8)
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index bcba3c643e63..919ce7f456d4 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -130,6 +130,8 @@
 #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
 #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
+#define X86_CR4_UINTR_BIT	25 /* enable User Interrupts support */
+#define X86_CR4_UINTR		_BITUL(X86_CR4_UINTR_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f8885949e8c..55fee930b6d1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -308,6 +308,58 @@ static __always_inline void setup_smep(struct cpuinfo_x86 *c)
 		cr4_set_bits(X86_CR4_SMEP);
 }
 
+static __init int setup_disable_uintr(char *arg)
+{
+	/* No additional arguments expected */
+	if (strlen(arg))
+		return 0;
+
+	/* Do not emit a message if the feature is not present. */
+	if (!boot_cpu_has(X86_FEATURE_UINTR))
+		return 1;
+
+	setup_clear_cpu_cap(X86_FEATURE_UINTR);
+	pr_info_once("x86: 'nouintr' specified, User Interrupts support disabled\n");
+	return 1;
+}
+__setup("nouintr", setup_disable_uintr);
+
+static __always_inline void setup_uintr(struct cpuinfo_x86 *c)
+{
+	/* check the boot processor, plus compile options for UINTR. */
+	if (!cpu_feature_enabled(X86_FEATURE_UINTR))
+		goto disable_uintr;
+
+	/* checks the current processor's cpuid bits: */
+	if (!cpu_has(c, X86_FEATURE_UINTR))
+		goto disable_uintr;
+
+	/*
+	 * User Interrupts currently doesn't support PTI. For processors that
+	 * support User interrupts PTI in auto mode will default to off.  Need
+	 * this check only for users who have force enabled PTI.
+	 */
+	if (boot_cpu_has(X86_FEATURE_PTI)) {
+		pr_info_once("x86: User Interrupts (UINTR) not enabled. Please disable PTI using 'nopti' kernel parameter\n");
+		goto clear_uintr_cap;
+	}
+
+	cr4_set_bits(X86_CR4_UINTR);
+	pr_info_once("x86: User Interrupts (UINTR) enabled\n");
+
+	return;
+
+clear_uintr_cap:
+	setup_clear_cpu_cap(X86_FEATURE_UINTR);
+
+disable_uintr:
+	/*
+	 * Make sure UINTR is disabled in case it was enabled in a
+	 * previous boot (e.g., via kexec).
+	 */
+	cr4_clear_bits(X86_CR4_UINTR);
+}
+
 static __init int setup_disable_smap(char *arg)
 {
 	setup_clear_cpu_cap(X86_FEATURE_SMAP);
@@ -1564,6 +1616,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_smap(c);
 	setup_umip(c);
 
+	/* Set up User Interrupts */
+	setup_uintr(c);
+
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
 		cr4_set_bits(X86_CR4_FSGSBASE);
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index defda61f372d..6f7eb4af5b4a 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -75,6 +75,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
+	{ X86_FEATURE_UINTR,			X86_FEATURE_XSAVES    },
 	{}
 };
 
-- 
2.33.0

