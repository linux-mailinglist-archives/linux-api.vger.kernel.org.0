Return-Path: <linux-api+bounces-5510-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85224C8615F
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 18:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7500D3B4016
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D128332E72E;
	Tue, 25 Nov 2025 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZnbNAtt7"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D732D435
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089957; cv=none; b=N7Ixji3xrxRwIA8CLJwL7ojO2lm0se5gH37Er45OQ1kZLMWWRKTIQEjo9vM6WLbDjk3uv8z6wXpYP9ROxzqPQEdEt0dc0o0FndyywNKIX9txhco4EfarcjyojU7zce0JkMYw/I1nCIEMIdFaR9Jvtc0uCnedHOKbQHEaf4ixHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089957; c=relaxed/simple;
	bh=rtE+Ceb6uvxsJ0lAv2S8AcwD3k610VK53wkRvQDM1Hc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmQ+f22JNRmn1wLg/c0d1GNOlPZesXLB80VJTuBj05gn5QclWnh8566kzZbiei5qcojRWe4GZn9PJiLuvw+PNi6ehQ1hLy47qL38tjEngZ7twz/ITjCb6bfsfuLKVTOJLSu8/uGeImLaARTL8bncmkI+LkRwdYhy8EI2ZSN1ptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ZnbNAtt7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7881b67da53so57755997b3.1
        for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089955; x=1764694755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2VZ/uSTE9rekrj+aF+jwkex/aSDTyF9XJpHnZs+90c=;
        b=ZnbNAtt7KY+wWAuqReoR2RU9F5Ma3kWXG5zsoZkHcnNSfQZKMB/3hC9D3dSkFO0VhE
         dJy8Dj9mMLwDiIA0QdIQCYl/jPGvqqlVMJHKMvv9PN5Y/yd9M+uOXNUXnQL+Q6TBTJrM
         BYEWSJCK9Lv50BX48dq1nDOYVxPZJFdLdYRkC0F5nxKb7cqbzoaNZsaeSLYj0pVsn+8/
         ktOUlFYKrl+Hl2/xFPou+GGkkv3nk1P0q8g9vWm5dVUB7sGH3AfD1xO0SkM9MztzJ81O
         bwKo7ppBP6V1aNqe+mIKt1B67oEK2t4AcDapv3I+b1vAemUHDCsraUHzHaRDf0fyPDvR
         PqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089955; x=1764694755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n2VZ/uSTE9rekrj+aF+jwkex/aSDTyF9XJpHnZs+90c=;
        b=uWW0KsDR4yuvMWHOajEFBR50MzTR/WNfggrfifP9cctF87/CBwUBguNQyaLrBpk8n6
         Tk3Tpq85m7+zV9+g/qZiXmjTy92Y0PZxvYi08pMQqWsMuphQD5LCeIdUacKOOzExBdTQ
         3AvqKKPfBf3WRtGVQ90Op7Iho7cOyg6jxFvPtme/yh28JoN3A4vN7kQV7skIcq3+Ko8E
         NbXYFL2WqsGifkKxoja/cM49yrgwnkJAjcJ/Om5jR7rJtXORGc4GPuDPcSg67pIPsuCU
         SwTiBBIWMo9QdSCy8wHZnKWsMPnG+2+7kZm9PJ7fZqkHz22IYC4rpCVcUt9rdXkJt1XD
         0X2w==
X-Forwarded-Encrypted: i=1; AJvYcCXnm09adoWmWPTvGxMUR4JWT7FzCwrtbCtDRxrR71LTrJ6NsftUcCS1al7zpvYxTKcpZF1IZf9linQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnQk1Ai15HDNxbkfcCoW0qcwvKZLtGiOOqdKrV/PcIZR/sDZd
	KsQATsXlqvqjMIbuES9M664Pa9T0uOB4yXcDoOgLziU35VNIPSqnuhT2bON1Wlj6GGw=
X-Gm-Gg: ASbGncuDEoqV01Xb+eMbdyLsH5R4Xxmdls5dVHPjqBKLRJGXmyWqdOII6NVpgEY23/P
	Pj6TqgTViGKvcgQ3BTTl+zWQlmmLkhSgk0tRAGEllo6yP2aBffvLgP6EGzPrMF43IeXk6Hu1NP5
	mQsF+HX23ZMLr8HOsK50vWMK4OfzU0Pc2mpw8Syvyd1lgjQg5zIG+7BpFXeiVpVqrBEGzq1aHl1
	324skG4Yd3ahvNY7qSizjVnyAoszEZKsYqiBJQ829fut0cSYwCrHd1HExJxamQxjJLeufFy28si
	zP29trk3MWIykD6niMwnvJPohVoeUY7kKtN2YUL7BhwR7huSJBlgeh0oAW9DB4GljXra8LAvQOt
	uS92diE5atVj4KVy+o4LEVfKw02nMyXrh/5sfxD5pgqq6A9dR7kp0WwapjQPPn+lmKCQP29PjUt
	S5GkxkYU9wy6ou6GUUb/M2w6PfBJ4z+obfrWqhzU/3UQ9ayhe7XDMi0ht1lArknz/7wSoyC0LwS
	4RWwFY=
X-Google-Smtp-Source: AGHT+IHp/uLRINC+2mEmiuoSxBmCL/SWIZK6CY7B3JageMUTar9wmfaPytTKzucTyEwNZIYxmxjOcA==
X-Received: by 2002:a05:690c:61c6:b0:786:4fd5:e5dc with SMTP id 00721157ae682-78a8b53925emr120116757b3.36.1764089954718;
        Tue, 25 Nov 2025 08:59:14 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:14 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v8 09/18] MAINTAINERS: add liveupdate entry
Date: Tue, 25 Nov 2025 11:58:39 -0500
Message-ID: <20251125165850.3389713-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS file entry for the new Live Update Orchestrator
introduced in previous patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b46425e3b4d3..868d3d23fdea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14466,6 +14466,18 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+M:	Mike Rapoport <rppt@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/linux/liveupdate/
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.52.0.460.gd25c4c69ec-goog


