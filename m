Return-Path: <linux-api+bounces-778-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE88446D4
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 19:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101D11C212A9
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105DA13AA2D;
	Wed, 31 Jan 2024 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KnHVwhWv"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29A1386A6
	for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724583; cv=none; b=YGYuO/xQIQSM64XmvthIoRL5p1vDiR0WJcZ5SntcngG90GnWqpEXEAvnjJZ7xVoOkACPlntUgvvyz5jr4+SGFcV4fOAPO/rk5DYA7NmW5Y+0XrEiGsxUkYfW9w7ZakfS9L3PFdHM8232TNBMxqlmastG+EVFVQkhc5FjrKBCl+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724583; c=relaxed/simple;
	bh=+NvwukKrlDHz6eylGdtOKZKD8hFQLLmD1KnjinUcTaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnu+uQ/WDx+flwoPk03E2KJcuxp5Rbb5iwE6QHSoIICwdKoIRFk7TMEXnwxK1c5sk1xHwqnNPx3Elvs4bIY6603ufze96roi4fQ/tSIM90IpOWdZs11Ufm0No5GYs+58j3ZnfQCtDrzgHJk7xiAxnJ6aBWgkQiS3MTzhrLn2GaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KnHVwhWv; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59a27fbe832so41798eaf.3
        for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706724580; x=1707329380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dis0Zk83NVRgFQ7j5PMchP4NSpK2O2E2OiTy+PShPHQ=;
        b=KnHVwhWvgJevhVlcnikP7QUDjrpfFLbgEZhFUoIjHIFCR/MNbfMrJXrQ4IkSM5TrqK
         2UDPfy1N3PUya8cOMl+64EFU1OoCdR0ueVBFh3poG/6pfowuA0LDBbpd2CEe4mxyO5Ik
         4vT9JFBioIWaYPE9QI3DKf+tA05SI0ri3vzZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724580; x=1707329380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dis0Zk83NVRgFQ7j5PMchP4NSpK2O2E2OiTy+PShPHQ=;
        b=GiUguZzwPxh1ZyPfB5E0nXSRoigrsOlyDRbKn9JHxj7e6N4U3sDP15frs6O099GJHN
         2ovuwrLHZOntfq4m+Xev+9627H1RmSOM182C5spXKMMc2vSBVp1fwKG+8SG1B0mtlYxc
         3O49IDNZ34AI19APnMHV79H24UNKP8JkJxyVmUMdVQEt1Qoyhb7tpyxcsbioQzpjk7Fz
         L6dZCNTBue7+Gjwao2G9vOsrpVGMtZUaYgq0m9hy38UDF9U8i4r75aAgyWCy7Y8mZb3n
         TLqQgacQwYPj+GhxPBRlWmojRBRfrG0p1e4t9EvQirxHSLBQyABVTIpG+LUKZELR2vn0
         LPQA==
X-Gm-Message-State: AOJu0YxqDrHbtNXaM7hFfNYuiIuZBlxEDmpXgTEgixoiymml4dx3qigZ
	+wcoDsl0G8KSsLNAfGUvrzQ89nSjaqm/12WwZFMm4QCvRxEPqeTrbcK9LAsIS+c=
X-Google-Smtp-Source: AGHT+IE3WSCEhFcdCAfWNl58ynuO3Wg26xmq2qCV3dHWjIH6sZZ7QtfQiNgztoOEGf9zo7iiBN0/rw==
X-Received: by 2002:a05:6358:4b4b:b0:176:915a:c7b7 with SMTP id ks11-20020a0563584b4b00b00176915ac7b7mr32979rwc.31.1706724580488;
        Wed, 31 Jan 2024 10:09:40 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id v24-20020a634818000000b005cfbf96c733sm10876004pga.30.2024.01.31.10.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:09:40 -0800 (PST)
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
Subject: [PATCH net-next v5 2/3] eventpoll: Add per-epoll busy poll packet budget
Date: Wed, 31 Jan 2024 18:08:04 +0000
Message-Id: <20240131180811.23566-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131180811.23566-1-jdamato@fastly.com>
References: <20240131180811.23566-1-jdamato@fastly.com>
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


