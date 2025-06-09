Return-Path: <linux-api+bounces-3889-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E462BAD2355
	for <lists+linux-api@lfdr.de>; Mon,  9 Jun 2025 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE7216FAED
	for <lists+linux-api@lfdr.de>; Mon,  9 Jun 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D1C21ABDD;
	Mon,  9 Jun 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="TK5Sk4xP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="nyNXsfMx"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079A217660;
	Mon,  9 Jun 2025 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485148; cv=none; b=YnTtsYac/rPKiD8Hg0NJyXoxY8i0MC1pHa43cLNG3RZzb1R+MxqWS5xL7jqr5uHHem7fpmbBOG7AnMr0iCEMVTTR0F2xfr99bXw6zIX4CL4dens8FTkR0JITl8puFHAoWolWSAfpU07Zp3LjKLJUu9zV3MlfvSS4sC+Yw86lzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485148; c=relaxed/simple;
	bh=GOmNOUxIjL7FpfpdDBjTyoaeUXKoUvzhkneuD7WUxtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egkRk1P8fsJe/Zv5QtJmphYVczqKjC63UPDHmHtYV/U5GJWS04SoYJInIyB0PSOIIZnb5e1M4o0diABLhYG3q4ZbGszzdRfsp8LdW58Rq1s/3RwFnBiWviTF4Ofnd2NKdkxje00mImP48zFBSzeJhcQz14YqQt7mXYDLo6z4B+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=TK5Sk4xP; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=nyNXsfMx; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=X1jUlirJuPk7kGbfN3el3gS5c708I/qfwMVd/PFAGjY=; b=TK5Sk4xPvYq3Qbe
	3kwAXhRCPgZT6oMT9M8e/cgEHwz1wACXSmd5x9FqNpEHU/0crsfmo35QJh1T9w3Tz8XbfCQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=X1jUlirJuPk7kGbfN3el3gS5c708I/qfwMVd/PFAGjY=; b=nyNXsfMxXDxad4h
	CaJTiijePfKSI9Clzmwsp81krDLTdHGJMjvhZ0j+qra8KOmPvO4UUE9Pvd7M7+mQl5W96gXEWkC7Y
	0EKOC6GEdvJcs/KyJAQztvK+DHLQP1+m9fRA7RMy22rDEixerJh1eCNn0LcS8jaLe4A/PjhMToLuI
	OBJ261Lc+2D72i+u312/VivvvXbW63VmE6ZKE7vCa9HY71So+gw6Jmy6ovKbRZ/0mkqwQN+ndRcmq
	QkDE6MisvgCm3H9jYVxOtJ39uRoh8dkFmnnTpAh+yO9qMUMnre7OUSN8tg54ifrr8geU1k1lK8lNK
	s1ONFLndauk/M8nFhRQ==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uOf0L-00000000n6h-0amY
	(return-path <jgh@exim.org>);
	Mon, 09 Jun 2025 16:05:45 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next v3 5/6] tcp: fastopen: retransmit data when only the SYN of a synack-with-data is acked
Date: Mon,  9 Jun 2025 17:05:21 +0100
Message-ID: <edf1680d5052a529e6dda11d36f49171e1af48eb.1749466540.git.jgh@exim.org>
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


