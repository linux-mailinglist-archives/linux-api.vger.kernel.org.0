Return-Path: <linux-api+bounces-3786-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 105C7ABA059
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB97C1BA7549
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E894B1CEAC2;
	Fri, 16 May 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="ldGH8748";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="FLKQh6Q9"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92711C4A10;
	Fri, 16 May 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410967; cv=none; b=eOyE0xCBhL9xmBveYQoZgwjfHbdqMLF4b5dCCMlqZ1pUh8g3irPq/e0GcW34P9T4QRfK8tSN0wG//mQvtNwyH8hLeuACAgBNgwJlkm18ecgzcrO2gcxXhbNQdcqZ4NfxstOAM0KdsQ1MTG2FkqJeeZrQsq2FIqjH2LELVQRbHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410967; c=relaxed/simple;
	bh=GOmNOUxIjL7FpfpdDBjTyoaeUXKoUvzhkneuD7WUxtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDIaRPLmUvhjmNNPQAwODBO14ILHY0aFy9nl41lGHImmVaYuB6JFrU9HHc6x3/aPY6fBfQ/4m9yultTJERhQF4jvTfBy4zL2M18AsHPppYKsKozj9FCbrp15ZK/JJJs6ihlKvEqBD/xpkrvAa+aw+yhZUFDpFAqHAVYp9mSbdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=ldGH8748; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=FLKQh6Q9; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=X1jUlirJuPk7kGbfN3el3gS5c708I/qfwMVd/PFAGjY=; b=ldGH8748gsmDwpq
	GtVQQsMaTooGJXnUTQtwaLP272nckvDX63VfkWj+lpm+SHrFMzXGdi5vcoCdNu+JE2/6lCw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=X1jUlirJuPk7kGbfN3el3gS5c708I/qfwMVd/PFAGjY=; b=FLKQh6Q9eE8bS+/
	LlrtyR5LM2z+uFka4RyA3C7IN54ht69xa2PygM0rXkjAbcePQc17wfHC2ZctZevJNa7B9oLLiisUo
	sOmrTufv7JbXaUCJsXXfN1B0b8oRQEj1UuF5sqfzvGbDD28KfP7lAkVC4+Cg4ztpd0XtNyG5RNgbC
	iCPbxC8Ymw2EPz3n9oJzAXqsNIoQeLMFkZXBHkzEyKBRpDSjlC295Yxvf6xJvBO970i3ZyHpTIlwV
	9k0Ryb50TL1sML78jeLpmrppySec++3KZpItt3OGoGtYgIsnPItqC9WTiZjmGkgonNX2pGOD9x2zS
	5zgiZdiHKH6kQNx2FXg==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uFxPo-00000007363-0XpL
	(return-path <jgh@exim.org>);
	Fri, 16 May 2025 15:56:04 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH 5/6] tcp: fastopen: retransmit data when only the SYN of a synack-with-data is acked
Date: Fri, 16 May 2025 16:55:03 +0100
Message-ID: <6201e4cb8374df23e86bf3af0fd6794005f77b4e.1747409911.git.jgh@exim.org>
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


