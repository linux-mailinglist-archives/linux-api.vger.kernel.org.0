Return-Path: <linux-api+bounces-3834-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5D8ABF351
	for <lists+linux-api@lfdr.de>; Wed, 21 May 2025 13:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF713B0FC4
	for <lists+linux-api@lfdr.de>; Wed, 21 May 2025 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09DF265607;
	Wed, 21 May 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="RQd4A3Pk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="qjubHqEF"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B025A2AF;
	Wed, 21 May 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828200; cv=none; b=ezb1DxWHo0CvybSi3KbiRBPkxjk+UQSVhnFMsA8GExSJOPJyQQhmAcUrvURvr/G/YBDaZZql4MiZM8SiVpDuqG0On+sxJFGTSbpjVIMo1vyqIqhRJTHngG2Vv7Lw9FquqtAqYRASr3jCIU10C3NAlW1Nopc3l/yfJAL5Ed4CbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828200; c=relaxed/simple;
	bh=GOmNOUxIjL7FpfpdDBjTyoaeUXKoUvzhkneuD7WUxtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLJkTcQxP7HWzc8YKFnH2kf8fsTFJaysrXKtca7MyTIIgx9BVhqxXVgr/9m5jEUZzrvj0aFyiAP0Jdaesqc0m2+xvDJ2BVYkQVWDKXmFNduiZHPvVx9Z0b/jUuD2fz+yJfjHSAzdaZRSSQFQcE11MjI9a9UTDqLawdf9FsuFbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=RQd4A3Pk; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=qjubHqEF; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=X1jUlirJuPk7kGbfN3el3gS5c708I/qfwMVd/PFAGjY=; b=RQd4A3PkyhPL5Rt
	VjBwtSl9fHxB855KDiudNgGY1H287iaDykVau4Y746KR86Nyz+54RnxLS2gja3EYMGaTfBw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=X1jUlirJuPk7kGbfN3el3gS5c708I/qfwMVd/PFAGjY=; b=qjubHqEFRo1XDt9
	EDC/WEs9gRXLmVLj0LV0FW24VHwrbYNSwEQ4DWeCskUqq4+s41HRRg74lTAYZAzRmV53loZqqQbm2
	YwILHXGqI/d919OebDfwDOXJ12yEGePmjwzUCMsp8sjGMQieoh1FNjRK7XQ8aWthNANChVd6xMLy6
	H9naiFKER7mGlfxGgjZ9cM6/MSnJpcF2E7yzDBfl+8m83/f6iD6umn5c75hmBemCMY3vnF13Kxv2S
	krFDGuPxcNksTuEu5y5MXm6QvpIymZ2y3MaLQKj3deUtWImAUfapdPoXQ4cxsXrqKExfX+yNgCZ9E
	SpKVnKbwElUGp3Hl4sg==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uHhtA-00000001yTm-0C5v
	(return-path <jgh@exim.org>);
	Wed, 21 May 2025 11:45:36 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next v2 5/6] tcp: fastopen: retransmit data when only the SYN of a synack-with-data is acked
Date: Wed, 21 May 2025 12:45:04 +0100
Message-ID: <685024553d541e6c06d7428f2cfe9160e8fc9ff4.1747826775.git.jgh@exim.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747826775.git.jgh@exim.org>
References: <cover.1747826775.git.jgh@exim.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

A corner-case for the 3rd-ack after a data-on-synack is for only
the SYN to be acked. Handle this by, in ack processing, when in
SYN_RECV state (the state is not yet updated to ESTABLISHED)
marking the retransmit-queue sk_buff as having been lost.

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 net/ipv4/tcp_input.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 345a08baaf02..a53021edddd5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4069,6 +4069,18 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 				      &rexmit);
 	}
 
+	/* On receiving a 3rd-ack, if we never sent a packet via
+	 * the normal means (which counts them), yet there is data
+	 * remaining for retransmit, it was data-on-synack not acked;
+	 * mark the skb for retransmission.
+	 */
+	if (sk->sk_state == TCP_SYN_RECV && tp->segs_out == 0) {
+		struct sk_buff *skb = tcp_rtx_queue_head(sk);
+
+		if (skb)
+			tcp_mark_skb_lost(sk, skb);
+	}
+
 	/* If needed, reset TLP/RTO timer when RACK doesn't set. */
 	if (flag & FLAG_SET_XMIT_TIMER)
 		tcp_set_xmit_timer(sk);
-- 
2.49.0


