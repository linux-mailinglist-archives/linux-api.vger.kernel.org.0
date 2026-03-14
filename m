Return-Path: <linux-api+bounces-5980-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGpHJErDtWkV4wAAu9opvQ
	(envelope-from <linux-api+bounces-5980-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:21:30 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD028EDD8
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B255830C19EA
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D2539021A;
	Sat, 14 Mar 2026 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBb15A9L"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A038CFF0
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519307; cv=none; b=U5k8Dm8C1VyWdSsCiDb1L2Ld47a24B6DQ7EVfPfCGOPOEfe+fS8VfkfWtnnnQTzzIByxrI9rE3+luvLBnTiv3eBQXSZCWXobJS5GRuzq3G99CjFd/TzWsrqGX2O1VKwcDn4nU6oqPgu2pX9VksMl3XWxXVyzaoeQ92L9k/KJIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519307; c=relaxed/simple;
	bh=6JX3Yctd8bDnEGsPO4CjvDQJ7QxYVDLwhFVJibho2l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtSMwUCqh450y8TJ1O15kZHHjKFARFQS6QSDJzwX7N6Os2TtOt1q+S3Dgees4dOz0X5FJkiDtu+r/Q7gMM0CcgV6ycNMnnOrJ/SYnOIqq3+rfpNNTX3YBtlMJgkZg7BISjAz0uDqwxYX2a3lqA6jANvY6fNwjlnXsRwjKvX3QAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBb15A9L; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so2247405fac.1
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519303; x=1774124103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cgfXJCeRN9gp7HY5pu2xM6oON8ruZZKeF5hMpMsDXs=;
        b=RBb15A9LhAjqy1l+E94eY3B61c3MRemIiBubOrFkwitCkW0pKPkQMWqW/xL02oSOUP
         +QnJYvITZ2olPk3tcPo4LUVmsLRAjD9N1RFIsVcxMuS8nOnCo4ywqDcsAJh24YxBz94M
         2KSk5XiytD7vbtcSjUpcAsU3aAKo53hs+U1m1H8gHDJKdh96nKZ76sxZfZtEZTzrwb1a
         lNKgKd2nc5ckqgTcibEouzyHyEYvIGOcTZZhOYia6H8tDaQih3P9uzuFKz3BA9NwxbzC
         Zxi1+V/IGFqtwQEyVLRNq7EtDmBOWM9go4RA9uKFbgX5uSTl5NnB4rwcxAnnVFsXO17/
         N1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519303; x=1774124103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5cgfXJCeRN9gp7HY5pu2xM6oON8ruZZKeF5hMpMsDXs=;
        b=UEkFO3gWtmDlGeXOfQFqH0+4A41iov1mXI+4r7neag7qTZHAOZ3B54yt3lRenXjr2s
         v83Tl4/xKUxbbSHdeuBSpCVjQsSZncG33neoo7faeem/GgP2qVagC8DVS8cnkTUDaaBM
         22RoUCi/X3jcarOipjuUwhnsZw8Fz1q8SCMGRpdtz/pfkWhxshU1+vytMg8+3vuzJTXh
         pBBZZPrYDjtKz2lYc3Oowa5WSDRUYkDtc13Sf5tNwIQ94CBusWkU6ZI1EePgduZRmh8C
         dhJ2Y1vx5Do+EKOvpYVVBosmreqHrqVq+pCr1jGM38lxPsYxQKujrHiLvDP/NDjZjBWI
         l32w==
X-Forwarded-Encrypted: i=1; AJvYcCWcbHaLX592abjiXdDAMUlpJ+hTWiOmpCAHO6zDwbHQ/OJuqmB2bgj6Wr2lha08fLlOO7rzXVvUCX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUYJFxdgb5+7+ERGDu0+VcE8vQ2Ff8IcmGaHe8QjrLY18LyJP
	53zXK7UvFBCe703SRuXWVWT99xtFlTI/fwChASeBz0MnEj1lCASvyQkv
X-Gm-Gg: ATEYQzyCamY5v5YUSFjaWhmo8AiAETDxMisFo3FuD/NDm9XuJq7HPqyzFAr5SymFgZQ
	w8TkD17bWQffluiDjXJYjPVEcvMVPSp/zyuVMXMfy04O526FB6SyMv5hcMh6sJ4KlXyboDjInBI
	Ayj1fmHDJuCXyEoyt/0R2Zix51uQNoFqDm9LpmzHHzcMRO3Vj3yqteDAiV22dwToKYvHoGFPNBK
	BHga4l/4VYaszJYAB7T4fQc6cSTo7A7+EcvyomeuRB5CP63GAu+6J9mlqHyNGz6cU+2aEbv4XW3
	miOcaL0H31eGyumalMbGN84oEtM1Xs9/ZL37jrzyB3AlxqJbTFEunCfyvFLctNh76FllLsTzq5w
	LfgUXa8XZuFxDoH760/KK5BdJsQSeaLUrm4KoAMQsLGXbyrrApG56d6/UDO+xrvnG39gj9LQICU
	Ni8BVwK9mA5HV/yr3njdplvm3sPrkU4xfGj9NutqGLJtOf+Mii8oXU+bWtjIC4hZbymhQqEhJxN
	bvxG90IGktFxNbuBByBpb2E9Px3O5CAac8J9srA
X-Received: by 2002:a05:6870:7d16:b0:417:4bd3:f5f5 with SMTP id 586e51a60fabf-417b93e2407mr4714434fac.37.1773519302604;
        Sat, 14 Mar 2026 13:15:02 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:15:02 -0700 (PDT)
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
Subject: [PATCH net-next v2 13/14] netdevsim: add peer RX truesize support for selftests
Date: Sat, 14 Mar 2026 14:13:47 -0600
Message-ID: <20260314201348.1786972-14-atwellwea@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5980-lists,linux-api=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[peer-rx-truesize.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8AD028EDD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

Add a debugfs-controlled peer RX truesize knob to netdevsim, inflate the
forwarded skb only on the peer RX side, and cover the resulting socket
memory-accounting behavior with a dedicated selftest.

This keeps the synthetic cost out of the sender-side skb geometry while
giving the selftests a second runtime vehicle for the receive-memory
accounting exercised by the TCP rwnd work.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 drivers/net/netdevsim/netdev.c                | 145 +++++-
 drivers/net/netdevsim/netdevsim.h             |   4 +
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../drivers/net/netdevsim/peer-rx-truesize.sh | 426 ++++++++++++++++++
 4 files changed, 575 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer-rx-truesize.sh

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 5ec028a00c62..22238df79b6a 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -17,8 +17,10 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
@@ -37,6 +39,91 @@ MODULE_IMPORT_NS("NETDEV_INTERNAL");
 
 #define NSIM_RING_SIZE		256
 
+struct nsim_rx_truesize {
+	refcount_t refs;
+	u32 value;
+};
+
+static struct nsim_rx_truesize *
+nsim_rx_truesize_get(struct nsim_rx_truesize *rx_truesize)
+{
+	if (!rx_truesize)
+		return NULL;
+
+	if (!refcount_inc_not_zero(&rx_truesize->refs))
+		return NULL;
+
+	return rx_truesize;
+}
+
+static void nsim_rx_truesize_put(struct nsim_rx_truesize *rx_truesize)
+{
+	if (!rx_truesize)
+		return;
+
+	if (refcount_dec_and_test(&rx_truesize->refs))
+		kfree(rx_truesize);
+}
+
+static ssize_t nsim_rx_truesize_read(struct file *file, char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct nsim_rx_truesize *rx_truesize = file->private_data;
+	char buf[24];
+	int len;
+
+	len = scnprintf(buf, sizeof(buf), "%u\n",
+			READ_ONCE(rx_truesize->value));
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t nsim_rx_truesize_write(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct nsim_rx_truesize *rx_truesize = file->private_data;
+	u32 value;
+	int err;
+
+	err = kstrtou32_from_user(user_buf, count, 0, &value);
+	if (err)
+		return err;
+
+	WRITE_ONCE(rx_truesize->value, value);
+
+	return count;
+}
+
+static int nsim_rx_truesize_open(struct inode *inode, struct file *file)
+{
+	struct nsim_rx_truesize *rx_truesize;
+
+	rx_truesize = nsim_rx_truesize_get(inode->i_private);
+	if (!rx_truesize)
+		return -ENODEV;
+
+	file->private_data = rx_truesize;
+
+	return nonseekable_open(inode, file);
+}
+
+static int nsim_rx_truesize_release(struct inode *inode, struct file *file)
+{
+	nsim_rx_truesize_put(file->private_data);
+
+	return 0;
+}
+
+static const struct file_operations nsim_rx_truesize_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nsim_rx_truesize_open,
+	.read		= nsim_rx_truesize_read,
+	.write		= nsim_rx_truesize_write,
+	.release	= nsim_rx_truesize_release,
+	.llseek		= noop_llseek,
+};
+
 static void nsim_start_peer_tx_queue(struct net_device *dev, struct nsim_rq *rq)
 {
 	struct netdevsim *ns = netdev_priv(dev);
@@ -117,6 +204,28 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 	return nsim_napi_rx(tx_dev, rx_dev, rq, skb);
 }
 
+/* Tests can inflate peer RX skb->truesize to exercise receiver-side TCP
+ * accounting under scaling-ratio drift without perturbing sender-side skb
+ * ownership.
+ */
+static void nsim_rx_update_truesize(struct sk_buff *skb, u32 extra)
+{
+	unsigned int truesize;
+
+	if (!extra)
+		return;
+
+	if (check_add_overflow(skb->truesize, extra, &truesize))
+		truesize = UINT_MAX;
+
+	skb->truesize = truesize;
+}
+
+static u32 nsim_rx_extra_truesize(const struct netdevsim *ns)
+{
+	return READ_ONCE(ns->rx_truesize->value);
+}
+
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
@@ -125,7 +234,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int len = skb->len;
 	struct netdevsim *peer_ns;
 	struct netdev_config *cfg;
+	struct sk_buff *nskb;
 	struct nsim_rq *rq;
+	u32 extra;
 	int rxq;
 	int dr;
 
@@ -160,7 +271,24 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	      cfg->hds_thresh > len)))
 		skb_linearize(skb);
 
+	extra = nsim_rx_extra_truesize(peer_ns);
 	skb_tx_timestamp(skb);
+	if (extra) {
+		/* Clone before inflating truesize so only the peer RX path sees
+		 * the synthetic cost; sender-side skb accounting stays put.
+		 */
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb) {
+			if (psp_ext)
+				__skb_ext_put(psp_ext);
+			goto out_drop_free;
+		}
+
+		consume_skb(skb);
+		skb = nskb;
+		nsim_rx_update_truesize(skb, extra);
+	}
+
 	if (unlikely(nsim_forward_skb(dev, peer_dev,
 				      skb, rq, psp_ext) == NET_RX_DROP))
 		goto out_drop_cnt;
@@ -1121,6 +1249,7 @@ struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
 			      u8 perm_addr[ETH_ALEN])
 {
 	struct net_device *dev;
+	struct nsim_rx_truesize *rx_truesize;
 	struct netdevsim *ns;
 	int err;
 
@@ -1140,6 +1269,13 @@ struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
+	rx_truesize = kzalloc_obj(*rx_truesize);
+	if (!rx_truesize) {
+		err = -ENOMEM;
+		goto err_free_netdev;
+	}
+	refcount_set(&rx_truesize->refs, 1);
+	ns->rx_truesize = rx_truesize;
 	nsim_ethtool_init(ns);
 	if (nsim_dev_port_is_pf(nsim_dev_port))
 		err = nsim_init_netdevsim(ns);
@@ -1153,21 +1289,27 @@ struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
 	ns->qr_dfs = debugfs_create_file("queue_reset", 0200,
 					 nsim_dev_port->ddir, ns,
 					 &nsim_qreset_fops);
+	ns->rx_truesize_dfs = debugfs_create_file("rx_extra_truesize", 0600,
+						  nsim_dev_port->ddir,
+						  ns->rx_truesize,
+						  &nsim_rx_truesize_fops);
 	return ns;
 
 err_free_netdev:
+	nsim_rx_truesize_put(ns->rx_truesize);
 	free_netdev(dev);
 	return ERR_PTR(err);
 }
 
 void nsim_destroy(struct netdevsim *ns)
 {
+	struct nsim_rx_truesize *rx_truesize = ns->rx_truesize;
 	struct net_device *dev = ns->netdev;
 	struct netdevsim *peer;
 
+	debugfs_remove(ns->rx_truesize_dfs);
 	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
-
 	if (ns->nb.notifier_call)
 		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
 						      &ns->nn);
@@ -1198,6 +1340,7 @@ void nsim_destroy(struct netdevsim *ns)
 	}
 
 	free_netdev(dev);
+	nsim_rx_truesize_put(rx_truesize);
 }
 
 bool netdev_is_nsim(struct net_device *dev)
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7505..972ad274060e 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -75,6 +75,8 @@ struct nsim_macsec {
 	u8 nsim_secy_count;
 };
 
+struct nsim_rx_truesize;
+
 struct nsim_ethtool_pauseparam {
 	bool rx;
 	bool tx;
@@ -144,6 +146,8 @@ struct netdevsim {
 	} udp_ports;
 
 	struct page *page;
+	struct nsim_rx_truesize *rx_truesize;
+	struct dentry *rx_truesize_dfs;
 	struct dentry *pp_dfs;
 	struct dentry *qr_dfs;
 
diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index 1a228c5430f5..9e9e48d5913b 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -14,6 +14,7 @@ TEST_PROGS := \
 	macsec-offload.sh \
 	nexthop.sh \
 	peer.sh \
+	peer-rx-truesize.sh \
 	psample.sh \
 	tc-mq-visibility.sh \
 	udp_tunnel_nic.sh \
diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer-rx-truesize.sh b/tools/testing/selftests/drivers/net/netdevsim/peer-rx-truesize.sh
new file mode 100755
index 000000000000..6d1101d20847
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer-rx-truesize.sh
@@ -0,0 +1,426 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+set -euo pipefail
+
+lib_dir=$(dirname "$0")/../../../net
+source "$lib_dir"/lib.sh
+
+NSIM_SRV_ID=$((1024 + RANDOM % 1024))
+NSIM_CLI_ID=$((2048 + RANDOM % 1024))
+NSIM_SYS_LINK=/sys/bus/netdevsim/link_device
+SERVER_ADDR=192.0.2.1
+CLIENT_ADDR=192.0.2.2
+RMEM_PORT=12345
+WARM_PORT=12346
+RMEM_QUEUED_LEN=65000
+RMEM_INFLATED_LEN=65000
+RMEM_SMALL_EXTRA=4096
+RMEM_LARGE_EXTRA=65536
+WARM_WARMUP_ROUNDS=16
+WARM_WARMUP_LEN=65000
+WARM_QUEUED_LEN=62000
+WARM_INFLATED_LEN=65000
+WARM_EXTRA=65536
+
+srv_dev=
+cli_dev=
+srv_pid=
+cli_pid=
+srv_fd=
+cli_fd=
+stage_dir=
+CASE_BASE_METRIC=
+CASE_FINAL_METRIC=
+
+cleanup()
+{
+	local rc=$?
+
+	if [ -n "${srv_pid:-}" ]; then
+		kill "${srv_pid}" 2>/dev/null || true
+		wait "${srv_pid}" 2>/dev/null || true
+	fi
+
+	if [ -n "${cli_pid:-}" ]; then
+		kill "${cli_pid}" 2>/dev/null || true
+		wait "${cli_pid}" 2>/dev/null || true
+	fi
+
+	if [ -n "${srv_fd:-}" ]; then
+		eval "exec ${srv_fd}<&-"
+	fi
+
+	if [ -n "${cli_fd:-}" ]; then
+		eval "exec ${cli_fd}<&-"
+	fi
+
+	if [ -d "${stage_dir:-}" ]; then
+		rm -rf "${stage_dir}"
+	fi
+
+	cleanup_netdevsim "${NSIM_SRV_ID}" 2>/dev/null || true
+	cleanup_netdevsim "${NSIM_CLI_ID}" 2>/dev/null || true
+	cleanup_ns "${SRV:-}" "${CLI:-}" 2>/dev/null || true
+
+	exit "${rc}"
+}
+
+trap cleanup EXIT
+
+ensure_debugfs()
+{
+	if mount | grep -q 'on /sys/kernel/debug type debugfs'; then
+		return 0
+	fi
+
+	if ! mount -t debugfs none /sys/kernel/debug >/dev/null 2>&1; then
+		echo "SKIP: failed to mount debugfs"
+		exit "${ksft_skip}"
+	fi
+}
+
+ensure_netdevsim()
+{
+	if [ -w /sys/bus/netdevsim/new_device ]; then
+		return 0
+	fi
+
+	if ! modprobe netdevsim >/dev/null 2>&1; then
+		echo "SKIP: no netdevsim support"
+		exit "${ksft_skip}"
+	fi
+}
+
+create_nsim()
+{
+	local id="$1"
+	local ns="$2"
+	local addr="$3"
+	local dev
+
+	echo "${id}" | ip netns exec "${ns}" tee /sys/bus/netdevsim/new_device >/dev/null
+	udevadm settle
+
+	dev=$(ip netns exec "${ns}" ls /sys/bus/netdevsim/devices/netdevsim"${id}"/net)
+	ip -netns "${ns}" link set dev "${dev}" name "nsim${id}"
+	ip -netns "${ns}" addr add "${addr}/24" dev "nsim${id}"
+	ip -netns "${ns}" link set dev "nsim${id}" up
+
+	echo "nsim${id}"
+}
+
+link_nsim_peers()
+{
+	local srv_ifindex
+	local cli_ifindex
+
+	eval "exec {srv_fd}</var/run/netns/${SRV}"
+	eval "exec {cli_fd}</var/run/netns/${CLI}"
+
+	srv_ifindex=$(ip netns exec "${SRV}" cat /sys/class/net/"${srv_dev}"/ifindex)
+	cli_ifindex=$(ip netns exec "${CLI}" cat /sys/class/net/"${cli_dev}"/ifindex)
+
+	echo "${srv_fd}:${srv_ifindex} ${cli_fd}:${cli_ifindex}" > "${NSIM_SYS_LINK}"
+}
+
+wait_for_file()
+{
+	local path="$1"
+	local i
+
+	for i in $(seq 100); do
+		if [ -e "${path}" ]; then
+			return 0
+		fi
+		sleep 0.1
+	done
+
+	return 1
+}
+
+server_python='
+import array
+import fcntl
+import os
+import socket
+import struct
+import sys
+import time
+
+SO_MEMINFO = 55
+SK_MEMINFO_RMEM_ALLOC = 0
+TCP_MAXSEG = getattr(socket, "TCP_MAXSEG", 2)
+FIONREAD = 0x541B
+POLL_INTERVAL = 0.01
+POLL_TIMEOUT = 20.0
+
+(mode, host, port, warmup_rounds, warmup_len, queued_len, inflated_len,
+ ready_file, result_file) = sys.argv[1:]
+port = int(port)
+warmup_rounds = int(warmup_rounds)
+warmup_len = int(warmup_len)
+queued_len = int(queued_len)
+inflated_len = int(inflated_len)
+
+def queued_bytes(sock):
+    buf = array.array("I", [0])
+    fcntl.ioctl(sock.fileno(), FIONREAD, buf, True)
+    return buf[0]
+
+def wait_for_queued(sock, target):
+    deadline = time.time() + POLL_TIMEOUT
+    while time.time() < deadline:
+        if queued_bytes(sock) >= target:
+            return
+        time.sleep(POLL_INTERVAL)
+    raise SystemExit(f"timed out waiting for {target} queued bytes")
+
+def meminfo(sock):
+    raw = sock.getsockopt(socket.SOL_SOCKET, SO_MEMINFO, 9 * 4)
+    return struct.unpack("=9I", raw)
+
+def wait_for_growth(sock, idx, base):
+    deadline = time.time() + POLL_TIMEOUT
+    while time.time() < deadline:
+        cur = meminfo(sock)[idx]
+        if cur > base:
+            return cur
+        time.sleep(POLL_INTERVAL)
+    raise SystemExit(f"timed out waiting for SO_MEMINFO[{idx}] growth from {base}")
+
+def write_metric(path, value):
+    with open(path, "w", encoding="ascii") as fp:
+        fp.write(f"{value}\n")
+
+def recv_all(sock, total):
+    remaining = total
+    while remaining:
+        chunk = sock.recv(min(65536, remaining))
+        if not chunk:
+            raise SystemExit("unexpected EOF while draining receive data")
+        remaining -= len(chunk)
+
+listener = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+listener.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
+listener.setsockopt(socket.IPPROTO_TCP, TCP_MAXSEG, 1000)
+listener.bind((host, port))
+listener.listen(1)
+conn, _ = listener.accept()
+
+for _ in range(warmup_rounds):
+    recv_all(conn, warmup_len)
+
+if mode == "rmem_alloc":
+    wait_for_queued(conn, queued_len)
+    base_metric = meminfo(conn)[SK_MEMINFO_RMEM_ALLOC]
+    write_metric(ready_file, base_metric)
+
+    recv_all(conn, queued_len)
+    wait_for_queued(conn, inflated_len)
+    grown_metric = meminfo(conn)[SK_MEMINFO_RMEM_ALLOC]
+    write_metric(result_file, grown_metric)
+elif mode == "rmem_alloc_warm":
+    wait_for_queued(conn, queued_len)
+    base_metric = meminfo(conn)[SK_MEMINFO_RMEM_ALLOC]
+    write_metric(ready_file, base_metric)
+
+    wait_for_queued(conn, queued_len + 1)
+    grown_metric = wait_for_growth(conn, SK_MEMINFO_RMEM_ALLOC, base_metric)
+    write_metric(result_file, grown_metric)
+elif mode == "rmem_alloc_growth":
+    # The growth cases compare against a live socket metric, so wait for
+    # observed growth instead of trusting one instantaneous post-queue sample.
+    wait_for_queued(conn, queued_len)
+    base_metric = meminfo(conn)[SK_MEMINFO_RMEM_ALLOC]
+    write_metric(ready_file, base_metric)
+
+    recv_all(conn, queued_len)
+    wait_for_queued(conn, inflated_len)
+    grown_metric = wait_for_growth(conn, SK_MEMINFO_RMEM_ALLOC, base_metric)
+    write_metric(result_file, grown_metric)
+else:
+    raise SystemExit(f"unknown mode: {mode}")
+'
+
+client_python='
+import os
+import socket
+import sys
+import time
+
+POLL_INTERVAL = 0.01
+POLL_TIMEOUT = 20.0
+
+host, port, warmup_rounds, warmup_len, queued_len, inflated_len, gate_file = sys.argv[1:]
+port = int(port)
+warmup_rounds = int(warmup_rounds)
+warmup_len = int(warmup_len)
+queued_len = int(queued_len)
+inflated_len = int(inflated_len)
+
+def send_all(sock, total):
+    payload = b"a" * min(total, 65536)
+    left = total
+    while left:
+        chunk = payload[: min(len(payload), left)]
+        sent = sock.send(chunk)
+        if sent <= 0:
+            raise SystemExit("short send")
+        left -= sent
+
+def wait_for_file(path):
+    deadline = time.time() + POLL_TIMEOUT
+    while time.time() < deadline:
+        if os.path.exists(path):
+            return
+        time.sleep(POLL_INTERVAL)
+    raise SystemExit(f"timed out waiting for {path}")
+
+cli = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+cli.setsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG, 1000)
+cli.connect((host, port))
+for _ in range(warmup_rounds):
+    send_all(cli, warmup_len)
+send_all(cli, queued_len)
+wait_for_file(gate_file)
+send_all(cli, inflated_len)
+cli.close()
+'
+
+read_metric()
+{
+	local path="$1"
+	local value
+
+	if ! read -r value < "${path}"; then
+		echo "FAIL: unable to read metric from ${path}"
+		exit "${ksft_fail}"
+	fi
+
+	printf '%s\n' "${value}"
+}
+
+run_case()
+{
+	local case_id="$1"
+	local mode="$2"
+	local port="$3"
+	local warmups="$4"
+	local warmup_len="$5"
+	local queued_len="$6"
+	local inflated_len="$7"
+	local extra="$8"
+	local label="$9"
+	local ready_file="${stage_dir}/${case_id}.ready"
+	local result_file="${stage_dir}/${case_id}.result"
+	local gate_file="${stage_dir}/${case_id}.gate"
+
+	rm -f "${ready_file}" "${result_file}" "${gate_file}"
+	echo 0 > "${dfs_file}"
+
+	ip netns exec "${SRV}" python3 - "${mode}" "${SERVER_ADDR}" "${port}" \
+		"${warmups}" "${warmup_len}" "${queued_len}" "${inflated_len}" \
+		"${ready_file}" "${result_file}" <<PY &
+${server_python}
+PY
+	srv_pid=$!
+
+	wait_local_port_listen "${SRV}" "${port}" tcp
+
+	ip netns exec "${CLI}" python3 - "${SERVER_ADDR}" "${port}" \
+		"${warmups}" "${warmup_len}" "${queued_len}" "${inflated_len}" \
+		"${gate_file}" <<PY &
+${client_python}
+PY
+	cli_pid=$!
+
+	if ! wait_for_file "${ready_file}"; then
+		echo "FAIL: ${label}: ready marker did not appear"
+		exit "${ksft_fail}"
+	fi
+
+	echo "${extra}" > "${dfs_file}"
+	touch "${gate_file}"
+
+	wait "${cli_pid}"
+	cli_pid=
+	wait "${srv_pid}"
+	srv_pid=
+
+	CASE_BASE_METRIC=$(read_metric "${ready_file}")
+	CASE_FINAL_METRIC=$(read_metric "${result_file}")
+
+	echo "PASS: ${label}"
+}
+
+# This test only proves that injected truesize reaches socket memory
+# accounting. Packetdrill covers the sender-visible rwnd accept/drop logic.
+
+assert_no_growth()
+{
+	local label="$1"
+
+	if [ "${CASE_FINAL_METRIC}" -gt "${CASE_BASE_METRIC}" ]; then
+		echo "FAIL: ${label}: metric grew unexpectedly:" \
+		     "base=${CASE_BASE_METRIC}" \
+		     "after=${CASE_FINAL_METRIC}"
+		exit "${ksft_fail}"
+	fi
+}
+
+assert_growth()
+{
+	local label="$1"
+
+	if [ "${CASE_FINAL_METRIC}" -le "${CASE_BASE_METRIC}" ]; then
+		echo "FAIL: ${label}: metric did not grow:" \
+		     "base=${CASE_BASE_METRIC}" \
+		     "after=${CASE_FINAL_METRIC}"
+		exit "${ksft_fail}"
+	fi
+}
+
+ensure_debugfs
+ensure_netdevsim
+set +u
+setup_ns SRV CLI
+set -u
+
+srv_dev=$(create_nsim "${NSIM_SRV_ID}" "${SRV}" "${SERVER_ADDR}")
+cli_dev=$(create_nsim "${NSIM_CLI_ID}" "${CLI}" "${CLIENT_ADDR}")
+link_nsim_peers
+
+ip netns exec "${SRV}" sysctl -wq net.ipv4.tcp_moderate_rcvbuf=0
+
+stage_dir=$(mktemp -d)
+dfs_file="/sys/kernel/debug/netdevsim/netdevsim${NSIM_SRV_ID}/ports/0/rx_extra_truesize"
+
+run_case "rmem_noop" "rmem_alloc" "${RMEM_PORT}" 0 0 \
+	"${RMEM_QUEUED_LEN}" "${RMEM_INFLATED_LEN}" 0 \
+	"peer rx truesize zero no-op"
+assert_no_growth "peer rx truesize zero no-op"
+
+run_case "rmem_small" "rmem_alloc_growth" "${RMEM_PORT}" 0 0 \
+	"${RMEM_QUEUED_LEN}" "${RMEM_INFLATED_LEN}" "${RMEM_SMALL_EXTRA}" \
+	"peer rx truesize small rmem_alloc"
+assert_growth "peer rx truesize small rmem_alloc"
+small_delta=$((CASE_FINAL_METRIC - CASE_BASE_METRIC))
+
+run_case "rmem_large" "rmem_alloc_growth" "${RMEM_PORT}" 0 0 \
+	"${RMEM_QUEUED_LEN}" "${RMEM_INFLATED_LEN}" "${RMEM_LARGE_EXTRA}" \
+	"peer rx truesize large rmem_alloc"
+assert_growth "peer rx truesize large rmem_alloc"
+large_delta=$((CASE_FINAL_METRIC - CASE_BASE_METRIC))
+
+if [ "${large_delta}" -le "${small_delta}" ]; then
+	echo "FAIL: peer rx truesize stepped rmem_alloc:" \
+	     "small_delta=${small_delta}" \
+	     "large_delta=${large_delta}"
+	exit "${ksft_fail}"
+fi
+
+run_case "rmem_warm" "rmem_alloc_warm" "${WARM_PORT}" "${WARM_WARMUP_ROUNDS}" "${WARM_WARMUP_LEN}" \
+	"${WARM_QUEUED_LEN}" "${WARM_INFLATED_LEN}" "${WARM_EXTRA}" \
+	"peer rx truesize warm rmem_alloc"
+assert_growth "peer rx truesize warm rmem_alloc"
-- 
2.43.0


