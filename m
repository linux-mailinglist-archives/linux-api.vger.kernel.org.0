Return-Path: <linux-api+bounces-5981-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E2WNqLCtWkV4wAAu9opvQ
	(envelope-from <linux-api+bounces-5981-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:18:42 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB928ED5A
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A10783086DCA
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 20:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310333909AA;
	Sat, 14 Mar 2026 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivkAmQmz"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC038F63E
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519308; cv=none; b=OZsgC+0Z30hKsuExXwQGwhqqzILFfNtSOugCh8tPGBFQQkTI0m0VUdn615HQAGRiWNMh2OUXCf0m4i2NQ5pApGZQFQQ6BVeUBRzEn7DSsaMjld3XJdD0RiJaWou0dXFKiImkRKj1kwYR14SG8zFntTv41jUpAvGs/mUPSTAm8AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519308; c=relaxed/simple;
	bh=cj/seZubwP7nLqBoz8ofrtucQHhr4mn40yQgMXMr40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7wfl1tFYmMXP00I29MsD3eW2ew0S2pHmCFzDC+wNaxgL9HJIJUwlt3BGNcHyEP3C+1sm4yY1upLEOWrJXOHzj0fiJL9vNDYJEdvWMc/ArubiXq1DaiK+CONIeJpImmHv2BOUStFITsbhFZjsd4ffb9MaP+r8o371ymfhzGwLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivkAmQmz; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-41708e43f61so1125136fac.1
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519304; x=1774124104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib/vlu986mcpuvwIbmamafwqas870ti4JrE+4bqQJAA=;
        b=ivkAmQmzdcLJlNNYxp6d5Wvnrm5CvFJdBD52nglEHtaE7RwLh47ZMzL/ttonOB+vJW
         ZQDGv1lXXvYBjtu1ENydtWMCaC2R2fQ7ha+kdZFhUuOrMKfz9QO4ITE9pa5Zvew7Bx/V
         3dtfMLqZ1vEpFcQSBZvLiFGoB/FTq8slitueAr/d1F4HZw+eKO9/iLaEHzdp882Ss+hS
         C6EjZrO/iSi7raWOMd5nLDoooPqMIEwpIYFA6dRACEEYxrdCceevaNy2bx3fyx8kMWBx
         7JOOU4OtRct6dgB5K6pv4voVVEYlyEHiMgrIh35dTNf9rDrwFhxld1VAse/CgIwdmcfj
         ifjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519304; x=1774124104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ib/vlu986mcpuvwIbmamafwqas870ti4JrE+4bqQJAA=;
        b=f2AQnOQkX/MoLZZV4+eKpMLL0pS4LKurpWe2Z2pKyCuDQnlJfZXmFLrq3hrMCyQhf/
         Bm+2IyDCSfZPUStdmnnZILPvo1LamjZt52oVdU8IucAH/Ozdy2f55POH/FOPP599LUqJ
         8TOVDzIiLwyjxcn2BzzdTMxJQf36qMSBdiX+mSL6FKqBffeJxS74JpNuLImN+fK6HVHV
         +3Gx+LQC5Rd1/E2LrSMfItr3frdDiWexdvrtyDV7ot8kfda9EWRg7me3Y+obKLKOn3or
         wyHGxvkndnql1mwmYHKWHifffwe0wBXl3dI5qbJFGEErqiJLYVcrqLANqRKLf2pnQb5j
         026g==
X-Forwarded-Encrypted: i=1; AJvYcCXuzSg6LR9EMXe6GQqdfb3+xJo4Lf4+oc425i5/uZ8t5DMfDFQjitqkSCJqMKZOXpy3CuvGCFG7q48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/BM+M0xtjm1Twetiu6DZ5vG5hND9axujv8MhlId/ZnsElQ1t
	ehw8iwQs2GFrw35upnQ0oxhM+yQ1vnzdF+X9BwPpqK4bMwC77rvQ9Pm/
X-Gm-Gg: ATEYQzz81GmIpYnHVGWnf5qpNoPyMkiS9+9WyNrhQULhb1u3dphsnKRyRtwxRPCfetF
	sLGVrqUZrMayW0bqquc2ugs2Gt4tkr+H712c/74wLexI+Fv+E5CA9qLE/1wplbsfMwHAyWaypSr
	bdRH3jFt1ZXyiXbLjc/MKgSz/pCPNkxxIdPAZ4VPI3g4xxj90XCkSwS2VxQuYQpaAUceSiTUOsW
	JZNlKxKGVXxUG1HUKDFkbE2HJ1al5XNoFTYgvk0YYTHfH6U0fHEqHkm47QuoU376eFZDkw2vTnM
	CDI6jE4AyEAn0Q88sGbYDh+lbe1aaPiK9R/alrY2EoU+3Gw5x8r7Xb8pyrqStCb+Xyrq+2pIfgQ
	FKPLXmJydS3nN/dMnzoMtJQWHjEJMoMzR4pnfXZ/e8TFjawaXpSzYWakR5d+JJPW8fqJy9bw8Xb
	j/ud6UIv1zL97pzljHG9JLqyWgWS16nF2Ys6bWKmRqCBoFLKFj9fx3aYXX71XKwEd1rP03NEQB5
	1mdKgU5d1xA8SbM81A8AKDs4pmRu3bTQ2V9+SNl
X-Received: by 2002:a05:6871:c949:b0:404:168:3ba1 with SMTP id 586e51a60fabf-417b91d86f7mr5008979fac.18.1773519304503;
        Sat, 14 Mar 2026 13:15:04 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:15:04 -0700 (PDT)
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
Subject: [PATCH net-next v2 14/14] netdevsim: release pinned PSP ext on drop paths
Date: Sat, 14 Mar 2026 14:13:48 -0600
Message-ID: <20260314201348.1786972-15-atwellwea@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5981-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FDB928ED5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

nsim_do_psp() can leave an extra extension reference pinned until
nsim_psp_handle_ext() reattaches it to a forwarded skb.

Route the drop paths through a common helper and release that extra
reference when __dev_forward_skb() fails and when start_xmit() drops the
skb before it reaches the peer RX path.

This is separate from the peer RX truesize test hook itself.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 22238df79b6a..c22513c523d6 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -187,6 +187,15 @@ static int nsim_napi_rx(struct net_device *tx_dev, struct net_device *rx_dev,
 	return NET_RX_SUCCESS;
 }
 
+/* nsim_do_psp() pins an extra extension ref until nsim_psp_handle_ext()
+ * reattaches it to a forwarded skb.
+ */
+static void nsim_psp_ext_put(struct skb_ext *psp_ext)
+{
+	if (psp_ext)
+		__skb_ext_put(psp_ext);
+}
+
 static int nsim_forward_skb(struct net_device *tx_dev,
 			    struct net_device *rx_dev,
 			    struct sk_buff *skb,
@@ -196,8 +205,10 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 	int ret;
 
 	ret = __dev_forward_skb(rx_dev, skb);
-	if (ret)
+	if (ret) {
+		nsim_psp_ext_put(psp_ext);
 		return ret;
+	}
 
 	nsim_psp_handle_ext(skb, psp_ext);
 
@@ -278,11 +289,8 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		 * the synthetic cost; sender-side skb accounting stays put.
 		 */
 		nskb = skb_clone(skb, GFP_ATOMIC);
-		if (!nskb) {
-			if (psp_ext)
-				__skb_ext_put(psp_ext);
+		if (!nskb)
 			goto out_drop_free;
-		}
 
 		consume_skb(skb);
 		skb = nskb;
@@ -303,6 +311,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 out_drop_any:
 	dr = SKB_DROP_REASON_NOT_SPECIFIED;
 out_drop_free:
+	nsim_psp_ext_put(psp_ext);
 	kfree_skb_reason(skb, dr);
 out_drop_cnt:
 	rcu_read_unlock();
-- 
2.43.0


