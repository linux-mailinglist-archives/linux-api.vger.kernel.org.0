Return-Path: <linux-api+bounces-3885-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676FFAD2343
	for <lists+linux-api@lfdr.de>; Mon,  9 Jun 2025 18:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC458161EAE
	for <lists+linux-api@lfdr.de>; Mon,  9 Jun 2025 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61590217660;
	Mon,  9 Jun 2025 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="LOG6g3JT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="O3X/oNQw"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ECF217659;
	Mon,  9 Jun 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485135; cv=none; b=HYAGJ1+DEmXH5IipPl8IQ8xnc1ZMdmngfz0OlB3cdwM4fD6GJZ0spJghYVvo0SpnfggUF5Ff74+T8s6WBca3r4AkNQbPUDhHfI+iwc9m9qYxrcG+ezs1n9dH6BN4jCb3fAxYOheiOsl/5oHzdpTByLf9Dbswz8ociB0GbLQO4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485135; c=relaxed/simple;
	bh=SBkrgM14OUuhdHvcfsWwWoAR8JQKd4xY6qaEO7io8Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjaeL8FRol97ivT7S7RYLShOYfJGGpSCN1a6Uerqgra+ldehqsMZd3Uaj5J8WtiE6a95IeklLAe6x1BF/RscP/70EZt2x4R5TEfvgIKVGwlu3813k9Mz6KIRBenTk7ASBaeIy5MKo8H7eHKetL/zQ9gtwjf1+bgIVzrR4Kktd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=LOG6g3JT; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=O3X/oNQw; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=TzWrBe6M7YpW3JNszYeApf3YkYVZKUXl3s/EAj+fAgE=; b=LOG6g3JTbyMDBF+
	3apqtfQ+pjdjj/4J9HZxV755WuOwWPbe2Vgb19QKREY7vtWS0Ps1g52GPTj7cGTg+vI2LCg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=TzWrBe6M7YpW3JNszYeApf3YkYVZKUXl3s/EAj+fAgE=; b=O3X/oNQw4nlyirf
	eXvwdCpf0iWQdfYEsqUWziBh3PJgrhhBRg3i6SlXKweKyoL7dJSmaa/jxZnoqH36Ga3cIrVpXPTwS
	J4YVWFw6vwfVsmICtpCVCmV5TSVUYmdYxxDARZCWng7TG/iA7Q9uMqE5HCGNo5qMa4J2KMsQ0Hkwg
	O//fb08qk0sa6Bt+O85ERpnGdOCVVKvMF1YoS7vJVQBfuAyn1dHIb+e5POWd5EKFZIQ8Ou88/PKzi
	LoPkGApnMg0SNJeLCFgaEZj5GH8x2EL40NY2ZMscVoNjOhJrgn8b9yqq4t95yQkJYt6NNQuXRvce2
	/l6/thBAnHlHkwkng4w==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uOf05-00000000n6h-3POZ
	(return-path <jgh@exim.org>);
	Mon, 09 Jun 2025 16:05:29 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next v3 1/6]     tcp: support writing to a socket in listening state
Date: Mon,  9 Jun 2025 17:05:17 +0100
Message-ID: <7facb17b78f6cbbdb38f140872e02a345a0023f7.1749466540.git.jgh@exim.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749466540.git.jgh@exim.org>
References: <cover.1749466540.git.jgh@exim.org>
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
 include/linux/socket.h                        |   1 +
 net/ipv4/tcp.c                                | 112 ++++++++++++++++++
 .../perf/trace/beauty/include/linux/socket.h  |   1 +
 tools/perf/trace/beauty/msg_flags.c           |   3 +
 4 files changed, 117 insertions(+)

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
index f64f8276a73c..c0a787c1649d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1057,6 +1057,115 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 	return err;
 }
 
+/* Cut-down version of tcp_sendmsg_locked(), for writing on a listen socket
+ */
+static int tcp_sendmsg_preload(struct sock *sk, struct msghdr *msg)
+{
+	struct sk_buff *skb;
+	int flags, err, copied = 0;
+	int size_goal;
+	int process_backlog = 0;
+	long timeo;
+
+	if (sk->sk_state != TCP_LISTEN)
+		return -EINVAL;
+
+	flags = msg->msg_flags;
+
+	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
+
+	/* Ok commence sending. */
+restart:
+	/* Use a arbitrary "mss" value */
+	size_goal = 1000;
+
+	err = -EPIPE;
+	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
+		goto do_error;
+
+	while (msg_data_left(msg)) {
+		ssize_t copy = 0;
+
+		skb = tcp_write_queue_tail(sk);
+		if (skb)
+			copy = size_goal - skb->len;
+
+		trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
+
+		if (copy <= 0 || !tcp_skb_can_collapse_to(skb)) {
+			bool first_skb = !skb;
+
+			/* Limit to only one skb on the sk write queue */
+
+			if (!first_skb)
+				goto out_nopush;
+
+			if (!sk_stream_memory_free(sk))
+				goto wait_for_space;
+
+			if (unlikely(process_backlog >= 16)) {
+				process_backlog = 0;
+				if (sk_flush_backlog(sk))
+					goto restart;
+			}
+
+			skb = tcp_stream_alloc_skb(sk, sk->sk_allocation,
+						   first_skb);
+			if (!skb)
+				goto wait_for_space;
+
+			process_backlog++;
+
+#ifdef CONFIG_SKB_DECRYPTED
+			skb->decrypted = !!(flags & MSG_SENDPAGE_DECRYPTED);
+#endif
+			tcp_skb_entail(sk, skb);
+			copy = size_goal;
+		}
+
+		/* Try to append data to the end of skb. */
+		if (copy > msg_data_left(msg))
+			copy = msg_data_left(msg);
+
+		copy = min_t(int, copy, skb_tailroom(skb));
+		err = skb_add_data_nocache(sk, skb, &msg->msg_iter, copy);
+		if (err)
+			goto do_error;
+
+		TCP_SKB_CB(skb)->end_seq += copy;
+		tcp_skb_pcount_set(skb, 0);
+
+		copied += copy;
+		goto out_nopush;
+
+wait_for_space:
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		tcp_remove_empty_skb(sk);
+
+		err = sk_stream_wait_memory(sk, &timeo);
+		if (err != 0)
+			goto do_error;
+	}
+
+out_nopush:
+	return copied;
+
+do_error:
+	tcp_remove_empty_skb(sk);
+
+	if (copied)
+		goto out_nopush;
+
+	err = sk_stream_error(sk, flags, err);
+	/* make sure we wake any epoll edge trigger waiter */
+	if (unlikely(tcp_rtx_and_write_queues_empty(sk) && err == -EAGAIN)) {
+		sk->sk_write_space(sk);
+		tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
+	}
+
+	return err;
+}
+
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	struct net_devmem_dmabuf_binding *binding = NULL;
@@ -1129,6 +1238,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			goto out_err;
 	}
 
+	if (unlikely(flags & MSG_PRELOAD))
+		return tcp_sendmsg_preload(sk, msg);
+
 	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 
 	tcp_rate_check_app_limited(sk);  /* is sending application-limited? */
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


