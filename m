Return-Path: <linux-api+bounces-3836-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46CABF355
	for <lists+linux-api@lfdr.de>; Wed, 21 May 2025 13:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AC13AEC59
	for <lists+linux-api@lfdr.de>; Wed, 21 May 2025 11:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A3265CB6;
	Wed, 21 May 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="HazkByk6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="VG/kzCoW"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A016265633;
	Wed, 21 May 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828205; cv=none; b=VOo8S61xEwltMA3OSipeGSB0AS8w/dIThY9OkHdHrZKFq5+hYWzfkSrE0fZ6HSsFpec7zAQ4XjAyIjf/k+YNz8GhdqRFdE29xkQ8AJAQCrK7V/29kajQc/NGfF7k8V1Git3ghYgnomr4XcuhINlT4FENZeJ+bMSF2ZlAPimbeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828205; c=relaxed/simple;
	bh=8R+W4oVEJoSwN26pxY0PmMLqYAqygI+BWRqAhVn6+5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k46kJOOpvQmODn3BAy6ZaroK0Z9q2bBCh87W0PX5bml0aMdsbl1A+TDCKDa0LqwOkrEU/yoajX08UWZnrZ0hCzOz931ZhVJrwIhyKg+PFAMVLs+VEBhwbx78QGVQrqUq5Ml0W0tamqdDjvvUKhxDG1wO7p00mWn4vFv5qkITUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=HazkByk6; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=VG/kzCoW; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=NZq41W+GrtefNdEUbFkTNDa8Ss05cbXfFVdbvBLZRlQ=; b=HazkByk6DZi4Y8Y
	2B7Y6IEQL9lJscvep8TpTyN1xHlQFEhaGT5tMHuU7TgzRubctDFDwuQFnj/AS0THxg3gwDg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=NZq41W+GrtefNdEUbFkTNDa8Ss05cbXfFVdbvBLZRlQ=; b=VG/kzCoWZFhgEUZ
	wbpRu9NhIb/L/VTRYHL5SYmztsJb6LbF5BpSa3y73d9SwwQLhaQ0CFigjCcVH0rxixDL4K+nL8Q4e
	BuC3cO0QCQz8p7QcZb9lb6nCcGe1SZWh8out3YKXOqIO2sA639sPdpcBs7aPL9tir7EFmSz28jeq/
	SjtCqTybzhXEAYnQG0bpIWM0oPNqipxjf5s8p5RRQYpyd0y0GB9UvLmwda+z3+Yb7G5/0F9/qdWPU
	abeu2NuvXL37dCU9PJah/Mhlystd+mFDcuYrSMr9laWahfmxCK/driD7Grij5vRiBeHTSOLiUF/dK
	SonKI3XGdc118gy9ikw==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uHht9-00000001yTm-1FD0
	(return-path <jgh@exim.org>);
	Wed, 21 May 2025 11:45:35 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next v2 2/6] tcp: copy write-data from listen socket to accept child socket
Date: Wed, 21 May 2025 12:45:01 +0100
Message-ID: <d1f6e022bd0e22a7904d4a345296dae2d9b7dd62.1747826775.git.jgh@exim.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747826775.git.jgh@exim.org>
References: <cover.1747826775.git.jgh@exim.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

Set the request_sock flag for fastopen earlier, making it available
to the af_ops SYN-handler function.

In that function copy data from the listen socket write queue into an
sk_buff, allocating if needed and adding to the write queue of the
newly-created child socket.
Set sequence number values depending on the fastopen status.

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 net/ipv4/tcp_fastopen.c  |  3 ++-
 net/ipv4/tcp_ipv4.c      |  4 +--
 net/ipv4/tcp_minisocks.c | 58 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 9b83d639b5ac..03a86d0b87ba 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -245,6 +245,8 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	struct sock *child;
 	bool own_req;
 
+	tcp_rsk(req)->tfo_listener = true;
+
 	child = inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
 							 NULL, &own_req);
 	if (!child)
@@ -261,7 +263,6 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	tp = tcp_sk(child);
 
 	rcu_assign_pointer(tp->fastopen_rsk, req);
-	tcp_rsk(req)->tfo_listener = true;
 
 	/* RFC1323: The window in SYN & SYN/ACK segments is never
 	 * scaled. So correct it appropriately.
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..e488effdbdb2 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1747,8 +1747,8 @@ EXPORT_IPV6_MOD(tcp_v4_conn_request);
 
 
 /*
- * The three way handshake has completed - we got a valid synack -
- * now create the new socket.
+ * The three way handshake has completed - we got a valid synack
+ * (or a FASTOPEN syn) - now create the new socket.
  */
 struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 				  struct request_sock *req,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 43d7852ce07e..d471531b4a78 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -529,7 +529,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	struct inet_connection_sock *newicsk;
 	const struct tcp_sock *oldtp;
 	struct tcp_sock *newtp;
-	u32 seq;
+	u32 seq, a_seq, n_seq;
 
 	if (!newsk)
 		return NULL;
@@ -550,9 +550,55 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->segs_in = 1;
 
 	seq = treq->snt_isn + 1;
-	newtp->snd_sml = newtp->snd_una = seq;
-	WRITE_ONCE(newtp->snd_nxt, seq);
-	newtp->snd_up = seq;
+	n_seq = seq;
+	a_seq = seq;
+	newtp->write_seq = seq;
+	newtp->snd_una = seq;
+
+	/* If there is write-data sitting on the listen socket, copy it to
+	 * the accept socket. If FASTOPEN we will send it on the synack,
+	 * otherwise it sits there until 3rd-ack arrives.
+	 */
+
+	if (unlikely(!skb_queue_empty(&sk->sk_write_queue))) {
+		struct sk_buff *l_skb = tcp_send_head(sk),
+				*a_skb = tcp_write_queue_tail(newsk);
+		ssize_t copy = 0;
+
+		if (a_skb)
+			copy = l_skb->len - a_skb->len;
+
+		if (copy <= 0 || !tcp_skb_can_collapse_to(a_skb)) {
+			bool first_skb = tcp_rtx_and_write_queues_empty(newsk);
+
+			a_skb = tcp_stream_alloc_skb(newsk,
+						     newsk->sk_allocation,
+						     first_skb);
+			if (!a_skb) {
+				/* is this the correct free? */
+				bh_unlock_sock(newsk);
+				sk_free(newsk);
+				return NULL;
+			}
+
+			tcp_skb_entail(newsk, a_skb);
+		}
+		copy = min_t(int, l_skb->len, skb_tailroom(a_skb));
+		skb_put_data(a_skb, l_skb->data, copy);
+
+		TCP_SKB_CB(a_skb)->end_seq += copy;
+
+		a_seq += l_skb->len;
+
+		if (treq->tfo_listener)
+			seq = a_seq;
+
+		/* assumes only one skb on the listen write queue */
+	}
+
+	newtp->snd_sml = seq;
+	WRITE_ONCE(newtp->snd_nxt, a_seq);
+	newtp->snd_up = n_seq;
 
 	INIT_LIST_HEAD(&newtp->tsq_node);
 	INIT_LIST_HEAD(&newtp->tsorted_sent_queue);
@@ -567,7 +613,9 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->total_retrans = req->num_retrans;
 
 	tcp_init_xmit_timers(newsk);
-	WRITE_ONCE(newtp->write_seq, newtp->pushed_seq = treq->snt_isn + 1);
+
+	newtp->pushed_seq = n_seq;
+	WRITE_ONCE(newtp->write_seq, a_seq);
 
 	if (sock_flag(newsk, SOCK_KEEPOPEN))
 		tcp_reset_keepalive_timer(newsk, keepalive_time_when(newtp));
-- 
2.49.0


