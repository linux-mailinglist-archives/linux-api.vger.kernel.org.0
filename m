Return-Path: <linux-api+bounces-3785-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D49ABA058
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF777A32CC
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2D91C84C4;
	Fri, 16 May 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="5en9einp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="T77fyJTg"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1286359;
	Fri, 16 May 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410967; cv=none; b=Yyh7NFZ9hiy3Y/MJ1Rz7VEa0W+ZC60UP+urnlVPpJxA/Rlb1OrBaSe5Atuxk/HLyLRfLcLEpIzjxTyWW8wvgGXXv9EXeNrCsbm1BE+4O2XftE/ot80+geWwEzR9Grz6DivO8B6Mff1ZcVPhsH2+tucYu7rasEunTCl+lSDbAULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410967; c=relaxed/simple;
	bh=nrBUcJU2scK2k+/lJKZux/Q2ArF4WOrJQWpsET0BqS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txZbx1ezi98TkRo686XZPkZ7bGf4tIhw4Jh5PEXZuA9a+TcEPdQn8tuSbZIF+HtOoqCk/Bih04MkD0IRF9DtH3oNI0xqYixys8bxQ2joYH0IHBJlvR7nzsW28U/BPfCF/xo51mnzg5s8Ninue0CmEzdc0c46DtcyKlguezUo2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=5en9einp; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=T77fyJTg; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=oaH0U7lQi/iHujLwef0CPlbEWnQhpFg5fe7v8JnIhUw=; b=5en9einpiMUYihG
	VEQp5O5BF/HnCfnhIaYqt7spCAW2iEu3ktLq3S51mOI/y0iUNZOoMg/Pq/QsQYS02nCAuAA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=oaH0U7lQi/iHujLwef0CPlbEWnQhpFg5fe7v8JnIhUw=; b=T77fyJTg4IiPFoA
	lj92e20uZdQoANPONq1nKXg1269iJ3ozn+H1CkVCvtFWfBodnssKcDHGxIymjRoTweIK30b1Ezlfw
	jPfM7asw2H/borYqnBLh/rC2FjKx4HS97XgXPkNq58OoGn3wrdmI1F542Po8s9U2JbLKPgMKPZyRj
	gkXETOGBvZFX5UOCN1JZ+kdDxJ4/z280XqLmYGxfdWI7ZUs2OZw/Ub/Uvrx86EGXytekCb/4GznKR
	NJTIGB35/J4LoaK/LAdYLJcGvv5JFVtjZPqNko6LRTK6vvYMoDyFrkhYTRAU9MZr4CWzcgNa/2Ohe
	DTsVTBLusAh3zD815kQ==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uFxPm-00000007363-3On1
	(return-path <jgh@exim.org>);
	Fri, 16 May 2025 15:56:02 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH 1/6] tcp: support writing to a socket in listening state
Date: Fri, 16 May 2025 16:54:59 +0100
Message-ID: <9235dfbc27f25974547e080f6278b0fbabda4e0a.1747409911.git.jgh@exim.org>
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

In the tcp sendmsg handler, permit a write in LISTENING state if
a MSG_PRELOAD flag is used.  Copy from iovec to a linear sk_buff
for placement on the socket write queue.

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 include/linux/socket.h                         |  1 +
 net/ipv4/tcp.c                                 | 17 +++++++++++++----
 tools/perf/trace/beauty/include/linux/socket.h |  1 +
 tools/perf/trace/beauty/msg_flags.c            |  3 +++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 3b262487ec06..b41f4cd4dc97 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -330,6 +330,7 @@ struct ucred {
 #define MSG_SOCK_DEVMEM 0x2000000	/* Receive devmem skbs as cmsg */
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
 #define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
+#define MSG_PRELOAD	0x10000000	/* Preload tx data while listening */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
 #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
 					   descriptor received through
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b7b6ab41b496..72b5d7cad351 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1136,12 +1136,13 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 	tcp_rate_check_app_limited(sk);  /* is sending application-limited? */
 
-	/* Wait for a connection to finish. One exception is TCP Fast Open
+	/* Wait for a connection to finish. Exceptions are TCP Fast Open
 	 * (passive side) where data is allowed to be sent before a connection
-	 * is fully established.
+	 * is fully established, and a message marked as preload which is
+	 * allowed to be placed in the send queue of a listening socket.
 	 */
 	if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
-	    !tcp_passive_fastopen(sk)) {
+	    !tcp_passive_fastopen(sk) && !(flags & MSG_PRELOAD)) {
 		err = sk_stream_wait_connect(sk, &timeo);
 		if (err != 0)
 			goto do_error;
@@ -1226,7 +1227,13 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (copy > msg_data_left(msg))
 			copy = msg_data_left(msg);
 
-		if (zc == 0) {
+		if (unlikely(flags & MSG_PRELOAD)) {
+			copy = min_t(int, copy, skb_tailroom(skb));
+			err = skb_add_data_nocache(sk, skb, &msg->msg_iter,
+						   copy);
+			if (err)
+				goto do_error;
+		} else if (zc == 0) {
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
 			struct page_frag *pfrag = sk_page_frag(sk);
@@ -1330,6 +1337,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (!msg_data_left(msg)) {
 			if (unlikely(flags & MSG_EOR))
 				TCP_SKB_CB(skb)->eor = 1;
+			if (unlikely(flags & MSG_PRELOAD))
+				goto out_nopush;
 			goto out;
 		}
 
diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index c3322eb3d686..e9ea498169f3 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -330,6 +330,7 @@ struct ucred {
 #define MSG_SOCK_DEVMEM 0x2000000	/* Receive devmem skbs as cmsg */
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
 #define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
+#define MSG_PRELOAD	0x10000000	/* Preload tx data while listening */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
 #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
 					   descriptor received through
diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index 2da581ff0c80..27e40da9b02d 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -20,6 +20,9 @@
 #ifndef MSG_SPLICE_PAGES
 #define MSG_SPLICE_PAGES	0x8000000
 #endif
+#ifndef MSG_PRELOAD
+#define MSG_PRELOAD		0x10000000
+#endif
 #ifndef MSG_FASTOPEN
 #define MSG_FASTOPEN		0x20000000
 #endif
-- 
2.49.0


