Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56A9BE2FE
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440123AbfIYRAc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 13:00:32 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:13298 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392205AbfIYRAc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Sep 2019 13:00:32 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 72A03A21D6;
        Wed, 25 Sep 2019 19:00:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id swp-s0YUgHBL; Wed, 25 Sep 2019 19:00:09 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
Date:   Wed, 25 Sep 2019 18:59:12 +0200
Message-Id: <20190925165915.8135-2-cyphar@cyphar.com>
In-Reply-To: <20190925165915.8135-1-cyphar@cyphar.com>
References: <20190925165915.8135-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A common pattern for syscall extensions is increasing the size of a
struct passed from userspace, such that the zero-value of the new fields
result in the old kernel behaviour (allowing for a mix of userspace and
kernel vintages to operate on one another in most cases).

While this interface exists for communication in both directions, only
one interface is straightforward to have reasonable semantics for
(userspace passing a struct to the kernel). For kernel returns to
userspace, what the correct semantics are (whether there should be an
error if userspace is unaware of a new extension) is very
syscall-dependent and thus probably cannot be unified between syscalls
(a good example of this problem is [1]).

Previously there was no common lib/ function that implemented
the necessary extension-checking semantics (and different syscalls
implemented them slightly differently or incompletely[2]). Future
patches replace common uses of this pattern to make use of
copy_struct_from_user().

[1]: commit 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
     robustify sched_read_attr() ABI logic and code")

[2]: For instance {sched_setattr,perf_event_open,clone3}(2) all do do
     similar checks to copy_struct_from_user() while rt_sigprocmask(2)
     always rejects differently-sized struct arguments.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/uaccess.h |  4 +++
 lib/Makefile            |  2 +-
 lib/strnlen_user.c      | 52 +++++++++++++++++++++++++++++
 lib/struct_user.c       | 73 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 lib/struct_user.c

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 34a038563d97..824569e309e4 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -230,6 +230,10 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
 
 #endif		/* ARCH_HAS_NOCACHE_UACCESS */
 
+extern int is_zeroed_user(const void __user *from, size_t count);
+extern int copy_struct_from_user(void *dst, size_t ksize,
+				 const void __user *src, size_t usize);
+
 /*
  * probe_kernel_read(): safely attempt to read from a location
  * @dst: pointer to the buffer that shall take the data
diff --git a/lib/Makefile b/lib/Makefile
index 29c02a924973..d86c71feaf0a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,7 +28,7 @@ endif
 CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
 endif
 
-lib-y := ctype.o string.o vsprintf.o cmdline.o \
+lib-y := ctype.o string.o struct_user.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o \
 	 sha1.o chacha.o irq_regs.o argv_split.o \
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 7f2db3fe311f..7eb665732954 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -123,3 +123,55 @@ long strnlen_user(const char __user *str, long count)
 	return 0;
 }
 EXPORT_SYMBOL(strnlen_user);
+
+/**
+ * is_zeroed_user: check if a userspace buffer is full of zeros
+ * @from:  Source address, in userspace.
+ * @size: Size of buffer.
+ *
+ * This is effectively shorthand for "memchr_inv(from, 0, size) == NULL" for
+ * userspace addresses. If there are non-zero bytes present then false is
+ * returned, otherwise true is returned.
+ *
+ * Returns:
+ *  * -EFAULT: access to userspace failed.
+ */
+int is_zeroed_user(const void __user *from, size_t size)
+{
+	u64 val;
+	uintptr_t align = (uintptr_t) from % 8;
+
+	if (unlikely(!size))
+		return true;
+
+	from -= align;
+	size += align;
+
+	if (!user_access_begin(from, size))
+		return -EFAULT;
+
+	while (size >= 8) {
+		unsafe_get_user(val, (u64 __user *) from, err_fault);
+		if (align) {
+			/* @from is unaligned. */
+			val &= ~aligned_byte_mask(align);
+			align = 0;
+		}
+		if (val)
+			goto done;
+		from += 8;
+		size -= 8;
+	}
+	if (size) {
+		/* (@from + @size) is unaligned. */
+		unsafe_get_user(val, (u64 __user *) from, err_fault);
+		val &= aligned_byte_mask(size);
+	}
+
+done:
+	user_access_end();
+	return (val == 0);
+err_fault:
+	user_access_end();
+	return -EFAULT;
+}
diff --git a/lib/struct_user.c b/lib/struct_user.c
new file mode 100644
index 000000000000..57d79eb53bfa
--- /dev/null
+++ b/lib/struct_user.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 SUSE LLC
+ * Copyright (C) 2019 Aleksa Sarai <cyphar@cyphar.com>
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+/**
+ * copy_struct_from_user: copy a struct from userspace
+ * @dst:   Destination address, in kernel space. This buffer must be @ksize
+ *         bytes long.
+ * @ksize: Size of @dst struct.
+ * @src:   Source address, in userspace.
+ * @usize: (Alleged) size of @src struct.
+ *
+ * Copies a struct from userspace to kernel space, in a way that guarantees
+ * backwards-compatibility for struct syscall arguments (as long as future
+ * struct extensions are made such that all new fields are *appended* to the
+ * old struct, and zeroed-out new fields have the same meaning as the old
+ * struct).
+ *
+ * @ksize is just sizeof(*dst), and @usize should've been passed by userspace.
+ * The recommended usage is something like the following:
+ *
+ *   SYSCALL_DEFINE2(foobar, const struct foo __user *, uarg, size_t, usize)
+ *   {
+ *      int err;
+ *      struct foo karg = {};
+ *
+ *      err = copy_struct_from_user(&karg, sizeof(karg), uarg, size);
+ *      if (err)
+ *        return err;
+ *
+ *      // ...
+ *   }
+ *
+ * There are three cases to consider:
+ *  * If @usize == @ksize, then it's copied verbatim.
+ *  * If @usize < @ksize, then the userspace has passed an old struct to a
+ *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @usize)
+ *    are to be zero-filled.
+ *  * If @usize > @ksize, then the userspace has passed a new struct to an
+ *    older kernel. The trailing bytes unknown to the kernel (@usize - @ksize)
+ *    are checked to ensure they are zeroed, otherwise -E2BIG is returned.
+ *
+ * Returns (in all cases, some data may have been copied):
+ *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes in @src.
+ *  * -EFAULT: access to userspace failed.
+ */
+int copy_struct_from_user(void *dst, size_t ksize,
+			  const void __user *src, size_t usize)
+{
+	size_t size = min(ksize, usize);
+	size_t rest = max(ksize, usize) - size;
+
+	/* Deal with trailing bytes. */
+	if (usize < ksize) {
+		memset(dst + size, 0, rest);
+	} else if (usize > ksize) {
+		int ret = is_zeroed_user(src + size, rest);
+		if (ret <= 0)
+			return ret ?: -E2BIG;
+	}
+	/* Copy the interoperable parts of the struct. */
+	if (copy_from_user(dst, src, size))
+		return -EFAULT;
+	return 0;
+}
-- 
2.23.0

