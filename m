Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8174540FEF2
	for <lists+linux-api@lfdr.de>; Fri, 17 Sep 2021 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbhIQSE4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Sep 2021 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbhIQSEy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Sep 2021 14:04:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23500C061574
        for <linux-api@vger.kernel.org>; Fri, 17 Sep 2021 11:03:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n2so4089003plk.12
        for <linux-api@vger.kernel.org>; Fri, 17 Sep 2021 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLdxpR7e5qoomVVKT+7/RLfFQA2fUy9OidkDkwgIHmk=;
        b=XHGPR+psb3orXsp1XhzHUqgxgnw5bmQa8OGk/mz1eTAn/7DK8P2h4ys9T/F7Ik03TE
         cL2MLH2nvE1iyrTN1vIgk/dVvDYcw7ygCPRJqoI1WHYGbxurQEYzI8IpS43DyicIgGuY
         L9gaXKCXsRVsdISYq5SPrzaAfKNTDjH5C4Q+7oIx1c/p3lTXwpftsSRM2624cBZP1TfU
         zRW1+ov1/0whShXsRTDnpggm0f+VSNyq45+6TZbEnlJb/Ym5GLgVx+zFrygOCYFtTtD8
         4NC+tf0yZkiCQw/qrQyT9jYUlrxWpSzYnI2p2S2t5Rj0Wvauq46EzEOFBywlzCX8Sp/f
         CMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLdxpR7e5qoomVVKT+7/RLfFQA2fUy9OidkDkwgIHmk=;
        b=nZX90q/TenxT3kTwvgGJrkoSGkfyx6h2yHVrJRpMMnzd7xG+y/fSTpLHOuSghswb2Q
         jrgDtuOuvPPVSBnA6FvP6gs9fimtD7ejYCP5dNEUOgh9RYQTO/tbaOCetzuKRnoqKY9f
         /YAm3J6OtFqXyDJdhM3wgFdAoqil+cpFwHmJfpKXmX/pmmjPJ+aIkqPdyxJsTLn2Yuy/
         xN2OoPUA+7Lc3eBzVP3YQ91LxTyk3BCFNYv/idQOeMyLLQNZs+VpGqqKVlcVAi7zCQ5J
         v+iebjf127jVnvkclKIKDcpxp5ndOK6KlJCjeXk1S+DgdASg+gMwGEW3bHWxMNcWdiPT
         izHg==
X-Gm-Message-State: AOAM530r2myKvLa8FhBRGGadUimKVZPuMxNahVeAtDW65Q6u06ID8QB/
        8E5Ewm45oGCR+1fIaYxaovWEnA==
X-Google-Smtp-Source: ABdhPJxXwbemvTjDVAngFbg2hGOo57Z5vPYYLWsyqSXVXr5ba2Mn6/m1M/gogzKZdCpbY1oXgFHXZw==
X-Received: by 2002:a17:90a:940d:: with SMTP id r13mr13916717pjo.63.1631901811628;
        Fri, 17 Sep 2021 11:03:31 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id b24sm5781773pfi.205.2021.09.17.11.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 11:03:31 -0700 (PDT)
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
Subject: [PATCH 2/5 v0.6] sched/umcg: RFC: add userspace atomic helpers
Date:   Fri, 17 Sep 2021 11:03:20 -0700
Message-Id: <20210917180323.278250-3-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917180323.278250-1-posk@google.com>
References: <20210917180323.278250-1-posk@google.com>
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
them in kernel/sched/umcg_uaccess.h temporarily for convenience. Please
let me know where I should put them.

Changelog:
v0.5->v0.6:
 - replaced mmap_read_lock with mmap_read_lock_killable in fix_pagefault();
 - fix_pagefault now validates proper uaddr alignment;
 - renamed umcg.h to umcg_uaccess.h;
v0.4->v0.5:
 - added xchg_user_** helpers;
v0.3->v0.4:
 - added put_user_nosleep;
 - removed linked list/stack operations patch;
v0.2->v0.3:
 - renamed and refactored the helpers a bit, as described above;
 - moved linked list/stack operations into a separate patch.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 kernel/sched/umcg_uaccess.h | 344 ++++++++++++++++++++++++++++++++++++
 1 file changed, 344 insertions(+)
 create mode 100644 kernel/sched/umcg_uaccess.h

diff --git a/kernel/sched/umcg_uaccess.h b/kernel/sched/umcg_uaccess.h
new file mode 100644
index 000000000000..e4ead8d2fd62
--- /dev/null
+++ b/kernel/sched/umcg_uaccess.h
@@ -0,0 +1,344 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _KERNEL_SCHED_UMCG_UACCESS_H
+#define _KERNEL_SCHED_UMCG_UACCESS_H
+
+#ifdef CONFIG_X86_64
+
+#include <linux/uaccess.h>
+
+#include <asm/asm.h>
+#include <linux/atomic.h>
+#include <asm/uaccess.h>
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
+static inline int fix_pagefault(unsigned long uaddr, bool write_fault, int bytes)
+{
+	struct mm_struct *mm = current->mm;
+	int ret;
+
+	/* Validate proper alignment. */
+	if (uaddr % bytes)
+		return -EINVAL;
+
+	if (mmap_read_lock_killable(mm))
+		return -EINTR;
+	ret = fixup_user_fault(mm, uaddr, write_fault ? FAULT_FLAG_WRITE : 0,
+			NULL);
+	mmap_read_unlock(mm);
+
+	return ret < 0 ? ret : 0;
+}
+
+/**
+ * cmpxchg_32_user_nosleep - compare_exchange 32-bit values
+ *
+ * Return:
+ * 0 - OK
+ * -EFAULT: memory access error
+ * -EAGAIN: @expected did not match; consult @prev
+ */
+static inline int cmpxchg_user_32_nosleep(u32 __user *uaddr, u32 *old, u32 new)
+{
+	int ret = -EFAULT;
+	u32 __old = *old;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	__uaccess_begin_nospec();
+	ret = __try_cmpxchg_user_32(old, uaddr, __old, new);
+	user_access_end();
+
+	if (!ret)
+		ret =  *old == __old ? 0 : -EAGAIN;
+
+	pagefault_enable();
+	return ret;
+}
+
+/**
+ * cmpxchg_64_user_nosleep - compare_exchange 64-bit values
+ *
+ * Return:
+ * 0 - OK
+ * -EFAULT: memory access error
+ * -EAGAIN: @expected did not match; consult @prev
+ */
+static inline int cmpxchg_user_64_nosleep(u64 __user *uaddr, u64 *old, u64 new)
+{
+	int ret = -EFAULT;
+	u64 __old = *old;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	__uaccess_begin_nospec();
+	ret = __try_cmpxchg_user_64(old, uaddr, __old, new);
+	user_access_end();
+
+	if (!ret)
+		ret =  *old == __old ? 0 : -EAGAIN;
+
+	pagefault_enable();
+
+	return ret;
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
+		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
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
+		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
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
+
+		__uaccess_begin_nospec();
+		ret = __try_xchg_user_32(val, uaddr, *val);
+		user_access_end();
+
+		if (!ret)
+			break;
+
+		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
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
+
+		__uaccess_begin_nospec();
+		ret = __try_xchg_user_64(val, uaddr, *val);
+		user_access_end();
+
+		if (!ret)
+			break;
+
+		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
+			break;
+	}
+
+	pagefault_enable();
+
+	return ret;
+}
+
+/**
+ * get_user_nosleep - get user value without sleeping.
+ *
+ * get_user() might sleep and therefore cannot be used in preempt-disabled
+ * regions.
+ */
+#define get_user_nosleep(out, uaddr)			\
+({							\
+	int ret = -EFAULT;				\
+							\
+	if (access_ok((uaddr), sizeof(*(uaddr)))) {	\
+		pagefault_disable();			\
+							\
+		if (!__get_user((out), (uaddr)))	\
+			ret = 0;			\
+							\
+		pagefault_enable();			\
+	}						\
+	ret;						\
+})
+
+#endif  /* CONFIG_X86_64 */
+#endif  /* _KERNEL_SCHED_UMCG_UACCESS_H */
--
2.25.1

