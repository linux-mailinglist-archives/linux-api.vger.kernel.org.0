Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E5C226C99
	for <lists+linux-api@lfdr.de>; Mon, 20 Jul 2020 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbgGTQ6Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jul 2020 12:58:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40026 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbgGTQ6M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Jul 2020 12:58:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06KGw6BI027183;
        Mon, 20 Jul 2020 11:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595264286;
        bh=1RwmlEeamb14FvVTIhkiuYRUKf43yl4jbd7KeTldcS4=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=F4DRyBrsi4DHKuo1LRfYd6W1dr5e6x35UUBpwtf0bkMFVO1M+pMd5hVmrXlhJ5P0r
         zEpYSWCJAU8FaNq2K821Z0FmqzfjtJnxxnYE2bvYlIuB9XGnltU5DqQlpaoI8jJObK
         IFgxaaE16/2i9zNfhQp/l4Uy27Q15J1ODw7QNGaM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06KGw6kc005346
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 11:58:06 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 20
 Jul 2020 11:58:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 20 Jul 2020 11:58:06 -0500
Received: from uda0868495.fios-router.home (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KGw3B7041101;
        Mon, 20 Jul 2020 11:58:05 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <nsekhar@ti.com>, <grygorii.strashko@ti.com>,
        <vinicius.gomes@intel.com>
Subject: [net-next v4 PATCH 4/7] net: prp: add supervision frame generation utility function
Date:   Mon, 20 Jul 2020 12:58:00 -0400
Message-ID: <20200720165803.17793-5-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720165803.17793-1-m-karicheri2@ti.com>
References: <20200720165803.17793-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add support for generation of PRP supervision frames. For PRP,
supervision frame format is similar to HSR version 0, but have
a PRP Redundancy Control Trailer (RCT) added and uses a different
message type, PRP_TLV_LIFE_CHECK_DD. Also update
is_supervision_frame() to include the new message type used for
PRP supervision frame.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_device.c  | 64 ++++++++++++++++++++++++++++++++++++++++++-
 net/hsr/hsr_forward.c |  4 ++-
 net/hsr/hsr_main.h    | 22 +++++++++++++++
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 006e715eccb6..74eaf28743a4 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -238,6 +238,10 @@ static struct sk_buff *hsr_init_skb(struct hsr_port *master, u16 proto)
 
 	hlen = LL_RESERVED_SPACE(master->dev);
 	tlen = master->dev->needed_tailroom;
+	/* skb size is same for PRP/HSR frames, only difference
+	 * being, for PRP it is a trailer and for HSR it is a
+	 * header
+	 */
 	skb = dev_alloc_skb(sizeof(struct hsr_tag) +
 			    sizeof(struct hsr_sup_tag) +
 			    sizeof(struct hsr_sup_payload) + hlen + tlen);
@@ -336,6 +340,55 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	return;
 }
 
+static void send_prp_supervision_frame(struct hsr_port *master,
+				       unsigned long *interval)
+{
+	struct hsr_priv *hsr = master->hsr;
+	struct hsr_sup_payload *hsr_sp;
+	struct hsr_sup_tag *hsr_stag;
+	unsigned long irqflags;
+	struct sk_buff *skb;
+	struct prp_rct *rct;
+	u8 *tail;
+
+	skb = hsr_init_skb(master, ETH_P_PRP);
+	if (!skb) {
+		WARN_ONCE(1, "PRP: Could not send supervision frame\n");
+		return;
+	}
+
+	*interval = msecs_to_jiffies(HSR_LIFE_CHECK_INTERVAL);
+	hsr_stag = skb_put(skb, sizeof(struct hsr_sup_tag));
+	set_hsr_stag_path(hsr_stag, (hsr->prot_version ? 0x0 : 0xf));
+	set_hsr_stag_HSR_ver(hsr_stag, (hsr->prot_version ? 1 : 0));
+
+	/* From HSRv1 on we have separate supervision sequence numbers. */
+	spin_lock_irqsave(&master->hsr->seqnr_lock, irqflags);
+	hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
+	hsr->sup_sequence_nr++;
+	hsr_stag->HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
+	hsr_stag->HSR_TLV_length = sizeof(struct hsr_sup_payload);
+
+	/* Payload: MacAddressA */
+	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
+	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
+
+	if (skb_put_padto(skb, ETH_ZLEN + HSR_HLEN)) {
+		spin_unlock_irqrestore(&master->hsr->seqnr_lock, irqflags);
+		return;
+	}
+
+	tail = skb_tail_pointer(skb) - HSR_HLEN;
+	rct = (struct prp_rct *)tail;
+	rct->PRP_suffix = htons(ETH_P_PRP);
+	set_prp_LSDU_size(rct, HSR_V1_SUP_LSDUSIZE);
+	rct->sequence_nr = htons(hsr->sequence_nr);
+	hsr->sequence_nr++;
+	spin_unlock_irqrestore(&master->hsr->seqnr_lock, irqflags);
+
+	hsr_forward_skb(skb, master);
+}
+
 /* Announce (supervision frame) timer function
  */
 static void hsr_announce(struct timer_list *t)
@@ -389,6 +442,10 @@ static struct hsr_proto_ops hsr_ops = {
 	.send_sv_frame = send_hsr_supervision_frame,
 };
 
+struct hsr_proto_ops prp_ops = {
+	.send_sv_frame = send_prp_supervision_frame,
+};
+
 void hsr_dev_setup(struct net_device *dev)
 {
 	eth_hw_addr_random(dev);
@@ -452,7 +509,12 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	if (protocol_version == PRP_V1)
 		return -EPROTONOSUPPORT;
 
-	hsr->proto_ops = &hsr_ops;
+	/* initialize protocol specific functions */
+	if (protocol_version == PRP_V1)
+		hsr->proto_ops = &prp_ops;
+	else
+		hsr->proto_ops = &hsr_ops;
+
 	/* Make sure we recognize frames from ourselves in hsr_rcv() */
 	res = hsr_create_self_node(hsr, hsr_dev->dev_addr,
 				   slave[1]->dev_addr);
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 2f29ebc85eda..7ce5fc8e4a5e 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -76,7 +76,9 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	}
 
 	if (hsr_sup_tag->HSR_TLV_type != HSR_TLV_ANNOUNCE &&
-	    hsr_sup_tag->HSR_TLV_type != HSR_TLV_LIFE_CHECK)
+	    hsr_sup_tag->HSR_TLV_type != HSR_TLV_LIFE_CHECK &&
+	    hsr_sup_tag->HSR_TLV_type != PRP_TLV_LIFE_CHECK_DD &&
+	    hsr_sup_tag->HSR_TLV_type != PRP_TLV_LIFE_CHECK_DA)
 		return false;
 	if (hsr_sup_tag->HSR_TLV_length != 12 &&
 	    hsr_sup_tag->HSR_TLV_length != sizeof(struct hsr_sup_payload))
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 671270115a50..58e1ad21b66f 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -35,6 +35,10 @@
 
 #define HSR_TLV_ANNOUNCE		   22
 #define HSR_TLV_LIFE_CHECK		   23
+/* PRP V1 life check for Duplicate discard */
+#define PRP_TLV_LIFE_CHECK_DD		   20
+/* PRP V1 life check for Duplicate Accept */
+#define PRP_TLV_LIFE_CHECK_DA		   21
 
 /* HSR Tag.
  * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype = 0x88FB,
@@ -126,6 +130,24 @@ enum hsr_port_type {
 	HSR_PT_PORTS,	/* This must be the last item in the enum */
 };
 
+/* PRP Redunancy Control Trailor (RCT).
+ * As defined in IEC-62439-4:2012, the PRP RCT is really { sequence Nr,
+ * Lan indentifier (LanId), LSDU_size and PRP_suffix = 0x88FB }.
+ *
+ * Field names as defined in the IEC:2012 standard for PRP.
+ */
+struct prp_rct {
+	__be16          sequence_nr;
+	__be16          lan_id_and_LSDU_size;
+	__be16          PRP_suffix;
+} __packed;
+
+static inline void set_prp_LSDU_size(struct prp_rct *rct, u16 LSDU_size)
+{
+	rct->lan_id_and_LSDU_size = htons((ntohs(rct->lan_id_and_LSDU_size) &
+					  0xF000) | (LSDU_size & 0x0FFF));
+}
+
 struct hsr_port {
 	struct list_head	port_list;
 	struct net_device	*dev;
-- 
2.17.1

