Return-Path: <linux-api+bounces-4199-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0633B0F5D6
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 16:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A4E1CC2D9E
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5ED2F6F9E;
	Wed, 23 Jul 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="KL4Num2E"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DE2F5C32
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282023; cv=none; b=inp7u0F9J+PC9RFal/yc6yPTYyDhzeOpc+BB74pvcHa2+duZmp4hzCoNAb1V4JyVWDqLwyVOMZKQcP/DIY4DSoY9QsWz+9+yUh4FNFbN78A5g+DKS1JYacWva7dZCLslRo3Kzv7JY4m8CWeEDrn+Ja7pEAMHXMQbElWNwEKt1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282023; c=relaxed/simple;
	bh=kan5N6v9h+6HDmaXzRrpPnNHjduBvdwtdSKyvQ1qoHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbQOD0vyYizQetsH3FVp5OpguVSMQ4FyvHt1l3gLOqPhc9RrkDJ6+aIM0EZlXFzi2zusZPfoZvxNryGHcXHfTHhXTabib14rmJZG4UVwpCMokASVbbEcrfWu88LbISGa7FS8nD4TbpTJ3GmdWyT+9bt9hrb1S3FVRGzuenpoktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=KL4Num2E; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e1d8c2dc2so65659427b3.3
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282020; x=1753886820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gy3J9QeC6eXj3cGR0pgjxNs/6APC+1lztNiCJckBgPA=;
        b=KL4Num2ErMDjSve2Ap/UeK84q8BVWlgZScO0wXfZKdHj0BoY/3vpaaEdSO67uTDl0N
         EK+9w26CgCTEG3g4ZZovf6HJlIZvbRroRps3D+HI5DUKgFzXZM9v8Eq4dHlaGBr5iN+q
         uWUiQdMER9jsseUMjfid2gZ61FAjv3HbuJrTeAXbXe9RqB+4DPKuTl9FOQpdXXDx4W/M
         iIJmCFgAbbCNbxiRDbC8sa1dbiUHM6u9TQTOQZgm94jDXnK9D5YifpVCN2jSO+HJbVfA
         DdZuLjPg7krOtEVrVPmqLqlPSeSdzNj7RhlMtOIBTI02bBIkS6pcDsfAl+4TgsDl0iHM
         To5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282020; x=1753886820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy3J9QeC6eXj3cGR0pgjxNs/6APC+1lztNiCJckBgPA=;
        b=mjVeYafxadk2lpMgQhqNO+IeAKWC+JWraounTwBKud8LSVlQCdxqxHgx3akoSqSH2V
         H1JR2Saovv36w6Ax0idMCQC2Uq/GFEZjulBJPby0oDVte8QgcDpnyT1Q0PwZGzxgGZzO
         t6E88ZS3zwyCa11J/Mb/9oz1bBULy2eSp1CsKLCFPlfmbheCgT2Fa31Xiunb/iizHstw
         9PddmsO8+UbcvUsYGf0jqpJB96MiEyTuYYhiQIdJQECCHfwHBXv9F6aiI6xNbZXC9k8P
         ys37zIJf5Hn0J0O1alZuNUdoQ1Hjin9dd6sO24tP2OxYKXQvkTif85ycEV1wT9eEtBIo
         4Q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFy/JHS2fCy71CRsaJuCchXnvF5QYf/UaB8HKpsCHeG4xosGcvfaD1ay+IzVb6S7iUUZVn5qkxIW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylzvb1cb7F4qBq5SWzGbjgoaQ3sFPzeYVvHQAT46lvZHoFU2bz
	8IQ2bHt4ZQrZcq0jlKNPb0jZyCxCCDBSnV8wYmcjleLMg4K/bZXpQ+50FVa72tlD7/w=
X-Gm-Gg: ASbGncvQj4QG9Y1QcbMk5GQCT79ZgTbxpHJ8H1JGsxv37mGHJ6iYtjhBSYPCeWovUWY
	O0wS2deBH7Jmd6KzZa2rtZtvdlKjlG0KkTRlSbV4w/tphRHmTANEV4f3JTglJ++qhV6AQ350gZv
	gM0AlaRiaY+2tkLjUNmS18zhOoPKBKaJtZwBNWy3ITqIYq2nPtsaRCYNb58WLdT/OWdixenwEzs
	H0PZP1m8BHcBBWo7hfDv+RtVKZmPieDZJTa7SQayiewMeM+Zh6nK0q7jcNN0N8Kix3Qnr+j/m92
	8ln6ljT46zurVhFkjN3quMEL0D2R46GMJcqMsGIQzTMJFbg5Aj326Fcwyc/qWaZCWB++XmS2JPk
	E4o2qP7NACvPAu5TLyHcWBB2rRxHqPyy1+StuoZ799OqKtJzelRUoCPs82JjfGO4Ht96nwrSXE7
	kLNOghidc8eYfMqQ==
X-Google-Smtp-Source: AGHT+IE8V9tRE54MK48zflOS7PSA4HAhDqRjtC0UhDc7I1+H3UGz76R3OVDEkrrQ9nCRF167WfSdiw==
X-Received: by 2002:a05:690c:74c3:b0:710:f1da:1b5f with SMTP id 00721157ae682-719b424d284mr43181487b3.34.1753282020293;
        Wed, 23 Jul 2025 07:47:00 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:46:59 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
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
	zhangguopeng@kylinos.cn,
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
	witu@nvidia.com
Subject: [PATCH v2 03/32] kho: warn if KHO is disabled due to an error
Date: Wed, 23 Jul 2025 14:46:16 +0000
Message-ID: <20250723144649.1696299-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During boot scratch area is allocated based on command line
parameters or auto calculated. However, scratch area may fail
to allocate, and in that case KHO is disabled. Currently,
no warning is printed that KHO is disabled, which makes it
confusing for the end user to figure out why KHO is not
available. Add the missing warning message.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 1ff6b242f98c..368e23db0a17 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -565,6 +565,7 @@ static void __init kho_reserve_scratch(void)
 err_free_scratch_desc:
 	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
 err_disable_kho:
+	pr_warn("Failed to reserve scratch area, disabling kexec handover\n");
 	kho_enable = false;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


