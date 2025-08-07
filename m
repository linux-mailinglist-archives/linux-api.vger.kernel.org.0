Return-Path: <linux-api+bounces-4357-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE30B1D08D
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 03:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDEC727204
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 01:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10835263F36;
	Thu,  7 Aug 2025 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Q31CMqbt"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A42571C3
	for <linux-api@vger.kernel.org>; Thu,  7 Aug 2025 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531127; cv=none; b=aIqbNSEntOtYhsMJ7KXNv0zvCM7VwmL01/xcjcLqxEipfZDH3GRClCTiY1UCLwG+oQsI1jAbaYK6yZfejM8r6PaI9hR7dwx4eIL9cL2QR/nkRmHTiepuZ7lBZgBDaYLwR55ymtB3aZdq4eytrJQunsVsknOTNjh2p8h+oy7UlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531127; c=relaxed/simple;
	bh=UP+tTKO8bTmYY5fR3f5WgKrqzkcSSflb/PbEDUyLyGI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM7RBE2NCspvnvCgS5eWPLblGAFw3O+Od9fZKWfda5l3Z3DdTkf+IIp18bnUoGMfL9IUpp9c8k8KwDudMCC0n/sezx/H2/Q5WuGczmf+DsXjMJMkuN7B7fmxBhBF11ObnUKtoAUp6eU8hJ/I52HNzLJQXXJYf2POxOr3qtdpMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Q31CMqbt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e6399d0654so40621985a.0
        for <linux-api@vger.kernel.org>; Wed, 06 Aug 2025 18:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531123; x=1755135923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGzTQ+v+K/aDaHLB/ImuEc3dGBvilPrPVquoyLgmTGc=;
        b=Q31CMqbtC/2m7/iYzYo6w3yVUrIPBZ2T4f3K93wetHSduR9Q58N/8m4gax2mIpxC4W
         OWTBVnzfGngopUnsG4Md3DnYxOV0gmC0yXFYtvirvn37qWZ3Tbe5hKpUhD72OqpHgDr5
         MyTVIYob57EMv+igLq5GantSC4GmLxiUKFZs0W+dXKVWg2xMC0aoIo3PXrVIM/2i8jA8
         OYkxZUJ18v2ce+Rf/mPcgxygjsmeHXDjA2M23NLTUezFlTf0Vk95pPpArWsp0WrbbKwm
         LBxtXiv6dazu2CIerewSSocUVZmxxQoU2eIAxkDsc5cVzjpBqKv5uEyToKY72ftatRSs
         d+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531123; x=1755135923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGzTQ+v+K/aDaHLB/ImuEc3dGBvilPrPVquoyLgmTGc=;
        b=U7vddWR6omoJS6aLs/M+aPbaSxeQ4ZR8HQcjAWqhOdlrRC1HRXTisCV6Nsp0s6UL3n
         StO9F6ercAc4zgwqWuoIVmfqqgDe0GJDNsiRXKz78MBeX5xlLBlxQvbPQz7Fz/ywarGx
         8NIw3N32EmypfpYX0xkOaukclhyWea7z+GAf3OGPh2NqAjTxiXppfrAc87JFsrN8qk2h
         f9GnXkkWqYY3L6ev8T4Xq513wKWR+heNVHGbHK1XA+wniGRH2qVe+QKKpMF/Bd5CssU0
         GymwwGgiPi2tNR55SWid12DsyLYWcRfIIwv/kKEy02eyPEbAcs5h7ozAR9S09oPi3tue
         CSkg==
X-Forwarded-Encrypted: i=1; AJvYcCUAyXZ5KhqmTwiDoXwhkqr72rCXB5+thpC/mfhIzwain5X66L5OfX5vPtjyc9XAgP9p457iHWMYiyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7YXIn5PQl8Pav9RjkLD3TxPMyr4P1jXVS1a6iHdJSyGMPrSq
	tEOH3XlosffTZ6xHdavlpXyioWdOD/S6Ln5F/x4V9QWsk73CbQxyJztlNSTQRNIzE2o=
X-Gm-Gg: ASbGncuAQWhcgHYK6IHRj32MbBWDRemwiRO8gEFaXJHKdv1peB3IuRtnhq6DIP09fJG
	lKIUKlNdvMj2m1IUUjJGKw/WOQVn+/c53uc3A0rzAccZtvRK02it+h+wor99d32H13ju8Sv6sds
	UopjRQiygCJwjHQy6XxnPUGxbyME2xa2mH0rEuEtQCJyYxlhp6NGO+1B07f30D97cF9zh/Lo9lr
	zyV3RnYkPHzEhI6/lzSAp9bISyqNCKiF0iDEQUJFUIax5D/rovwdsSf4YRVDKDzWwij48JFqO4e
	h5K56n5zLHqR+OwSx62Qp5w3SuHsHajHThz5ymJXabRwK5RJWfFJH8+L0UC860PKydRUAzdG39I
	hFClVB5F6Shnvmm57hHdK4VmHoofUI+qkISa0osm3ly6PCF6RoutpMneey5vobTjxlASpOyotdT
	Q6d1RxnwGw2ybq9A+AbG9sYa0=
X-Google-Smtp-Source: AGHT+IFHcYm7yT/4Xvuv4TWFZXCA+gfPfNAN3UieGuxKRFyW9+H99+FaVZtYe/cgGd4cOSeq4i1AXA==
X-Received: by 2002:a05:6214:2522:b0:707:5dac:be09 with SMTP id 6a1803df08f44-7097add7f30mr59186586d6.9.1754531122925;
        Wed, 06 Aug 2025 18:45:22 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:22 -0700 (PDT)
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
Subject: [PATCH v3 24/30] docs: add luo documentation
Date: Thu,  7 Aug 2025 01:44:30 +0000
Message-ID: <20250807014442.3829950-25-pasha.tatashin@soleen.com>
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

Add the documentation files for the Live Update Orchestrator

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/admin-guide/index.rst        |  1 +
 Documentation/admin-guide/liveupdate.rst   | 16 +++++++
 Documentation/core-api/index.rst           |  1 +
 Documentation/core-api/liveupdate.rst      | 50 ++++++++++++++++++++++
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/liveupdate.rst | 25 +++++++++++
 6 files changed, 94 insertions(+)
 create mode 100644 Documentation/admin-guide/liveupdate.rst
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 259d79fbeb94..3f59ccf32760 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -95,6 +95,7 @@ likely to be of interest on almost any system.
    cgroup-v2
    cgroup-v1/index
    cpu-load
+   liveupdate
    mm/index
    module-signing
    namespaces/index
diff --git a/Documentation/admin-guide/liveupdate.rst b/Documentation/admin-guide/liveupdate.rst
new file mode 100644
index 000000000000..ff05cc1dd784
--- /dev/null
+++ b/Documentation/admin-guide/liveupdate.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Live Update sysfs
+=================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+LUO sysfs interface
+===================
+.. kernel-doc:: kernel/liveupdate/luo_sysfs.c
+   :doc: LUO sysfs interface
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </core-api/liveupdate>`
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index a03a99c2cac5..a8b7d1417f0a 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -137,6 +137,7 @@ Documents that don't fit elsewhere or which have yet to be categorized.
    :maxdepth: 1
 
    librs
+   liveupdate
    netlink
 
 .. only:: subproject and html
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
new file mode 100644
index 000000000000..41c4b76cd3ec
--- /dev/null
+++ b/Documentation/core-api/liveupdate.rst
@@ -0,0 +1,50 @@
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
+LUO Subsystems Participation
+============================
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :doc: LUO Subsystems support
+
+LUO Preserving File Descriptors
+===============================
+.. kernel-doc:: kernel/liveupdate/luo_files.c
+   :doc: LUO file descriptors
+
+Public API
+==========
+.. kernel-doc:: include/linux/liveupdate.h
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_files.c
+   :export:
+
+Internal API
+============
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_files.c
+   :internal:
+
+See Also
+========
+
+- :doc:`Live Update uAPI </userspace-api/liveupdate>`
+- :doc:`Live Update SysFS </admin-guide/liveupdate>`
+- :doc:`/core-api/kho/concepts`
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b8c73be4fb11..ee8326932cb0 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -62,6 +62,7 @@ Everything else
 
    ELF
    netlink/index
+   liveupdate
    sysfs-platform_profile
    vduse
    futex2
diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
new file mode 100644
index 000000000000..70b5017c0e3c
--- /dev/null
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Live Update uAPI
+================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+ioctl interface
+===============
+.. kernel-doc:: kernel/liveupdate/luo_ioctl.c
+   :doc: LUO ioctl Interface
+
+ioctl uAPI
+===========
+.. kernel-doc:: include/uapi/linux/liveupdate.h
+
+LUO selftests ioctl
+===================
+.. kernel-doc:: kernel/liveupdate/luo_selftests.c
+   :doc: LUO Selftests
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </core-api/liveupdate>`
-- 
2.50.1.565.gc32cd1483b-goog


