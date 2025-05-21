Return-Path: <linux-api+bounces-3832-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860B0ABF34C
	for <lists+linux-api@lfdr.de>; Wed, 21 May 2025 13:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA54A179E
	for <lists+linux-api@lfdr.de>; Wed, 21 May 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4615826460B;
	Wed, 21 May 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="CWthe4og";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="Vl8/Nhma"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB51264A61;
	Wed, 21 May 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828195; cv=none; b=GSWQXeN7F3LUOnqYYqRZ/Qr6DtcDKS9eAGY45dtyxg0GCWRfgyfMsJ8r255W8COczGcYRgLBc5dTQhb6MEG6POjoGud8oWYkR9HfWoJkSQyqHLFANP7MZbHUPPGG7UDHjow4ZDwNIF8mcDwWeuNub4rjcXvQr/9gfiuCwiizTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828195; c=relaxed/simple;
	bh=/8EsM6BRyc0g3vlGm/7x0a+DxL/gOg3Vrr7yYO/oCPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfpNbBYgY4T1T0L3almRX7wzBAX9iHM40WCYkKE14jKIOWt3kYgpolGr95POeZMkHQhenYuGtDg3Q6NcZGeI+CB6WvXdkIF/vVc7bEGCe7BVavlaDXqFEa9VrViGOphJKbhHcVnri12KoTClNkIUH/qCvSxilMpAO6xaiDAKdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=CWthe4og; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=Vl8/Nhma; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=dwa9n0vM+saGNiHuv80Sdy07xurtcNugWn6VvuI+IR4=; b=CWthe4ogQ4VTbQd
	BvvwazX8GidDe0OVhiQboLoCNNvBFAsTFfphIPJqyE06T8kEdHMf+m3qhpJJJEqv1OG1AAQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=dwa9n0vM+saGNiHuv80Sdy07xurtcNugWn6VvuI+IR4=; b=Vl8/NhmawY9MVSS
	nEkV2C805MMpnMKauNkmoQlmILYzrOt3hQzvRuCPq+4+tqDur3urmejuWsBF1O2GyXC8F7vsAMI9r
	/eyuXV0JHK5CII+Y2UYbcK0XfaMm/zPd3Hc+nLHDl5YadF39FUzqPkz3FhXItHz7qg9dfGQJX0e+r
	OiWcpJsR4+pyxwySGQAp7W6842pU1ZN465yrjduMOdb0tdSUxaqbub8Vhr88MxIyJRUPMDZg8xr6k
	+pEFu3ahPzWYRcYRU2+lUmocm2aelScI4dcVaAjZQpT3KtsOX0ef0b7oDqX79vY0e4wmmBtsVIq2d
	7HiafIGn1HLZTFymOKQ==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uHht9-00000001yTm-3N9O
	(return-path <jgh@exim.org>);
	Wed, 21 May 2025 11:45:35 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next v2 4/6] tcp: transmit any pending data on receipt of 3rd-ack
Date: Wed, 21 May 2025 12:45:03 +0100
Message-ID: <46cd124e7d2bce9fb4174c130f055db40eea54a4.1747826775.git.jgh@exim.org>
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

For the non-fastopen case of prelaod, when the 3rd-ack arrives there
will be data on the write queue. Transmit it immediately
by allowing the SYN_SENT state to run the xmit-recovery code.

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 net/ipv4/tcp_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8ec92dec321a..345a08baaf02 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3900,7 +3900,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (rexmit == REXMIT_NONE || sk->sk_state == TCP_SYN_SENT)
+	if ((rexmit == REXMIT_NONE && sk->sk_state != TCP_SYN_RECV) ||
+	    sk->sk_state == TCP_SYN_SENT)
 		return;
 
 	if (unlikely(rexmit == REXMIT_NEW)) {
-- 
2.49.0


