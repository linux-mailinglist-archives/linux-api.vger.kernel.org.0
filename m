Return-Path: <linux-api+bounces-3790-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144A5ABA062
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82EC7AE019
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBABB1DE2BF;
	Fri, 16 May 2025 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="PNXo8LGN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="jPoTpixH"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4F1C5D5A;
	Fri, 16 May 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410969; cv=none; b=g4MvxGg6gJiFs48Hm6sxmxw52fVKxX8huWM9MfwMwHqiBzdC55hDmGD6XmCOEsyg2QmEfJfCTzIV4qePG2z+VtuFScG3k1/4S1PfJZ6wEUROUpAgpYKFA9hZ6Cf3UWGgVLn6ZS7Dgvevh27TeZ46WqtEJpJQeFgFJvyWbPY/3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410969; c=relaxed/simple;
	bh=n7GL3JfX/o1loCKYYkVIDuL0l6MlqVUcQldRYUX0bvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9SpvbCrZU5RcSY3kqZn3kKitP/O2JXXd1NJ7jSpcO4MYcYexdaTtF7GymA+P8BimWmVzRobVW/VCSeOdapzlc84Ce9+ExjOnRBRbCCGxW6HoULSSirGDq77A/syXtWuKVkbkRi/nCZnWaYaswPoCyWoxqwHvnGRCjMWV6DEjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=PNXo8LGN; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=jPoTpixH; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=nb9WRft/OW0n5bm53JjdN0ibz9K5wZCUesZrN5O6JLQ=; b=PNXo8LGNoEL7LfS
	BAnijC0UG6rR5L8WGpxv6ZJOohm0kehFKXxN2C6D7ah6JUgJvUPa54y4ysaxE6Gld7oa/CQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=nb9WRft/OW0n5bm53JjdN0ibz9K5wZCUesZrN5O6JLQ=; b=jPoTpixHRPJH06b
	00yAhlDX0nW+4gryo9Tz+pKbemOgnbbGytBShYYQ2quPtVGu7VduSl1iW0R+tV4a1WU1FSYE/L30Q
	/9Z0hCAJaOaaADNaXt84UpOKH0+gN16YJhUKagRVP2EDJUzfiacTADMgypqbZkm5Yhy6brfJzntFb
	lkvAuN3mvO4WwHS5WS3hv6gPaWZ9JiFzSt+Y2jXW2jlgfZDod0pgIHdwtb7cAAQ2o2q6MYptiHiNU
	VksddylKSzWltSAP75Hb16vebliW8L4HjXthiai40s4dc6TKFByPMkM3GTnAuLGqKH535YCm3JXbd
	nqYpLgdXKqHgng2yJHw==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uFxPn-00000007363-22h5
	(return-path <jgh@exim.org>);
	Fri, 16 May 2025 15:56:03 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH 3/6] tcp: fastopen: add write-data to fastopen synack packet
Date: Fri, 16 May 2025 16:55:01 +0100
Message-ID: <0207fe2dbc9a30a27e0ad059e3ec181a91e6c19f.1747409911.git.jgh@exim.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747409911.git.jgh@exim.org>
References: <cover.1747409911.git.jgh@exim.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

While building the synack packet, for a fastopen socket
copy data from write queue to the packet.
Move the data from write queue to retransmit queue.

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 net/ipv4/tcp_output.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3ac8d2d17e1f..c50553c1c795 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3702,7 +3702,7 @@ int tcp_send_synack(struct sock *sk)
 
 /**
  * tcp_make_synack - Allocate one skb and build a SYNACK packet.
- * @sk: listener socket
+ * @sk: listener socket (or child socket for fastopen)
  * @dst: dst entry attached to the SYNACK. It is consumed and caller
  *       should not use it again.
  * @req: request_sock pointer
@@ -3719,6 +3719,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	struct inet_request_sock *ireq = inet_rsk(req);
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_out_options opts;
+	struct sock *fastopen_sk = (struct sock *)sk;
 	struct tcp_key key = {};
 	struct sk_buff *skb;
 	int tcp_header_size;
@@ -3748,7 +3749,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 		 * cpu might call us concurrently.
 		 * sk->sk_wmem_alloc in an atomic, we can promote to rw.
 		 */
-		skb_set_owner_w(skb, (struct sock *)sk);
+		skb_set_owner_w(skb, fastopen_sk);
 		break;
 	}
 	skb_dst_set(skb, dst);
@@ -3831,6 +3832,33 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	th->window = htons(min(req->rsk_rcv_wnd, 65535U));
 	tcp_options_write(th, NULL, tcp_rsk(req), &opts, &key);
 	th->doff = (tcp_header_size >> 2);
+
+	/* If this is a FASTOPEN, and there is write-data on the accept socket,
+	 * re-copy it to the synack segment. If not FASTOPEN. any data waits
+	 * until 3rd-ack arrival.
+	 */
+
+	if (synack_type == TCP_SYNACK_FASTOPEN &&
+	    !skb_queue_empty(&sk->sk_write_queue)) {
+		struct sk_buff *a_skb = tcp_write_queue_tail(sk);
+		int copy = min_t(int, a_skb->len, skb_tailroom(skb));
+
+		skb_put_data(skb, a_skb->data, copy);
+		TCP_SKB_CB(skb)->end_seq += copy;
+
+		tcp_skb_pcount_set(a_skb, 1);
+		WRITE_ONCE(tcp_sk(fastopen_sk)->write_seq,
+			   TCP_SKB_CB(a_skb)->end_seq);
+
+		skb_set_delivery_time(a_skb, now, SKB_CLOCK_MONOTONIC);
+
+		/* Move the data to the retransmit queue.
+		 * Code elsewhere implies this is a full child socket and
+		 * can be treated as writeable - permitting the cast.
+		 */
+		tcp_event_new_data_sent(fastopen_sk, a_skb);
+	}
+
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 
 	/* Okay, we have all we need - do the md5 hash if needed */
-- 
2.49.0


