Return-Path: <linux-api+bounces-924-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696FB84FE9F
	for <lists+linux-api@lfdr.de>; Fri,  9 Feb 2024 22:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6136B2BE71
	for <lists+linux-api@lfdr.de>; Fri,  9 Feb 2024 21:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8FD39FDA;
	Fri,  9 Feb 2024 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="b+oKolW1"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B783987A
	for <linux-api@vger.kernel.org>; Fri,  9 Feb 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513350; cv=none; b=EhLlsGL2JXTk+nI/bIKgoT4meNB/6Rq7UWy3v//9RV6Sob05cni16KCgLad3GVY9f9OErPGj0+7sat0y4TSKWxEvGg1t6ivBO81iVKFC1vbjmHcqI4DngPceOYYqR7un3PIkjkGMLqyad1S6L/MM3Y2wr0n/Rl2WgA0ev3LZ4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513350; c=relaxed/simple;
	bh=L4RwZXaFjOs7euXjMxwYiABkrXXZbZcKloyh3rbhzu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6BB34qGvURvX2iy6AyA+wdrE3LUBNmVoq8cpJPiqmQfVyBHZEy2EAXhrMxVscG4TtJ3DOnNA328oirvSYQk/T6z0hN/VD4x2vgmsqnRSUmdbZqjDanl1SLcIzVtwDEypvbnVBvQR/CBjsEVFrilWk8HkWnTLJt4/7JC7gAMtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=b+oKolW1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0a5472e7cso4507b3a.2
        for <linux-api@vger.kernel.org>; Fri, 09 Feb 2024 13:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707513348; x=1708118148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFThVNztewuogOwemulUSfgykwCuDZCM+kDTpLgPy0E=;
        b=b+oKolW1DTy82nN0oHPSubUTCq0lfavtXVbB+bq7BhtLyG5UQz2/UGVrWFoqxLXtXZ
         dVRnG/xGHm/t8rC6wEND/pRFlk4EvZLpzlsB3pJmN3pukc4dAwBYqSP8jIr99g7Olovb
         5lzKrpzLmclX6vrZj38Tco/LFCzUmVtqNHkfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513348; x=1708118148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFThVNztewuogOwemulUSfgykwCuDZCM+kDTpLgPy0E=;
        b=eRRC0A8PsXIn6ptdh9JAKcEnqAS7p5nDs96rD+7j1o5eCmfXNvbpaFmokY3YnJgqZE
         7lPdFcprC/yKnqPIYsldjG/IvB8o45YUBds9NgRHHv+zL1dXAZzDSnpyoR6UbRTSI/nv
         eGBz1lfZI31+xsLmeoQ+3pBHth9Y1sIJy9+Q6lJDa+CJomKzfx27k/wqxdkHj0O0H+QO
         U90QROfc1YSdJZSjQJbf50f9p6KBLxJUVAmbtpK1fmIsb80JIWQi9Z9ysFDvFLVrvTYg
         Y+cRXT1AVsnnEsLh2cKRwutXUObJVJE/xLYmXa9zdxijOI5ixGGkQjlhKldHRzhgHUfb
         KxYw==
X-Forwarded-Encrypted: i=1; AJvYcCXoRdfo9hj7NyfDE3nH1GjQoZU1Ms1R0RQzBbWUTkVRP5j9y9DdQTBPmgpAUUB1EbF/lU3eZcai167GG7kDhontLZWX8hmXRPJh
X-Gm-Message-State: AOJu0YzamABAXbyRdJBz0OQ+xra0b5yllwuq6QxZOVyHC4V07Y0NMlw3
	UertYx8oOuvBXo23nUPGUS1B2++V646AFcQO4F1FjcyoakoV3dtZMZzw2Oad3Vk=
X-Google-Smtp-Source: AGHT+IHBtWZUAFvJ7g8Am1KSc4m3iLUyccIs9HN9bZVz88EdQc9f018q6t7kU5QG9vMdtqZXX3RafA==
X-Received: by 2002:a05:6a20:d708:b0:19c:8d73:721e with SMTP id iz8-20020a056a20d70800b0019c8d73721emr464952pzb.36.1707513347879;
        Fri, 09 Feb 2024 13:15:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdfNV3zIRMqCFWm0pUC8hu56lzq0vEgBCLGbtY0asu7ymZ5imx6EuZrSCehX/vvQ8oqWC6oUjGT+11xrnw2ltOPIfx0BIPn9mTkH3XYri9Y4KwD9wFMlJxRkPFBBcOUb7GxFHqJRwHwwkUc286hkZznY+jNz1pSnmV74R9Kv3uv+DskkGQvb2XrOU+AtdzbMwdVM970wFrPdGDXbeNfsY1KkeDRZL2iONNd75Q18hZhliWAZsjdRFiDV2z3qEh2Sm1keYNhjbpAYwb+wCXbTwMnbYvZhq+6njlY8t0iTq+EAaaUaq2Drpc+Sb0zwS6FPNBNVFXr570xg7UPO+pPusZj3GSrjKB/Dpr0eNDdQ0BKl0BF7l6CzXd5b9anDK/ltX3YwdBp8r8bdIs1M5TNd1E24E9RicTb7jvvmDgL51zokAZzyzqyUhz3Qvu7Qs0x0KjL+8L1PCUYwBkh0whJK1UTAt3iJXUjxzhP5T1sGJlqJ+djLuJGYx05CE6B+dOhdxGV0/vHZ3prPDyNTtUcrIfrX+mNXG1G5KmREXRS40SyQOzcumij41wqEK/HkeXUXPF9GUZeGUDLlklma/nmL3I1IBFeGTrC2y53gyOLsmEBfPSw87XKwJPdDFTgEU=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79197000000b006e05c801748sm969629pfa.199.2024.02.09.13.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:15:47 -0800 (PST)
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
Subject: [PATCH net-next v7 2/4] eventpoll: Add per-epoll busy poll packet budget
Date: Fri,  9 Feb 2024 21:15:22 +0000
Message-Id: <20240209211528.51234-3-jdamato@fastly.com>
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

When using epoll-based busy poll, the packet budget is hardcoded to
BUSY_POLL_BUDGET (8). Users may desire larger busy poll budgets, which
can potentially increase throughput when busy polling under high network
load.

Other busy poll methods allow setting the busy poll budget via
SO_BUSY_POLL_BUDGET, but epoll-based busy polling uses a hardcoded
value.

Fix this edge case by adding support for a per-epoll context busy poll
packet budget. If not specified, the default value (BUSY_POLL_BUDGET) is
used.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 fs/eventpoll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 401f865eced9..ed83ae33dd45 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -229,6 +229,8 @@ struct eventpoll {
 	unsigned int napi_id;
 	/* busy poll timeout */
 	u32 busy_poll_usecs;
+	/* busy poll packet budget */
+	u16 busy_poll_budget;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -435,10 +437,14 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
 static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
+	u16 budget = READ_ONCE(ep->busy_poll_budget);
+
+	if (!budget)
+		budget = BUSY_POLL_BUDGET;
 
 	if (napi_id >= MIN_NAPI_ID && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
-			       BUSY_POLL_BUDGET);
+			       budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
@@ -2091,6 +2097,7 @@ static int do_epoll_create(int flags)
 	}
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs = 0;
+	ep->busy_poll_budget = 0;
 #endif
 	ep->file = file;
 	fd_install(fd, file);
-- 
2.25.1


