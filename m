Return-Path: <linux-api+bounces-2698-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D29C49D2
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 00:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D270289173
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2024 23:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2579015A864;
	Mon, 11 Nov 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="BqiaFDSF"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B81AE014
	for <linux-api@vger.kernel.org>; Mon, 11 Nov 2024 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368449; cv=none; b=EYxg/HoVMcnVnV3ZimRU8B+1mQz9Z/rntKy+Z/p2B0wgq3hE/xxR5waKoT12qBSELBLEBKka5P8gFX5Wd7eMEsa/W29oXJuhCZf58Pyvuqpbi0zW0IDRucLnyN0WQyU+LtQCcg+xnSBZxO104Jp3ERVkUggEGNgzl08+qsqfrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368449; c=relaxed/simple;
	bh=jotivBw7mrLSzxetjbP4AvIoi1+jbKOuREJSN5mJSY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwK+MFobDtrzSfM0dXH05AzHjfGd5KPc9FcADWfmEXAoU2A/njoyYrPdcuSn0WFpT2wKQvH24XBY9lpLGXuawA+icae4k9D9rTtTutsyywTdZ69VKFF/bdmWrNtjygYtMny/re/8YnOwhFLHH+sBf9Oi2xKcPmiivxKs7+4/6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=BqiaFDSF; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U/RlneSlwoaVF+gnEYnz6ND6Rj8DJKyTgBm/IctHBC8=; t=1731368447; x=1732232447; 
	b=BqiaFDSF5JofyjLZvM3fhtBx+dPgxj0qZCZtBAB48HSMbrwsDe7nIaAQsRXIk2pH2k/6j6IgEKE
	UmebIJb1gNGx7oMSaRvgOWv4NpN+njOlHnaK0EAId9QWYLtbrHO2g/4yqNvcgDqby3qGD2IuhiryT
	uTmwv0Hx/DQFvI5D5f4C61fY9Aa/eejzNNRnGCUBz9xf+7L5+KoLZBlAAI6UrsM6mCV1AcwscdDcS
	hLgZ/K/lG2ixju5ODNRp3N80q8exZuMNLiOl7r9SkvdJ05Yy7DrNcxSKcZ/NRKhaYlprkwh0Y2TIU
	4Dre2UvTq4mruKZ6vNNGnrDh+f+tK4gajFNA==;
Received: from ouster448.stanford.edu ([172.24.72.71]:54467 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tAe1Q-0002NP-Nt; Mon, 11 Nov 2024 15:40:41 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v2 01/12] net: homa: define user-visible API for Homa
Date: Mon, 11 Nov 2024 15:39:54 -0800
Message-ID: <20241111234006.5942-2-ouster@cs.stanford.edu>
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
X-Scan-Signature: d35fb6c06066e474e02df1cf6298274e

Note: for man pages, see the Homa Wiki at:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 include/uapi/linux/homa.h | 165 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 include/uapi/linux/homa.h

diff --git a/include/uapi/linux/homa.h b/include/uapi/linux/homa.h
new file mode 100644
index 000000000000..d06cfc49c101
--- /dev/null
+++ b/include/uapi/linux/homa.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file defines the kernel call interface for the Homa
+ * transport protocol.
+ */
+
+#ifndef _UAPI_LINUX_HOMA_H
+#define _UAPI_LINUX_HOMA_H
+
+#include <linux/types.h>
+#ifndef __KERNEL__
+#include <netinet/in.h>
+#include <sys/socket.h>
+#endif
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+/* IANA-assigned Internet Protocol number for Homa. */
+#define IPPROTO_HOMA 146
+
+/**
+ * define HOMA_MAX_MESSAGE_LENGTH - Maximum bytes of payload in a Homa
+ * request or response message.
+ */
+#define HOMA_MAX_MESSAGE_LENGTH 1000000
+
+/**
+ * define HOMA_BPAGE_SIZE - Number of bytes in pages used for receive
+ * buffers. Must be power of two.
+ */
+#define HOMA_BPAGE_SHIFT 16
+#define HOMA_BPAGE_SIZE (1 << HOMA_BPAGE_SHIFT)
+
+/**
+ * define HOMA_MAX_BPAGES: The largest number of bpages that will be required
+ * to store an incoming message.
+ */
+#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1) \
+		>> HOMA_BPAGE_SHIFT)
+
+/**
+ * define HOMA_MIN_DEFAULT_PORT - The 16-bit port space is divided into
+ * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
+ * for well-defined server ports. The remaining ports are used for client
+ * ports; these are allocated automatically by Homa. Port 0 is reserved.
+ */
+#define HOMA_MIN_DEFAULT_PORT 0x8000
+
+/**
+ * struct homa_sendmsg_args - Provides information needed by Homa's
+ * sendmsg; passed to sendmsg using the msg_control field.
+ */
+struct homa_sendmsg_args {
+	/**
+	 * @id: (in/out) An initial value of 0 means a new request is
+	 * being sent; nonzero means the message is a reply to the given
+	 * id. If the message is a request, then the value is modified to
+	 * hold the id of the new RPC.
+	 */
+	uint64_t id;
+
+	/**
+	 * @completion_cookie: (in) Used only for request messages; will be
+	 * returned by recvmsg when the RPC completes. Typically used to
+	 * locate app-specific info about the RPC.
+	 */
+	uint64_t completion_cookie;
+};
+
+#if !defined(__cplusplus)
+_Static_assert(sizeof(struct homa_sendmsg_args) >= 16,
+	       "homa_sendmsg_args shrunk");
+_Static_assert(sizeof(struct homa_sendmsg_args) <= 16,
+	       "homa_sendmsg_args grew");
+#endif
+
+/**
+ * struct homa_recvmsg_args - Provides information needed by Homa's
+ * recvmsg; passed to recvmsg using the msg_control field.
+ */
+struct homa_recvmsg_args {
+	/**
+	 * @id: (in/out) Initially specifies the id of the desired RPC, or 0
+	 * if any RPC is OK; returns the actual id received.
+	 */
+	uint64_t id;
+
+	/**
+	 * @completion_cookie: (out) If the incoming message is a response,
+	 * this will return the completion cookie specified when the
+	 * request was sent. For requests this will always be zero.
+	 */
+	uint64_t completion_cookie;
+
+	/**
+	 * @flags: (in) OR-ed combination of bits that control the operation.
+	 * See below for values.
+	 */
+	uint32_t flags;
+
+	/**
+	 * @num_bpages: (in/out) Number of valid entries in @bpage_offsets.
+	 * Passes in bpages from previous messages that can now be
+	 * recycled; returns bpages from the new message.
+	 */
+	uint32_t num_bpages;
+
+	/**
+	 * @bpage_offsets: (in/out) Each entry is an offset into the buffer
+	 * region for the socket pool. When returned from recvmsg, the
+	 * offsets indicate where fragments of the new message are stored. All
+	 * entries but the last refer to full buffer pages (HOMA_BPAGE_SIZE bytes)
+	 * and are bpage-aligned. The last entry may refer to a bpage fragment and
+	 * is not necessarily aligned. The application now owns these bpages and
+	 * must eventually return them to Homa, using bpage_offsets in a future
+	 * recvmsg invocation.
+	 */
+	uint32_t bpage_offsets[HOMA_MAX_BPAGES];
+};
+
+#if !defined(__cplusplus)
+_Static_assert(sizeof(struct homa_recvmsg_args) >= 88,
+	       "homa_recvmsg_args shrunk");
+_Static_assert(sizeof(struct homa_recvmsg_args) <= 88,
+	       "homa_recvmsg_args grew");
+#endif
+
+/* Flag bits for homa_recvmsg_args.flags (see man page for documentation):
+ */
+#define HOMA_RECVMSG_REQUEST       0x01
+#define HOMA_RECVMSG_RESPONSE      0x02
+#define HOMA_RECVMSG_NONBLOCKING   0x04
+#define HOMA_RECVMSG_VALID_FLAGS   0x07
+
+/** define SO_HOMA_SET_BUF: setsockopt option for specifying buffer region. */
+#define SO_HOMA_SET_BUF 10
+
+/** struct homa_set_buf - setsockopt argument for SO_HOMA_SET_BUF. */
+struct homa_set_buf_args {
+	/** @start: First byte of buffer region. */
+	void *start;
+
+	/** @length: Total number of bytes available at @start. */
+	size_t length;
+};
+
+/**
+ * Meanings of the bits in Homa's flag word, which can be set using
+ * "sysctl /net/homa/flags".
+ */
+
+/**
+ * Disable the output throttling mechanism: always send all packets
+ * immediately.
+ */
+#define HOMA_FLAG_DONT_THROTTLE   2
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _UAPI_LINUX_HOMA_H */
-- 
2.34.1


