Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA33C1A12
	for <lists+linux-api@lfdr.de>; Thu,  8 Jul 2021 21:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhGHTta (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Jul 2021 15:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGHTta (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Jul 2021 15:49:30 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16C4C061764
        for <linux-api@vger.kernel.org>; Thu,  8 Jul 2021 12:46:46 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u14so7392553pga.11
        for <linux-api@vger.kernel.org>; Thu, 08 Jul 2021 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vqt7xpIH7a/xgTEcLAz8+GIKMkG1FUNZJBUCT7nGtY=;
        b=Vr8eXf1SJ75DairU2xUWHxJ+Xjp74ldga2tClDl1ZqxtKO5X0NHtCSCBgNG6adUjtJ
         XW3qvOtf7x3gVuwPLCdZwxH3mehqniFBqlNDN3RgylLO2Gtq8rvZyThhX/hn8Z/oSlJQ
         nOZQBm5G6XTyQE4NZN2MeOIb+LF4qz00+D7VrzbeJ8vH4f+FNq8ufGJZykHlk2gjXC/F
         Y+sR4N7tOnxDiirhdlpmIulN5irXb8IXExpqV6mrQSDCkSd3qTbrhXNdnXY8fP8Bi/1U
         iJVrZT9ZRduY10SRPo7mulYGBFXHSq5IykWzGuneIoR70LjAN1oIGGZ/bOsjn4kqfqSd
         yOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vqt7xpIH7a/xgTEcLAz8+GIKMkG1FUNZJBUCT7nGtY=;
        b=fcZjwVq8/TZGaRjQCyT8Wu0ZVnlYoXVZADSRI3bSUvvOX6YkERcwmjnHVi+mqEqZ+i
         2YWTSxO410/F+ITKPBWNKlMGskQ8O6ppGeCEtVSy+BN6XdQXkyKKuLbmL7Z77iGflgBB
         vs/y70BE6mI3it7IWw7Omql++lj2WQp4jSPWKXZNpw9OowN+1xCBL046RCGY1rFiym0X
         5UhlhqTNJD8XXo7vTMz6AgvInm/KQBUPkgghv7noW5BxMChrVoGzSjVYAvWC2pt9AhwW
         NeXj0VVV2iBvSILcEwigdt7Q2+Yvsn0BGvBjGSNi4kmc4ODtqNcWy9EaS2eN8upLsSj2
         6qPA==
X-Gm-Message-State: AOAM531fvzXwazZj+vydFIUFVLOuZnvWjakvtV2bqJubQJ6xIwdTzXTu
        3/+qe0C8IgMfPxgd4SltytxVUw==
X-Google-Smtp-Source: ABdhPJxuaEdU7+3812uyhUckuVaw/+KYl+877uUKtbONQaUxcrUxfYY/etK8JPoZOrR3jBWoWOIkNQ==
X-Received: by 2002:a63:471b:: with SMTP id u27mr34286700pga.301.1625773606236;
        Thu, 08 Jul 2021 12:46:46 -0700 (PDT)
Received: from localhost.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id v1sm3283176pjg.19.2021.07.08.12.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:46:45 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>
Subject: [RFC PATCH 2/3 v0.2] sched/umcg: RFC: add userspace atomic helpers
Date:   Thu,  8 Jul 2021 12:46:37 -0700
Message-Id: <20210708194638.128950-3-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708194638.128950-1-posk@google.com>
References: <20210708194638.128950-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add helper functions to work atomically with userspace 32/64 bit values -
there are some .*futex.* named helpers, but they are not exactly
what is needed for UMCG; I haven't found what else I could use, so I
rolled these.

At the moment only X86_64 is supported.

Note: the helpers should probably go into arch/ somewhere; I have
them in kernel/sched/umcg.h temporarily for convenience. Please
let me know where I should put them and how to name them.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 kernel/sched/umcg.h | 264 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 264 insertions(+)
 create mode 100644 kernel/sched/umcg.h

diff --git a/kernel/sched/umcg.h b/kernel/sched/umcg.h
new file mode 100644
index 000000000000..aa8fb24964ed
--- /dev/null
+++ b/kernel/sched/umcg.h
@@ -0,0 +1,264 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _KERNEL_SCHED_UMCG_H
+#define _KERNEL_SCHED_UMCG_H
+
+#ifdef CONFIG_UMCG
+#ifdef CONFIG_X86_64
+
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <linux/umcg.h>
+
+#include <asm/asm.h>
+#include <linux/atomic.h>
+
+/* TODO: move atomic operations below into arch/ headers */
+static inline int umcg_atomic_cmpxchg_32(u32 *uval, u32 __user *uaddr,
+						u32 oldval, u32 newval)
+{
+	int ret = 0;
+
+	if (!user_access_begin(uaddr, sizeof(u32)))
+		return -EFAULT;
+	asm volatile("\n"
+		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
+		"2:\n"
+		"\t.section .fixup, \"ax\"\n"
+		"3:\tmov     %3, %0\n"
+		"\tjmp     2b\n"
+		"\t.previous\n"
+		_ASM_EXTABLE_UA(1b, 3b)
+		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
+		: "i" (-EFAULT), "r" (newval), "1" (oldval)
+		: "memory"
+	);
+	user_access_end();
+	*uval = oldval;
+	return ret;
+}
+
+static inline int umcg_atomic_cmpxchg_64(u64 *uval, u64 __user *uaddr,
+						u64 oldval, u64 newval)
+{
+	int ret = 0;
+
+	if (!user_access_begin(uaddr, sizeof(u64)))
+		return -EFAULT;
+	asm volatile("\n"
+		"1:\t" LOCK_PREFIX "cmpxchgq %4, %2\n"
+		"2:\n"
+		"\t.section .fixup, \"ax\"\n"
+		"3:\tmov     %3, %0\n"
+		"\tjmp     2b\n"
+		"\t.previous\n"
+		_ASM_EXTABLE_UA(1b, 3b)
+		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
+		: "i" (-EFAULT), "r" (newval), "1" (oldval)
+		: "memory"
+	);
+	user_access_end();
+	*uval = oldval;
+	return ret;
+}
+
+static inline int fix_pagefault(unsigned long uaddr, bool write_fault)
+{
+	struct mm_struct *mm = current->mm;
+	int ret;
+
+	mmap_read_lock(mm);
+	ret = fixup_user_fault(mm, uaddr, write_fault ? FAULT_FLAG_WRITE : 0,
+			NULL);
+	mmap_read_unlock(mm);
+
+	return ret < 0 ? ret : 0;
+}
+
+static inline int umcg_get_user_32(u32 __user *uaddr, u32 *val)
+{
+	while (true) {
+		int ret;
+		u32 out;
+
+		pagefault_disable();
+		ret = __get_user(out, uaddr);
+		pagefault_enable();
+
+		if (!ret) {
+			*val = out;
+			return 0;
+		}
+
+		if (WARN_ONCE(ret != -EFAULT, "Unexpected error"))
+			return -EFAULT;
+
+		ret = fix_pagefault((unsigned long)uaddr, false);
+		if (ret)
+			return -EFAULT;
+	}
+}
+
+/**
+ * umcg_cmpxchg_32_user - compare_exchange 32-bit values
+ *
+ * Return:
+ * 0 - OK
+ * -EFAULT: memory access error
+ * -EAGAIN: @expected did not match; consult @prev
+ */
+static inline int umcg_cmpxchg_32_user(u32 __user *uaddr, u32 *prev, u32 val)
+{
+	while (true) {
+		int ret;
+		u32 expected = *prev;
+
+		pagefault_disable();
+		ret = umcg_atomic_cmpxchg_32(prev, uaddr, expected, val);
+		pagefault_enable();
+
+		if (!ret)
+			return *prev == expected ? 0 : -EAGAIN;
+
+		if (WARN_ONCE(ret != -EFAULT, "Unexpected error"))
+			return -EFAULT;
+
+		ret = fix_pagefault((unsigned long)uaddr, true);
+		if (ret)
+			return -EFAULT;
+	}
+}
+
+/**
+ * umcg_cmpxchg_64_user - compare_exchange 64-bit values
+ *
+ * Return:
+ * 0 - OK
+ * -EFAULT: memory access error
+ * -EAGAIN: @expected did not match; consult @prev
+ */
+static inline int umcg_cmpxchg_64_user(u64 __user *uaddr, u64 *prev, u64 val)
+{
+	while (true) {
+		int ret;
+		u64 expected = *prev;
+
+		pagefault_disable();
+		ret = umcg_atomic_cmpxchg_64(prev, uaddr, expected, val);
+		pagefault_enable();
+
+		if (!ret)
+			return *prev == expected ? 0 : -EAGAIN;
+
+		if (WARN_ONCE(ret != -EFAULT, "Unexpected error"))
+			return -EFAULT;
+
+		ret = fix_pagefault((unsigned long)uaddr, true);
+		if (ret)
+			return -EFAULT;
+	}
+}
+
+/**
+ * atomic_stack_push_user - push a node onto the stack
+ * @head - a pointer to the head of the stack;
+ * @node - a pointer to the node to push.
+ *
+ * Push a node onto a single-linked list (stack). Atomicity/correctness
+ * is guaranteed by locking the head via settings its first bit (assuming
+ * the pointer is aligned).
+ *
+ * Return: 0 on success, -EFAULT on error.
+ */
+static inline int atomic_stack_push_user(u64 __user *head, u64 __user *node)
+{
+	while (true) {
+		int ret;
+		u64 first;
+
+		smp_mb();  /* Make the read below clean. */
+		if (get_user(first, head))
+			return -EFAULT;
+
+		if (first & 1UL) {
+			cpu_relax();
+			continue;  /* first is being deleted. */
+		}
+
+		if (put_user(first, node))
+			return -EFAULT;
+		smp_mb();  /* Make the write above visible. */
+
+		ret = umcg_cmpxchg_64_user(head, &first, (u64)node);
+		if (!ret)
+			return 0;
+
+		if (ret == -EAGAIN) {
+			cpu_relax();
+			continue;
+		}
+
+		if (WARN_ONCE(ret != -EFAULT, "unexpected umcg_cmpxchg result"))
+			return -EFAULT;
+
+		return -EFAULT;
+	}
+}
+
+/**
+ * atomic_stack_pop_user - pop a node from the stack
+ * @head - a pointer to the head of the stack;
+ * @value - a pointer to where store the popped value.
+ *
+ * Pop a node from a single-linked list (stack). Atomicity/correctness
+ * is guaranteed by locking the head via settings its first bit (assuming
+ * the pointer is aligned).
+ *
+ * Note: on success, @value should be cast to (u64 __user *) if not zero.
+ *
+ * Return: 0 on success, -EFAULT on error.
+ */
+static inline int atomic_stack_pop_user(u64 __user *head, u64 *value)
+{
+	while (true) {
+		int ret;
+		u64 next, first;
+
+		smp_mb();  /* Make the read below clean. */
+		if (get_user(first, head))
+			return -EFAULT;
+
+		if (!first) {
+			*value = 0UL;
+			return 0;
+		}
+
+		if (first & 1UL) {
+			cpu_relax();
+			continue;  /* first is being deleted. */
+		}
+
+		ret = umcg_cmpxchg_64_user(head, &first, first | 1UL);
+		if (ret == -EAGAIN) {
+			cpu_relax();
+			continue;
+		}
+
+		if (ret)
+			return -EFAULT;
+
+		if (get_user(next, (u64 __user *)first))
+			return -EFAULT;
+
+		first |= 1UL;
+
+		ret = umcg_cmpxchg_64_user(head, &first, next);
+		if (ret)
+			return -EFAULT;
+
+		*value = first & ~1UL;
+		return 0;
+	}
+}
+#endif  /* CONFIG_X86_64 */
+#endif  /* CONFIG_UMCG */
+#endif  /* _KERNEL_SCHED_UMCG_H */
--
2.25.1

