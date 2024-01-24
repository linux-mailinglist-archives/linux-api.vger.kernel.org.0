Return-Path: <linux-api+bounces-603-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A4839FAD
	for <lists+linux-api@lfdr.de>; Wed, 24 Jan 2024 03:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED416282DBD
	for <lists+linux-api@lfdr.de>; Wed, 24 Jan 2024 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FAC1754A;
	Wed, 24 Jan 2024 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dxKpYYNe"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA57C8D2
	for <linux-api@vger.kernel.org>; Wed, 24 Jan 2024 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064868; cv=none; b=T+z7UWa5bNk0ClMjIgxNFb1EHDJANOUheDx+GgbUP/GhTDmTn35wQyJcRgzSn+SpAiBD6jxDs1AmJulN/Lfx6HItnOwytyZvfuQ4jdjZ8tKc7stje5mB93U7Yd3OW6NqK9KnP9T91+Jdce/eBtqa2WiFhDA+ouoBGW9GiYyPrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064868; c=relaxed/simple;
	bh=x9OhPpSYWyV//QzVZ+AyBMkwYyqs6YawOXB0aB4LXI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/yTISi7zV34dmE4SfBsKk9pK2c5dzIUCiiK2BvBZ2t/cO0QwNj7w0HuEJiZ/Hmr0bNjQxj0zS9q9sDAn8wHtv6NwWTzTIGrXMLFr60hj1m7EjRrRUA3kwKXeo1d3b2Bjdh4amXGo3LQMPmj9pxM6AYcp9/xbALKSg70yoPmoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dxKpYYNe; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da202aa138so3835156b3a.2
        for <linux-api@vger.kernel.org>; Tue, 23 Jan 2024 18:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706064866; x=1706669666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=005kpyubXBPQOHjxUqpZWTUrOf8Qcj4Qiatp9b0UiEQ=;
        b=dxKpYYNeGx0O3hiHTJm4sRj7+dBvgF2ad2bTB1sv2khpRtX/HUUrkmn/thcx+tAmj1
         j3+SJktksiKroIJjp6cHGn8SUlRIIUitgcfG1cMZvRGiCAKafwq43SJjmEIqUJLSeWL6
         h/D1Q5zzAfrTTZ5H4DMqVwrwBr7toN7hShZxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064866; x=1706669666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=005kpyubXBPQOHjxUqpZWTUrOf8Qcj4Qiatp9b0UiEQ=;
        b=uX4/8u3MNuq8+LJ9sdOTP26l0JgWK7oqhA8gxUdueDg4n7WrI+dblE4NcdWGgbdfRZ
         UU3RzRSxbpnV+qfbrqZhXn1nKyKTznMvbUsu+8z74zNtIBO6pU2gYlTdbN7VqfEgPkFw
         L7rGtoN4Mb2XaINA29Cuc261ieFey5D8D3Mf+kbz4kug2RBJhOFn2FD1onyziMXLVePE
         UCj8/X8wmN+1zYtG8qF47npXJkJF4aEfPprCb+V3o9lE9e+rK/qEvhxMBJaFN0H3E+x2
         BJsBPMHLzE3EvRB2Kxc0E1pgg5VV1WFIw/BOEXNFuUjEJtEBmMQwEBKD9Ey8oD9/O6FP
         FUBg==
X-Gm-Message-State: AOJu0YzmNZsnC2dOvEE3gLHQK52doSzXYGmZLgOZi9Hkd2RKtA4kTp13
	hzDooVWx9Nz6COI17JTW4omha3psLc8G+Lws8i7gv4oNA26BeLIa9NWaw33Rgas=
X-Google-Smtp-Source: AGHT+IHvjM42z5Ob49rS2wUG1yqcpOTjWFDo4wmk2k/hcusmSKEOAtCtsD9PFtd17SR/X3zBFLDomw==
X-Received: by 2002:a05:6a20:7d89:b0:19c:63ac:edec with SMTP id v9-20020a056a207d8900b0019c63acedecmr305042pzj.8.1706064866083;
        Tue, 23 Jan 2024 18:54:26 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z14-20020a62d10e000000b006d9b38f2e75sm12974229pfg.32.2024.01.23.18.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:54:25 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next 1/3] eventpoll: support busy poll per epoll instance
Date: Wed, 24 Jan 2024 02:53:57 +0000
Message-Id: <20240124025359.11419-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124025359.11419-1-jdamato@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow busy polling on a per-epoll context basis. The per-epoll context
usec timeout value is preferred, but the pre-existing system wide sysctl
value is still supported if it specified.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3534d36a1474..4503fec01278 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -227,6 +227,8 @@ struct eventpoll {
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
 	unsigned int napi_id;
+	/* busy poll timeout */
+	u64 busy_poll_usecs;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -386,12 +388,44 @@ static inline int ep_events_available(struct eventpoll *ep)
 		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
 }
 
+/**
+ * busy_loop_ep_timeout - check if busy poll has timed out. The timeout value
+ * from the epoll instance ep is preferred, but if it is not set fallback to
+ * the system-wide global via busy_loop_timeout.
+ *
+ * @start_time: The start time used to compute the remaining time until timeout.
+ * @ep: Pointer to the eventpoll context.
+ *
+ * Return: true if the timeout has expired, false otherwise.
+ */
+static inline bool busy_loop_ep_timeout(unsigned long start_time, struct eventpoll *ep)
+{
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	unsigned long bp_usec = READ_ONCE(ep->busy_poll_usecs);
+
+	if (bp_usec) {
+		unsigned long end_time = start_time + bp_usec;
+		unsigned long now = busy_loop_current_time();
+
+		return time_after(now, end_time);
+	} else {
+		return busy_loop_timeout(start_time);
+	}
+#endif
+	return true;
+}
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
+static bool ep_busy_loop_on(struct eventpoll *ep)
+{
+	return !!ep->busy_poll_usecs ^ net_busy_loop_on();
+}
+
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
 {
 	struct eventpoll *ep = p;
 
-	return ep_events_available(ep) || busy_loop_timeout(start_time);
+	return ep_events_available(ep) || busy_loop_ep_timeout(start_time, ep);
 }
 
 /*
@@ -404,7 +438,7 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 
-	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on()) {
+	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
 			       BUSY_POLL_BUDGET);
 		if (ep_events_available(ep))
@@ -430,7 +464,8 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 	struct socket *sock;
 	struct sock *sk;
 
-	if (!net_busy_loop_on())
+	ep = epi->ep;
+	if (!ep_busy_loop_on(ep))
 		return;
 
 	sock = sock_from_file(epi->ffd.file);
@@ -442,7 +477,6 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 		return;
 
 	napi_id = READ_ONCE(sk->sk_napi_id);
-	ep = epi->ep;
 
 	/* Non-NAPI IDs can be rejected
 	 *	or
@@ -466,6 +500,10 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 {
 }
 
+static inline bool ep_busy_loop_on(struct eventpoll *ep)
+{
+	return false;
+}
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -2058,6 +2096,9 @@ static int do_epoll_create(int flags)
 		error = PTR_ERR(file);
 		goto out_free_fd;
 	}
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	ep->busy_poll_usecs = 0;
+#endif
 	ep->file = file;
 	fd_install(fd, file);
 	return fd;
-- 
2.25.1


