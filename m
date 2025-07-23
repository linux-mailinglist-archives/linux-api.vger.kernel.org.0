Return-Path: <linux-api+bounces-4198-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4982B0F5C6
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 16:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789267B65D8
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BDE2F5C57;
	Wed, 23 Jul 2025 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lLeh4OIW"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57532F548E
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282022; cv=none; b=q2siwxrY0nSFULPPOoRZ9341z424lM8RxsOUtIdUJnOLgFOQSUXRJYAIe1aJy1+sYG2vedW9coSRtRquDi/zafY6ssRkCt+NkUJRT38bjGok3UjhwUumTN145J5GO0vUSlF04IBexHS0M/UPYtD6IXaR1pxdkti6Rbc34SJfX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282022; c=relaxed/simple;
	bh=sJLDn8ryoW/ov6UjZZGTTudXv5WHl8/v2Z5ZbPyJ1x4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CF1x9J5qQ6zUljD+DP4ZF3qNVX5tAiuj26C+rHEK+3CrhEiHmCr8u04HVSNzDXNqOuhIiCpgtehcqm72LmNLIa3PNxYO/XlRmXHQV4tNA+SPrceeYCn3mlAd73yDgLVp7cui6EwPzlAR1YRKZkzNxi1wkEjBlwSuirt4gdo3120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lLeh4OIW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-719c4aa9b19so1152817b3.0
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282019; x=1753886819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7cl1P/nffEHtPrwqwqBj2n/TmbnAXjnzD/OU22eOOo=;
        b=lLeh4OIWCBKjqs1N2TriFDuB+ubYYiseni13/mb49rqAEhv2jLPKXb3Q/Mt4rf8D+Z
         7yJwP/iH0iEperDTE1UJelAthrHwmUaZj5cFcEBvnG0IGsmcnsZ4WAvZv7geAbLGv4vE
         fmMj/N8K1oy3jNEltDSq/BUyPW75NEC+xgiUamE4ezJO2QZFp/l1vZOkUu96jPBefpci
         x/ghPi6RS0ioS+uuVxBn1m0yOsq9yXXNmipUz9VUSxh1x2ahltuhH9zXtrxah945fb6q
         9soOx0N9pwYeBRyFHMoAuRsRWpIIyt7NidN7JD7l97y2oc7p4deeBVm17WMsi+ciOXrt
         8etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282019; x=1753886819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7cl1P/nffEHtPrwqwqBj2n/TmbnAXjnzD/OU22eOOo=;
        b=HEN8D2ecsj2ateNE9+dmHxpQLpn4p1LWgtmnPsqnQReQvejJpQ8sg7XszxWpjk7RI5
         tOLcxuhM2ehFoJXGhUCaCvRa2RR3RtAagsdtJcLicCl4fkx1ly8TEFGHCU+wpnrWn5Jc
         GXLtp8NcFTWi1Fp4pljYs/9yl3aGNG24Kk4trIudrdlngq78w7lLWPJXP9+8g5NS8QSP
         VQbT1rlz17qByAFL3wG8f5ybuYjabkxnplFJTP5Ok7UuC+GANdL4kYh5qy/I4Mh/WFWb
         sXrMhteCphu1ZfY59UfXW+0E0kc150NGvcJPUY2jbyVLN8dnKz76kviYbnsmTsnUr4dD
         tLqg==
X-Forwarded-Encrypted: i=1; AJvYcCWxtmNGj0kqCqLOmwk2thH2DdHLdnATLPFbvJnG6+J/eZJxid3hgEBPGJ0DB8PFOg25HGT/NDt2yJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRanicee8eRIbUQpz8ZYmFDhNQx1s4gxz0w5AzFtUvCgF21tEs
	kYIC+Et3SS5tMVlRtR1xVULirUZPWjenNPy1dLPHRX8uG+yOQG5eYnwcBatCeqF4tK8=
X-Gm-Gg: ASbGncvsCwKhO+QRtm8RgLV8YIJvtcakjm4uIxS7PGuFS1GBRLTA5rrhlICQAIdq4IH
	5Po3wnQjm+ns05W3JelRKMt7ctPkj1ZRm+rlbf6RRA2j3M20KdaU6+aO4H9dzLP33RnAD6+P/4Q
	aDmkJjBDdhdVoeQ0bMoGgADpboCq4fR+nOmyhzf0GytDsrOZ0Qq1HLUyGL+ckqv3YwjXghZaJFY
	3rAB1nLmId/1nb4+RhwnZQmpgSNsSLlcSgEidZI8ugZ7Ix5wErioAb1Jkr96uH/FwLNAqY7bJHk
	8GuWX4lLb3ZPVZcphZg5sYWmx8WVFZVMmksU8yuzG375fzJIyAfZh/tWVQNhP4uZWVnM0y8RUWB
	w3N8QkDoUClu4FbIcldUBbw5yZWPPx6g1Fi4HdYr5ZM06XPtwP8BwQq4Eq6yk5H3NgJW0hhpv2k
	Y0KBES42s7RjUv8A==
X-Google-Smtp-Source: AGHT+IE6ehQOayyo1lb2cZBdo6W6rK2fNueePB1JRBmEV6kcBUnmTmWNn0MIzxo8F5fZ2uNGvf14yw==
X-Received: by 2002:a05:690c:490b:b0:719:4c68:a6f8 with SMTP id 00721157ae682-719b4258512mr43723377b3.32.1753282018494;
        Wed, 23 Jul 2025 07:46:58 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:46:57 -0700 (PDT)
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
Subject: [PATCH v2 02/32] kho: mm: Don't allow deferred struct page with KHO
Date: Wed, 23 Jul 2025 14:46:15 +0000
Message-ID: <20250723144649.1696299-3-pasha.tatashin@soleen.com>
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

KHO uses struct pages for the preserved memory early in boot, however,
with deferred struct page initialization, only a small portion of
memory has properly initialized struct pages.

This problem was detected where vmemmap is poisoned, and illegal flag
combinations are detected.

Don't allow them to be enabled together, and later we will have to
teach KHO to work properly with deferred struct page init kernel
feature.

Fixes: 990a950fe8fd ("kexec: add config option for KHO")

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/Kconfig.kexec | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 2ee603a98813..1224dd937df0 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -97,6 +97,7 @@ config KEXEC_JUMP
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
+	depends on !DEFERRED_STRUCT_PAGE_INIT
 	select MEMBLOCK_KHO_SCRATCH
 	select KEXEC_FILE
 	select DEBUG_FS
-- 
2.50.0.727.gbf7dc18ff4-goog


