Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5092445C7EB
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 15:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353289AbhKXOtx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 09:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357550AbhKXOtt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 09:49:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D5EC09B191;
        Wed, 24 Nov 2021 06:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h4YHaXfc797c+fVdtCihmNRDbAha4Heg3KAGVDLIC8M=; b=pCbg2g70GO+I8eMvWx0LNFsReQ
        O0xE6GqUW+VOujs25DS9deR1gdD5Nc35A3QKdzM+I2eSRu2c7KGk9jZdnTmylU4yqln/SdrJVGnAK
        NpVu3wvlFxniiOllAG2Sg+tFus+48isqYtGsGhHuwawEgkWyzgnkpFHgxxiWxvXeN8lAofHqmbrRb
        JMuqarkvYGEYhvaD5drtQy+uISMzywp6EZ9PToIYyLxzJGPpD+2J9d5RwntLOtqZ4qLsjdFrDdH1/
        KrzDx9Kl1heNvTYPB74QAZvOQtBpFe5Mn1ZHsOpcZbIgPWYHXkmgv0jLP8uG5m/DZLJOr4ORFvcrZ
        5d3vn2mQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mptJX-002912-35; Wed, 24 Nov 2021 14:31:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54CD2300230;
        Wed, 24 Nov 2021 15:31:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39A52203C25B1; Wed, 24 Nov 2021 15:31:58 +0100 (CET)
Date:   Wed, 24 Nov 2021 15:31:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 2/6] mm, x86/uaccess: add userspace atomic helpers
Message-ID: <YZ5M3gm5v5qXCpUW@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-3-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122211327.5931-3-posk@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 22, 2021 at 01:13:23PM -0800, Peter Oskolkov wrote:

> +static inline int __try_cmpxchg_user_32(u32 *uval, u32 __user *uaddr,
> +						u32 oldval, u32 newval)

That's a 'try_cmpxchg' function but *NOT* the try_cmpxchg semantics,
please don't do that, fixed in the below.

> +int cmpxchg_user_64(u64 __user *uaddr, u64 *curr_val, u64 new_val)
> +{
> +	int ret = -EFAULT;
> +	u64 __old = *curr_val;
> +
> +	/* Validate proper alignment. */
> +	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
> +			((unsigned long)curr_val % sizeof(*curr_val))))
> +		return -EINVAL;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	while (true) {
> +		ret = -EFAULT;
> +		if (!user_access_begin(uaddr, sizeof(*uaddr)))
> +			break;
> +
> +		ret = __try_cmpxchg_user_64(curr_val, uaddr, __old, new_val);
> +		user_access_end();
> +
> +		if (!ret) {
> +			ret =  *curr_val == __old ? 0 : -EAGAIN;
> +			break;
> +		}
> +
> +		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
> +			break;
> +	}
> +
> +	pagefault_enable();
> +	return ret;
> +}

Please, just read what you wrote. This scored *really* high on the
WTF'o'meter.

That is aside of:

 - that user_access_begin() includes access_ok().
 - the fact that having SMAP *inside* a cmpxchg loop is ridiculous.
 - that you write cmpxchg inside a loop, but it isn't actually a cmpxchg-loop.

No the real problem is:

 - you *DISABLE* pagefaults
 - you force the exception handler
 - you manually fix up the fault

while you could've just done the op and let the fault handler do it's
thing, that whole function is pointless.



So as a penance for not having looked at this before I wrote you the
replacement. The asm-goto-output variant isn't actually compile tested,
but the old complicated thing is. Also, I'm >.< close to merging the
series that kills .fixup for x86, but the fixup (pun intended) should be
trivial.

Usage can be gleaned from the bigger patch I send you in reply to 0/ but
TL;DR:

	if (!user_access_begin(uptr, sizeof(u64)))
		return -EFAULT;

	unsafe_get_user(old, uptr, Efault);
	do {
		new = func(old);
	} while (!__try_cmpxchg_user(uptr, &old, new, Efault));

	user_access_end();

	return 0;

Efault:
	user_access_end();
	return -EFAULT;


Then if called within pagefault_disable(), it'll get -EFAULT more, if
called without it, it'll just take the fault and try to fix it up if at
all possible.


---
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 33a68407def3..909c48083c4f 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -341,6 +341,37 @@ do {									\
 		     : [umem] "m" (__m(addr))				\
 		     : : label)
 
+#define __try_cmpxchg_user_asm(itype, _ptr, _pold, _new, label)	({	\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm_volatile_goto("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
+		     _ASM_EXTABLE_UA(1b, %l[label])			\
+		     : CC_OUT(z) (success),				\
+		       [ptr] "+m" (*_ptr),				\
+		       [old] "+a" (__old)				\
+		     : [new] "r" (__new)				\
+		     : "memory", "cc"					\
+		     : label);						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
+
+#define __xchg_user_asm(itype, _ptr, _val, label)	({		\
+	__typeof__(*(_ptr)) __ret = (_val);				\
+	asm_volatile_goto("\n"						\
+			"1: " LOCK_PREFIX "xchg"itype" %[var], %[ptr]\n"\
+			_ASM_EXTABLE_UA(1b, %l[label])			\
+			: [var] "+r" (__ret).				\
+			  [ptr] "+m" (*(_ptr))				\
+			:						\
+			: "memory", "cc"				\
+			: label);					\
+	__ret;						})
+
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 #ifdef CONFIG_X86_32
@@ -411,8 +442,83 @@ do {									\
 		     : [umem] "m" (__m(addr)),				\
 		       [efault] "i" (-EFAULT), "0" (err))
 
+#define __try_cmpxchg_user_asm(itype, _ptr, _pold, _new, label)	({	\
+	int __err = 0;							\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
+		     CC_SET(z)						\
+		     "2:\n"						\
+		     ".pushsection .fixup,\"ax\"\n"			\
+		     "3:	mov %[efault], %[errout]\n"		\
+		     "		jmp 2b\n"				\
+		     ".popsection\n"					\
+		     _ASM_EXTABLE_UA(1b, 3b)				\
+		     : CC_OUT(z) (success),				\
+		       [errout] "+r" (__err),				\
+		       [ptr] "+m" (*_ptr),				\
+		       [old] "+a" (__old)				\
+		     : [new] "r" (__new),				\
+		       [efault] "i" (-EFAULT)				\
+		     : "memory", "cc");					\
+	if (unlikely(__err))						\
+		goto label;						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
+#define __xchg_user_asm(itype, _ptr, _val, label)	({		\
+	int __err = 0;							\
+	__typeof__(*(_ptr)) __ret = (_val);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "xchg"itype" %[var], %[ptr]\n"	\
+		     "2:\n"						\
+		     ".pushsection .fixup,\"ax\"\n"			\
+		     "3:	mov %[efault], %[errout]\n"		\
+		     "		jmp 2b\n"				\
+		     ".popsection\n"					\
+		     _ASM_EXTABLE_UA(1b, 3b)				\
+		     : [ptr] "+m" (*(_ptr)),				\
+		       [var] "+r" (__ret),				\
+		       [errout] "+r" (__err)				\
+		     : [efault] "i" (-EFAULT)				\
+		     : "memory", "cc");					\
+	if (unlikely(__err))						\
+		goto label;						\
+	__ret;						})
+
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
+extern void __try_cmpxchg_user_wrong_size(void);
+extern void __xchg_user_wrong_size(void);
+
+#define __try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({		\
+	__typeof__(*(_ptr)) __ret;					\
+	switch (sizeof(__ret)) {					\
+	case 4:	__ret = __try_cmpxchg_user_asm("l", (_ptr), (_oldp),	\
+					       (_nval), _label);	\
+		break;							\
+	case 8:	__ret = __try_cmpxchg_user_asm("q", (_ptr), (_oldp),	\
+					       (_nval), _label);	\
+		break;							\
+	default: __try_cmpxchg_user_wrong_size();			\
+	}								\
+	__ret;						})
+
+#define __xchg_user(_ptr, _nval, _label)		({		\
+	__typeof__(*(_ptr)) __ret;					\
+	switch (sizeof(__ret)) {					\
+	case 4: __ret = __xchg_user_asm("l", (_ptr), (_nval), _label);	\
+		break;							\
+	case 8: __ret = __xchg_user_asm("q", (_ptr), (_nval), _label);	\
+		break;							\
+	default: __xchg_user_wrong_size();				\
+	}								\
+	__ret;						})
+
 /* FIXME: this hack is definitely wrong -AK */
 struct __large_struct { unsigned long buf[100]; };
 #define __m(x) (*(struct __large_struct __user *)(x))
