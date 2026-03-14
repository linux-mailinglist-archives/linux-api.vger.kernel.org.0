Return-Path: <linux-api+bounces-5973-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCINJpXCtWkV4wAAu9opvQ
	(envelope-from <linux-api+bounces-5973-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:18:29 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD428ED4C
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 341253075FA4
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 20:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83260387572;
	Sat, 14 Mar 2026 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av4C9+ab"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A2386C07
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519293; cv=none; b=CcwmPPAzNyiwMmBklmKpT7aBe4LmDUcXBVWPJs+R5iGAkEhNS3NYlkg0zPNypbc8X6gtCsKc4cg56dA+uK4rVbKU5GymAxlN9cQPPX23esLpOFJgz8WRDNN5//xOr2EmnliZIVqs71/qUUw25Ho6e80leZnEi6xUju+GrcL7gjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519293; c=relaxed/simple;
	bh=X1zLIw1J0h9kTV3NoqokrWtcJn8B9ET3Wq/q4qH3Vzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhqMymXCvhw9FWO4378M3gjN2CCWXkqju7co19Wk8hM4S1vCwMwsER22Vm0n/iKva+bpfFenHE8VQ1E0Jkhso1XLHvDEU+Rn7yPg2QPMw/ZLMvFtpKE1x2plDyFQMIjHeC3yuAEBwa3xzgFZ/uy23y51z8o2lAFVLENfpmaaAto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=av4C9+ab; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d7653db148so2321282a34.2
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519291; x=1774124091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q07GcXVkZ6+WpFEBkbyw8fuqV93z6jZU74lSMjAcsUw=;
        b=av4C9+abqVpl1yMfwP13WzFukND7oTB7bmhw/zU+qs7arventB0BU1KB4Mbsou5O+k
         6DRJJrkSnX7dOSovGsorBbjyap39bFfQGwd9zn0pmCabgitQ3aGWUXM2Kq3ShumzS21K
         S4U0DuPE0UlEdXoN/+jcyQwD22HlteF2XGQcWzONGCc2q72voKQIm/HP4CoxGXuJVagY
         ohNaxMSy0L6t3uHxjB/zD9ya7F219NmdlOpPj/tTZWGriZQc1N63XXGmWzlLOyWUuZOV
         la5lceDE1cuF5SiB8JBi8dEXDq3ND1sgIheSbwJn3HqodREIbOvahlN/u1khl0jM+dBi
         K4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519291; x=1774124091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q07GcXVkZ6+WpFEBkbyw8fuqV93z6jZU74lSMjAcsUw=;
        b=Lbo5l8WSbEw7kqNszDhk15YCFAE21+EsUgS5YQLXQ6WFzO7gYFLEo1LMtDujsaziLd
         GgknN7qU5BnUzflfwZ1To9+1PK3xF0feTNxCJaoPIvyAXFbuem88jbJNHG10Al9PrMF8
         /R5+RhqyFjqpJcJ9R69TG4NlOIzrPSm/WmwAKTauG31Y+muqSiRrrlS6gi6CZqouX+TU
         7zMISK6DqKlnGpz/Ab0Y2tBldcrNUQSB0zaZxHgTJJl/+ncG/PB9A6zDdcRpu0Dxr712
         LE+NzhfldZ2ugbwaJSHXWWdWv76EIVZLmH9X9me+Uloy7KohaxY4luvJPnNur/U1c4Ms
         3AZA==
X-Forwarded-Encrypted: i=1; AJvYcCX0wH2E3U47FQA75n2Wxauq0oowOWbqqX9mI7FPZb4EMCoZKKCokOPLFId6fzgJowqGws6lFmuxHlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4RQxKWbMmU049Dbp0Xfg5GWCAKjk1w37qWkAtDU7oKH0BpYy
	lRZqQsL33b/4dQ5eAowdW064T7xqAG+P6T7R7RSRXlPU3NVUvyC6t6xA
X-Gm-Gg: ATEYQzy8HFEe/A2+KOODdxJvAUAE5gFv6SiKVXXbJ4za61BcSmhtxqgG9i0IYWEINR0
	sG53O3Mx26PI6PJETqnayDaFAB1Bd4MFh3Tr3U/PTQzTkDJV9Y5HGPlLHrjXoLx/hc7VrVczg/S
	qDV/9nMt+NxJu9VhYZW6yrF1s7lCGP1UmWpZjkenAZIf/uArJ+04+KCFfbeKcH/ChZ9VMsoJTms
	AMkO3ICEaPZMcAILU5nk2VWeJiLTj8UQxXsuSzV7v9Qn1Ln0aizAKm2vuYUpskocZPtzPk/QgYP
	FZf2Bn3M7nR/6QGxL0rwmW3nhwMDkMejOMS9qUbh6PkZHpi7Wt4RBka5JsA5HdCxsS9H3x1cocb
	ZFQ/x2VUDUc9ggLgAnoSXKZhCy5lKTa0FY9kgW4WSaKF5unKoqxgOC4BgAuD71bt/IsGO3rY1Ok
	t6hn1PuWUXPVHOCMCtgwZYee6D1kM7FIuB+NVooHPs8G883xTta5rmakTrr3GGXzpAAgyM0B+4M
	0IPkXyhqnaxtoQ95whxuXIiFwMf6bvZuPXu1bzBVG6uebJUj7I=
X-Received: by 2002:a05:6830:370d:b0:7d5:13eb:6010 with SMTP id 46e09a7af769-7d78259393bmr5062611a34.33.1773519290685;
        Sat, 14 Mar 2026 13:14:50 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:50 -0700 (PDT)
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
Subject: [PATCH net-next v2 06/14] tcp: regrow rcvbuf when scaling_ratio drops after advertisement
Date: Sat, 14 Mar 2026 14:13:40 -0600
Message-ID: <20260314201348.1786972-7-atwellwea@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-5973-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 46AD428ED4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

When tcp_measure_rcv_mss() lowers scaling_ratio after a window was
already advertised, grow sk_rcvbuf so the remaining live sender-visible
window still has matching hard receive-memory backing.

This repairs the live advertised window only. Retracted-window rescue is
handled separately in a later patch.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/ipv4/tcp_input.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 32256519a085..d76e4e4c0e57 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -221,6 +221,31 @@ static __cold void tcp_gro_dev_warn(const struct sock *sk, const struct sk_buff
 	rcu_read_unlock();
 }
 
+/* If scaling_ratio drops after we already advertised tp->rcv_wnd, grow
+ * sk_rcvbuf so the remaining live window still maps back to hard memory
+ * units under the old advertise-time basis.
+ */
+static void tcp_try_grow_advertised_window(struct sock *sk,
+					   const struct sk_buff *skb)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int needed;
+
+	/* Keep this repair aligned with tcp_rcvbuf_grow(): do not adjust
+	 * receive-buffer backing for not-yet-accepted or orphaned sockets.
+	 */
+	if (!tcp_rcvbuf_grow_allowed(sk))
+		return;
+
+	if (!tcp_receive_window(tp))
+		return;
+
+	if (!tcp_space_from_rcv_wnd(tp, tcp_receive_window(tp), &needed))
+		return;
+
+	tcp_try_grow_rcvbuf(sk, needed);
+}
+
 /* Adapt the MSS value used to make delayed ack decision to the
  * real world.
  */
@@ -251,6 +276,7 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 			if (old_ratio != tcp_sk(sk)->scaling_ratio) {
 				struct tcp_sock *tp = tcp_sk(sk);
 
+				tcp_try_grow_advertised_window(sk, skb);
 				val = tcp_win_from_space(sk, sk->sk_rcvbuf);
 				tcp_set_window_clamp(sk, val);
 
-- 
2.43.0


