Return-Path: <linux-api+bounces-3890-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D698AD235A
	for <lists+linux-api@lfdr.de>; Mon,  9 Jun 2025 18:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0801B18920C7
	for <lists+linux-api@lfdr.de>; Mon,  9 Jun 2025 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A4B21ADDB;
	Mon,  9 Jun 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="vL18kM/t";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="JpC/bo80"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64521A95D;
	Mon,  9 Jun 2025 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485149; cv=none; b=F8c4tN9D/5xg2p7z5fXkzBde25j46zeEFpaRn/VJ/CMJEhIeJSDYWyajqrJL2A3VyjgbeoYlOfQLtftnVVojwyLRDynYIHV7gYjzU7shHaCtX8YOXNg6duijtEA2wlbezW54cTuEPc5uDPiij2LeUKDF46x+1QhstO6Tuj+CQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485149; c=relaxed/simple;
	bh=uTKGjoMGXj04yN3Myx3usFQWFC5D3Co2ptQ0dRtJr4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOkR+BBTDU0yc/Grvcvas5d6XwOmr1rbgDy1T94oJrCx80ABub93sCCgZ0y7bRJkRBmxZdIyGxNPcikJcTSNRrsROPOxJhkOSAlVMS+hPArTo/FsbRl2BhNGJznWoigAb8OpNWeCWCAnflBiNJj1SvBMApKJ8hHNq6+Y45rOlHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=vL18kM/t; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=JpC/bo80; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=lEWYwwQHmD8Ov5VHOPf4Y8F+RFDCN7LlVYbW+6fxr00=; b=vL18kM/tq75QL2z
	ZCGSoBKcYEmwSqSO/xGQCVtd34M8EC+4up41Do9SozJnYkqxtoOAauLomixqp8+881Kl/Cw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=lEWYwwQHmD8Ov5VHOPf4Y8F+RFDCN7LlVYbW+6fxr00=; b=JpC/bo80IaDRnZD
	DpuwWf8FDsys/bUMfmy6Q0CnxfyLAHivv+dq8dbFFz4soNE9Bjypcl4L5jTeT4v3LG2KnGZ17QKWA
	3LevRrqNgVTMOfXmQTckpmqE9ki5z7RF74IJ+a1jbM7hBpjyAv/1JpJwMnFtUvy7i3tqSYg5zZvKG
	xM0fnWtp3ITvh6+nSlQoJAqMoWIW5FXL1yqUHq9YwR3IXHJ/hK53/5YFPh7smq6rmJbLE2Mn7VU9f
	D/oLrW23/sZ1qapS6rD6tJ5tW0fhpo6WLBm+UdrMy/9Ch2TdjVWVr8kgui3Mm1lXbR3HOgAOn1V+P
	ocZbjhjbuagkWg/SGnA==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uOf0L-00000000n6h-48rC
	(return-path <jgh@exim.org>);
	Mon, 09 Jun 2025 16:05:46 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next v3 6/6] tcp: fastopen: extend retransmit-queue trimming to handle linear sk_buff
Date: Mon,  9 Jun 2025 17:05:22 +0100
Message-ID: <5a10c22ceb84dfb72cd70a3d11f8371a68866dfc.1749466540.git.jgh@exim.org>
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

A corner-case for the 3rd-ack after a data-on-synack is for
some but not all of the data to be acked. Support this by
adding to the retransmit-queue trim routine to handle a
linear sk_buff.

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 net/ipv4/tcp_output.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c50553c1c795..bff5934ff04b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1708,8 +1708,22 @@ static int __pskb_trim_head(struct sk_buff *skb, int len)
 	struct skb_shared_info *shinfo;
 	int i, k, eat;
 
-	DEBUG_NET_WARN_ON_ONCE(skb_headlen(skb));
-	eat = len;
+	eat = skb_headlen(skb);
+	if (unlikely(eat)) {
+		if (len < eat)
+			eat = len;
+		skb->head += eat;
+		skb->len -= eat;
+		if (skb->data_len)
+			skb->data_len -= eat;
+
+		eat = len - eat;
+		if (eat == 0)
+			return len;
+	} else {
+		eat = len;
+	}
+
 	k = 0;
 	shinfo = skb_shinfo(skb);
 	for (i = 0; i < shinfo->nr_frags; i++) {
-- 
2.49.0


