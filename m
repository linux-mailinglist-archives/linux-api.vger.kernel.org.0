Return-Path: <linux-api+bounces-4359-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA16B1D09D
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 03:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FF31AA2955
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D526B75D;
	Thu,  7 Aug 2025 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Uun+cnp/"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4911D79A5
	for <linux-api@vger.kernel.org>; Thu,  7 Aug 2025 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531129; cv=none; b=SF3hvkg+oFAKumUHw4Qt8d3vhfq1D9hjHtKRDam7YwtVX8Y7i9kSkkKwU01nJv01aR0t9DiElOgbNJzwPKZD2m5xU4HQPnzc2CMprRV6xO8wt2EoG4u8dchyMRvMubsIAWOMX8Z8PoVKYmAds6aOdONhRWZII3iBwJVFnJG3Sx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531129; c=relaxed/simple;
	bh=MQ63LnQeT5I2XWVR3/9t21kTUDqY3sDHkmER0gtcW/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKfd59A24ukOtb86CZtYeOGLvTILQbHqt6T2C43fArevWa1dVpayauszbq0H9TIXXeyAMC/d434z/oh8xr9yJFEHTaY0L7W70RX/ZfCNMAmYYb3s8bD3dDtwdSrRUvKk3Uwbqgg0+92uRC8TnOzQ2RRgLZynGi8gvqEeOUN+kTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Uun+cnp/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70756dc2c00so7504346d6.1
        for <linux-api@vger.kernel.org>; Wed, 06 Aug 2025 18:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531124; x=1755135924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA/vUYeCxNkI6poJfbjFNlz5+YRzYcbbQ+LvASsW6yI=;
        b=Uun+cnp/XZzGsvmDPlAnMsb6mrtGv5dYDxU0XO8gk/1VU77Obpair0DmYTgs11wixy
         OEvZkYCAJnBva9a70vWXvsavXZ4astcUadDqnQZOlrHFrWk5w/Dgab6t1Yr4bdEofaQJ
         uVYfrN4ICKA63QtOGO+reRstzuz4o5FnyutjFC1wv5COdWV3rkVxWL0cgs1NsXcKUGKp
         yyo8h6baecjst6NVS7cbvibmGvPtTJYKh76QOTQ0rfRGdLrRF3bd+XaJ8DtiYw6wTLUu
         hRlvoi3s4xhmoDs+Coyx8VZC5jj3DpTlml/n/UfO5TUSRPiyrG1fLlah/nfGRkJx0ivL
         hEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531124; x=1755135924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA/vUYeCxNkI6poJfbjFNlz5+YRzYcbbQ+LvASsW6yI=;
        b=gijt16mTMmuFtJvIYB4oEeqtXDb+Ma6kQPhtsqIJU4dxRB6nHjTQw0x7AEqF6JKOAP
         j3QrsXDtv4+lo1NEloaa/UXbT4rNzzj+CoShaciBObL0HBOqeCuouHL1W4vlNei7ZuEF
         f0WxAxis/QTcpPS4pXsfsJU0+VvWf4LilFdoJyDzvmTdk9hITb78p8KZ3qawolT9QIyE
         WragmD2tadK6nIQ+57JVhHa/wa1NZqcnvqNh+d8Ru2Zqt02gyLYz54ECVphNgUCpWHcz
         TbRYgkw6XEoKunT42YddjA08gw/OwsiiKKJ4DACC6GwuE5fabgxEBwYwYHQ0T2yhgxVY
         yRbw==
X-Forwarded-Encrypted: i=1; AJvYcCU9H0fQ2I9IjjdINyJt/2IbpJT/XSgySEZu9QzhDV12Ki1ajd+KbaoVtkawQpUeC54wSJiQSv1WHV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6MGeMAGMyOcL6zRP1QWNzPHOho2FF7E7wAUVeeiWwJBw/p20C
	rli5A2trToNqbLj5GmXYM3DM4QbCe81T86BpwqgJCqO+exeTkSYrIOaUdAZdnDdS494=
X-Gm-Gg: ASbGncsdkW2ITl33QTWa/pz68YhepklY18E2G1ZGPnZJFn4ukjBQ/d7gjxyNuJQ8NqE
	RAoUJYu0Z/MrPA4T6w0u7jnUcb+b6zqKCpDiboFmWRN+SLpTfIU0abIIabw7E5vJ9e33UGe+M3s
	JLwpHcqQwI5FNPxFwy7Z+VdPz3AMY4Tip1Xb1CYNIEiE9R/08ahtBCeQnJeYzNjHi6bQhnenv+8
	bNzYtMvTTfNOFJV16LSNhyhhsNajtPCUVDJdr+gGgpBtKQGHrjikso82YMol7zSTCkY2kV5cBkE
	XxRWG2/q3sUXUmDL736fxOTIlFrnZJ9NZ5Ov3PMHKN8bvDSxC6u9hf9KB+NBVAWw8ouq6H+7a5q
	MMuOijmct8V/4SpEv0s/sgYGK7Nh/XHZv+M2TfaIzFM0AsvQX0XlN7ymAR6/aBOpG3bgqoZz5tP
	Q/CvwHXoNMoVAEbo80/vs5jpg=
X-Google-Smtp-Source: AGHT+IEmxyIIEpF/zYXpWh7lst20k+6O+/3teCC6bRoX7mK0ce9gFr80XAlcr6QckhUk2jTkrcE1vA==
X-Received: by 2002:a05:6214:27ea:b0:707:3314:793d with SMTP id 6a1803df08f44-7097969ff73mr76803076d6.37.1754531124250;
        Wed, 06 Aug 2025 18:45:24 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:23 -0700 (PDT)
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
Subject: [PATCH v3 25/30] MAINTAINERS: add liveupdate entry
Date: Thu,  7 Aug 2025 01:44:31 +0000
Message-ID: <20250807014442.3829950-26-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
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
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35cf4f95ed46..b88b77977649 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14207,6 +14207,19 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
+F:	Documentation/admin-guide/liveupdate.rst
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+F:	tools/testing/selftests/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.50.1.565.gc32cd1483b-goog


