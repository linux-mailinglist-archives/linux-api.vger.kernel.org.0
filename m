Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1377A1FAA6E
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 09:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFPHuX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 03:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPHts (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 03:49:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB1CC08C5C8
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 00:49:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so8831522pgo.9
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hymiFj42whdy2D05bhHghrqvNPgonrcbk2GbFm3EsyI=;
        b=f9r7BI5FO+bkXtD3hSIV/gO/wykpcs5Nzg5uxvgwjdkEuE1YiLJ6bjd62HL+z1G7wf
         9mJpAuojdEY7w8SJooynYRV1iiolNxDFS/JPxuueIwKEPebi8V9NBBP+WhY1V1A2Whbc
         r5Cq2o+4beGeb3ZnFnvnJTb4H0+uzqyzh9VZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hymiFj42whdy2D05bhHghrqvNPgonrcbk2GbFm3EsyI=;
        b=VYXj6Y7WteVCr7bGonHYgxYJ+KHx/OReCMkKP/BcgTozoXWp2P4IGNk0R9jSpkHFFo
         dsvfucpIyyLhRzMOkfyktgnWZpVR1TVLNy1BBsaChaFSqf18x7YiosUfHhRB5pejw+69
         Dl/j69QaTIHsadPabs+/fJ8YR0rQw4CvmH7xgPyO1Kvugu2g6IWpRROIX70tzgfM6ig2
         PQMBFirZJANz1EQCIz8Ip0uAwJ0lz82SbFiWhjY+DhkgDEWSiazOj8rqYjpsV5EU4QoC
         x38PGc5/p0ePtAiLc05vYccOUBJZozTcc6Vvt2lq4GoWamihWBE8vTluomtgmfTBzyyB
         8hYw==
X-Gm-Message-State: AOAM530PQem3CYlv+iZKD0Af4nC8gekUojlZOEF31JCGtkLieWu756LC
        aA8jpQQ1WZ8JVWGZtzEfUOZu6Q==
X-Google-Smtp-Source: ABdhPJyJE2ecymVAnnpMx8JwXvxakKaTc+cHmhmj6xoqwH9R6Zju+NCUJsZ1oJjUnMfzMDAdkGqUiA==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr1077179pfa.124.1592293786493;
        Tue, 16 Jun 2020 00:49:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 140sm16357711pfz.154.2020.06.16.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:49:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, x86@kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 4/8] seccomp: Implement constant action bitmaps
Date:   Tue, 16 Jun 2020 00:49:30 -0700
Message-Id: <20200616074934.1600036-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616074934.1600036-1-keescook@chromium.org>
References: <20200616074934.1600036-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

One of the most common pain points with seccomp filters has been dealing
with the overhead of processing the filters, especially for "always allow"
or "always reject" cases. While BPF is extremely fast[1], it will always
have overhead associated with it. Additionally, due to seccomp's design,
filters are layered, which means processing time goes up as the number
of filters attached goes up.

In the past, efforts have been focused on making filter execution complete
in a shorter amount of time. For example, filters were rewritten from
using linear if/then/else syscall search to using balanced binary trees,
or moving tests for syscalls common to the process's workload to the
front of the filter. However, there are limits to this, especially when
some processes are dealing with tens of filters[2], or when some
architectures have a less efficient BPF engine[3].

The most common use of seccomp, constructing syscall block/allow-lists,
where syscalls that are always allowed or always rejected (without regard
to any arguments), also tends to produce the most pathological runtime
problems, in that a large number of syscall checks in the filter need
to be performed to come to a determination.

In order to optimize these cases from O(n) to O(1), seccomp can
use bitmaps to immediately determine the desired action. A critical
observation in the prior paragraph bears repeating: the common case for
syscall tests do not check arguments. For any given filter, there is a
constant mapping from the combination of architecture and syscall to the
seccomp action result. (For kernels/architectures without CONFIG_COMPAT,
there is a single architecture.). As such, it is possible to construct
a mapping of arch/syscall to action, which can be updated as new filters
are attached to a process.

In order to build this mapping at filter attach time, each filter is
executed for every syscall (under each possible architecture), and
checked for any accesses of struct seccomp_data that are not the "arch"
nor "nr" (syscall) members. If only "arch" and "nr" are examined, then
there is a constant mapping for that syscall, and bitmaps can be updated
accordingly. If any accesses happen outside of those struct members,
seccomp must not bypass filter execution for that syscall, since program
state will be used to determine filter action result.

During syscall action probing, in order to determine whether other members
of struct seccomp_data are being accessed during a filter execution,
the struct is placed across a page boundary with the "arch" and "nr"
members in the first page, and everything else in the second page. The
"page accessed" flag is cleared in the second page's PTE, and the filter
is run. If the "page accessed" flag appears as set after running the
filter, we can determine that the filter looked beyond the "arch" and
"nr" members, and exclude that syscall from the constant action bitmaps.

For architectures to support this optimization, they must declare
their architectures for seccomp to see (via SECCOMP_ARCH and
SECCOMP_ARCH_COMPAT macros), and provide a way to perform efficient
CPU-local kernel TLB flushes (via local_flush_tlb_kernel_range()),
and then set HAVE_ARCH_SECCOMP_BITMAP in their Kconfig.

Areas needing more attention:

On x86, this currently adds 168 bytes (or 336 bytes under CONFIG_COMPAT)
to the size of task_struct. Allocating these on demand may be a better
use of memory, but may not result in good cache locality.

For architectures with "synthetic" architectures, like x86_x32,
additional work is needed. It should be possible to define a simple
mechanism based on the masking done in the x86 syscall entry path to
create another set of bitmaps for seccomp to key off of. I am, however,
considering just leaving HAVE_ARCH_SECCOMP_BITMAP depend on !X86_X32.

[1] https://lore.kernel.org/bpf/20200531171915.wsxvdjeetmhpsdv2@ast-mbp.dhcp.thefacebook.com/
[2] https://lore.kernel.org/bpf/20200601101137.GA121847@gardel-login/
[3] https://lore.kernel.org/bpf/717a06e7f35740ccb4c70470ec70fb2f@huawei.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig            |   7 ++
 include/linux/seccomp.h |  15 +++
 kernel/seccomp.c        | 227 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 246 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..4e692b7a4435 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -465,6 +465,13 @@ config SECCOMP_FILTER
 
 	  See Documentation/userspace-api/seccomp_filter.rst for details.
 
+config HAVE_ARCH_SECCOMP_BITMAP
+	bool
+	help
+	  An arch should select this symbol if it provides all of these things:
+	  - SECCOMP_ARCH (and SECCOMP_ARCH_COMPAT if appropriate)
+	  - local_flush_tlb_kernel_range()
+
 config HAVE_ARCH_STACKLEAK
 	bool
 	help
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 6525ddec177a..31ee2d6f4ec0 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -16,6 +16,17 @@
 #include <linux/atomic.h>
 #include <asm/seccomp.h>
 
+/* When no bits are set for a syscall, filters are run. */
+struct seccomp_bitmaps {
+#ifdef CONFIG_HAVE_ARCH_SECCOMP_BITMAP
+	/* "allow" are initialized to set and only ever get cleared. */
+	DECLARE_BITMAP(allow, NR_syscalls);
+	/* These are initialized to clear and only ever get set. */
+	DECLARE_BITMAP(kill_thread, NR_syscalls);
+	DECLARE_BITMAP(kill_process, NR_syscalls);
+#endif
+};
+
 struct seccomp_filter;
 /**
  * struct seccomp - the state of a seccomp'ed process
@@ -35,6 +46,10 @@ struct seccomp {
 #endif
 	atomic_t filter_count;
 	struct seccomp_filter *filter;
+	struct seccomp_bitmaps native;
+#ifdef CONFIG_COMPAT
+	struct seccomp_bitmaps compat;
+#endif
 };
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 43edf53c2d84..2fbe7d2260f7 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -44,6 +44,11 @@
 #include <linux/anon_inodes.h>
 #include <linux/lockdep.h>
 
+#ifdef CONFIG_HAVE_ARCH_SECCOMP_BITMAP
+#include <linux/pgtable.h>
+#include <asm/tlbflush.h>
+#endif
+
 enum notify_state {
 	SECCOMP_NOTIFY_INIT,
 	SECCOMP_NOTIFY_SENT,
@@ -476,6 +481,16 @@ static inline void seccomp_sync_threads(unsigned long flags)
 		atomic_set(&thread->seccomp.filter_count,
 			   atomic_read(&thread->seccomp.filter_count));
 
+		/* Copy syscall filter bitmaps. */
+		memcpy(&thread->seccomp.native,
+		       &caller->seccomp.native,
+		       sizeof(caller->seccomp.native));
+#ifdef CONFIG_COMPAT
+		memcpy(&thread->seccomp.compat,
+		       &caller->seccomp.compat,
+		       sizeof(caller->seccomp.compat));
+#endif
+
 		/*
 		 * Don't let an unprivileged task work around
 		 * the no_new_privs restriction by creating
@@ -578,6 +593,144 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 	return filter;
 }
 
+static inline bool sd_touched(pte_t *ptep)
+{
+	return !!pte_young(*(READ_ONCE(ptep)));
+}
+
+#ifdef CONFIG_HAVE_ARCH_SECCOMP_BITMAP
+/*
+ * We can build bitmaps only when an arch/nr combination reads nothing more
+ * that sd->nr and sd->arch, since those have a constant mapping to the
+ * syscall. To do this, we can run the filters for each syscall number, and
+ * examine the page table entry that is aligned to everything past sd->arch,
+ * checking for the ACCESSED flag.
+ *
+ * This approach could also be used to test for access to sd->arch too,
+ * if we wanted to warn about compat-unsafe filters.
+ */
+static void seccomp_update_bitmap(struct seccomp_filter *filter,
+				  void *pagepair, u32 arch,
+				  struct seccomp_bitmaps *bitmaps)
+{
+	struct seccomp_data *sd;
+	unsigned long vaddr;
+	u32 nr, ret;
+	pte_t *ptep;
+	u64 check;
+
+	/* Initialize bitmaps for first filter. */
+	if (!filter->prev)
+		bitmap_fill(bitmaps->allow, NR_syscalls);
+	/*
+	 * Prepare to detect memory accesses: find the PTE for the second page
+	 * in the page pair.
+	 */
+	vaddr = (unsigned long)(pagepair + PAGE_SIZE);
+	ptep = virt_to_kpte(vaddr);
+	/*
+	 * Split struct seccomp_data across two pages, with everything after
+	 * sd->arch (i.e. starting with sd->instruction_pointer), in the second
+	 * page of the page pair.
+	 */
+	sd = pagepair + PAGE_SIZE - offsetof(struct seccomp_data, instruction_pointer);
+
+	/* Mark the second page as untouched (i.e. "old") */
+	preempt_disable();
+	set_pte_at(&init_mm, vaddr, ptep, pte_mkold(*(READ_ONCE(ptep))));
+	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
+	preempt_enable();
+	/* Make sure the PTE agrees that it is untouched. */
+	if (WARN_ON_ONCE(sd_touched(ptep)))
+		return;
+	/* Read a portion of struct seccomp_data from the second page. */
+	check = sd->instruction_pointer;
+	/* First, verify the contents are zero from vzalloc(). */
+	if (WARN_ON_ONCE(check))
+		return;
+	/* Now make sure the ACCESSED bit has been set after the read. */
+	if (!sd_touched(ptep)) {
+		/*
+		 * If autodetection fails, fall back to standard beahavior by
+		 * clearing the entire "allow" bitmap.
+		 */
+		pr_warn_once("seccomp: cannot build automatic syscall filters\n");
+		bitmap_zero(bitmaps->allow, NR_syscalls);
+		return;
+	}
+
+	/*
+	 * For every syscall, if we don't already know we need to run
+	 * the full filter, simulate the filter with our static values.
+	 */
+	for (nr = 0; nr < NR_syscalls; nr++) {
+		/* Are we already at the maximal rejection state? */
+		if (test_bit(nr, bitmaps->kill_process))
+			continue;
+
+		sd->nr = nr;
+		sd->arch = arch;
+
+		/* Do we need to reset the ACCESSED bit? */
+		if (sd_touched(ptep)) {
+			preempt_disable();
+			set_pte_at(&init_mm, vaddr, ptep, pte_mkold(*(READ_ONCE(ptep))));
+			local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
+			preempt_enable();
+		}
+
+		/* Evaluate filter for this syscall. */
+		ret = bpf_prog_run_pin_on_cpu(filter->prog, sd);
+		/*
+		 * If this run through the filter didn't access
+		 * beyond "arch", we know the result is a constant
+		 * mapping for arch/nr -> ret.
+		 */
+		if (!sd_touched(ptep)) {
+			/* Constant evaluation. Mark appropriate bitmaps. */
+			switch (ret) {
+			case SECCOMP_RET_KILL_PROCESS:
+				set_bit(nr, bitmaps->kill_process);
+				break;
+			case SECCOMP_RET_KILL_THREAD:
+				set_bit(nr, bitmaps->kill_thread);
+				break;
+			default:
+				break;
+			case SECCOMP_RET_ALLOW:
+				/*
+				 * If we always map to allow, there are
+				 * no changes needed to the bitmaps.
+				 */
+				continue;
+			}
+		}
+
+		/*
+		 * Dynamic evaluation of syscall, or non-allow constant
+		 * mapping to something other than SECCOMP_RET_ALLOW: we
+		 * must not short-circuit-allow it anymore.
+		 */
+		clear_bit(nr, bitmaps->allow);
+	}
+}
+
+static void seccomp_update_bitmaps(struct seccomp_filter *filter,
+				   void *pagepair)
+{
+	seccomp_update_bitmap(filter, pagepair, SECCOMP_ARCH,
+			      &current->seccomp.native);
+#ifdef CONFIG_COMPAT
+	seccomp_update_bitmap(filter, pagepair, SECCOMP_ARCH_COMPAT,
+			      &current->seccomp.compat);
+#endif
+}
+#else
+static void seccomp_update_bitmaps(struct seccomp_filter *filter,
+				   void *pagepair)
+{ }
+#endif
+
 /**
  * seccomp_attach_filter: validate and attach filter
  * @flags:  flags to change filter behavior
@@ -591,7 +744,8 @@ seccomp_prepare_user_filter(const char __user *user_filter)
  *   - in NEW_LISTENER mode: the fd of the new listener
  */
 static long seccomp_attach_filter(unsigned int flags,
-				  struct seccomp_filter *filter)
+				  struct seccomp_filter *filter,
+				  void *pagepair)
 {
 	unsigned long total_insns;
 	struct seccomp_filter *walker;
@@ -630,6 +784,9 @@ static long seccomp_attach_filter(unsigned int flags,
 	current->seccomp.filter = filter;
 	atomic_inc(&current->seccomp.filter_count);
 
+	/* Evaluate filter for new known-outcome syscalls */
+	seccomp_update_bitmaps(filter, pagepair);
+
 	/* Now that the new filter is in place, synchronize to all threads. */
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
 		seccomp_sync_threads(flags);
@@ -857,6 +1014,56 @@ static int seccomp_do_user_notification(int this_syscall,
 	return -1;
 }
 
+#ifdef CONFIG_HAVE_ARCH_SECCOMP_BITMAP
+static inline bool __bypass_filter(struct seccomp_bitmaps *bitmaps,
+				   u32 nr, u32 *filter_ret)
+{
+	if (nr < NR_syscalls) {
+		if (test_bit(nr, current->seccomp.native.allow)) {
+			*filter_ret = SECCOMP_RET_ALLOW;
+			return true;
+		}
+		if (test_bit(nr, current->seccomp.native.kill_process)) {
+			*filter_ret = SECCOMP_RET_KILL_PROCESS;
+			return true;
+		}
+		if (test_bit(nr, current->seccomp.native.kill_thread)) {
+			*filter_ret = SECCOMP_RET_KILL_THREAD;
+			return true;
+		}
+	}
+	return false;
+}
+
+static inline u32 check_syscall(const struct seccomp_data *sd,
+				struct seccomp_filter **match)
+{
+	u32 filter_ret = SECCOMP_RET_KILL_PROCESS;
+
+#ifdef CONFIG_COMPAT
+	if (sd->arch == SECCOMP_ARCH) {
+#endif
+		if (__bypass_filter(&current->seccomp.native, sd->nr, &filter_ret))
+			return filter_ret;
+#ifdef CONFIG_COMPAT
+	} else if (sd->arch == SECCOMP_ARCH_COMPAT) {
+		if (__bypass_filter(&current->seccomp.compat, sd->nr, &filter_ret))
+			return filter_ret;
+	} else {
+		WARN_ON_ONCE(1);
+		return filter_ret;
+	}
+#endif
+	return seccomp_run_filters(sd, match);
+}
+#else
+static inline u32 check_syscall(const struct seccomp_data *sd,
+				struct seccomp_filter **match)
+{
+	return seccomp_run_filters(sd, match);
+}
+#endif
+
 static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 			    const bool recheck_after_trace)
 {
@@ -876,7 +1083,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 		sd = &sd_local;
 	}
 
-	filter_ret = seccomp_run_filters(sd, &match);
+	filter_ret = check_syscall(sd, &match);
 	data = filter_ret & SECCOMP_RET_DATA;
 	action = filter_ret & SECCOMP_RET_ACTION_FULL;
 
@@ -1346,6 +1553,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	long ret = -EINVAL;
 	int listener = -1;
 	struct file *listener_f = NULL;
+	void *pagepair;
 
 	/* Validate flags. */
 	if (flags & ~SECCOMP_FILTER_FLAG_MASK)
@@ -1391,12 +1599,24 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	    mutex_lock_killable(&current->signal->cred_guard_mutex))
 		goto out_put_fd;
 
+	/*
+	 * This memory will be needed for bitmap testing, but we'll
+	 * be holding a spinlock at that point. Do the allocation
+	 * (and free) outside of the lock.
+	 *
+	 * Alternative: we could do the bitmap update before attach
+	 * to avoid spending too much time under lock.
+	 */
+	pagepair = vzalloc(PAGE_SIZE * 2);
+	if (!pagepair)
+		goto out_put_fd;
+
 	spin_lock_irq(&current->sighand->siglock);
 
 	if (!seccomp_may_assign_mode(seccomp_mode))
 		goto out;
 
-	ret = seccomp_attach_filter(flags, prepared);
+	ret = seccomp_attach_filter(flags, prepared, pagepair);
 	if (ret)
 		goto out;
 	/* Do not free the successfully attached filter. */
@@ -1405,6 +1625,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	seccomp_assign_mode(current, seccomp_mode, flags);
 out:
 	spin_unlock_irq(&current->sighand->siglock);
+	vfree(pagepair);
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
 		mutex_unlock(&current->signal->cred_guard_mutex);
 out_put_fd:
-- 
2.25.1

