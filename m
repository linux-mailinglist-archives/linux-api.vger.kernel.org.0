Return-Path: <linux-api+bounces-5581-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D849BCF2663
	for <lists+linux-api@lfdr.de>; Mon, 05 Jan 2026 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C9E5301470E
	for <lists+linux-api@lfdr.de>; Mon,  5 Jan 2026 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B3B331227;
	Mon,  5 Jan 2026 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nWSSKglL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m2V5ETSY"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AE32E6B4;
	Mon,  5 Jan 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601560; cv=none; b=Rd38tzWOxfN3dLlqtp1eoflqIsdO6gvc65LNImqkRNqMn8f4GM117ggkwrEKOLelDogFaYo3f4sXPpBkj0/aABAHnCO/IBwdeuMeTY8Qb+HpXK8C1/pOuLvaEBw8EVzGLLYDNpO3hfe38Ta0aFW3FqBWVTXo/sZk15sMkuie0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601560; c=relaxed/simple;
	bh=F0BXKGEIbQEgNDpnR4sFqfVyBXsRDo0ukaJR9qC1Fkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QNSZVHQDHV9+cPsc2dKQmAEyhDMfYuBftpkuX3IIBKPJkcZWJ9O1eULDqH+YdSAf5BQ4qBddv6hIszpjP0IMUQncFUEm0gGUyBN9Sxms4Vf1FI6letf37IUB8mRvduAjIfL9kNrtv8b2St0q88V3Ox5GQ5c0eVzGU5HvJyFQJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nWSSKglL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m2V5ETSY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767601556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iomAiraVidAewY3lmJu2od0SPuPOGXSVoNfq8xPpxJ4=;
	b=nWSSKglLmp7/eMP8nNDM6vrYHRfHBOQTAiOT8zKJaWCE+nktUo2aokh8aI3ImWVItHeIl2
	30iVoK3GBcpuit5sL7ev/V7jRlMygpMGPM6E/uHVmRfG58UBmH8SsMcOinRpPLOuuc1QLM
	ybuRK+dzlE44E4Cys2aWy7QOeRcnxaLVkVBeGrCxMopEPWmKywtcBQ3olFS8BQaOtITgLf
	dWx5EKseWRiOZRh7ZXC33opAP6moL2/W90accepPsi7dCtzoVvBkabECN/ivUz+2Uqa8+S
	n3/rKvTrGQ8XU9BdRlq52Xc/QELnMg4+tt11RSX3U/AYv4v2dG3Q1TFGSYmfNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767601556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iomAiraVidAewY3lmJu2od0SPuPOGXSVoNfq8xPpxJ4=;
	b=m2V5ETSYA+AAksePtKRl2SD9H+s59ZvuDemc1NOyEhpaSKvY+UBYMGcwal2eg4vTfz//+Y
	K0MBhOtdTKFyVEAQ==
Date: Mon, 05 Jan 2026 09:25:55 +0100
Subject: [PATCH net-next] net: uapi: Provide an UAPI definition of 'struct
 sockaddr'
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJJ1W2kC/x3MQQqAIBBA0avErBvIoZK6SrQQHWsILLRCiO6et
 HyL/x9IHIUTjNUDkW9JsocCVVdgVxMWRnHFQA11iojwModg2u1mnItovWpY99RqGqA0R2Qv+f9
 NEPjEwPmE+X0/S41aq2kAAAA=
X-Change-ID: 20251222-uapi-sockaddr-cf10e7624729
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767601555; l=4018;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=F0BXKGEIbQEgNDpnR4sFqfVyBXsRDo0ukaJR9qC1Fkg=;
 b=+I/qcHQzJobm848ZdicumfKVxZIq5NV0lyRX410kNtzxyPvyrXtlW+t4seoD6lIEOrLdduxY/
 XNiqcVgytBrC6QmA9VNd5M89I7FZdLRhJ9ajIpFVm9kxXMmr25AOd26
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Various UAPI headers reference 'struct sockaddr'. Currently the
definition of this struct is pulled in from the libc header
sys/socket.h. This is problematic as it introduces a dependency
on a full userspace toolchain.

Instead expose a custom but compatible definition of 'struct sockaddr'
in the UAPI headers. It is guarded by the libc compatibility
infrastructure to avoid potential conflicts.

The compatibility symbol won't be supported by glibc right away,
but right now __UAPI_DEF_IF_IFNAMSIZ is not supported either,
so including the libc headers before the UAPI headers is broken anyways.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/socket.h           | 10 ----------
 include/uapi/linux/if.h          |  4 ----
 include/uapi/linux/libc-compat.h | 12 ++++++++++++
 include/uapi/linux/socket.h      | 14 ++++++++++++++
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index ec715ad4bf25..8363d4e0a044 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -28,16 +28,6 @@ extern void socket_seq_show(struct seq_file *seq);
 
 typedef __kernel_sa_family_t	sa_family_t;
 
-/*
- *	1003.1g requires sa_family_t and that sa_data is char.
- */
-
-/* Deprecated for in-kernel use. Use struct sockaddr_unsized instead. */
-struct sockaddr {
-	sa_family_t	sa_family;	/* address family, AF_xxx	*/
-	char		sa_data[14];	/* 14 bytes of protocol address	*/
-};
-
 /**
  * struct sockaddr_unsized - Unspecified size sockaddr for callbacks
  * @sa_family: Address family (AF_UNIX, AF_INET, AF_INET6, etc.)
diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
index 797ba2c1562a..a4bc54196a07 100644
--- a/include/uapi/linux/if.h
+++ b/include/uapi/linux/if.h
@@ -25,10 +25,6 @@
 #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
 #include <linux/compiler.h>		/* for "__user" et al           */
 
-#ifndef __KERNEL__
-#include <sys/socket.h>			/* for struct sockaddr.		*/
-#endif
-
 #if __UAPI_DEF_IF_IFNAMSIZ
 #define	IFNAMSIZ	16
 #endif /* __UAPI_DEF_IF_IFNAMSIZ */
diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
index 0eca95ccb41e..13a06ce4e825 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -140,6 +140,13 @@
 
 #endif /* _NETINET_IN_H */
 
+/* Definitions for socket.h */
+#if defined(_SYS_SOCKET_H)
+#define __UAPI_DEF_SOCKADDR		0
+#else
+#define __UAPI_DEF_SOCKADDR		1
+#endif
+
 /* Definitions for xattr.h */
 #if defined(_SYS_XATTR_H)
 #define __UAPI_DEF_XATTR		0
@@ -221,6 +228,11 @@
 #define __UAPI_DEF_IP6_MTUINFO		1
 #endif
 
+/* Definitions for socket.h */
+#ifndef __UAPI_DEF_SOCKADDR
+#define __UAPI_DEF_SOCKADDR		1
+#endif
+
 /* Definitions for xattr.h */
 #ifndef __UAPI_DEF_XATTR
 #define __UAPI_DEF_XATTR		1
diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53..35d7d5f4b1a8 100644
--- a/include/uapi/linux/socket.h
+++ b/include/uapi/linux/socket.h
@@ -2,6 +2,8 @@
 #ifndef _UAPI_LINUX_SOCKET_H
 #define _UAPI_LINUX_SOCKET_H
 
+#include <linux/libc-compat.h>          /* for compatibility with glibc */
+
 /*
  * Desired design of maximum size and alignment (see RFC2553)
  */
@@ -26,6 +28,18 @@ struct __kernel_sockaddr_storage {
 	};
 };
 
+/*
+ *	1003.1g requires sa_family_t and that sa_data is char.
+ */
+
+/* Deprecated for in-kernel use. Use struct sockaddr_unsized instead. */
+#if __UAPI_DEF_SOCKADDR
+struct sockaddr {
+	__kernel_sa_family_t	sa_family;	/* address family, AF_xxx	*/
+	char			sa_data[14];	/* 14 bytes of protocol address	*/
+};
+#endif /* __UAPI_DEF_SOCKADDR */
+
 #define SOCK_SNDBUF_LOCK	1
 #define SOCK_RCVBUF_LOCK	2
 

---
base-commit: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
change-id: 20251222-uapi-sockaddr-cf10e7624729

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


