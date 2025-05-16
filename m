Return-Path: <linux-api+bounces-3787-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644FCABA05B
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 17:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D0517BEBA
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 15:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5414F1D54FE;
	Fri, 16 May 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="EnI5EJnD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="aOEWq0Uv"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949DE1C5485;
	Fri, 16 May 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410968; cv=none; b=LIZvJEzeV1CTQfN1DlZlM+/wVYjhSmLTR98PmMAy1XbjX0yVsXwzcSESkwPXgAO2WVYuFECo4Yl+X46aLJZkB9VtO3tn4YFy7W4MF9PvRdjR0wKxMFdzB3kT2dXcn+qwEElCLTlqeG7INlw+Ex5CE70sFd6jKf3+1tK31qqzLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410968; c=relaxed/simple;
	bh=uTKGjoMGXj04yN3Myx3usFQWFC5D3Co2ptQ0dRtJr4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWaPsZQfVM9cBHD818BqOIS40VR8EsfcdDAvc2gkKEL8QZqzsBSJaLXxf6ZM+6lu/uqeMs//OO0F6JEz7NYMLo7deAfLZOCw8frc1F3cmRWkeDP8YToKOjFQ2wxwYMnEoZY/l2HKRdW61I2i9LrDaTmNu76ohUkUr4H9UDuLtak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=EnI5EJnD; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=aOEWq0Uv; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=lEWYwwQHmD8Ov5VHOPf4Y8F+RFDCN7LlVYbW+6fxr00=; b=EnI5EJnDna8tOFP
	seJhATmbbkrbMuBO4EPmzn+a2HZohT7zSjjUUxJI5X88C6QuVtWdekxwECLZg37Ig8n2BBg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=lEWYwwQHmD8Ov5VHOPf4Y8F+RFDCN7LlVYbW+6fxr00=; b=aOEWq0UvORGmuqo
	qN66nwWWf3rrZK2IwWu0mFKe/oi4JT2yCxDsMSGQI6iDPtHWfQKeJGL/l4e+681VXR6l9LMCKkgVJ
	Mea6WZ3j7zyFmz7BSv7VkgpdONXpGmqVMQKB+ZaAZ6cqmmwHP5cuzEWSTO6sEe5ZnALiVUZuuONCa
	YPS2xqwCN7GWarX8JXV/K9eQeRxHbfSNdwGcSfiV6t32r4jKe2bLcMACM95NBXBAiJjIRezUt+/jZ
	kJuMup6FFNNi0zPaP5Mnr7HfBAfjNcJZlM7GWqCOM5Ukl8+dSLjyUeOBvA9a3f8A3QxMMXzvdLx1B
	9d77oDu6k4CWcfxrMlg==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uFxPo-00000007363-1wMo
	(return-path <jgh@exim.org>);
	Fri, 16 May 2025 15:56:04 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH 6/6] tcp: fastopen: extend retransmit-queue trimming to handle linear sk_buff
Date: Fri, 16 May 2025 16:55:04 +0100
Message-ID: <d901d0a442c341aae2d6652fc6fe7d4ea5ee66c7.1747409911.git.jgh@exim.org>
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


