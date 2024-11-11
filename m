Return-Path: <linux-api+bounces-2697-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3069C49D3
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 00:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F046D2897A4
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2024 23:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257E61BDA85;
	Mon, 11 Nov 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="aSJU6C6g"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B31AA7AF
	for <linux-api@vger.kernel.org>; Mon, 11 Nov 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368449; cv=none; b=c6AJZCyHQ5mDnX3f+ohm4Wh56oyPIMnMgWAzb7pat85AzwvJ8YFQVXb1JSTH+I5npM8DaRa4Sy62pr81P6bCVyUh2idoFWppeP5cAwftcL7iHXOjxVBNilxQvY57EU8KkN7Vz1sN8aE5Jsd+1WHqwgWLFUc9TdJhZVt2X1ctZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368449; c=relaxed/simple;
	bh=ufu+wJtbjtEOoH8Hv+Jn/m3B/aJT2g5MckLJrXycy9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dK1M7oJonYl1wfzzvB+XD6ZaGVhQm34OBVThsq7Vi6jJVedwvXQoYaCJkSAZR6EECzr9yiTySEi9+YiT3hcKjtYIfT4C4EfD8R1mL+xXPEfxFeaC09yJbzv4A2d0FRuHwZH07kKoVKIVPih/fglsOwyPO+f7PyrhYRUa/dE8Bgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=aSJU6C6g; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zwIOJtwVBoMWW44quPjlmJojB9nnT/SUAdempJvepm8=; t=1731368446; x=1732232446; 
	b=aSJU6C6g0uDoSlscujGJyZP2v+pvxnWiwrLpYrx80DZA3rohFx0Wq2vmMmCFA9Iw/HqvD9MaH5O
	uudKsCZyEDvEq3U8x7Ysqjfqdb9XFklNWvS75u+x+dlYA7Jl/VIfkls3HApLUBM9RckIWaTYoC33W
	ibALZg+odupHP+07T0zc9qWYf4XuSc93l2qPIH8mx47navR8+j9kCd4NandrdRnX+aY329h78z37G
	zZ7UIMmGZlKt2LoyWJVvz5IIE6wZsGZfct+oHEgiO6jAT/vG3chwLBUPWQH2ZTd78NPLNxdxP5EA3
	dZtFbrOthTgE08S6lwlkJv+0GnOCigCkqq1w==;
Received: from ouster448.stanford.edu ([172.24.72.71]:54467 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tAe1U-0002NP-Tc; Mon, 11 Nov 2024 15:40:46 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v2 04/12] net: homa: create homa_pool.h and homa_pool.c
Date: Mon, 11 Nov 2024 15:39:57 -0800
Message-ID: <20241111234006.5942-5-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241111234006.5942-1-ouster@cs.stanford.edu>
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 5d4d7bb02bad719eb6b7853edc1469aa

These files implement Homa's mechanism for managing application-level
buffer space for incoming messages This mechanism is needed to allow
Homa to copy data out to user space in parallel with receiving packets;
it was discussed in a talk at NetDev 0x17.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_pool.c | 420 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_pool.h | 152 ++++++++++++++++
 2 files changed, 572 insertions(+)
 create mode 100644 net/homa/homa_pool.c
 create mode 100644 net/homa/homa_pool.h

diff --git a/net/homa/homa_pool.c b/net/homa/homa_pool.c
new file mode 100644
index 000000000000..4d166eb4ac19
--- /dev/null
+++ b/net/homa/homa_pool.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+#include "homa_impl.h"
+#include "homa_pool.h"
+
+/* This file contains functions that manage user-space buffer pools. */
+
+/* Pools must always have at least this many bpages (no particular
+ * reasoning behind this value).
+ */
+#define MIN_POOL_SIZE 2
+
+/* Used when determining how many bpages to consider for allocation. */
+#define MIN_EXTRA 4
+
+/**
+ * set_bpages_needed() - Set the bpages_needed field of @pool based
+ * on the length of the first RPC that's waiting for buffer space.
+ * The caller must own the lock for @pool->hsk.
+ * @pool: Pool to update.
+ */
+static void set_bpages_needed(struct homa_pool *pool)
+{
+	struct homa_rpc *rpc = list_first_entry(&pool->hsk->waiting_for_bufs,
+			struct homa_rpc, buf_links);
+	pool->bpages_needed = (rpc->msgin.length + HOMA_BPAGE_SIZE - 1)
+			>> HOMA_BPAGE_SHIFT;
+}
+
+/**
+ * homa_pool_init() - Initialize a homa_pool; any previous contents of the
+ * objects are overwritten.
+ * @hsk:          Socket containing the pool to initialize.
+ * @region:       First byte of the memory region for the pool, allocated
+ *                by the application; must be page-aligned.
+ * @region_size:  Total number of bytes available at @buf_region.
+ * Return: Either zero (for success) or a negative errno for failure.
+ */
+int homa_pool_init(struct homa_sock *hsk, void __user *region, __u64 region_size)
+{
+	struct homa_pool *pool = hsk->buffer_pool;
+	int i, result;
+
+	if (((uintptr_t)region) & ~PAGE_MASK)
+		return -EINVAL;
+	pool->hsk = hsk;
+	pool->region = (char __user *)region;
+	pool->num_bpages = region_size >> HOMA_BPAGE_SHIFT;
+	pool->descriptors = NULL;
+	pool->cores = NULL;
+	if (pool->num_bpages < MIN_POOL_SIZE) {
+		result = -EINVAL;
+		goto error;
+	}
+	pool->descriptors = kmalloc_array(pool->num_bpages,
+					  sizeof(struct homa_bpage), GFP_ATOMIC);
+	if (!pool->descriptors) {
+		result = -ENOMEM;
+		goto error;
+	}
+	for (i = 0; i < pool->num_bpages; i++) {
+		struct homa_bpage *bp = &pool->descriptors[i];
+
+		spin_lock_init(&bp->lock);
+		atomic_set(&bp->refs, 0);
+		bp->owner = -1;
+		bp->expiration = 0;
+	}
+	atomic_set(&pool->free_bpages, pool->num_bpages);
+	pool->bpages_needed = INT_MAX;
+
+	/* Allocate and initialize core-specific data. */
+	pool->cores = kmalloc_array(nr_cpu_ids, sizeof(struct homa_pool_core),
+				    GFP_ATOMIC);
+	if (!pool->cores) {
+		result = -ENOMEM;
+		goto error;
+	}
+	pool->num_cores = nr_cpu_ids;
+	for (i = 0; i < pool->num_cores; i++) {
+		pool->cores[i].page_hint = 0;
+		pool->cores[i].allocated = 0;
+		pool->cores[i].next_candidate = 0;
+	}
+	pool->check_waiting_invoked = 0;
+
+	return 0;
+
+error:
+	kfree(pool->descriptors);
+	kfree(pool->cores);
+	pool->region = NULL;
+	return result;
+}
+
+/**
+ * homa_pool_destroy() - Destructor for homa_pool. After this method
+ * returns, the object should not be used unless it has been reinitialized.
+ * @pool: Pool to destroy.
+ */
+void homa_pool_destroy(struct homa_pool *pool)
+{
+	if (!pool->region)
+		return;
+	kfree(pool->descriptors);
+	kfree(pool->cores);
+	pool->region = NULL;
+}
+
+/**
+ * homa_pool_get_pages() - Allocate one or more full pages from the pool.
+ * @pool:         Pool from which to allocate pages
+ * @num_pages:    Number of pages needed
+ * @pages:        The indices of the allocated pages are stored here; caller
+ *                must ensure this array is big enough. Reference counts have
+ *                been set to 1 on all of these pages (or 2 if set_owner
+ *                was specified).
+ * @set_owner:    If nonzero, the current core is marked as owner of all
+ *                of the allocated pages (and the expiration time is also
+ *                set). Otherwise the pages are left unowned.
+ * Return: 0 for success, -1 if there wasn't enough free space in the pool.
+ */
+int homa_pool_get_pages(struct homa_pool *pool, int num_pages, __u32 *pages,
+			int set_owner)
+{
+	int core_num = raw_smp_processor_id();
+	struct homa_pool_core *core;
+	__u64 now = sched_clock();
+	int alloced = 0;
+	int limit = 0;
+
+	core = &pool->cores[core_num];
+	if (atomic_sub_return(num_pages, &pool->free_bpages) < 0) {
+		atomic_add(num_pages, &pool->free_bpages);
+		return -1;
+	}
+
+	/* Once we get to this point we know we will be able to find
+	 * enough free pages; now we just have to find them.
+	 */
+	while (alloced != num_pages) {
+		struct homa_bpage *bpage;
+		int cur, ref_count;
+
+		/* If we don't need to use all of the bpages in the pool,
+		 * then try to use only the ones with low indexes. This
+		 * will reduce the cache footprint for the pool by reusing
+		 * a few bpages over and over. Specifically this code will
+		 * not consider any candidate page whose index is >= limit.
+		 * Limit is chosen to make sure there are a reasonable
+		 * number of free pages in the range, so we won't have to
+		 * check a huge number of pages.
+		 */
+		if (limit == 0) {
+			int extra;
+
+			limit = pool->num_bpages
+					- atomic_read(&pool->free_bpages);
+			extra = limit >> 2;
+			limit += (extra < MIN_EXTRA) ? MIN_EXTRA : extra;
+			if (limit > pool->num_bpages)
+				limit = pool->num_bpages;
+		}
+
+		cur = core->next_candidate;
+		core->next_candidate++;
+		if (cur >= limit) {
+			core->next_candidate = 0;
+
+			/* Must recompute the limit for each new loop through
+			 * the bpage array: we may need to consider a larger
+			 * range of pages because of concurrent allocations.
+			 */
+			limit = 0;
+			continue;
+		}
+		bpage = &pool->descriptors[cur];
+
+		/* Figure out whether this candidate is free (or can be
+		 * stolen). Do a quick check without locking the page, and
+		 * if the page looks promising, then lock it and check again
+		 * (must check again in case someone else snuck in and
+		 * grabbed the page).
+		 */
+		ref_count = atomic_read(&bpage->refs);
+		if (ref_count >= 2 || (ref_count == 1 && (bpage->owner < 0 ||
+							  bpage->expiration > now)))
+			continue;
+		if (!spin_trylock_bh(&bpage->lock))
+			continue;
+		ref_count = atomic_read(&bpage->refs);
+		if (ref_count >= 2 || (ref_count == 1 && (bpage->owner < 0 ||
+							  bpage->expiration > now))) {
+			spin_unlock_bh(&bpage->lock);
+			continue;
+		}
+		if (bpage->owner >= 0)
+			atomic_inc(&pool->free_bpages);
+		if (set_owner) {
+			atomic_set(&bpage->refs, 2);
+			bpage->owner = core_num;
+			bpage->expiration = now +
+					1000 * pool->hsk->homa->bpage_lease_usecs;
+		} else {
+			atomic_set(&bpage->refs, 1);
+			bpage->owner = -1;
+		}
+		spin_unlock_bh(&bpage->lock);
+		pages[alloced] = cur;
+		alloced++;
+	}
+	return 0;
+}
+
+/**
+ * homa_pool_allocate() - Allocate buffer space for an RPC.
+ * @rpc:  RPC that needs space allocated for its incoming message (space must
+ *        not already have been allocated). The fields @msgin->num_buffers
+ *        and @msgin->buffers are filled in. Must be locked by caller.
+ * Return: The return value is normally 0, which means either buffer space
+ * was allocated or the @rpc was queued on @hsk->waiting. If a fatal error
+ * occurred, such as no buffer pool present, then a negative errno is
+ * returned.
+ */
+int homa_pool_allocate(struct homa_rpc *rpc)
+{
+	struct homa_pool *pool = rpc->hsk->buffer_pool;
+	int full_pages, partial, i, core_id;
+	__u32 pages[HOMA_MAX_BPAGES];
+	struct homa_pool_core *core;
+	struct homa_bpage *bpage;
+	struct homa_rpc *other;
+
+	if (!pool->region)
+		return -ENOMEM;
+
+	/* First allocate any full bpages that are needed. */
+	full_pages = rpc->msgin.length >> HOMA_BPAGE_SHIFT;
+	if (unlikely(full_pages)) {
+		if (homa_pool_get_pages(pool, full_pages, pages, 0) != 0)
+			goto out_of_space;
+		for (i = 0; i < full_pages; i++)
+			rpc->msgin.bpage_offsets[i] = pages[i] << HOMA_BPAGE_SHIFT;
+	}
+	rpc->msgin.num_bpages = full_pages;
+
+	/* The last chunk may be less than a full bpage; for this we use
+	 * the bpage that we own (and reuse it for multiple messages).
+	 */
+	partial = rpc->msgin.length & (HOMA_BPAGE_SIZE - 1);
+	if (unlikely(partial == 0))
+		goto success;
+	core_id = raw_smp_processor_id();
+	core = &pool->cores[core_id];
+	bpage = &pool->descriptors[core->page_hint];
+	if (!spin_trylock_bh(&bpage->lock))
+		spin_lock_bh(&bpage->lock);
+	if (bpage->owner != core_id) {
+		spin_unlock_bh(&bpage->lock);
+		goto new_page;
+	}
+	if ((core->allocated + partial) > HOMA_BPAGE_SIZE) {
+		if (atomic_read(&bpage->refs) == 1) {
+			/* Bpage is totally free, so we can reuse it. */
+			core->allocated = 0;
+		} else {
+			bpage->owner = -1;
+
+			/* We know the reference count can't reach zero here
+			 * because of check above, so we won't have to decrement
+			 * pool->free_bpages.
+			 */
+			atomic_dec_return(&bpage->refs);
+			spin_unlock_bh(&bpage->lock);
+			goto new_page;
+		}
+	}
+	bpage->expiration = sched_clock() +
+			1000 * pool->hsk->homa->bpage_lease_usecs;
+	atomic_inc(&bpage->refs);
+	spin_unlock_bh(&bpage->lock);
+	goto allocate_partial;
+
+	/* Can't use the current page; get another one. */
+new_page:
+	if (homa_pool_get_pages(pool, 1, pages, 1) != 0) {
+		homa_pool_release_buffers(pool, rpc->msgin.num_bpages,
+					  rpc->msgin.bpage_offsets);
+		rpc->msgin.num_bpages = 0;
+		goto out_of_space;
+	}
+	core->page_hint = pages[0];
+	core->allocated = 0;
+
+allocate_partial:
+	rpc->msgin.bpage_offsets[rpc->msgin.num_bpages] = core->allocated
+			+ (core->page_hint << HOMA_BPAGE_SHIFT);
+	rpc->msgin.num_bpages++;
+	core->allocated += partial;
+
+success:
+	return 0;
+
+	/* We get here if there wasn't enough buffer space for this
+	 * message; add the RPC to hsk->waiting_for_bufs.
+	 */
+out_of_space:
+	homa_sock_lock(pool->hsk, "homa_pool_allocate");
+	list_for_each_entry(other, &pool->hsk->waiting_for_bufs, buf_links) {
+		if (other->msgin.length > rpc->msgin.length) {
+			list_add_tail(&rpc->buf_links, &other->buf_links);
+			goto queued;
+		}
+	}
+	list_add_tail_rcu(&rpc->buf_links, &pool->hsk->waiting_for_bufs);
+
+queued:
+	set_bpages_needed(pool);
+	homa_sock_unlock(pool->hsk);
+	return 0;
+}
+
+/**
+ * homa_pool_get_buffer() - Given an RPC, figure out where to store incoming
+ * message data.
+ * @rpc:        RPC for which incoming message data is being processed; its
+ *              msgin must be properly initialized and buffer space must have
+ *              been allocated for the message.
+ * @offset:     Offset within @rpc's incoming message.
+ * @available:  Will be filled in with the number of bytes of space available
+ *              at the returned address.
+ * Return:      The application's virtual address for buffer space corresponding
+ *              to @offset in the incoming message for @rpc.
+ */
+void __user *homa_pool_get_buffer(struct homa_rpc *rpc, int offset,
+				  int *available)
+{
+	int bpage_index, bpage_offset;
+
+	bpage_index = offset >> HOMA_BPAGE_SHIFT;
+	BUG_ON(bpage_index >= rpc->msgin.num_bpages);
+	bpage_offset = offset & (HOMA_BPAGE_SIZE - 1);
+	*available = (bpage_index < (rpc->msgin.num_bpages - 1))
+			? HOMA_BPAGE_SIZE - bpage_offset
+			: rpc->msgin.length - offset;
+	return rpc->hsk->buffer_pool->region + rpc->msgin.bpage_offsets[bpage_index]
+			+ bpage_offset;
+}
+
+/**
+ * homa_pool_release_buffers() - Release buffer space so that it can be
+ * reused.
+ * @pool:         Pool that the buffer space belongs to. Doesn't need to
+ *                be locked.
+ * @num_buffers:  How many buffers to release.
+ * @buffers:      Points to @num_buffers values, each of which is an offset
+ *                from the start of the pool to the buffer to be released.
+ */
+void homa_pool_release_buffers(struct homa_pool *pool, int num_buffers,
+			       __u32 *buffers)
+{
+	int i;
+
+	if (!pool->region)
+		return;
+	for (i = 0; i < num_buffers; i++) {
+		__u32 bpage_index = buffers[i] >> HOMA_BPAGE_SHIFT;
+		struct homa_bpage *bpage = &pool->descriptors[bpage_index];
+
+		if (bpage_index < pool->num_bpages)
+			if (atomic_dec_return(&bpage->refs) == 0)
+				atomic_inc(&pool->free_bpages);
+		}
+	}
+
+/**
+ * homa_pool_check_waiting() - Checks to see if there are enough free
+ * bpages to wake up any RPCs that were blocked. Whenever
+ * homa_pool_release_buffers is invoked, this function must be invoked later,
+ * at a point when the caller holds no locks (homa_pool_release_buffers may
+ * be invoked with locks held, so it can't safely invoke this function).
+ * This is regrettably tricky, but I can't think of a better solution.
+ * @pool:         Information about the buffer pool.
+ */
+void homa_pool_check_waiting(struct homa_pool *pool)
+{
+	while (atomic_read(&pool->free_bpages) >= pool->bpages_needed) {
+		struct homa_rpc *rpc;
+
+		homa_sock_lock(pool->hsk, "buffer pool");
+		if (list_empty(&pool->hsk->waiting_for_bufs)) {
+			pool->bpages_needed = INT_MAX;
+			homa_sock_unlock(pool->hsk);
+			break;
+		}
+		rpc = list_first_entry(&pool->hsk->waiting_for_bufs,
+				       struct homa_rpc, buf_links);
+		if (!homa_bucket_try_lock(rpc->bucket, rpc->id,
+					  "homa_pool_check_waiting")) {
+			/* Can't just spin on the RPC lock because we're
+			 * holding the socket lock (see sync.txt). Instead,
+			 * release the socket lock and try the entire
+			 * operation again.
+			 */
+			homa_sock_unlock(pool->hsk);
+			continue;
+		}
+		list_del_init(&rpc->buf_links);
+		if (list_empty(&pool->hsk->waiting_for_bufs))
+			pool->bpages_needed = INT_MAX;
+		else
+			set_bpages_needed(pool);
+		homa_sock_unlock(pool->hsk);
+		homa_pool_allocate(rpc);
+		if (rpc->msgin.num_bpages > 0)
+			/* Allocation succeeded; "wake up" the RPC. */
+			rpc->msgin.resend_all = 1;
+		homa_rpc_unlock(rpc);
+	}
+}
diff --git a/net/homa/homa_pool.h b/net/homa/homa_pool.h
new file mode 100644
index 000000000000..609d99b59707
--- /dev/null
+++ b/net/homa/homa_pool.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file contains definitions used to manage user-space buffer pools.
+ */
+
+#ifndef _HOMA_POOL_H
+#define _HOMA_POOL_H
+
+#include "homa_rpc.h"
+
+/**
+ * struct homa_bpage - Contains information about a single page in
+ * a buffer pool.
+ */
+struct homa_bpage {
+	union {
+		/**
+		 * @cache_line: Ensures that each homa_bpage object
+		 * is exactly one cache line long.
+		 */
+		char cache_line[L1_CACHE_BYTES];
+		struct {
+			/** @lock: to synchronize shared access. */
+			spinlock_t lock;
+
+			/**
+			 * @refs: Counts number of distinct uses of this
+			 * bpage (1 tick for each message that is using
+			 * this page, plus an additional tick if the @owner
+			 * field is set).
+			 */
+			atomic_t refs;
+
+			/**
+			 * @owner: kernel core that currently owns this page
+			 * (< 0 if none).
+			 */
+			int owner;
+
+			/**
+			 * @expiration: time (in sched_clock() units) after
+			 * which it's OK to steal this page from its current
+			 * owner (if @refs is 1).
+			 */
+			__u64 expiration;
+		};
+	};
+};
+
+/**
+ * struct homa_pool_core - Holds core-specific data for a homa_pool (a bpage
+ * out of which that core is allocating small chunks).
+ */
+struct homa_pool_core {
+	union {
+		/**
+		 * @cache_line: Ensures that each object is exactly one
+		 * cache line long.
+		 */
+		char cache_line[L1_CACHE_BYTES];
+		struct {
+			/**
+			 * @page_hint: Index of bpage in pool->descriptors,
+			 * which may be owned by this core. If so, we'll use it
+			 * for allocating partial pages.
+			 */
+			int page_hint;
+
+			/**
+			 * @allocated: if the page given by @page_hint is
+			 * owned by this core, this variable gives the number of
+			 * (initial) bytes that have already been allocated
+			 * from the page.
+			 */
+			int allocated;
+
+			/**
+			 * @next_candidate: when searching for free bpages,
+			 * check this index next.
+			 */
+			int next_candidate;
+		};
+	};
+};
+
+/**
+ * struct homa_pool - Describes a pool of buffer space for incoming
+ * messages for a particular socket; managed by homa_pool.c. The pool is
+ * divided up into "bpages", which are a multiple of the hardware page size.
+ * A bpage may be owned by a particular core so that it can more efficiently
+ * allocate space for small messages.
+ */
+struct homa_pool {
+	/**
+	 * @hsk: the socket that this pool belongs to.
+	 */
+	struct homa_sock *hsk;
+
+	/**
+	 * @region: beginning of the pool's region (in the app's virtual
+	 * memory). Divided into bpages. 0 means the pool hasn't yet been
+	 * initialized.
+	 */
+	char __user *region;
+
+	/** @num_bpages: total number of bpages in the pool. */
+	int num_bpages;
+
+	/** @descriptors: kmalloced area containing one entry for each bpage. */
+	struct homa_bpage *descriptors;
+
+	/**
+	 * @free_bpages: the number of pages still available for allocation
+	 * by homa_pool_get pages. This equals the number of pages with zero
+	 * reference counts, minus the number of pages that have been claimed
+	 * by homa_get_pool_pages but not yet allocated.
+	 */
+	atomic_t free_bpages;
+
+	/**
+	 * The number of free bpages required to satisfy the needs of the
+	 * first RPC on @hsk->waiting_for_bufs, or INT_MAX if that queue
+	 * is empty.
+	 */
+	int bpages_needed;
+
+	/** @cores: core-specific info; dynamically allocated. */
+	struct homa_pool_core *cores;
+
+	/** @num_cores: number of elements in @cores. */
+	int num_cores;
+
+	/**
+	 * @check_waiting_invoked: incremented during unit tests when
+	 * homa_pool_check_waiting is invoked.
+	 */
+	int check_waiting_invoked;
+};
+
+int      homa_pool_allocate(struct homa_rpc *rpc);
+void     homa_pool_check_waiting(struct homa_pool *pool);
+void     homa_pool_destroy(struct homa_pool *pool);
+void __user *homa_pool_get_buffer(struct homa_rpc *rpc, int offset,
+			      int *available);
+int      homa_pool_get_pages(struct homa_pool *pool, int num_pages,
+			     __u32 *pages, int leave_locked);
+int      homa_pool_init(struct homa_sock *hsk, void __user *buf_region,
+			__u64 region_size);
+void     homa_pool_release_buffers(struct homa_pool *pool,
+				   int num_buffers, __u32 *buffers);
+
+#endif /* _HOMA_POOL_H */
-- 
2.34.1


