Return-Path: <linux-api+bounces-730-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363C8432F3
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 02:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B673B1F2552A
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 01:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0521859;
	Wed, 31 Jan 2024 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qtm/73JW"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13D55677
	for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665671; cv=none; b=pCrDs3mSM2bF4me/WImqBsBSWAf3xi2BeDk5pbmFJCBkBO/21K+GvjWsM7sLZ+npqNKu/GkRIpjA9f7QnohfvpCaYUZgKAGppbKVQ7DfQQbvgmYrWrjKucV0Drzf3F/VsMnqqFsJaAtPpWo1SYNuL0uYpJWeCqeWPTO+71+gmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665671; c=relaxed/simple;
	bh=+NvwukKrlDHz6eylGdtOKZKD8hFQLLmD1KnjinUcTaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HP6cOfAvwIyHEvPzurYyAYUlEGiVhPwOljIvwH3FlfTPvVo/ocs11khLzkZFQvPhP+g50vWB9wxZmVQMJGbUVrtu1EnY9Ui6098ZpKwYmmbkzPRgzPJWmgLEUCJDVSxS4RKcdUhxDUvq4mI0uIfTyIdD9oGLhjNeqtKIbTMuLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qtm/73JW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d73066880eso37005615ad.3
        for <linux-api@vger.kernel.org>; Tue, 30 Jan 2024 17:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706665668; x=1707270468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dis0Zk83NVRgFQ7j5PMchP4NSpK2O2E2OiTy+PShPHQ=;
        b=qtm/73JWx7S9OK0UV6TPJcE/rlOXvOveLlaD3eRlhDwbPAAuBPb/5a97Gluz6XwVSP
         A5rMWNs+JQiBtvpHVsyEXZnwnC/xP5BRqk+nJgzj2Ovgbj17EyjfHkueZzgmz+0gZb1D
         CLJYNVRys7ObuXJyvYu/F0W16yb0lgDTLw5kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706665668; x=1707270468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dis0Zk83NVRgFQ7j5PMchP4NSpK2O2E2OiTy+PShPHQ=;
        b=wxFT+pfURzp3D6ztBrnax+M1E3lFJCvBNvZc+nv9ZaV6BHfW5nRS6/mMHbIGVgtvwb
         9hGHlhrgPQ4+IeA88gsAVRqnWizZ6SNc+cmgyCkRR1i2TWg1BTmSnZM//hQRtNk1h4RA
         sEh2S+vu/k1dmOLTidNWQu4Wix2sZp3tZt7OpZJuW3helgQFYvaTGwLTXfG774U5sYCY
         1gVHkHeyOz0XgVFrEnBAMVJbTmkfeDs/aknXt+W04u3sbDvtGBDDOQplukastl0VGK9G
         u3fNbUk5LBwbGu7Pl1XEupPg9XfU3GsFYFd59vClx3caVtL/0dbuGzVnAV1fS/TKAJZ/
         f5IQ==
X-Gm-Message-State: AOJu0Yytvsha5Yu7Q6nmTsL1F6RfOrD42pvK+YjkEcq4RwLKiwkNusMV
	YzGw2QzW7Tz0cZXrYGsvsvecmpZxChKhBbJL0SfHJPkqs2q/tYrKpXiCodwyA/c=
X-Google-Smtp-Source: AGHT+IFv6d4ylemRg3/pDjnfS0aS5P4n48qcDQT6tqTQ/14aUrLUnInFu+mblYmjeGs82/P7TOII6w==
X-Received: by 2002:a17:902:bcc5:b0:1d6:fe15:b588 with SMTP id o5-20020a170902bcc500b001d6fe15b588mr324376pls.64.1706665668134;
        Tue, 30 Jan 2024 17:47:48 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id li6-20020a170903294600b001d90fe6da6esm1837846plb.305.2024.01.30.17.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:47:47 -0800 (PST)
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
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v4 2/3] eventpoll: Add per-epoll busy poll packet budget
Date: Wed, 31 Jan 2024 01:47:32 +0000
Message-Id: <20240131014738.469858-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131014738.469858-1-jdamato@fastly.com>
References: <20240131014738.469858-1-jdamato@fastly.com>
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


