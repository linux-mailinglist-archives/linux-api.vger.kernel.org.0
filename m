Return-Path: <linux-api+bounces-5929-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI0VNX4hsWkOrQIAu9opvQ
	(envelope-from <linux-api+bounces-5929-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:02:06 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF5225E599
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 988A8300D755
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A056C3BF671;
	Wed, 11 Mar 2026 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZBHLDL3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4026B3BD23D
	for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215810; cv=none; b=H6nDMzYL04UMI6X7wkbezcvbF9al2Ebfhl1tFSR9RFmoqBvFQZFGDWVEJfxCaI0ceW4zvbMfmm/OtC6kMjqt5TQyHL9FduyVZeT8jEs8DgjuhX9sBqhM1OSVEh8m/KYCpWEsBxjhsM1NOMZiF0xDpZXuc+ewfFdX8GPg2mUpItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215810; c=relaxed/simple;
	bh=kX5kLQG5J1Hlmj0ExCOTkwchnPLs0mj06XQzcCCourE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPA/OSWcQuou9k93EYzTVxf2en8Z61a56r69kHkY66ESusyRU4DIVNW3MuAKa+lAhlL8WnoA7M40tnnvx1NTXcsLMlR8tnk5lO4PS9ENQPLWDKtyAhY1LMOimXD+22cO7G6pGqk4XVMZqs8rDVShpZR8rnpcVQ8QUbfCy91e8V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZBHLDL3; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-466ebbf7ff7so1238522b6e.1
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215801; x=1773820601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqy84kuwqTRqlBZVM3vX2nv7L0enzcNB2UtOtxRx+lU=;
        b=PZBHLDL39zcZG6HXPIcAxfLZmW/1UBXziWefHTsZB0zSjmJpFQ/8jlQw55QEaGmEOk
         WHyrLakg4VHmAm/y8pIKlmIwugrrnvmIWT3+6BGJZtoC+ouu5gVllfQCyS72QKXw8/2a
         YE0n67s6gihcRahMXSXNVmChmPlauGN3d4rkF+pTirates39ekmIRdP8QsOgRPVRSukA
         +BeNnPYMGvq9fcM+9vG4VsQ9bXP/IZQDS5svDDiLoEg+7EHoo+DRmWGPXbENGMCSJtA/
         EGt+V4GJAVYly5HVCKqU5WuWL494GdMkUBFQGXxsqP+HTh88dNnZqwPYnH7hULJqlG30
         2ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215801; x=1773820601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aqy84kuwqTRqlBZVM3vX2nv7L0enzcNB2UtOtxRx+lU=;
        b=thCaWopQNXrUlGns4Q+EZf9dh9l44omzt5cHmavzofVL593MRMsHTykEDZdk3ZPY0P
         GcnvQRlOQ3FN0XLJmfwY1jzVms78HNqY7ZOX8IySCikMnTIsh2fioSeDbrLryzIL0Lwx
         BVFUudrqvDN5mCYXh+HDbSZ3JZO5BrVKSsFR4+ipFSSsHZe9jhRU6xOlgWWOg7B23jAT
         UC+zm8BqwLdw/n+Bu+trjvhZqSnhArIiejlgY7TBdm4VbvNTjjfzvGWMZJmzj3VFW0A2
         zB9j+L3nQO0H6qnAISF8mYHh0EQiTXA1/pLKqs2TUjKuUnCsKJpwnKThqPMl4+mEBXUs
         pE2A==
X-Forwarded-Encrypted: i=1; AJvYcCXGKjOYjXNeHaXulMVMLGIVCw/aacRH9GParItJ9VVzXMhbJFGzptK7Z8PQxk0ExgowXppLQ7MXMso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPYftcp57CtgzjVgYsZEv1aZ1Ugtx2+Lp1a4Qe4hCe5XQN4di
	3UfcbTxnGAnll2BdqXToZc2Jr9vZ+hvTy6EQLtm3MLnL84r88Po3w/Yj
X-Gm-Gg: ATEYQzym8pBFpu9OW4/mnlofSt6r7CiaLlv+0w+/w3wcsgWkh0iCl4KS/t3MzcmdD67
	cLZulU/wtSta/NxPFSwZY1aNmHrv1HZNRTSZxTfYZCNubVYV1V2+vnfDtrI1aNjBMnc4qyz/WMd
	sm3pWd6hjjcgaqjTmunQUYxifeOZKhblYgQgcoyHklm8621USaaSojPqCRZymQceVnhh73ZM5En
	Pt2xLtCHCCOgQPeih1ouC2BpZPhQ4N1xZdGFoRmwsnlQGWKPtD/OpnSK/2b858GS002jBIfNZxk
	fNizz2RB0DoXDy2Y4yiauT81HnIhjfoHFVf8rXzhRsMHglGjNsqCaEFl7efr0Bc868Ffm3jqPt8
	7xZQXb73tM06H3fguKAAm/5XZexb2UrxshxomDYhnPMnn7fa0iG0lBAL9uGtiZvmA8Y3yZY4OaS
	L1JaBwzjCaRqzi8UU/2relnFeQlkninGsVTR0VmJx/INzUsJZL5CjeSqa/M6e/nbNCBYEU6PZcB
	4mkyN0NQ0OR4bQuUYtEts8rgNN6wONYez0gYtpJS+GWsnAv
X-Received: by 2002:a05:6808:f8a:b0:450:4782:2b0e with SMTP id 5614622812f47-4673346f783mr849508b6e.15.1773215800832;
        Wed, 11 Mar 2026 00:56:40 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:40 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 7/7] selftests: tcp_ao: cover legacy and extended TCP_REPAIR_WINDOW layouts
Date: Wed, 11 Mar 2026 01:56:00 -0600
Message-Id: <20260311075600.948413-8-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AFF5225E599
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5929-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,lwn.net,linuxfoundation.org,goodmis.org,efficios.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-api];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Extend the repair helpers and selftests so the ABI contract is pinned
down in-tree.

The TCP-AO restore coverage now exercises both the exact and legacy
TCP_REPAIR_WINDOW layouts, verifies that intermediate lengths are
rejected, and keeps the packetdrill coverage for the advertised-window
receive-memory regressions in the same net selftest series.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 .../net/packetdrill/tcp_rcv_toobig.pkt        | 35 +++++++
 .../packetdrill/tcp_rcv_toobig_default.pkt    | 97 +++++++++++++++++++
 .../testing/selftests/net/tcp_ao/lib/aolib.h  | 56 +++++++++--
 .../testing/selftests/net/tcp_ao/lib/repair.c | 18 ++--
 .../selftests/net/tcp_ao/self-connect.c       | 61 ++++++++++--
 5 files changed, 244 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
new file mode 100644
index 000000000000..723c739ddc32
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh`
+
+    0 `nstat -n`
+
+// Establish a connection.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
+  +.1 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 < P. 1:20001(20000) ack 1 win 257
+ +.04 > .  1:1(0) ack 20001 win 18000
+
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [12000], 4) = 0
+   +0 < P. 20001:80001(60000) ack 1 win 257
+   +0 > .  1:1(0) ack 20001 win 18000
+
+   +0 read(4, ..., 20000) = 20000
+
+// A too big packet is accepted if the receive queue is empty, but the
+// stronger admission path must not zero the receive buffer while doing so.
+   +0 < P. 20001:80001(60000) ack 1 win 257
+   +0 > .  1:1(0) ack 80001 win 0
+   +0 %{ assert SK_MEMINFO_RCVBUF > 0, SK_MEMINFO_RCVBUF }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default.pkt
new file mode 100644
index 000000000000..b2e4950e0b83
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default.pkt
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_moderate_rcvbuf=0`
+
+// Establish a connection on the default receive buffer. Leave a large skb in
+// the queue, then deliver another one which still fits the remaining rwnd.
+// We should grow sk_rcvbuf to honor the already-advertised window instead of
+// dropping the packet.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <...>
+  +.1 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+// Exchange enough data to get past the completely fresh-socket case while
+// still keeping the receive buffer at its 128kB default.
+   +0 < P. 1:65001(65000) ack 1 win 257
+   * > .  1:1(0) ack 65001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 65001:130001(65000) ack 1 win 257
+   * > .  1:1(0) ack 130001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 130001:195001(65000) ack 1 win 257
+   * > .  1:1(0) ack 195001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 195001:260001(65000) ack 1 win 257
+   * > .  1:1(0) ack 260001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 260001:325001(65000) ack 1 win 257
+   * > .  1:1(0) ack 325001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 325001:390001(65000) ack 1 win 257
+   * > .  1:1(0) ack 390001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 390001:455001(65000) ack 1 win 257
+   * > .  1:1(0) ack 455001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 455001:520001(65000) ack 1 win 257
+   * > .  1:1(0) ack 520001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 520001:585001(65000) ack 1 win 257
+   * > .  1:1(0) ack 585001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 585001:650001(65000) ack 1 win 257
+   * > .  1:1(0) ack 650001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 650001:715001(65000) ack 1 win 257
+   * > .  1:1(0) ack 715001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 715001:780001(65000) ack 1 win 257
+   * > .  1:1(0) ack 780001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 780001:845001(65000) ack 1 win 257
+   * > .  1:1(0) ack 845001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 845001:910001(65000) ack 1 win 257
+   * > .  1:1(0) ack 910001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 910001:975001(65000) ack 1 win 257
+   * > .  1:1(0) ack 975001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 975001:1040001(65000) ack 1 win 257
+   * > .  1:1(0) ack 1040001
+   +0 read(4, ..., 65000) = 65000
+
+// Leave about 60kB queued, then accept another large skb which still fits
+// the rwnd we already exposed to the peer. The regression is the drop; the
+// exact sk_rcvbuf growth path is an implementation detail.
+   +0 < P. 1040001:1102001(62000) ack 1 win 257
+   * > .  1:1(0) ack 1102001
+
+   +0 < P. 1102001:1167001(65000) ack 1 win 257
+   * > .  1:1(0) ack 1167001
+   +0 read(4, ..., 127000) = 127000
diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index ebb2899c12fe..ff259795a4a0 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -13,6 +13,7 @@
 #include <linux/snmp.h>
 #include <linux/tcp.h>
 #include <netinet/in.h>
+#include <stddef.h>
 #include <stdarg.h>
 #include <stdbool.h>
 #include <stdlib.h>
@@ -671,17 +672,42 @@ struct tcp_sock_state {
 	int timestamp;
 };
 
-extern void __test_sock_checkpoint(int sk, struct tcp_sock_state *state,
-				   void *addr, size_t addr_size);
+/* Legacy userspace stops before the snapshot field and therefore exercises
+ * the kernel's unknown-snapshot fallback path.
+ */
+static inline socklen_t test_tcp_repair_window_legacy_size(void)
+{
+	return offsetof(struct tcp_repair_window, rcv_wnd_scaling_ratio);
+}
+
+static inline socklen_t test_tcp_repair_window_exact_size(void)
+{
+	return sizeof(struct tcp_repair_window);
+}
+
+void __test_sock_checkpoint_opt(int sk, struct tcp_sock_state *state,
+				socklen_t trw_len,
+				void *addr, size_t addr_size);
 static inline void test_sock_checkpoint(int sk, struct tcp_sock_state *state,
 					sockaddr_af *saddr)
 {
-	__test_sock_checkpoint(sk, state, saddr, sizeof(*saddr));
+	__test_sock_checkpoint_opt(sk, state, test_tcp_repair_window_exact_size(),
+				   saddr, sizeof(*saddr));
+}
+
+static inline void test_sock_checkpoint_legacy(int sk,
+					       struct tcp_sock_state *state,
+					       sockaddr_af *saddr)
+{
+	__test_sock_checkpoint_opt(sk, state, test_tcp_repair_window_legacy_size(),
+				   saddr, sizeof(*saddr));
 }
 extern void test_ao_checkpoint(int sk, struct tcp_ao_repair *state);
-extern void __test_sock_restore(int sk, const char *device,
-				struct tcp_sock_state *state,
-				void *saddr, void *daddr, size_t addr_size);
+void __test_sock_restore_opt(int sk, const char *device,
+			     struct tcp_sock_state *state,
+			     socklen_t trw_len,
+			     void *saddr, void *daddr,
+			     size_t addr_size);
 static inline void test_sock_restore(int sk, struct tcp_sock_state *state,
 				     sockaddr_af *saddr,
 				     const union tcp_addr daddr,
@@ -690,7 +716,23 @@ static inline void test_sock_restore(int sk, struct tcp_sock_state *state,
 	sockaddr_af addr;
 
 	tcp_addr_to_sockaddr_in(&addr, &daddr, htons(dport));
-	__test_sock_restore(sk, veth_name, state, saddr, &addr, sizeof(addr));
+	__test_sock_restore_opt(sk, veth_name, state,
+				test_tcp_repair_window_exact_size(),
+				saddr, &addr, sizeof(addr));
+}
+
+static inline void test_sock_restore_legacy(int sk,
+					    struct tcp_sock_state *state,
+					    sockaddr_af *saddr,
+					    const union tcp_addr daddr,
+					    unsigned int dport)
+{
+	sockaddr_af addr;
+
+	tcp_addr_to_sockaddr_in(&addr, &daddr, htons(dport));
+	__test_sock_restore_opt(sk, veth_name, state,
+				test_tcp_repair_window_legacy_size(),
+				saddr, &addr, sizeof(addr));
 }
 extern void test_ao_restore(int sk, struct tcp_ao_repair *state);
 extern void test_sock_state_free(struct tcp_sock_state *state);
diff --git a/tools/testing/selftests/net/tcp_ao/lib/repair.c b/tools/testing/selftests/net/tcp_ao/lib/repair.c
index 9893b3ba69f5..befbd0f72db5 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/repair.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/repair.c
@@ -66,8 +66,9 @@ static void test_sock_checkpoint_queue(int sk, int queue, int qlen,
 		test_error("recv(%d): %d", qlen, ret);
 }
 
-void __test_sock_checkpoint(int sk, struct tcp_sock_state *state,
-			    void *addr, size_t addr_size)
+void __test_sock_checkpoint_opt(int sk, struct tcp_sock_state *state,
+				socklen_t trw_len,
+				void *addr, size_t addr_size)
 {
 	socklen_t len = sizeof(state->info);
 	int ret;
@@ -82,9 +83,9 @@ void __test_sock_checkpoint(int sk, struct tcp_sock_state *state,
 	if (getsockname(sk, addr, &len) || len != addr_size)
 		test_error("getsockname(): %d", (int)len);
 
-	len = sizeof(state->trw);
+	len = trw_len;
 	ret = getsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &state->trw, &len);
-	if (ret || len != sizeof(state->trw))
+	if (ret || len != trw_len)
 		test_error("getsockopt(TCP_REPAIR_WINDOW): %d", (int)len);
 
 	if (ioctl(sk, SIOCOUTQ, &state->outq_len))
@@ -160,9 +161,10 @@ static void test_sock_restore_queue(int sk, int queue, void *buf, int len)
 	} while (len > 0);
 }
 
-void __test_sock_restore(int sk, const char *device,
-			 struct tcp_sock_state *state,
-			 void *saddr, void *daddr, size_t addr_size)
+void __test_sock_restore_opt(int sk, const char *device,
+			     struct tcp_sock_state *state,
+			     socklen_t trw_len,
+			     void *saddr, void *daddr, size_t addr_size)
 {
 	struct tcp_repair_opt opts[4];
 	unsigned int opt_nr = 0;
@@ -215,7 +217,7 @@ void __test_sock_restore(int sk, const char *device,
 	}
 	test_sock_restore_queue(sk, TCP_RECV_QUEUE, state->in.buf, state->inq_len);
 	test_sock_restore_queue(sk, TCP_SEND_QUEUE, state->out.buf, state->outq_len);
-	if (setsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &state->trw, sizeof(state->trw)))
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &state->trw, trw_len))
 		test_error("setsockopt(TCP_REPAIR_WINDOW)");
 }
 
diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index 2c73bea698a6..a7edd72ab28d 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -4,6 +4,7 @@
 #include "aolib.h"
 
 static union tcp_addr local_addr;
+static bool checked_repair_window_lens;
 
 static void __setup_lo_intf(const char *lo_intf,
 			    const char *addr_str, uint8_t prefix)
@@ -30,8 +31,40 @@ static void setup_lo_intf(const char *lo_intf)
 #endif
 }
 
+/* The repair ABI accepts exactly the legacy and extended layouts. */
+static void test_repair_window_len_contract(int sk)
+{
+	struct tcp_repair_window trw = {};
+	socklen_t len = test_tcp_repair_window_exact_size();
+	socklen_t bad_len = test_tcp_repair_window_legacy_size() + 1;
+	int ret;
+
+	if (checked_repair_window_lens)
+		return;
+
+	checked_repair_window_lens = true;
+
+	ret = getsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &trw, &len);
+	if (ret || len != test_tcp_repair_window_exact_size())
+		test_error("getsockopt(TCP_REPAIR_WINDOW): %d", (int)len);
+
+	len = bad_len;
+	ret = getsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &trw, &len);
+	if (ret == 0 || errno != EINVAL)
+		test_fail("repair-window get rejects invalid len");
+	else
+		test_ok("repair-window get rejects invalid len");
+
+	ret = setsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &trw, bad_len);
+	if (ret == 0 || errno != EINVAL)
+		test_fail("repair-window set rejects invalid len");
+	else
+		test_ok("repair-window set rejects invalid len");
+}
+
 static void tcp_self_connect(const char *tst, unsigned int port,
-			     bool different_keyids, bool check_restore)
+			     bool different_keyids, bool check_restore,
+			     bool legacy_repair_window)
 {
 	struct tcp_counters before, after;
 	uint64_t before_aogood, after_aogood;
@@ -109,7 +142,11 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 	}
 
 	test_enable_repair(sk);
-	test_sock_checkpoint(sk, &img, &addr);
+	test_repair_window_len_contract(sk);
+	if (legacy_repair_window)
+		test_sock_checkpoint_legacy(sk, &img, &addr);
+	else
+		test_sock_checkpoint(sk, &img, &addr);
 #ifdef IPV6_TEST
 	addr.sin6_port = htons(port + 1);
 #else
@@ -123,7 +160,11 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 		test_error("socket()");
 
 	test_enable_repair(sk);
-	__test_sock_restore(sk, "lo", &img, &addr, &addr, sizeof(addr));
+	__test_sock_restore_opt(sk, "lo", &img,
+				legacy_repair_window ?
+				test_tcp_repair_window_legacy_size() :
+				test_tcp_repair_window_exact_size(),
+				&addr, &addr, sizeof(addr));
 	if (different_keyids) {
 		if (test_add_repaired_key(sk, DEFAULT_TEST_PASSWORD, 0,
 					  local_addr, -1, 7, 5))
@@ -165,20 +206,24 @@ static void *client_fn(void *arg)
 
 	setup_lo_intf("lo");
 
-	tcp_self_connect("self-connect(same keyids)", port++, false, false);
+	tcp_self_connect("self-connect(same keyids)", port++, false, false, false);
 
 	/* expecting rnext to change based on the first segment RNext != Current */
 	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
 			      port, port, 0, -1, -1, -1, -1, -1, 7, 5, -1);
-	tcp_self_connect("self-connect(different keyids)", port++, true, false);
-	tcp_self_connect("self-connect(restore)", port, false, true);
+	tcp_self_connect("self-connect(different keyids)", port++, true, false, false);
+	tcp_self_connect("self-connect(restore)", port, false, true, false);
+	port += 2; /* restore test restores over different port */
+	tcp_self_connect("self-connect(restore, legacy repair window)",
+			 port, false, true, true);
 	port += 2; /* restore test restores over different port */
 	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
 			      port, port, 0, -1, -1, -1, -1, -1, 7, 5, -1);
 	/* intentionally on restore they are added to the socket in different order */
 	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
 			      port + 1, port + 1, 0, -1, -1, -1, -1, -1, 5, 7, -1);
-	tcp_self_connect("self-connect(restore, different keyids)", port, true, true);
+	tcp_self_connect("self-connect(restore, different keyids)",
+			 port, true, true, false);
 	port += 2; /* restore test restores over different port */
 
 	return NULL;
@@ -186,6 +231,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(5, client_fn, NULL);
+	test_init(8, client_fn, NULL);
 	return 0;
 }
-- 
2.34.1


