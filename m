Return-Path: <linux-api+bounces-923-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29C84FE98
	for <lists+linux-api@lfdr.de>; Fri,  9 Feb 2024 22:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222BD282BFF
	for <lists+linux-api@lfdr.de>; Fri,  9 Feb 2024 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B4B39AC7;
	Fri,  9 Feb 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tYT0zxyG"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55E39870
	for <linux-api@vger.kernel.org>; Fri,  9 Feb 2024 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513348; cv=none; b=AnYi7rrX6F9LOlTK72XochpILnK4cO709WIuyZqQ7iV+Mr+jc2cVcXO7aOAeA0Zw2hQQuKoXUDQR00jkpKEkIYwZQtrId76ZGYNZWgeEeHw3B5qkgradtdmAh1+I7CVMWr/lYURUtM8EsVcc8KklHEuzsQeI/8HkptKRLDM0pYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513348; c=relaxed/simple;
	bh=HZCLTuMgp/ckUlZ/e4J3shoTAMuEzpAwMA7BLa/9RiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuWXh5r3h/rqBIkJ7RbSzJHf66dJNkBN/25ephAkLDLN8h4pM74Owy70+VJSrJwiJxIA7wPHk0gG48LY8wGn/q91EPEDZpIShbLxD/2RdT4XxybG/aoAaDwpUZZDkO/+p/DwGV9bhtGGNAvnGYQknNKdCRWqNrC+22oTW3868nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tYT0zxyG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da202aa138so1013177b3a.2
        for <linux-api@vger.kernel.org>; Fri, 09 Feb 2024 13:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707513346; x=1708118146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnWe3jITTYQxWO7n4MTzpSC6BAe+szTuzlwikAcSvaM=;
        b=tYT0zxyGQALoutYHNBNhO5y5dZYLx2lgv1nqXnhIWkc76+UlnmfM6Fw9th4ZlAfatK
         xjzvDb4YzqRsFZvnvGncRJIIRKiawlyOdOoAwQ36Q4/yDxaHK0fgoUTreOygNbeLrH8q
         LArkw7y/XuC5RNRUWgP6M94Yg6jVPxr/lsCx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513346; x=1708118146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnWe3jITTYQxWO7n4MTzpSC6BAe+szTuzlwikAcSvaM=;
        b=W7O8yhxqgf1m13xrLxXHIY7FttGYiU35GUSJvdNwaBeilVssBL+ZavAXnLJwYqNTzx
         ZnFUd1b9EzW5E1+17AxMcO8g6tzBkHsa9U7zSdUzHoznDEOLVPNrpr8905p8Fk7vyGFk
         tAGT8uWhc9w42/5v1L1LUFayC44TJ8LpBiRWULa+2fJYlbEONkdrTmKp9Pfbev4e5O9P
         lhhaP23Kid6DXyHUG5yvCCZ1AkckHDQvmaJMnxyR5xTrTCeste777WeHvt+rqEIoJl2T
         Qwjpy6+/MiRk9TJLjDkdooFFuoOrY7CqE6PMlLR87eRw7Cdr0Y1f9pYqEudfxmkR0Ue7
         iAIA==
X-Forwarded-Encrypted: i=1; AJvYcCUcYd7Sn319Kf+m42KC44naYfMG81a9/pUZvr+AypZ7837Wp1TN711PGSoNi8MQBprs6iRQD2BVu3gyN3uBCmH1rbbYdQA7Gmsu
X-Gm-Message-State: AOJu0YymOhvdpcFiZu0UNOL7qfdFMOC5IFWX2B/IPiMIhjs8JM0rlfaa
	9o++VZ+kkmDBIH/F3U/HJ8/hQ8YlpLTE/dudvK2QkSchekindUCdD/zUlB+ol9c=
X-Google-Smtp-Source: AGHT+IHrROXaC1T16mcElSwIXy7NMQMX/oEKLGAhaBXmlPXFeLNe23PLKNuB+mrTVCPIHPRvrmdang==
X-Received: by 2002:aa7:8d0a:0:b0:6de:1e25:48e8 with SMTP id j10-20020aa78d0a000000b006de1e2548e8mr469606pfe.14.1707513345615;
        Fri, 09 Feb 2024 13:15:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZBSIfqNr68Owgav3RM3Xfph+ZAAxDrRGFRBDiw8MjSKXZJGtj8MF123MizOhU5Ok4S26YLAEomcDdR/fLxX0F+Z2siGroZptJ3px9fyzb50dnPIweDBnDdI5dkSY206V4FwgAihNo45vggdOuRM1dtVZtH4SO/wwTOsaGS7bhkx27e6C7Qjcx6+uF3eHNAkovl5ar26Cwo+E00/yAdpta9p6ILwwBfoC5Kd92oYw7KteYRqTngPeaTMRvPKExkG+apB00MviiOYjI1VOA6Kdz4c7WQv0c6eiwjQEqj1QZesDy/ASWH0as8V4jG9pxu1pXnJIazZwnYk1YoebWQjA/fzsBfJbMXYLNDBGgVAJ/seeLAtx+q6GztNJuFQ5aLv+4mjQ80NfN53enwBjgPQIAtoR6NVoyvKjdS+cQ1Ca64JGBZXvUlgx/YsF8nMIicKtIY6wjmxQaDG8wR/3LUP0xT4evp7XTND4o9KuqQv2p2OXrfX3bbPoOj480fWHEZBkHI+rMkCdp6uzEkJ5eTr2WXt0Jup+sOHeDBBbSO6cHWSOhuhILEjJ656tSmWaP0acDFOKHFEDyQCgTLl92MAuGKRA2l8GzcYn/pdICo1TXSWeAn5kW69X7xLF8PSw=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79197000000b006e05c801748sm969629pfa.199.2024.02.09.13.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:15:45 -0800 (PST)
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
Subject: [PATCH net-next v7 1/4] eventpoll: support busy poll per epoll instance
Date: Fri,  9 Feb 2024 21:15:21 +0000
Message-Id: <20240209211528.51234-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209211528.51234-1-jdamato@fastly.com>
References: <20240209211528.51234-1-jdamato@fastly.com>
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

busy_poll_usecs is a u32, but in a follow up patch the ioctl provided to
the user only allows setting a value from 0 to S32_MAX.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
---
 fs/eventpoll.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3534d36a1474..401f865eced9 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -227,6 +227,8 @@ struct eventpoll {
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
 	unsigned int napi_id;
+	/* busy poll timeout */
+	u32 busy_poll_usecs;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -387,11 +389,41 @@ static inline int ep_events_available(struct eventpoll *ep)
 }
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
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
+static bool busy_loop_ep_timeout(unsigned long start_time,
+				 struct eventpoll *ep)
+{
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
+}
+
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
@@ -404,7 +436,7 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 
-	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on()) {
+	if (napi_id >= MIN_NAPI_ID && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
 			       BUSY_POLL_BUDGET);
 		if (ep_events_available(ep))
@@ -425,12 +457,12 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
  */
 static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 {
-	struct eventpoll *ep;
+	struct eventpoll *ep = epi->ep;
 	unsigned int napi_id;
 	struct socket *sock;
 	struct sock *sk;
 
-	if (!net_busy_loop_on())
+	if (!ep_busy_loop_on(ep))
 		return;
 
 	sock = sock_from_file(epi->ffd.file);
@@ -442,7 +474,6 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 		return;
 
 	napi_id = READ_ONCE(sk->sk_napi_id);
-	ep = epi->ep;
 
 	/* Non-NAPI IDs can be rejected
 	 *	or
@@ -2058,6 +2089,9 @@ static int do_epoll_create(int flags)
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


