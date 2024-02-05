Return-Path: <linux-api+bounces-846-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F884A846
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 22:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2A0B271A8
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 21:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9450F13D4EF;
	Mon,  5 Feb 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dANtzwMy"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691913C1E8
	for <linux-api@vger.kernel.org>; Mon,  5 Feb 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167108; cv=none; b=BRj1P8R20Kg2jvEHZDPzxTjKRsbgg/dnA73CBNqbYh+QzRy2ikJPQK8n/M4OlDBzThBmy4kDgX0YyJ30aJp+RGCl1VpCT+kC/dbp+tmqgHLg8TZzmkHrjDGgaTU9bItcC+IhJd9AnKP46teGI9mAsMrS2JBYgTuNTrncId61HSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167108; c=relaxed/simple;
	bh=NOwj8c7OsDBEwdIAq+Wisv12nzJJCvXJamRUTIa+OYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=saOgLSd0OUx+0xWUn8WTgid/9NpxPCOUVto9eXd9GhCUidFCIjaNhG1+Y8OLSX/PPSW9gb3HRs4nR+K4F01pT6OvpJ70UQ910fxxvMclWlgAr/T9ViPJbbhPxAGsh5Pswc2sB9ZNkG4syXgbs6sLH2QNPAIQ7ztTRNNvk0eBNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dANtzwMy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e02597a0afso1845176b3a.1
        for <linux-api@vger.kernel.org>; Mon, 05 Feb 2024 13:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707167106; x=1707771906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBiMdRH4c/8PwxTtqzx2lNrurPu3dag4D7tWOSrqvQs=;
        b=dANtzwMyTiUKYEANH6iYHxN5E0jb9AQ5LjPkqx9tb/WwixpwClUw6VoTkDuJaNBpDV
         2fpfCSzWssPdIfwKbcRhptpfxiPDz+meBnzSmtjl3ElbNumQQgI0iVh3baH2J8UpKDsG
         vRZquuT9hL2IYDkVA5UUvSxNb/gx7ocksAWcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707167106; x=1707771906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBiMdRH4c/8PwxTtqzx2lNrurPu3dag4D7tWOSrqvQs=;
        b=WL4/UEw2QmI9vmgYVZWJ/Y5sOhs5gM8eszg6DGtLfgrHJuDuU3T4pr4AZUhLCaEoXK
         5w+M2ivln2qPHYCI6eHG2a/Kgj6/rQQ9qRd/5OWmLtUFDLqv1BR+K48aaJgESlZGpmO1
         P07wn3I3epzETN9B1jTFtdeWEte449VKqSSdAY1gWxmtM5aSSbzWmXIEEIvMHz0My3ze
         f6StOD9/IDOwyvGZ+Cm/SnwhyITkJ6zGMSW/5arP+nImG9QXJbb+3MOLpsrh60o54KTA
         gm3C+x82v2hD3cJp3r75Lf8gh1t3nggHezvKGY/K5jSe3ilCmE930Q8glRqAYR969kLQ
         k8Zw==
X-Gm-Message-State: AOJu0Ywtx2Oh1flBfkB1t1jwPGGXHqnh8QCVvXug5NWCwfNCCvHyUqJk
	VuoZ1kf+MGRxSKo8CmNg16E78unIGzokCcki7V6LEM8hDk3Al5HNv3Oih40kGVM=
X-Google-Smtp-Source: AGHT+IF59+I3+vguGe8WjhRP5kzJgtOZW+SSHykKmm8E3FfjR4hiD41Jcsbe/NREAOuQqts4sloh6A==
X-Received: by 2002:aa7:8594:0:b0:6e0:540e:bf43 with SMTP id w20-20020aa78594000000b006e0540ebf43mr758751pfn.33.1707167106379;
        Mon, 05 Feb 2024 13:05:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzF9zYuQBn2HijFNy9BeuTMFAR7WgvA6hcwexP03WGZparkd2SO67O5nwT73blaBRwmKgp9CMzTYv1RygO4ui1u741WPf/e+T8MWehMrXCuGivTWb0RItzr6I3uBklkx2WDa5M1f8InQjbB2NxtMuR/0qvS+YCiH8rAEx1mdxFNwpka7oW8vepfEEOvlvHuigNK6SnBz2PjWghEer5NuRNd74fpkguMCTCUemQP+vlfKX3Wb6i1kCXSWmiSaBGxNfhTG51ZnAif5+Y83TY0QidlK1NsBlo+HM07Yqfs/m9X0NfOZN8EhuUEk2zy0qs/kf7hRZPuvz9KK2nFOOqgedzpFLcv3DjnX0GTKQE7sxy1hjVgLN2Q6Wag8adDx141gXXDTvNJtyFr83GIe8msd1a/jqv0QOJRnxkhqxyTAysvNbqAaT3EV8qBMNna0xAOtkQTubWIpVZlS+0mTWExW4JJONa96R1MQuMSTCHlIiJkIcVUFa9ZaA3zCkohSw02Oa0RTdlRiVz9Vo/dXNQj+65IdwTBjPFzsWetoXumMARjYeTMlrbi7I87QyKnKGXe4lcIka43IQtwGe27s0jT8ujI1mLYiQmrMVIvYoBIZTL18fjiN92dXTVzkLGl/M=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b006e03efbcb3esm315750pfq.73.2024.02.05.13.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:05:05 -0800 (PST)
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
Subject: [PATCH net-next v6 3/4] eventpoll: Add per-epoll prefer busy poll option
Date: Mon,  5 Feb 2024 21:04:48 +0000
Message-Id: <20240205210453.11301-4-jdamato@fastly.com>
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

When using epoll-based busy poll, the prefer_busy_poll option is hardcoded
to false. Users may want to enable prefer_busy_poll to be used in
conjunction with gro_flush_timeout and defer_hard_irqs_count to keep device
IRQs masked.

Other busy poll methods allow enabling or disabling prefer busy poll via
SO_PREFER_BUSY_POLL, but epoll-based busy polling uses a hardcoded value.

Fix this edge case by adding support for a per-epoll context
prefer_busy_poll option. The default is false, as it was hardcoded before
this change.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3985434df527..a69ee11682b9 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -231,6 +231,7 @@ struct eventpoll {
 	u64 busy_poll_usecs;
 	/* busy poll packet budget */
 	u16 busy_poll_budget;
+	bool prefer_busy_poll;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -440,13 +441,14 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 	u16 budget = READ_ONCE(ep->busy_poll_budget);
+	bool prefer_busy_poll = READ_ONCE(ep->prefer_busy_poll);
 
 	if (!budget)
 		budget = BUSY_POLL_BUDGET;
 
 	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
-		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
-			       budget);
+		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end,
+				ep, prefer_busy_poll, budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
@@ -2105,6 +2107,7 @@ static int do_epoll_create(int flags)
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs = 0;
 	ep->busy_poll_budget = 0;
+	ep->prefer_busy_poll = false;
 #endif
 	ep->file = file;
 	fd_install(fd, file);
-- 
2.25.1


