Return-Path: <linux-api+bounces-5431-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5D8C7D8C1
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 23:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C5564E051D
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311192DAFB9;
	Sat, 22 Nov 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S9NGJRgn"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C52D94B0
	for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850258; cv=none; b=FJSYPandoboepUoJb6tC3rUOf2rkbWJwKN/EcIoC8Wis+6EgVFaw3EqZCGmRfH0JV6HGhAckgGTd5/Nte0Kzz4Z+/KD8zKN1u0FIzQ4MxOu50o29MZkHr/5gxs24gF5/aU6SADrPEqPmXn9vxUH6VFswhNyY+4rZ81o/Wh2yd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850258; c=relaxed/simple;
	bh=EnyxoW9Q62zzNLamdD3lY33p/cbJQtd0FxygTgIMtNI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZhaLFVttT7IAdZpTeO3OehSTIgMT7MmiunM4BSdcQstDbSCZkBJlbEgwkneZ70aKSkI5t3C/8LMXnbOWAKZpKZs9U+l1swRg/0gH4QbQgG6bfLA9sSXGl7EwnaLm/hnYA4B33akssdq8AuxoIIKOxU69dr3lmp7eMQloNA1Kuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=S9NGJRgn; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7895017c722so30365697b3.2
        for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850255; x=1764455055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzrSObhj5Wimd1cdYGg31ZDKZ8HgVQz7p6sm5WUy9Y8=;
        b=S9NGJRgnpowrXgInACxha2n2Ffk3pLPjp3BC1WNT/wTq4yNHk8eU6sCmka9gmsBTMK
         pER5bynmdLXu7hu9B8itR7Z4TJyotJok/HIBFtiPyLwM9fKuDGaa48ypS9adHNj0wjjF
         obW+dMnDMo1P6jHVTpHMMpI1+BVVR3WLkhCgL7+JdBxzm150angHE5Bs/SslxXf25GmM
         3++NLSaR3B+oc1eQi5AJGfQ6sEBkDbNNjqrqNFywmS2zzWwALBCqzkngHErncKv1F1xK
         xpQMIM8G3yUXBg6bN0J1Zge+v+OmvrTYUCtXntjFh9V8po//Xw9JbC8GwvLGzrusieiD
         AAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850255; x=1764455055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xzrSObhj5Wimd1cdYGg31ZDKZ8HgVQz7p6sm5WUy9Y8=;
        b=BK7mh9cMbhUejjTcXcOEZNZskDm1KvrTMvRpjQf2Q13T9biXTkZxiA3cNoQfbivtRD
         568QIqCzSd4qCYNa/6rQERF0Z7Qcl7ACvSNl51eXUI1LtpXK5FLAdHVofyQcdv1PDFr9
         KMNhyz0QE8epwqxcui75f5p6ANmyWLq2BJ7bNmvR3sRtDkWwROHTROkVr91ZA4EhmrwP
         DQLEEK+a9AFio43KXzkqrcUKaA3XERGuzYordmAJDX7pihsEA4cFF/xoOpu4cLh+Z3L8
         N2lG3wnrsjOhQT1+RwE3mjRPR3LOfZVCP1EGT4mMgieIUzlO04OSxyWu366oXwdRFoLd
         8PRA==
X-Forwarded-Encrypted: i=1; AJvYcCU018rEk8V91USkGFR6NeDUibkDWBwNvqGC3PofjYL7S9cTEcfBHqifcb71nObh4LoMO1H/1ezIoh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydxaAiG/TBtZzj77dIYiUhN2HqulYP+Fgo0gqwNMRlB0oBFwkv
	5g8GPg4YaAw1dAC1rdGa7dffVHOJBwDAjlHVpHqCwwROjl8UY3m6UNaGKE27RvDSjrU=
X-Gm-Gg: ASbGnctWxBQKpqrUzvpwh495mQA61+sZVwMUzGsajGR395+hDWE5YSHsYdd/kAhVipJ
	ZM7d1HEWD5ryALGIT2TWRRwC2WGq8yaBO+bAmNJynUQ8QeWNgVl8eF/fZidiPXAiIzHAbLhutcV
	lOHXKlekw1CpZiSPl0C1nuMO/u4EjxPq0yfi4I55s1n5pisBR0H7p33dmhrI8j5JBBxEiqweM1x
	OzCqmXNV1Dugb+OZCOpKeeESh3wI5QZEOngBygVd2vsEyRZzHa/X1JB3S1yEPOn+yTC/alFyFS3
	7xfciC1VgdIcfA1H969OMyVHC5gADP1rmhL9p5ii7MO8e4qWqpt5lpLCIS00QdDbDd95cUlRZT/
	BUZeNITojy99Fs+aISUsJUI2gMuZI1tRuZViUljiS+eX8RiH0GcIvJCEtfl2hvs6DUnQXqs73z0
	ZtJsWZkJFbT+Hhq2EznCMY7DKQPfvrCzAzaZbdFLTGztm2e1tXRP+4zJbISH1Tlz81LiIUyourN
	+8OWUU=
X-Google-Smtp-Source: AGHT+IHKuSAjgrt1dxDo5oomNcqBOfqdLocHIsya6Qr+JoT/gAP6yZKLlAopzeyv3C1y1/iPUXwmuQ==
X-Received: by 2002:a05:690c:b99:b0:786:4fd5:e5ce with SMTP id 00721157ae682-78a8b541204mr57832467b3.37.1763850255139;
        Sat, 22 Nov 2025 14:24:15 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:14 -0800 (PST)
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
Subject: [PATCH v7 09/22] MAINTAINERS: add liveupdate entry
Date: Sat, 22 Nov 2025 17:23:36 -0500
Message-ID: <20251122222351.1059049-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
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
2.52.0.rc2.455.g230fcf2819-goog


