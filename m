Return-Path: <linux-api+bounces-2707-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A21B9C49E9
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 00:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F66B2B437
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2024 23:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CB51C8FD3;
	Mon, 11 Nov 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="PS1NNn6T"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD901C876F
	for <linux-api@vger.kernel.org>; Mon, 11 Nov 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368462; cv=none; b=Qxx4RICz50q7NZKnN0HntaxIvtnt+L6Kdbb8u3CpLKRtXElk665sh/iCBeOT5ssQS35O19HPBgWyaH9mJnx7k4eAICxpVGu41YASN+I583SbIiCqGDyuOVD5FYkDOnzznefzd8Fs0W2BNZchOYUmKLCbPq6u/P8MOqphJLzuUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368462; c=relaxed/simple;
	bh=Gn7khNU2u5xYeSP0C456MvmT1bsHO8drBcblpdqFoL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy+8+A3N1znzQpC1oQDKPz4iLtxiVkXPMF2dxlVJf1rwLB7WCe/JACSQvlvSdlRVglvyvIwxd80TifW9kbjw4X0cRN1W1ZURnEBgM4hs12Te9zm2JWIkrAzrd6j0v1Kd4O9BvR6IEJb1GxE8UVrGHF2aO/4kxshFaUGeFvaWX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=PS1NNn6T; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fMexW2pDdBCFxriCy/VerA2cOBlMw5Jwtysz6bjLElw=; t=1731368460; x=1732232460; 
	b=PS1NNn6TQco4eVLeYmtcEN1dlq1mBLvfm6s8Xl2zorW533PV6Iz8THOn9J7Hq+gPtWtk5T0QAhj
	h2MC5+pDziOn7qxBlzjsJqZf+TvIJuqjEb803yLjtllyqhoUh+kdgi3pfW6VN4lGHiW5ViR1uzbhz
	/y7Bupmtsl2HWvTLGygmEegbU9gVijzB9deQFLHspmhIdvEqJOdEEg5/ZydYxfsA5L0jm/BFEh1dc
	QZqLaFwfcfOLlTyFSpf58ON1wpXthZBdbpM/gfRPFHpuHolE0pHrgtAFHdCjMuT9u3p8GYuuMX5B9
	4OGK+slgnl3MXyxib6wEPu7espeXrHcrYwQw==;
Received: from ouster448.stanford.edu ([172.24.72.71]:54467 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tAe1j-0002NP-DP; Mon, 11 Nov 2024 15:41:00 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
Date: Mon, 11 Nov 2024 15:40:05 -0800
Message-ID: <20241111234006.5942-13-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241111234006.5942-1-ouster@cs.stanford.edu>
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: f3ece08579cbcd970dc3d33c6519ba8c

Before this commit the Homa code is "inert": it won't be compiled
in kernel builds. This commit adds Homa's Makefile and Kconfig, and
also links Homa into net/Makefile and net/Kconfig, so that Homa
will be built during kernel builds if enabled (it is disabled by
default).

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 MAINTAINERS       |  7 +++++++
 net/Kconfig       |  1 +
 net/Makefile      |  1 +
 net/homa/Kconfig  | 19 +++++++++++++++++++
 net/homa/Makefile | 14 ++++++++++++++
 5 files changed, 42 insertions(+)
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 1389704c7d8d..935d1e995018 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10391,6 +10391,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HOMA TRANSPORT PROTOCOL
+M:	John Ousterhout <ouster@cs.stanford.edu>
+S:	Maintained
+W:	https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
+F:	include/uapi/linux/homa.h
+F:	net/homa/
+
 HONEYWELL HSC030PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Petre Rodan <petre.rodan@subdimension.ro>
 L:	linux-iio@vger.kernel.org
diff --git a/net/Kconfig b/net/Kconfig
index a629f92dc86b..ca8551c1a226 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -244,6 +244,7 @@ endif
 
 source "net/dccp/Kconfig"
 source "net/sctp/Kconfig"
+source "net/homa/Kconfig"
 source "net/rds/Kconfig"
 source "net/tipc/Kconfig"
 source "net/atm/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index 65bb8c72a35e..18fa3c323187 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -44,6 +44,7 @@ obj-y				+= 8021q/
 endif
 obj-$(CONFIG_IP_DCCP)		+= dccp/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
+obj-$(CONFIG_HOMA)              += homa/
 obj-$(CONFIG_RDS)		+= rds/
 obj-$(CONFIG_WIRELESS)		+= wireless/
 obj-$(CONFIG_MAC80211)		+= mac80211/
diff --git a/net/homa/Kconfig b/net/homa/Kconfig
new file mode 100644
index 000000000000..8ba81b00d35f
--- /dev/null
+++ b/net/homa/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Homa transport protocol
+#
+
+menuconfig HOMA
+	tristate "The Homa transport protocol"
+	depends on INET
+	depends on IPV6
+
+	help
+	Homa is a network transport protocol for communication within
+	a datacenter. It provides significantly lower latency than TCP,
+	particularly for workloads containing a mixture of large and small
+	messages operating at high network utilization. For more information
+	see the homa(7) man page or checkout the Homa Wiki at
+	https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview.
+
+	If unsure, say N.
diff --git a/net/homa/Makefile b/net/homa/Makefile
new file mode 100644
index 000000000000..3eb192a6ffa6
--- /dev/null
+++ b/net/homa/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Makefile for the Linux implementation of the Homa transport protocol.
+
+obj-$(CONFIG_HOMA) := homa.o
+homa-y:=        homa_incoming.o \
+		homa_outgoing.o \
+		homa_peer.o \
+		homa_pool.o \
+		homa_plumbing.o \
+		homa_rpc.o \
+		homa_sock.o \
+		homa_timer.o \
+		homa_utils.o
-- 
2.34.1


