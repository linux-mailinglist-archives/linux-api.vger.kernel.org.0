Return-Path: <linux-api+bounces-5923-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNZcKQslsWmvrQIAu9opvQ
	(envelope-from <linux-api+bounces-5923-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:17:15 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A325ED0C
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82D613243241
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F103B47E8;
	Wed, 11 Mar 2026 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lONTAza+"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B83B8BA6
	for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215794; cv=none; b=JrpRzPkukPY8p5/nBqZxIXJ9izSBDqFKJSvEgj5bzWtptC3agyRYtR+hVMHn9huCpaVIvWLkrEAJ4pT7pB/U1jcj3jNyuTsKxri4Zqaztl4uftgKY87BdJQAkSNPjlEx02EBvwA+SbbIyGgYtItn5/IChprpowPBVHrhxV7aiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215794; c=relaxed/simple;
	bh=FYyuTZ6oj/yHfeGN9pAwnMFoWQKizQRfgw8TBRRgtVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbFlaycXgPkv+oDf/jA8LcYjIWqZ3KmfTTAAo3jvsExiIzMznRebbWaLzf3auxaHjCWLXveBEbpOfyF02R+deP0SlgvO1QKDUK9u0SYOpJVBVnb44uQ4c46/E5RUyrgfYSjk9NRm7C9hPD2su6P+FOySvGBK/3II85Ya3BMTNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lONTAza+; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-409de4132b5so5818816fac.1
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215789; x=1773820589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40e3x26UsOAMqAGLAxgvpaUIp6rLm2UmpbVxhD/U51Y=;
        b=lONTAza+A8SZwtCD93pRqPMiUVmL7xvOTl4aa9qY1c8XZAjojLuW9G+8TvMNSVodZ4
         9To8/LBjMDjisOAygz6wdcp2cIUNPYVDjheVZBvAnfzkXxwa1tTtO14tQAYFS63sGUzX
         MnT4Q1fx7B1zkX+pAK9GecVIUv0zmGseDk/psUwQs2UEs1Gehl1OUgDRYKWMDFMHyH2s
         dq/x27USjxK1TelWPRl7WGXMc2/ddbfEk/q9MLF6/y9yOaX1tDNshwCNifRxbUFCmYsl
         3Uyvk0Q8qsgIoGRcxcBiFkkdjKqdk+41nQuaQn0CkjRftqdoqNZqLhP2LVJ0dsFr9ksd
         VPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215789; x=1773820589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40e3x26UsOAMqAGLAxgvpaUIp6rLm2UmpbVxhD/U51Y=;
        b=k6txafnQbxFPy2KpX3GInAQKbpqps62/1FRltjflYytknbyS0XriLS8QgbSEd6mO9+
         ZQQRY39K5O/C8G2q3nx0bwagayyUna/KChu8/7TrS4UUnWoH5zj4NOkfznjzM9WefkAI
         hwxHMmv3YuDfYI3kvTjWckXigcjGvWVOYnsZoLILvwi6pobXBbRQQPpv3HGEuCLWMdvi
         Iem3xB0jjE1tr1IAhKgqNT8DOLNp8AqTvNQcNvNvXJs/hNZe+ce86lW765pNIa2xvaPZ
         D5dP2yeXkCh7MFX00FT4vj3VZ7xtNX7XN7QzxGkQ8Jf/YYMphCURXM0NT4gjrL2hH5wE
         ReGw==
X-Forwarded-Encrypted: i=1; AJvYcCVvtYlhmmDHgcPu+RLlE95C5myxppkq1T9tCVwvAob+t5YCOWluX9vVNxzdxZzpwb7EUQobT/1V1Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUTJyh2qCv9k1lrG5ZUPd9uwj5Fq0sNxzMek5xR43fXyUKxZx
	z6UliIEl0nZ0NQapH/Pyx9MZLCwFddd2AKqKmPT8jJP9M0Tjqqpo+xqm
X-Gm-Gg: ATEYQzyQrP6Y3K2Va52LCWKFzf4Izi08E2J0W7HyzzktyW/B51NERP+ewP79L7wbK4L
	ie60Y3E4ngqvDrrJ8y24WvKs8SOdxFYHIUR5BjDkw5ubzhCk61pWQJZ1/Cft2RzkifDwXRQJcCp
	IsCzReukoA5pxcYHgSdar5EMSbUMZiPtZemiT4bXgu3MTKjCRy/VY/4SbBgynMYDd+w9dSa2iKu
	zloyl3+92BlPIcdGUjAZtNro0fbzn/FAs1Q32WXpXKKb3/xRwtS3nPITfRIfKO3qQaEI/MipEW8
	CUsnWFSCNBLXB6boU4MeZukCI1kL+wEHRYdo0XabnM9dxNmTgq8HkhK3RwY1FOMb96e3gG7nq6M
	XSep42zpRvPFi8pQDJ7G8aJ5PLsbyPqEPD0MpLiLX44DcgtrV3Fu0Toe/kjKBu1B5Xc7pVl/czb
	oOKwiTdA6Ko+dLBnRYiLj0g47Bsio3Hg6t63NJ/PTpS7gjUneCH10FnjZDTqV8rAKeye5I3wQpL
	3sTo79hed/hCSEx5DfcyIWf4p6DYpUe8bK1AJhWeafxKXi4
X-Received: by 2002:a05:6871:2b04:b0:3ec:565a:13a4 with SMTP id 586e51a60fabf-4177c8be4f7mr1195845fac.34.1773215788774;
        Wed, 11 Mar 2026 00:56:28 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:28 -0700 (PDT)
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
Subject: [PATCH net 1/7] tcp: track advertise-time scaling basis for rcv_wnd
Date: Wed, 11 Mar 2026 01:55:54 -0600
Message-Id: <20260311075600.948413-2-atwellwea@gmail.com>
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
X-Rspamd-Queue-Id: 473A325ED0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5923-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

tp->rcv_wnd is an advertised window, but later receive-side accounting
needs to recover the hard memory budget that window represented when it
was exposed.

Prepare for that by storing the scaling basis alongside tp->rcv_wnd and
centralizing the helper API around the paired state. While here, make the
existing receive-memory arithmetic use the shared helper names so later
behavioral changes can build on one explicit accounting model.

This patch is groundwork only. Later patches will refresh the snapshot at
window write sites and consume it in the receive-memory paths.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 include/net/tcp.h                             | 79 +++++++++++++++++--
 net/ipv4/tcp.c                                |  1 +
 4 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 563daea10d6c..1415981b9d8a 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -12,6 +12,7 @@ struct inet_connection_sock   inet_conn
 u16                           tcp_header_len          read_mostly         read_mostly         tcp_bound_to_half_wnd,tcp_current_mss(tx);tcp_rcv_established(rx)
 u16                           gso_segs                read_mostly                             tcp_xmit_size_goal
 __be32                        pred_flags              read_write          read_mostly         tcp_select_window(tx);tcp_rcv_established(rx)
+u8                            rcv_wnd_scaling_ratio   read_write          read_mostly         tcp_set_rcv_wnd,tcp_can_ingest,tcp_clamp_window
 u64                           bytes_received                              read_write          tcp_rcv_nxt_update(rx)
 u32                           segs_in                                     read_write          tcp_v6_rcv(rx)
 u32                           data_segs_in                                read_write          tcp_v6_rcv(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f72eef31fa23..ec6b70c1174b 100644
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
index 978eea2d5df0..187e6d660f62 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1702,6 +1702,26 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
 }
 
+static inline bool tcp_rcv_wnd_snapshot_valid(const struct tcp_sock *tp)
+{
+	return tp->rcv_wnd_scaling_ratio != 0;
+}
+
+/* Rebuild hard receive-memory units for data already covered by tp->rcv_wnd if
+ * the advertise-time basis is known. Legacy TCP_REPAIR restores can only
+ * recover tp->rcv_wnd itself; callers must fall back when the snapshot is
+ * unknown.
+ */
+static inline bool tcp_space_from_rcv_wnd(const struct tcp_sock *tp, int win,
+					  int *space)
+{
+	if (!tcp_rcv_wnd_snapshot_valid(tp))
+		return false;
+
+	*space = __tcp_space_from_win(tp->rcv_wnd_scaling_ratio, win);
+	return true;
+}
+
 /* Assume a 50% default for skb->len/skb->truesize ratio.
  * This may be adjusted later in tcp_measure_rcv_mss().
  */
@@ -1709,15 +1729,62 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 
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
+ * window was last advertised. Legacy TCP_REPAIR restores can only recover the
+ * window value itself and use a zero snapshot until a fresh local window
+ * advertisement refreshes the pair.
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
+}
+
+/* TCP receive-side accounting reuses sk_rcvbuf as both a hard memory limit
+ * and as the source material for the advertised receive window after
+ * scaling_ratio conversion. Keep the byte accounting explicit so admission,
+ * pruning, and rwnd selection all start from the same quantities.
+ */
+static inline int tcp_rmem_used(const struct sock *sk)
+{
+	return atomic_read(&sk->sk_rmem_alloc);
+}
+
+static inline int tcp_rmem_avail(const struct sock *sk)
+{
+	return READ_ONCE(sk->sk_rcvbuf) - tcp_rmem_used(sk);
+}
+
+/* Sender-visible rwnd headroom also reserves bytes already queued on backlog.
+ * Those bytes are not free to advertise again until __release_sock() drains
+ * backlog and clears sk_backlog.len.
+ */
+static inline int tcp_rwnd_avail(const struct sock *sk)
+{
+	return tcp_rmem_avail(sk) - READ_ONCE(sk->sk_backlog.len);
 }
 
 /* Note: caller must be prepared to deal with negative returns */
 static inline int tcp_space(const struct sock *sk)
 {
-	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
-				  READ_ONCE(sk->sk_backlog.len) -
-				  atomic_read(&sk->sk_rmem_alloc));
+	return tcp_win_from_space(sk, tcp_rwnd_avail(sk));
 }
 
 static inline int tcp_full_space(const struct sock *sk)
@@ -1760,7 +1827,7 @@ static inline bool tcp_rmem_pressure(const struct sock *sk)
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	threshold = rcvbuf - (rcvbuf >> 3);
 
-	return atomic_read(&sk->sk_rmem_alloc) > threshold;
+	return tcp_rmem_used(sk) > threshold;
 }
 
 static inline bool tcp_epollin_ready(const struct sock *sk, int target)
@@ -1910,7 +1977,7 @@ static inline void tcp_fast_path_check(struct sock *sk)
 
 	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
 	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    tcp_rmem_avail(sk) > 0 &&
 	    !tp->urg_data)
 		tcp_fast_path_on(tp);
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 202a4e57a218..cec9ae1bf875 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5238,6 +5238,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd_scaling_ratio);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
-- 
2.34.1


