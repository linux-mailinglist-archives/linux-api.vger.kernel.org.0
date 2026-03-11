Return-Path: <linux-api+bounces-5926-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFYxLcoisWkOrQIAu9opvQ
	(envelope-from <linux-api+bounces-5926-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:07:38 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B8025E968
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD8AE3382281
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212DC3BD23A;
	Wed, 11 Mar 2026 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/2YPI1C"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB513BBA12
	for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215801; cv=none; b=Qdl5LdlZ5nuEhlJGgG5/W7YwOsyqKXBFJYCGZgslmOasWw8ySKdwdmJcLO1++t4XgjOAA69QkBRhIHXyDzju149tzVt+9G2ebUrY90RYLKpYgDt06mNdK9U/2D/TErhA7he3tVjZiSy5xWhPBGOBzLgvznB52/7EwT7Tsjgt3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215801; c=relaxed/simple;
	bh=FWYsgoyKVIUupg0joGsjXBrmnww52mswGSTqsNgSq3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS46AlyGU1HHjqGSPZIk1dmJWFVxuqxdJJ8wzV9IDdw2i2TTvHzs3adfhWYXBPjdPoON2gZXzGyoi8ZZjwzkQrFtNpySLRt1muTSTYI8s3WHepgsaPnAGTXyoUMj/Kx4BqHQLWkkarT1uzey3Jre5xGvC8frSVEPKkKRPixr1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/2YPI1C; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d751ef36ccso1423334a34.0
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215795; x=1773820595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWRaO2kk43skP87kgk2P1rc0roOMtr/hXw08wzU1czs=;
        b=H/2YPI1Cgww1qLF8X73k6RMOlAtgpK/tDCvVe+qwTWtv1lCqP/9Fz45QU3JjxC8vrb
         KrI/fsEV4RvZpfe88/9Cwo/YMKi35uyvLHUFKDak3gowGawOrR3bOjUjQ3v6IgOmR/9L
         FYLTBlILCke4UkUMknw1uBgIO5NQE+pfMPuzCDz+CnIWsyP7Hkf22Ya8+euYwzq9rU4Y
         +bIc4n7aEXDhyF8zB00n5LgY89TGa4cFLqoLjmdsa67XhchiL3Zu+1D7GOGzgbGmzERY
         0igkVYqDe1yoW9f/vGObwMv1JwybRSSMh3KeQl5KIPum6s8beGt543tmJSEwsJMkvkWu
         AR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215795; x=1773820595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWRaO2kk43skP87kgk2P1rc0roOMtr/hXw08wzU1czs=;
        b=YXY1R3RKxDyn++crCgtlJTubGkQ9TcvUPgFYjTqU6Uh1m3jsslHAwj9VGuyQqS4+q6
         zizLXKsubBuuPSrGBIUbH58M7VBe5kjBwxgmzNVyQdoR30PM3ItvgVdrxYJ0bnqvdtGv
         9ofoH/tqARtKhD+TAgB6+Skf6Y1zzBoqOn8Q4+OHOHpxh+XpLZaU6WHKCW75W2BtVtTw
         fYIgNhGE38CfvGTdecWcoMw8UXiFu4vcWzMLlbP1xpkDeOBp3bmEezCL/sfyW19Be22b
         3RLgOpVQeGSM58DOSE6/x8ziuyGPQ97IHggM9s+8AZQHuLACqe6mW4NxtgCcUPSa0J+0
         e+6A==
X-Forwarded-Encrypted: i=1; AJvYcCXpK64RmhsmXK+z76HFDK8yMVxRDD9R85vXGOKStU/qCDoTa/AoGLAQ0ddIvMQY0FBjcsfjWxEvlZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkEVs9grTFNz0PM7YXZwl9Ev4tE2BeE4hyfMNl2s95Mr60fCif
	oY5enhF/6HC65NsWNzeGb4bv13acUveHgR9fOVW7DXIFY+v6WTozAO5z
X-Gm-Gg: ATEYQzz20dzflSRxSmUezNWHnNGgedJFHN3R1rNCvdGkmNtlnMITd6vWIy5OeLwNgdr
	qCpA3B4u/RK3atPqzF2m2qCPUqch2KmYMRlWRCb1niJycrm4DBmF3SURB1r8VcvFe8kb+oLPzHa
	MdwKiSmQGLFa2BNXWGObGxt+tPZ0R6QkR8k/0QGNg0zj8f7UX0yOY5a951+aECcemCi2p6+Qjcg
	tLhGjDdexVym6/5cQAaYiFlOqUh7en8/VcNqfTNQdWC+AMML428/n8AQs8y55aZT1riQYHEr70X
	pDQAClZS+7KhUH59rMWSuuXwvPoGHNCo3RbumfdtvO69e4SjkcaiYZtVV5xosmOq+BgF1/rzvZU
	sEbyCfWFM4eWbGsXqRU9+lzeBytoAHlm/RH43iCmj/dyxRZx5Nihebka1t9KkZQpwyJVzIN0EOM
	9yMC7klVH/XhEQEHoIXptkPXjHHUOENvWPZtFNXWPa4rL5BizSlsLhzTh20EPODclrsaulIEEmN
	6fo6neAtBIsZPebn1foFulLvB1AVyRRAa0vRaIRQoasG583
X-Received: by 2002:a05:6820:4deb:b0:679:e889:dde1 with SMTP id 006d021491bc7-67bc8877e83mr927920eaf.6.1773215795085;
        Wed, 11 Mar 2026 00:56:35 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:34 -0700 (PDT)
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
Subject: [PATCH net 4/7] tcp: extend TCP_REPAIR_WINDOW with receive-window scaling snapshot
Date: Wed, 11 Mar 2026 01:55:57 -0600
Message-Id: <20260311075600.948413-5-atwellwea@gmail.com>
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
X-Rspamd-Queue-Id: 58B8025E968
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
	TAGGED_FROM(0.00)[bounces-5926-lists,linux-api=lfdr.de];
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

The paired receive-window state is now part of the live TCP socket
semantics, so repair and restore need a way to preserve it.

Extend TCP_REPAIR_WINDOW with the advertise-time scaling snapshot while
keeping old userspace working. The kernel now accepts exactly the legacy
layout and the extended layout. Legacy restore leaves the snapshot
unknown so the socket falls back safely until a fresh local window
advertisement refreshes the pair, while the extended layout restores the
exact snapshot.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/uapi/linux/tcp.h |  1 +
 net/ipv4/tcp.c           | 34 ++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 03772dd4d399..3a799f4c0e1e 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -159,6 +159,7 @@ struct tcp_repair_window {
 
 	__u32	rcv_wnd;
 	__u32	rcv_wup;
+	__u32	rcv_wnd_scaling_ratio; /* 0 means advertise-time basis unknown */
 };
 
 enum {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cec9ae1bf875..dd2b4fe61bd8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3551,17 +3551,25 @@ static inline bool tcp_can_repair_sock(const struct sock *sk)
 		(sk->sk_state != TCP_LISTEN);
 }
 
+/* Keep accepting the pre-extension TCP_REPAIR_WINDOW layout so legacy
+ * userspace can restore sockets without fabricating a snapshot basis.
+ */
+static inline int tcp_repair_window_legacy_size(void)
+{
+	return offsetof(struct tcp_repair_window, rcv_wnd_scaling_ratio);
+}
+
 static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
 {
-	struct tcp_repair_window opt;
+	struct tcp_repair_window opt = {};
 
 	if (!tp->repair)
 		return -EPERM;
 
-	if (len != sizeof(opt))
+	if (len != tcp_repair_window_legacy_size() && len != sizeof(opt))
 		return -EINVAL;
 
-	if (copy_from_sockptr(&opt, optbuf, sizeof(opt)))
+	if (copy_from_sockptr(&opt, optbuf, len))
 		return -EFAULT;
 
 	if (opt.max_window < opt.snd_wnd)
@@ -3577,7 +3585,20 @@ static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
 	tp->snd_wnd	= opt.snd_wnd;
 	tp->max_window	= opt.max_window;
 
-	tp->rcv_wnd	= opt.rcv_wnd;
+	if (len == tcp_repair_window_legacy_size()) {
+		/* Legacy repair UAPI has no advertise-time basis for tp->rcv_wnd.
+		 * Mark the snapshot unknown until a fresh local advertisement
+		 * re-establishes the pair.
+		 */
+		tcp_set_rcv_wnd_unknown(tp, opt.rcv_wnd);
+		tp->rcv_wup	= opt.rcv_wup;
+		return 0;
+	}
+
+	if (opt.rcv_wnd_scaling_ratio > U8_MAX)
+		return -EINVAL;
+
+	tcp_set_rcv_wnd_snapshot(tp, opt.rcv_wnd, opt.rcv_wnd_scaling_ratio);
 	tp->rcv_wup	= opt.rcv_wup;
 
 	return 0;
@@ -4667,12 +4688,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_REPAIR_WINDOW: {
-		struct tcp_repair_window opt;
+		struct tcp_repair_window opt = {};
 
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
-		if (len != sizeof(opt))
+		if (len != tcp_repair_window_legacy_size() && len != sizeof(opt))
 			return -EINVAL;
 
 		if (!tp->repair)
@@ -4683,6 +4704,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		opt.max_window	= tp->max_window;
 		opt.rcv_wnd	= tp->rcv_wnd;
 		opt.rcv_wup	= tp->rcv_wup;
+		opt.rcv_wnd_scaling_ratio = tp->rcv_wnd_scaling_ratio;
 
 		if (copy_to_sockptr(optval, &opt, len))
 			return -EFAULT;
-- 
2.34.1


