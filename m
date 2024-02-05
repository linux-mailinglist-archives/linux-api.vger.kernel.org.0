Return-Path: <linux-api+bounces-845-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A94884A843
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 22:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FAC28F5D9
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 21:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649113C1D3;
	Mon,  5 Feb 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fKEmRb0U"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969C13BE95
	for <linux-api@vger.kernel.org>; Mon,  5 Feb 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167106; cv=none; b=hGLLU1WjbhbQizPX55+rraICGRntWNcYa+BnZ+2EhQ4MKDCzC5e2oaDM0wKMUjxjt5nwrjXsLTz3fPh6VKVHQeHUkFVxmuMc4o0Qe8HxeC2bdqmL/EyzESPFYCKuOD9F9znNTdAwWyARnJu0kCBsHSpvEGUwuzlCTuxfv6/9eb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167106; c=relaxed/simple;
	bh=+NvwukKrlDHz6eylGdtOKZKD8hFQLLmD1KnjinUcTaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PfkMwVVHPOPZHYOzuNn6+a1F6vlRYg5Xcu12H10tpCd/AivsQNX4byG+Nlm0f+OIKMx+TrAVIREnwI2gS67SjzfTI+krOOJy7qwMOBhsJsgDokUoC1BQ1sL+vc4fkUXVrwhATRdg2K58nD8oBlq5uaFgQy38LqgihN9JvcyiKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fKEmRb0U; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so3570096b3a.0
        for <linux-api@vger.kernel.org>; Mon, 05 Feb 2024 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707167104; x=1707771904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dis0Zk83NVRgFQ7j5PMchP4NSpK2O2E2OiTy+PShPHQ=;
        b=fKEmRb0UzhtVp0JQ8NPE8Nu+HOAPjAG3hq3TZ59qH5BWuUlO7T57l30gAyZKt0I78N
         /KVCinUWTW1V1w/CPrNKeq6NjggUecwxLP4eHJnRO6Gx4oySKg+57HefVME0hGpHrSd1
         eQ2aw0CRvdXMzq5GkAh1ok76X1L+KpApRN8Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707167104; x=1707771904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dis0Zk83NVRgFQ7j5PMchP4NSpK2O2E2OiTy+PShPHQ=;
        b=FTp0BPxAshppl7+2/WBTqLDDJDzbu8jya2dVtIYG2oeJD3bIujlhBi5usSUqK1kwLJ
         8GTRHu1asUduyEWLqMg2yqzBddBAkE73RQGHyGSqC+J3rgt3wfgk+Nq2Z4qxhBxtU9cw
         tgb/af6+93kgyIiAP5cvXbPp/22jFUUKXDSDUwVQnk/Wdm87JElh6VX2WBNKYlhuL2nT
         iZTCuWDSWr4YnBWnbrfwvv69Rth+fj0XfW5Cl9dZSZ56dY8k96hRMmOaByrBFmDkhwW/
         9FLCmxnb+YtbdaNcCyga9AboG1eLNx1bB+5B1h6fOKTF+r2K2v9aLwzwuP1pIijd8MwZ
         IbzA==
X-Gm-Message-State: AOJu0Yy7KM4sFfZ3kuId1v5JdcklElMTs6tl4+elxZioGjhq7bpIgUT+
	TTTnTZZQnc16uVXQei8S8UOrjOkROHGhs8xvRiL3Kdm2g4vcHbNsDMd5oFjkon+cVNw/HiHDgRU
	4Hs0=
X-Google-Smtp-Source: AGHT+IFJ4+OR+39oHGx05mb7rYjJ7noSEROls4REVzCMLwGu9fk14D4OkwieS1cILPpVXMwzy8c40w==
X-Received: by 2002:aa7:8a5a:0:b0:6e0:3789:1d22 with SMTP id n26-20020aa78a5a000000b006e037891d22mr745135pfa.0.1707167104127;
        Mon, 05 Feb 2024 13:05:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWPCDwj2puJ8K8VTtMqxLjenbVPTnlb5l/s9MSgpQcJSphuEfojDN2xQ8wceg7xxhwdKnqgzZXtjqGEqcSQsFx40TTvbDOLhtxqAEKF6qejocHfQY2QJIYVhoEjUonK+O/KLFB+NCqEynMVOXKCSgzUaaNqICkui8Dk0VLLDBToef3tPycqOHfdjnxJQDy4Zd4+pdVP64r1tXr9BYhfqgaKTdnG1n21Yioi1vEKrjFk3eK202MWrCGVEP8PxR2bwnt1KJvyTcL+0Q8+Y8DZxrd6q/3Uke4FjrpcFxN/NeZzHr2f1+HlZ2EAxYvLkSv/Rz92o2TCWNkMPgX1y+OLczHDhccHd40xIPOb92n7ESGN8HAW6KeDpkL+ITHQz0mKaRXAb199+dsfJoOnrLgchGTtQmudj9BvEjtySid47JSg2WY8bu7Cm8wxA985K15oylghCstmbjyvBufle8nb3PfLKYFJI6akjuxYH3xZopZ6/0iLUoy4zswlgCg7phxlLlJZdlSeiH04Y5r8s4e0RtTseBiQOzbh2/78nkbTElh9yhTwuGB6h38x7rluWpmKq305dmTbo4IpL8Lg7slKVW2WvqmIuOeHKbrQQSGbcX/LmHqyJ/M5LOhIGTykw8I=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b006e03efbcb3esm315750pfq.73.2024.02.05.13.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:05:03 -0800 (PST)
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
Subject: [PATCH net-next v6 2/4] eventpoll: Add per-epoll busy poll packet budget
Date: Mon,  5 Feb 2024 21:04:47 +0000
Message-Id: <20240205210453.11301-3-jdamato@fastly.com>
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
---
 fs/eventpoll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ce75189d46df..3985434df527 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -229,6 +229,8 @@ struct eventpoll {
 	unsigned int napi_id;
 	/* busy poll timeout */
 	u64 busy_poll_usecs;
+	/* busy poll packet budget */
+	u16 busy_poll_budget;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -437,10 +439,14 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
 static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
+	u16 budget = READ_ONCE(ep->busy_poll_budget);
+
+	if (!budget)
+		budget = BUSY_POLL_BUDGET;
 
 	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
-			       BUSY_POLL_BUDGET);
+			       budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
@@ -2098,6 +2104,7 @@ static int do_epoll_create(int flags)
 	}
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs = 0;
+	ep->busy_poll_budget = 0;
 #endif
 	ep->file = file;
 	fd_install(fd, file);
-- 
2.25.1


