Return-Path: <linux-api+bounces-5516-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CDCC8619F
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 18:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A36F235222C
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311853314DE;
	Tue, 25 Nov 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QFRoAdF3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37732AAC8
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089980; cv=none; b=ct1rhe0/wQUC5Z6tmwbR79CNxY28qecOunh4OsNanBUC/uxmBLdlFGonyb2mvvZ1i66X5z/3PnweVYNqcgqvDWFqXBPbSSwT4WVt3j+ulvm/tu2medwU6tQsC07FnsbPcF2rHbrdgShPb23O7qMYomMyrCg+vDKoOtV5A4BNDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089980; c=relaxed/simple;
	bh=fychgt9nAVC6qlaQbGXvu+POyBVW9WjNWP+jjeOAE6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwcrPPZKc3FdTNMUMF6hcUhPyXsbn2FFlWCgrJDozyzHx640kdrAaw0R/hWe65j8Vj6KF9ON2BsghNoQgIv6TVXZjC41UoQMbpo4MxvXOWENJsk3yo9+cDlC+bx3fHafKOyFWO7mps2ID2UWoO1W0kb8WIoW6NZ6iBrv2Xu9U/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=QFRoAdF3; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f996d4e1aso6067493d50.0
        for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 08:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089976; x=1764694776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKFulOeeZC8khoIo0yKZZlpL1Ef0ob1cKcWS/buX2aU=;
        b=QFRoAdF3IFRPlbySoUDhL6X3A/qQ0oyijI7bkI/Dl/z7Cbhvia/AZ4zE3Ex6J6h6ro
         h3zKdjHMyfYexWkM1dHg690qtCGlpYwPNC1XkdQldRKhR5Nr29oZdxj5GD8r31Wa8iq5
         sTpZxldZSHHzGNHhNXiK1NVfWY09tPyCd6wDnRcmZQLPExPEf3JuTic5bOKQtsGFHYvA
         41SM3gDNZNKe8HgcqpGm8tkE9f1zzaVtWJPKE6QuHcye1wwgNNUV4sJDj8udaJl0Tpnm
         crXunP2f0rHlCq7vRIt8v3iS84L+37VEukQp5xyqK53ptQEBGgXb3vzpWK89maOJKs/A
         cbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089976; x=1764694776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RKFulOeeZC8khoIo0yKZZlpL1Ef0ob1cKcWS/buX2aU=;
        b=oXqN1KjDjSpN4javc9G8jwfrYZw4p6mCvgQaj79vMWNPo14yzjSsaonFky4YPPKDSA
         RDA7hm5vxg3TGfxdnu7F8VUmXpphAUuu2u6IMXbTeuUOy0Oci94SwPpg9SCICshrJQEO
         MI0VNvs/1XubBF7sUdDjJ0YomJLbSKFpYHVkAeZDfctNxxWAXAoCwehYlGuOl3hpMEg8
         ob6ZU0vVSaHkX6mzHSsMRLGSAGQXARg5w4ps6oLg6VA1YkY8jXv5Qx2U+wM2R9UH4oJD
         SGWfGCxUEvztsFkWzbSe0KiygDx9OVA5vU7t+lpYMWGzq1yEazlt6/ureoIbu9bWwATk
         IJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCVyXQKAVflBaV2BpYcBkuceQM3gcoI7uJ8KjhIH9evynwLDEWzdM/H2ptRL4RyQpo7ZCMZd8DyUJEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Antvz6z6jJoRrDDxRpOv/43AmjmPb4g0aBN06H627tiSdqrs
	gr4fmh5yyq1qU7HhIQiLfH2RbehhYyzlJlLwmzloeGExIHtdo6VAfXkD6mPlVl6L/Tk=
X-Gm-Gg: ASbGnctPUeWp2tPMeVzaGeqfM+WTD/E0LiiFnZxcqdksPMdLPprhkhrYGj6dqmOsyJb
	ycSdrrjQZIHwyNuobpcc2MFfCRtqN/L7mfRx5fZuibwg8UVGgTEOev71d0xzYKkNI8s/WdEPzeH
	PsZDvhVJE67KxksiYToumWA+jEC7aezW2Oh8hRBrzHf74fTzg9gpZn7CKmNR6tSlWQzwALSqlJ5
	Ynkhx7ySxI2byMEdXl2Wl82vCUuFAAe3eVKC2RreWzGZGSi9AeDz04AzZE6c62ZIykjgplPXqcG
	zilm9Zu7EGY5wQBHn2zcbQwHVtJBQZbuJykViIWvYh0X/D3aeuxfgx8haDaZBE9KBWss0F0EFv5
	B4htWyfeGar4oq4v3yS8uBWT8xkIquFcVFPi9Nds585nPWz7RjrIBlaYnC/Sxwrx6eVDe9UkgnR
	NbwZ8M+SIZ+sW5VW4F1esuRRMc2QL6Vx1e5oRYmJrVYtc+wseOgUZ+jI+WIx2DQKke68DEZLEDL
	sc=
X-Google-Smtp-Source: AGHT+IFFyrvPeYSGKaZ2gflHxpJKasjuM+nfTPdri6fpn7nF6c9WwHVJYxBbdaTgAkmoqf3bueMENQ==
X-Received: by 2002:a53:d057:0:10b0:63f:a3d8:1b0e with SMTP id 956f58d0204a3-64302a3aa73mr10362858d50.12.1764089976255;
        Tue, 25 Nov 2025 08:59:36 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:35 -0800 (PST)
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
Subject: [PATCH v8 15/18] docs: add documentation for memfd preservation via LUO
Date: Tue, 25 Nov 2025 11:58:45 -0500
Message-ID: <20251125165850.3389713-16-pasha.tatashin@soleen.com>
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

From: Pratyush Yadav <ptyadav@amazon.de>

Add the documentation under the "Preserving file descriptors" section of
LUO's documentation.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 Documentation/core-api/liveupdate.rst   |  7 +++++++
 Documentation/mm/index.rst              |  1 +
 Documentation/mm/memfd_preservation.rst | 23 +++++++++++++++++++++++
 MAINTAINERS                             |  1 +
 4 files changed, 32 insertions(+)
 create mode 100644 Documentation/mm/memfd_preservation.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index cca1993008d8..7960eb15a81f 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -23,6 +23,13 @@ Live Update Orchestrator ABI
 .. kernel-doc:: include/linux/kho/abi/luo.h
    :doc: Live Update Orchestrator ABI
 
+The following types of file descriptors can be preserved
+
+.. toctree::
+   :maxdepth: 1
+
+   ../mm/memfd_preservation
+
 Public API
 ==========
 .. kernel-doc:: include/linux/liveupdate.h
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index ba6a8872849b..7aa2a8886908 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -48,6 +48,7 @@ documentation, or deleted if it has served its purpose.
    hugetlbfs_reserv
    ksm
    memory-model
+   memfd_preservation
    mmu_notifier
    multigen_lru
    numa
diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/memfd_preservation.rst
new file mode 100644
index 000000000000..66e0fb6d5ef0
--- /dev/null
+++ b/Documentation/mm/memfd_preservation.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==========================
+Memfd Preservation via LUO
+==========================
+
+.. kernel-doc:: mm/memfd_luo.c
+   :doc: Memfd Preservation via LUO
+
+Memfd Preservation ABI
+======================
+
+.. kernel-doc:: include/linux/kho/abi/memfd.h
+   :doc: DOC: memfd Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/memfd.h
+   :internal:
+
+See Also
+========
+
+- :doc:`/core-api/liveupdate`
+- :doc:`/core-api/kho/concepts`
diff --git a/MAINTAINERS b/MAINTAINERS
index 425c46bba764..cabbf30d50e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14473,6 +14473,7 @@ R:	Pratyush Yadav <pratyush@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
 F:	include/linux/liveupdate.h
 F:	include/linux/liveupdate/
-- 
2.52.0.460.gd25c4c69ec-goog


