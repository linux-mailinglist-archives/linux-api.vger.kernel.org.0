Return-Path: <linux-api+bounces-844-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC684A83E
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 22:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA5E1C281DD
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 21:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E113BE9D;
	Mon,  5 Feb 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Z9p1Typm"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308613B7AB
	for <linux-api@vger.kernel.org>; Mon,  5 Feb 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167104; cv=none; b=eMVQLNWEikKmB470tT+r+8KtEHbxHb2cQZ9O66TieuQL88xHb7kqodeAgdJtwEUVZZa+c91WpTszbHmZzQH3YTjrRVCLbkzT4nIp52IbYO+XnehRQUWa+PHqmDJ905VG0LvPfOGaoqF1obgwJa8sJaqQL3lzBKMjxUDmddkmLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167104; c=relaxed/simple;
	bh=gQDKvGU/ghxRMfcflvdwZ024OwvFboTrSVuhgGT5PSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWbhRhuM5mwET9smwbxNVgNkv/dtYHozQafY2G4ICWg8xrIJhsqHNDHXKF4rETUKcSETi7l+CDWXTt9FBKyAzjEM0NmUb1yPh38jAXjrSsVQ/MR6PDZ4S9aei89nP+9Q48MVnGJFyrLUNk0xy1B6X6URbh/HqJHHavsgIVTHKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Z9p1Typm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso619414b3a.0
        for <linux-api@vger.kernel.org>; Mon, 05 Feb 2024 13:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707167102; x=1707771902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//WWP3LIv7F69f9OvZE6kAJ/ncD/SOZi/tM1IcQuzWk=;
        b=Z9p1TypmZBncIk3hMD3ssbrfbGNvV//XFL3azhO5lzVQ3E3tzoSmMHONBmlisJZYiG
         ZMZiiGkgGSxZJjSft0H4/VdeUKNTyPmplMCthd9vrMGOs2hNYy8x5/AiCHv0h+h3s5jp
         7v9zjyEi+3j6DrJxYtAlokCirPCDmcZDz/T2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707167102; x=1707771902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//WWP3LIv7F69f9OvZE6kAJ/ncD/SOZi/tM1IcQuzWk=;
        b=qVOl9MvDT3VFmt8MYYZmbSPqYdRbty+3qNTJxIbgOc7fGUzfROjL/B3Z6iluRZ9ftr
         m7p+r8D7FHpqrRmiS7BgFovKbVQRM+dIRtcl2naMJNUMXWicF2OZPTVda396vxReuOFS
         oMlTCQ4oPrSIrBKNmlEll96BcuWeti6BIqrySjnV/hvs7oCY9dUhxvS3aBTIE4g67BHr
         78tegUbhmINNdQrf7R0mAwwmnHNW3YYRF7V5AgPSqDvBIxYOjzEUuL40ZB8CUp6bxMOw
         hguaoh5Lh4KqVemA4QP/sPX4i1C8xelxqFNUNkQsXUEZhVPObKMPTR3GpnseIi7gKsDQ
         3YqQ==
X-Gm-Message-State: AOJu0Yx9zj1v7qf6Kd0hAT0DaytaJyHbMKQfw3gO+NB/7Aj+8WKRn/DG
	2PBKG1EpbXm5SSUYKEvX50zkoM1V1UO5GTpjfdXqMdXfY3oqNBrFt83k9vF+4gw=
X-Google-Smtp-Source: AGHT+IGGPpScTLwYDVzDc0zc1eW3gIaxrebnnJTEJmL/cDQmZjF0qqfvEPqYHDHZJqzJ82rmQNqbbQ==
X-Received: by 2002:aa7:88d0:0:b0:6e0:405f:ef8d with SMTP id k16-20020aa788d0000000b006e0405fef8dmr5450050pff.8.1707167101863;
        Mon, 05 Feb 2024 13:05:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV0V7zW2Chf3BKlfYDuPfCvy127acHgLLl/mxXnRfIXqkHQCrQaQCPHdzazH8xfDSiXyKXxDAueYNvzI5Np8XwDPN9VFhyCsI/seiejAqnkBwWYlAIraIZTqvzT1jWdBJjgIYJg+S8qdc+J0padB7TRXlFeO4wU8oN/787VAdH9YX3HjMvC1iTU15fBaj57sOpTXPiLe0gaLgRk+Oyn0hCBygc8JUZPOQCQLCa58l9VRsWqlBWhy0ldc0/xQdKWLedO4A3GZgOAWY8FTZGYhutzcb++BPzwHk8tt509jQHGEA0E4smfPQBmWPK3b6zYUSjNCDkb7s/N0d/A5cTdU/6+/Zc84r4SFUUF7ey9P4dHQbE8oSxdo9/6grXe0IblW1hW28CRUI+KROaAQx2fKD0/BRNzFiShZRS6At7UG1y7RzCxXhEB00PPg4SkrBTf14nbukfvwi8OcCoP6cWk8gPxqPBdafgnzncvXql9bw48+qEi4/SC96wpgrucv6d6tr/9+lvtgLRAEVljlg7OP3N8l8kkGjbHSXTQQM2aSmzw8DrTZUMewHKF+EWZtdugy/VYyeJj7kJXH13ydUAmVmKgir3VjWEg4zW7FrKpSmujyLaJs5Iv9cLIZ4r7ccI=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b006e03efbcb3esm315750pfq.73.2024.02.05.13.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:05:01 -0800 (PST)
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
	David.Laight@ACULAB.COM,
	arnd@arndb.de,
	sdf@google.com,
	amritha.nambiar@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v6 1/4] eventpoll: support busy poll per epoll instance
Date: Mon,  5 Feb 2024 21:04:46 +0000
Message-Id: <20240205210453.11301-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205210453.11301-1-jdamato@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
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
index 3534d36a1474..ce75189d46df 100644
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
+	return !!ep->busy_poll_usecs || net_busy_loop_on();
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


