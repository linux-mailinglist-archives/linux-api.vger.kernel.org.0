Return-Path: <linux-api+bounces-5509-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F929C8614A
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 18:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D42AB350C79
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 17:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24A032C931;
	Tue, 25 Nov 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="j5aI6HAP"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAE932B9A7
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089956; cv=none; b=EX6vMtDz6lfATlH/sVWNnvoJ6X4rrO5NKgKPw9/Bt2LqY0ckcFkrqEU4WT5C6nExpxeqAcBoRov/YPMtoZwOzKEqBZOs6ocjj5ptvfgHpON7mEc1oJ9ASEdgTzBwC/QSixsm759/IS3INUx/6eHjGhCMAZOXnjq1fd4//TptBfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089956; c=relaxed/simple;
	bh=xrL/fE95vVE+j+qMFfMAEFOcWkNFadUPHDp/nSqn4jE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCPyJnWRIGpLKUl1rgjLn+wi4MjSU1tWnXcMQZvobbmbxxjsSc6nrPMj8ZCKlUPR0fMrymN8euAenfXoeX3XmQl6p7gYTKRFQYxVGEymGcG++fQzoa3vxhpldK7rLiNHCP+J6XtrXygx9b/Y/atTifMvSmZWuvBIEEWPPfHs7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=j5aI6HAP; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7895017c722so54438477b3.2
        for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 08:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089953; x=1764694753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04W1U9tqhM0nKxenqkng147mrDWDs9iksZrUOMH/VOs=;
        b=j5aI6HAPEMWqlDeC2WzvfhkPnOC620ylIFv1u/P5gaVsmnX3TbiQ3Yna+vcsuRBcxk
         kwwwLY4iJAT4zIoR/og7InAVosA5SVh4s3m7HkyHAQNFJ5RdbqT4ALIddOfb3umaYAEH
         /i9USuRFo2wWEouHtKOFy9UbOFHDgoPB3p0FvZw07pUvtjBffHYgHgyC/rBvtSNEEVmy
         NJ0AWEMQ+FAFz0ipC677QVWdKHNaFJIfKoZPioxhdLzJRCrNU6Uh2NgqOdHnnaiF+srn
         K83Vm4hrouywSZtTcbMx/zj48UwYm/lpVqvb+HXBMWsikXOb/+T3dBlPYLI8+sWQyFUk
         0f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089953; x=1764694753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=04W1U9tqhM0nKxenqkng147mrDWDs9iksZrUOMH/VOs=;
        b=a58lrdsw6WgzfrRdL5QO1L1ecsVOcb7p81P55WPj2LZ+5FoYh3VuaCSZI8pkwBsLmk
         FCUab9DmM4oFsKGQiO5Qlw+cEhQ7NAQuQx2/T2b3V6HFfnqqA8UtY4F+UvPJjvkVLNIJ
         +zCvYm2YedsCt0sUXjoVshHH98mWYMMk7O1PH7MZ8xI1Zu/cgfgVkWa9MZ8Lnrt4GQ8F
         gu5jqzFvsrkTXuGaG/ZoJTWi85OpPx0KvIO3lGi5HXpgzVRnjailhyVcEyYxMppFuQBj
         zz+BxNuFXmmWGIt6jiKCfv72YrYYUjvbqIQPQ6JeVyExHuHlHpUIcDhK60VVJkaE+0Mt
         6KOw==
X-Forwarded-Encrypted: i=1; AJvYcCUEBxX4hpTE/+afc62uOIxuG1y/9IMBH1YWd/g1i3aZbV6+1gjA0gZuQ726Lgp6HTPsZ/rdXqmVD8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2ZnSFt+6T3cRttHNrVzt5H0EwfjXIlHaL4PU5nVIeuDx5zb7
	sDcosGl4Aieb2TP4vWPbhKcWi+HsBRwCziDXQq1ozPkQIwXSn6Erk/FVHtXmwJ9hHDk=
X-Gm-Gg: ASbGncuINTEa5bs0iSQFDCbXy9qe38QZYhb/je1hkQDPbZDudh+7qRnOutlHyCCsD95
	2Liea6bs4G/GRwFUdApKv2isf9a6yJlpd7w2xLK1g4i4Da+DIx+DROD6bA5b2A72jIhciiUbPwA
	xNynv2NzZQhduOM14t4V+reN1WESTHvyvEuj9HlTCgP1/VOQ434Pdq8y9O5YFzBeGhfZpf+ppWp
	uiur9iugGTZ78tquyjF92PGti8yhFrNU1PFzv8n8TzvBE5yGVIXGgAE+vvmd/43UclXlw/ra9sL
	F942Moi3+HOQA/tEceKeKDo4ivCBNSMZMdZUCC+3mFe3kCYAKTW9jT06khQ1eqrukDs8C/M55R2
	Q9sBG4y0TTaoxiyO5cllQHl/nv33ds3JilSReRgyeYu3QjmMeOVk+Dl63QkTXr8ed/3c+xaGqjU
	CjQr/kAv87sDxx8kf9rzEvxwn/VNnbSDf5WeZ5+J8m+eoCi5rqTpee8T8sSmsCwD1O
X-Google-Smtp-Source: AGHT+IG/VheigjnnqLhidQQho4WaPxQMBWl1KDbGTnAN7GCTM0241MCFueP/x+zM5U+5JuAeLMQRDQ==
X-Received: by 2002:a05:690c:84:b0:786:8a95:1e00 with SMTP id 00721157ae682-78ab6dacefamr27675197b3.10.1764089952872;
        Tue, 25 Nov 2025 08:59:12 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:12 -0800 (PST)
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
Subject: [PATCH v8 08/18] docs: add luo documentation
Date: Tue, 25 Nov 2025 11:58:38 -0500
Message-ID: <20251125165850.3389713-9-pasha.tatashin@soleen.com>
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

Add the documentation files for the Live Update Orchestrator

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 Documentation/core-api/index.rst           |  1 +
 Documentation/core-api/liveupdate.rst      | 54 ++++++++++++++++++++++
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/liveupdate.rst | 20 ++++++++
 4 files changed, 76 insertions(+)
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 6cbdcbfa79c3..5eb0fbbbc323 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -138,6 +138,7 @@ Documents that don't fit elsewhere or which have yet to be categorized.
    :maxdepth: 1
 
    librs
+   liveupdate
    netlink
 
 .. only:: subproject and html
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
new file mode 100644
index 000000000000..cca1993008d8
--- /dev/null
+++ b/Documentation/core-api/liveupdate.rst
@@ -0,0 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Live Update Orchestrator
+========================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :doc: Live Update Orchestrator (LUO)
+
+LUO Sessions
+============
+.. kernel-doc:: kernel/liveupdate/luo_session.c
+   :doc: LUO Sessions
+
+LUO Preserving File Descriptors
+===============================
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :doc: LUO File Descriptors
+
+Live Update Orchestrator ABI
+============================
+.. kernel-doc:: include/linux/kho/abi/luo.h
+   :doc: Live Update Orchestrator ABI
+
+Public API
+==========
+.. kernel-doc:: include/linux/liveupdate.h
+
+.. kernel-doc:: include/linux/kho/abi/luo.h
+   :functions:
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :export:
+
+Internal API
+============
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_session.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :internal:
+
+See Also
+========
+
+- :doc:`Live Update uAPI </userspace-api/liveupdate>`
+- :doc:`/core-api/kho/concepts`
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b8c73be4fb11..8a61ac4c1bf1 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -61,6 +61,7 @@ Everything else
    :maxdepth: 1
 
    ELF
+   liveupdate
    netlink/index
    sysfs-platform_profile
    vduse
diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
new file mode 100644
index 000000000000..41c0473e4f16
--- /dev/null
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Live Update uAPI
+================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+ioctl interface
+===============
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :doc: LUO ioctl Interface
+
+ioctl uAPI
+===========
+.. kernel-doc:: include/uapi/linux/liveupdate.h
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </core-api/liveupdate>`
-- 
2.52.0.460.gd25c4c69ec-goog


