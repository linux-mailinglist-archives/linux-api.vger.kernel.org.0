Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAFD3DCD8B
	for <lists+linux-api@lfdr.de>; Sun,  1 Aug 2021 22:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhHAUGe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 1 Aug 2021 16:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhHAUGd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 1 Aug 2021 16:06:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AB3C06175F
        for <linux-api@vger.kernel.org>; Sun,  1 Aug 2021 13:06:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j1so22447207pjv.3
        for <linux-api@vger.kernel.org>; Sun, 01 Aug 2021 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ny67j5O7byZxjeFHXBz18QS2dZpjt9iKM0xcbydgTFs=;
        b=MuEzoy7M6/CaRR+btUxG63N9hVSNuoUImProThHtCrEZfsiRo74jyeKxnJn7ijw+zW
         baHpSm7PkwKMtsdB1/pzjTqjSNzWaVfUM010BtVrkusOCeIk2Hig06pgnBynU1Um9jJp
         v2nBNInsZ/LcaSGzXP4z0T5F/4L469fbeXd55BgA1P4TrSS7/urSNh1mTynsDI6VLHdl
         ygyNpw8L38I6NvafFDwXzowfnob5E23UnA+bWmOIiylFXGRo7SFvkqATF05ZFWMp/i0x
         uCObiZ05TNzR4E1ux1Guh+nC7k01OTbu0reUQ/Wu+wFT4jWR29jblCyo0iWU42R+OTS/
         hAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ny67j5O7byZxjeFHXBz18QS2dZpjt9iKM0xcbydgTFs=;
        b=DR023siph98S+0QAsw1/lFzsML+m5Dz0AGwEH3nPddIbXxG5h/yDpMZVFMmLGZ6XyW
         hlIoDxXnlgna5SONKQQO4wwAuaSDnEM7iT+lm/36gnrVp96+QHcmbA0Ug2twDA2zyPg7
         b01+05s+yz19O7rZwfg1BCyXMbvp1VYPvoaF7SC7sbCDFvgxP0ok4Nl8wB00wJfYeouq
         Ey/5rhPmrkG5FB860/IiL+Nx2ULGMA/HHubMdYqdYftGhj6clf/OFEbAcSqtNbVWvywk
         Ekya5ZqvpDePqF9pLnqMy9UZ0hkiLuj+ci8o+TcqQqhC84yYp93J6vUts/AbLmvlgIZp
         WKsQ==
X-Gm-Message-State: AOAM531Uzzbn2CKj70+5VwlSxJUwYpk04hWKlBN8jqnrg8MRcF74/K3S
        pJyE5vypJydb8FeIPpG2sTC2cw==
X-Google-Smtp-Source: ABdhPJx/eQOktNZ4bgZrfnipGRiNkPu8n7saQr/Rmedz3eFTv9kQLXiyDieO5t2ZxDx6AavUE94Xkg==
X-Received: by 2002:a17:902:a5c5:b029:12c:a867:a839 with SMTP id t5-20020a170902a5c5b029012ca867a839mr5300172plq.71.1627848384297;
        Sun, 01 Aug 2021 13:06:24 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id b3sm9293714pfi.179.2021.08.01.13.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:06:24 -0700 (PDT)
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
Subject: [PATCH 2/4 v0.4] sched/umcg: RFC: add userspace atomic helpers
Date:   Sun,  1 Aug 2021 13:06:15 -0700
Message-Id: <20210801200617.623745-3-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210801200617.623745-1-posk@google.com>
References: <20210801200617.623745-1-posk@google.com>
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
v0.3->v0.4:
 - added put_user_nosleep;
 - removed linked list/stack operations patch;
v0.2->v0.3:
 - renamed and refactored the helpers a bit, as described above;
 - moved linked list/stack operations into a separate patch.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 kernel/sched/umcg.h | 198 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100644 kernel/sched/umcg.h

diff --git a/kernel/sched/umcg.h b/kernel/sched/umcg.h
new file mode 100644
index 000000000000..1db283071ca6
--- /dev/null
+++ b/kernel/sched/umcg.h
@@ -0,0 +1,198 @@
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

