Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86AF8648
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfKLB3J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:29:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33346 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfKLB2D (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:28:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id a17so1139632wmb.0
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGFTdgqgghcbmf5KJSmfZYZjK2lWV/3Xhkbd1XIGYj0=;
        b=DWe5LJ0MCV0MBZ2eRseWaKHbkHAYqVHr3ASpvTtJTysagcufs9Lvoo8VRJM5+jINZ1
         1RZtbcHQtZ3txt+a6Z89LRd756klBbO3+6dTBd5qbs9ODjQg+i+4KTEk7/IMwsd3IMnD
         LVEYl3Rh8x7ggu4xaILh+u2gR905CcQD60/jyiLvccTwIxduUTPhmODQ5RjNa78kZhLs
         pRi1QDAbgm0kcm3YJEx/D8LjgeMqT6/djZOz/fqmfRNxqLja6+pKFSZeWRR/BSEmcjsY
         wdLXP4ZrUqT8UEILkzmCDg4JdjLczL64EWDEpT8TecFjI7agexPNXxERXCouas0fgHyy
         2NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGFTdgqgghcbmf5KJSmfZYZjK2lWV/3Xhkbd1XIGYj0=;
        b=ARiNX46nULYuk7yxZqK54XRFcpwJYc3FwEmeFJhMB7Gz3qXAoK5cwkRmWJ6aJyZGvK
         RvGkP/P+/MP9K1j7IkiJKWa9YfcroTUy7rgj+RAIyb+7Urb+/xdNg7xOtUEboW9BmDQp
         GoJyocQM7kR25Rba3AVniuOJ1IkmbVOfHlWvCkKbB0Slv5tBGN+rulYDW6k+KKDQhG75
         fD/WsgU5UuhfhYaGZZFhCDe2akOTuzZK4ejLtW48ekhEjUAKXNXBHIKzOnKNDF9WpEWQ
         QGB6kbjSGEN/RIuoCEweZKshZ7cPLIldmLflkwX83DkZRo+RGx8Y24xsfWzsNvbrB5Rk
         hEBg==
X-Gm-Message-State: APjAAAWosV00kUJnXC6WoYG9Xu/6U4PjYgH13HH8gNuNmyOkLsqbxhin
        xbzMtRH1xdiWCQatYmJ9/0B/Qw==
X-Google-Smtp-Source: APXvYqwPQSwYY5kbe2K0yP5/1/UaQt/BXvDykb1mdqra2Fm0GrhPHgCVrolUyhaZGHxhAVmYSowXqQ==
X-Received: by 2002:a05:600c:20e:: with SMTP id 14mr1434341wmi.107.1573522081287;
        Mon, 11 Nov 2019 17:28:01 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:28:00 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
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
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv8 22/34] x86/vdso: Add timens page
Date:   Tue, 12 Nov 2019 01:27:11 +0000
Message-Id: <20191112012724.250792-23-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

To support time namespaces in the VDSO with a minimal impact on regular non
time namespace affected tasks, the namespace handling needs to be hidden in
a slow path.

The most obvious place is vdso_seq_begin(). If a task belongs to a time
namespace then the VVAR page which contains the system wide VDSO data is
replaced with a namespace specific page which has the same layout as the
VVAR page. That page has vdso_data->seq set to 1 to enforce the slow path
and vdso_data->clock_mode set to VCLOCK_TIMENS to enforce the time
namespace handling path.

The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
update of the VDSO data is in progress, is not really affecting regular
tasks which are not part of a time namespace as the task is spin waiting
for the update to finish and vdso_data->seq to become even again.

If a time namespace task hits that code path, it invokes the corresponding
time getter function which retrieves the real VVAR page, reads host time
and then adds the offset for the requested clock which is stored in the
special VVAR page.

Allocate Timens page among VVAR pages and place vdso_data on it.
Provide __arch_get_timens_vdso_data() helper for VDSO code to get the
code-relative position of VVARs on that special page.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/Kconfig                         |  1 +
 arch/x86/entry/vdso/vdso-layout.lds.S    | 11 +++++++++--
 arch/x86/entry/vdso/vdso2c.c             |  3 +++
 arch/x86/include/asm/vdso.h              |  1 +
 arch/x86/include/asm/vdso/gettimeofday.h |  9 +++++++++
 arch/x86/include/asm/vvar.h              |  5 ++++-
 6 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2329f9e5b57c..58dacb97545f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -126,6 +126,7 @@ config X86
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_TIME_NS
 	select GUP_GET_PTE_LOW_HIGH		if X86_PAE
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
 	select HAVE_ACPI_APEI			if ACPI
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 2330daad67c3..ea7e0155c604 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -16,8 +16,8 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - 3 * PAGE_SIZE;
-	vvar_page = vvar_start;
+	vvar_start = . - 4 * PAGE_SIZE;
+	vvar_page  = vvar_start;
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
 #define EMIT_VVAR(name, offset) vvar_ ## name = vvar_page + offset;
@@ -26,6 +26,13 @@ SECTIONS
 
 	pvclock_page = vvar_start + PAGE_SIZE;
 	hvclock_page = vvar_start + 2 * PAGE_SIZE;
+	timens_page  = vvar_start + 3 * PAGE_SIZE;
+
+#undef _ASM_X86_VVAR_H
+	/* Place all vvars in timens too at the offsets in asm/vvar.h. */
+#define EMIT_VVAR(name, offset) timens_ ## name = timens_page + offset;
+#include <asm/vvar.h>
+#undef EMIT_VVAR
 
 	. = SIZEOF_HEADERS;
 
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 3a4d8d4d39f8..3842873b3ae3 100644
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
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 230474e2ddb5..bbcdc7b8f963 100644
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
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index e9ee139cf29e..4f938f8e756b 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -21,6 +21,7 @@
 #include <clocksource/hyperv_timer.h>
 
 #define __vdso_data (VVAR(_vdso_data))
+#define __timens_vdso_data (TIMENS(_vdso_data))
 
 #define VDSO_HAS_TIME 1
 
@@ -56,6 +57,14 @@ extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
+#ifdef CONFIG_TIME_NS
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(void)
+{
+	return __timens_vdso_data;
+}
+#endif
+
 #ifndef BUILD_VDSO32
 
 static __always_inline
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index ff2de3025388..183e98e49ab9 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -33,9 +33,12 @@ extern char __vvar_page;
 
 #define DECLARE_VVAR(offset, type, name)				\
 	extern type vvar_ ## name[CS_BASES]				\
-	__attribute__((visibility("hidden")));
+	__attribute__((visibility("hidden")));				\
+	extern type timens_ ## name[CS_BASES]				\
+	__attribute__((visibility("hidden")));				\
 
 #define VVAR(name) (vvar_ ## name)
+#define TIMENS(name) (timens_ ## name)
 
 #define DEFINE_VVAR(type, name)						\
 	type name[CS_BASES]						\
-- 
2.24.0

