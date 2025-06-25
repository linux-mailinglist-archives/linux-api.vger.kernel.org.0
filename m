Return-Path: <linux-api+bounces-3996-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F55CAE9224
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 01:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE41C41F37
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79B2F5481;
	Wed, 25 Jun 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ViCB+3V5"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB42F4324
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893529; cv=none; b=f3sBJmuOJEeqOjuE2ZZsLEbX/Zuks09Gfv8MQLP3k+O0tlIxtu5mDOuB+NT0magpExmcWvEhbfjk9sQaj5ZOpZ1ZZUOg9NXK9aG3M+OY/bNOQvv/PS9Kk2yqlIl0Diah4gswl99rstB6pbSFr4YW17ml1ow16G+pSqjTSEQAAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893529; c=relaxed/simple;
	bh=PF4zPZ0Sp9cFfB82RPz+AlnuSwnkSMU7iIBj0zSOFYQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMzk2I7m1/JstEB98PvOPEdAV6Wf8/Y9VQSvQs6xtxDW9V/1jsbVFPxsi9GJai+Ou3g2vtdUrK9jNcu/yAkYFPQaCAk0qmQTXjQEPZJOJGyVdMsFvyWxShSDCsw+NqrubLrxiCDmkAeMtUazTW51Ih1hGjL2/rkwwenApXrXm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ViCB+3V5; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso318273276.1
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893527; x=1751498327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oli2O51+2uVx0lLUJdn7wg4sXYNT345uLjNKlql1qmI=;
        b=ViCB+3V5htYFrHZMRHANBUKMG+bkSjOMn8AQIhMlOn+nvaOrw4Pb6+esS6L6xFmYKu
         hs2+nIZrpnNdYCgi5qOyECPNN+f2DM7wwi4mFyHufgiotz4Kpj1jyCCgG8kKAV4R6MlB
         em/T7NC40JexR821d2Euyyu07JvKz1HymVxiJTBvj0+DvHwUNR0Qj8wwZNGftTUoj5ID
         x2I8fABa4RfLSpkjzIeb8rqOw9DUu869p2tau+5MSmpOJPCoTpGnvCLuQj/Loae59pAT
         e7X5Gnlihiq32KW7A50UaDXPqnbPnYiLw+66a1OhK7J2Bwbvj7j4F8G84y5iBbLJ39TJ
         yDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893527; x=1751498327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oli2O51+2uVx0lLUJdn7wg4sXYNT345uLjNKlql1qmI=;
        b=izjftzFAfklL/Dld6KBBJS30ZpLEPXApv8P82oSp/wWmly33GrlKjeNv5waFzklM23
         /JFMJpnWWaqb7vi0SIH6pMeKbqhmzy32X6RkfpXr2f5+68TvS6qs5QwL4Bo6vfkvUnpe
         e/3xU0V6l+lWE4B3NJ9diU3jU1nlfnUNHF7NJpeMBPsP9ZuxMmXOmz2H7PfmAP69eXxU
         Xo6q9GVav20FDGHNsmxFyOi9NqpuPaBUKo284/ut3klAGUMmusfldPXe/pReaomYhfRZ
         Qx7HFcJyj9kJ5N8F3a+XyJ41k3i5SlJeof7BhOMa0CBWSDrA7W53wIvqEybQMPVDTs/C
         UwpA==
X-Forwarded-Encrypted: i=1; AJvYcCV4dpdObLPs444EA3q3srRxtWumLUO80u7s5PxVWXawLGJwGjwza4L/vcskGj+dqA7/sOXmPIKweow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+R1Bz74mnpYM0IGw4NzikZNv/susYxUeUAqyrL+27prPNAThP
	HN6MnXp2YYCkZXWffzIIbHzkt+PkLSy20KuNT0rOn7tJK1q3eSlZRmJ7wstt3k8A66c=
X-Gm-Gg: ASbGnctqri5DxUWKq8o3M56VdMYGCyt6tCPsgxTLAxDAflDnXkEcMGR9icr1EYRdptO
	9APMx0uGoU1B7NaRBG2sowDbGwDo1CkBQmLJ1fJcljviAlTKtcLNEikm3nBrxwdBEDurhDM+9pu
	fbfPq5XWTXfI3DeQ5cl1XjLD72frLr5OmKLbGE+Q/jPNte0OaPvyX/NYPBvdduZkZGo7fZcgjbk
	sdDh2vxeUHpNEk0D4eV6I1EHy4XSwYvnpv6gUAIoSGoqckFeEczez2+abwXEkkbWbwUP1NyCu/a
	+PMXj9E6Pu4ZyaIjEOpAExA4dZJ1LUVF0kjyd8KljFu5UDdSiidyTPqcdmATESBhDQ+I3YNkaKh
	HHLA295/od4tw4oMBBd8b2UvmzldZWX4LujyXDWseyRS+Pfir2xd9
X-Google-Smtp-Source: AGHT+IF1PnL73EgTJEwVzGrV6WgSUuuJlktSvOW7rB8u8kfkaYIkr57swyuuC7E1tjKCDwfV/0m2Xg==
X-Received: by 2002:a05:6902:2305:b0:e84:2a48:993f with SMTP id 3f1490d57ef6-e879b8875e2mr2677057276.7.1750893526742;
        Wed, 25 Jun 2025 16:18:46 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:18:46 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 02/32] kho: mm: Don't allow deferred struct page with KHO
Date: Wed, 25 Jun 2025 23:17:49 +0000
Message-ID: <20250625231838.1897085-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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
index e64ce21f9a80..ff8ab20f9228 100644
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


