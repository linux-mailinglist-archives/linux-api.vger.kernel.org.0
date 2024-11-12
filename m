Return-Path: <linux-api+bounces-2699-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C1D9C49F7
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 00:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4048B29CAB
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2024 23:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B411BE243;
	Mon, 11 Nov 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="FW4XmRNE"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC41BD9CD
	for <linux-api@vger.kernel.org>; Mon, 11 Nov 2024 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368450; cv=none; b=V4zmm6NX32RxJ0xEIaxaDusQp/kgbKo9d1fDH8akKWnWKVrgkjPInvjBrLZsc6k3O1r6GTj6pPc0iPHCJZj9Oy7VtNyXrNXIw9cyu3BoGB/Fi7g3aGU7ji3yDevy9zniP4XgcUNmPaYjCNzqbFwMB03Iie1loMAQHLXzvm85r6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368450; c=relaxed/simple;
	bh=zlnLUOim/QaHKJc9UofPvMKXSv0FNklj9ig6zWE++P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o62Zkr/9ECEuNxZs/2SFfHbpvys5uEvK7wq7M5KBLzZBBuqfnJHJa8MMX4zQ5xxkJPBgM4RIOWfNA1v48Wm+1cnSG2e3ywZ3OGHczQtiIzXTyI1oVtLaIZJC//MfHxA5Oa9MX5Xv37+dUyc/88mAFWoWQt0DZ4gAYS3uMAkpwOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=FW4XmRNE; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i1+hFTKpDJbk7fQaYfHZF1/cNOl8KtR9xjMKGxdgykY=; t=1731368448; x=1732232448; 
	b=FW4XmRNEdyrNDTnM5TUDu0u+smt6mNSKuf/IwR4RYD+1emjooBFxjZCwHJiJX7Uj3Xz4ePdq2vC
	9ZkKu3dtqDgso+xFxAAkw2aSbm2FFr2+yOJoXuAJMT1hDDIGMmblUv/cEe47VeUzGwm4tehCDpLCt
	wxU0owIiKTTGiqQcqqXYAyXiwmF7f3fZOwAyRw/vTP9GcszAGWBKoXLQ+qHqbrEdnD1LVK4To5Qp+
	vdRnWb9iKPfla6ImfjI21ZTL8UoIY9yXhp+SxxjC+LdQsN3Mre2tc2ajYIeG5KRkMlOQ8AMjdF/tk
	z/9f+Xv/iPVmZV9ahauD1pJZj38gtRR7t5Bg==;
Received: from ouster448.stanford.edu ([172.24.72.71]:54467 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tAe1R-0002NP-LE; Mon, 11 Nov 2024 15:40:42 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v2 02/12] net: homa: define Homa packet formats
Date: Mon, 11 Nov 2024 15:39:55 -0800
Message-ID: <20241111234006.5942-3-ouster@cs.stanford.edu>
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
X-Scan-Signature: a4197552717df0bd80eeda27cbeae713

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_wire.h | 378 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 378 insertions(+)
 create mode 100644 net/homa/homa_wire.h

diff --git a/net/homa/homa_wire.h b/net/homa/homa_wire.h
new file mode 100644
index 000000000000..d7b87dc88cc1
--- /dev/null
+++ b/net/homa/homa_wire.h
@@ -0,0 +1,378 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file defines the on-the-wire format of Homa packets. */
+
+#ifndef _HOMA_WIRE_H
+#define _HOMA_WIRE_H
+
+#include <linux/skbuff.h>
+
+/**
+ * enum homa_packet_type - Defines the possible types of Homa packets.
+ *
+ * See the xxx_header structs below for more information about each type.
+ */
+enum homa_packet_type {
+	DATA               = 0x10,
+	RESEND             = 0x12,
+	UNKNOWN            = 0x13,
+	BUSY               = 0x14,
+	NEED_ACK           = 0x17,
+	ACK                = 0x18,
+	BOGUS              = 0x19,      /* Used only in unit tests. */
+	/* If you add a new type here, you must also do the following:
+	 * 1. Change BOGUS so it is the highest opcode
+	 * 2. Add support for the new opcode in homa_print_packet,
+	 *    homa_print_packet_short, homa_symbol_for_type, and mock_skb_new.
+	 * 3. Add the header length to header_lengths in homa_plumbing.c.
+	 */
+};
+
+/** define HOMA_IPV6_HEADER_LENGTH - Size of IP header (V6). */
+#define HOMA_IPV6_HEADER_LENGTH 40
+
+/** define HOMA_IPV4_HEADER_LENGTH - Size of IP header (V4). */
+#define HOMA_IPV4_HEADER_LENGTH 20
+
+/**
+ * define HOMA_SKB_EXTRA - How many bytes of additional space to allow at the
+ * beginning of each sk_buff, before the IP header. This includes room for a
+ * VLAN header and also includes some extra space, "just to be safe" (not
+ * really sure if this is needed).
+ */
+#define HOMA_SKB_EXTRA 40
+
+/**
+ * define HOMA_ETH_OVERHEAD - Number of bytes per Ethernet packet for Ethernet
+ * header, CRC, preamble, and inter-packet gap.
+ */
+#define HOMA_ETH_OVERHEAD 42
+
+/**
+ * define HOMA_MIN_PKT_LENGTH - Every Homa packet must be padded to at least
+ * this length to meet Ethernet frame size limitations. This number includes
+ * Homa headers and data, but not IP or Ethernet headers.
+ */
+#define HOMA_MIN_PKT_LENGTH 26
+
+/**
+ * define HOMA_MAX_HEADER - Number of bytes in the largest Homa header.
+ */
+#define HOMA_MAX_HEADER 90
+
+/**
+ * define ETHERNET_MAX_PAYLOAD - Maximum length of an Ethernet packet,
+ * excluding preamble, frame delimeter, VLAN header, CRC, and interpacket gap;
+ * i.e. all of this space is available for Homa.
+ */
+#define ETHERNET_MAX_PAYLOAD 1500
+
+/**
+ * define HOMA_MAX_PRIORITIES - The maximum number of priority levels that
+ * Homa can use (the actual number can be restricted to less than this at
+ * runtime). Changing this value will affect packet formats.
+ */
+#define HOMA_MAX_PRIORITIES 8
+
+/**
+ * struct common_header - Wire format for the first bytes in every Homa
+ * packet. This must (mostly) match the format of a TCP header to enable
+ * Homa packets to actually be transmitted as TCP packets (and thereby
+ * take advantage of TSO and other features).
+ */
+struct common_header {
+	/**
+	 * @sport: Port on source machine from which packet was sent.
+	 * Must be in the same position as in a TCP header.
+	 */
+	__be16 sport;
+
+	/**
+	 * @dport: Port on destination that is to receive packet. Must be
+	 * in the same position as in a TCP header.
+	 */
+	__be16 dport;
+
+	/**
+	 * @sequence: corresponds to the sequence number field in TCP headers;
+	 * used in DATA packets to hold the offset in the message of the first
+	 * byte of data. This value will only be correct in the first segment
+	 * of a GSO packet.
+	 */
+	__be32 sequence;
+
+	/**
+	 * The fields below correspond to the acknowledgment field in TCP
+	 * headers; not used by Homa, except for the low-order 8 bits, which
+	 * specify the Homa packet type (one of the values in the
+	 * homa_packet_type enum).
+	 */
+	__be16 ack1;
+	__u8 ack2;
+	__u8 type;
+
+	/**
+	 * @doff: High order 4 bits holds the number of 4-byte chunks in a
+	 * data_header (low-order bits unused). Used only for DATA packets;
+	 * must be in the same position as the data offset in a TCP header.
+	 * Used by TSO to determine where the replicated header portion ends.
+	 */
+	__u8 doff;
+
+	__u8 dummy1;
+
+	/**
+	 * @window: Corresponds to the window field in TCP headers. Not used
+	 * by HOMA.
+	 */
+	__be16 window;
+
+	/**
+	 * @checksum: not used by Homa, but must occupy the same bytes as
+	 * the checksum in a TCP header (TSO may modify this?).
+	 */
+	__be16 checksum;
+
+	__be16 dummy2;
+
+	/**
+	 * @sender_id: the identifier of this RPC as used on the sender (i.e.,
+	 * if the low-order bit is set, then the sender is the server for
+	 * this RPC).
+	 */
+	__be64 sender_id;
+} __packed;
+
+/**
+ * struct homa_ack - Identifies an RPC that can be safely deleted by its
+ * server. After sending the response for an RPC, the server must retain its
+ * state for the RPC until it knows that the client has successfully
+ * received the entire response. An ack indicates this. Clients will
+ * piggyback acks on future data packets, but if a client doesn't send
+ * any data to the server, the server will eventually request an ack
+ * explicitly with a NEED_ACK packet, in which case the client will
+ * return an explicit ACK.
+ */
+struct homa_ack {
+	/**
+	 * @id: The client's identifier for the RPC. 0 means this ack
+	 * is invalid.
+	 */
+	__be64 client_id;
+
+	/** @client_port: The client-side port for the RPC. */
+	__be16 client_port;
+
+	/** @server_port: The server-side port for the RPC. */
+	__be16 server_port;
+} __packed;
+
+/* struct data_header - Contains data for part or all of a Homa message.
+ * An incoming packet consists of a data_header followed by message data.
+ * An outgoing packet can have this simple format as well, or it can be
+ * structured as a GSO packet. GSO packets look like this:
+ *
+ *    No hijacking:
+ *
+ *    |-----------------------|
+ *    |                       |
+ *    |     data_header       |
+ *    |                       |
+ *    |---------------------- |
+ *    |                       |
+ *    |                       |
+ *    |     segment data      |
+ *    |                       |
+ *    |                       |
+ *    |-----------------------|
+ *    |      seg_header       |
+ *    |-----------------------|
+ *    |                       |
+ *    |                       |
+ *    |     segment data      |
+ *    |                       |
+ *    |                       |
+ *    |-----------------------|
+ *    |      seg_header       |
+ *    |-----------------------|
+ *    |                       |
+ *    |                       |
+ *    |     segment data      |
+ *    |                       |
+ *    |                       |
+ *    |-----------------------|
+ *
+ * TSO will not adjust @common.sequence in the segments, so Homa sprinkles
+ * correct offsets (in seg_headers) throughout the segment data; TSO/GSO
+ * will include a different seg_header in each generated packet.
+ */
+
+struct seg_header {
+	/**
+	 * @offset: Offset within message of the first byte of data in
+	 * this segment.
+	 */
+	__be32 offset;
+} __packed;
+
+struct data_header {
+	struct common_header common;
+
+	/** @message_length: Total #bytes in the message. */
+	__be32 message_length;
+
+	/**
+	 * @incoming: The receiver can expect the sender to send all of the
+	 * bytes in the message up to at least this offset (exclusive),
+	 * even without additional grants. This includes unscheduled
+	 * bytes, granted bytes, plus any additional bytes the sender
+	 * transmits unilaterally (e.g., to round up to a full GSO batch).
+	 */
+	__be32 incoming;
+
+	/** @ack: If the @client_id field of this is nonzero, provides info
+	 * about an RPC that the recipient can now safely free. Note: in
+	 * TSO packets this will get duplicated in each of the segments;
+	 * in order to avoid repeated attempts to ack the same RPC,
+	 * homa_gro_receive will clear this field in all segments but the
+	 * first.
+	 */
+	struct homa_ack ack;
+
+	__be16 dummy;
+
+	/**
+	 * @retransmit: 1 means this packet was sent in response to a RESEND
+	 * (it has already been sent previously).
+	 */
+	__u8 retransmit;
+
+	__u8 pad;
+
+	/** @seg: First of possibly many segments. */
+	struct seg_header seg;
+} __packed;
+_Static_assert(sizeof(struct data_header) <= HOMA_MAX_HEADER,
+	       "data_header too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+_Static_assert(sizeof(struct data_header) >= HOMA_MIN_PKT_LENGTH,
+	       "data_header too small: Homa doesn't currently have codeto pad data packets");
+_Static_assert(((sizeof(struct data_header) - sizeof(struct seg_header)) & 0x3) == 0,
+	       " data_header length not a multiple of 4 bytes (required for TCP/TSO compatibility");
+
+/**
+ * homa_data_len() - Returns the total number of bytes in a DATA packet
+ * after the data_header. Note: if the packet is a GSO packet, the result
+ * may include metadata as well as packet data.
+ */
+static inline int homa_data_len(struct sk_buff *skb)
+{
+	return skb->len - skb_transport_offset(skb) - sizeof(struct data_header);
+}
+
+/**
+ * struct resend_header - Wire format for RESEND packets.
+ *
+ * A RESEND is sent by the receiver when it believes that message data may
+ * have been lost in transmission (or if it is concerned that the sender may
+ * have crashed). The receiver should resend the specified portion of the
+ * message, even if it already sent it previously.
+ */
+struct resend_header {
+	/** @common: Fields common to all packet types. */
+	struct common_header common;
+
+	/**
+	 * @offset: Offset within the message of the first byte of data that
+	 * should be retransmitted.
+	 */
+	__be32 offset;
+
+	/**
+	 * @length: Number of bytes of data to retransmit; this could specify
+	 * a range longer than the total message size. Zero is a special case
+	 * used by servers; in this case, there is no need to actually resend
+	 * anything; the purpose of this packet is to trigger an UNKNOWN
+	 * response if the client no longer cares about this RPC.
+	 */
+	__be32 length;
+} __packed;
+_Static_assert(sizeof(struct resend_header) <= HOMA_MAX_HEADER,
+	       "resend_header too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+
+/**
+ * struct unknown_header - Wire format for UNKNOWN packets.
+ *
+ * An UNKNOWN packet is sent by either server or client when it receives a
+ * packet for an RPC that is unknown to it. When a client receives an
+ * UNKNOWN packet it will typically restart the RPC from the beginning;
+ * when a server receives an UNKNOWN packet it will typically discard its
+ * state for the RPC.
+ */
+struct unknown_header {
+	/** @common: Fields common to all packet types. */
+	struct common_header common;
+} __packed;
+_Static_assert(sizeof(struct unknown_header) <= HOMA_MAX_HEADER,
+	       "unknown_header too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+
+/**
+ * struct busy_header - Wire format for BUSY packets.
+ *
+ * These packets tell the recipient that the sender is still alive (even if
+ * it isn't sending data expected by the recipient).
+ */
+struct busy_header {
+	/** @common: Fields common to all packet types. */
+	struct common_header common;
+} __packed;
+_Static_assert(sizeof(struct busy_header) <= HOMA_MAX_HEADER,
+	       "busy_header too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+
+/**
+ * struct need_ack_header - Wire format for NEED_ACK packets.
+ *
+ * These packets ask the recipient (a client) to return an ACK message if
+ * the packet's RPC is no longer active.
+ */
+struct need_ack_header {
+	/** @common: Fields common to all packet types. */
+	struct common_header common;
+} __packed;
+_Static_assert(sizeof(struct need_ack_header) <= HOMA_MAX_HEADER,
+	       "need_ack_header too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+
+/**
+ * struct ack_header - Wire format for ACK packets.
+ *
+ * These packets are sent from a client to a server to indicate that
+ * a set of RPCs is no longer active on the client, so the server can
+ * free any state it may have for them.
+ */
+struct ack_header {
+	/** @common: Fields common to all packet types. */
+	struct common_header common;
+
+	/** @num_acks: number of (leading) elements in @acks that are valid. */
+	__be16 num_acks;
+
+#define HOMA_MAX_ACKS_PER_PKT 5
+	struct homa_ack acks[HOMA_MAX_ACKS_PER_PKT];
+} __packed;
+_Static_assert(sizeof(struct ack_header) <= HOMA_MAX_HEADER,
+	       "ack_header too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+
+/**
+ * homa_local_id(): given an RPC identifier from an input packet (which
+ * is network-encoded), return the decoded id we should use for that
+ * RPC on this machine.
+ * @sender_id:  RPC id from an incoming packet, such as h->common.sender_id
+ */
+static inline __u64 homa_local_id(__be64 sender_id)
+{
+	/* If the client bit was set on the sender side, it needs to be
+	 * removed here, and conversely.
+	 */
+	return be64_to_cpu(sender_id) ^ 1;
+}
+
+#endif /* _HOMA_WIRE_H */
-- 
2.34.1


