Return-Path: <linux-api+bounces-942-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515F8528B3
	for <lists+linux-api@lfdr.de>; Tue, 13 Feb 2024 07:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E761C22888
	for <lists+linux-api@lfdr.de>; Tue, 13 Feb 2024 06:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A817562;
	Tue, 13 Feb 2024 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="V4tUlKDt"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49325134CB
	for <linux-api@vger.kernel.org>; Tue, 13 Feb 2024 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805024; cv=none; b=rIlxdzFm8315k+2xTYC5xL18oMS0p6sRN27AdUSvTR70Tr+bxsgC+p4opa+G+KTLUaOWviLqkt4Fnft3mChNGcB4DkymQreOA1zh6ZmapWJi3RCKnrxhB5qKRoJntlGZ2mbtjAzkZBgzYuI9jWCCPgQXx2NEVt37luwsmgGQtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805024; c=relaxed/simple;
	bh=+BdDiZtulZrbvLpADjlE62DUPuOp3KejqJWNkuE2SMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVCItLsLGRPx3MZcdIGPXe76q5s788WfRwEslpgPg57cU827SHfv4NPsn4HRiamPmSyUWEENg0GCJP2A6J6b1OKeKIhynnnsitv/7ZTHGnenZefT7Z9to3XeW0beWGpdk6GFlqFBJb6oIuuGoWZiOm9on4HilAUjHYrYHF9nr9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=V4tUlKDt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e0a4823881so1397274b3a.0
        for <linux-api@vger.kernel.org>; Mon, 12 Feb 2024 22:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707805020; x=1708409820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWK7Tcl4v78WKhBmDih4hp4aKoxAkEp5jIDo2VrMgEA=;
        b=V4tUlKDtNG5nDcAVYnEBlnYWOg1iCN64lyuhme3cICIR1UcXjoVt/fCCOWn9ZkKsrM
         +OXcUk7ZlLq4QByOlywAFy5AvXdM/mr+I/R5IZg6BkhvtHOrt4fhVOPrI9+ehJQumqOk
         K3C173ell5/3VM6iH+r5fFz65o1kDHq4l3w8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805020; x=1708409820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWK7Tcl4v78WKhBmDih4hp4aKoxAkEp5jIDo2VrMgEA=;
        b=aTzG1TU+PuvqtQOEhNsKyR9MyK6hRj015BzmhKNnefyPBkOY/0OIIGsySnOpOHni1m
         4aWmmlhSDjkumAmeYX9OTjCA9udUYUqvDWo4L8bPsxTvnaBfYTyDSJOa7m3lPRbjouaN
         19MLyKteWrsf42ZC2Nr4fgHhvO+eGUmo9U23vMeiZ60WTD2WScGyE2JbnXzXkUDuHGAU
         9YdyLz+9G3TMsB6Qj+Tu5Ov+f3Kqau5hM2UvbVVsV75HFGPuh3D4orJfBUaHkRMbKrW7
         9t5QMzpM7j+UHSuaJseGKXqLjk3hOFfVyQfh9689isMeQ5vdwIYNVVWDXsSIMZJICWn+
         7+gg==
X-Forwarded-Encrypted: i=1; AJvYcCUP/ZhumXnYtZWTqCXpKI0P+rhMSj2bXNlfbpzjLFmil/Fl4RT/FZk3HiW4ov0VM20j3Qf8w7Uabo7U8WXfLus6UaDJY5+0eiQq
X-Gm-Message-State: AOJu0Yw7v9XO0USYQIP0kSwYDqZSqf4ExVZWBYijxTPhYQ7VBYIVsoOE
	qjx3z965uY4y2QpjbIFqbqux09N+ge5MXJahtCwMlPk25+1D36kUO9qdRizZb+M=
X-Google-Smtp-Source: AGHT+IFA7EAAn3meKC9yNTCZGB0U0AKSVSGB9K2EIMouJRX02mBckAKZdErIH3xk401Zifh9l4gNXg==
X-Received: by 2002:a05:6a00:bc6:b0:6e0:99d6:490 with SMTP id x6-20020a056a000bc600b006e099d60490mr7327725pfu.21.1707805020617;
        Mon, 12 Feb 2024 22:17:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmL7Vz3PAAYJ2YuBcOicTcHD7G3MPIBgpPVxgOqWx57ckQb0LQsp+zo+1xBYVJvVxX1xnFMSlslqEurFjhd8BN1Ask2EQZc6mdjdKDIMOrD2H0lpbgk0puZwOgN13OsNWKlrdGSpZQkn99PMb/TF7Oj1g/IwqZQq5GO+n3XY6NDDlRAtv12zlRd0iJIDQMrq7FkJSptx6nz6yJAAagghDmHZIA9mwS4SqtRXSu3uJqtwLYyikPd5fzSj0z4vZx78G9/mykhCZyiEGpwlQkKn63Jis6NDCbIJxOJsjVE0w5tj5tfF91tqmc3P213LPGsFXADlJRzdIJB//0Ulx206ft3k7pQWfiWaGLP5U4RECb/+vlQxJkkviTJuDmWX7O1JcYb4w5gdEt7RG4FG9CSrJ3JD7sSFtfiPLmpmKlPamtwsXW6cFbL/F06xzeuX0PLxAxn1O16eKif/KlZfe/lU/gZQfwRBIMdKexiAyTmgInf0DAvzL142wZqKm6vdLgmm4VbYXpnlpgP8utTiAXPZAKZzb2dnMUxVKYLzCP62FKYAYD0md7sF9dz4n2FLx1qDWBzGhXgJhHpdvg65qvOan1XyFJTk5wI0x9FBMjuUvRwkjUb2YMyMNjTcY9t34=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id n19-20020a638f13000000b005dc87f5dfcfsm342936pgd.78.2024.02.12.22.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:17:00 -0800 (PST)
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
Subject: [PATCH net-next v8 1/4] eventpoll: support busy poll per epoll instance
Date: Tue, 13 Feb 2024 06:16:42 +0000
Message-Id: <20240213061652.6342-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240213061652.6342-1-jdamato@fastly.com>
References: <20240213061652.6342-1-jdamato@fastly.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


