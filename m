Return-Path: <linux-api+bounces-2696-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5FA9C49D1
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 00:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE081F22657
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2024 23:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC011BD032;
	Mon, 11 Nov 2024 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="BNKMqxnO"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E666156F21
	for <linux-api@vger.kernel.org>; Mon, 11 Nov 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368448; cv=none; b=NRMtasUqAf48b3N+t7E1U6yTkx7pDVBuEkunFpQoVkXIbyklzi1YHiFHO+G/B+3kZ3svYAKc0E4Efw59hIulSp4f/CUqgDYgg/LX54vQrcK8h5Q1kQI+lPQbA3eKSksrT5DX9ZJMSxhi0RkSobY4Fv1SNDNzo7m1gw8xilkDERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368448; c=relaxed/simple;
	bh=ziWOXnRCJxMMKPnW+LHPgsfMWHjD0j5x9JsG0zok8cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLVczHmzFrtZ4RUr1OWrXgeOTCJYomT0SAWdlWXdbI/J6riqgQbyg7002we5piu0fXGtCxnUeUplagCBUG/vwZGsFgpzdgrSxboqmevFV5dStPWxJMl3LfgfUi6up7jNndUutK/KIYVQumPWBsblkby6BB3X4Z4m34efxA+0U+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=BNKMqxnO; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fyYMgF7rVq5RKjxt6RJsiqUQAsp6ww5q/ZVu2GP31pA=; t=1731368446; x=1732232446; 
	b=BNKMqxnO5gkFElELx9daTZ53oqJIO66iU0WA31qCTfNWr5LLEkvAhVAvqHkVS+6wBP42YI26r54
	5YxFvUTIFodoH7MObQXyt8BiCpXt3/L/jdbdy5ZfQyYrCYzNsRql5eM5mzj3MdI79RtWutgnBboTd
	TluxJ9lunTJlfXFumGpVQ2fEMUAp58ejxJNQOYaFNg6D/sE93jnmfD4BTzvY9VztV+QJdBLBg/MTU
	y2cRI/Rd3Sfx+qq8wwfLyJYEQsye1k1RigXvjWGhu/T/qa3e/HweoPfl9olPSc87K6tJayS4f/xlk
	8sQbIzB9Ds7al0svGu26JrCcGW1jKaAfwxcQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:54467 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tAe1P-0002NP-SK; Mon, 11 Nov 2024 15:40:40 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v2 00/12] Begin upstreaming Homa transport protocol
Date: Mon, 11 Nov 2024 15:39:53 -0800
Message-ID: <20241111234006.5942-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: dfe9a19d2d5d3f4658608889c96f7beb

This patch series begins the process of upstreaming the Homa transport
protocol. Homa is an alternative to TCP for use in datacenter
environments. It provides 10-100x reductions in tail latency for short
messages relative to TCP. Its benefits are greatest for mixed workloads
containing both short and long messages running under high network loads.
Homa is not API-compatible with TCP: it is connectionless and message-
oriented (but still reliable and flow-controlled). Homa's new API not
only contributes to its performance gains, but it also eliminates the
massive amount of connection state required by TCP for highly connected
datacenter workloads.

For more details on Homa, please consult the Homa Wiki:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
The Wiki has pointers to two papers on Homa (one of which describes
this implementation) as well as man pages describing the application
API and other information.

There is also a GitHub repo for Homa:
https://github.com/PlatformLab/HomaModule
The GitHub repo contains a superset of this patch set, including:
* Additional source code that will eventually be upstreamed
* Extensive unit tests (which will also be upstreamed eventually)
* Application-level library functions (which need to go in glibc?)
* Man pages (which need to be upstreamed as well)
* Benchmarking and instrumentation code

For this patch series, Homa has been stripped down to the bare minimum
functionality capable of actually executing remote procedure calls. (about
7500 lines of source code, compared to 15000 in the complete Homa). The
remaining code will be upstreamed in smaller batches once this patch
series has been accepted. Note: the code in this patch series is
functional but its performance is not very interesting (about the same
as TCP).

The patch series is arranged to introduce the major functional components
of Homa. Until the last patch has been applied, the code is inert (it
will not be compiled).

Note: this implementation of Homa supports both IPv4 and IPv6.

John Ousterhout (12):
  net: homa: define user-visible API for Homa
  net: homa: define Homa packet formats
  net: homa: create shared Homa header files
  net: homa: create homa_pool.h and homa_pool.c
  net: homa: create homa_rpc.h and homa_rpc.c
  net: homa: create homa_peer.h and homa_peer.c
  net: homa: create homa_sock.h and homa_sock.c
  net: homa: create homa_incoming.c
  net: homa: create homa_outgoing.c
  net: homa: create homa_timer.c
  net: homa: create homa_plumbing.c homa_utils.c
  net: homa: create Makefile and Kconfig

 MAINTAINERS               |    7 +
 include/uapi/linux/homa.h |  165 ++++++
 net/Kconfig               |    1 +
 net/Makefile              |    1 +
 net/homa/Kconfig          |   19 +
 net/homa/Makefile         |   14 +
 net/homa/homa_impl.h      |  767 ++++++++++++++++++++++++++
 net/homa/homa_incoming.c  | 1076 +++++++++++++++++++++++++++++++++++++
 net/homa/homa_outgoing.c  |  854 +++++++++++++++++++++++++++++
 net/homa/homa_peer.c      |  319 +++++++++++
 net/homa/homa_peer.h      |  234 ++++++++
 net/homa/homa_plumbing.c  |  965 +++++++++++++++++++++++++++++++++
 net/homa/homa_pool.c      |  420 +++++++++++++++
 net/homa/homa_pool.h      |  152 ++++++
 net/homa/homa_rpc.c       |  488 +++++++++++++++++
 net/homa/homa_rpc.h       |  446 +++++++++++++++
 net/homa/homa_sock.c      |  380 +++++++++++++
 net/homa/homa_sock.h      |  426 +++++++++++++++
 net/homa/homa_stub.h      |   80 +++
 net/homa/homa_timer.c     |  156 ++++++
 net/homa/homa_utils.c     |  150 ++++++
 net/homa/homa_wire.h      |  378 +++++++++++++
 22 files changed, 7498 insertions(+)
 create mode 100644 include/uapi/linux/homa.h
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile
 create mode 100644 net/homa/homa_impl.h
 create mode 100644 net/homa/homa_incoming.c
 create mode 100644 net/homa/homa_outgoing.c
 create mode 100644 net/homa/homa_peer.c
 create mode 100644 net/homa/homa_peer.h
 create mode 100644 net/homa/homa_plumbing.c
 create mode 100644 net/homa/homa_pool.c
 create mode 100644 net/homa/homa_pool.h
 create mode 100644 net/homa/homa_rpc.c
 create mode 100644 net/homa/homa_rpc.h
 create mode 100644 net/homa/homa_sock.c
 create mode 100644 net/homa/homa_sock.h
 create mode 100644 net/homa/homa_stub.h
 create mode 100644 net/homa/homa_timer.c
 create mode 100644 net/homa/homa_utils.c
 create mode 100644 net/homa/homa_wire.h

--
2.34.1


