Return-Path: <linux-api+bounces-3789-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE5ABA061
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975E53ABB2C
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7351DC9B8;
	Fri, 16 May 2025 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="B/scKisY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="BcSbYPxG"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4E1C4A17;
	Fri, 16 May 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410969; cv=none; b=KyuxUhbp3WqJE+LfG2X0EkHujHRPL/N3v/2exDRslWgXQyRYM2AASLcbrHcKsyP838KMknkQ8AWdaMHYv0UxjNS2A/AU7Hqv8lvKC9/P+Ff4Gwi4Fs9HxS4qWG5/S4dS/cdtxSySyNz4WLLZXFigLqli13idXkavEHQcAClhDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410969; c=relaxed/simple;
	bh=/8EsM6BRyc0g3vlGm/7x0a+DxL/gOg3Vrr7yYO/oCPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4aYPB3oTsx1huYleZmfXXqWWkydZfMbL7fV/NUZTyD5Ts2KwIVO7q0qimHR8lYaKCjoSyxjDlCopI/+wKscw50wsAuCJURlKnWvHqHSKUc3+TDcBg4M9iQ2X8/DcxH68HyT13tIwrtZ2KFkb4HFURUq/gR9+GoMWX0TIXmfFMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=B/scKisY; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=BcSbYPxG; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=dwa9n0vM+saGNiHuv80Sdy07xurtcNugWn6VvuI+IR4=; b=B/scKisY1UDG9RF
	Uw2Ewf5nNyxPXRRcXIVSxmVR9G4JNjWPykLdaU2PYNTr1iMv1UsAe3gW6BHk0HiT3365QCA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=dwa9n0vM+saGNiHuv80Sdy07xurtcNugWn6VvuI+IR4=; b=BcSbYPxGF6DwsiW
	BxISl+JeIb3bgnjUopUqyiLzR3D04uBGSmW8BUu38XOeAM2C0VRuJMEjy7MajqvMD4c/Wr/0Hw4Pu
	z8xbg+v9Nn2Cfp7r+gCe+jNRaz6k8ClmthQUAwABMPJW5oCqwPfGbYOW7pkq5mobwK1j0IROELRs7
	m0RqDjXnOsHJT5k8UuMDGvAcaCkJ6NBmpeZCbpkE0necRh3CMWQSaIEd2g+rYAw1tVJkB4vtmnmRR
	4XeD0EdSIDlgCjbCL1XkWANKjpRPsAQKnZAi6auou3ENNz2hApHMyDuh83aIruxt9nEWlGPG1PceY
	z+rIOJCbl9r7kKH9yAQ==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uFxPn-00000007363-3OHy
	(return-path <jgh@exim.org>);
	Fri, 16 May 2025 15:56:03 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH 4/6] tcp: transmit any pending data on receipt of 3rd-ack
Date: Fri, 16 May 2025 16:55:02 +0100
Message-ID: <7787ef4a5f96bc9744b4844b2c3a9e7a81a157b3.1747409911.git.jgh@exim.org>
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


