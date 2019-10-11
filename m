Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA753D36F7
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfJKBYU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:24:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36279 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfJKBYT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so9966209wrd.3
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z80Wkv7hDeZaQtsThmwjgnLBl5TKdyqw3gtOu26TDPU=;
        b=S9PDlLoUEuTbf+JAC1FRVJK2a/lzy1G1g2AWK0X7aFZ7FXuHRfpWZ48q7tsyCqw6a4
         7T8yJx7Z/fj9chrIftBa6G1Tyd/K0JSdApFsgF94A8K63drSTKgqx5fV4Pqln8Rrji4o
         qdDL433EzadqDiHF79jq/saPuOMnG/2BKjRJWywgWvGym57LCsngKUhvZUIGXDvZHPm7
         71MWgrGyscnXpXi+Yh9oEzPdQxqKNTgd3SewHym6wDLlKp6+fpNh8csw7bzQMTqe7SBq
         yzieZ++bqjrleRAPwiF4mMsjg7CA1dtTTFbuvyzxNAxXCR47DauGo4RqG73CEUs2B4G9
         WUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z80Wkv7hDeZaQtsThmwjgnLBl5TKdyqw3gtOu26TDPU=;
        b=RDEW7Q+CmxEaiX90H+W+MVSnroNvMIuuHrwpmpfLL2kyJQdGcCeUqe2+aLuOm818ll
         VZ+yk4rMWtIilXpwjmNsbkmzmuVmi2/DseOMA2BmFriwU+ws2nMcgmMdrxWNcDGsh6rq
         wt8o15xX6+SPyj98015wJL+uY2ldvXZmYgKfShLzUAaUbqjBMMpeu4ewwUIM7xlc348H
         PDqrgR1Y1jIaxmTKs+dEOEYRo2u+YH6Sblr0mwIsmTiNW/KzJ4yNT7bWnSuqvUyVSR1d
         1njpLXvjb/vBCrMzGVLpnH9DqTI9V2QgqIeMaMRwtWdD10p9DKofnzIqWr9cvX9IiVTk
         Hn1w==
X-Gm-Message-State: APjAAAW7usMSGulInnF7jJ8i5H4A/w9Ew2w+370ML5NMfRzyiKfrt4b3
        mZpoi+PrF8TZfgr8Ix6oDm4L9A==
X-Google-Smtp-Source: APXvYqzNY4wzWTtAh17rW7vc590vD8YLN/GsEofDTRRhUBA6BBnJx58A27oe2UlcdVyo96o6+uNA6w==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr10341944wrt.36.1570757057403;
        Thu, 10 Oct 2019 18:24:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:16 -0700 (PDT)
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
Subject: [PATCHv7 21/33] x86/vdso: Add timens page
Date:   Fri, 11 Oct 2019 02:23:29 +0100
Message-Id: <20191011012341.846266-22-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
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
index d6e1faa28c58..15f076eb2b1c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -226,6 +226,7 @@ config X86
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
+	select VDSO_TIMENS			if TIME_NS
 
 config INSTRUCTION_DECODER
 	def_bool y
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
index e9ee139cf29e..39a551df4fea 100644
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
 
+#ifdef CONFIG_VDSO_TIMENS
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
2.23.0

