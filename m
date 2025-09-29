Return-Path: <linux-api+bounces-4967-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688B3BA7B59
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 03:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EAA3BCDE0
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 01:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA727E1D0;
	Mon, 29 Sep 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YqgwQruV"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56D26FD9D
	for <linux-api@vger.kernel.org>; Mon, 29 Sep 2025 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107885; cv=none; b=a2BOvygq4e2JNUHqcoKDMCBcESWkem5MukGdJY2jX47t3A+Rrff7JB2IB+AWvwJ/+QjkDOIWDqz8fayP/mU/aWOKM5Z1od+RgfjcBsOMnYBQ4BMVKBPl+ZziCTLhwAdHDiylII/hnwizMiN0xmJnlk+bmX0fa3DN8G1mmNur3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107885; c=relaxed/simple;
	bh=9W8xPT3N53RvPHAnS9f5/QrLnT01yqAHq2ba0G88QkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjQw8ZKYh93WhP/cLEMjw4V02MfEkYnKLjODbFFEdlkidYzPwfVMlNUs+jiVijEetpOnWKsKHHw3TUKr/Dh5o8OTeBYgEqNBy8+9JibA240HSR0wLUTxT6MAYTNXr8/xQIFDFry8nSPlUMlYZ3TeiAE6HhszFQeZoTpiGfIPR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YqgwQruV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-84dcf6f28e0so427913885a.2
        for <linux-api@vger.kernel.org>; Sun, 28 Sep 2025 18:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107882; x=1759712682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7EcpRB2lXFP1cLCapL56dmZqGYeN55I/l6E6y0w+Pw=;
        b=YqgwQruV64DhTVuvvXUghhuaB+AJDi1BI1iuUcrVyWiMrPyXJEWs/dwlNUAnUN024w
         T6KBZc/EJHoBLkXs8WfudD9QpAUfnowBYAeQDRF3q+dM8PTTf0h4bOMwKFlOTOzw4WMf
         MfKHlrAwaY6i3poHdRRD2bUgIQcABCKGgCyY1ibV04dgNPuVvvvS5BBdskC6E4FXB6ky
         rKqmCnfvb+12cLzv78dlntY4PMfABHP1UIWjLoxffc3AAsgJn07ZCy/Bwj/jO7bP4kiH
         k3YTU5+2SnVTbnsZ5O98z8ZU+Mm7SWNeahppJ9z+3NLrVs9wuHaMhAaRWlEokvGsLr0Z
         /tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107882; x=1759712682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7EcpRB2lXFP1cLCapL56dmZqGYeN55I/l6E6y0w+Pw=;
        b=otb8DPs/VOfopDMM6OauGg2eBatvMjL/JS9E0bdL5tzgUfKiNWtxeL0+ebyv4nQsuy
         EiHjGHI4HrDAkBBDSVZ4ULhVy6G97WvpJpkAFDc80TTQCnvZXELxj1XHuYzovGR+bBCx
         CF6J2Fd2glxK6h6pGHRm1gdGoPCSTKK3DwU9SZUzcxDF+u+RDxshqLS1HmTd8GfaJj2o
         0DcuO9RcWSJRClgyYCDwNv5qbTdFhQaMhZQ9xeCpPwpd+N5PrA85n/NOKjVqWncfets2
         ywoeoZS75bk3wdClMdHtcirkwUcBOksxFQny38V5erqrpdPqYB5rayJOF5ZkB7WMwCwk
         +A5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzLpl0a1l0amXNl9ffRAkU1lXxhm5GG0IEibpursP1IE99EinMjWK6Aa7b13N5bigrpdllAAkKGlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYzzNaoItH22d7TGPdN/lp0piC6tvfW8P4P2ORLiOySi7CQnt
	Hx7ok2M7XvhkJiCmW+z/8js5dANLH38HNIUx5NxC50pEonUzsdsAZiWlUyKOGJVAgrk=
X-Gm-Gg: ASbGncuGdnUYZnTfbf9MgUvITYru5GIIUcWR8t4J/16SYo3Wrd9Edp4iR2OvDFT0xRH
	WVqxPNXlbUiWlvLMg+esvhmqqj864bAIDHHelOnr+BuCYruWddeOBijyd4R4UYJesDccfHw03gG
	iTiGPtyJLGH/8soAU9FRycdAZXEM9e/2vYUVypevFMYnHhm+gwHSLIXGQZI9iC3NlnLxTuMKDQO
	EU1boUHkZByubZPsmtKHPD+az0T9mXMDmoaOBmyU1Exrn8iDWzWZ6MaxW9ceDs2C+z68An1wyUQ
	Zc5sSjZTdiZtVl6lVi67qP/6t5WHTe/ZYAj+35GjVsVSB6y2UIf/bTnGjbJdokc48o50S2zf3ZM
	gTmbLeQrC3jOIa4KEGdj5N384pA7Ymh4Waue6uJopq+Z+lD98JxBVYeaJKxgN79IIlzjD4qK1z8
	ZSxxQCy372lsvKbxPNfQ==
X-Google-Smtp-Source: AGHT+IFiLMT68nSMNgBaSuSlJ+JLaJj7OJOpOwM9krl/tnM9X12Z1SJwMWK8EaN96FbQ1GWCyUBDww==
X-Received: by 2002:a05:620a:294a:b0:864:48eb:34e with SMTP id af79cd13be357-86448eb08f9mr880925585a.55.1759107881875;
        Sun, 28 Sep 2025 18:04:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:41 -0700 (PDT)
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 20/30] MAINTAINERS: add liveupdate entry
Date: Mon, 29 Sep 2025 01:03:11 +0000
Message-ID: <20250929010321.3462457-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
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
index e5c800ed4819..e99af6101d3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14431,6 +14431,18 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
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
2.51.0.536.g15c5d4f767-goog


