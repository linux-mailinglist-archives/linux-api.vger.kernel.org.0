Return-Path: <linux-api+bounces-664-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC5483CFCF
	for <lists+linux-api@lfdr.de>; Thu, 25 Jan 2024 23:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320D51F2177D
	for <lists+linux-api@lfdr.de>; Thu, 25 Jan 2024 22:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009FC134BA;
	Thu, 25 Jan 2024 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LNteaX/L"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BA12E40
	for <linux-api@vger.kernel.org>; Thu, 25 Jan 2024 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223468; cv=none; b=bGCSJ/kqFT8U3pvqR9JpZbT0zafGVTMtTSXciNRe2jZLtAx3fndCMlHM2jRlJqQ+Ll2cDlg39x5RNwLnU9oaHEwn6bD2OhVXY5UI8nnU5beAt7q7tcOm68Jj+wslxIN/CIUVGGdRsKcYC3eu3fB8SeXYZAsKSskElJl+6ThnmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223468; c=relaxed/simple;
	bh=qkngexUKlfn+hMPunN78J4XlCpnaY0JzFvOY2CvOwFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGka6FUj+N+JGz3wk6n5wjddlND8LJ8mGw7SkqQtzWHyMk1x3Kk4Taz8Xtb5hg6mso0yR3Hry0BHVNCc7uZUXT7wHn/4bock/19fPgbRh2XVD5h1v+8dC2cxE7yvJe5hB9ng4vMSyTcxI+wsYlb+jbogC6CY8k+ZBLQ7wX5HrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LNteaX/L; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dddc655a60so5149734a34.2
        for <linux-api@vger.kernel.org>; Thu, 25 Jan 2024 14:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706223466; x=1706828266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VV39OAkRpCVAHLKUI3lU3BvBDLbvOa7qJKwdNWq/qLo=;
        b=LNteaX/L+A7wlIGmFAxlvRJaShq9jtlCsS7lt6LO3BAt07Nb19rEMQjRcCbK+Uam8B
         AzOj6bZyX0A1KQiqGpZHWYCmB10uu9k3eS+FBEcf8d71RhKk3zsQkwoij+2OQbtvxmKg
         xwJNF9rgsMOWKsDTUZWkAu5aK+9qfLiWBUDco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706223466; x=1706828266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VV39OAkRpCVAHLKUI3lU3BvBDLbvOa7qJKwdNWq/qLo=;
        b=Yoy4nFdcoATNsZG9mzRaauUXOWBIPEvo8oajvcvP2Dq94uQb2ZNYRjpp5942jZriFv
         dp+HUiDjqcUmDiYeyIn9A5OZYszERKrVsyF4qzX+LBOeCRWH990yV4Yyyf6LoH0aRXB7
         ok+K7AwmyNp62FyyS24m52lTms0e76tP6YNgtIxPLmFoQF7g2Y7gjV9DSNeTO9gCL8oq
         BbEpibDdrZlcRfvB3u/tlvTZhKzRMI7gU5On5sKZJ/0O2T/S6TrIagqmq0oxwjo5kraw
         HBbH6+W2i2QAkviL2Yswuw9FZYidlpZEf3joK/Kxkb0n3h9UBUX0v78CWVfYewHP+goA
         ZyXw==
X-Gm-Message-State: AOJu0YyvBGQDqpfzz98SNEJ14souTxYN1uawfLKRaDIDTT6qg1JYEM4p
	0/dDRNq8AcWoMew7uQNUD/FsqwNkJjoe+BIYEXwWB6C6kSsyq+TAYeb+Qwi6Cww=
X-Google-Smtp-Source: AGHT+IEBJKdnv/0PWa1kjfk6mL3RWJeaJjGcRTqPE4k+O8aLjsFMGw7r0OXSIIiMsItoxHdR43gtew==
X-Received: by 2002:a05:6359:4588:b0:176:6270:8cb6 with SMTP id no8-20020a056359458800b0017662708cb6mr549318rwb.25.1706223466122;
        Thu, 25 Jan 2024 14:57:46 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z24-20020a631918000000b005d68962e1a7sm19948pgl.24.2024.01.25.14.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:57:45 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	weiwan@google.com,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v3 1/3] eventpoll: support busy poll per epoll instance
Date: Thu, 25 Jan 2024 22:56:57 +0000
Message-Id: <20240125225704.12781-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125225704.12781-1-jdamato@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
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


