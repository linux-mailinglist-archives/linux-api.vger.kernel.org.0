Return-Path: <linux-api+bounces-3888-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE6AD2351
	for <lists+linux-api@lfdr.de>; Mon,  9 Jun 2025 18:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8445716E6B4
	for <lists+linux-api@lfdr.de>; Mon,  9 Jun 2025 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB5B21ABB0;
	Mon,  9 Jun 2025 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="S3Bi+SlG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="Z3LPv1cx"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE513219E8D;
	Mon,  9 Jun 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485147; cv=none; b=X5wJiqECsXyz7MYuassjXoBVwCXG2xWjLcWmrdRhHUkT7c1nSbHloipfi/l67arEN+rtoJkygE025phMYp/Xn6yUvU6QhMZ5sMjDKSKA5fk3Jkvsc21rI/4Y9m1ZSEpmB6NACijrakjzUl6fvKRUFtHCM8Oy23JiwqgURRNaxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485147; c=relaxed/simple;
	bh=H59FyAJLWzXwn/QRxYNX7FO1RffMhpDaObiulKVs7sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIkDZ8CDOOCQtVTcDTwo0ITyu2kNEtSBgFnBB3IWEUpyRYwc9TXDmExdsEFXYbDAByEvxnAnBdz0RMi+OkIjbIYQqw9uYkDdxzjel8i19N9J4FBaMd1pbhWYqtPP8PWNPgSXZzid6o613eMs09J0NE0cmy+UqKGX818gaHgsy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=S3Bi+SlG; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=Z3LPv1cx; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=7J8KsMu0luRBxt3dJ5Kbm/pDzf8XFDYhV9l44WRVJZ4=; b=S3Bi+SlGU0mLw9H
	Sqx1gIewkfMDVq9S7pdP1nMNeZKdbYKLamiYzwOWUjM5QZ/WDkqlmKZHdp0CssDSbJl+1Cw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=7J8KsMu0luRBxt3dJ5Kbm/pDzf8XFDYhV9l44WRVJZ4=; b=Z3LPv1cxqFqriUH
	k57nRQq8YyHqJQujNSyzZGh4tieFKgo7DSrHtM9hNmHe9lGVE5BeWSuW80M4ivWogWe6d8DJaWYCM
	iEmrkPY5Me660c9dZRkryaXZXpBtL5F34DrH2kBvzS9Ypw41RPhYac9+pRbfkwyvnXM8ryYZcc5/F
	QpfH6Z3JtwLNBbpFhTcCd8IaVso+L8rmzbExF58R2vB2LrJQrfhcY5RcbECb6QqqIVh/ssJ82pqtN
	S63mf8aXjb4Az1DOBFfI483p3znGEHNW9/5udfMDgW4QZM5UoHxgIaemrQSUyyz+KsdFOlmTjEd0h
	vPKWdNWWwwEUZycyPGg==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uOf0K-00000000n6h-0tRB
	(return-path <jgh@exim.org>);
	Mon, 09 Jun 2025 16:05:44 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next v3 4/6] tcp: transmit any pending data on receipt of 3rd-ack
Date: Mon,  9 Jun 2025 17:05:20 +0100
Message-ID: <7d73f08f0fe8eb43c18dd1cd2eca80a1c1cd3d5b.1749466540.git.jgh@exim.org>
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

For the non-fastopen case of prelaod, when the 3rd-ack arrives there
will be data on the write queue. Transmit it immediately
by allowing the SYN_RECV state to run the xmit-recovery code.

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


