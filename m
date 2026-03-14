Return-Path: <linux-api+bounces-5975-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN6NJ/HCtWkV4wAAu9opvQ
	(envelope-from <linux-api+bounces-5975-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:20:01 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0828EDA2
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4BEA30A724F
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 20:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3F03890FF;
	Sat, 14 Mar 2026 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j49SHDWy"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155E3876C1
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519296; cv=none; b=M4DGvqh05YCe2b9ZNe8W6jv92EPcKhqxeywUtzrmaMheVMEvqGO8x/qAnng8gh/JaRZS8/ULj12q8DyvHXJLbP//F7VRVouF2wXMqZQ+afvPTjG3UxUqGasvupF/st68DEiDzrCAwlZmOmBlRXhQ+iCEh+nqemdcSSn4OyHhIhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519296; c=relaxed/simple;
	bh=UwI3YBDLFZSN0Qol0fxNTwazKut7aA5SPPECRbpGROI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIVSZKDYxrPLCd8tcYQfb5fkBjwciDw0RSLps9co+oQ4tsf8MIIPXLD0asdoMcKEiUALyVDuYOqgWEsRnQnfozkSS96WOmh2qpH4+V02NKfnVpQF0HGYNCMoqypMIOXe9fJVlMN+3SzESu7gbEBQPfATGKayI+gFI7ZJgXszBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j49SHDWy; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4138136f02eso2337965fac.2
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519294; x=1774124094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8jG5HL0B71BMqNMR6IMNfhIt0KSqCtw04UXTW9LEYQ=;
        b=j49SHDWyhL6wVPV5IL2n94528OcExoRQnxUY1jTYXuP9K5S7QNJhuDq8bK7PGpVdf2
         IqZrZw86ALzFrFB7Dm1rYuRSKE51wU3EBTogSlIzUc8xR7rhpUWSEgMkUE3jmocumDW3
         ZXRd33PWAzTNzUQIcWtqxbrFNOrq00xB6l/Afjl+nBygCSzgG3J8KYC1MXTabkdXlG5Z
         ho5UwDBIsi6JuMoafh9D1E73l18caLotal1OPM62yTIie9pZ+IcMRXu/muCXIk7W6eAv
         Q221WX4LU4hrfBVNoXINbhrBMEwgtWdBRAO25EnJl/8EHyc6i8KbPBQrnVbLQN0uz7L4
         4BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519294; x=1774124094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8jG5HL0B71BMqNMR6IMNfhIt0KSqCtw04UXTW9LEYQ=;
        b=AsB8dGdyBiHKVdRR/pOl2uRgRxJTO2dQ2kLE/SJzVQoAZCvy0jOoEptkDCIvp8n7X/
         KmrIPqr7kH4YvtW9NNY8Dlk5mPD8FNNih+WC9Jt69DEI3q1wHynNPb+l8NYy4ZnsfT2A
         kCpWLE56XQ5MlDqRkopkS7P6o2j2/EPGjzTIGR54t+RrSu8gsx3/8sbARhOUpSbD35BR
         GTS3N+9GiNh299KEIjFzRzdLi9koNr31OrlGyIfM3y0Q5iElBTWNswoKQgjoSUf9VdbU
         v2YfU/hJLrF61+rhxvDL/6oPL2BvFfNtCSeXadj3kRkNlMGMS/6K1YVMCEnYMQWT3s9L
         crqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjAgkEVC94r4Quse2JnNACgxQOM/WULRetySLBCTEb4Ry+a9nedgXCoZTXADVQWhM2lWbiVQfBEKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6rOLrSoWC2AAAM1vSYbtVdC+BW1xG8Zdfey+GBQah+w6ezSbg
	mQ9J3R8m6MpEPRdM5PSIYmG53+r3FO4ypiBjhQEixBan5boxDRwkhw4I
X-Gm-Gg: ATEYQzxRpKwfzt3uEVVPFTEhbWsiQYrl1GGq2/A3+BSlVwvPHeVtdMLzNZJHgtjdfHy
	MdNp4Bo6K8mGcSzT3GNqyz2uqxbgbKo1U5K3LfZKxdCxV/LNbCaiYyIXrWTK6HpIgtdiOU5P2QR
	LDw6phYxHHvF40BAZ8C6UrY+J173/K3Bgxyi/7Szqk5NmxJewTgYj9kSc/R1FL5RkJSTEuC+aOW
	EzHkAhu2ys1PVI0+5aWFwJz3ehah6Lhg/iuZbqIeBYNEyGS8RE4rRgH6xHvCIiLxQYA7mSHiy/4
	N/E/hVtm8t1Hrlt5NmlU7b01C+GiNHcDBPP5U8EFss01A2dJpamQlT8tD9+iA/XpjYMPme2r5Ze
	Dxge/dvla96LzE+aUpiJqOK/bp+j4wZfej/GtvqHfiWhBcmKn1dn+XlR8EqhN0aFEKQvj0/6um3
	sTh8jCHRQ/EcL9dt+9rkgVaklvrVc/4zgJtqmW1CaoWrK7fsE7JZCyuhwvxhSn5F1ycn7OkSlWO
	tte1BRBB6Y6tVTQ9e0XGLkvF4dhQXsDEsyWBC97
X-Received: by 2002:a05:6870:a70b:b0:409:5241:8abc with SMTP id 586e51a60fabf-417b91902e7mr4222211fac.20.1773519293652;
        Sat, 14 Mar 2026 13:14:53 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:53 -0700 (PDT)
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
Subject: [PATCH net-next v2 08/14] tcp: extend TCP_REPAIR_WINDOW for live and max-window snapshots
Date: Sat, 14 Mar 2026 14:13:42 -0600
Message-ID: <20260314201348.1786972-9-atwellwea@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5975-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1ED0828EDA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

Extend TCP_REPAIR_WINDOW so repair and restore can round-trip both the
live rwnd snapshot and the remembered maximum sender-visible window.

Keep the ABI append-only by accepting the legacy and v1 prefix lengths on
both get and set, rebuilding any missing max-window state from the live
window when older userspace restores a socket.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/net/tcp.h        | 13 +++----
 include/uapi/linux/tcp.h |  8 +++++
 net/ipv4/tcp.c           | 73 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5b479ad44f89..12e62fea2aaf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1766,13 +1766,14 @@ static inline bool tcp_space_from_wnd_snapshot(u8 scaling_ratio, int win,
 }
 
 /* Rebuild hard receive-memory units for data already covered by tp->rcv_wnd if
- * the advertise-time basis is known.
+ * the advertise-time basis is known. Legacy TCP_REPAIR restores can only
+ * recover tp->rcv_wnd itself; callers must fall back when the snapshot is
+ * unknown.
  */
 static inline bool tcp_space_from_rcv_wnd(const struct tcp_sock *tp, int win,
 					  int *space)
 {
-	return tcp_space_from_wnd_snapshot(tp->rcv_wnd_scaling_ratio, win,
-					   space);
+	return tcp_space_from_wnd_snapshot(tp->rcv_wnd_scaling_ratio, win, space);
 }
 
 /* Same as tcp_space_from_rcv_wnd(), but for the remembered maximum
@@ -1800,9 +1801,9 @@ static inline void tcp_scaling_ratio_init(struct sock *sk)
 }
 
 /* tp->rcv_wnd is paired with the scaling_ratio that was in force when that
- * window was last advertised. Callers can leave a zero snapshot when the
- * advertise-time basis is unknown and refresh the pair on the next local
- * window update.
+ * window was last advertised. Legacy TCP_REPAIR restores can only recover the
+ * window value itself and use a zero snapshot until a fresh local window
+ * advertisement refreshes the pair.
  */
 static inline void tcp_set_rcv_wnd_snapshot(struct tcp_sock *tp, u32 win,
 					    u8 scaling_ratio)
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 03772dd4d399..564a77f69130 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -152,6 +152,11 @@ struct tcp_repair_opt {
 	__u32	opt_val;
 };
 
+/* Append-only repair ABI.
+ * Older userspace may stop at rcv_wup or rcv_wnd_scaling_ratio.
+ * The kernel accepts those prefix lengths and rebuilds any missing
+ * receive-window snapshot state on restore.
+ */
 struct tcp_repair_window {
 	__u32	snd_wl1;
 	__u32	snd_wnd;
@@ -159,6 +164,9 @@ struct tcp_repair_window {
 
 	__u32	rcv_wnd;
 	__u32	rcv_wup;
+	__u32	rcv_wnd_scaling_ratio;  /* 0 means live-window basis unknown */
+	__u32	rcv_mwnd_seq;
+	__u32	rcv_mwnd_scaling_ratio; /* 0 means max-window basis unknown */
 };
 
 enum {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 66706dbb90f5..39a1265876ea 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3533,17 +3533,31 @@ static inline bool tcp_can_repair_sock(const struct sock *sk)
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
+static inline int tcp_repair_window_v1_size(void)
+{
+	return offsetof(struct tcp_repair_window, rcv_mwnd_seq);
+}
+
 static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
 {
-	struct tcp_repair_window opt;
+	struct tcp_repair_window opt = {};
 
 	if (!tp->repair)
 		return -EPERM;
 
-	if (len != sizeof(opt))
+	if (len != tcp_repair_window_legacy_size() &&
+	    len != tcp_repair_window_v1_size() && len != sizeof(opt))
 		return -EINVAL;
 
-	if (copy_from_sockptr(&opt, optbuf, sizeof(opt)))
+	if (copy_from_sockptr(&opt, optbuf, len))
 		return -EFAULT;
 
 	if (opt.max_window < opt.snd_wnd)
@@ -3559,9 +3573,47 @@ static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
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
+		tcp_init_max_rcv_wnd_seq(tp);
+		return 0;
+	}
+
+	if (opt.rcv_wnd_scaling_ratio > U8_MAX)
+		return -EINVAL;
+
+	tcp_set_rcv_wnd_snapshot(tp, opt.rcv_wnd, opt.rcv_wnd_scaling_ratio);
 	tp->rcv_wup	= opt.rcv_wup;
-	tp->rcv_mwnd_seq = opt.rcv_wup + opt.rcv_wnd;
+
+	if (len == tcp_repair_window_v1_size()) {
+		/* v1 repair can restore the live-window snapshot, but not a
+		 * retracted max-window snapshot. Rebuild it from the live pair
+		 * until a fresh local advertisement updates it again.
+		 */
+		tcp_init_max_rcv_wnd_seq(tp);
+		return 0;
+	}
+
+	if (opt.rcv_mwnd_scaling_ratio > U8_MAX)
+		return -EINVAL;
+
+	/* Userspace may repair sequence-space values after checkpoint without
+	 * also rebasing the remembered max advertised right edge. If the exact
+	 * snapshot no longer covers the restored live window, treat it like
+	 * v1 and rebuild the max-window side from the live pair.
+	 */
+	if (after(opt.rcv_wup + opt.rcv_wnd, opt.rcv_mwnd_seq)) {
+		tcp_init_max_rcv_wnd_seq(tp);
+		return 0;
+	}
+
+	tp->rcv_mwnd_seq = opt.rcv_mwnd_seq;
+	tp->rcv_mwnd_scaling_ratio = opt.rcv_mwnd_scaling_ratio;
 
 	return 0;
 }
@@ -4650,12 +4702,16 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_REPAIR_WINDOW: {
-		struct tcp_repair_window opt;
+		struct tcp_repair_window opt = {};
 
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
-		if (len != sizeof(opt))
+		/* Mirror the accepted set-side prefix lengths so checkpoint
+		 * tools can round-trip exactly the layout version they know.
+		 */
+		if (len != tcp_repair_window_legacy_size() &&
+		    len != tcp_repair_window_v1_size() && len != sizeof(opt))
 			return -EINVAL;
 
 		if (!tp->repair)
@@ -4666,6 +4722,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		opt.max_window	= tp->max_window;
 		opt.rcv_wnd	= tp->rcv_wnd;
 		opt.rcv_wup	= tp->rcv_wup;
+		opt.rcv_wnd_scaling_ratio = tp->rcv_wnd_scaling_ratio;
+		opt.rcv_mwnd_seq = tp->rcv_mwnd_seq;
+		opt.rcv_mwnd_scaling_ratio = tp->rcv_mwnd_scaling_ratio;
 
 		if (copy_to_sockptr(optval, &opt, len))
 			return -EFAULT;
-- 
2.43.0


