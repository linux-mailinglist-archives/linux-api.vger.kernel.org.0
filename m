Return-Path: <linux-api+bounces-5968-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAw8Fr7BtWkV4wAAu9opvQ
	(envelope-from <linux-api+bounces-5968-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:14:54 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1811A28EBBC
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E66E302836C
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23EF3845D6;
	Sat, 14 Mar 2026 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhUkIN79"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842A384248
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519284; cv=none; b=A70WPyuhJ6i8A/ciElwwjTl6WEda1nQP2pl5KtqIK1usCF1nDHDEqog1ZNwbRCI5aWDuvYo6wXdF9RFz9bdPrx4Oc3XueAv+rUNjZphcLOiPSyhxCO1ZX8lPeNRbz0bccoqKerVAo4SL4LPpdKDNxchmGdYCGJEhijt2td3o8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519284; c=relaxed/simple;
	bh=x7JZBaiPMjila4i+dsi/muzHxZeS9PJ/SGrV4i00JNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dgz9f7e0OrKN1quxH8YPjwLf2/mW6d54b4sQWNd5+WSqD4N1xkn2yPUbWo5aMX6tCS9Mf0l9/lPNbop7FCpGmcMCvRHE+rq/lVTlm7qd2ujHRaRdGF8uYbaSw7A0j7+3ao6T41NPmhgp+eev3Igt0QPWJvb4YEZGZeWSnDAm5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhUkIN79; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1123619fac.3
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519282; x=1774124082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO8Gig+uUsNsJX3c3oLWHfAhxFR79WVWca0SWR3nLZY=;
        b=AhUkIN79mN8ojz/fybmKvpF0JjleCLGY4QbBKJgI6OUDuBXH4XR3lV3+WckMvA4KCc
         0OjOLBcBwM71dp/Mk32iasY+Z2jObUC4pSQP4hQqWgy0rpHeliVj8qTuEtNgwgrUcnoJ
         seV+FVl7Z93NKeu9ucjyvGwlbAFnJbY3D28Gs5S1QmeSbxksLmAUGkHjrA/P1xTN4edZ
         EOb+QWuFCp8WX0ZIJtxHpe70w9ne1eN+Xii8M33lXisL1CNd8vydDrg1MsnigRVFcecW
         bjcQFJWcU58wxnXkq+57nzQ57x/HlYiTb2HC26qEevaQptff6NMfXwj31ErwfQ8+QhUm
         kElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519282; x=1774124082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iO8Gig+uUsNsJX3c3oLWHfAhxFR79WVWca0SWR3nLZY=;
        b=HA95Spl4DzIVGlxjjaAUmAXBAEJPrREeN1xu+gWu6i+Lum01J06vBGlchy8mRrvylN
         zeeuu+fvKnacslTY3nxcJAqDhT/8HwC9H+yciRBMuah/1Knlq5s64oJUGsbYB8c//OMk
         LVQbSscpb4hOVzldJKQ3//48D/eP3zZ9eDXxvqMdYOvipM2plBPqO5dMNH++6pgy5HoK
         H3PZM4DkoHIBpZQQICluCEuKHnUPGlfECuSqXOPyUGwNah4gIomm7AYUXjY2tmbeW2Lp
         9LJq3EToEH8/bdBsxZpIhYs9xqkAGxg7DUtFxcWYtR0G9M0gXNfUFuWpPJCIypSK+L43
         RYCg==
X-Forwarded-Encrypted: i=1; AJvYcCU8qCuZrIQGpBCP2Ar+UzdjNimsTz11SjSUaCqAgufgc1l1/f/yI9z4sV6EafCm5SKet+J2sCN069k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAyTw8XMwRruOBBcww0KqwUQZXS4VvRdxC9mp9Bqa3pW/CscVk
	3GmrKcWCImpPHWImR3W3aSFvo+n0vbjfjHIDHS6ceJurO6E9pJ5JeFsu
X-Gm-Gg: ATEYQzz2EsDwn7BY6UMURNFCO8bUND29ZKlksONDrMS0TELedIfkMT2A2Og8lniwCVz
	CXFFUxDlkNRW3pmrCKLxVkk0M7PHcjT4GMaWn5ej+Uvq6m/qBV97IE8cYVvN2+YpH08ElPPpPQV
	dFMN4l/O3s7V6Nhn5T0BHftB2WTl78oYJfEPJ1S8yrPqhrmKOzE4DvQNtXUK8t4RvKv5ul/vnUN
	JETpNp8aIt9v2qV745F8hC6VVUhqHs7GNbeCV74VOLwJ+VHqUfTT9BAzSdU1zr3anAtrg8/WUAD
	MAVsP1M+kABZoO8z2LOXmpTb5/IHjGtu9REkBd3QUdcth4Lhpkvjwcz0JsxeQo3fC7VBzpZMfDX
	QsWTfmAWP4uHldcb/vnSndS3X6+kxb1siIWf2NUs+6fxNcxLaElPhb6wiQWr7ooZj78D2eUzT3g
	rPRyaxGTpzN8qEvKLxjbTETkpmojjkjdBLnSuaQdDLnsTcwnWcXgVhjuE2IYnUPKWgOBOhi49F4
	CuRG8NlcgRjYOHgytpqh0OG2tfkomP3D03Osx4n
X-Received: by 2002:a05:6870:d8c:b0:404:33e1:3cc2 with SMTP id 586e51a60fabf-417b91b2c8fmr4474193fac.13.1773519282232;
        Sat, 14 Mar 2026 13:14:42 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:41 -0700 (PDT)
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
Subject: [PATCH net-next v2 01/14] tcp: factor receive-memory accounting helpers
Date: Sat, 14 Mar 2026 14:13:35 -0600
Message-ID: <20260314201348.1786972-2-atwellwea@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5968-lists,linux-api=lfdr.de];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,linux-api@vger.kernel.org]
X-Rspamd-Queue-Id: 1811A28EBBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

Factor the core receive-memory byte accounting into small helpers so
window selection, pressure checks, and prune decisions all start from
one set of quantities.

This is preparatory only. Later patches will use the same helpers when
tying sender-visible receive-window state back to hard memory admission.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/net/tcp.h    | 32 +++++++++++++++++++++++++++-----
 net/ipv4/tcp_input.c |  2 +-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f87bdacb5a69..3a0060599afe 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1751,12 +1751,34 @@ static inline void tcp_scaling_ratio_init(struct sock *sk)
 	tcp_sk(sk)->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 }
 
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
+}
+
 /* Note: caller must be prepared to deal with negative returns */
 static inline int tcp_space(const struct sock *sk)
 {
-	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
-				  READ_ONCE(sk->sk_backlog.len) -
-				  atomic_read(&sk->sk_rmem_alloc));
+	return tcp_win_from_space(sk, tcp_rwnd_avail(sk));
 }
 
 static inline int tcp_full_space(const struct sock *sk)
@@ -1799,7 +1821,7 @@ static inline bool tcp_rmem_pressure(const struct sock *sk)
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	threshold = rcvbuf - (rcvbuf >> 3);
 
-	return atomic_read(&sk->sk_rmem_alloc) > threshold;
+	return tcp_rmem_used(sk) > threshold;
 }
 
 static inline bool tcp_epollin_ready(const struct sock *sk, int target)
@@ -1949,7 +1971,7 @@ static inline void tcp_fast_path_check(struct sock *sk)
 
 	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
 	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    tcp_rmem_avail(sk) > 0 &&
 	    !tp->urg_data)
 		tcp_fast_path_on(tp);
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e6b2f4be7723..b8e65e31255e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5959,7 +5959,7 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	/* Do nothing if our queues are empty. */
-	if (!atomic_read(&sk->sk_rmem_alloc))
+	if (!tcp_rmem_used(sk))
 		return -1;
 
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_PRUNECALLED);
-- 
2.43.0


