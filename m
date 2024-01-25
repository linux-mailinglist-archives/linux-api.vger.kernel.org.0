Return-Path: <linux-api+bounces-634-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E9E83B60C
	for <lists+linux-api@lfdr.de>; Thu, 25 Jan 2024 01:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7591C2220B
	for <lists+linux-api@lfdr.de>; Thu, 25 Jan 2024 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C4067C42;
	Thu, 25 Jan 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RrRYhH/i"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16080A
	for <linux-api@vger.kernel.org>; Thu, 25 Jan 2024 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706142625; cv=none; b=ZYkYl/zj0U//N9H24Gi9qX3xVl/COhVRI+gReeRdW1V33pxyju7XvDhgT2bOcT6PQKaxlnTwHgmffxdpd0NDc5DakskI2vnZOO6VpDyBbSfF4BgR0+EjwPQVdo1embjkay1S3bS0sGkvxgcfj9R71nm+CX5we7NEIxq4LeX7wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706142625; c=relaxed/simple;
	bh=qkngexUKlfn+hMPunN78J4XlCpnaY0JzFvOY2CvOwFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhTsKoMGSzH9BwH8uAJjYyjvTsQKeJEs97k/mVm2gnsyQExV2tqt5DRdv/rZzWUlG3NzG5vRbZok+Axm+ZhDcXT6pw/ZoUTfxtz8ugMUQbKdyfRxUc7eSRq6lv5h0dpMIwkrlerl59kiszSJoz2bVUbqYXhAYy81aLFuVTAC+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RrRYhH/i; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bee874fcc2so315311639f.1
        for <linux-api@vger.kernel.org>; Wed, 24 Jan 2024 16:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706142622; x=1706747422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VV39OAkRpCVAHLKUI3lU3BvBDLbvOa7qJKwdNWq/qLo=;
        b=RrRYhH/iEsRHUmKTquV2y95C9aRsKyCGxgflWpj0V8QQpjBruF+BKUVz0LDlNsI313
         8aI4+U3ixR45wYg8g3NTlExvkD//EWmymdG7TeA4zAT0wedY0BX8zsZUlPWuKfQoeszg
         uTrztf7SZyKmfaLyL7opJRTMLitGJKRVxeNEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706142622; x=1706747422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VV39OAkRpCVAHLKUI3lU3BvBDLbvOa7qJKwdNWq/qLo=;
        b=qNKovFRZsA3oN4GmFVedJ09BQiSNkSGsVymfoxePrFH09pIBNK4PrUWWqqeCaj1gJ+
         SdvMI7tb9uOzMpxnf/yBKOeenJhzaxs4Q0/tbVtrIN0KKp028+ZoQmUfHFNMns/5TJIC
         79Ee9YKEyGwELIC4j+JeA85wTaPRKghh2W+NQ2HbpLUNbJgqwxVWkORoHKV0tT5ApVij
         OfZmNlVe/QqRJ+ZZ58ORtV/6XxXnuiVxX32/gUrSTWHJ6eSX7RhdNQfU24gXWAK0C2xF
         pDk7VKFZ+BE8/+IQb1/9yaNkTVC/nhhj6GYI+935wWBEM88/TX5cI8LlEHdqJnJepf1P
         exbA==
X-Gm-Message-State: AOJu0YyfWbm6nPvKY9h/nqlS5PhZVY3CCsq4JYDzFo2PwZhbabBC34H2
	yyY17/Yi9E+zG6ujkYFK81E2w+2Ud6UH0sHChRDOEw6KHOYhrMrATkfD1VHpi28=
X-Google-Smtp-Source: AGHT+IGnYPOifsV33or2bBeZeQG6+k6OkdXKBZqmsoPyQU14DL3OI0VG4LUd5evkY/JboI23hyOIDQ==
X-Received: by 2002:a92:cec9:0:b0:361:ac44:150a with SMTP id z9-20020a92cec9000000b00361ac44150amr285943ilq.57.1706142622585;
        Wed, 24 Jan 2024 16:30:22 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id w10-20020a63d74a000000b005cd945c0399sm12550486pgi.80.2024.01.24.16.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:30:21 -0800 (PST)
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
	weiwan@google.com,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next v2 1/4] eventpoll: support busy poll per epoll instance
Date: Thu, 25 Jan 2024 00:30:11 +0000
Message-Id: <20240125003014.43103-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125003014.43103-1-jdamato@fastly.com>
References: <20240125003014.43103-1-jdamato@fastly.com>
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

Note that this change uses an xor: either per epoll instance busy polling
is enabled on the epoll instance or system wide epoll is enabled. Enabling
both is disallowed.

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


