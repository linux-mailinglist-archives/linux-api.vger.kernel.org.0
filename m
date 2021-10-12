Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C834542B01B
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 01:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhJLX1j (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Oct 2021 19:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbhJLX1g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Oct 2021 19:27:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C874C061746
        for <linux-api@vger.kernel.org>; Tue, 12 Oct 2021 16:25:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om14so770578pjb.5
        for <linux-api@vger.kernel.org>; Tue, 12 Oct 2021 16:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYYN8ps/4ON5gOEV1om9Qq0pYbPKO37jw8Nt8S6IsO8=;
        b=QosNPx7C2GPyZUrjqeHNGr3sYxXkjSRqOfuhYSryLPbAS1k+n8XvHGTsBVi4asPnYk
         P2F1cLSmYk6Dd6m/SNxSRRzA5kA41I1Mnuv0Kg+Jy6d6AVReV2bjCdRn6sm6IPsH1pRH
         IobUAZUKwxgx/B4DJ5iV8EwakQNnhG+OGbzDH1etY0ziXV+QWWZrAgKvBi9goTFkSCSJ
         HWry37m/KzKNfPGrjDdQfN0tvnM+mWp6JZ01Goh9ZgAMEtm3V9H3a4vcU1mXzIkCcPPQ
         kr7C1YtHiJOjLXOrK9VEz+30e9WHg4Rh5tNGW2iYks5Z2t42jPAbxpGRjjPCpuwiPLmU
         wGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYYN8ps/4ON5gOEV1om9Qq0pYbPKO37jw8Nt8S6IsO8=;
        b=FPXTR/hffWh+uv8z05PKkkdVmy1s2hiG09kp3ZgMv9hDn9HskuX7iMgwow4PjwfzXi
         cnBJtWq321yLeMSw89jnHW49JaIafLCb58U9x8EF3C0td9wE+QV274Jc2VownARvsyc6
         vZvHH20kjHJy3tARewf5HwAukHhOVKqmG9BCLaTDHkToTvNcH1s1V1B5ogkDFRsNuieO
         7F4jX3y2HVsyhmuDcCyKgvz8oDE4EXWs/YlW46xOu5kM8F5ulgGm249WCX6ss+adUXdU
         jHHqnrQ4lr5nGSta/Ag6zUkRTiq04oDHM81FQcac4/q+BT19VF+u/LsopfU18YvV602E
         2qpg==
X-Gm-Message-State: AOAM531QevP557rOLKOe83+T4JdObLShsGec79FCPS+SH/JJu9v3ityo
        UxeWyrIvMHlLDOcOzL9QCEie8A==
X-Google-Smtp-Source: ABdhPJz/lSTAwKoxtaM+NkVypfLKQ3ADRoTZlHRK/5TJ69mVhGqdo/T8KbGuZgbyWOZ/bDa7DRQG7g==
X-Received: by 2002:a17:90a:2902:: with SMTP id g2mr9374632pjd.161.1634081133530;
        Tue, 12 Oct 2021 16:25:33 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id v20sm12675026pgc.38.2021.10.12.16.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 16:25:33 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH v0.7 2/5] mm, x86/uaccess: add userspace atomic helpers
Date:   Tue, 12 Oct 2021 16:25:19 -0700
Message-Id: <20211012232522.714898-3-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012232522.714898-1-posk@google.com>
References: <20211012232522.714898-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In addition to futexes needing to do atomic operations in the userspace,
a second use case is now in the works (UMCG, see
https://lore.kernel.org/all/20210917180323.278250-1-posk@google.com/),
so a generic facility to perform these operations has been called for
(see https://lore.kernel.org/all/87ilyk9xc0.ffs@tglx/).

Add a set of generic helpers to perform 32/64-bit xchg and cmpxchg
operations in the userspace. Also implement the required
architecture-specific support on x86_64.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 arch/x86/include/asm/uaccess_64.h |  93 +++++++++++
 include/linux/uaccess.h           |  46 ++++++
 mm/maccess.c                      | 264 ++++++++++++++++++++++++++++++
 3 files changed, 403 insertions(+)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 45697e04d771..fd535660123c 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -79,4 +79,97 @@ __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
 	kasan_check_write(dst, size);
 	return __copy_user_flushcache(dst, src, size);
 }
+
+#define ARCH_HAS_ATOMIC_UACCESS_HELPERS 1
+
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
 #endif /* _ASM_X86_UACCESS_64_H */
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..dcb3ac093075 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -408,4 +408,50 @@ void __noreturn usercopy_abort(const char *name, const char *detail,
 			       unsigned long len);
 #endif

+#ifdef ARCH_HAS_ATOMIC_UACCESS_HELPERS
+/**
+ * cmpxchg_user_[32|64][_nofault|]() - compare_exchange 32/64-bit values
+ * @uaddr:     Destination address, in user space;
+ * @curr_val:  Source address, in kernel space;
+ * @new_val:   The value to write to the destination address.
+ *
+ * This is the standard cmpxchg: atomically: compare *@uaddr to *@curr_val;
+ * if the values match, write @new_val to @uaddr, return 0; if the values
+ * do not match, write *@uaddr to @curr_val, return -EAGAIN.
+ *
+ * The _nofault versions don't fault and can be used in
+ * atomic/preempt-disabled contexts.
+ *
+ * Return:
+ * 0      : OK/success;
+ * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
+ * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault);
+ * -EAGAIN: @old did not match.
+ */
+int cmpxchg_user_32_nofault(u32 __user *uaddr, u32 *curr_val, u32 new_val);
+int cmpxchg_user_64_nofault(u64 __user *uaddr, u64 *curr_val, u64 new_val);
+int cmpxchg_user_32(u32 __user *uaddr, u32 *curr_val, u32 new_val);
+int cmpxchg_user_64(u64 __user *uaddr, u64 *curr_val, u64 new_val);
+
+/**
+ * xchg_user_[32|64][_nofault|]() - exchange 32/64-bit values
+ * @uaddr:   Destination address, in user space;
+ * @val:     Source address, in kernel space.
+ *
+ * This is the standard atomic xchg: exchange values pointed to by @uaddr and @val.
+ *
+ * The _nofault versions don't fault and can be used in
+ * atomic/preempt-disabled contexts.
+ *
+ * Return:
+ * 0      : OK/success;
+ * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
+ * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault).
+ */
+int xchg_user_32_nofault(u32 __user *uaddr, u32 *val);
+int xchg_user_64_nofault(u64 __user *uaddr, u64 *val);
+int xchg_user_32(u32 __user *uaddr, u32 *val);
+int xchg_user_64(u64 __user *uaddr, u64 *val);
+#endif		/* ARCH_HAS_ATOMIC_UACCESS_HELPERS */
+
 #endif		/* __LINUX_UACCESS_H__ */
diff --git a/mm/maccess.c b/mm/maccess.c
index d3f1a1f0b1c1..620556b11550 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -335,3 +335,267 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count)

 	return ret;
 }
+
+#ifdef ARCH_HAS_ATOMIC_UACCESS_HELPERS
+
+static int fix_pagefault(unsigned long uaddr, bool write_fault, int bytes)
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
+int cmpxchg_user_32_nofault(u32 __user *uaddr, u32 *curr_val, u32 new_val)
+{
+	int ret = -EFAULT;
+	u32 __old = *curr_val;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
+		pagefault_enable();
+		return -EFAULT;
+	}
+	ret = __try_cmpxchg_user_32(curr_val, uaddr, __old, new_val);
+	user_access_end();
+
+	if (!ret)
+		ret =  *curr_val == __old ? 0 : -EAGAIN;
+
+	pagefault_enable();
+	return ret;
+}
+
+int cmpxchg_user_64_nofault(u64 __user *uaddr, u64 *curr_val, u64 new_val)
+{
+	int ret = -EFAULT;
+	u64 __old = *curr_val;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
+		pagefault_enable();
+		return -EFAULT;
+	}
+	ret = __try_cmpxchg_user_64(curr_val, uaddr, __old, new_val);
+	user_access_end();
+
+	if (!ret)
+		ret =  *curr_val == __old ? 0 : -EAGAIN;
+
+	pagefault_enable();
+
+	return ret;
+}
+
+int cmpxchg_user_32(u32 __user *uaddr, u32 *curr_val, u32 new_val)
+{
+	int ret = -EFAULT;
+	u32 __old = *curr_val;
+
+	/* Validate proper alignment. */
+	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
+			((unsigned long)curr_val % sizeof(*curr_val))))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		ret = -EFAULT;
+		if (!user_access_begin(uaddr, sizeof(*uaddr)))
+			break;
+
+		ret = __try_cmpxchg_user_32(curr_val, uaddr, __old, new_val);
+		user_access_end();
+
+		if (!ret) {
+			ret =  *curr_val == __old ? 0 : -EAGAIN;
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
+int cmpxchg_user_64(u64 __user *uaddr, u64 *curr_val, u64 new_val)
+{
+	int ret = -EFAULT;
+	u64 __old = *curr_val;
+
+	/* Validate proper alignment. */
+	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
+			((unsigned long)curr_val % sizeof(*curr_val))))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		ret = -EFAULT;
+		if (!user_access_begin(uaddr, sizeof(*uaddr)))
+			break;
+
+		ret = __try_cmpxchg_user_64(curr_val, uaddr, __old, new_val);
+		user_access_end();
+
+		if (!ret) {
+			ret =  *curr_val == __old ? 0 : -EAGAIN;
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
+ * xchg_user_[32|64][_nofault|]() - exchange 32/64-bit values
+ * @uaddr:   Destination address, in user space;
+ * @val:     Source address, in kernel space.
+ *
+ * This is the standard atomic xchg: exchange values pointed to by @uaddr and @val.
+ *
+ * The _nofault versions don't fault and can be used in
+ * atomic/preempt-disabled contexts.
+ *
+ * Return:
+ * 0      : OK/success;
+ * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
+ * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault).
+ */
+int xchg_user_32_nofault(u32 __user *uaddr, u32 *val)
+{
+	int ret;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
+		pagefault_enable();
+		return -EFAULT;
+	}
+
+	ret = __try_xchg_user_32(val, uaddr, *val);
+	user_access_end();
+
+	pagefault_enable();
+
+	return ret;
+}
+
+int xchg_user_64_nofault(u64 __user *uaddr, u64 *val)
+{
+	int ret;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
+		pagefault_enable();
+		return -EFAULT;
+	}
+
+	ret = __try_xchg_user_64(val, uaddr, *val);
+	user_access_end();
+
+	pagefault_enable();
+
+	return ret;
+}
+
+int xchg_user_32(u32 __user *uaddr, u32 *val)
+{
+	int ret = -EFAULT;
+
+	/* Validate proper alignment. */
+	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
+			((unsigned long)val % sizeof(*val))))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		ret = -EFAULT;
+		if (!user_access_begin(uaddr, sizeof(*uaddr)))
+			break;
+
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
+int xchg_user_64(u64 __user *uaddr, u64 *val)
+{
+	int ret = -EFAULT;
+
+	/* Validate proper alignment. */
+	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
+			((unsigned long)val % sizeof(*val))))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	while (true) {
+		ret = -EFAULT;
+		if (!user_access_begin(uaddr, sizeof(*uaddr)))
+			break;
+
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
+#endif		/* ARCH_HAS_ATOMIC_UACCESS_HELPERS */
--
2.25.1

