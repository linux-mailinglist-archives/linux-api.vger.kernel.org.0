Return-Path: <linux-api+bounces-5928-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIz0K/UisWkOrQIAu9opvQ
	(envelope-from <linux-api+bounces-5928-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:08:21 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D6E25E9D9
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9F03393838
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BB33BC68E;
	Wed, 11 Mar 2026 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh/S2Ut8"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155363B7760
	for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215805; cv=none; b=Ixi2EQd6uk4KtyALzZQB/zdhr8rhmMJmsrLkpWlbI5Aj2QfetEPm8R9Z9Du9FGT2qGHh0Onr4Br7Yp3yLUVUxcsC2labn1VV+Utk0YK4Z1jest5GEeazoZ7teVBf+scVPZH5QyDt8MJ15Wi0wS3+tyjwXqiZ9Q0SkJGqXkxjqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215805; c=relaxed/simple;
	bh=C939i0d+rKTXWj91cA/6uhlPcNX1BycjNPrjJIyRlB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMkhtfLwGpxZJ3wvh+AnxkEBvuMegPJKrMo1wdPHfLrb1BLVqGJx2sPq0jtaVlBql18I6qjrBNRJc7sAd2BOOo+8aP4xHLx7DseR0prdLSVX+eQyqytxs2g56Xf+O4BRsXxTtRUElvb4BdLpkAYMi2+F/PyHZvvAPnJlUwO8tQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh/S2Ut8; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-41708e43f61so1520901fac.1
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215799; x=1773820599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4epqsXquWuAivDGaqjYARTGwK/kOqEMKWTt83y67gTo=;
        b=Kh/S2Ut8Mz3IOrJyUF1u8U1hKxWbezXDQfvjBZZZSRIxPlXeO/7kz+0xvq1bMEiJAe
         lXzcI5udhKCFXJqU2fL1KoH6Jdn0FZiXxgwW39Y5VOznkbwDLALQDwc3P74kEVEYjYq+
         yig8cAAHYZAQ9qcVilzLP9jNYCgVewxw+Yb2TwGYXDOSkqfDkRmwMpg3p/Tfa3pSEe9u
         g7bABRqWYHbWBfa3Hjar5WRpxYmkbhu4XEe3Rvhy/d2yHHE/pxgWgsqKVIWOOYvwEhnl
         AVOMSDCrZpk1GXQMspz5ABATP+Km1F5tyN8Czb/z1EperES+Pbim2ngZgi1MZtlBkUbW
         hTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215799; x=1773820599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4epqsXquWuAivDGaqjYARTGwK/kOqEMKWTt83y67gTo=;
        b=aHhcL9o/NyQs4x1WdNAJUtKs8mkT2xenUpn+7h4ySfD1atfKmHNdA7rB5N3HvvzviR
         0O9Kg0Om7M/SsmWz0fkRvQ2sJnkXJ5AbaHiG19swHi54NFubLfZ9ZrT6HD/RDRTjokcl
         Tknp2sNKCiTVlU1kKIuoD/UsgPWQrHVYpiUM08Pffk/PkgiuSvwRkt+Ju9klhjdUxzse
         1/qkh0yyjmAGPoOVvA4d7ntxlzS45CMWxVLtSkbFp/K8W6JDZHXQe/DojKawhICGUtWj
         rlU3QQgd9V3z2PLSPTaqn7+XtN3HOftL3yHC2aXKOy0LEowML3JNAD+UKWRlTWIy/9+h
         4ptQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxSpRZCq/8ZvLBj5nnnDBlZL4Jeoy2Zr4sWF2AKjqfet0Sl1ElLX83DovxqVauEZxUcUIGdzI4wPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx301nXj51EG1hYboeEdBtgGqThdTCN/agsTnMLEJsAPGxCh7W
	pZ9PiF3PbcW2I6+Jd2S94kXzbyJkZMFlHT3wQTK/X8MBYIhOeD9PKVCb
X-Gm-Gg: ATEYQzzNyBgCe1eEYkoJGvV/iXbMjjA0MjVYC73kL4OLw4jJwS005lNnHct4qzxwuQ6
	P4GhmWXhbffOUFkM7XL8Zgt03KcSALbnbcOasXYv0Mitt94ICIxM+0RT8hx3uR/PqvQDjo9tpiS
	TOgHdfIfUHtZiPu5S4weGdRHt55x7OWTSZea/y8I/GPW3frt/dn3Hu3d7ATRVAAJkYMK4xQeaV3
	3CIszmbuKPO/t8/gSWoFugAXu3kcL4AoBU2BLT13ORuKy/UGHCMTcEE2cHxkwn6673lgYoxcMaT
	aRa7TtNuH0FxwiC7Ql0JaZEM74cehxhS+KiZ6dxT+jnwlGW0ai3hn+2ICYsPkmUyvH3LsoO4AIf
	WaqYaxfjwevGY6Dgecy4N7guWp0sTCwGxDNQthRcmfOHyWQ5bWDyNd3zxthfNErlajMdCnqhzDl
	xT/P3EKtwnDgtEht/mK54id3YrQ0LknwOt6gb7U+irB3BDyEgkh0jMaT/lL7iduecgqTV16wusG
	Y0A2XrZUfjk+VTFQtshq3yPkE2UNAqKAiWLRoaqFnaftKlV
X-Received: by 2002:a05:6870:8e07:b0:3e0:de76:31e5 with SMTP id 586e51a60fabf-4177c8b4e62mr1075613fac.25.1773215798847;
        Wed, 11 Mar 2026 00:56:38 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:38 -0700 (PDT)
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
Subject: [PATCH net 6/7] tcp: expose rmem and backlog accounting in rcvbuf_grow tracepoints
Date: Wed, 11 Mar 2026 01:55:59 -0600
Message-Id: <20260311075600.948413-7-atwellwea@gmail.com>
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
X-Rspamd-Queue-Id: 53D6E25E9D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5928-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The receive-window work now depends on keeping sender-visible rwnd and
hard receive-memory accounting aligned.

Expose the current rmem charge and backlog reservation in the TCP and
MPTCP rcvbuf_grow tracepoints so that later drift between advertised
window and local backing is visible during review and debugging.

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
2.34.1


