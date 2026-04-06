Return-Path: <linux-api+bounces-6063-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id N9tRLDjo02lqnwcAu9opvQ
	(envelope-from <linux-api+bounces-6063-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 06 Apr 2026 19:07:04 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7263A5915
	for <lists+linux-api@lfdr.de>; Mon, 06 Apr 2026 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 800363004F74
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2026 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192CD38CFFE;
	Mon,  6 Apr 2026 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="BdXgaili"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-m83129.xmail.ntesmail.com (mail-m83129.xmail.ntesmail.com [156.224.83.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5E27702D;
	Mon,  6 Apr 2026 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.83.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495222; cv=none; b=MqZOVIlYyG0xl5AgpCtmayfqGf45tLkCc47NDsoeysPWN7FcY3jTs+Km5187++TV5NAXwZILA5RyxHQdOVdudqU7UNIjwLn3ckVPBEnrdTTU6fqspU9QZ/7u+Fb7ZDAYqGRxufESo7GlVlkjILLdDJRim6qmEU/LgtZF+iilYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495222; c=relaxed/simple;
	bh=MyruzAKe4PZJ1OY6Kp5WYJMBUmMjeBtf1hWfM9tLod4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJi5TdKxzW1OfLj8HvSX8wXl0MAEwEZ3IbbdRiFJnRKWFhtZtEsZXWHtQzI0m7jnNX7cEOscpBzbqAMxjRN24qJwcGXfoW6VJLCAJxG6vENTAEp5sdtZ8+mPMZkkuyaEc2BFps/Y5TrEA+WSeGKc/yE8xNAYV7C96fwL5msPPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=BdXgaili; arc=none smtp.client-ip=156.224.83.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39aaefbdc;
	Tue, 7 Apr 2026 00:51:30 +0800 (GMT+08:00)
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
Subject: [RFC PATCH v3 2/6] rust: bindings: expose goldfish address-space headers
Date: Mon,  6 Apr 2026 12:51:16 -0400
Message-Id: <20260406165120.166928-3-wenzhaoliao@ruc.edu.cn>
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
X-HM-Tid: 0a9d63b4daed03a2kunm562d3b0d647e6e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaShpDVh5KHkpMT0JDQkxLSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BdXgailiNrsn8yC/dq8FY+M6JpXPpASFyXieM45D3hWn/cPVgh/uT2aYXrDL2PHSKx40AcROqNuhlFH7gWL1XsKcz2Unl1hh93gnRVceR384iXFdFyPno6MhLwTtGadoCSjrrLlZtlYZ7WCFPMJf4eJ9FrlDRPiZL1gavm9Ncn4=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=X16YJLGp7nPhHrC8mDgnpZbzv+DRjBcKHLYYvHcfrz0=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6063-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0C7263A5915
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose the UAPI header and the Linux I/O declarations needed by the Rust goldfish address-space driver.

This keeps the driver-side code on typed Rust interfaces while still allowing the binding and helper layers to see the header and memremap support required by the abstraction patches that follow.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/bindings/bindings_helper.h | 1 +
 rust/uapi/uapi_helper.h         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 083cc44aa952..b0baff4c6349 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -59,6 +59,7 @@
 #include <linux/fs.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/io-pgtable.h>
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 06d7d1a2e8da..ff19edab81da 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -11,6 +11,7 @@
 #include <uapi/drm/nova_drm.h>
 #include <uapi/drm/panthor_drm.h>
 #include <uapi/linux/android/binder.h>
+#include <uapi/linux/goldfish_address_space.h>
 #include <uapi/linux/mdio.h>
 #include <uapi/linux/mii.h>
 #include <uapi/linux/ethtool.h>
-- 
2.34.1


