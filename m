Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0A7D0F5
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfGaWTN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:19:13 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50417 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731289AbfGaWRF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:17:05 -0400
Received: by mail-pf1-f201.google.com with SMTP id h27so44141061pfq.17
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=klghF8F9jCh3lGq1PlqD6+/L30+aHC8n0RDXrpkxL3I=;
        b=g+gTa4LqQH20zCJciwnO6YvWGBXEyfQjUBh3mqCVmw1D2WwnyD7eDIi1PTLDUahdRS
         Sx7iq/LZKSbS9dJ5AGYtxi6didXdD1VqvqzMT01foMBaxKkBcqQ6+jzwprZzErkXWRS1
         3msMg+zlu8cnKO2j0mCX1FzYi5O/lBlFW9/ld0+ZAzJ7Kb/rthD++w2R8wuy5/PKcmOi
         kT45zAK03gPDl4Ir2fxNNFowqMkKPf9F3nWOgVmXS12tNwHpicptJZTdZI+4Ol7OJVbB
         Btmm2ih+cO2vy83JVfQqPrpzBKTCis6Bw0V+esANuhr9WaB2xzyxGau6Ug+osZLKHSUx
         3/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=klghF8F9jCh3lGq1PlqD6+/L30+aHC8n0RDXrpkxL3I=;
        b=iBif+uUALZpC6fvt6r1AmLfMdJJLw8uEs3qn72tAvON4jM2O+Qwxl97qzoHXdAzf7J
         3dDE9336cYhq1y0tw2cXzn79ojVDyPjF7tDpy2YwV7Wu0RtwasWQwxg2cGpsd5YXk8Cf
         GMA2DXLLodpkoVJ/+PxU+h1O4bkQucnuUF7j3WgPB1hbS09c3p/8x/7kvticjw7zNUK+
         gBWNSu9iJ61I8Hwh2kDWLIa8Rg/AElU+QVWJgOumFrUslw7sqDB7UDXHA7kT5VPo86p8
         DNBOJ5gKq+42+pM3a51yybpt+a7IdaODtz8p7/lgYunytn2iJeM8wI6l/8fYeDKB7IiU
         5XXA==
X-Gm-Message-State: APjAAAUQmg5fmDqYYHoTImmsd7mw+hJsdIgeljqnNsErCH/auTqK8Jr7
        dMyq6OpQJ3zA1y9L9Vb57vIe+XWCCZALarA2j3mVuA==
X-Google-Smtp-Source: APXvYqwzPMtpkPbGUc3NZc/t84m5E7WL6Vl9kAHyPM7B+anR7yHljemMiz+5eHdeRSf8CpDeFvAuKhmN+Lgp6mUjCukA+w==
X-Received: by 2002:a63:1e05:: with SMTP id e5mr259333pge.153.1564611424198;
 Wed, 31 Jul 2019 15:17:04 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:03 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 15/29] acpi: Ignore acpi_rsdp kernel param when the kernel
 has been locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware. Reject
the option when the kernel is locked down. This requires some reworking
of the existing RSDP command line logic, since the early boot code also
makes use of a command-line passed RSDP when locating the SRAT table
before the lockdown code has been initialised. This is achieved by
separating the command line RSDP path in the early boot code from the
generic RSDP path, and then copying the command line RSDP into boot
params in the kernel proper if lockdown is not enabled. If lockdown is
enabled and an RSDP is provided on the command line, this will only be
used when parsing SRAT (which shouldn't permit kernel code execution)
and will be ignored in the rest of the kernel.

(Modified by Matthew Garrett in order to handle the early boot RSDP
environment)

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
---
 arch/x86/boot/compressed/acpi.c | 19 +++++++++++++------
 arch/x86/include/asm/acpi.h     |  9 +++++++++
 arch/x86/include/asm/x86_init.h |  2 ++
 arch/x86/kernel/acpi/boot.c     |  5 +++++
 arch/x86/kernel/x86_init.c      |  1 +
 drivers/acpi/osl.c              | 14 +++++++++++++-
 include/linux/acpi.h            |  6 ++++++
 7 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 15255f388a85..149795c369f2 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -26,7 +26,7 @@ struct mem_vector immovable_mem[MAX_NUMNODES*2];
  */
 #define MAX_ADDR_LEN 19
 
-static acpi_physical_address get_acpi_rsdp(void)
+static acpi_physical_address get_cmdline_acpi_rsdp(void)
 {
 	acpi_physical_address addr = 0;
 
@@ -278,10 +278,7 @@ acpi_physical_address get_rsdp_addr(void)
 {
 	acpi_physical_address pa;
 
-	pa = get_acpi_rsdp();
-
-	if (!pa)
-		pa = boot_params->acpi_rsdp_addr;
+	pa = boot_params->acpi_rsdp_addr;
 
 	/*
 	 * Try to get EFI data from setup_data. This can happen when we're a
@@ -311,7 +308,17 @@ static unsigned long get_acpi_srat_table(void)
 	char arg[10];
 	u8 *entry;
 
-	rsdp = (struct acpi_table_rsdp *)(long)boot_params->acpi_rsdp_addr;
+	/*
+	 * Check whether we were given an RSDP on the command line. We don't
+	 * stash this in boot params because the kernel itself may have
+	 * different ideas about whether to trust a command-line parameter.
+	 */
+	rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
+
+	if (!rsdp)
+		rsdp = (struct acpi_table_rsdp *)(long)
+			boot_params->acpi_rsdp_addr;
+
 	if (!rsdp)
 		return 0;
 
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index aac686e1e005..bc9693c9107e 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -117,6 +117,12 @@ static inline bool acpi_has_cpu_in_madt(void)
 	return !!acpi_lapic;
 }
 
+#define ACPI_HAVE_ARCH_SET_ROOT_POINTER
+static inline void acpi_arch_set_root_pointer(u64 addr)
+{
+	x86_init.acpi.set_root_pointer(addr);
+}
+
 #define ACPI_HAVE_ARCH_GET_ROOT_POINTER
 static inline u64 acpi_arch_get_root_pointer(void)
 {
@@ -125,6 +131,7 @@ static inline u64 acpi_arch_get_root_pointer(void)
 
 void acpi_generic_reduced_hw_init(void);
 
+void x86_default_set_root_pointer(u64 addr);
 u64 x86_default_get_root_pointer(void);
 
 #else /* !CONFIG_ACPI */
@@ -138,6 +145,8 @@ static inline void disable_acpi(void) { }
 
 static inline void acpi_generic_reduced_hw_init(void) { }
 
+static inline void x86_default_set_root_pointer(u64 addr) { }
+
 static inline u64 x86_default_get_root_pointer(void)
 {
 	return 0;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index ac0934189017..19435858df5f 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -134,10 +134,12 @@ struct x86_hyper_init {
 
 /**
  * struct x86_init_acpi - x86 ACPI init functions
+ * @set_root_poitner:		set RSDP address
  * @get_root_pointer:		get RSDP address
  * @reduced_hw_early_init:	hardware reduced platform early init
  */
 struct x86_init_acpi {
+	void (*set_root_pointer)(u64 addr);
 	u64 (*get_root_pointer)(void);
 	void (*reduced_hw_early_init)(void);
 };
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 17b33ef604f3..04205ce127a1 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1760,6 +1760,11 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	e820__update_table_print();
 }
 
+void x86_default_set_root_pointer(u64 addr)
+{
+	boot_params.acpi_rsdp_addr = addr;
+}
+
 u64 x86_default_get_root_pointer(void)
 {
 	return boot_params.acpi_rsdp_addr;
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 1bef687faf22..18a799c8fa28 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -95,6 +95,7 @@ struct x86_init_ops x86_init __initdata = {
 	},
 
 	.acpi = {
+		.set_root_pointer	= x86_default_set_root_pointer,
 		.get_root_pointer	= x86_default_get_root_pointer,
 		.reduced_hw_early_init	= acpi_generic_reduced_hw_init,
 	},
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 9c0edf2fc0dd..d43df3a3fa8d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/jiffies.h>
 #include <linux/semaphore.h>
+#include <linux/security.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -180,8 +181,19 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	/*
+	 * We may have been provided with an RSDP on the command line,
+	 * but if a malicious user has done so they may be pointing us
+	 * at modified ACPI tables that could alter kernel behaviour -
+	 * so, we check the lockdown status before making use of
+	 * it. If we trust it then also stash it in an architecture
+	 * specific location (if appropriate) so it can be carried
+	 * over further kexec()s.
+	 */
+	if (acpi_rsdp && !security_locked_down(LOCKDOWN_ACPI_TABLES)) {
+		acpi_arch_set_root_pointer(acpi_rsdp);
 		return acpi_rsdp;
+	}
 #endif
 	pa = acpi_arch_get_root_pointer();
 	if (pa)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e40e1e27ed8e..6b35f2f4cab3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -643,6 +643,12 @@ bool acpi_gtdt_c3stop(int type);
 int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count);
 #endif
 
+#ifndef ACPI_HAVE_ARCH_SET_ROOT_POINTER
+static inline void acpi_arch_set_root_pointer(u64 addr)
+{
+}
+#endif
+
 #ifndef ACPI_HAVE_ARCH_GET_ROOT_POINTER
 static inline u64 acpi_arch_get_root_pointer(void)
 {
-- 
2.22.0.770.g0f2c4a37fd-goog

