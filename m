Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8107ED3723
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfJKBZV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:25:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45431 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJKBYS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so9918706wrm.12
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=De+pNqwE3UZqGadaVX0hm3j7kjfrKO6HV/vQkFXaIGA=;
        b=kh+MDBuR2cMEEXRCL7MtHQg0XwvwYvULoBh2CiV+BfEt1qHtE4R5PIpxV5qh50tHxI
         s8OOlOtLXj0rl1qayiYvWCTwuKLD/zMztPRr319GGqt6ieaDk+5v//5EGrQSCWprnBEw
         ry0rjX5HtK7w9AZ4hQy/LgMtAbg65ROB0r5XHnJMQNo1aYNFkPnTq9Z/GYncnCkQAbOb
         qs3sCAH+OqBWN1DykGUDP/sOMiWFO55v97uQlY4J5McOzxXIKfLN6Q6WlvXkdYa0djMG
         8oTlNGXZNxkce17+96jZs/U3ADtEkgzOJjMp8XO3gvlPiVWgLQNB6+kxvqvy7R/oUDGL
         ZoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=De+pNqwE3UZqGadaVX0hm3j7kjfrKO6HV/vQkFXaIGA=;
        b=saoXYMm8TIRPpJv464nNOmxHC/4hMs7s6hHOG7DSm6oY+Hu01zgvF7XQnGXVOJpL4z
         5Ws9ojW0nhCbyw1I3JM4nKkplrGVr87msh0qQMKkHGYhVOaY9W3+jd3ogh4x5u4TBpOP
         f1T3gxk/nLIu4IT/kxBoYayBucqDqugXsioCMMaCvT2aC/nkwbdv6l1Z4lBA+rLUnhy0
         hacFHs+Jkg60w/n7xQxBJultp7NAxterMCzTPHXBVW9gNymd4r6NeqTa/umW+yCOsKNU
         vxL8ylYBRTmUih0EfQ+A2r3k8MA0Yica2bhZPWA5AqorydaMWDXVzr/a2BtfPHrdNVjZ
         e2HA==
X-Gm-Message-State: APjAAAW4isZUwwZkcCR3D7N+hDVXuHpAXstKKHdpf+Ad7mnGg76m7C7r
        12BvOtwAU/zXw616zd+8UHiUFg==
X-Google-Smtp-Source: APXvYqxlxEsNaMCSxRwB5Q6yar5uBDDb+T8Ish9/NlyPWlHuE70pidS2qCNn8dMtibacbxXdDKuXBw==
X-Received: by 2002:adf:ec84:: with SMTP id z4mr10780854wrn.254.1570757055816;
        Thu, 10 Oct 2019 18:24:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:15 -0700 (PDT)
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
Subject: [PATCHv7 20/33] x86/vdso: Provide vdso_data offset on vvar_page
Date:   Fri, 11 Oct 2019 02:23:28 +0100
Message-Id: <20191011012341.846266-21-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
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
index e2feacf921a0..ca02d0d301cd 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -195,12 +195,10 @@ SECTIONS
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
index 9a77d3854830..772911945944 100644
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
2.23.0

