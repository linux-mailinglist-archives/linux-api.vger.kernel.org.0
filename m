Return-Path: <linux-api+bounces-6060-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ruO+Lafk02kFnwcAu9opvQ
	(envelope-from <linux-api+bounces-6060-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 06 Apr 2026 18:51:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2B3A572A
	for <lists+linux-api@lfdr.de>; Mon, 06 Apr 2026 18:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B109300938D
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2026 16:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C071C386C2C;
	Mon,  6 Apr 2026 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="mr0jnYGJ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-m128214.netease.com (mail-m128214.netease.com [103.209.128.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA035F5E9;
	Mon,  6 Apr 2026 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494303; cv=none; b=e81+kLR9+Tkxby+5D0LgP4dfNdtUA2rDG/0W7SVEiGD6xVAtQlUlNxpASYVhX9HvIsd8h7e1IGKH67asIqgH8Ed6YPA4z1FUUMo7jm9MxDWG9J8Ve/HjRaQXmnUD9VR0eR4l4q5qryBrEzm/GAIoa5q3fB29dCiQCHjGV7a06s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494303; c=relaxed/simple;
	bh=JGV9wifkkNiF1MU+26HGbW/+ymbUBkjqNWmmDG9ejug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bW/3SXJtPHfhCsVNaiUrsoMTPHSaDUGVXBv6CTjHb8YpvoiJYN/1d2zCREFlza3cWqnXd1Tto4+s0JjpoGcBthDATUnEK4L1jLoWKuLqph3dLYHeRgtmFTBov6xXHJUVzQvHxUI39fh3z4aKuIs0/a5IDn2ohLi62+GQI4KfDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=mr0jnYGJ; arc=none smtp.client-ip=103.209.128.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39aaefbdb;
	Tue, 7 Apr 2026 00:51:25 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: ojeda@kernel.org,
	dakr@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [RFC PATCH v3 1/6] uapi: add goldfish_address_space userspace ABI header
Date: Mon,  6 Apr 2026 12:51:15 -0400
Message-Id: <20260406165120.166928-2-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406165120.166928-1-wenzhaoliao@ruc.edu.cn>
References: <cover.1775456181.git.wenzhaoliao@ruc.edu.cn>
 <20260406165120.166928-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d63b4ca8003a2kunm562d3b0d647e63
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkgYVhoeS0pCQkJOS0geTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=mr0jnYGJNn7jdQdmGx9snQukeD3Qle86rk2rjHNwRxzlq3z1QnTC5xPCsUs6ScNU2TzPr+pLNsIN/bPqVMJ0aW6R6lYp4m4VrAAZ/g1m48og8sJJnNcg94vYyd1Z9om1QI14x9/viFF0QyRbedvCJWQVQO79LFtSyIGorAbn7L0=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=2PkcM2WRjNh0KqsyA+Q2Us0R9IhzckDTKUqyovFSI74=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6060-lists,linux-api=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ruc.edu.cn:dkim,ruc.edu.cn:email,ruc.edu.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7D2B3A572A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The external goldfish address-space driver exposes its userspace
contract through a dedicated header. Land the ioctl definitions in
include/uapi/linux so the Rust driver can depend on an in-tree UAPI
surface instead of carrying an external private header.

This RFC intentionally narrows the first upstream step to the
open/release/ioctl ABI subset. Userspace mmap and PING_WITH_DATA stay
out of this series until they have their own review and validation
story.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 MAINTAINERS                                 |  8 +++
 include/uapi/linux/goldfish_address_space.h | 54 +++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 include/uapi/linux/goldfish_address_space.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a62f6af55c3a..800b2fe0e648 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1882,6 +1882,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.yaml
 F:	drivers/irqchip/irq-goldfish-pic.c
 
+ANDROID GOLDFISH ADDRESS SPACE DRIVER
+M:	Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
+L:	linux-kernel@vger.kernel.org
+L:	linux-pci@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	include/uapi/linux/goldfish_address_space.h
+
 ANDROID GOLDFISH RTC DRIVER
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
 S:	Supported
diff --git a/include/uapi/linux/goldfish_address_space.h b/include/uapi/linux/goldfish_address_space.h
new file mode 100644
index 000000000000..b782d82f53df
--- /dev/null
+++ b/include/uapi/linux/goldfish_address_space.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _UAPI_LINUX_GOLDFISH_ADDRESS_SPACE_H
+#define _UAPI_LINUX_GOLDFISH_ADDRESS_SPACE_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define GOLDFISH_ADDRESS_SPACE_DEVICE_NAME "goldfish_address_space"
+
+struct goldfish_address_space_allocate_block {
+	__u64 size;
+	__u64 offset;
+	__u64 phys_addr;
+};
+
+struct goldfish_address_space_ping {
+	__u64 offset;
+	__u64 size;
+	__u64 metadata;
+	__u32 version;
+	__u32 wait_fd;
+	__u32 wait_flags;
+	__u32 direction;
+};
+
+struct goldfish_address_space_claim_shared {
+	__u64 offset;
+	__u64 size;
+};
+
+#define GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC 'G'
+
+#define GOLDFISH_ADDRESS_SPACE_IOCTL_OP(OP, T) \
+	_IOWR(GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC, OP, T)
+
+#define GOLDFISH_ADDRESS_SPACE_IOCTL_ALLOCATE_BLOCK \
+	GOLDFISH_ADDRESS_SPACE_IOCTL_OP(10, \
+		struct goldfish_address_space_allocate_block)
+
+#define GOLDFISH_ADDRESS_SPACE_IOCTL_DEALLOCATE_BLOCK \
+	GOLDFISH_ADDRESS_SPACE_IOCTL_OP(11, __u64)
+
+#define GOLDFISH_ADDRESS_SPACE_IOCTL_PING \
+	GOLDFISH_ADDRESS_SPACE_IOCTL_OP(12, \
+		struct goldfish_address_space_ping)
+
+#define GOLDFISH_ADDRESS_SPACE_IOCTL_CLAIM_SHARED \
+	GOLDFISH_ADDRESS_SPACE_IOCTL_OP(13, \
+		struct goldfish_address_space_claim_shared)
+
+#define GOLDFISH_ADDRESS_SPACE_IOCTL_UNCLAIM_SHARED \
+	GOLDFISH_ADDRESS_SPACE_IOCTL_OP(14, __u64)
+
+#endif /* _UAPI_LINUX_GOLDFISH_ADDRESS_SPACE_H */
-- 
2.34.1


