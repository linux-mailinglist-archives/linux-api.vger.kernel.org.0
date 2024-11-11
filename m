Return-Path: <linux-api+bounces-2701-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B019C49D8
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 00:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC92282056
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2024 23:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE83B1C2457;
	Mon, 11 Nov 2024 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="K9827/HT"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B841BDAAE
	for <linux-api@vger.kernel.org>; Mon, 11 Nov 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368452; cv=none; b=ab8mlK1xHTjRYu50/Vsb9xRNEzJQ5kDKx08PK3La1ihRsbxXCKOG8gS3OihCWCs5GeGFr331nCRhl5oY91yBZEyrqRtM7lP0dBXfyTSbQvy8EzRRF7TEv+S2wGRVDSVtjCvCnIM2PKamc+6ImqbSWH9IPXs3WU5dSxrVlF2pAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368452; c=relaxed/simple;
	bh=4suU7x6oP7OFTncfPKkv+UBYzyrpQT7Pbe5FEoSOxjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4wHwF4vngKrYfUYLkMiNvoXLM4NWxEExfhPiz6SnAqgd0D+vi4FzvSO79axyIYhL3yYYYWQ6xbKPr/EumLAWW1luHd1cGGAjeeNw5Q9IQewjRLs7EZf1nNcQeEkLSGyuR/mlXZ5u09KWVcy0Wf5qHJEs/80KZ4Zw6iyPtxSEns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=K9827/HT; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C2Aw7yKXG7wvNec5VTC80ONdrzreFnGvOD9mSAlDjT0=; t=1731368450; x=1732232450; 
	b=K9827/HTcufR6K27HYFRnas0bcSPdMXLp7mbbwRkCnnq0tFrHs1WyTpGF61IcN5S/63vosjA+Ns
	VExPEjVjFi65zpkjEhR5+ZtzkoTinLm8dRSdqABxMmnWAVQg26RP9NiBYf/kNvGRpc31rNfLwAWE1
	420SbMGIvyAvypsbRYwiWtQ2W3+MtM79e3mdhjsMfD36Rkb2oKUIUINi3rUWVltgIyfUvqjviDEpu
	oTzaHa7R8Gexi1PLiEiisMIqcnfqMrUnY++fwxkVDDNBeyno1bqhKYmN+PJr+1BNCWilxe5adkK3Q
	OluhcW/3Dx3BCNc6AQo01ddNDxUrfJtHxEjg==;
Received: from ouster448.stanford.edu ([172.24.72.71]:54467 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tAe1Y-0002NP-IV; Mon, 11 Nov 2024 15:40:50 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v2 06/12] net: homa: create homa_peer.h and homa_peer.c
Date: Mon, 11 Nov 2024 15:39:59 -0800
Message-ID: <20241111234006.5942-7-ouster@cs.stanford.edu>
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
X-Scan-Signature: f5202e84dfa637b272337b0c5c517531

Homa needs to keep a small amount of information for each peer that
it has communicated with. These files define that state and provide
functions for storing and accessing it.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_peer.c | 319 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_peer.h | 234 +++++++++++++++++++++++++++++++
 2 files changed, 553 insertions(+)
 create mode 100644 net/homa/homa_peer.c
 create mode 100644 net/homa/homa_peer.h

diff --git a/net/homa/homa_peer.c b/net/homa/homa_peer.c
new file mode 100644
index 000000000000..7762064cb9e1
--- /dev/null
+++ b/net/homa/homa_peer.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file provides functions related to homa_peer and homa_peertab
+ * objects.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+
+/**
+ * homa_peertab_init() - Constructor for homa_peertabs.
+ * @peertab:  The object to initialize; previous contents are discarded.
+ *
+ * Return:    0 in the normal case, or a negative errno if there was a problem.
+ */
+int homa_peertab_init(struct homa_peertab *peertab)
+{
+	/* Note: when we return, the object must be initialized so it's
+	 * safe to call homa_peertab_destroy, even if this function returns
+	 * an error.
+	 */
+	int i;
+
+	spin_lock_init(&peertab->write_lock);
+	INIT_LIST_HEAD(&peertab->dead_dsts);
+	peertab->buckets = vmalloc(HOMA_PEERTAB_BUCKETS *
+				   sizeof(*peertab->buckets));
+	if (!peertab->buckets)
+		return -ENOMEM;
+	for (i = 0; i < HOMA_PEERTAB_BUCKETS; i++)
+		INIT_HLIST_HEAD(&peertab->buckets[i]);
+	return 0;
+}
+
+/**
+ * homa_peertab_destroy() - Destructor for homa_peertabs. After this
+ * function returns, it is unsafe to use any results from previous calls
+ * to homa_peer_find, since all existing homa_peer objects will have been
+ * destroyed.
+ * @peertab:  The table to destroy.
+ */
+void homa_peertab_destroy(struct homa_peertab *peertab)
+{
+	struct hlist_node *next;
+	struct homa_peer *peer;
+	int i;
+
+	if (!peertab->buckets)
+		return;
+
+	for (i = 0; i < HOMA_PEERTAB_BUCKETS; i++) {
+		hlist_for_each_entry_safe(peer, next, &peertab->buckets[i],
+					  peertab_links) {
+			dst_release(peer->dst);
+			kfree(peer);
+		}
+	}
+	vfree(peertab->buckets);
+	homa_peertab_gc_dsts(peertab, ~0);
+}
+
+/**
+ * homa_peertab_gc_dsts() - Invoked to free unused dst_entries, if it is
+ * safe to do so.
+ * @peertab:       The table in which to free entries.
+ * @now:           Current time, in sched_clock() units; entries with expiration
+ *                 dates no later than this will be freed. Specify ~0 to
+ *                 free all entries.
+ */
+void homa_peertab_gc_dsts(struct homa_peertab *peertab, __u64 now)
+{
+	while (!list_empty(&peertab->dead_dsts)) {
+		struct homa_dead_dst *dead = list_first_entry(&peertab->dead_dsts,
+							      struct homa_dead_dst,
+							      dst_links);
+		if (dead->gc_time > now)
+			break;
+		dst_release(dead->dst);
+		list_del(&dead->dst_links);
+		kfree(dead);
+	}
+}
+
+/**
+ * homa_peer_find() - Returns the peer associated with a given host; creates
+ * a new homa_peer if one doesn't already exist.
+ * @peertab:    Peer table in which to perform lookup.
+ * @addr:       Address of the desired host: IPv4 addresses are represented
+ *              as IPv4-mapped IPv6 addresses.
+ * @inet:       Socket that will be used for sending packets.
+ *
+ * Return:      The peer associated with @addr, or a negative errno if an
+ *              error occurred. The caller can retain this pointer
+ *              indefinitely: peer entries are never deleted except in
+ *              homa_peertab_destroy.
+ */
+struct homa_peer *homa_peer_find(struct homa_peertab *peertab,
+				 const struct in6_addr *addr,
+				 struct inet_sock *inet)
+{
+	/* Note: this function uses RCU operators to ensure safety even
+	 * if a concurrent call is adding a new entry.
+	 */
+	struct homa_peer *peer;
+	struct dst_entry *dst;
+
+	// Should use siphash or jhash here:
+	__u32 bucket = hash_32((__force __u32)addr->in6_u.u6_addr32[0],
+			       HOMA_PEERTAB_BUCKET_BITS);
+
+	bucket ^= hash_32((__force __u32)addr->in6_u.u6_addr32[1],
+			  HOMA_PEERTAB_BUCKET_BITS);
+	bucket ^= hash_32((__force __u32)addr->in6_u.u6_addr32[2],
+			  HOMA_PEERTAB_BUCKET_BITS);
+	bucket ^= hash_32((__force __u32)addr->in6_u.u6_addr32[3],
+			  HOMA_PEERTAB_BUCKET_BITS);
+	hlist_for_each_entry_rcu(peer, &peertab->buckets[bucket],
+				 peertab_links) {
+		if (ipv6_addr_equal(&peer->addr, addr))
+			return peer;
+	}
+
+	/* No existing entry; create a new one.
+	 *
+	 * Note: after we acquire the lock, we have to check again to
+	 * make sure the entry still doesn't exist (it might have been
+	 * created by a concurrent invocation of this function).
+	 */
+	spin_lock_bh(&peertab->write_lock);
+	hlist_for_each_entry_rcu(peer, &peertab->buckets[bucket],
+				 peertab_links) {
+		if (ipv6_addr_equal(&peer->addr, addr))
+			goto done;
+	}
+	peer = kmalloc(sizeof(*peer), GFP_ATOMIC);
+	if (!peer) {
+		peer = (struct homa_peer *)ERR_PTR(-ENOMEM);
+		goto done;
+	}
+	peer->addr = *addr;
+	dst = homa_peer_get_dst(peer, inet);
+	if (IS_ERR(dst)) {
+		kfree(peer);
+		peer = (struct homa_peer *)PTR_ERR(dst);
+		goto done;
+	}
+	peer->dst = dst;
+	INIT_LIST_HEAD(&peer->grantable_rpcs);
+	INIT_LIST_HEAD(&peer->grantable_links);
+	hlist_add_head_rcu(&peer->peertab_links, &peertab->buckets[bucket]);
+	peer->outstanding_resends = 0;
+	peer->most_recent_resend = 0;
+	peer->least_recent_rpc = NULL;
+	peer->least_recent_ticks = 0;
+	peer->current_ticks = -1;
+	peer->resend_rpc = NULL;
+	peer->num_acks = 0;
+	spin_lock_init(&peer->ack_lock);
+
+done:
+	spin_unlock_bh(&peertab->write_lock);
+	return peer;
+}
+
+/**
+ * homa_dst_refresh() - This method is called when the dst for a peer is
+ * obsolete; it releases that dst and creates a new one.
+ * @peertab:  Table containing the peer.
+ * @peer:     Peer whose dst is obsolete.
+ * @hsk:      Socket that will be used to transmit data to the peer.
+ */
+void homa_dst_refresh(struct homa_peertab *peertab, struct homa_peer *peer,
+		      struct homa_sock *hsk)
+{
+	struct dst_entry *dst;
+
+	spin_lock_bh(&peertab->write_lock);
+	dst = homa_peer_get_dst(peer, &hsk->inet);
+	if (!IS_ERR(dst)) {
+		struct homa_dead_dst *dead = (struct homa_dead_dst *)
+				kmalloc(sizeof(*dead), GFP_KERNEL);
+		if (unlikely(!dead)) {
+			/* Can't allocate memory to keep track of the
+			 * dead dst; just free it immediately (a bit
+			 * risky, admittedly).
+			 */
+			dst_release(peer->dst);
+		} else {
+			__u64 now = sched_clock();
+
+			dead->dst = peer->dst;
+			dead->gc_time = now + 125000000;
+			list_add_tail(&dead->dst_links, &peertab->dead_dsts);
+			homa_peertab_gc_dsts(peertab, now);
+		}
+		peer->dst = dst;
+	}
+	spin_unlock_bh(&peertab->write_lock);
+}
+
+/**
+ * homa_peer_get_dst() - Find an appropriate dst structure (either IPv4
+ * or IPv6) for a peer.
+ * @peer:   The peer for which a dst is needed. Note: this peer's flow
+ *          struct will be overwritten.
+ * @inet:   Socket that will be used for sending packets.
+ * Return:  The dst structure (or an ERR_PTR).
+ */
+struct dst_entry *homa_peer_get_dst(struct homa_peer *peer,
+				    struct inet_sock *inet)
+{
+	memset(&peer->flow, 0, sizeof(peer->flow));
+	if (inet->sk.sk_family == AF_INET) {
+		struct rtable *rt;
+
+		flowi4_init_output(&peer->flow.u.ip4, inet->sk.sk_bound_dev_if,
+				   inet->sk.sk_mark, inet->tos, RT_SCOPE_UNIVERSE,
+				   inet->sk.sk_protocol, 0,
+				   peer->addr.in6_u.u6_addr32[3], inet->inet_saddr,
+				   0, 0, inet->sk.sk_uid);
+		security_sk_classify_flow(&inet->sk, &peer->flow.u.__fl_common);
+		rt = ip_route_output_flow(sock_net(&inet->sk),
+					  &peer->flow.u.ip4, &inet->sk);
+		if (IS_ERR(rt))
+			return (struct dst_entry *)(PTR_ERR(rt));
+		return &rt->dst;
+	}
+	peer->flow.u.ip6.flowi6_oif = inet->sk.sk_bound_dev_if;
+	peer->flow.u.ip6.flowi6_iif = LOOPBACK_IFINDEX;
+	peer->flow.u.ip6.flowi6_mark = inet->sk.sk_mark;
+	peer->flow.u.ip6.flowi6_scope = RT_SCOPE_UNIVERSE;
+	peer->flow.u.ip6.flowi6_proto = inet->sk.sk_protocol;
+	peer->flow.u.ip6.flowi6_flags = 0;
+	peer->flow.u.ip6.flowi6_secid = 0;
+	peer->flow.u.ip6.flowi6_tun_key.tun_id = 0;
+	peer->flow.u.ip6.flowi6_uid = inet->sk.sk_uid;
+	peer->flow.u.ip6.daddr = peer->addr;
+	peer->flow.u.ip6.saddr = inet->pinet6->saddr;
+	peer->flow.u.ip6.fl6_dport = 0;
+	peer->flow.u.ip6.fl6_sport = 0;
+	peer->flow.u.ip6.mp_hash = 0;
+	peer->flow.u.ip6.__fl_common.flowic_tos = inet->tos;
+	peer->flow.u.ip6.flowlabel = ip6_make_flowinfo(inet->tos, 0);
+	security_sk_classify_flow(&inet->sk, &peer->flow.u.__fl_common);
+	return ip6_dst_lookup_flow(sock_net(&inet->sk), &inet->sk,
+			&peer->flow.u.ip6, NULL);
+}
+
+/**
+ * homa_peer_lock_slow() - This function implements the slow path for
+ * acquiring a peer's @unacked_lock. It is invoked when the lock isn't
+ * immediately available. It waits for the lock, but also records statistics
+ * about the waiting time.
+ * @peer:    Peer to  lock.
+ */
+void homa_peer_lock_slow(struct homa_peer *peer)
+	__acquires(&peer->ack_lock)
+{
+	spin_lock_bh(&peer->ack_lock);
+}
+
+/**
+ * homa_peer_add_ack() - Add a given RPC to the list of unacked
+ * RPCs for its server. Once this method has been invoked, it's safe
+ * to delete the RPC, since it will eventually be acked to the server.
+ * @rpc:    Client RPC that has now completed.
+ */
+void homa_peer_add_ack(struct homa_rpc *rpc)
+{
+	struct homa_peer *peer = rpc->peer;
+	struct ack_header ack;
+
+	homa_peer_lock(peer);
+	if (peer->num_acks < HOMA_MAX_ACKS_PER_PKT) {
+		peer->acks[peer->num_acks].client_id = cpu_to_be64(rpc->id);
+		peer->acks[peer->num_acks].client_port = htons(rpc->hsk->port);
+		peer->acks[peer->num_acks].server_port = htons(rpc->dport);
+		peer->num_acks++;
+		homa_peer_unlock(peer);
+		return;
+	}
+
+	/* The peer has filled up; send an ACK message to empty it. The
+	 * RPC in the message header will also be considered ACKed.
+	 */
+	memcpy(ack.acks, peer->acks, sizeof(peer->acks));
+	ack.num_acks = htons(peer->num_acks);
+	peer->num_acks = 0;
+	homa_peer_unlock(peer);
+	homa_xmit_control(ACK, &ack, sizeof(ack), rpc);
+}
+
+/**
+ * homa_peer_get_acks() - Copy acks out of a peer, and remove them from the
+ * peer.
+ * @peer:    Peer to check for possible unacked RPCs.
+ * @count:   Maximum number of acks to return.
+ * @dst:     The acks are copied to this location.
+ *
+ * Return:   The number of acks extracted from the peer (<= count).
+ */
+int homa_peer_get_acks(struct homa_peer *peer, int count, struct homa_ack *dst)
+{
+	/* Don't waste time acquiring the lock if there are no ids available. */
+	if (peer->num_acks == 0)
+		return 0;
+
+	homa_peer_lock(peer);
+
+	if (count > peer->num_acks)
+		count = peer->num_acks;
+	memcpy(dst, &peer->acks[peer->num_acks - count],
+	       count * sizeof(peer->acks[0]));
+	peer->num_acks -= count;
+
+	homa_peer_unlock(peer);
+	return count;
+}
diff --git a/net/homa/homa_peer.h b/net/homa/homa_peer.h
new file mode 100644
index 000000000000..2bec66e5818f
--- /dev/null
+++ b/net/homa/homa_peer.h
@@ -0,0 +1,234 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file contains definitions related to managing peers (homa_peer
+ * and homa_peertab).
+ */
+
+#ifndef _HOMA_PEER_H
+#define _HOMA_PEER_H
+
+#include "homa_wire.h"
+#include "homa_sock.h"
+
+struct homa_rpc;
+
+/**
+ * struct homa_dead_dst - Used to retain dst_entries that are no longer
+ * needed, until it is safe to delete them (I'm not confident that the RCU
+ * mechanism will be safe for these: the reference count could get incremented
+ * after it's on the RCU list?).
+ */
+struct homa_dead_dst {
+	/** @dst: Entry that is no longer used by a struct homa_peer. */
+	struct dst_entry *dst;
+
+	/**
+	 * @gc_time: Time (in units of sched_clock()) when it is safe
+	 * to free @dst.
+	 */
+	__u64 gc_time;
+
+	/** @dst_links: Used to link together entries in peertab->dead_dsts. */
+	struct list_head dst_links;
+};
+
+/**
+ * define HOMA_PEERTAB_BUCKETS - Number of bits in the bucket index for a
+ * homa_peertab.  Should be large enough to hold an entry for every server
+ * in a datacenter without long hash chains.
+ */
+#define HOMA_PEERTAB_BUCKET_BITS 16
+
+/** define HOME_PEERTAB_BUCKETS - Number of buckets in a homa_peertab. */
+#define HOMA_PEERTAB_BUCKETS BIT(HOMA_PEERTAB_BUCKET_BITS)
+
+/**
+ * struct homa_peertab - A hash table that maps from IPv6 addresses
+ * to homa_peer objects. IPv4 entries are encapsulated as IPv6 addresses.
+ * Entries are gradually added to this table, but they are never removed
+ * except when the entire table is deleted. We can't safely delete because
+ * results returned by homa_peer_find may be retained indefinitely.
+ *
+ * This table is managed exclusively by homa_peertab.c, using RCU to
+ * permit efficient lookups.
+ */
+struct homa_peertab {
+	/**
+	 * @write_lock: Synchronizes addition of new entries; not needed
+	 * for lookups (RCU is used instead).
+	 */
+	spinlock_t write_lock;
+
+	/**
+	 * @dead_dsts: List of dst_entries that are waiting to be deleted.
+	 * Hold @write_lock when manipulating.
+	 */
+	struct list_head dead_dsts;
+
+	/**
+	 * @buckets: Pointer to heads of chains of homa_peers for each bucket.
+	 * Malloc-ed, and must eventually be freed. NULL means this structure
+	 * has not been initialized.
+	 */
+	struct hlist_head *buckets;
+};
+
+/**
+ * struct homa_peer - One of these objects exists for each machine that we
+ * have communicated with (either as client or server).
+ */
+struct homa_peer {
+	/**
+	 * @addr: IPv6 address for the machine (IPv4 addresses are stored
+	 * as IPv4-mapped IPv6 addresses).
+	 */
+	struct in6_addr addr;
+
+	/** @flow: Addressing info needed to send packets. */
+	struct flowi flow;
+
+	/**
+	 * @dst: Used to route packets to this peer; we own a reference
+	 * to this, which we must eventually release.
+	 */
+	struct dst_entry *dst;
+
+	/**
+	 * grantable_rpcs: Contains all homa_rpcs (both requests and
+	 * responses) involving this peer whose msgins require (or required
+	 * them in the past) and have not been fully received. The list is
+	 * sorted in priority order (head has fewest bytes_remaining).
+	 * Locked with homa->grantable_lock.
+	 */
+	struct list_head grantable_rpcs;
+
+	/**
+	 * @grantable_links: Used to link this peer into homa->grantable_peers.
+	 * If this RPC is not linked into homa->grantable_peers, this is an
+	 * empty list pointing to itself.
+	 */
+	struct list_head grantable_links;
+
+	/**
+	 * @peertab_links: Links this object into a bucket of its
+	 * homa_peertab.
+	 */
+	struct hlist_node peertab_links;
+
+	/**
+	 * @outstanding_resends: the number of resend requests we have
+	 * sent to this server (spaced @homa.resend_interval apart) since
+	 * we received a packet from this peer.
+	 */
+	int outstanding_resends;
+
+	/**
+	 * @most_recent_resend: @homa->timer_ticks when the most recent
+	 * resend was sent to this peer.
+	 */
+	int most_recent_resend;
+
+	/**
+	 * @least_recent_rpc: of all the RPCs for this peer scanned at
+	 * @current_ticks, this is the RPC whose @resend_timer_ticks
+	 * is farthest in the past.
+	 */
+	struct homa_rpc *least_recent_rpc;
+
+	/**
+	 * @least_recent_ticks: the @resend_timer_ticks value for
+	 * @least_recent_rpc.
+	 */
+	__u32 least_recent_ticks;
+
+	/**
+	 * @current_ticks: the value of @homa->timer_ticks the last time
+	 * that @least_recent_rpc and @least_recent_ticks were computed.
+	 * Used to detect the start of a new homa_timer pass.
+	 */
+	__u32 current_ticks;
+
+	/**
+	 * @resend_rpc: the value of @least_recent_rpc computed in the
+	 * previous homa_timer pass. This RPC will be issued a RESEND
+	 * in the current pass, if it still needs one.
+	 */
+	struct homa_rpc *resend_rpc;
+
+	/**
+	 * @num_acks: the number of (initial) entries in @acks that
+	 * currently hold valid information.
+	 */
+	int num_acks;
+
+	/**
+	 * @acks: info about client RPCs whose results have been completely
+	 * received.
+	 */
+	struct homa_ack acks[HOMA_MAX_ACKS_PER_PKT];
+
+	/**
+	 * @ack_lock: used to synchronize access to @num_acks and @acks.
+	 */
+	spinlock_t ack_lock;
+};
+
+void              homa_dst_refresh(struct homa_peertab *peertab,
+				   struct homa_peer *peer,
+				   struct homa_sock *hsk);
+void              homa_peertab_destroy(struct homa_peertab *peertab);
+int               homa_peertab_init(struct homa_peertab *peertab);
+void              homa_peer_add_ack(struct homa_rpc *rpc);
+struct homa_peer *homa_peer_find(struct homa_peertab *peertab,
+				 const struct in6_addr *addr,
+				 struct inet_sock *inet);
+int               homa_peer_get_acks(struct homa_peer *peer, int count,
+				     struct homa_ack *dst);
+struct dst_entry *homa_peer_get_dst(struct homa_peer *peer,
+				    struct inet_sock *inet);
+void              homa_peer_lock_slow(struct homa_peer *peer);
+void              homa_peertab_gc_dsts(struct homa_peertab *peertab, __u64 now);
+
+/**
+ * homa_peer_lock() - Acquire the lock for a peer's @unacked_lock. If the lock
+ * isn't immediately available, record stats on the waiting time.
+ * @peer:    Peer to lock.
+ */
+// static inline void homa_peer_lock(struct homa_peer *peer)
+// 	__acquires(&peer->ack_lock)
+// {
+// 	if (!spin_trylock_bh(&peer->ack_lock))
+// 		homa_peer_lock_slow(peer);
+// }
+#define homa_peer_lock(peer) do {               \
+	struct homa_peer *_peer = peer;         \
+	if (!spin_trylock_bh(&_peer->ack_lock)) \
+		homa_peer_lock_slow(_peer);     \
+} while (0)
+
+/**
+ * homa_peer_unlock() - Release the lock for a peer's @unacked_lock.
+ * @peer:   Peer to lock.
+ */
+static inline void homa_peer_unlock(struct homa_peer *peer)
+	__releases(&peer->ack_lock)
+{
+	spin_unlock_bh(&peer->ack_lock);
+}
+
+/**
+ * homa_get_dst() - Returns destination information associated with a peer,
+ * updating it if the cached information is stale.
+ * @peer:   Peer whose destination information is desired.
+ * @hsk:    Homa socket; needed by lower-level code to recreate the dst.
+ * Return   Up-to-date destination for peer.
+ */
+static inline struct dst_entry *homa_get_dst(struct homa_peer *peer,
+					     struct homa_sock *hsk)
+{
+	if (unlikely(peer->dst->obsolete > 0))
+		homa_dst_refresh(hsk->homa->peers, peer, hsk);
+	return peer->dst;
+}
+
+#endif /* _HOMA_PEER_H */
-- 
2.34.1


