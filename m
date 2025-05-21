Return-Path: <linux-api+bounces-3831-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C036CABF34B
	for <lists+linux-api@lfdr.de>; Wed, 21 May 2025 13:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99601BC3974
	for <lists+linux-api@lfdr.de>; Wed, 21 May 2025 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24CD264639;
	Wed, 21 May 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="8Uq+DjmY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="qQDRBLVK"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB92620F5;
	Wed, 21 May 2025 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828192; cv=none; b=jK9gbuSRZhBJzC4uaNO1vL0DaSeCq44XCGsgIBM/vOJIIZDAbbVtnQwXGRCxiI1l1GpLwY5rw0A8CelNaTjHeHdSSZJmzOtHfhXQU0teAriXwvwVTLRhRoTvNndwL3N5752javIeTnSfMQ+kVr+XkezNGe6kAmkXrle6pGfk6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828192; c=relaxed/simple;
	bh=uTKGjoMGXj04yN3Myx3usFQWFC5D3Co2ptQ0dRtJr4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bD8be8oMLh3/gBjQHEnxtszM35+3JNFUA9rL8mrmbyk7Johp8D3MvTUYXc9DNpdIX5548uJZbngZoKs19DYQW59E+08vS1w0pZZ1XCPsoVMiYclUSEcVvPe5yhPs1HWBdJMyZ+gDSohRfvqdg6bAS59Fd4CR218VRpe7K/P50cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=8Uq+DjmY; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=qQDRBLVK; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=lEWYwwQHmD8Ov5VHOPf4Y8F+RFDCN7LlVYbW+6fxr00=; b=8Uq+DjmY6g/gQ8T
	89TXH4voLazJVTrHMh3bCz/WTiax6yy6Kodq/D8p6Hw7z5vLtSGh+5ceKMOhZSk80q+lgDw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=lEWYwwQHmD8Ov5VHOPf4Y8F+RFDCN7LlVYbW+6fxr00=; b=qQDRBLVK599dl0C
	N/p8/t56xoCHJJTVJRnKYCmflzgbmuJYFgpvzzSyE8gWC63wEmEFLLUhvN7eX8JywPPVakpy/h/CC
	iRFjLoEsc6CdtWN7oQr0vsFhW/4vPe0lcK8dHYh9cCd/skFeocPr2VQTLZHf89oWln2JUZZH/O5mf
	rBScGCRGur/OOFJBPB9qafrDh0eJfPyVS65YQ8oWlJv1+38ZIPHKioHYQSSGKPC+vmEl3oLL/L+2R
	m1RUXoW+mok8FU4RXWABF/heAcqRUjd8TmvrZV9AvT6PLGYML5tnWZYZYgvoVoYJgVtE+XrN8aL8u
	fIlrN48KuPM0GMQ/5zA==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uHhtA-00000001yTm-19OM
	(return-path <jgh@exim.org>);
	Wed, 21 May 2025 11:45:36 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next v2 6/6] tcp: fastopen: extend retransmit-queue trimming to handle linear sk_buff
Date: Wed, 21 May 2025 12:45:05 +0100
Message-ID: <b7a743482e916470ff6fb4fbeb1adde147ee89fb.1747826775.git.jgh@exim.org>
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


