Return-Path: <linux-api+bounces-604-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F41F839FB0
	for <lists+linux-api@lfdr.de>; Wed, 24 Jan 2024 03:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF01284F36
	for <lists+linux-api@lfdr.de>; Wed, 24 Jan 2024 02:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B217572;
	Wed, 24 Jan 2024 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tH9zr1wY"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C017546
	for <linux-api@vger.kernel.org>; Wed, 24 Jan 2024 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064869; cv=none; b=QdpAvyoen9jrkByKEp8WrSbJcjxKylQroRJMSD9ZxZ4frgRZXyWjYXnFiTeEsrzqgdi/OSuAUoulTIPij+jHmyR133bTtx6Gx5+RhaKqZbKNxv3WvUJ3nlFUYVp5lV5wVLV3nmgSs39BhmDovsH5nCv5nV1OcEzFe/qnVRz4VKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064869; c=relaxed/simple;
	bh=tt8whk6QkKHecHFyCKI/nRn5ZBU9W9pAuOHdt0se2xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhihqm79EcwVNnCbylNd7kk82zYoU49m8ReGeqQm+uOkEgj7Hq+ETP5mSroPAwCUMotp5KWil6D3NfHp04lESa68vfa2WItCtY3of1b/5FiQFKmw1pi3fr1KbKObhPG7PgO/aH+K3bO3Ezq5aLUehY2a/64oKnijSMmOTusvqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tH9zr1wY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dd80d3d419so920117b3a.3
        for <linux-api@vger.kernel.org>; Tue, 23 Jan 2024 18:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706064867; x=1706669667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq2iCmnPB94WcqySTTnm3WLG+4jkf9fY7fGI3ZdGS38=;
        b=tH9zr1wY32bhLbQn/L8zBfhSab4FuzEwR8XHnAg0JZxyF5etL9PHPdUzaJ52dEUPDe
         aZs2FFZBtJjjfqqAKfOWFHCosxXBC3i0vhbrN+yKlSBRUksx57UhpyNsIfo5r8vxq5Ye
         U2bIvWJLs0ih0exY0aDVnO8rRndkkhP2Ts2JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064867; x=1706669667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq2iCmnPB94WcqySTTnm3WLG+4jkf9fY7fGI3ZdGS38=;
        b=UTzqwZJFA3WubscWcDC8KwypsUcnNe923OFqmnVl7N9qmqzlEKrv2nIFmU7+QdsNYZ
         zFgQ94MbcLSXw5EUAwDP0XUk1BfVVkZYqq4HRA77ca0T623/u3JH19c9/EvuwOhVhXBL
         8uMrBocs+FDQ0Db6+7NQJgJ7iAH5KTN344bPKPEH12ff9GrWmKDCRI/P5B+MfvC4i1IE
         SG/0NG/CFzEGTo0rB6VF08vewX0hbd1Zfu9xb/fNuVs5Kc5K9sU7Zs1rPSjv3OCoUtmS
         LigBjeSGwlMrDrI0bsdc820MDxdCrfTbeTZdbisQstTh2d/vH/ZbYN332+J+xAcPLMSh
         +D7Q==
X-Gm-Message-State: AOJu0Yz2Ke3RPN6CZ5ZfqyVsfZz2W9nT3fqsHvxSsRQSS8ymKOqmeDWB
	J9r6ol6E9f3nqnE+qQrWPeBlWrU8Gv7M5t4iLQRhqkDNjHK8yqTFwB6QkgDwQDU=
X-Google-Smtp-Source: AGHT+IGodI8N0Czn5sWE4mbKrdlX6VeLBQ+z79W6omRxv5iM82o7VtlJXdsv7TV9KmnVN9aTE4/aNA==
X-Received: by 2002:a05:6a00:3a09:b0:6db:a0e5:7ec3 with SMTP id fj9-20020a056a003a0900b006dba0e57ec3mr9228809pfb.22.1706064867592;
        Tue, 23 Jan 2024 18:54:27 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z14-20020a62d10e000000b006d9b38f2e75sm12974229pfg.32.2024.01.23.18.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:54:26 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next 2/3] eventpoll: Add per-epoll busy poll packet budget
Date: Wed, 24 Jan 2024 02:53:58 +0000
Message-Id: <20240124025359.11419-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124025359.11419-1-jdamato@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using epoll-based busy poll, the packet budget is hardcoded to
BUSY_POLL_BUDGET (8).

Add support for a per-epoll context busy poll packet budget. If not
specified, the default value (BUSY_POLL_BUDGET) is used.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4503fec01278..40bd97477b91 100644
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


