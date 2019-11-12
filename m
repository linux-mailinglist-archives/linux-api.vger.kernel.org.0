Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B34F861E
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKLB2D (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:28:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55459 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfKLB2C (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:28:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so1278809wmb.5
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uz85eFOmw9eLe/gvfSQH1CU3diio5dCJ/bAD2qd/VU8=;
        b=gpKRrTBpgN66zUcyxXmMiN9olyPrBDZriHy6MODURyKZt2CiBfI3Webvcs+Rocy1uY
         0H8i6IXgHpG40TARF+zrmgkcwXZjG5n6tJQFfR6BFndo2T3GrkhJsQaoUYe+GR/BKymf
         W6kv3+VHoyo8lkX9eFpcqjHzimTnUAAJBHiJLQzXCXDjxCF3tRFMkb2wHDiBQPpGdgAp
         m85mxMcIPx5mizSRZcmy3FKshd3ycQl5hxGQXKRBZBn/mTp4XcuNNmwjt9V+LjfyAQgL
         jqIZ4DjGkqUbrbNJ7t66G1UAbhYQ2Pd0+SO25dpoEbj+sLFCiiWGNkUtWAIl8OiHd0Pm
         StcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uz85eFOmw9eLe/gvfSQH1CU3diio5dCJ/bAD2qd/VU8=;
        b=niqKPiXSPZ/IQC/eJEntSjhlqlMewS+YbsuCxgX1dPyBBcTJxS+wXCs7wyilmMI1rW
         erCZcnhc4pHxZpaqgdlybHsCQA6r1AkPsoIsrw24yhtdzZpUuYZ0JXUfR6LEjssjf+um
         dM1Jpv7REqm4TwG3L9cF71erwEKfuDLJosSt9U4Jo0D9PKroFCyfVBDoU83X2ViVJOi1
         BanD28mLyYvsPuQ8HkWwq688U+hw28hBIXSgYfALoPSc9gHQqeMKxRP5s96oe5bzm8nw
         BPVrYJJ0sEYdARDUupfJ18PNHGWCd0qQHXl9XW70vWAMdTTsZ0oJ17IrILmFvWtWNYM1
         Q78g==
X-Gm-Message-State: APjAAAXXOSB23HgN/rl9Np0gWuUoEx81YQmJfbpUShjVF0rOVOGQO3Vz
        +ai8KWQ9Mul6F2IuJFoMTRKMKA==
X-Google-Smtp-Source: APXvYqyKBWNMmVaj5SuoqSYxX5UN3z/BGtBiK0BH5DbbJTqYAWgt0WrrLNo77oGEluBiZj/uKHhbIQ==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr1483434wmc.157.1573522080001;
        Mon, 11 Nov 2019 17:28:00 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:59 -0800 (PST)
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
Subject: [PATCHv8 21/34] x86/vdso: Provide vdso_data offset on vvar_page
Date:   Tue, 12 Nov 2019 01:27:10 +0000
Message-Id: <20191112012724.250792-22-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

VDSO support for Time namespace needs to set up a page with the same
layout as VVAR. That timens page will be placed on position of VVAR page
inside namespace. That page has vdso_data->seq set to 1 to enforce
the slow path and vdso_data->clock_mode set to VCLOCK_TIMENS to enforce
the time namespace handling path.

To prepare timens page kernel needs to know the vdso_data offset.
Provide arch_get_vdso_data() helper for locating vdso_data on VVAR page.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso-layout.lds.S |  2 --
 arch/x86/entry/vdso/vma.c             | 11 +++++++++++
 arch/x86/include/asm/vvar.h           |  8 ++++----
 arch/x86/kernel/vmlinux.lds.S         |  4 +---
 include/linux/time_namespace.h        |  1 +
 5 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 93c6dc7812d0..2330daad67c3 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -21,9 +21,7 @@ SECTIONS
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
 #define EMIT_VVAR(name, offset) vvar_ ## name = vvar_page + offset;
-#define __VVAR_KERNEL_LDS
 #include <asm/vvar.h>
-#undef __VVAR_KERNEL_LDS
 #undef EMIT_VVAR
 
 	pvclock_page = vvar_start + PAGE_SIZE;
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 000db8282cc8..5dab706aca2e 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -24,6 +24,17 @@
 #include <asm/cpufeature.h>
 #include <clocksource/hyperv_timer.h>
 
+#undef _ASM_X86_VVAR_H
+#define EMIT_VVAR(name, offset)	\
+	const size_t name ## _offset = offset;
+#include <asm/vvar.h>
+
+struct vdso_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_data *)(vvar_page + _vdso_data_offset);
+}
+#undef EMIT_VVAR
+
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 32f5d9a0b90e..ff2de3025388 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -19,10 +19,10 @@
 #ifndef _ASM_X86_VVAR_H
 #define _ASM_X86_VVAR_H
 
-#if defined(__VVAR_KERNEL_LDS)
-
-/* The kernel linker script defines its own magic to put vvars in the
- * right place.
+#ifdef EMIT_VVAR
+/*
+ * EMIT_VVAR() is used by the kernel linker script to put vvars in the
+ * right place. Also, it's used by kernel code to import offsets values.
  */
 #define DECLARE_VVAR(offset, type, name) \
 	EMIT_VVAR(name, offset)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3a1a819da137..e3296aa028fe 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -193,12 +193,10 @@ SECTIONS
 		__vvar_beginning_hack = .;
 
 		/* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) 			\
+#define EMIT_VVAR(name, offset)				\
 		. = __vvar_beginning_hack + offset;	\
 		*(.vvar_ ## name)
-#define __VVAR_KERNEL_LDS
 #include <asm/vvar.h>
-#undef __VVAR_KERNEL_LDS
 #undef EMIT_VVAR
 
 		/*
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index a68b1ab7b5bb..90e82654b4ce 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -37,6 +37,7 @@ extern struct time_namespace *copy_time_ns(unsigned long flags,
 	struct user_namespace *user_ns, struct time_namespace *old_ns);
 extern void free_time_ns(struct kref *kref);
 extern int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
+extern struct vdso_data *arch_get_vdso_data(void *vvar_page);
 
 static inline void put_time_ns(struct time_namespace *ns)
 {
-- 
2.24.0

