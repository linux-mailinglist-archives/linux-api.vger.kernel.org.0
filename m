Return-Path: <linux-api+bounces-925-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C849384FEA2
	for <lists+linux-api@lfdr.de>; Fri,  9 Feb 2024 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629F528824D
	for <lists+linux-api@lfdr.de>; Fri,  9 Feb 2024 21:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF623A29A;
	Fri,  9 Feb 2024 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tG2UUo5K"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F63987A
	for <linux-api@vger.kernel.org>; Fri,  9 Feb 2024 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513352; cv=none; b=b+90yA4a1aKfg8tLvvS3jLmSkFjXrq0cOqizppuEj7fTYBA7JXkuSdL5eDFMCoCSYWr68INsMg8+E5MYO4kpTs3Q+nu1nMCzT8h4XlHSWMDlR3t7NNNf/zuH00A4zkCMeOPZWX2NIAhhEMF2cUWX/P5WWnL9zUatf2o47Cz9kwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513352; c=relaxed/simple;
	bh=CJVUUyQixO3GY5CVmRJIGygCqjREOllOxrIr3Eh94fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvpoxNgr1VwZWcYTrFV0ZzZWAHJ/fTqOGtkIq8BLTUeQJgAITuAVrOoRVlK37/9kyf0i27eDxTg1FAG67si/qiu35NnfrfQuys8vvCrSbjvGywn25mzf6RJInNZC345itTv8FOmb3ScLpPK77bNWnqbsg8F5UWQagwQRyjeiGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tG2UUo5K; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e06bc288d2so1000733b3a.2
        for <linux-api@vger.kernel.org>; Fri, 09 Feb 2024 13:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707513350; x=1708118150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0NsVP2+DJYJlYo79AHfvXsFPLMqC3dLNa8zH3nE+As=;
        b=tG2UUo5Kpulb48owiZcJFB8pxTuNhFU9SFG3y6Pp2+m3iTqxdP0TNvApcT4I8+TCqd
         g46fYzuQUTpOtXqJJQuOh1qkYpoEarnlL0Fna8bntuGSxxCWfXSbQkAY4Ft4wi+GltSY
         VWO9pMWohX3ut8JEMS147DOZyzh0Q4/O3Y8UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513350; x=1708118150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0NsVP2+DJYJlYo79AHfvXsFPLMqC3dLNa8zH3nE+As=;
        b=sY1FRST2ZLkogqTpsu8DSJHuJjdvusA21MTPm6WGvr0ByTHuM//C3TM0Ey0xuQo/BX
         m19zu7oZzbs0SSkwsKZj1qxiS4qSkuSxcKHvO4sno7FqE9l6aKgbh21vwKgydNsz+Zsy
         UcZuzao82d/YdGcijBZIpWl8by2IR6AG5Z8oU14iapR8Hhq8m2dn2ku0DlonvVD6rc5Y
         B8dx8wnf/mjmzHSMEbPgkc+c58d2H8TRFMkWEySJnByk62Tr3k0aEeKeJjT3oqpKTGrA
         4dPuKgFj8sn7nr3ROiRMYpSUU6OsehSBbwWn+eYOAuXaEG2UYvMLwaqZTRmR8+1MkiCI
         OlZA==
X-Gm-Message-State: AOJu0YyVypUpNrHlw1G1NSg/OJcWENzixVbrer8UfQ4xi0BNcmXzk7B1
	+HexO+1OYugOqdSEbnOvj5FuDsnWlGc703/pOfMcRQNk1MJ7Lk3j0XgwDizN/pA=
X-Google-Smtp-Source: AGHT+IHmI8QI8C638ZR26XV9GPNEC+m5Z+umS8LHYW+HhCSIZuRwIB9zWgAYwasbnTt3KHpB3AETcQ==
X-Received: by 2002:a05:6a20:9c99:b0:19e:9a59:20df with SMTP id mj25-20020a056a209c9900b0019e9a5920dfmr417488pzb.9.1707513349972;
        Fri, 09 Feb 2024 13:15:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNGCpYwEjdWOp9Af1u8tW2O5xfC8VpboIT36q3QoQQ0xH8ctFz596nOAMoJ6F9eyhTK4CEvJ51uFuMx4RHYRgPLExDttotnTGSfTdhT23/b36g8AFG7+uss8UnzMKMa53LRAHzowhtf0al3hzyCvrkY11h/lWzYIPynIHTbIN6G5UcjMAIPlzOVTX095Co2AVRH9cDkWKI8/1rFzGFHNlXbp85kHT81yA+mrIfbgPMAMw+U1nAeAtmV5ebnFKXhLt/PI9r5tcZhGMuVg1ZfywC+HV8IxiRKzPV/lxrB8MPOR8HgvmRPf2u0u/QI5ISX9m31W8z6zinbpMD8h2Hb4jl7zx3p4ZPGSM7XSYfzsXJNLqAmY9wa0hkB+0hnDhEMgvImlirN4gAJGlPng+ARn+AZpzmpIk4WS++qFSfmnCroCn4gOE4F+T2RUvPsGLi+7fMs3YNc5Z747JAwSsALvsjuGQ1fvuK/rQO4ph0xMzubDjDQzWiPoXGGnNdIa7pyamFRUmN5+5V2DdYXB7H1i20ZEHsDOqik5LK4JATJ3l08TuBrqHTaHawQ8+MnQomcrLFsBX9LzSWPMf7UK9UZzaVwSRWUnGTI+hnps+26D5KUGMH5xl8Lr3OSaL/c/Q=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79197000000b006e05c801748sm969629pfa.199.2024.02.09.13.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:15:49 -0800 (PST)
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
Subject: [PATCH net-next v7 3/4] eventpoll: Add per-epoll prefer busy poll option
Date: Fri,  9 Feb 2024 21:15:23 +0000
Message-Id: <20240209211528.51234-4-jdamato@fastly.com>
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
Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 fs/eventpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ed83ae33dd45..1b8d01af0c2c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -231,6 +231,7 @@ struct eventpoll {
 	u32 busy_poll_usecs;
 	/* busy poll packet budget */
 	u16 busy_poll_budget;
+	bool prefer_busy_poll;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -438,13 +439,14 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 	u16 budget = READ_ONCE(ep->busy_poll_budget);
+	bool prefer_busy_poll = READ_ONCE(ep->prefer_busy_poll);
 
 	if (!budget)
 		budget = BUSY_POLL_BUDGET;
 
 	if (napi_id >= MIN_NAPI_ID && ep_busy_loop_on(ep)) {
-		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
-			       budget);
+		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end,
+			       ep, prefer_busy_poll, budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
@@ -2098,6 +2100,7 @@ static int do_epoll_create(int flags)
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs = 0;
 	ep->busy_poll_budget = 0;
+	ep->prefer_busy_poll = false;
 #endif
 	ep->file = file;
 	fd_install(fd, file);
-- 
2.25.1


