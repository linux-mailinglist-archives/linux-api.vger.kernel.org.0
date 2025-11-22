Return-Path: <linux-api+bounces-5437-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B5C7D952
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 23:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D22A34B442
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B332E611B;
	Sat, 22 Nov 2025 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="kUNpuhcm"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A392C3248
	for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850269; cv=none; b=r1nqTfTR9/xZNPikkj2p4x7uo7YxIy/iywsLK5fO5D8aP+4w3cwaxR+YaP3wMztPzipFUwLulsY+oxYvajeh5vgz1P4032uT0kI/VWES/MiLIvx52ZEUBWDAy2s/nlaTtqZaPl5gqQ3kZd4Dj0VMG9eMhBDnDaalnanb5JjDN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850269; c=relaxed/simple;
	bh=HckDMYe0+V7dIt+99RvEfUMzQcIYTFKI66vYhRUdjQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv7UkkHxcxHc76+amV9RqYzLBTCTj/NhWiZ+ZAg6hmbnA37GVHmiQuSo4Vbf5ayVtY2GgqOj0CerOAPYXec98qqGK5iGOk3biDA6Lz1az1m3Q4JrqZ9H15B4F3hPFaNObNFMKEewsC97ZCnzmTcPJQxj3lC/kEOsbVbyDFQfHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=kUNpuhcm; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63f96d5038dso2695378d50.1
        for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850266; x=1764455066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oZaYRe5g0R4lweOQLAK81RG676DLPyUWLh/z30V3oE=;
        b=kUNpuhcmhJRzDdbopx+yw1ynUATxeENtPf4tOwHPPENr78Xz1DbY8zuYNGC0GNDPTa
         ZSk0TiTXYZP4GoAEH9ga0HJqU7yWWdru/Vbpyg2wwwpx4nYuC2OigJLFMpv3MSCnRcss
         8VgrDTkHGCLQ2t+gaP6n4rUES77FYvAgAmH9IZYo/H9rQV17xQZyJy7R5ks7GABKkWi8
         Grd5BW4wn5TyZ4RKzBrN6WPo8lbCWq4ImT2WC5mW72L4pS8dme6t1iJHvyM6T+b99QKd
         M64TuQZrRsHu4DEhr8Ss9BfKanjC9absBmTvPnBPvDDnPORW8ckvh/ZjV71fAGyb5XFP
         Xi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850266; x=1764455066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8oZaYRe5g0R4lweOQLAK81RG676DLPyUWLh/z30V3oE=;
        b=hbqhYjllp+8M4x3rpr+yZX1fTFXpm7QXA55F9B1LRo2Ml1MB+G5xw6+mJthCY/RBqm
         yA0hhOdqlmsbn27TDALYpIH/lF0aQkC7CrWuaEJqPdENv0KlsY4mkDUrKUV8MwstD20D
         79Zg/OYSkD2wmts0BmrkDszLdiZEi6T9zQaw03ue/da3vLHKYoVCw8i582rMlSBsE8Uv
         dQvzKv04cLUrExY1W3NiuPu0Np7b1AHi3sKSx+PNREC19eK6n5jBQiSV0gLtCKhyyElf
         bExpvztqukjzXa8C4CIZMKt+P1mFm89thI1/eSIzUKSwKxn44I+DKSVE4Y6H1yDaE3+g
         r/jw==
X-Forwarded-Encrypted: i=1; AJvYcCWiKSX8c2QoL6V+eJAFSd4B7QksCPS9VLU8RDgYFRrPfuLOKc+GjG3R0wpKRsRPyRRiZMJ5laVaD6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwdgpgwQVWyVE9XpPQRFqqjaJC0Lkn24WNCHPbODfeZx+ii0Sv
	1+EYPS5Amk3FNk7/Q4jZIEekFyVl/b3ycPWoJEVqemyU2gLRQh3BSGUpdzQt0OUdqD4=
X-Gm-Gg: ASbGnctgNW5X+00lqb0mtSFUlUjyIwqz8jw3f2LVdPO6IReVtulBkY/tXHKM+zhzNs0
	OWvm2m8TsSRXMH6lzPAVxVeyNlmIZ6xecb+ewtp8Toop89WIVlktX231PmWLc2K21yxfLl9QmWq
	gTo5wfollUMTLIV/hvsNRekVSV6gxveNLENSUb3FuwGDd9bVSFTogGKEnKWD6EsTs5MJhBjwhZl
	El2ixsPX8QjeI+dR7/JFxZdxGsASuJ1+Cy7jviUxfaABdyJUtsdRlFejq+zTx8HWaew5EElpWG3
	dcJPnULhbNs4XPpsfGxLUYjKgpPEnNNqWiBgCHPqIIPqNxzgCJSZn8z74jRAezprmKV63xctxwO
	T4e7gchz4VqTdVieqk+RC7LglIaX3Pu0LlHiwI3VFyQ2L8KJem3FCUdsQZddycPo7GRCLDia/wo
	qbhNoX8kzQiLRGlI4l43Lu3DRyZFqxszurDZerbESjsfnx0LykuM5pH7AVtMvrXoO1Q8T5pXntI
	YpQU1heBOeTnYXbPQ==
X-Google-Smtp-Source: AGHT+IFA8xiqyidX6vSHxt0Fa6KY7zq1D81H8XmTPSjBAk/TG7qP+fvxB9otYVm16cp+k+p4xO9fVA==
X-Received: by 2002:a05:690e:118d:b0:63f:b634:4224 with SMTP id 956f58d0204a3-64302a427cemr5083872d50.21.1763850266314;
        Sat, 22 Nov 2025 14:24:26 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:25 -0800 (PST)
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
Subject: [PATCH v7 15/22] docs: add documentation for memfd preservation via LUO
Date: Sat, 22 Nov 2025 17:23:42 -0500
Message-ID: <20251122222351.1059049-16-pasha.tatashin@soleen.com>
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

From: Pratyush Yadav <ptyadav@amazon.de>

Add the documentation under the "Preserving file descriptors" section of
LUO's documentation.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/liveupdate.rst   |  7 +++++++
 Documentation/mm/index.rst              |  1 +
 Documentation/mm/memfd_preservation.rst | 23 +++++++++++++++++++++++
 MAINTAINERS                             |  1 +
 4 files changed, 32 insertions(+)
 create mode 100644 Documentation/mm/memfd_preservation.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index e1f0c13d5b4a..b776b625c60f 100644
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
2.52.0.rc2.455.g230fcf2819-goog


