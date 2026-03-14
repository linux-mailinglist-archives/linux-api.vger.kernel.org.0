Return-Path: <linux-api+bounces-5972-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NMNJPfBtWkV4wAAu9opvQ
	(envelope-from <linux-api+bounces-5972-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:15:51 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1325928EC44
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0621F30405DC
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 20:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461A8386C23;
	Sat, 14 Mar 2026 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfSQCnI8"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA63386547
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519292; cv=none; b=SONuKs4kVpFNJ7iC/+X9TIHIrgqs4yWhwSOvAGCc/bUpp5iLORqp7SXULr1fbauYLucWsYjsEk+LlJgshMi9vteRBU8YoFk7dZSdJx9rKk7qST7rndi26dOlQit6bBrmGRt5fP/r/7LzFzIRLH1P+G3sbevlcGjK3GWPZIfUxiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519292; c=relaxed/simple;
	bh=7izhNqLY7+iqpp+D5zcP+czL6od/LnGYqCsmQoSJSu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=untnuFumKe+Nc/67Cp98cNY5wcjWRiU36bvoZzlJhQdDUmtR5xbWofsrhJVeiTXz5aflxk5BLJJCUQLygyTNgSr5VHTw7sZAPlpWBlziy9QM1gE4mVBfCY6mDOcQx8tTQMQPfFrbUiUHO/O7Vnt7VorqzzIgmqskelbDaUNfeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfSQCnI8; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40974bf7781so3244007fac.0
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519289; x=1774124089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOOOdlrS2+fu1x+v8Rmi5MAUGmJW2DC+1z1Ah1tHPHA=;
        b=YfSQCnI8pcAkQBxbxRmg0IXw0rj6yeiQQBJEY+8xfNyIFRNHohbTtZgFJr19+aIs5d
         po7C/9kl24MwwwIpN7b2TDapKOhvwhx0SOXgfsb9P3JuQo44cThC4EZC4W7qj0lS1R3s
         0WLlVmQ1GtJA79Y7M+esx4Q8tOheHSz8oqqmaiELJYb2BGUQjaWrIaCpPw0+0sjbVib9
         TI8wFudad+LkDCH+nVFSPDUf2JTqlLX9Iqv5B/y3QiV4nEFRGWYQlZku/Iu/0Lm2Jq06
         JErdP0bcSZykMicBHCwDaAsVaAFg0imOj2oy5cCZdXFPzZN7gzZbiCIh9M3UKJiSxIl1
         PI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519289; x=1774124089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fOOOdlrS2+fu1x+v8Rmi5MAUGmJW2DC+1z1Ah1tHPHA=;
        b=a4Kx/t6C0mnJtq+LK5o+dMZcgHcz4PjgFenVwdOoycJoNjiaJMeEBaAX5QuXKa94pI
         pcMqgXz1nFNJvR7HK6RnxGKWgI6xGYRJwTKAeGSp6X0G93QCYXjSkOB+anvzwbi3QrhI
         PNNSvjoK2wwOAv9Tp3Jp91qcfWRvDnd5v97ZXxkKOKOkucE3quWjlb84ONIhs8OU7B0s
         TVD1k+k665cEw5VpLYnOgKtzKcIHzglSuh9baIHH0i0apjS3AQ2imHLaXwrlwGPV5ciN
         dKH1DaAZ3V3MsLt2ZJIwTYOYrvu1W4Zpka0RTM7toIEM0gCarUNZ6Px4fe2KRjG1BnZT
         WTzg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ7q1DwAMRD0eFrfSeOyVPgxapkLVIpExU0KHgH+AKZuhu/49yEJTTY2wSBehTtKiHfv5BYuKeUvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIw7ArEIeF1Bs9TCavuyT2+X/aRkv/HMtbJlygGnqolAlEPXv
	5Fd8PXdRiXQ/2XUGMEwNHDGE99xqLGbxU9YcBKCQx+udCrTm5Ifyg2hT
X-Gm-Gg: ATEYQzzoK79TcSQoOOnrd9ok61RlfD28/C+tcW/ReVrqddtiaLP8ZpvXKv+XL+1NRZ1
	iZolFnHiaVJjOcwy8W454kJ+saLhA81fxDDKyvRl1AFMBf9CZoRPxc7I1kAy1Efr3tFl2HYRZy9
	NLqKtBNv47wcRdroNbNw6nUWe3rTAlwaAaIBdoIxVWyh3s/BGdYu/XlrTCFtks6meWji+qTpTZY
	TCghutNdF+eZEcVDSfjElOX46XOSSef+oZ43CRMBZxx7d0DPOL8oyYR7TjbNRR4Q82aQ7rQqBnz
	QI06wNTQcXR7uFzgeHnaXO98+UhcCKr4p2M8o+gDErnLHloAbw4nXHB79WfvzaJrF5j2m/p0yAO
	5Fx7CLj51OvYVQ0ZYk5M0R3M3kclFgQkcy27rm9lMNEcZdba7K///OyJ0uor7JfDznryoGjxIUY
	f6R3X2uaUc+FqGtn8PpMf6jZz5WxBp4bconFTTRlYBo+eJlM3E2QseuyPtOX5F5BYvrSlVy+gHA
	n1pbqe7ievUUlqsK6Lv6NQpwdHbHYD6OSuatU7k
X-Received: by 2002:a05:6870:7d86:b0:40a:5870:98bb with SMTP id 586e51a60fabf-4179911cfccmr6459609fac.21.1773519288902;
        Sat, 14 Mar 2026 13:14:48 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:48 -0700 (PDT)
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
Subject: [PATCH net-next v2 05/14] tcp: grow rcvbuf to back scaled-window quantization slack
Date: Sat, 14 Mar 2026 14:13:39 -0600
Message-ID: <20260314201348.1786972-6-atwellwea@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-5972-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 1325928EC44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

Teach TCP to grow sk_rcvbuf when scale rounding would otherwise expose
more sender-visible window than the current hard receive-memory backing
can cover.

The new helper keeps backlog and memory-pressure limits in the same
units as the rest of the receive path, while __tcp_select_window()
backs any rounding slack before advertising it.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/net/tcp.h     | 12 ++++++++++++
 net/ipv4/tcp_input.c  | 36 ++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_output.c | 15 +++++++++++++--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index fc22ab6b80d5..5b479ad44f89 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -397,6 +397,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
+bool tcp_try_grow_rcvbuf(struct sock *sk, int needed);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
@@ -1844,6 +1845,17 @@ static inline int tcp_rwnd_avail(const struct sock *sk)
 	return tcp_rmem_avail(sk) - READ_ONCE(sk->sk_backlog.len);
 }
 
+/* Passive children clone the listener's sk_socket until accept() grafts
+ * their own struct socket, so only sockets that point back to themselves
+ * should autotune receive-buffer backing.
+ */
+static inline bool tcp_rcvbuf_grow_allowed(const struct sock *sk)
+{
+	struct socket *sock = READ_ONCE(sk->sk_socket);
+
+	return sock && READ_ONCE(sock->sk) == sk;
+}
+
 /* Note: caller must be prepared to deal with negative returns */
 static inline int tcp_space(const struct sock *sk)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 352f814a4ff6..32256519a085 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -774,6 +774,38 @@ static void tcp_init_buffer_space(struct sock *sk)
 				    (u32)TCP_INIT_CWND * tp->advmss);
 }
 
+/* Try to grow sk_rcvbuf so the hard receive-memory limit covers @needed
+ * bytes beyond sk_rmem_alloc while preserving sender-visible headroom
+ * already consumed by sk_backlog.len.
+ */
+bool tcp_try_grow_rcvbuf(struct sock *sk, int needed)
+{
+	struct net *net = sock_net(sk);
+	int backlog;
+	int rmem2;
+	int target;
+
+	needed = max(needed, 0);
+	backlog = READ_ONCE(sk->sk_backlog.len);
+	target = tcp_rmem_used(sk) + backlog + needed;
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
 static void tcp_clamp_window(struct sock *sk)
 {
@@ -785,14 +817,14 @@ static void tcp_clamp_window(struct sock *sk)
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
 		tp->rcv_ssthresh = min(tp->window_clamp, 2U * tp->advmss);
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 57a2a6daaad3..53781cf591d2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3375,13 +3375,24 @@ u32 __tcp_select_window(struct sock *sk)
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
+		    (!tcp_rcvbuf_grow_allowed(sk) ||
+		     !tcp_try_grow_rcvbuf(sk, tcp_space_from_win(sk, window))))
+			window = round_down(free_space, rcv_wscale);
 	} else {
 		window = tp->rcv_wnd;
 		/* Get the largest window that is a nice multiple of mss.
-- 
2.43.0


