Return-Path: <linux-api+bounces-2702-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7839C49D9
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 00:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9342830CD
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2024 23:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3301C2DCF;
	Mon, 11 Nov 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="nlScpjMl"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC21BD9E9
	for <linux-api@vger.kernel.org>; Mon, 11 Nov 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368452; cv=none; b=gofz5+IFaOotPhUVfpKiMUl5AuxNbpmHmf72/mCcPfUFmNZZiqImuaZiGW1GDkIy+mw2/lsNNKHPjLV9iTTzNEzUy6UzLR7C6JNRtRDBLSB1rf2IMfzP3oLlvRprB4REVAs2dWfL4pdS+QBbi8yl767y42WPel1O+1gw+HfYk2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368452; c=relaxed/simple;
	bh=QiPq35SPKJ4eRlfOAwlcFZlfRkrdi6Xg4cjbk+8C/D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6sC1SPqzu84Lh6aUcUfQ98+FXtqAPZl2ORjH7mcmTuO2yccfkjtuHSvq+hVRP49goFsZX7xPwTrCLResGGVmhJBAXxbANLb/yRcFtfotv0zgarOD3zemI3Zmu6vDvyanOUXyvS0An8z4fydWj0JMlu4oti+sjflKTPF1mz67VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=nlScpjMl; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fitKp9yhB53l7AHibiNU7N+zO5pIlssI0iDN4EdDqio=; t=1731368450; x=1732232450; 
	b=nlScpjMlLYGnAPCR/O16fxAs1iwEXuFr28hulwk6ScU153uidmvQzEGz9WRCmmA/VG6c0u5ERdt
	o7SdvClTi8FFavLF4SmjIzu/FC60cG1epAKIIfuwH0/rrcf3WSBL+meSTOv6tiJV/JANgPc/RWjUL
	fM5t4ABDgL/qQRksd0LSTr9ZoYYbLyArP7VkSnCjthWumO3rc/1zK/4H6CehPE9VFqXF5ro0dgO+P
	YzMbLr/TFCtOCrhEX38bo8LYNaOQO84FQww9A7TPfP3HupljHQJDIOhSPjT/ClX39y5qmFcX4y28M
	bE38AB5qOozfRRz4wZaem3YdvZsRuxFfx/CQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:54467 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tAe1S-0002NP-RI; Mon, 11 Nov 2024 15:40:44 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v2 03/12] net: homa: create shared Homa header files
Date: Mon, 11 Nov 2024 15:39:56 -0800
Message-ID: <20241111234006.5942-4-ouster@cs.stanford.edu>
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
X-Scan-Signature: bcdc0f61a95607edd77a27aa99508360

homa_impl.h defines "struct homa", which contains overall information
about the Homa transport, plus various odds and ends that are used
throughout the Homa implementation.

homa_stub.h is a temporary header file that provides stubs for
facilities that have omitted for this first patch series. This file
will go away once Home is fully upstreamed.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_impl.h | 767 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_stub.h |  80 +++++
 2 files changed, 847 insertions(+)
 create mode 100644 net/homa/homa_impl.h
 create mode 100644 net/homa/homa_stub.h

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
new file mode 100644
index 000000000000..316a82b12ffa
--- /dev/null
+++ b/net/homa/homa_impl.h
@@ -0,0 +1,767 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file contains definitions that are shared across the files
+ * that implement Homa for Linux.
+ */
+
+#ifndef _HOMA_IMPL_H
+#define _HOMA_IMPL_H
+
+#include <linux/bug.h>
+
+#include <linux/audit.h>
+#include <linux/icmp.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/completion.h>
+#include <linux/proc_fs.h>
+#include <linux/sched/clock.h>
+#include <linux/sched/signal.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/vmalloc.h>
+#include <net/icmp.h>
+#include <net/ip.h>
+#include <net/protocol.h>
+#include <net/inet_common.h>
+#include <net/gro.h>
+#include <net/rps.h>
+
+#include <uapi/linux/homa.h>
+#include "homa_wire.h"
+
+/* Forward declarations. */
+struct homa_peer;
+struct homa_sock;
+struct homa;
+
+/* Declarations used in this file, so they can't be made at the end. */
+void     homa_throttle_lock_slow(struct homa *homa);
+
+#define sizeof32(type) ((int)(sizeof(type)))
+
+/**
+ * Holds either an IPv4 or IPv6 address (smaller and easier to use than
+ * sockaddr_storage).
+ */
+union sockaddr_in_union {
+	struct sockaddr sa;
+	struct sockaddr_in in4;
+	struct sockaddr_in6 in6;
+};
+
+/**
+ * struct homa_interest - Contains various information used while waiting
+ * for incoming messages (indicates what kinds of messages a particular
+ * thread is interested in receiving).
+ */
+struct homa_interest {
+	/**
+	 * @thread: Thread that would like to receive a message. Will get
+	 * woken up when a suitable message becomes available.
+	 */
+	struct task_struct *thread;
+
+	/**
+	 * @ready_rpc: This is actually a (struct homa_rpc *) identifying the
+	 * RPC that was found; NULL if no RPC has been found yet. This
+	 * variable is used for synchronization to handoff the RPC, and
+	 * must be set only after @locked is set.
+	 */
+	atomic_long_t ready_rpc;
+
+	/**
+	 * @locked: Nonzero means that @ready_rpc is locked; only valid
+	 * if @ready_rpc is non-NULL.
+	 */
+	int locked;
+
+	/**
+	 * @core: Core on which @thread was executing when it registered
+	 * its interest.  Used for load balancing (see balance.txt).
+	 */
+	int core;
+
+	/**
+	 * @reg_rpc: RPC whose @interest field points here, or
+	 * NULL if none.
+	 */
+	struct homa_rpc *reg_rpc;
+
+	/**
+	 * @request_links: For linking this object into
+	 * &homa_sock.request_interests. The interest must not be linked
+	 * on either this list or @response_links if @id is nonzero.
+	 */
+	struct list_head request_links;
+
+	/**
+	 * @response_links: For linking this object into
+	 * &homa_sock.request_interests.
+	 */
+	struct list_head response_links;
+};
+
+/**
+ * homa_interest_init() - Fill in default values for all of the fields
+ * of a struct homa_interest.
+ * @interest:   Struct to initialize.
+ */
+static inline void homa_interest_init(struct homa_interest *interest)
+{
+	interest->thread = current;
+	atomic_long_set(&interest->ready_rpc, 0);
+	interest->locked = 0;
+	interest->core = raw_smp_processor_id();
+	interest->reg_rpc = NULL;
+	interest->request_links.next = LIST_POISON1;
+	interest->response_links.next = LIST_POISON1;
+}
+
+/**
+ * struct homa - Overall information about the Homa protocol implementation.
+ *
+ * There will typically only exist one of these at a time, except during
+ * unit tests.
+ */
+struct homa {
+	/**
+	 * @next_outgoing_id: Id to use for next outgoing RPC request.
+	 * This is always even: it's used only to generate client-side ids.
+	 * Accessed without locks.
+	 */
+	atomic64_t next_outgoing_id;
+
+	/**
+	 * @link_idle_time: The time, measured by sched_clock at which we
+	 * estimate that all of the packets we have passed to Linux for
+	 * transmission will have been transmitted. May be in the past.
+	 * This estimate assumes that only Homa is transmitting data, so
+	 * it could be a severe underestimate if there is competing traffic
+	 * from, say, TCP. Access only with atomic ops.
+	 */
+	atomic64_t link_idle_time __aligned(L1_CACHE_BYTES);
+
+	/**
+	 * @pacer_mutex: Ensures that only one instance of homa_pacer_xmit
+	 * runs at a time. Only used in "try" mode: never block on this.
+	 */
+	spinlock_t pacer_mutex __aligned(L1_CACHE_BYTES);
+
+	/**
+	 * @pacer_fifo_fraction: The fraction of time (in thousandths) when
+	 * the pacer should transmit next from the oldest message, rather
+	 * than the highest-priority message. Set externally via sysctl.
+	 */
+	int pacer_fifo_fraction;
+
+	/**
+	 * @pacer_fifo_count: When this becomes <= zero, it's time for the
+	 * pacer to allow the oldest RPC to transmit.
+	 */
+	int pacer_fifo_count;
+
+	/**
+	 * @pacer_wake_time: time (in sched_clock units) when the pacer last
+	 * woke up (if the pacer is running) or 0 if the pacer is sleeping.
+	 */
+	__u64 pacer_wake_time;
+
+	/**
+	 * @throttle_lock: Used to synchronize access to @throttled_rpcs. To
+	 * insert or remove an RPC from throttled_rpcs, must first acquire
+	 * the RPC's socket lock, then this lock.
+	 */
+	spinlock_t throttle_lock;
+
+	/**
+	 * @throttled_rpcs: Contains all homa_rpcs that have bytes ready
+	 * for transmission, but which couldn't be sent without exceeding
+	 * the queue limits for transmission. Manipulate only with "_rcu"
+	 * functions.
+	 */
+	struct list_head throttled_rpcs;
+
+	/**
+	 * @throttle_add: The time (in sched_clock() units) when the most
+	 * recent RPC was added to @throttled_rpcs.
+	 */
+	__u64 throttle_add;
+
+	/**
+	 * @throttle_min_bytes: If a packet has fewer bytes than this, then it
+	 * bypasses the throttle mechanism and is transmitted immediately.
+	 * We have this limit because for very small packets we can't keep
+	 * up with the NIC (we're limited by CPU overheads); there's no
+	 * need for throttling and going through the throttle mechanism
+	 * adds overhead, which slows things down. At least, that's the
+	 * hypothesis (needs to be verified experimentally!). Set externally
+	 * via sysctl.
+	 */
+	int throttle_min_bytes;
+
+	/**
+	 * @next_client_port: A client port number to consider for the
+	 * next Homa socket; increments monotonically. Current value may
+	 * be in the range allocated for servers; must check before using.
+	 * This port may also be in use already; must check.
+	 */
+	__u16 next_client_port __aligned(L1_CACHE_BYTES);
+
+	/**
+	 * @port_map: Information about all open sockets. Dynamically
+	 * allocated; must be kfreed.
+	 */
+	struct homa_socktab *port_map __aligned(L1_CACHE_BYTES);
+
+	/**
+	 * @peertab: Info about all the other hosts we have communicated with.
+	 * Dynamically allocated; must be kfreed.
+	 */
+	struct homa_peertab *peers;
+
+	/** @max_numa: Highest NUMA node id in use by any core. */
+	int max_numa;
+
+	/**
+	 * @unsched_bytes: The number of bytes that may be sent in a
+	 * new message without receiving any grants. There used to be a
+	 * variable rtt_bytes that served this purpose, and was also used
+	 * for window.  Historically, rtt_bytes was intended to be the amount
+	 * of data that can be transmitted over the wire in the time it
+	 * takes to send a full-size data packet and receive back a grant.
+	 * But, for fast networks that value could result in too much
+	 * buffer utilization (and, we wanted to have separate values for
+	 * @unsched_bytes and @window). Set externally via sysctl.
+	 */
+	int unsched_bytes;
+
+	/**
+	 * @window_param: Set externally via sysctl to select a policy for
+	 * computing homa-grant_window. If 0 then homa->grant_window is
+	 * computed dynamically based on the number of RPCs we're currently
+	 * granting to. If nonzero then homa->grant_window will always be the
+	 * same as @window_param.
+	 */
+	int window_param;
+
+	/**
+	 * @link_bandwidth: The raw bandwidth of the network uplink, in
+	 * units of 1e06 bits per second.  Set externally via sysctl.
+	 */
+	int link_mbps;
+
+	/**
+	 * @fifo_grant_increment: how many additional bytes to grant in
+	 * a "pity" grant sent to the oldest outstanding message. Set
+	 * externally via sysctl.
+	 */
+	int fifo_grant_increment;
+
+	/**
+	 * @grant_fifo_fraction: The fraction (in thousandths) of granted
+	 * bytes that should go to the *oldest* incoming message, rather
+	 * than the highest priority ones. Set externally via sysctl.
+	 */
+	int grant_fifo_fraction;
+
+	/**
+	 * @max_overcommit: The maximum number of messages to which Homa will
+	 * send grants at any given point in time.  Set externally via sysctl.
+	 */
+	int max_overcommit;
+
+	/**
+	 * @max_incoming: Homa will try to ensure that the total number of
+	 * bytes senders have permission to send to this host (either
+	 * unscheduled bytes or granted bytes) does not exceeds this value.
+	 * Set externally via sysctl.
+	 */
+	int max_incoming;
+
+	/**
+	 * @max_rpcs_per_peer: If there are multiple incoming messages from
+	 * the same peer, Homa will only issue grants to this many of them
+	 * at a time.  Set externally via sysctl.
+	 */
+	int max_rpcs_per_peer;
+
+	/**
+	 * @resend_ticks: When an RPC's @silent_ticks reaches this value,
+	 * start sending RESEND requests.
+	 */
+	int resend_ticks;
+
+	/**
+	 * @resend_interval: minimum number of homa timer ticks between
+	 * RESENDs for the same RPC.
+	 */
+	int resend_interval;
+
+	/**
+	 * @timeout_ticks: abort an RPC if its silent_ticks reaches this value.
+	 */
+	int timeout_ticks;
+
+	/**
+	 * @timeout_resends: Assume that a server is dead if it has not
+	 * responded after this many RESENDs have been sent to it.
+	 */
+	int timeout_resends;
+
+	/**
+	 * @request_ack_ticks: How many timer ticks we'll wait for the
+	 * client to ack an RPC before explicitly requesting an ack.
+	 * Set externally via sysctl.
+	 */
+	int request_ack_ticks;
+
+	/**
+	 * @reap_limit: Maximum number of packet buffers to free in a
+	 * single call to home_rpc_reap.
+	 */
+	int reap_limit;
+
+	/**
+	 * @dead_buffs_limit: If the number of packet buffers in dead but
+	 * not yet reaped RPCs is less than this number, then Homa reaps
+	 * RPCs in a way that minimizes impact on performance but may permit
+	 * dead RPCs to accumulate. If the number of dead packet buffers
+	 * exceeds this value, then Homa switches to a more aggressive approach
+	 * to reaping RPCs. Set externally via sysctl.
+	 */
+	int dead_buffs_limit;
+
+	/**
+	 * @max_dead_buffs: The largest aggregate number of packet buffers
+	 * in dead (but not yet reaped) RPCs that has existed so far in a
+	 * single socket.  Readable via sysctl, and may be reset via sysctl
+	 * to begin recalculating.
+	 */
+	int max_dead_buffs;
+
+	/**
+	 * @pacer_kthread: Kernel thread that transmits packets from
+	 * throttled_rpcs in a way that limits queue buildup in the
+	 * NIC.
+	 */
+	struct task_struct *pacer_kthread;
+
+	/**
+	 * @pacer_exit: true means that the pacer thread should exit as
+	 * soon as possible.
+	 */
+	bool pacer_exit;
+
+	/**
+	 * @max_nic_queue_ns: Limits the NIC queue length: we won't queue
+	 * up a packet for transmission if link_idle_time is this many
+	 * nanoseconds in the future (or more). Set externally via sysctl.
+	 */
+	int max_nic_queue_ns;
+
+	/**
+	 * @ns_per_mbyte: the number of ns that it takes to transmit
+	 * 10**6 bytes on our uplink. This is actually a slight overestimate
+	 * of the value, to ensure that we don't underestimate NIC queue
+	 * length and queue too many packets.
+	 */
+	__u32 ns_per_mbyte;
+
+	/**
+	 * @max_gso_size: Maximum number of bytes that will be included
+	 * in a single output packet that Homa passes to Linux. Can be set
+	 * externally via sysctl to lower the limit already enforced by Linux.
+	 */
+	int max_gso_size;
+
+	/**
+	 * @gso_force_software: A non-zero value will cause Home to perform
+	 * segmentation in software using GSO; zero means ask the NIC to
+	 * perform TSO. Set externally via sysctl.
+	 */
+	int gso_force_software;
+
+	/**
+	 * @max_gro_skbs: Maximum number of socket buffers that can be
+	 * aggregated by the GRO mechanism.  Set externally via sysctl.
+	 */
+	int max_gro_skbs;
+
+	/**
+	 * @gro_policy: An OR'ed together collection of bits that determine
+	 * how Homa packets should be steered for SoftIRQ handling.  A value
+	 * of zero will eliminate any Homa-specific behaviors, reverting
+	 * to the Linux defaults. Set externally via sysctl (but modifying
+	 * it is almost certainly a bad idea; see below).
+	 */
+	int gro_policy;
+
+	/* Bits that can be specified for gro_policy. These were created for
+	 * testing, in order to evaluate various possible policies; you almost
+	 * certainly should not use any value other than HOMA_GRO_NORMAL.
+	 * HOMA_GRO_SAME_CORE         If isolated packets arrive (not part of
+	 *                            a batch) use the GRO core for SoftIRQ also.
+	 * HOMA_GRO_IDLE              Use old mechanism for selecting an idle
+	 *                            core for SoftIRQ (deprecated).
+	 * HOMA_GRO_NEXT              Always use the next core in circular
+	 *                            order for SoftIRQ (deprecated).
+	 * HOMA_GRO_GEN2              Use the new mechanism for selecting an
+	 *                            idle core for SoftIRQ.
+	 * HOMA_GRO_SHORT_BYPASS      Pass all single-packet messages directly
+	 *                            to homa_softirq during GRO (only if the
+	 *                            core isn't overloaded).
+	 * HOMA_GRO_GEN3              Use the "Gen3" mechanisms for load
+	 *                            balancing.
+	 */
+	#define HOMA_GRO_SAME_CORE         2
+	#define HOMA_GRO_IDLE              4
+	#define HOMA_GRO_NEXT              8
+	#define HOMA_GRO_GEN2           0x10
+	#define HOMA_GRO_SHORT_BYPASS   0x40
+	#define HOMA_GRO_GEN3           0x80
+	#define HOMA_GRO_NORMAL      (HOMA_GRO_SAME_CORE | HOMA_GRO_GEN2 | \
+				      HOMA_GRO_SHORT_BYPASS)
+
+	/**
+	 * @timer_ticks: number of times that homa_timer has been invoked
+	 * (may wraparound, which is safe).
+	 */
+	__u32 timer_ticks;
+
+	/**
+	 * @flags: a collection of bits that can be set using sysctl
+	 * to trigger various behaviors.
+	 */
+	int flags;
+
+	/**
+	 * @bpage_lease_usecs: how long a core can own a bpage (microseconds)
+	 * before its ownership can be revoked to reclaim the page.
+	 */
+	int bpage_lease_usecs;
+
+	/**
+	 * @next_id: Set via sysctl; causes next_outgoing_id to be set to
+	 * this value; always reads as zero. Typically used while debugging to
+	 * ensure that different nodes use different ranges of ids.
+	 */
+	int next_id;
+
+	/**
+	 * @temp: the values in this array can be read and written with sysctl.
+	 * They have no officially defined purpose, and are available for
+	 * short-term use during testing.
+	 */
+	int temp[4];
+};
+
+/**
+ * struct homa_skb_info - Additional information needed by Homa for each
+ * outbound DATA packet. Space is allocated for this at the very end of the
+ * linear part of the skb.
+ */
+struct homa_skb_info {
+	/**
+	 * @next_skb: used to link together all of the skb's for a Homa
+	 * message (in order of offset).
+	 */
+	struct sk_buff *next_skb;
+
+	/**
+	 * @wire_bytes: total number of bytes of network bandwidth that
+	 * will be consumed by this packet. This includes everything,
+	 * including additional headers added by GSO, IP header, Ethernet
+	 * header, CRC, preamble, and inter-packet gap.
+	 */
+	int wire_bytes;
+
+	/**
+	 * @data_bytes: total bytes of message data across all of the
+	 * segments in this packet.
+	 */
+	int data_bytes;
+
+	/** @seg_length: maximum number of data bytes in each GSO segment. */
+	int seg_length;
+
+	/**
+	 * @offset: offset within the message of the first byte of data in
+	 * this packet.
+	 */
+	int offset;
+};
+
+/**
+ * homa_get_skb_info() - Return the address of Homa's private information
+ * for an sk_buff.
+ * @skb:     Socket buffer whose info is needed.
+ */
+static inline struct homa_skb_info *homa_get_skb_info(struct sk_buff *skb)
+{
+	return (struct homa_skb_info *)(skb_end_pointer(skb)
+			- sizeof(struct homa_skb_info));
+}
+
+/**
+ * homa_next_skb() - Compute address of Homa's private link field in @skb.
+ * @skb:     Socket buffer containing private link field.
+ *
+ * Homa needs to keep a list of buffers in a message, but it can't use the
+ * links built into sk_buffs because Homa wants to retain its list even
+ * after sending the packet, and the built-in links get used during sending.
+ * Thus we allocate extra space at the very end of the packet's data
+ * area to hold a forward pointer for a list.
+ */
+static inline struct sk_buff **homa_next_skb(struct sk_buff *skb)
+{
+	return (struct sk_buff **)(skb_end_pointer(skb) - sizeof(char *));
+}
+
+/**
+ * homa_set_doff() - Fills in the doff TCP header field for a Homa packet.
+ * @h:     Packet header whose doff field is to be set.
+ * @size:  Size of the "header", bytes (must be a multiple of 4). This
+ *         information is used only for TSO; it's the number of bytes
+ *         that should be replicated in each segment. The bytes after
+ *         this will be distributed among segments.
+ */
+static inline void homa_set_doff(struct data_header *h, int size)
+{
+	h->common.doff = size << 2;
+}
+
+/**
+ * homa_throttle_lock() - Acquire the throttle lock. If the lock
+ * isn't immediately available, record stats on the waiting time.
+ * @homa:    Overall data about the Homa protocol implementation.
+ */
+// static inline void homa_throttle_lock(struct homa *homa)
+// 	__acquires(THROTTLE_LOCK)
+// {
+// 	if (!spin_trylock_bh(&homa->throttle_lock))
+// 		homa_throttle_lock_slow(homa);
+// }
+
+#define homa_throttle_lock(_homa) do {                 \
+	struct homa *h = _homa;                        \
+	if (!spin_trylock_bh(&h->throttle_lock))       \
+		homa_throttle_lock_slow(h);            \
+} while (0)
+
+/**
+ * homa_throttle_unlock() - Release the throttle lock.
+ * @homa:    Overall data about the Homa protocol implementation.
+ */
+static inline void homa_throttle_unlock(struct homa *homa)
+	__releases(&homa->throttle_lock)
+{
+	spin_unlock_bh(&homa->throttle_lock);
+}
+
+/** skb_is_ipv6() - Return true if the packet is encapsulated with IPv6,
+ *  false otherwise (presumably it's IPv4).
+ */
+static inline bool skb_is_ipv6(const struct sk_buff *skb)
+{
+	return ipv6_hdr(skb)->version == 6;
+}
+
+/**
+ * Given an IPv4 address, return an equivalent IPv6 address (an IPv4-mapped
+ * one)
+ * @ip4: IPv4 address, in network byte order.
+ */
+static inline struct in6_addr ipv4_to_ipv6(__be32 ip4)
+{
+	struct in6_addr ret = {};
+
+	if (ip4 == htonl(INADDR_ANY))
+		return in6addr_any;
+	ret.in6_u.u6_addr32[2] = htonl(0xffff);
+	ret.in6_u.u6_addr32[3] = ip4;
+	return ret;
+}
+
+/**
+ * ipv6_to_ipv4() - Given an IPv6 address produced by ipv4_to_ipv6, return
+ * the original IPv4 address (in network byte order).
+ * @ip6:  IPv6 address; assumed to be a mapped IPv4 address.
+ */
+static inline __be32 ipv6_to_ipv4(const struct in6_addr ip6)
+{
+	return ip6.in6_u.u6_addr32[3];
+}
+
+/**
+ * skb_canonical_ipv6_addr() - Convert a socket address to the "standard"
+ * form used in Homa, which is always an IPv6 address; if the original address
+ * was IPv4, convert it to an IPv4-mapped IPv6 address.
+ * @addr:   Address to canonicalize (if NULL, "any" is returned).
+ */
+static inline struct in6_addr canonical_ipv6_addr(const union sockaddr_in_union *addr)
+{
+	if (addr) {
+		return (addr->sa.sa_family == AF_INET6)
+			? addr->in6.sin6_addr
+			: ipv4_to_ipv6(addr->in4.sin_addr.s_addr);
+	} else {
+		return in6addr_any;
+	}
+}
+
+/**
+ * skb_canonical_ipv6_saddr() - Given a packet buffer, return its source
+ * address in the "standard" form used in Homa, which is always an IPv6
+ * address; if the original address was IPv4, convert it to an IPv4-mapped
+ * IPv6 address.
+ * @skb:   The source address will be extracted from this packet buffer.
+ */
+static inline struct in6_addr skb_canonical_ipv6_saddr(struct sk_buff *skb)
+{
+	return skb_is_ipv6(skb) ? ipv6_hdr(skb)->saddr
+				: ipv4_to_ipv6(ip_hdr(skb)->saddr);
+}
+
+/**
+ * is_mapped_ipv4() - Return true if an IPv6 address is actually an
+ * IPv4-mapped address, false otherwise.
+ * @x:  The address to check.
+ */
+static inline bool is_mapped_ipv4(const struct in6_addr x)
+{
+	return ((x.in6_u.u6_addr32[0] == 0) &&
+		(x.in6_u.u6_addr32[1] == 0) &&
+		(x.in6_u.u6_addr32[2] == htonl(0xffff)));
+}
+
+/**
+ * tt_addr() - Given an address, return a 4-byte id that will (hopefully)
+ * provide a unique identifier for the address in a timetrace record.
+ * @x:  Address (either IPv6 or IPv4-mapped IPv6)
+ */
+static inline __u32 tt_addr(const struct in6_addr x)
+{
+	return is_mapped_ipv4(x) ? ntohl(x.in6_u.u6_addr32[3])
+			: (x.in6_u.u6_addr32[3] ? ntohl(x.in6_u.u6_addr32[3])
+			: ntohl(x.in6_u.u6_addr32[1]));
+}
+
+void     homa_abort_rpcs(struct homa *homa, const struct in6_addr *addr,
+			 int port, int error);
+void     homa_abort_sock_rpcs(struct homa_sock *hsk, int error);
+void     homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+		      struct homa_rpc *rpc);
+void     homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb);
+void     homa_add_to_throttled(struct homa_rpc *rpc);
+int      homa_backlog_rcv(struct sock *sk, struct sk_buff *skb);
+int      homa_bind(struct socket *sk, struct sockaddr *addr,
+		   int addr_len);
+int      homa_check_nic_queue(struct homa *homa, struct sk_buff *skb,
+			      bool force);
+struct homa_interest *homa_choose_interest(struct homa *homa,
+					   struct list_head *head,
+					   int offset);
+void     homa_close(struct sock *sock, long timeout);
+int      homa_copy_to_user(struct homa_rpc *rpc);
+void     homa_data_from_server(struct sk_buff *skb,
+			       struct homa_rpc *crpc);
+void     homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
+void     homa_destroy(struct homa *homa);
+int      homa_disconnect(struct sock *sk, int flags);
+void     homa_dispatch_pkts(struct sk_buff *skb, struct homa *homa);
+int      homa_err_handler_v4(struct sk_buff *skb, u32 info);
+int      homa_err_handler_v6(struct sk_buff *skb,
+			     struct inet6_skb_parm *opt, u8 type,  u8 code,
+			     int offset, __be32 info);
+int      homa_fill_data_interleaved(struct homa_rpc *rpc,
+				    struct sk_buff *skb, struct iov_iter *iter);
+struct homa_gap *homa_gap_new(struct list_head *next, int start, int end);
+void     homa_gap_retry(struct homa_rpc *rpc);
+int      homa_get_port(struct sock *sk, unsigned short snum);
+int      homa_getsockopt(struct sock *sk, int level, int optname,
+			 char __user *optval, int __user *option);
+int      homa_hash(struct sock *sk);
+enum hrtimer_restart homa_hrtimer(struct hrtimer *timer);
+int      homa_init(struct homa *homa);
+void     homa_incoming_sysctl_changed(struct homa *homa);
+int      homa_ioctl(struct sock *sk, int cmd, int *karg);
+int      homa_message_in_init(struct homa_rpc *rpc, int length);
+int      homa_message_out_fill(struct homa_rpc *rpc,
+			       struct iov_iter *iter, int xmit);
+void     homa_message_out_init(struct homa_rpc *rpc, int length);
+void     homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+			   struct homa_rpc *rpc);
+struct sk_buff *homa_new_data_packet(struct homa_rpc *rpc,
+				     struct iov_iter *iter, int offset,
+				     int length, int max_seg_data);
+void     homa_outgoing_sysctl_changed(struct homa *homa);
+int      homa_pacer_main(void *transport);
+void     homa_pacer_stop(struct homa *homa);
+void     homa_pacer_xmit(struct homa *homa);
+__poll_t homa_poll(struct file *file, struct socket *sock,
+		   struct poll_table_struct *wait);
+int      homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+		      int flags, int *addr_len);
+int      homa_register_interests(struct homa_interest *interest,
+				 struct homa_sock *hsk, int flags, __u64 id);
+void     homa_remove_from_throttled(struct homa_rpc *rpc);
+void     homa_resend_data(struct homa_rpc *rpc, int start, int end);
+void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
+			 struct homa_sock *hsk);
+void     homa_rpc_abort(struct homa_rpc *crpc, int error);
+void     homa_rpc_acked(struct homa_sock *hsk,
+			const struct in6_addr *saddr, struct homa_ack *ack);
+void     homa_rpc_free(struct homa_rpc *rpc);
+void     homa_rpc_handoff(struct homa_rpc *rpc);
+int      homa_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
+int      homa_setsockopt(struct sock *sk, int level, int optname,
+			 sockptr_t optval, unsigned int optlen);
+int      homa_shutdown(struct socket *sock, int how);
+int      homa_softirq(struct sk_buff *skb);
+void     homa_spin(int ns);
+char    *homa_symbol_for_type(uint8_t type);
+void     homa_timer(struct homa *homa);
+int      homa_timer_main(void *transport);
+void     homa_unhash(struct sock *sk);
+void     homa_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
+struct homa_rpc *homa_wait_for_message(struct homa_sock *hsk, int flags,
+				       __u64 id);
+int      homa_xmit_control(enum homa_packet_type type, void *contents,
+			   size_t length, struct homa_rpc *rpc);
+int      __homa_xmit_control(void *contents, size_t length,
+			     struct homa_peer *peer, struct homa_sock *hsk);
+void     homa_xmit_data(struct homa_rpc *rpc, bool force);
+void     __homa_xmit_data(struct sk_buff *skb, struct homa_rpc *rpc);
+void     homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk);
+
+/**
+ * homa_check_pacer() - This method is invoked at various places in Homa to
+ * see if the pacer needs to transmit more packets and, if so, transmit
+ * them. It's needed because the pacer thread may get descheduled by
+ * Linux, result in output stalls.
+ * @homa:    Overall data about the Homa protocol implementation. No locks
+ *           should be held when this function is invoked.
+ * @softirq: Nonzero means this code is running at softirq (bh) level;
+ *           zero means it's running in process context.
+ */
+static inline void homa_check_pacer(struct homa *homa, int softirq)
+{
+	if (list_empty(&homa->throttled_rpcs))
+		return;
+
+	/* The ">> 1" in the line below gives homa_pacer_main the first chance
+	 * to queue new packets; if the NIC queue becomes more than half
+	 * empty, then we will help out here.
+	 */
+	if ((sched_clock() + (homa->max_nic_queue_ns >> 1)) <
+			atomic64_read(&homa->link_idle_time))
+		return;
+	homa_pacer_xmit(homa);
+}
+
+extern struct completion homa_pacer_kthread_done;
+#endif /* _HOMA_IMPL_H */
diff --git a/net/homa/homa_stub.h b/net/homa/homa_stub.h
new file mode 100644
index 000000000000..fb2ba4195dd2
--- /dev/null
+++ b/net/homa/homa_stub.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file contains stripped-down replacements that have been
+ * temporarily removed from Homa during the Linux upstreaming
+ * process. By the time upstreaming is complete this file will
+ * have gone away.
+ */
+
+#ifndef _HOMA_STUB_H
+#define _HOMA_STUB_H
+
+#include "homa_impl.h"
+
+static inline int homa_skb_append_from_iter(struct homa *homa,
+					    struct sk_buff *skb,
+					    struct iov_iter *iter, int length)
+{
+	char *dst = skb_put(skb, length);
+
+	if (copy_from_iter(dst, length, iter) != length)
+		return -EFAULT;
+	return 0;
+}
+
+static inline int homa_skb_append_to_frag(struct homa *homa, struct sk_buff *skb,
+					  void *buf, int length)
+{
+	char *dst = skb_put(skb, length);
+
+	memcpy(dst, buf, length);
+	return 0;
+}
+
+static inline int  homa_skb_append_from_skb(struct homa *homa,
+					    struct sk_buff *dst_skb,
+					    struct sk_buff *src_skb,
+					    int offset, int length)
+{
+	return homa_skb_append_to_frag(homa, dst_skb,
+			skb_transport_header(src_skb) + offset, length);
+}
+
+static inline void homa_skb_free_tx(struct homa *homa, struct sk_buff *skb)
+{
+	kfree_skb(skb);
+}
+
+static inline void homa_skb_free_many_tx(struct homa *homa,
+					 struct sk_buff **skbs, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		kfree_skb(skbs[i]);
+}
+
+static inline void homa_skb_get(struct sk_buff *skb, void *dest, int offset,
+				int length)
+{
+	memcpy(dest, skb_transport_header(skb) + offset, length);
+}
+
+static inline struct sk_buff *homa_skb_new_tx(int length)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(HOMA_SKB_EXTRA + HOMA_IPV6_HEADER_LENGTH +
+			sizeof(struct homa_skb_info) + length,
+			GFP_KERNEL);
+	if (likely(skb)) {
+		skb_reserve(skb, HOMA_SKB_EXTRA + HOMA_IPV6_HEADER_LENGTH);
+		skb_reset_transport_header(skb);
+	}
+	return skb;
+}
+
+static inline void homa_skb_stash_pages(struct homa *homa, int length)
+{}
+
+#endif /* _HOMA_STUB_H */
-- 
2.34.1


