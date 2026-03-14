Return-Path: <linux-api+bounces-5970-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKxHGy/CtWkV4wAAu9opvQ
	(envelope-from <linux-api+bounces-5970-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:16:47 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FAC28ECCE
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44BFA305A430
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 20:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3138642A;
	Sat, 14 Mar 2026 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYmglQBk"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833A53845A2
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519289; cv=none; b=TxGlXBjoMFtu1tFDPbRPSyv/58stlaNkZC7igB8PNPlahQmsKu2bPBotOhcmkavGQcGir0PhFupSbqY7NUT3smYPE2ICUROXKKZIPRiuNxwBRYnVYJm0UvuBRDqhBXH1oFEqCP0MrJKBKJh3o0NEmOEHUo5m+3Xxv7mHLT3+BFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519289; c=relaxed/simple;
	bh=Ttxd17H5LIzMMzsw2TR13aHibCW2LBBebxMgXaknmMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRvHxNJyiBaXBw5L5vCGTRSo+7NXoaLbl/B4dEnY2Z/QiBOveYx/OrX51kiMgZN6znwhQlCFEt2kQRWGr2kIMzlYpaH1BEKIgb40hLLDMAdbzZYj5IfU7maTi/h+xrv2yY1rJGVb5H2g6EOKogifY4YUKZwFh870Hd8b8PQfz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYmglQBk; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40429b1d8baso1292771fac.0
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519286; x=1774124086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMcuR3aCCM7PiXgftnIc+4nYAKR8gQqAUuswiZ7+FpY=;
        b=GYmglQBkG2E1X7kBarsxxIkNHb6EjaPAexNG1J/bbJZ/0cXvJUreZuGHd6Q8gpCRJc
         THax/x7rWjLdmM93OMlNnpCT6vIx0UK2aWUQwZyYq285oHH2S/GXRP6Hh4G0zUj8G9ZH
         BaoLhauFbOMn6zIIziSlGKm9KLpd8yMaohK8FEe2mw/u8jtJJw4Nt1/KtZSdbznqP9dO
         B5/JjRREpPF0nZGjCDEX4bQQ4+i837nS/KDXSE7C+XV6rClkeTa6XyIG4kaKMeWW9HyO
         9N9bsmPdqkKZEUXtur5bUZFEyOiLFOcW0S3Bcr6PBYq0+xFor32PLTZXUTlUBFPpmhN4
         ZsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519286; x=1774124086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zMcuR3aCCM7PiXgftnIc+4nYAKR8gQqAUuswiZ7+FpY=;
        b=qrR3yxzogPYWW+1jAFn9eFsVPVl0IWTlHVpQbXtFFw9cdF63T/hD7yTrAj/9CriuwZ
         qYar/BG92ReyxF3ZHUN1YUKOY1mxesaSxQOr+DqHT+v/EKM7CGYo9Fh/CXU97+NXW3gq
         cvylufdSy2Rb75kE2c0gX0ocOqgkBxyTjNLCz+X+u4LkTq4Hchq0D4vSYYzq+zlE3Ryc
         FTALQeEisksurlvsyy26m6cVi845wvNLHKm2S8tU4TlqfrNONPMj+JmgV2njCFcPEwSJ
         laClrhzDR3rCa4fdnWBU0uwr4aRcnbM0H1+zeESfUMkxibtnxYqc/ZBlPejej9JxPHWP
         DKHg==
X-Forwarded-Encrypted: i=1; AJvYcCWf+GN60oYuuYn+iwfh3Fwljlw3ybYcflNZ5Jy7ARAkkTSbK3B7+XL5dBu56M1fNmPD9vQmAq84eww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsTd/nLzV4AD3TrvGKoP1goF65udTpsedag1xFsPpMR/OOIsPF
	tvAyzlqeuEN5BrBlL0fs77jc7f6xFqpBo06khBiHJMDJwc+AqhhqmjO9zwUip+7Bc6k=
X-Gm-Gg: ATEYQzwn/1zOwF3KYfE+wFBixAcqN7E1nVbZKDV/6gkkniUtGS5W5mWdsjDiHYYk2TA
	IocboM/fc0JSKN3HVFXSAYAiPZO5nJL92CHgUechgnLIg4lH6Ftk93/giLdK6gtTDUQ1yZxhP7O
	M/w6PFI5acuSlst1eYjU+ey6VGYWG8A2rNE5YROY6kzbhCRfQ8rmFbVEJxOhYGgC1cXIRHCBRok
	x8EXWV+fNoHLv8CDgxN/y2gyD6AMxNSkpboUehCiq75ULYB6GBFsw1mhNMJW+jbcbIULtzivoJx
	LZ4gImFMn+aUS6sO5/w0RV0vJ6nmida7aK/9rWPPauIWvVL2XArc2eBEMmvFvi+WqWyZlyNTuiO
	tMtXfAHH+HCfmaVag8z7H9APMaYGWjfDoUKC9dv7OVSgv1EHMyBFFmLjSOsGwJxAx8v55WU2dzs
	frhKJaWuwFevfzcJzTVGbceumyMGayTkEaIOOD83xGTz48iW3vue7rCAgFTnFqq5ZqKLII1VHUk
	2EGH+rI9pDWM+S42JkG+DEHb1W+Znl7DrImiM2o
X-Received: by 2002:a05:6870:ebc9:b0:404:590:59dc with SMTP id 586e51a60fabf-417b938f328mr3924319fac.33.1773519285922;
        Sat, 14 Mar 2026 13:14:45 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:45 -0700 (PDT)
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
Subject: [PATCH net-next v2 03/14] tcp: refresh rcv_wnd snapshots at TCP write sites
Date: Sat, 14 Mar 2026 14:13:37 -0600
Message-ID: <20260314201348.1786972-4-atwellwea@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5970-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17FAC28ECCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

Refresh the live rwnd snapshot whenever TCP updates tp->rcv_wnd at the
normal write sites, including child setup, tcp_select_window(), and the
initial connect-time window selection.

This keeps the live sender-visible window paired with the scaling basis
that was actually advertised.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index d350d794a959..1c02c9cd13fe 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -603,7 +603,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->rx_opt.sack_ok = ireq->sack_ok;
 	newtp->window_clamp = req->rsk_window_clamp;
 	newtp->rcv_ssthresh = req->rsk_rcv_wnd;
-	newtp->rcv_wnd = req->rsk_rcv_wnd;
+	tcp_set_rcv_wnd(newtp, req->rsk_rcv_wnd);
 	newtp->rcv_mwnd_seq = newtp->rcv_wup + req->rsk_rcv_wnd;
 	newtp->rx_opt.wscale_ok = ireq->wscale_ok;
 	if (newtp->rx_opt.wscale_ok) {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 35c3b0ab5a0c..0b082726d7c4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -291,7 +291,7 @@ static u16 tcp_select_window(struct sock *sk)
 	 */
 	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
 		tp->pred_flags = 0;
-		tp->rcv_wnd = 0;
+		tcp_set_rcv_wnd(tp, 0);
 		tp->rcv_wup = tp->rcv_nxt;
 		tcp_update_max_rcv_wnd_seq(tp);
 		return 0;
@@ -315,7 +315,7 @@ static u16 tcp_select_window(struct sock *sk)
 		}
 	}
 
-	tp->rcv_wnd = new_win;
+	tcp_set_rcv_wnd(tp, new_win);
 	tp->rcv_wup = tp->rcv_nxt;
 	tcp_update_max_rcv_wnd_seq(tp);
 
@@ -4148,6 +4148,10 @@ static void tcp_connect_init(struct sock *sk)
 				  READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_window_scaling),
 				  &rcv_wscale,
 				  rcv_wnd);
+	/* tcp_select_initial_window() filled tp->rcv_wnd through its out-param,
+	 * so snapshot the scaling_ratio we will use for that initial rwnd.
+	 */
+	tcp_set_rcv_wnd(tp, tp->rcv_wnd);
 
 	tp->rx_opt.rcv_wscale = rcv_wscale;
 	tp->rcv_ssthresh = tp->rcv_wnd;
-- 
2.43.0


