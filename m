Return-Path: <linux-api+bounces-5977-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPcmJvbBtWke4wAAu9opvQ
	(envelope-from <linux-api+bounces-5977-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:15:50 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB728EC3D
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9481D301C147
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 20:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE853845DB;
	Sat, 14 Mar 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQzm6OK0"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FBF38BF81
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519300; cv=none; b=pNF2ptPd/Q91oAkWeGUGbc1XiWbWOjRJBPU5QU5BksUpVOADdSfEMEmPd4LDvnw7XWL/G6ajxzTimyAua00GnEdm4wu6BEuPJKGEwNjsLvVPD7XVzQ+BRnmDS8b/utIbGW4a3qyzgwvSqA2n6J4LA+a4IfI0Qrbfv5VyLhQXkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519300; c=relaxed/simple;
	bh=EnceP3zAxby9Gd7UKyzsACNfFh/U0eVEzsye/mjXh5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsb8fEQLfkC1+/6UYYPqZ6NAOTHcG/u/aMu0+wdNfU5zO7RujgJFeGk+yYCsU0xaq+BpUJhSRryKDGHoEMdY2REIDFECUjxu3dmRRIdRCKpIv7u5BN1vnDdGxCoWARI61PeiB/Z4FfNqVWyV25mPa62ahk/i14MhUT5zNA/J2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQzm6OK0; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67bb87f866bso2136941eaf.2
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519297; x=1774124097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUx81sAr4LqFx9f2CLQOytjXeMe6lrxWLv4FjaWsnVM=;
        b=ZQzm6OK0AS/dByADCifyfvmuM5Nt67P8C03nokYMZPaCYSMhOi5QYT/N/0p9uOpxal
         KI7yxacerUUpHlkzMRCwgD7Wuq3wVCFkXG6Z7vihdsJDuh3EgGaoGNCiVREgnPjRlDZ6
         19qu5KbKDeaHjzALEqpK1mtq4QuuQUgAVAlgDXXxF5GDFRipdXDjvPdilJoajzk+7n0r
         078x5vhpx2PbL4muLjqTkKNwIdE568pC+duI47AyQy1TN9VXVbJE53Te0UeQuEEn11Gk
         LjouXnMvTt+VPd6svE260ycFYtBLM7XRYyCjnJyCZQnZwxnKetFScLO3kzLCkBKZre9X
         YPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519297; x=1774124097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FUx81sAr4LqFx9f2CLQOytjXeMe6lrxWLv4FjaWsnVM=;
        b=DX3P3tPE2Gddb0w6I9Um0fy4lA6Fm4RBh6dWFBLJ3nHv1SIz2rRDQyqTcoB7LtcB4J
         H7vTexHxxrcPtKdW0/FYLoW/+QVJh87DIaE8THzG4hvBa+qgv5/dJWfI1PclDQNpbPH+
         V7PqHWkWeRP2CgH6p4TtGO44KXWm0PbwybYB5HdRY7S/WkV/1Yf9lmwQFj/xM306loz6
         /7wGp1ksfiKduqotWiG2YKBbt9ZuEwwG0F4C4gtV9rYim3ja7jVbTz7X9QgP04BeWSKc
         PlBhn2+kgh8fgMLMJursB1C9d1/2NbcPVOR/cgLIPgJXHoS/yHG/Ij2BtP55zWXR5Y0J
         V7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUcqtolP8dP57E4FXqBCYhM8Mq8uxsX5HirGXiZ+i2qZ9rpZpoCGeSrF189+HcVdsL6unkkabUaOxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/q/tqoxL640L5WfTSl+JLXW6GZPVO8tPJU3YL3RoAHozQn+w
	Q8BeatHanHL9e8XQFU7B9PspZIPWmW926mQNjxQmC6qUqRqM9L9WIDnP
X-Gm-Gg: ATEYQzxNGafWIFba9B3ymIdbsh/xNNDxbEypVccKA2AfDoiQ4bif4rorQeCwu+ixhhD
	KIzI1BPRLZR5EHzE8Kym91jhAoTEaFe7k54HxUTCAKsuE/2lGtu9PXhpGH/FoUDrbEj1dI5yNMV
	tqudou8p7JV1IMX28/5/MtowmdPeyrbRkbLt2BW01emNu/NF4sUc1CSwwsYrqxV219TuJw4Tg1U
	i7FnwDMuDILJtXLJLZcMJNgCSMyJqoXImyIe9cDF6JD8sjlzhWi7UJQ8a0FoIwWrn9pnEFpqP5+
	q3FB2cyjmxa/89Gaq27aWAJvXgmxjY7lJ1VxI1xFFSGYaLt12l7Bl1Ng/EPEWXHugJp3P+uwnql
	xOV+rcyl8P8z6WWcu0EwSHCxVV6P6FrbcryXfNS8THEsbLRaRKQg8R+aEoCgOvgy+FskAlsUQ1k
	zce4Gd5jPKoTP6YdRIeuA/FELTeK9veK9ACERMt2eRgUX7qchMjaTf0ZnUK5aVh2WGiTLpnMhBZ
	zcgVC1bNDKAZ08zgrKX7nErDCW6UDrOI8FslSwZ
X-Received: by 2002:a05:6820:883:b0:67a:1d28:7bae with SMTP id 006d021491bc7-67bdaa2eedbmr4832661eaf.37.1773519297408;
        Sat, 14 Mar 2026 13:14:57 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:56 -0700 (PDT)
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
Subject: [PATCH net-next v2 10/14] tcp: expose rmem and backlog in tcp and mptcp rcvbuf_grow tracepoints
Date: Sat, 14 Mar 2026 14:13:44 -0600
Message-ID: <20260314201348.1786972-11-atwellwea@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5977-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,linux-api@vger.kernel.org]
X-Rspamd-Queue-Id: 40DB728EC3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

Extend the tcp_rcvbuf_grow and mptcp_rcvbuf_grow tracepoints with the
live receive-memory allocation and backlog occupancy that now drive the
window-growth decisions in this series.

That makes it easier to inspect sender-visible rwnd state against the
actual hard receive-memory inputs.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/trace/events/mptcp.h | 11 +++++++----
 include/trace/events/tcp.h   | 12 +++++++-----
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 269d949b2025..167970e8e0a5 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -199,6 +199,8 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__field(__u32, inq)
 		__field(__u32, space)
 		__field(__u32, ooo_space)
+		__field(__u32, rmem_alloc)
+		__field(__u32, backlog_len)
 		__field(__u32, rcvbuf)
 		__field(__u32, rcv_wnd)
 		__field(__u8, scaling_ratio)
@@ -228,6 +230,8 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 				     MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
 				     msk->ack_seq;
 
+		__entry->rmem_alloc = tcp_rmem_used(sk);
+		__entry->backlog_len = READ_ONCE(msk->backlog_len);
 		__entry->rcvbuf = sk->sk_rcvbuf;
 		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) -
 				   msk->ack_seq;
@@ -248,12 +252,11 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__entry->skaddr = sk;
 	),
 
-	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u "
-		  "rcvbuf=%u rcv_wnd=%u family=%d sport=%hu dport=%hu saddr=%pI4 "
-		  "daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p",
+	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rmem_alloc=%u backlog_len=%u rcvbuf=%u rcv_wnd=%u family=%d sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p",
 		  __entry->time, __entry->rtt_us, __entry->copied,
 		  __entry->inq, __entry->space, __entry->ooo_space,
-		  __entry->scaling_ratio, __entry->rcvbuf, __entry->rcv_wnd,
+		  __entry->scaling_ratio, __entry->rmem_alloc,
+		  __entry->backlog_len, __entry->rcvbuf, __entry->rcv_wnd,
 		  __entry->family, __entry->sport, __entry->dport,
 		  __entry->saddr, __entry->daddr, __entry->saddr_v6,
 		  __entry->daddr_v6, __entry->skaddr)
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index f155f95cdb6e..92d0bd6be0ba 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -217,6 +217,8 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 		__field(__u32, inq)
 		__field(__u32, space)
 		__field(__u32, ooo_space)
+		__field(__u32, rmem_alloc)
+		__field(__u32, backlog_len)
 		__field(__u32, rcvbuf)
 		__field(__u32, rcv_ssthresh)
 		__field(__u32, window_clamp)
@@ -247,6 +249,8 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 				     TCP_SKB_CB(tp->ooo_last_skb)->end_seq -
 				     tp->rcv_nxt;
 
+		__entry->rmem_alloc = tcp_rmem_used(sk);
+		__entry->backlog_len = READ_ONCE(sk->sk_backlog.len);
 		__entry->rcvbuf = sk->sk_rcvbuf;
 		__entry->rcv_ssthresh = tp->rcv_ssthresh;
 		__entry->window_clamp = tp->window_clamp;
@@ -269,13 +273,11 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 		__entry->sock_cookie = sock_gen_cookie(sk);
 	),
 
-	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rcvbuf=%u "
-		  "rcv_ssthresh=%u window_clamp=%u rcv_wnd=%u "
-		  "family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 "
-		  "saddrv6=%pI6c daddrv6=%pI6c skaddr=%p sock_cookie=%llx",
+	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rmem_alloc=%u backlog_len=%u rcvbuf=%u rcv_ssthresh=%u window_clamp=%u rcv_wnd=%u family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p sock_cookie=%llx",
 		  __entry->time, __entry->rtt_us, __entry->copied,
 		  __entry->inq, __entry->space, __entry->ooo_space,
-		  __entry->scaling_ratio, __entry->rcvbuf,
+		  __entry->scaling_ratio, __entry->rmem_alloc,
+		  __entry->backlog_len, __entry->rcvbuf,
 		  __entry->rcv_ssthresh, __entry->window_clamp,
 		  __entry->rcv_wnd,
 		  show_family_name(__entry->family),
-- 
2.43.0


