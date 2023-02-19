Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5652969BEE9
	for <lists+linux-api@lfdr.de>; Sun, 19 Feb 2023 08:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBSHeK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 19 Feb 2023 02:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBSHeH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 19 Feb 2023 02:34:07 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED34112846;
        Sat, 18 Feb 2023 23:33:39 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-171b38c1ef7so2353966fac.9;
        Sat, 18 Feb 2023 23:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlynQezfHAvAVV88tDFCiMn0mp/ma0Jf15lF8KMULwE=;
        b=dyzaeJeRkZ76kFwW87dY2/OjAQ4R6h3m+1H3Km8Y7hKcEyGTxRidR2F4qaKtakNY5B
         f8kgl8T9pPAOtVfS0RDmNVNSRA3vr6sgA9kLU9F/nIKmuOgq+IMe4p1/ILwZUDlT5puF
         TU5YxelzjYRB0iHQGcfX5LiMUGWj8I4BykJGd67Kq/kGoDX3rlqiJVjSS+FDKV1YrXsb
         idT5IWHKypLWcn9eox+CBgMmWcbeUCC5wU5D5FR2Dwmx+ExnwcERNcvkoDDBsPprCyOu
         JR8EIW0xm2/O3nOMCTU7fatgqwWx/uStu7h/EaYKVkd3WsWjf/Ne3pgv+Bkh8kFizpPb
         Dgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlynQezfHAvAVV88tDFCiMn0mp/ma0Jf15lF8KMULwE=;
        b=imzKhpeihkGNTZGuDjEgnR+728QzLvBo8UxI96zLSzs8FjeXVGWwdP46euiRz0E8U5
         0NyjnhH3nAoJcz/JBzpaOdErtfnv8Zymev5piCVHdu73yx2gk4kWwePJ7qb+5wVUzy29
         mqVHf0rMVFA5rSJXHS+2pxFq7g+98GDMrx1HgULYS1NSs+y/xlPafz8fOzTor6+vbmfE
         xPUPVkBc7eqYFd2a/Xc49SdRto5biyDFcA059vxmqUfnnWu9nN7fhEvsqAFtbqjl7J3G
         q2+jPzKIoPdZqHdOcnm+Gk5izOC+MZXDjizBLoFqQwj81mwmeOhU7KIcbBK0QBE1RQho
         tp8w==
X-Gm-Message-State: AO0yUKWg6NIXLVDfmn6sk+uEoDTQ3E+iHjS3GFvzb7vB0SRGLCVYKJ/4
        S0wuJYSoFu+D6EwvqT9SRtc=
X-Google-Smtp-Source: AK7set8JLXLRJKfS1MeXuyhs9cu2GQ+dZtxQx0E9qqmlzHa4FJWq8Np3khjO1v2BkuRq/ZqjerScZA==
X-Received: by 2002:a05:6870:8915:b0:16e:707f:db66 with SMTP id i21-20020a056870891500b0016e707fdb66mr7555582oao.17.1676792018893;
        Sat, 18 Feb 2023 23:33:38 -0800 (PST)
Received: from localhost (227.sub-174-197-65.myvzw.com. [174.197.65.227])
        by smtp.gmail.com with ESMTPSA id g18-20020a4ad852000000b0051fdb2cba97sm3749063oov.7.2023.02.18.23.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 23:33:38 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, arnd@arndb.de, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v10 2/3] cachestat: implement cachestat syscall
Date:   Sat, 18 Feb 2023 23:33:17 -0800
Message-Id: <20230219073318.366189-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230219073318.366189-1-nphamcs@gmail.com>
References: <20230219073318.366189-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

There is currently no good way to query the page cache state of large
file sets and directory trees. There is mincore(), but it scales poorly:
the kernel writes out a lot of bitmap data that userspace has to
aggregate, when the user really doesn not care about per-page
information in that case. The user also needs to mmap and unmap each
file as it goes along, which can be quite slow as well.

This patch implements a new syscall that queries cache state of a file
and summarizes the number of cached pages, number of dirty pages, number
of pages marked for writeback, number of (recently) evicted pages, etc.
in a given range. Currently, the syscall is only wired in for x86
architecture.

NAME
    cachestat - query the page cache statistics of a file.

SYNOPSIS
    #include <sys/mman.h>

    struct cachestat {
        __u64 nr_cache;
        __u64 nr_dirty;
        __u64 nr_writeback;
        __u64 nr_evicted;
        __u64 nr_recently_evicted;
    };

    int cachestat(unsigned int fd, size_t len, loff_t off,
        struct cachestat *cstat, unsigned int flags);

DESCRIPTION
    cachestat() queries the number of cached pages, number of dirty
    pages, number of pages marked for writeback, number of evicted
    pages, number of recently evicted pages, in the bytes range given by
    `off` and `len`.

    An evicted page is a page that is previously in the page cache but
    has been evicted since. A page is recently evicted if its last
    eviction was recent enough that its reentry to the cache would
    indicate that it is actively being used by the system, and that
    there is memory pressure on the system.

    These values are returned in a cachestat struct, whose address is
    given by the `cstat` argument.

    The `off` and `len` arguments must be non-negative integers. If
    `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
    0, we will query in the range from `off` to the end of the file.

    The `flags` argument is unused for now, but is included for future
    extensibility. User should pass 0 (i.e no flag specified).

RETURN VALUE
    On success, cachestat returns 0. On error, -1 is returned, and errno
    is set to indicate the error.

ERRORS
    EFAULT cstat points to an invalid address.

    EINVAL invalid offset or flags.

    EBADF  invalid file descriptor.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/compat.h                 |   4 +-
 include/linux/fs.h                     |   3 +
 include/linux/syscalls.h               |   3 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/mman.h              |   9 ++
 init/Kconfig                           |  10 ++
 kernel/sys_ni.c                        |   1 +
 mm/filemap.c                           | 158 +++++++++++++++++++++++++
 10 files changed, 193 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..01d1cc009250 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,4 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	cachestat		sys_cachestat		compat_sys_cachestat
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..227538b0ce80 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	cachestat		sys_cachestat

 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 594357881b0b..1c5d385be859 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -816,7 +816,9 @@ asmlinkage long compat_sys_sendmsg(int fd, struct compat_msghdr __user *msg,
 asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
 				   unsigned int flags);

-/* mm/filemap.c: No generic prototype for readahead */
+/* mm/filemap.c */
+asmlinkage long compat_sys_cachestat(int fd, size_t len, compat_arg_u64(off),
+		struct cachestat __user *cstat, unsigned int flags);

 /* security/keys/keyctl.c */
 asmlinkage long compat_sys_keyctl(u32 option,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f1651..83300f1491e7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -75,6 +75,7 @@ struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
 struct iomap_ops;
+struct cachestat;

 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -830,6 +831,8 @@ void filemap_invalidate_lock_two(struct address_space *mapping1,
 				 struct address_space *mapping2);
 void filemap_invalidate_unlock_two(struct address_space *mapping1,
 				   struct address_space *mapping2);
+void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
+		pgoff_t last_index, struct cachestat *cs);


 /*
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..9f384a6d7e77 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -72,6 +72,7 @@ struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
 enum landlock_rule_type;
+struct cachestat;

 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1056,6 +1057,8 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_cachestat(unsigned int fd, size_t len, loff_t offset,
+		struct cachestat __user *cstat, unsigned int flags);

 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..dc5fcfee7f09 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)

+#define __NR_cachestat 451
+__SC_COMP(__NR_cachestat, sys_cachestat, compat_sys_cachestat)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452

 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index f55bc680b5b0..fe03ed0b7587 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -4,6 +4,7 @@

 #include <asm/mman.h>
 #include <asm-generic/hugetlb_encode.h>
+#include <linux/types.h>

 #define MREMAP_MAYMOVE		1
 #define MREMAP_FIXED		2
@@ -41,4 +42,12 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB

+struct cachestat {
+	__u64 nr_cache;
+	__u64 nr_dirty;
+	__u64 nr_writeback;
+	__u64 nr_evicted;
+	__u64 nr_recently_evicted;
+};
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/init/Kconfig b/init/Kconfig
index 694f7c160c9c..da96ac29af1d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1798,6 +1798,16 @@ config RSEQ

 	  If unsure, say Y.

+config CACHESTAT_SYSCALL
+	bool "Enable cachestat() system call" if EXPERT
+	default y
+	help
+	  Enable the cachestat system call, which queries the page cache
+	  statistics of a file (number of cached pages, dirty pages,
+	  pages marked for writeback, (recently) evicted pages).
+
+	  If unsure say Y here.
+
 config DEBUG_RSEQ
 	default n
 	bool "Enabled debugging of rseq() system call" if EXPERT
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..04bfb1e4d377 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -299,6 +299,7 @@ COND_SYSCALL(set_mempolicy);
 COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
+COND_SYSCALL(cachestat);

 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/filemap.c b/mm/filemap.c
index 08341616ae7a..a00b5988d21c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/syscalls.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -55,6 +56,9 @@
 #include <linux/buffer_head.h> /* for try_to_free_buffers */

 #include <asm/mman.h>
+#include <uapi/linux/mman.h>
+
+#include "swap.h"

 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
@@ -3949,3 +3953,157 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 	return try_to_free_buffers(folio);
 }
 EXPORT_SYMBOL(filemap_release_folio);
+
+/**
+ * filemap_cachestat() - compute the page cache statistics of a mapping
+ * @mapping:	The mapping to compute the statistics for.
+ * @first_index:	The starting page cache index.
+ * @last_index:	The final page index (inclusive).
+ * @cs:	the cachestat struct to write the result to.
+ *
+ * This will query the page cache statistics of a mapping in the
+ * page range of [first_index, last_index] (inclusive). The statistics
+ * queried include: number of dirty pages, number of pages marked for
+ * writeback, and the number of (recently) evicted pages.
+ */
+void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
+		pgoff_t last_index, struct cachestat *cs)
+{
+	XA_STATE(xas, &mapping->i_pages, first_index);
+	struct folio *folio;
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, last_index) {
+		unsigned long nr_pages;
+		pgoff_t folio_first_index, folio_last_index;
+
+		if (xas_retry(&xas, folio))
+			continue;
+
+		nr_pages = folio_nr_pages(folio);
+		folio_first_index = folio_pgoff(folio);
+		folio_last_index = folio_first_index + nr_pages - 1;
+
+		/* Folios might straddle the range boundaries, only count covered subpages */
+		if (folio_first_index < first_index)
+			nr_pages -= first_index - folio_first_index;
+
+		if (folio_last_index > last_index)
+			nr_pages -= folio_last_index - last_index;
+
+		if (xa_is_value(folio)) {
+			/* page is evicted */
+			void *shadow = (void *)folio;
+			bool workingset; /* not used */
+
+			cs->nr_evicted += nr_pages;
+
+#ifdef CONFIG_SWAP /* implies CONFIG_MMU */
+			if (shmem_mapping(mapping)) {
+				/* shmem file - in swap cache */
+				swp_entry_t swp = radix_to_swp_entry(folio);
+
+				shadow = get_shadow_from_swap_cache(swp);
+			}
+#endif
+			if (workingset_test_recent(shadow, true, &workingset))
+				cs->nr_recently_evicted += nr_pages;
+
+			goto resched;
+		}
+
+		/* page is in cache */
+		cs->nr_cache += nr_pages;
+
+		if (folio_test_dirty(folio))
+			cs->nr_dirty += nr_pages;
+
+		if (folio_test_writeback(folio))
+			cs->nr_writeback += nr_pages;
+
+resched:
+		if (need_resched()) {
+			xas_pause(&xas);
+			cond_resched_rcu();
+		}
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(filemap_cachestat);
+
+#ifdef CONFIG_CACHESTAT_SYSCALL
+long ksys_cachestat(unsigned int fd, size_t len, loff_t off,
+		struct cachestat __user *cstat, unsigned int flags)
+{
+	struct fd f = fdget(fd);
+	struct address_space *mapping;
+	struct cachestat cs;
+	pgoff_t first_index = off >> PAGE_SHIFT;
+	pgoff_t last_index =
+		len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
+
+	if (!f.file)
+		return -EBADF;
+
+	if (off < 0 || flags != 0) {
+		fdput(f);
+		return -EINVAL;
+	}
+
+	memset(&cs, 0, sizeof(struct cachestat));
+	mapping = f.file->f_mapping;
+	filemap_cachestat(mapping, first_index, last_index, &cs);
+	fdput(f);
+
+	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/*
+ * The cachestat(5) system call.
+ *
+ * cachestat() returns the page cache statistics of a file in the
+ * bytes range specified by `off` and `len`: number of cached pages,
+ * number of dirty pages, number of pages marked for writeback,
+ * number of evicted pages, and number of recently evicted pages.
+ *
+ * An evicted page is a page that is previously in the page cache
+ * but has been evicted since. A page is recently evicted if its last
+ * eviction was recent enough that its reentry to the cache would
+ * indicate that it is actively being used by the system, and that
+ * there is memory pressure on the system.
+ *
+ * `off` and `len` must be non-negative integers. If `len` > 0,
+ * the queried range is [`off`, `off` + `len`]. If `len` == 0,
+ * we will query in the range from `off` to the end of the file.
+ *
+ * The `flags` argument is unused for now, but is included for future
+ * extensibility. User should pass 0 (i.e no flag specified).
+ *
+ * Because the status of a page can change after cachestat() checks it
+ * but before it returns to the application, the returned values may
+ * contain stale information.
+ *
+ * return values:
+ *  zero    - success
+ *  -EFAULT - cstat points to an illegal address
+ *  -EINVAL - invalid arguments
+ *  -EBADF	- invalid file descriptor
+ */
+SYSCALL_DEFINE5(cachestat, unsigned int, fd, size_t, len, loff_t, off,
+		struct cachestat __user *, cstat, unsigned int, flags)
+{
+	return ksys_cachestat(fd, len, off, cstat, flags);
+}
+
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,
+		compat_arg_u64_dual(off), struct cachestat __user *, cstat,
+		unsigned int, flags)
+{
+	return ksys_cachestat(fd, len, compat_arg_u64_glue(off), cstat, flags);
+}
+#endif
+#endif /* CONFIG_CACHESTAT_SYSCALL */
--
2.39.1
