Return-Path: <linux-api+bounces-943-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C553E8528B5
	for <lists+linux-api@lfdr.de>; Tue, 13 Feb 2024 07:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC6F284722
	for <lists+linux-api@lfdr.de>; Tue, 13 Feb 2024 06:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2AF17576;
	Tue, 13 Feb 2024 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="L6sEy3AH"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415D14F75
	for <linux-api@vger.kernel.org>; Tue, 13 Feb 2024 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805024; cv=none; b=JxPDgfGglL6BSZ12nCdl33thApYNg6cpJkioX6kVUgKzW3EyIgU/3gE8HUOillGJyx1mon8k6cBoVSHu8wKqfSctQwHwZvd+8QqdRntIeic5ycqCp25OBK+yErrG31MFTatkfBNXCYRKfets7moRpWq/HcZ0XUpNgXk50CsAbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805024; c=relaxed/simple;
	bh=L4RwZXaFjOs7euXjMxwYiABkrXXZbZcKloyh3rbhzu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvtJyAZjyfBUDETDZqLGEgCQm0C2s7ZT/hyOiynJgtqoxufrpZGp/LAxUbPgEEWTwkZh+L5U7o1pOYnyedJBuEGCrQMIX5JB0hNBAjMXOo642YNV51QGtCxSo1IX8tP0zKJxevv/YIFjLuBn0RuBcXrTIkhLonQck9OzIkPky4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=L6sEy3AH; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e0f43074edso1890509a34.1
        for <linux-api@vger.kernel.org>; Mon, 12 Feb 2024 22:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707805022; x=1708409822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFThVNztewuogOwemulUSfgykwCuDZCM+kDTpLgPy0E=;
        b=L6sEy3AHB/9S1ETrXIdWeuDJTO+JItL1T8o3SFnZ4BKP4YiYwBRO37T/weSaBgPYhm
         YnVlQzuSsC9TTLPx1+OXMEASFzakzgHP6dAvRNAF426cdxfM5n8FUPQQ8PM94Qehbi8G
         KOZP76hVUY5LhIh5ExSs1xxMynX9QY3xhrz3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805022; x=1708409822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFThVNztewuogOwemulUSfgykwCuDZCM+kDTpLgPy0E=;
        b=CfZfJ+pP0TSW9EjgAzNu6pX2OFT+ZMnmx8Wp8X5D6LhbMmKcAztV8k0MdwlFaxesIH
         tv12XF7NVhAeU4qM193pHtYko/D+HyLPPsbEP0fCTvK93NlEJeyT3e58Bn8l22c4D6Y4
         hDW5n59JFNCaqhINvl95mvwk1DGWZzNlZ/xeu2nBzOGn/qT1BWe9eVXLXMlVM6OSA7cf
         S/YiVSmuRPV1ZLhtfA2HMVk64fyfz/usnAWbJixXyIH+0WlWmsweI/gPHGDPjJARcXoW
         x4awBnv+Wkt1FL8JbcKV1SgOFDhhTI735vfkMcQejeY0XYJ7zr+s6ROvannt5qXSt0f4
         4qqw==
X-Forwarded-Encrypted: i=1; AJvYcCXK9RWAUwAcjPUery3v+iwNIKPzgJE9wq1Jnhrh9xAHI6FgIgpdAfoKGXBPTYkmDF5r8Mra11UnaLvai3DXyx1r6RcMACKJFqMm
X-Gm-Message-State: AOJu0YyMiOXSJNiUHdYrAPwVAUqDBeoqDFZe2QAYwmFMJK3JBoa3LSNi
	C3+xVcs7dbmXlOCgum2vC+Vr8r1b51uppPz1UmGIhEX/YkEGwlFnfhiPMy+9Gx4=
X-Google-Smtp-Source: AGHT+IFVfWPZRbUE6r9Yo+YUSODrgsrUJRinzg6kpn6pQMTOnUE3+tSxFxwynr2J7Kcj+JX8vRKntQ==
X-Received: by 2002:a05:6830:1d54:b0:6e2:f1ce:4e88 with SMTP id p20-20020a0568301d5400b006e2f1ce4e88mr1965111oth.19.1707805022376;
        Mon, 12 Feb 2024 22:17:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYudH5/eqFbxhZ1hee68duq43gdfcl3tLV139OGz9rGgNuBXOhMoikoVe06ZLfc3dFF+s43Qx0hjnPO8pucyDy87wQCcQlRhWCz35HxPO/j+RWygD4yYXtpaPx4Ry+ENGYPR3CPJ4nXwnyppylY5YGFUCGsBx8jsV5vaRiLDcqmBexOI1QOv721rZxZ1DMDrvLnBfADBmQj8y7AWxcrPT2BAae2UZm9MgT57OUzg08Bpoig/7yjqVAr67cJoYvM0pkvmWBVPjtDRbZEVldDpc4wRAFKhdoAW69KcXlUxqHwKz28aeP1brgHx7bnggm8dbV7p2ou6y4ICaN9B1qZY3T+Oz/Ub1xuOWXj/ak+bIiTxLZj2uhqQ/z//l7/NBca1XZWp7adLGz9YFsacPO74y+4CpnIv3Q9NsYKc9aFuLMp6KRmdsqs1XcM4hAGW4PxL2FTf5u/TVpQQzenla9TIGqnms0q7AxBAGtEKfNJsH75WhhrROjOUIbthRqXHxZbRgh582zDFOEpAHrUQdjV0kfY+wh2sttc/xibp/6p4EVMsRPL2mfCAl2KBDc6EXfLntG06U6ivsUTG2u6Ao9qEJ4eIGSb4FmEe+tTx7EAp1ukNNH0JWWgbqgyb5ak7s=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id n19-20020a638f13000000b005dc87f5dfcfsm342936pgd.78.2024.02.12.22.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:17:01 -0800 (PST)
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
Subject: [PATCH net-next v8 2/4] eventpoll: Add per-epoll busy poll packet budget
Date: Tue, 13 Feb 2024 06:16:43 +0000
Message-Id: <20240213061652.6342-3-jdamato@fastly.com>
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


