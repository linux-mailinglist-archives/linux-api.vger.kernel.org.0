Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BF83CBC14
	for <lists+linux-api@lfdr.de>; Fri, 16 Jul 2021 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhGPSun (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Jul 2021 14:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPSu2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Jul 2021 14:50:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5735C061765
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 11:47:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o8so5741134plg.11
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhI0XXDV8yiWk1PS9R3P0X9l+ZCIXIAwsagPrUXxtf0=;
        b=N7WpBcqI40urDe9VnLrgtHUDc+BW1wsM2yOIGeVMr2wIVZQEopdiuizHoLjbQJaJMJ
         f4b4H0WADhfRjNMmVIGOvYSw7aeQJmaNfMXkIgeiXftEtXG79+fAwS6gPwAz+6Vifvmr
         oyQHpTPWDgkbc6fijh6dX+VmGgMuchBcERTXWNDqQRYkN1/NRhExOjNmu+P8Hmv/AjbL
         FfTj1uiWuhotT3NzCbJCig+JPuByByqoHhcWlT09NunwCuRJfCXlw50obo0hUh1lVhBc
         gVqLmAMdBvgX2GKXb4pnNJztV5+zkNonYH4N2nXx8HnJGpXm4s28O3AcYXHLK83E2jiW
         ryyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhI0XXDV8yiWk1PS9R3P0X9l+ZCIXIAwsagPrUXxtf0=;
        b=AR41nNygsy/zsZN17vjSh2D0gQsbD8ADifEUAfUTJZEU3inztEN4mzzYQ4GXG06cAv
         2kAD+biGjRTM/gS7Jkxj2WKKO/EyE9NQa+vgL1XB+OqQsK9vgY8ekCUbZpSVVrtjbnvi
         yRXzdyin74rkdvtxiF3xuAUFeT5RW7P52TxkAFGLHJCIAukqv7H8JClDG06nFgdHDBPs
         VN168FlYU50ZVDiLXcgPKtY3L9yn2RWWQ1hijqxcDV3l5fHZ/jV8uP5J0Wsn7X80Sp3S
         2GnCPDofZs2QRviRdO5dEUcLBc+tWFR+Qzzw49pHGaxMztmjkIYJ3MOV8MPDuuIfuAhJ
         90+A==
X-Gm-Message-State: AOAM530gyn9EbXNGKaxPPobEdyGMPSBBogeb8jTntg1AFTGsjN/t3Bcu
        +rDRZTe7INqncF5Ajsy8aegKtw==
X-Google-Smtp-Source: ABdhPJxv6FT+7MU8+UP7SE+t4lJE5Bcg/4RSVn8tZfwmvtiukGjNm77371y6cqzsIXE6FAcaabVoxw==
X-Received: by 2002:a17:902:c215:b029:12b:25f7:9b11 with SMTP id 21-20020a170902c215b029012b25f79b11mr8853135pll.82.1626461251442;
        Fri, 16 Jul 2021 11:47:31 -0700 (PDT)
Received: from localhost.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id q125sm3170240pga.87.2021.07.16.11.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:47:30 -0700 (PDT)
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
        Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [RFC PATCH 2/4 v0.3] sched/umcg: RFC: add userspace atomic helpers
Date:   Fri, 16 Jul 2021 11:47:17 -0700
Message-Id: <20210716184719.269033-3-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716184719.269033-1-posk@google.com>
References: <20210716184719.269033-1-posk@google.com>
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
let me know where I should put them.

Note: the current code follows sugestions here:
https://lore.kernel.org/lkml/YOgCdMWE9OXvqczk@hirez.programming.kicks-ass.net/
with the exception that I couldn't combine __try_cmpxchg_user_32/64 functions
into a macro, as my asm foo is not too strong. I'll continue trying to make
the macro work, but for the moment I've decided to post this RFC so that
other areas of the patchset could be reviewed.

Changelog:
v0.2->v0.3:
 - renamed and refactored the helpers a bit, as described above;
 - moved linked list/stack operations into a separate patch.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 kernel/sched/umcg.h | 169 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 kernel/sched/umcg.h

diff --git a/kernel/sched/umcg.h b/kernel/sched/umcg.h
new file mode 100644
index 000000000000..288017f5368c
--- /dev/null
+++ b/kernel/sched/umcg.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _KERNEL_SCHED_UMCG_H
+#define _KERNEL_SCHED_UMCG_H
+
+#ifdef CONFIG_X86_64
+
+#include <linux/uaccess.h>
+
+#include <asm/asm.h>
+#include <linux/atomic.h>
+
+/* TODO: move atomic operations below into arch/ headers */
+static inline int __try_cmpxchg_user_32(u32 *uval, u32 __user *uaddr,
+						u32 oldval, u32 newval)
+{
+	int ret = 0;
+
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
+	*uval = oldval;
+	return ret;
+}
+
+static inline int __try_cmpxchg_user_64(u64 *uval, u64 __user *uaddr,
+						u64 oldval, u64 newval)
+{
+	int ret = 0;
+
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
+/**
+ * umcg_cmpxchg_32_user - compare_exchange 32-bit values
+ *
+ * Return:
+ * 0 - OK
+ * -EFAULT: memory access error
+ * -EAGAIN: @expected did not match; consult @prev
+ */
+static inline int cmpxchg_user_32(u32 __user *uaddr, u32 *old, u32 new)
+{
+	int ret = -EFAULT;
+	u32 __old = *old;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		__uaccess_begin_nospec();
+		ret = __try_cmpxchg_user_32(old, uaddr, __old, new);
+		user_access_end();
+
+		if (!ret) {
+			ret =  *old == __old ? 0 : -EAGAIN;
+			break;
+		}
+
+		if (fix_pagefault((unsigned long)uaddr, true) < 0)
+			break;
+	}
+
+	pagefault_enable();
+	return ret;
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
+static inline int cmpxchg_user_64(u64 __user *uaddr, u64 *old, u64 new)
+{
+	int ret = -EFAULT;
+	u64 __old = *old;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		__uaccess_begin_nospec();
+		ret = __try_cmpxchg_user_64(old, uaddr, __old, new);
+		user_access_end();
+
+		if (!ret) {
+			ret =  *old == __old ? 0 : -EAGAIN;
+			break;
+		}
+
+		if (fix_pagefault((unsigned long)uaddr, true) < 0)
+			break;
+	}
+
+	pagefault_enable();
+	return ret;
+}
+
+/**
+ * get_user_nosleep - get user value with inline fixup without sleeping.
+ *
+ * get_user() might sleep and therefore cannot be used in preempt-disabled
+ * regions.
+ */
+#define get_user_nosleep(out, uaddr)					\
+({									\
+	int ret = -EFAULT;						\
+									\
+	if (access_ok((uaddr), sizeof(*(uaddr)))) {				\
+		pagefault_disable();					\
+									\
+		while (true) {						\
+			if (!__get_user((out), (uaddr))) {			\
+				ret = 0;				\
+				break;					\
+			}						\
+									\
+			if (fix_pagefault((unsigned long)(uaddr), true) < 0) \
+				break;					\
+		}							\
+									\
+		pagefault_enable();					\
+	}								\
+	ret;								\
+})
+
+#endif  /* CONFIG_X86_64 */
+#endif  /* _KERNEL_SCHED_UMCG_H */
--
2.25.1

