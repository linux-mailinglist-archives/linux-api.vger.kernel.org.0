Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1559C403F3D
	for <lists+linux-api@lfdr.de>; Wed,  8 Sep 2021 20:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350246AbhIHSuY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 14:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350240AbhIHSuX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 14:50:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB740C061757
        for <linux-api@vger.kernel.org>; Wed,  8 Sep 2021 11:49:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso1975382pjh.5
        for <linux-api@vger.kernel.org>; Wed, 08 Sep 2021 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAZubrtFZP+6/ByAAEGI/qOIuTDfk/aZwVU4wMuJpMc=;
        b=GIukAKgHqmwo4y7H58D+oc50+Fjv2sgz4ProJwIZawRL+4p+hNFtun1GADk8SYP6n2
         xLvQa6DKX+WSNowYx0wGwk2aPvP/OPPzK8ufPjvgQhdp7UNAne1wupvp/uSMK7AuZu3z
         PNMgVFKm3vGOa2lHiB9DvAjPuCHSwx75MQNqZgBVOSwxp+s7+Rq9p5fAAHS+KQkl0Hw3
         i9UH6jhRGx8ykFW8rWj2pB1xqShLM/F3c2y8XmapaWckgkf7bM9UHRZoutPSq+1kG5s1
         3ypNyAkcJnSvVfh+J4AdMYSetl608/76t3nBwrO0HiV1Oza/TriTiEGO1KMOC4WRje8q
         aFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAZubrtFZP+6/ByAAEGI/qOIuTDfk/aZwVU4wMuJpMc=;
        b=KQsT/bH70sDZbL7+ICCwxbaBIa8hRtfXgHgkxK8VJL02QneikgCJN2eE8hUDTCjipF
         iXnbrJOCXGZpag8hq0Xp5IWAkzE7tD3wvwE/LmAOPZhaaJUyR625xM0tPorHFej9m5FY
         wAjRX8Rs6/mlEQy3O0pI5Gw1ULVKsxQW5yxx3KIc6KVZHCqIY8jFEAJAVg+ISJjbV50I
         M6c6517VS6WzUcf0lfvHXoKOGuq6B9qhSPiLHVWHiWmPrK60WSWpo0qV3Qkp2zTYF2qi
         Vzmlkjvp8/n82yM4OEqVfAhmNDxPxfXuVNm4PCVZPTBQFPwXzgeoBKwh9VVCn4bnfdOg
         DOkA==
X-Gm-Message-State: AOAM533QHu3BDjhay7gSJKbWlEY2fTsknlluqVxKQdaCIyzYjNCHutmZ
        ELXedEZ7VJ55v7ghZIcD9UTRVA==
X-Google-Smtp-Source: ABdhPJzf7ZRUbKtmLQt41AAxNgk1CfQ1Plf1zM8sbGm/ZEIInkYnrtFo6krvemG+FWiGmo6ERONZQA==
X-Received: by 2002:a17:90a:7f01:: with SMTP id k1mr5715781pjl.156.1631126954180;
        Wed, 08 Sep 2021 11:49:14 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id m64sm3645640pga.55.2021.09.08.11.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:49:13 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
Date:   Wed,  8 Sep 2021 11:49:03 -0700
Message-Id: <20210908184905.163787-3-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908184905.163787-1-posk@google.com>
References: <20210908184905.163787-1-posk@google.com>
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
v04->v0.5:
 - added xchg_user_** helpers;
v0.3->v0.4:
 - added put_user_nosleep;
 - removed linked list/stack operations patch;
v0.2->v0.3:
 - renamed and refactored the helpers a bit, as described above;
 - moved linked list/stack operations into a separate patch.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 kernel/sched/umcg.h | 312 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 312 insertions(+)
 create mode 100644 kernel/sched/umcg.h

diff --git a/kernel/sched/umcg.h b/kernel/sched/umcg.h
new file mode 100644
index 000000000000..89ba84afa977
--- /dev/null
+++ b/kernel/sched/umcg.h
@@ -0,0 +1,312 @@
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
+ * cmpxchg_32_user - compare_exchange 32-bit values
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
+ * cmpxchg_64_user - compare_exchange 64-bit values
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
+
+	return ret;
+}
+
+static inline int __try_xchg_user_32(u32 *oval, u32 __user *uaddr, u32 newval)
+{
+	u32 oldval = 0;
+	int ret = 0;
+
+	asm volatile("\n"
+		"1:\txchgl %0, %2\n"
+		"2:\n"
+		"\t.section .fixup, \"ax\"\n"
+		"3:\tmov     %3, %0\n"
+		"\tjmp     2b\n"
+		"\t.previous\n"
+		_ASM_EXTABLE_UA(1b, 3b)
+		: "=r" (oldval), "=r" (ret), "+m" (*uaddr)
+		: "i" (-EFAULT), "0" (newval), "1" (0)
+	);
+
+	if (ret)
+		return ret;
+
+	*oval = oldval;
+	return 0;
+}
+
+static inline int __try_xchg_user_64(u64 *oval, u64 __user *uaddr, u64 newval)
+{
+	u64 oldval = 0;
+	int ret = 0;
+
+	asm volatile("\n"
+		"1:\txchgq %0, %2\n"
+		"2:\n"
+		"\t.section .fixup, \"ax\"\n"
+		"3:\tmov     %3, %0\n"
+		"\tjmp     2b\n"
+		"\t.previous\n"
+		_ASM_EXTABLE_UA(1b, 3b)
+		: "=r" (oldval), "=r" (ret), "+m" (*uaddr)
+		: "i" (-EFAULT), "0" (newval), "1" (0)
+	);
+
+	if (ret)
+		return ret;
+
+	*oval = oldval;
+	return 0;
+}
+
+/**
+ * xchg_32_user - atomically exchange 64-bit values
+ *
+ * Return:
+ * 0 - OK
+ * -EFAULT: memory access error
+ */
+static inline int xchg_user_32(u32 __user *uaddr, u32 *val)
+{
+	int ret = -EFAULT;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		__uaccess_begin_nospec();
+		ret = __try_xchg_user_32(val, uaddr, *val);
+		user_access_end();
+
+		if (!ret)
+			break;
+
+		if (fix_pagefault((unsigned long)uaddr, true) < 0)
+			break;
+	}
+
+	pagefault_enable();
+
+	return ret;
+}
+
+/**
+ * xchg_64_user - atomically exchange 64-bit values
+ *
+ * Return:
+ * 0 - OK
+ * -EFAULT: memory access error
+ */
+static inline int xchg_user_64(u64 __user *uaddr, u64 *val)
+{
+	int ret = -EFAULT;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		__uaccess_begin_nospec();
+		ret = __try_xchg_user_64(val, uaddr, *val);
+		user_access_end();
+
+		if (!ret)
+			break;
+
+		if (fix_pagefault((unsigned long)uaddr, true) < 0)
+			break;
+	}
+
+	pagefault_enable();
+
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
+	if (access_ok((uaddr), sizeof(*(uaddr)))) {			\
+		pagefault_disable();					\
+									\
+		while (true) {						\
+			if (!__get_user((out), (uaddr))) {		\
+				ret = 0;				\
+				break;					\
+			}						\
+									\
+			if (fix_pagefault((unsigned long)(uaddr), false) < 0) \
+				break;					\
+		}							\
+									\
+		pagefault_enable();					\
+	}								\
+	ret;								\
+})
+
+/**
+ * put_user_nosleep - put user value with inline fixup without sleeping.
+ *
+ * put_user() might sleep and therefore cannot be used in preempt-disabled
+ * regions.
+ */
+#define put_user_nosleep(out, uaddr)					\
+({									\
+	int ret = -EFAULT;						\
+									\
+	if (access_ok((uaddr), sizeof(*(uaddr)))) {			\
+		pagefault_disable();					\
+									\
+		while (true) {						\
+			if (!__put_user((out), (uaddr))) {		\
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

