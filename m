Return-Path: <linux-api+bounces-5925-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNWaBA4hsWkOrQIAu9opvQ
	(envelope-from <linux-api+bounces-5925-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:00:14 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C8D25E539
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F0923006810
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6A23BC695;
	Wed, 11 Mar 2026 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaPSH409"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0033BB9F7
	for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215799; cv=none; b=DooUhIedyBmD29avSrhzakXe8WQqPJ9LTaWMqhfkCJmb8PSMLwE+QctuD0G4KaI//VUoiEfLWztjww7sPBMs9KmoxqmF88gsRTis6p9YkWjf3zpVCHIS2UT72CqTLb4+/jQuo/SVN1v9NUcV1i1hzj9qQpm49+UJ53swXcBqOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215799; c=relaxed/simple;
	bh=ePqPnwQ/F2I2migGyX7cR8MPgEP4dU5kjufej9umejg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d97k0XCBCpS1JcwLX9rqeaLt+fxiy98I3V8Icqu2LK6v8VLfXySVi0LP8ilhPiXWcZr97SSCI6x9BcOwYU8AvKAerWM/jhjDEd2YcIERmeGSee+t0VP0uBeNSkcGPhuM0p9codgyGr+j/2EMYb3lZPicIdglQSAKS4UmEFQ4BJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaPSH409; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d74c1157a4so2739290a34.1
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215793; x=1773820593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bbor1ZYXGNJCT22C8JYZ8ruTnAFylNvT3LJ2XPYETWo=;
        b=AaPSH409ofW22colwt/fc83kgrgzPTOjyuS4QkHKhjnMM7DAEz3gFEYcjW30OWvuvw
         d2jrxJs8Vri7fMUEAt/8NYZ9F54ZKUdKzhQY5tt9/oJsvMNRIQ1dPALjGexfbN5PY3ww
         zC9xKNDWTQSJvXkvO2yfmHgcANk65ZQnri4qb+CuvhwKuot4r7AMJZyqI+SYn57fi8GN
         FO0m9KDoMhpH8Yv/aMzL4LTkp/EiJEgDIH0apRHqUGVwYpE9QlaUEgivHn1CTniy7yEu
         AwM+/w2u/8GBTPgE1Vwd+G3H11qCyvb1vNYKpJAyVZsuI3RQ8IG8R+kJLYp9NV3DNNNN
         9mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215793; x=1773820593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bbor1ZYXGNJCT22C8JYZ8ruTnAFylNvT3LJ2XPYETWo=;
        b=quUs0Ol4g1McTjAYet4cK4vagOF9C2STcoJZGxgawvUN4HTqkYySVP8SpoeOuvwf3Z
         ZVPNVDbZYc0+A3LBg/cKB9ydSaymLoaKxVDvwCQUGyCNPtFGSZqT+2H4oI7R84EkUzaO
         uRxvkQS/0t8iENtQW24KymLtnSvwnFMsbrxbZ8T+r7jIlQ9HnqRMDeCFm3VgbFalMkvA
         sZ4HmxXPTlN6XfI8trjDhnmyJE79aiJpiNhTfRyg8ivV2qjKZyyY+BmI41kc0OKLFjS3
         rbs7NJkBuFWcxN/YUG/8yn+SzDCZGC8eJOdvP2OEYewnya22cDc4r9knqEoqy+oIKxBG
         NpXg==
X-Forwarded-Encrypted: i=1; AJvYcCViEc3i0G5XwTIFiiQLdOVUEw33JR/l0OfsgNg2y2jEPR+aJ+BrveP5AO14rEx1l7TzlE41dAnsj9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7cy6eJg2Ai39b8pYctGNpDVcy5fs2na1V2ZUm2Azmn8C8I4zc
	s1eiseqbQhkBLmiRiIhPjtZQZaQA0UWc8HWLGDC5TBQi7hRJucqkkGmK
X-Gm-Gg: ATEYQzwtung+boSrT36X2ekcZgCp7d3+OkFBrecJxC0X034/vWm85GrPoEvf84iRuXF
	vxYkEJpoMoc8Uxpb+dwmrYr2twN7WSfUcSh7aIxcoj8QTPa+7xQE8bsnirXmfNdQbnzfKkqoo3J
	aLiDyPcFomMlwHfiyUkqXNBy5jmN/4mRuPb+6iyO0qNh5TkeqQtyhr3wzCIgXYb0JQkx8lky3F6
	MM+0PaynMKxRIqizgR2ZiRhnBzkI4YZLrNb2q+966YuES1ksK5Y67CvMaZwgNbctwAltUBrXRt3
	vpahvy/THm+qK+GCXMsjFtN6sL5fQqg7IUjtFy5gzNM3xQPzKn3FlD+aCZAqr11PQqUIE0jusoP
	YEUNC1a7y7Yxwv1YBrc9stwEt6sXLD5Uvfw9hsGADvhw3JQIOOW3h8uRXuQn0hdsH9uP06s4pMZ
	+x0h/rOpOQiQ1OXnxCk/ppQ4QzzGDnQv2rPyxus6FKjose1OrtWeqc/A68+Tlon+BtRRQhaqYiP
	wj/+pZGto+4WyHSUm3AdYT5pC5hAXPhX1OX0URxMB0N2c+c
X-Received: by 2002:a05:6820:8ca:b0:679:e68b:f95d with SMTP id 006d021491bc7-67bc8a08660mr1135048eaf.53.1773215793063;
        Wed, 11 Mar 2026 00:56:33 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:32 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 3/7] tcp: honor advertised receive window in memory admission and clamping
Date: Wed, 11 Mar 2026 01:55:56 -0600
Message-Id: <20260311075600.948413-4-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6C8D25E539
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5925-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,lwn.net,linuxfoundation.org,goodmis.org,efficios.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-api];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

tp->rcv_wnd is an advertised promise to the sender, but receive-memory
accounting was still reconstructing that promise through mutable live
state.

Switch the receive-side decisions over to the advertise-time snapshot.
Use it when deciding whether a packet can be admitted, when deciding how
far to clamp future window growth, and when handling the scaled-window
quantization slack in __tcp_select_window(). If a snapshot is not
available, keep the legacy fallback behavior.

This keeps sender-visible rwnd and the local hard rmem budget in the
same unit system instead of letting ratio drift create accounting
mismatches.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/net/tcp.h     |  1 +
 net/ipv4/tcp_input.c  | 86 ++++++++++++++++++++++++++++++++++++++++---
 net/ipv4/tcp_output.c | 14 ++++++-
 3 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 187e6d660f62..88ddf7ee826e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -384,6 +384,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
+bool tcp_try_grow_rcvbuf(struct sock *sk, int needed);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cba89733d121..f76011fc1b7a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -774,8 +774,37 @@ static void tcp_init_buffer_space(struct sock *sk)
 				    (u32)TCP_INIT_CWND * tp->advmss);
 }
 
+/* Try to grow sk_rcvbuf so the hard receive-memory limit covers @needed
+ * bytes beyond the memory already charged in sk_rmem_alloc.
+ */
+bool tcp_try_grow_rcvbuf(struct sock *sk, int needed)
+{
+	struct net *net = sock_net(sk);
+	int target;
+	int rmem2;
+
+	needed = max(needed, 0);
+	target = tcp_rmem_used(sk) + needed;
+
+	if (target <= READ_ONCE(sk->sk_rcvbuf))
+		return true;
+
+	rmem2 = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
+	if (READ_ONCE(sk->sk_rcvbuf) >= rmem2 ||
+	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK) ||
+	    tcp_under_memory_pressure(sk) ||
+	    sk_memory_allocated(sk) >= sk_prot_mem_limits(sk, 0))
+		return false;
+
+	WRITE_ONCE(sk->sk_rcvbuf,
+		   min_t(int, rmem2,
+			 max_t(int, READ_ONCE(sk->sk_rcvbuf), target)));
+
+	return target <= READ_ONCE(sk->sk_rcvbuf);
+}
+
 /* 4. Recalculate window clamp after socket hit its memory bounds. */
-static void tcp_clamp_window(struct sock *sk)
+static void tcp_clamp_window_legacy(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -785,14 +814,42 @@ static void tcp_clamp_window(struct sock *sk)
 	icsk->icsk_ack.quick = 0;
 	rmem2 = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
 
-	if (sk->sk_rcvbuf < rmem2 &&
+	if (READ_ONCE(sk->sk_rcvbuf) < rmem2 &&
 	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
 	    !tcp_under_memory_pressure(sk) &&
 	    sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)) {
 		WRITE_ONCE(sk->sk_rcvbuf,
 			   min(atomic_read(&sk->sk_rmem_alloc), rmem2));
 	}
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+	if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf))
+		tp->rcv_ssthresh = min(tp->window_clamp, 2U * tp->advmss);
+}
+
+static void tcp_clamp_window(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 cur_rwnd = tcp_receive_window(tp);
+	int need;
+
+	if (!tcp_space_from_rcv_wnd(tp, cur_rwnd, &need)) {
+		tcp_clamp_window_legacy(sk);
+		return;
+	}
+
+	inet_csk(sk)->icsk_ack.quick = 0;
+	need = max_t(int, need, 0);
+
+	/* Keep the hard receive-memory cap large enough to honor the
+	 * remaining receive window we already exposed to the sender. Use
+	 * the scaling_ratio snapshot taken when tp->rcv_wnd was advertised,
+	 * not the mutable live ratio which may drift later in the flow.
+	 */
+	tcp_try_grow_rcvbuf(sk, need);
+
+	/* If the remaining advertised rwnd no longer fits the hard budget,
+	 * slow future window growth until the accounting converges again.
+	 */
+	if (need > tcp_rmem_avail(sk))
 		tp->rcv_ssthresh = min(tp->window_clamp, 2U * tp->advmss);
 }
 
@@ -5374,11 +5431,28 @@ static void tcp_ofo_queue(struct sock *sk)
 static bool tcp_prune_ofo_queue(struct sock *sk, const struct sk_buff *in_skb);
 static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb);
 
+/* Sequence checks run against the sender-visible receive window before this
+ * point. Convert the incoming payload back to the hard receive-memory budget
+ * using the scaling_ratio that was in force when tp->rcv_wnd was advertised,
+ * so admission keeps honoring the same exposed window even if the live ratio
+ * changes later in the flow. Legacy TCP_REPAIR restores do not have that
+ * advertise-time basis, so they fall back to the pre-series admission rule
+ * until a fresh local advertisement refreshes the pair.
+ *
+ * Do not subtract sk_backlog.len here. tcp_space() already reserves backlog
+ * bytes when selecting future advertised windows, and sk_backlog.len stays
+ * inflated until __release_sock() finishes draining backlog. Subtracting it
+ * again here would double count already-queued backlog packets as they move
+ * into sk_rmem_alloc.
+ */
 static bool tcp_can_ingest(const struct sock *sk, const struct sk_buff *skb)
 {
-	unsigned int rmem = atomic_read(&sk->sk_rmem_alloc);
+	int need;
+
+	if (!tcp_space_from_rcv_wnd(tcp_sk(sk), skb->len, &need))
+		return atomic_read(&sk->sk_rmem_alloc) <= READ_ONCE(sk->sk_rcvbuf);
 
-	return rmem <= sk->sk_rcvbuf;
+	return need <= tcp_rmem_avail(sk);
 }
 
 static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
@@ -6014,7 +6088,7 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	/* Do nothing if our queues are empty. */
-	if (!atomic_read(&sk->sk_rmem_alloc))
+	if (!tcp_rmem_used(sk))
 		return -1;
 
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_PRUNECALLED);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c1b94d67d8fe..5e69fc31a4da 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3377,13 +3377,23 @@ u32 __tcp_select_window(struct sock *sk)
 	 * scaled window will not line up with the MSS boundary anyway.
 	 */
 	if (tp->rx_opt.rcv_wscale) {
+		int rcv_wscale = 1 << tp->rx_opt.rcv_wscale;
+
 		window = free_space;
 
 		/* Advertise enough space so that it won't get scaled away.
-		 * Import case: prevent zero window announcement if
+		 * Important case: prevent zero-window announcement if
 		 * 1<<rcv_wscale > mss.
 		 */
-		window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
+		window = ALIGN(window, rcv_wscale);
+
+		/* Back any scale-quantization slack before we expose it.
+		 * Otherwise tcp_can_ingest() can reject data which is still
+		 * within the sender-visible window.
+		 */
+		if (window > free_space &&
+		    !tcp_try_grow_rcvbuf(sk, tcp_space_from_win(sk, window)))
+			window = round_down(free_space, rcv_wscale);
 	} else {
 		window = tp->rcv_wnd;
 		/* Get the largest window that is a nice multiple of mss.
-- 
2.34.1


