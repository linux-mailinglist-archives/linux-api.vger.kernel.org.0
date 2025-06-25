Return-Path: <linux-api+bounces-4017-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89EBAE927A
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 01:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C866A78C7
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 23:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1B2F0E48;
	Wed, 25 Jun 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="zw3yTgFD"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237322E543C
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893566; cv=none; b=glbdCLErnzH2Jt8ILa0V9dpCODznSstBuX58PUgy+tP0Ltc5rvF32dLIYq7PVBkkfN1GVPybKoaLGrnvz26DlKmhKmZpK/IXWmZFboPTOjiaGvKzAvl8QuYOvuEciibQkPFQod4e5YG9VPF9qbwNQsyHuvobdQITg2XcL7PDlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893566; c=relaxed/simple;
	bh=3Bs7yjVCwVYzX1qp5XJYtcpXHYaHTnRk2TWgFXsiFjo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ac2tsals+beddP+oXVFFQvWL7Hpp/xyNJdnwB1SWVi6RCkUsWiMLn8xHXBtB8T1I9KEQLviiaztRFtzPKQtoST0/TE9Kqp5iOZpnYnHgf3AZKeNEa0kWCaTfPwtnD0DXjs2B9qIZs6NidSRWcJsmAnIXQnuMlhfsf0oI2Nk3KfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=zw3yTgFD; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e740a09eae0so340218276.1
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893563; x=1751498363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC1ayEHkvN6ijinKURZBxrM3hNqjaSgPk5qZ/n3J1rM=;
        b=zw3yTgFDvVJTqB0CEMS6xo5qxldQbFl/tSMptiy1NkIiEtElya3EdUzXOOr7oaqOjy
         u9AyLhppc/fHCGFkRsYceqz+3zuxSylHWa4dzkbnmFJvvF/rnUsHbx/pYRBxp8WLLkVh
         LY+B+0E8wSK59Qaz8cFiP5zzS3GcasQ4zVqy1d7/8VQnErKzFcTUV3P73YFFx0xpS6LZ
         BXfA1bg35SD3zsvfJbFrET2epw5RtkHWtknrkXTvywYwBrzrMZm9o+pNDKKg6CNs6Ehy
         4YSwZLvj3L7Ft+bBVN9KPZJVIXYKVZQsS5M58vJFYyWJNhtmBLNNkLkyxIuqandS9I/5
         Wizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893563; x=1751498363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC1ayEHkvN6ijinKURZBxrM3hNqjaSgPk5qZ/n3J1rM=;
        b=inJd9GFyIRVMhQcVfeS42z1aGFvL5dGHULqaZkVOqkt/e2BOGiwJzGjSbhR5/Tt8RR
         QHXa2P+AomIXqGpuYoZV8ymE1ZVTG98p3fqwzUoas4Ba0L7JhdFLkR+Swb6m/N12tR+p
         AdeybKtOjeS4YFESOXIefssrEf/v9mSixXYGlTeCmcCFUSrjpsufHWWEcPGoPkbihczQ
         KS4MmyEgs2ZNADCYUxWAwrL7YbjBY25tTW1vyaZijIu+d+qC1TzQj+PiwqO189xGPDPz
         At+FuxPJqzpf0HfA0VL1yM2dLEgtuQGNPKxC6sdgYHUMNPnG3wvQVbRzcnf2Z6Q+HKj2
         ssUg==
X-Forwarded-Encrypted: i=1; AJvYcCXHlZ3fAIOgerih9koGCxyvZF4dklgf9xy7vj+/9SdKTgcFwh+d40dNVUavwId3EKR4kBvRFUQVMmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn7VDW8Z7jxJefh9VZb+s/SgmDi+MKrWGfBpLuOUcZIQbebhWm
	BvKK/sPNUZ87m4m6cjjXSqPpAjsjbLTpQnoKF+9S5JmJxOjcQPQLNHss8wXYNRSkUzQ=
X-Gm-Gg: ASbGncviWLZL1bgcaipeQ5WQeEs16zi5laB2be89CXJca2FTt4sHt8xxtzXmix1dEYw
	Cuf1mMLMMDWXpsSHfRq3uWrYpxcV30Rg45CvBQs97pJl8YDK271F6JXPet1QxSK/qCAQKq7Ntfh
	qjCI1Zb6tgvA6GuA5RQttCzswfVk85FMSxD46R8tEeDLuTHOD3GHo7BaaHzGgTbEvvcb2lr4p4Q
	KpYLFoULi7W5TRg6VAG+56qF+b5lDfUgBNqaZLybtbT/YOtOuWgH4RLtfKPjmXVymInDNxt6m6d
	km7rHwQ6DiLjqMy9iLx1OxThYD4fzbhFBOQ/nyZDtCC79qu/0+u1j7TYG3JHqDAuFhLi+N+EDnm
	o1cK+/+CmzctvQ5furJty06JPcIehjzxO9qa9XISh2y/Dz9B3EyYE
X-Google-Smtp-Source: AGHT+IFnAI1qCvNBz4mB5Q4FSGHdp5ZaV6ywIeny7tCD+W481rJiP0KC7KdFe65zVWMeF3cIUgLqHw==
X-Received: by 2002:a05:6902:1205:b0:e84:4341:4101 with SMTP id 3f1490d57ef6-e86016d1768mr7606110276.10.1750893563223;
        Wed, 25 Jun 2025 16:19:23 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:22 -0700 (PDT)
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
Subject: [PATCH v1 23/32] docs: add luo documentation
Date: Wed, 25 Jun 2025 23:18:10 +0000
Message-ID: <20250625231838.1897085-24-pasha.tatashin@soleen.com>
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
index 7a4ca18ca6e2..a79d806f2c8e 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -136,6 +136,7 @@ Documents that don't fit elsewhere or which have yet to be categorized.
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
2.50.0.727.gbf7dc18ff4-goog


