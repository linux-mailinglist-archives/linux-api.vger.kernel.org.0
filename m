Return-Path: <linux-api+bounces-6464-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGI9JqIiGmow1wgAu9opvQ
	(envelope-from <linux-api+bounces-6464-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2026 01:34:58 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75971609C90
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2026 01:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB1DF30298E8
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 23:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7FE3E5A2E;
	Fri, 29 May 2026 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2zelxXZ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF4B3CDBAA;
	Fri, 29 May 2026 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097629; cv=none; b=Nf1iCbQOf3YtWr1C/+8h2thXRA8cmPsxKfpp2q9AM/I89qWqP8vIYLSx8Y3eN8URwt6GW0rixgVJUIPz27Dv5v1yZp5VXxd9WkG4HMQA+eicIsq7zmoSqECq7tR9U1YMv+HWKuFfhf4W1kR7RIuIkCO2FRB5J8vqZ8dvWJmd2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097629; c=relaxed/simple;
	bh=b6+6c/VZ+E172jIwDrd2mUv5OAZvS4yOQTpwifWIa8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/5TMDEJWPBJhjFW5a9DwL6YwWJ8U9YOGcfUTR4vt5pBmNVhMnidC+JCZ7g7Le248rrJwoJNgEc7uIy8llQGd3VSe2zgMJRhcW/B3HgdZpWGgiNd2upudkiTEWVSSimghe/Wwhnzq6VkAmnmbsJt5LMCjCdfGNor/nCUaRM4mtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2zelxXZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594651F0089B;
	Fri, 29 May 2026 23:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097626;
	bh=rxZR8fNl/BxdvW6Xsew/4k8fTGgO3AxnPtUENX1h1jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2zelxXZHI67vwKv6UETdHZDGejPH0oqyUtJaj3LyESQ+HOOA+FABV14j/911YNdA
	 gzxrdO8wJc8OXq36VbPrd7q0/HGnwE4j3JUBQA2UTugdwmEnkqQqaW4/s7emzeNCN3
	 4DrnSmll0I6MoyAnDPax0+yXPoUkojYfERl9JNAW7Q9QddttDynC4ASES9lUQqB7s2
	 5X975fJGYGC5wN5VHcjqZsKzDG+71NElLQA+u7eRstIRWoF2HsBgeE2kvZP2uT6JBE
	 su4T48pPP75oHOtdYg/4jYRLpx0G0O7lKSO9w1x/MbdoOsdhkDJahf9x6NgQBRR6Hh
	 LtCJKbgAbpzew==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 10/11] kernel/api: add API specification for sys_madvise
Date: Fri, 29 May 2026 19:33:09 -0400
Message-ID: <20260529233311.1901670-11-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529233311.1901670-1-sashal@kernel.org>
References: <20260529233311.1901670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de,goodmis.org,efficios.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-6464-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 75971609C90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add KAPI-annotated kerneldoc for the sys_madvise system call in
mm/madvise.c.

The specification documents parameter constraints (start, len_in,
behavior), per-behavior error conditions, lock acquisition (mmap_lock
read and write modes plus the per-VMA fast path, mmu_gather and
mmu_notifier brackets), signal handling, side effects, capability
requirements (CAP_SYS_ADMIN for MADV_HWPOISON and MADV_SOFT_OFFLINE),
mseal interaction, and the heterogeneous skip semantics across the
hint, immediate-action and destructive groups.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 575 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 575 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index dbb69400786d1..ed0a046e9e25b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -2032,6 +2032,581 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	return error;
 }
 
+/**
+ * sys_madvise - Give advice about use of memory
+ * @start: Starting virtual address of the range to advise on
+ * @len_in: Length of the range in bytes
+ * @behavior: Advice (a MADV_* constant) the kernel should apply to the range
+ *
+ * long-desc: Provides the kernel with advice or directions about the address
+ *   range starting at start and extending for len_in bytes. The advice is
+ *   selected by behavior, which is one of the MADV_* constants defined in
+ *   <sys/mman.h>. The semantics fall into three groups. The hint group
+ *   primarily updates VMA flags (MADV_NORMAL, MADV_RANDOM, MADV_SEQUENTIAL,
+ *   MADV_DONTFORK, MADV_DOFORK, MADV_DONTDUMP, MADV_DODUMP, MADV_WIPEONFORK,
+ *   MADV_KEEPONFORK, MADV_MERGEABLE, MADV_UNMERGEABLE, MADV_HUGEPAGE,
+ *   MADV_NOHUGEPAGE), and is itself heterogeneous: the fork-copy gates
+ *   (MADV_DONTFORK / MADV_DOFORK) and the KSM scan gates
+ *   (MADV_MERGEABLE / MADV_UNMERGEABLE) are strictly honored by their
+ *   consumers; MADV_HUGEPAGE / MADV_NOHUGEPAGE express THP eligibility
+ *   advice rather than allocation guarantees (MADV_NOHUGEPAGE blocks the
+ *   normal fault-time, MADV_COLLAPSE and khugepaged paths; MADV_HUGEPAGE
+ *   widens eligibility and increases defrag aggressiveness but does not
+ *   force allocation, which still depends on the global
+ *   transparent_hugepage= mode, VMA suitability, and allocation success);
+ *   MADV_WIPEONFORK / MADV_KEEPONFORK do not wipe at fork time but cause
+ *   the child's first access to fault in zero-filled pages;
+ *   MADV_DONTDUMP / MADV_DODUMP normally control coredump inclusion but
+ *   can be overridden by always_dump_vma() for gate, vm_ops-named or
+ *   arch-named VMAs; and MADV_NORMAL / MADV_RANDOM / MADV_SEQUENTIAL are
+ *   genuinely heuristic read-ahead hints. The non-destructive
+ *   immediate-action group performs work
+ *   synchronously while preserving page contents (MADV_WILLNEED, MADV_COLD,
+ *   MADV_PAGEOUT, MADV_POPULATE_READ, MADV_POPULATE_WRITE, MADV_COLLAPSE,
+ *   MADV_GUARD_REMOVE). The destructive group discards, replaces or
+ *   invalidates page contents (MADV_DONTNEED, MADV_DONTNEED_LOCKED,
+ *   MADV_FREE, MADV_REMOVE, MADV_GUARD_INSTALL, MADV_HWPOISON,
+ *   MADV_SOFT_OFFLINE). MADV_GUARD_INSTALL belongs to the destructive group
+ *   because it zaps any existing pages in the range before installing PTE
+ *   guard markers.
+ *
+ *   start must be page-aligned; len_in is rounded up to the next page
+ *   boundary internally. Once those validation checks pass, a zero-length
+ *   range succeeds without performing work. The kernel rejects ranges that
+ *   wrap (start + PAGE_ALIGN(len_in) < start) and ranges where len_in is
+ *   non-zero but rounds down to zero. Address tagging bits are stripped
+ *   from start before VMA lookup for every behavior except MADV_HWPOISON
+ *   and MADV_SOFT_OFFLINE, which receive the raw start value because they
+ *   bypass the VMA walk entirely.
+ *
+ *   The kernel return value reports whether any error condition was
+ *   encountered, not whether the requested work was performed. The
+ *   relationship between the return code and the work done varies by
+ *   handler:
+ *
+ *     - Hint behaviors update VMA flags. The flags fall into five
+ *       sub-classes by how their consumers honor them:
+ *       (a) Hard gates -- MADV_DONTFORK / MADV_DOFORK strictly gate VMA
+ *       copy in dup_mmap(); MADV_MERGEABLE / MADV_UNMERGEABLE strictly
+ *       gate whether KSM will scan the VMA at all. These take effect
+ *       immediately and cannot be overridden by other policy.
+ *       (b) THP eligibility advice -- MADV_NOHUGEPAGE blocks the normal
+ *       fault-time, MADV_COLLAPSE and khugepaged THP paths for the VMA
+ *       (driver-internal PMD insertion via insert_pmd() is the only
+ *       documented bypass). MADV_HUGEPAGE only widens THP eligibility
+ *       under the kernel's "madvise" / "except-advised" policy and
+ *       increases defrag aggressiveness; it does not force allocation,
+ *       which still depends on the global transparent_hugepage= mode
+ *       (always / madvise / never), VMA suitability, defrag GFP policy,
+ *       and allocation or memcg-charge success.
+ *       (c) Fault-on-access -- MADV_WIPEONFORK / MADV_KEEPONFORK do not
+ *       wipe pages at fork time; instead the child VMA's pages are not
+ *       copied and the child sees zero-filled pages only when it first
+ *       reads or writes them.
+ *       (d) Mostly-strict with override -- MADV_DONTDUMP / MADV_DODUMP
+ *       control coredump inclusion via VM_DONTDUMP, but always_dump_vma()
+ *       can still include gate, vm_ops-named or arch-named VMAs in the
+ *       core regardless.
+ *       (e) Heuristic -- MADV_NORMAL / MADV_RANDOM / MADV_SEQUENTIAL set
+ *       VM_RAND_READ / VM_SEQ_READ as read-ahead hints that the read-ahead
+ *       code weighs against other policy and may diverge from at runtime.
+ *       In all five sub-classes the requested flag bits on the VMA are set;
+ *       what differs is the strength of the resulting downstream effect.
+ *
+ *     - Walk-and-skip handlers (MADV_COLD, MADV_PAGEOUT, MADV_FREE,
+ *       MADV_GUARD_REMOVE) traverse the range and silently skip pages or
+ *       PMDs that fail per-page preconditions (absent, special, device,
+ *       shared, non-LRU, unsplittable, locked, etc.), returning 0 even
+ *       when most or all pages were skipped.
+ *
+ *     - Bulk-backend handlers delegate the requested range to a single
+ *       backend call: MADV_DONTNEED and MADV_DONTNEED_LOCKED to
+ *       zap_page_range_single_batched(), MADV_REMOVE to vfs_fallocate(),
+ *       MADV_WILLNEED on regular files to vfs_fadvise(). The backend's
+ *       return is propagated for MADV_REMOVE and discarded for
+ *       MADV_WILLNEED; DAX files short-circuit MADV_WILLNEED entirely.
+ *
+ *     - Stop-on-error handlers (MADV_POPULATE_READ, MADV_POPULATE_WRITE,
+ *       MADV_SOFT_OFFLINE) walk the range but surface the first per-page
+ *       failure as an errno (-EHWPOISON, -EFAULT, -ENOMEM, ...) rather
+ *       than skipping silently.
+ *
+ *     - Hybrid handlers combine modes: MADV_WILLNEED walks for anonymous
+ *       and shmem ranges but bulk-calls vfs_fadvise() for regular files;
+ *       MADV_COLLAPSE walks PMD-by-PMD and tracks the last scan failure
+ *       so transient skips coexist with terminal errors;
+ *       MADV_GUARD_INSTALL walks to install markers and re-walks after
+ *       zap_page_range_single() to clear pre-existing pages, retrying up
+ *       to MAX_MADVISE_GUARD_RETRIES; MADV_HWPOISON walks pages but folds
+ *       memory_failure()'s -EOPNOTSUPP back to 0.
+ *
+ *   Applications that need to know whether a specific page was acted on
+ *   must verify the result through other means (e.g. /proc/[pid]/smaps,
+ *   page faults, read-after-write).
+ *
+ *   On success, madvise() returns 0; unlike read(2) and write(2) it has no
+ *   notion of partial completion at the syscall boundary. When the range
+ *   spans multiple VMAs, the kernel applies the advice to each in turn; an
+ *   unmapped gap inside the range causes the call to return -ENOMEM after
+ *   processing the mapped portions, rather than aborting at the gap.
+ *
+ *   POSIX defines posix_madvise(3) for a portable subset (POSIX_MADV_NORMAL,
+ *   _RANDOM, _SEQUENTIAL, _WILLNEED, _DONTNEED). Linux MADV_DONTNEED is
+ *   destructive: it discards the contents of the affected anonymous pages and
+ *   subsequent reads return zero. POSIX permits but does not require
+ *   destruction, so portable code that needs the POSIX semantics should use
+ *   posix_madvise(3) instead.
+ *
+ * contexts: process, sleepable
+ *
+ * param: start
+ *   type: uint, input
+ *   constraint-type: page_aligned
+ *   cdesc: Starting virtual address of the range. Must be aligned to
+ *     PAGE_SIZE. An unaligned start always returns -EINVAL, even when
+ *     len_in is zero. Address tag bits, where supported by the architecture,
+ *     are cleared via untagged_addr() before the range is interpreted, with
+ *     the exception of MADV_HWPOISON and MADV_SOFT_OFFLINE, which receive
+ *     the raw start value because they bypass the VMA walk.
+ *
+ * param: len_in
+ *   type: uint, input
+ *   constraint-type: range(0, SIZE_MAX)
+ *   cdesc: Length of the range in bytes. Internally rounded up to a multiple
+ *     of PAGE_SIZE. A len_in of 0 is accepted and the call is a no-op that
+ *     returns 0. A non-zero len_in that rounds up to 0 (i.e. wraps around)
+ *     returns -EINVAL, as does a range whose end (start + PAGE_ALIGN(len_in))
+ *     would wrap below start.
+ *
+ * param: behavior
+ *   type: int, input
+ *   cdesc: One of the MADV_* constants from <sys/mman.h>. See the long
+ *     description above for the full list and the three semantic groups
+ *     (hint, immediate-action, destructive). Behaviors gated by Kconfig
+ *     (KSM, transparent hugepage, memory failure) return -EINVAL when the
+ *     underlying support is disabled. A few architectures (notably alpha)
+ *     renumber values; portable code should always use the symbolic names.
+ *
+ * return:
+ *   type: int
+ *   check-type: exact
+ *   success: 0
+ *   desc: On success, returns 0. On error, returns a negative error code.
+ *     There is no partial-success indication; either the entire processed
+ *     range succeeded, or an error is returned and an unspecified prefix of
+ *     the range may have been advised.
+ *
+ * error: EINVAL, Invalid argument
+ *   desc: Returned for invalid input (unrecognised MADV_*, Kconfig-gated
+ *     behavior, unaligned start, range wrap, non-zero len_in rounding to
+ *     zero) and for per-behavior VMA-filter violations. The constraint:
+ *     blocks cover FREE, WIPEONFORK, REMOVE, COLD and PAGEOUT; inline
+ *     filters also reject DOFORK on VM_SPECIAL, KEEPONFORK on VM_DROPPABLE,
+ *     DODUMP on non-hugetlb VM_SPECIAL/VM_DROPPABLE, GUARD_* on VM_SPECIAL
+ *     or VM_HUGETLB, GUARD_INSTALL on VM_LOCKED. Also
+ *     returned by faultin_page_range() and madvise_collapse_errno().
+ *
+ * error: ENOMEM, Cannot allocate memory
+ *   desc: Some part of the requested range falls in a gap between mapped
+ *     VMAs; the kernel still applies the behavior to the mapped subranges
+ *     and only returns -ENOMEM after the walk completes. MADV_POPULATE_*
+ *     also returns -ENOMEM when the region has no VMA or when
+ *     faultin_page_range() exhausts memory. MADV_COLLAPSE returns -ENOMEM
+ *     when its struct collapse_control cannot be allocated up front, and
+ *     when madvise_collapse_errno() maps SCAN_ALLOC_HUGE_PAGE_FAIL (no
+ *     hugepage available) to -ENOMEM.
+ *
+ * error: EAGAIN, Resource temporarily unavailable
+ *   desc: For the VMA-flag-mutating behaviors, an internal -ENOMEM from VMA
+ *     splitting is translated to -EAGAIN before being returned to userspace,
+ *     advising the caller that a transient kernel resource shortage
+ *     prevented the update. Also returned by MADV_COLLAPSE via
+ *     madvise_collapse_errno() for transient scan failures (folio lock
+ *     contention, LRU isolation failure, dirty/writeback) where retrying
+ *     the call may succeed.
+ *
+ * error: EIO, Input/output error
+ *   desc: For MADV_REMOVE, an I/O error from the underlying filesystem's
+ *     FALLOC_FL_PUNCH_HOLE handler is propagated back as -EIO. MADV_WILLNEED
+ *     and MADV_PAGEOUT do not surface filesystem or device I/O errors:
+ *     vfs_fadvise() returns are discarded by madvise_willneed() and the
+ *     pageout walk is invoked through a void helper, so transient I/O
+ *     failures during read-ahead or page-out are silently dropped.
+ *
+ * error: EBADF, Bad file descriptor
+ *   desc: Returned by MADV_WILLNEED when applied to a non-file-backed VMA
+ *     and the kernel was built without CONFIG_SWAP, so there is neither a
+ *     file to read-ahead from nor a swap device to fault from.
+ *
+ * error: EACCES, Permission denied
+ *   desc: Returned by MADV_REMOVE when the target VMA is not a writable
+ *     shared mapping (vma_is_shared_maywrite() is false). Punching a hole in
+ *     a private or read-only shared mapping is not permitted; the operation
+ *     would either be invisible to other mappers or violate file permissions.
+ *
+ * error: EPERM, Operation not permitted
+ *   desc: Returned in two situations. First, MADV_HWPOISON and
+ *     MADV_SOFT_OFFLINE require CAP_SYS_ADMIN; the inject-error handler
+ *     refuses non-privileged callers. Second, on 64-bit kernels, a discard
+ *     operation (MADV_FREE, MADV_DONTNEED, MADV_DONTNEED_LOCKED, MADV_REMOVE,
+ *     MADV_DONTFORK, MADV_WIPEONFORK, MADV_GUARD_INSTALL) is refused on a
+ *     read-only anonymous VMA that has been sealed with mseal(2), to prevent
+ *     bypassing the seal by discarding mapped data.
+ *
+ * error: EINTR, Interrupted system call
+ *   desc: Returned when a fatal signal is delivered while the call is
+ *     waiting to acquire the mmap write lock for a VMA-flag-mutating
+ *     behavior (mmap_write_lock_killable() returns -EINTR), or when
+ *     MADV_POPULATE_READ/MADV_POPULATE_WRITE is interrupted while faulting
+ *     in pages (faultin_page_range() returns -EINTR). The single-shot
+ *     madvise() syscall is not automatically restarted by the signal
+ *     framework on this path; the caller must reissue the request if
+ *     desired.
+ *
+ * error: EHWPOISON, Memory page has hardware error
+ *   desc: MADV_POPULATE_READ or MADV_POPULATE_WRITE encountered a page that
+ *     has been marked as containing a hardware-detected memory error and
+ *     could not be faulted in.
+ *
+ * error: EFAULT, Bad address
+ *   desc: MADV_POPULATE_READ or MADV_POPULATE_WRITE attempted to fault in a
+ *     page whose mapping raised VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV (for
+ *     example, a file-backed page beyond the end of the file).
+ *
+ * error: EBUSY, Device or resource busy
+ *   desc: Returned by MADV_COLLAPSE via madvise_collapse_errno() in two
+ *     specific scan-failure modes: SCAN_CGROUP_CHARGE_FAIL (the new
+ *     hugepage cannot be charged to the memory cgroup) and
+ *     SCAN_EXCEED_NONE_PTE (too many absent PTEs in the candidate range
+ *     for a synchronous collapse). Other transient collapse failures are
+ *     reported as -EAGAIN; non-transient ones as -EINVAL.
+ *
+ * lock: mm->mmap_lock (read mode)
+ *   type: rwlock
+ *   acquired: yes
+ *   released: yes
+ *   desc: Held on entry to the VMA walk for MADV_REMOVE, MADV_WILLNEED,
+ *     MADV_COLD, MADV_PAGEOUT and MADV_COLLAPSE, and as the fallback when
+ *     the per-VMA fast path declines. Several handlers drop and reacquire
+ *     this lock mid-operation: MADV_WILLNEED on a file-backed VMA and
+ *     MADV_REMOVE around their vfs_fadvise() / vfs_fallocate() callouts;
+ *     MADV_COLLAPSE on file-backed ranges around the page migration
+ *     pipeline; MADV_POPULATE_* (dispatched directly to madvise_populate())
+ *     around each faultin_page_range() call, which may itself drop the
+ *     lock internally before returning.
+ *
+ * lock: mm->mmap_lock (write mode; killable)
+ *   type: rwlock
+ *   acquired: yes
+ *   released: yes
+ *   desc: Acquired in killable write mode for behaviors that modify
+ *     vma->vm_flags or split/merge VMAs (MADV_NORMAL, MADV_RANDOM,
+ *     MADV_SEQUENTIAL, MADV_DONTFORK, MADV_DOFORK, MADV_DONTDUMP, MADV_DODUMP,
+ *     MADV_WIPEONFORK, MADV_KEEPONFORK, MADV_MERGEABLE, MADV_UNMERGEABLE,
+ *     MADV_HUGEPAGE, MADV_NOHUGEPAGE). If the acquisition is killed by a
+ *     fatal signal, the syscall returns -EINTR before any VMA is touched.
+ *
+ * lock: per-VMA read lock (vma->vm_lock)
+ *   type: custom
+ *   acquired: yes
+ *   released: yes
+ *   desc: Tried first for MADV_DONTNEED, MADV_DONTNEED_LOCKED, MADV_FREE,
+ *     MADV_GUARD_INSTALL and MADV_GUARD_REMOVE via lock_vma_under_rcu(). The
+ *     per-VMA path is taken only when the requested range fits within a
+ *     single VMA, the target mm is the caller's mm, the VMA is not armed
+ *     with userfaultfd, and (for behaviors that establish page tables) an
+ *     anon_vma is already attached. Otherwise the code falls back to the
+ *     mmap read lock above.
+ *
+ * lock: mmu_gather TLB batch
+ *   type: custom
+ *   acquired: yes
+ *   released: yes
+ *   desc: For MADV_DONTNEED, MADV_DONTNEED_LOCKED and MADV_FREE the syscall
+ *     wraps the per-VMA work in tlb_gather_mmu() / tlb_finish_mmu() so PTE
+ *     clearing and TLB invalidation are batched. MADV_COLD and MADV_PAGEOUT
+ *     build a short-lived gather inside the handler. MADV_GUARD_INSTALL
+ *     builds a transient gather via zap_page_range_single() each time the
+ *     retry loop has to clear pre-existing pages; if the range is already
+ *     empty no gather is built. MADV_GUARD_REMOVE never zaps and never
+ *     gathers.
+ *
+ * lock: mmu_notifier invalidate range
+ *   type: custom
+ *   acquired: yes
+ *   released: yes
+ *   desc: All zap-based paths -- MADV_DONTNEED, MADV_DONTNEED_LOCKED, the
+ *     zap branch of MADV_GUARD_INSTALL via zap_page_range_single(), and
+ *     MADV_FREE's own walk -- bracket their work with
+ *     mmu_notifier_invalidate_range_start()/_end() so secondary MMUs (KVM,
+ *     IOMMUv2, etc.) observe the page clearing.
+ *
+ * signal: Any fatal signal
+ *   direction: receive
+ *   action: return
+ *   condition: Acquiring the mmap write lock or faulting in pages for
+ *     MADV_POPULATE_*
+ *   desc: A pending fatal signal aborts mmap_write_lock_killable() (used by
+ *     the VMA-flag-mutating behaviors) and faultin_page_range() (used by
+ *     MADV_POPULATE_READ and MADV_POPULATE_WRITE), in both cases surfacing as
+ *     -EINTR to userspace. The single-shot madvise() syscall does not request
+ *     transparent restart on these paths; the caller is expected to reissue
+ *     the call if appropriate.
+ *   errno: -EINTR
+ *   timing: during
+ *   restartable: no
+ *
+ * side-effect: modify_state
+ *   target: vma->vm_flags
+ *   condition: Hint-group behaviors (MADV_NORMAL, MADV_RANDOM, MADV_SEQUENTIAL,
+ *     MADV_DONTFORK, MADV_DOFORK, MADV_DONTDUMP, MADV_DODUMP, MADV_WIPEONFORK,
+ *     MADV_KEEPONFORK, MADV_MERGEABLE, MADV_UNMERGEABLE, MADV_HUGEPAGE,
+ *     MADV_NOHUGEPAGE)
+ *   desc: Sets or clears VM_RAND_READ, VM_SEQ_READ, VM_DONTCOPY, VM_DONTDUMP,
+ *     VM_WIPEONFORK, VM_MERGEABLE or VM_HUGEPAGE on the affected VMAs and may
+ *     split or merge VMAs to apply the change to a sub-range. The change is
+ *     reversible by issuing madvise() with the inverse advice (e.g.
+ *     MADV_DOFORK undoes MADV_DONTFORK), with the caveat that the inverse
+ *     call's per-VMA filter still applies: MADV_DOFORK rejects VM_SPECIAL,
+ *     MADV_DODUMP rejects non-hugetlb VM_SPECIAL or VM_DROPPABLE, and
+ *     MADV_KEEPONFORK rejects VM_DROPPABLE; for those classes of VMA the
+ *     inverse cannot complete.
+ *   reversible: yes
+ *
+ * side-effect: free_memory | modify_state | irreversible
+ *   target: page tables and resident pages within the range
+ *   condition: MADV_DONTNEED, MADV_DONTNEED_LOCKED, MADV_FREE
+ *   desc: MADV_DONTNEED zaps PTEs, releasing the underlying pages or swap
+ *     slots so the next access faults in zero-filled anonymous pages or
+ *     re-reads the file. MADV_DONTNEED_LOCKED is identical but tolerates
+ *     VM_LOCKED. MADV_FREE marks anonymous pages lazy-freeable: clean pages
+ *     may be reclaimed under memory pressure, while writes before
+ *     reclamation cancel the lazy-free. Discarded data cannot be recovered.
+ *   reversible: no
+ *
+ * side-effect: filesystem | irreversible
+ *   target: backing file (FALLOC_FL_PUNCH_HOLE)
+ *   condition: MADV_REMOVE
+ *   desc: Calls vfs_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE) on
+ *     the backing file, deallocating the corresponding file blocks. The hole
+ *     is visible to all mappers of the file and to read(2)/write(2)
+ *     callers; subsequent reads return zero. Filesystem freeze protection,
+ *     i_rwsem and any quota/space accounting are taken by the underlying
+ *     fallocate path.
+ *   reversible: no
+ *
+ * side-effect: modify_state | schedule
+ *   target: LRU lists and page reclaim
+ *   condition: MADV_COLD, MADV_PAGEOUT
+ *   desc: MADV_COLD deactivates the affected pages, moving them to the
+ *     inactive LRU and clearing PG_referenced/PG_young so they are reclaimed
+ *     sooner under pressure. MADV_PAGEOUT additionally calls reclaim_pages()
+ *     to write dirty pages out and drop clean ones synchronously. Page data
+ *     is preserved (rereads will fault in the same content), but the I/O and
+ *     LRU bookkeeping cannot be undone.
+ *   reversible: no
+ *
+ * side-effect: modify_state
+ *   target: page tables (faultin)
+ *   condition: MADV_POPULATE_READ, MADV_POPULATE_WRITE
+ *   desc: Walks the requested range with faultin_page_range(), populating
+ *     PTEs by triggering read or write faults so subsequent accesses do not
+ *     fault. Equivalent to touching every page in the range while suppressing
+ *     SIGBUS/SIGSEGV through the syscall return value. Allocations made by
+ *     faultin are not undone on partial failure.
+ *   reversible: no
+ *
+ * side-effect: modify_state | schedule
+ *   target: transparent hugepage layout
+ *   condition: MADV_COLLAPSE
+ *   desc: Synchronously coalesces base pages in the range into a PMD-sized
+ *     transparent hugepage when the mapping permits. Performs the same page
+ *     migration and zeroing that khugepaged would do asynchronously; the
+ *     range's data is preserved across the collapse.
+ *   reversible: no
+ *
+ * side-effect: free_memory | modify_state | irreversible
+ *   target: PTE marker (PTE_MARKER_GUARD)
+ *   condition: MADV_GUARD_INSTALL, MADV_GUARD_REMOVE
+ *   desc: MADV_GUARD_INSTALL installs PTE_MARKER_GUARD entries that cause
+ *     subsequent accesses to deliver SIGSEGV without consuming physical
+ *     memory; existing pages already mapped in the range are zapped via
+ *     zap_page_range_single() before the markers are installed, so any
+ *     prior contents are lost. MADV_GUARD_REMOVE clears the markers but
+ *     does not (and cannot) restore zapped data.
+ *   reversible: no
+ *
+ * side-effect: hardware | irreversible
+ *   target: physical page (memory_failure / soft_offline_page)
+ *   condition: MADV_HWPOISON, MADV_SOFT_OFFLINE
+ *   desc: MADV_HWPOISON marks the affected pages as containing an
+ *     unrecoverable hardware error using the same machine-check path that
+ *     real ECC failures take; MADV_SOFT_OFFLINE migrates the contents off
+ *     the affected pages and removes them from the buddy allocator. Both
+ *     paths affect physical memory bookkeeping kernel-wide and cannot be
+ *     undone without a reboot. Intended for testing the memory-failure
+ *     pipeline; restricted to CAP_SYS_ADMIN.
+ *   reversible: no
+ *
+ * side-effect: modify_state
+ *   target: KSM merge state (vm_flags & VM_MERGEABLE)
+ *   condition: MADV_MERGEABLE, MADV_UNMERGEABLE
+ *   desc: Toggles the VMA's eligibility for the kernel same-page merger.
+ *     Enabling merging may later cause identical anonymous pages to be
+ *     replaced by shared, write-protected copies; disabling merging tears
+ *     any existing merges down lazily. The flag toggle itself is reversible
+ *     by issuing the inverse advice.
+ *   reversible: yes
+ *
+ * side-effect: modify_state
+ *   target: userfaultfd event queue
+ *   condition: MADV_DONTNEED, MADV_DONTNEED_LOCKED, MADV_FREE, MADV_REMOVE
+ *     on a userfaultfd-armed VMA
+ *   desc: Generates a UFFD_EVENT_REMOVE notification covering the discarded
+ *     range so userfaultfd monitors observing the mapping see the
+ *     invalidation. The event is queued before the discard takes effect; the
+ *     monitor cannot veto it.
+ *   reversible: no
+ *
+ * capability: CAP_SYS_ADMIN
+ *   type: perform_operation
+ *   allows: Inject memory errors via MADV_HWPOISON or MADV_SOFT_OFFLINE
+ *   without: Both behaviors return -EPERM
+ *   condition: Checked at entry to madvise_inject_error() before any pages
+ *     are looked up
+ *
+ * constraint: Page-aligned start
+ *   desc: start must lie on a page boundary; otherwise the call returns
+ *     -EINVAL before any VMA is consulted.
+ *   expr: (start & (PAGE_SIZE - 1)) == 0
+ *
+ * constraint: Length rounded up to PAGE_SIZE
+ *   desc: The effective range length is PAGE_ALIGN(len_in). A non-zero len_in
+ *     that overflows during rounding, or a (start, end) range that wraps,
+ *     is rejected with -EINVAL.
+ *   expr: end = start + PAGE_ALIGN(len_in); end >= start
+ *
+ * constraint: Behavior must be supported
+ *   desc: behavior must be one of the MADV_* values listed under the
+ *     behavior parameter. Behaviors gated by Kconfig (KSM, THP, memory
+ *     failure) are rejected with -EINVAL when the corresponding option is
+ *     disabled in the running kernel.
+ *
+ * constraint: mseal-protected discards
+ *   desc: On 64-bit kernels, a discard operation (FREE, DONTNEED,
+ *     DONTNEED_LOCKED, REMOVE, DONTFORK, WIPEONFORK, GUARD_INSTALL) against
+ *     a sealed anonymous VMA is rejected unless the mapping is currently
+ *     writable -- both VM_WRITE in vm_flags and arch_vma_access_permitted()
+ *     allowing write -- so that mseal(2) cannot be bypassed by instructing
+ *     the kernel to throw the data away. File-backed sealed VMAs and
+ *     writable sealed VMAs are not subject to this restriction.
+ *   expr: !is_discard(behavior) || !vma_is_sealed(vma) ||
+ *     !vma_is_anonymous(vma) || ((vma->vm_flags & VM_WRITE) &&
+ *     arch_vma_access_permitted(vma, true, false, false))
+ *
+ * constraint: MADV_FREE requires anonymous mappings
+ *   desc: MADV_FREE is defined only over anonymous mappings; the handler
+ *     rejects file-backed VMAs with -EINVAL.
+ *   expr: vma_is_anonymous(vma)
+ *
+ * constraint: MADV_WIPEONFORK requires private anonymous mappings
+ *   desc: MADV_WIPEONFORK rejects file-backed mappings and shared anonymous
+ *     mappings; only MAP_PRIVATE anonymous VMAs accept it. Both rejections
+ *     surface as -EINVAL.
+ *   expr: !vma->vm_file && !(vma->vm_flags & VM_SHARED)
+ *
+ * constraint: MADV_REMOVE requires a writable shared file mapping
+ *   desc: MADV_REMOVE rejects VM_LOCKED VMAs, VMAs without an associated
+ *     file/mapping/host inode, and non-shared-writable mappings. The first
+ *     two cases return -EINVAL; a private or read-only shared mapping
+ *     returns -EACCES.
+ *   expr: !(vma->vm_flags & VM_LOCKED) && vma->vm_file &&
+ *     vma->vm_file->f_mapping && vma->vm_file->f_mapping->host &&
+ *     vma_is_shared_maywrite(vma)
+ *
+ * constraint: MADV_COLD / MADV_PAGEOUT VMA filter
+ *   desc: Both behaviors require LRU-managed pages; they reject VMAs that
+ *     are mlocked, raw-PFN or hugetlb.
+ *   expr: !(vma->vm_flags & (VM_LOCKED | VM_PFNMAP | VM_HUGETLB))
+ *
+ * examples: madvise(p, len, MADV_SEQUENTIAL);  // set VM_SEQ_READ on the VMA
+ *   madvise(p, len, MADV_POPULATE_WRITE);  // prefault writable PTEs
+ *   madvise(p, len, MADV_DONTNEED);        // discard anonymous pages
+ *   madvise(p, len, MADV_GUARD_INSTALL);   // install SIGSEGV guard pages
+ *
+ * notes: madvise(2) reports only whether an error condition was
+ *   encountered, not whether the requested work was performed. The hint
+ *   group sets VMA flags whose downstream strictness varies:
+ *   MADV_DONTFORK / MADV_DOFORK and MADV_MERGEABLE / MADV_UNMERGEABLE are
+ *   hard gates honored by fork-copy and KSM scanning respectively;
+ *   MADV_NOHUGEPAGE is a hard gate against the normal user-visible THP
+ *   paths but MADV_HUGEPAGE is eligibility/advice that does not force
+ *   THP installation -- the global transparent_hugepage= mode, VMA
+ *   suitability and allocation success still apply; MADV_WIPEONFORK /
+ *   MADV_KEEPONFORK take effect at the child's first page access
+ *   (zero-on-fault), not at fork time; MADV_DONTDUMP / MADV_DODUMP gate
+ *   coredump inclusion but can be overridden by always_dump_vma();
+ *   MADV_NORMAL / MADV_RANDOM / MADV_SEQUENTIAL are heuristic read-ahead
+ *   hints that the read-ahead code may weigh against other policy. The
+ *   non-hint behaviors
+ *   are not uniform: walk-and-skip handlers (COLD, PAGEOUT, FREE,
+ *   GUARD_REMOVE) silently skip pages that fail per-page preconditions;
+ *   bulk-backend handlers (DONTNEED, DONTNEED_LOCKED, REMOVE, and
+ *   WILLNEED on regular files) delegate the range to a single backend
+ *   call whose return is propagated for REMOVE and discarded for
+ *   WILLNEED; stop-on-error handlers (POPULATE_READ, POPULATE_WRITE,
+ *   SOFT_OFFLINE) surface the first per-page failure rather than
+ *   skipping; and hybrid handlers (WILLNEED for anon/shmem, COLLAPSE,
+ *   GUARD_INSTALL, HWPOISON) mix walking with bulk backends, retry/zap
+ *   loops or selective error suppression. A successful return therefore
+ *   guarantees only that no error was raised in the handler that ran,
+ *   not that every page was processed.
+ *
+ *   Behavior introduction history (mainline): MADV_FREE in 4.5,
+ *   MADV_WIPEONFORK / MADV_KEEPONFORK in 4.14, MADV_COLD / MADV_PAGEOUT in
+ *   5.4, MADV_POPULATE_READ / MADV_POPULATE_WRITE in 5.14,
+ *   MADV_DONTNEED_LOCKED in 5.18, MADV_COLLAPSE in 6.1, MADV_GUARD_INSTALL /
+ *   MADV_GUARD_REMOVE in 6.13. Code that wants to remain portable to older
+ *   kernels must handle -EINVAL gracefully and fall back.
+ *
+ *   process_madvise(2) extends the same set of advices to another process
+ *   identified by a pidfd. When the target mm is the caller's own (the
+ *   pidfd refers to the caller), any locally-supported MADV_* value is
+ *   accepted. When the target is a different mm, the behavior must be in
+ *   the non-destructive remote subset (MADV_COLD, MADV_PAGEOUT,
+ *   MADV_WILLNEED, MADV_COLLAPSE) or the call returns -EINVAL, and the
+ *   caller must hold CAP_SYS_NICE.
+ *
+ *   The discard subset (MADV_FREE, MADV_DONTNEED, MADV_DONTNEED_LOCKED,
+ *   MADV_REMOVE, MADV_DONTFORK, MADV_WIPEONFORK, MADV_GUARD_INSTALL) is
+ *   refused on non-writable anonymous VMAs sealed with mseal(2) on 64-bit
+ *   kernels. mseal(2) does not provide an unseal operation, so applications
+ *   that need to retain the ability to discard such pages must keep the
+ *   mapping writable (and arch-accessible for write) or refrain from
+ *   sealing it.
+ *
+ *   On a userfaultfd-armed VMA, all four destructive discards (DONTNEED,
+ *   DONTNEED_LOCKED, FREE, REMOVE) emit a UFFD_EVENT_REMOVE event; the
+ *   per-VMA fast path is bypassed and the syscall falls back to the
+ *   heavier mmap_read_lock so the userfaultfd monitor is consulted before
+ *   the discard takes effect.
+ *
+ *   MADV_GUARD_INSTALL retries up to MAX_MADVISE_GUARD_RETRIES (3) times
+ *   when it loses races with concurrent faulting or khugepaged. If those
+ *   retries are exhausted the handler returns -ERESTARTNOINTR via
+ *   restart_syscall(); the kernel's syscall return path treats this as a
+ *   transparent restart of madvise() and re-enters the call with the same
+ *   arguments. The transparent restart is unconditional and is not driven
+ *   by signal delivery, so the caller never observes an errno from this
+ *   path and the call appears to make eventual forward progress.
+ *   anon_vma_prepare() failures inside MADV_GUARD_INSTALL bypass the
+ *   ENOMEM-to-EAGAIN translation that applies to the VMA-flag-mutating
+ *   behaviors and surface as -ENOMEM directly.
+ *
+ *   Architecture note: alpha defines MADV_DONTNEED as 6 (not 4) and reserves
+ *   MADV_SPACEAVAIL=5; portable code must use the symbolic names from
+ *   <sys/mman.h>.
+ */
 SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
 	return do_madvise(current->mm, start, len_in, behavior);
-- 
2.53.0


