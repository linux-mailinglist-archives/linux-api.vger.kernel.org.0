Return-Path: <linux-api+bounces-637-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC2283B615
	for <lists+linux-api@lfdr.de>; Thu, 25 Jan 2024 01:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6635A284A45
	for <lists+linux-api@lfdr.de>; Thu, 25 Jan 2024 00:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA7748F;
	Thu, 25 Jan 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wdCQHqEF"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FB67C5C
	for <linux-api@vger.kernel.org>; Thu, 25 Jan 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706142628; cv=none; b=uy6qtgT5y5cyUmODk+XKRsqLVSOSq8E2UFP1cUA2NJNuYq7siU9qmeffxpErFkH1VVKtaVvYX05CJm9uUN1j8Q5ejG13x1JJ8vzZqKiVXfm+KNmKu5PFq9m0/lPYCwPy0VTUvXTnCs/sENiFuNuuzaoW726rAPiW9qdZFD4KLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706142628; c=relaxed/simple;
	bh=lab1cc/BnvmVMoI/6a4oqJtvBk6zbJgk82AeHiJrUN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qp7+XzYglC7Bnq1qWtkfSk56bH8o4dHVZBmM1VUg7snoBmhFuA7YBL2pnNsbm2CiFy8Z1T4zvKaNkZ8X7wXl27c0Jxhl9QfKsYlR8hb8nuYJ4PIiiaMsJ16XZQfI8CLxcf7q+i5YimsT1cXa6zFhkj79vPoR1bP4cHPKl575MNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wdCQHqEF; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-361a38dd171so21980865ab.0
        for <linux-api@vger.kernel.org>; Wed, 24 Jan 2024 16:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706142626; x=1706747426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgDFOq40XBBKNZXci2Ggytp+MQppzv/horYrfyyqlNM=;
        b=wdCQHqEFj1fELd8jMSd1CTQLr6eZnzKB40m2nzPPjLQCZtci8aSyRLSuQjKZy9gT21
         4DvQ9s+Ijra/BYPrcmyDDIzAN3lmuPPAbQTZTJsbE4567XCk3CZX8PoFmOxt6b/o1zBb
         Mbp7YovlQ8q5/7ZE0oQy7vnrHLAiWXyW482mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706142626; x=1706747426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgDFOq40XBBKNZXci2Ggytp+MQppzv/horYrfyyqlNM=;
        b=JykFx+COSjui2LCymZfasLWx+7Ce5MpD+GPc7K3INkkKd5CbU9pm2QPCdgsJz/v5q8
         QvB5Hn9btNwEfdEST/ZgRgvFwVbrZI4CjfMpQ3IGBGJ8a4pXtgLbzLFoaWfcto5poGxt
         eKLHttp6msuSp60T/Y0FcqRWGOp9PX5k/WkdTGTQ3LBC/pQyq8TXZ0zQK/zaDrGoVn6j
         /vOp5aisPfW/kbVeHzbWbqH9LGnVgU6FmSe4XKgwGmZ2AC3++ZHCrhdh5pbJ+kVggog5
         m81ucH0PKf/PtqT3tx0w74zU4MznnkYDhVyE7lmVpXqaLwmah/f9leBd2tbsek+oGZ2s
         BBXA==
X-Gm-Message-State: AOJu0YwO/SEX4kk0rBantsLakl1mAlFxPGrWon047dpD2Igz57dMkoNZ
	EXebSAd+I6Vi5rS5a1RqZA0ys5XnBHcG6uTa8CAc+zd111vBEp/DsmwQ8oBLWX4=
X-Google-Smtp-Source: AGHT+IE9OMBwdVUF2LOwcQ/6fsfVNS4gRrjXRfy15GDSSC7Tq5Amb3vaXx8NekmcMrDZP656URMpnw==
X-Received: by 2002:a92:b751:0:b0:361:abba:a7a4 with SMTP id c17-20020a92b751000000b00361abbaa7a4mr270859ilm.14.1706142626425;
        Wed, 24 Jan 2024 16:30:26 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id w10-20020a63d74a000000b005cd945c0399sm12550486pgi.80.2024.01.24.16.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:30:26 -0800 (PST)
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
	weiwan@google.com,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next v2 4/4] net: print error if SO_BUSY_POLL_BUDGET is large
Date: Thu, 25 Jan 2024 00:30:14 +0000
Message-Id: <20240125003014.43103-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125003014.43103-1-jdamato@fastly.com>
References: <20240125003014.43103-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When drivers call netif_napi_add_weight with a weight that is larger
than NAPI_POLL_WEIGHT, the networking code allows the larger weight, but
prints an error.

Replicate this check for SO_BUSY_POLL_BUDGET; check if the user
specified amount exceeds NAPI_POLL_WEIGHT, allow it anyway, but print an
error.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/core/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 158dbdebce6a..ed243bd0dd77 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1153,6 +1153,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			return -EPERM;
 		if (val < 0 || val > U16_MAX)
 			return -EINVAL;
+		if (val > NAPI_POLL_WEIGHT)
+			pr_err("SO_BUSY_POLL_BUDGET %u exceeds suggested maximum %u\n", val,
+			       NAPI_POLL_WEIGHT);
 		WRITE_ONCE(sk->sk_busy_poll_budget, val);
 		return 0;
 #endif
-- 
2.25.1


