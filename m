Return-Path: <linux-api+bounces-5969-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK7sINLBtWkV4wAAu9opvQ
	(envelope-from <linux-api+bounces-5969-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:15:14 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E628EBE2
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFBA9301CDB0
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 20:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B821338642B;
	Sat, 14 Mar 2026 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCJ0medY"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C20C384243
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519287; cv=none; b=hyFT8br5Y/9d7vghl3czwefny5hvTv/QRo6XwCtxQnYRn6iGJVodTQRJCN9QlJLu9BaTvMqG85fKKWEklmQgUoaad8f/XwBpHXlfYQArSm69uqsGT2+47JaBc0hFfSAyp5bSslo3VS+vXZ/LIxF+TB48RAw9s++qkXkWgd9fN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519287; c=relaxed/simple;
	bh=kQAayNyz3gm5FbyPOD3uaOhq7RsoX4Ii2Fi5JpOs7C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjVrJr/vQS9vkuFZxsFeQLSQ3TGgK/erF1oCdSQUdDeZNU6XFrCx52MYFzSBwdRGrNBek5k5RZPR9ASMH5MMuOGroG7+nqDSUvy2RhfKA6fR/HhvtE19fuBpo6kXTr1ipj0u1diK8JyDBI6Zn5IBWOKN/KxEURVO2VY6z1udPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCJ0medY; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-67bd152d3d9so1965177eaf.3
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519284; x=1774124084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meSreHlytwJ2+CYWUu8fQhMJhkO7SpENNzkrogjDyzo=;
        b=XCJ0medYSyUSQmiTOLhukeVpDbD+puJ/8hkc4j8T4ppJOy2IPw7pcm7waqXMySbFHv
         +uFn4Wk34rscOGfg/JVVvQVVPhXilbjqcUs4j3xJ688YhRUn9KmlFPMPsweGK4GI52N0
         ktmKT52GwZvwkEhywvrQn8k5PAEOg1IXO9GhpQ1OzAi0njDItQESw7Xij9rdL/qREk9j
         1iJ8HwNk43be2Suv1qAsVN3lnFKoZ1B6D2Pyf1xEQqUGO+aa6W0WoqP6ysItY6Cuw+wc
         kLDfSMbDb9co1eJtGvg7ilaAKeka3N/YtLBVwwmxAZctGg5uR59sbfB8dy2pGX8DdPgb
         ITmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519284; x=1774124084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=meSreHlytwJ2+CYWUu8fQhMJhkO7SpENNzkrogjDyzo=;
        b=rDYVDuIS/tC5PG5DCbqR011UwWzMvxcFbzbeTJ10AzSkC94syS/NRtfnTUoznmInHK
         nSMzD62o974A+KiAxM6NvkQFG4SjRxHNjSYWHofqfvMjP78TryL14LNWpsC7J0vxin8S
         AcakHwcE/5scDSdwptpWbw8X6yY0hDV+dnN4hDZfi9zYQlHZZEjyjnO/MGGs4qgYfG8B
         GI6PjsT51TwdBXkl1XZHwK/DXNhZmNRVeG7BADMfvKNSnZKmyR5oKpp+M4R72dlSysNC
         cnGaDT5NbVyOPI4i0OgMQirOBHijeivNaUP+MfgwTZKx679wWmTMlL/nQK+RJh1uEI/r
         gnmg==
X-Forwarded-Encrypted: i=1; AJvYcCUg79VwClNNJRQtUrMJiRuMyeHlS/1jLKjUr+hW4YTjpkQ9y5zU+vFfGIw61mctUAeLZCEahNpamjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCI+MxvhA3E4DcZOBxfGhZhMssxvhxnKpRztpM+6GAzBi49ro
	2O2hpMU7BIj6SiDl6CG8nJnk8MC0IElkRIsEfTEsQQLU0jDLojxxFkAn
X-Gm-Gg: ATEYQzzq7RDQa1E3f2ZnCfnmLH3uoxABx91gzLn+OnCinzyuF/YO6qsnZC4TVWTa2BV
	cfS1uG/Hv3THLUMczfjhGQDccvCXCkopB88TbV9nBjdethIF8oUFfO9tacRMbWSiqQGcWzx2IJs
	59C2dG4npzvBaiFBoid4IJwRyjW5hrUNx2Txj0b6pI22+0VrukeqLq++q4T7cUZ73YTTRwJ/gLu
	ZAm2R8JrB2Lh12P8p+o3No5tZiu6ubzBCohMy9jCtpjP5Y3W/Halc1DxP1CFT1O1QpJlKDrfZKf
	xrhcvkhIOW3mZl6stQzVxRFJGTHb3B2WIV+BYJ/nnK3HqR9l0RY/LfL4H6JNvwnGQKp/hbOQaAy
	5WZ1LSv8I+7ivK3IvzRkLGVc+beKxSjooO5J0DCR9xo/ujHIN/OgrKP3oEice+q6DeSddqpAKUy
	jSKh2cP1e53InX8aQ5MlbbwkrXUC6+VwB3ixWF/eKOGMJf1hRfqodPOaAwBSIAY+lDTTwgS+CxV
	s9ptW0G3cHzbizIlTzAjUhXHoXauuSPvsv+CsKB
X-Received: by 2002:a05:6820:2909:b0:662:fbd6:1849 with SMTP id 006d021491bc7-67bda98cb6dmr4777838eaf.4.1773519284132;
        Sat, 14 Mar 2026 13:14:44 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:43 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 02/14] tcp: snapshot advertise-time scaling for rcv_wnd
Date: Sat, 14 Mar 2026 14:13:36 -0600
Message-ID: <20260314201348.1786972-3-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5969-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 412E628EBE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

Track the scaling basis that was in force when tp->rcv_wnd was last
advertised, and provide helpers to refresh or interpret that snapshot.

Later patches use this live-window basis to preserve sender-visible rwnd
accounting when receive-side memory costs drift after advertisement.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 include/net/tcp.h                             | 52 ++++++++++++++++++-
 net/ipv4/tcp.c                                |  1 +
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index fecf61166a54..09ece1c59c2d 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -11,6 +11,7 @@ Type                          Name                    fastpath_tx_access  fastpa
 struct inet_connection_sock   inet_conn
 u16                           tcp_header_len          read_mostly         read_mostly         tcp_bound_to_half_wnd,tcp_current_mss(tx);tcp_rcv_established(rx)
 u16                           gso_segs                read_mostly                             tcp_xmit_size_goal
+u8                            rcv_wnd_scaling_ratio   read_write          read_mostly         tcp_set_rcv_wnd,tcp_can_ingest,tcp_repair_set_window,do_tcp_getsockopt
 __be32                        pred_flags              read_write          read_mostly         tcp_select_window(tx);tcp_rcv_established(rx)
 u64                           bytes_received                              read_write          tcp_rcv_nxt_update(rx)
 u32                           segs_in                                     read_write          tcp_v6_rcv(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6982f10e826b..2ace563d59d6 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -297,6 +297,7 @@ struct tcp_sock {
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		prev_ecnfield:2; /* ECN bits from the previous segment */
+	u8	rcv_wnd_scaling_ratio; /* 0 if unknown, else tp->rcv_wnd basis */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3a0060599afe..6fa7cdb0979e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1741,6 +1741,31 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
 }
 
+static inline bool tcp_wnd_snapshot_valid(u8 scaling_ratio)
+{
+	return scaling_ratio != 0;
+}
+
+static inline bool tcp_space_from_wnd_snapshot(u8 scaling_ratio, int win,
+					       int *space)
+{
+	if (!tcp_wnd_snapshot_valid(scaling_ratio))
+		return false;
+
+	*space = __tcp_space_from_win(scaling_ratio, win);
+	return true;
+}
+
+/* Rebuild hard receive-memory units for data already covered by tp->rcv_wnd if
+ * the advertise-time basis is known.
+ */
+static inline bool tcp_space_from_rcv_wnd(const struct tcp_sock *tp, int win,
+					  int *space)
+{
+	return tcp_space_from_wnd_snapshot(tp->rcv_wnd_scaling_ratio, win,
+					   space);
+}
+
 /* Assume a 50% default for skb->len/skb->truesize ratio.
  * This may be adjusted later in tcp_measure_rcv_mss().
  */
@@ -1748,7 +1773,32 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 
 static inline void tcp_scaling_ratio_init(struct sock *sk)
 {
-	tcp_sk(sk)->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tp->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+	tp->rcv_wnd_scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+}
+
+/* tp->rcv_wnd is paired with the scaling_ratio that was in force when that
+ * window was last advertised. Callers can leave a zero snapshot when the
+ * advertise-time basis is unknown and refresh the pair on the next local
+ * window update.
+ */
+static inline void tcp_set_rcv_wnd_snapshot(struct tcp_sock *tp, u32 win,
+					    u8 scaling_ratio)
+{
+	tp->rcv_wnd = win;
+	tp->rcv_wnd_scaling_ratio = scaling_ratio;
+}
+
+static inline void tcp_set_rcv_wnd(struct tcp_sock *tp, u32 win)
+{
+	tcp_set_rcv_wnd_snapshot(tp, win, tp->scaling_ratio);
+}
+
+static inline void tcp_set_rcv_wnd_unknown(struct tcp_sock *tp, u32 win)
+{
+	tcp_set_rcv_wnd_snapshot(tp, win, 0);
 }
 
 /* TCP receive-side accounting reuses sk_rcvbuf as both a hard memory limit
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 516087c622ad..0383ee8d3b78 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5275,6 +5275,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd_scaling_ratio);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_mwnd_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_tstamp);
-- 
2.43.0


