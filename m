Return-Path: <linux-api+bounces-4023-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7CBAE928F
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 01:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B35716A061
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 23:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04B30AAAC;
	Wed, 25 Jun 2025 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="IT36rwuh"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA60309DC9
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893577; cv=none; b=G/3h8GF0swQeOxc3/SVd4u6pMSbvNgGj7DDQH6eBZTID5EpZdX8KQAeAAUR2pwHc4xk3YUhMdrlDkXH7byxL6Q3IVR79BEMxMkrbwG5eu/jwfpInNh/LT5d2/2PZG1Drorw+VULNhfVnL8br85tK1IMNWPxuCJK7uRDIqas65qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893577; c=relaxed/simple;
	bh=b7MJffhHKyxoq2EEBO61UbwBKxqvQbmcAkEkF6dggFE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chh0XEBFIAh1BzWvqbchLTwRUUHT1DGYFQ1qwk98HztjgPVcASDCEHWoq59dDSOT2A+Zc/EHFx0tEYUGLuQvSDgjHnc/2SL7/+wt/4D2bvWSLTb1psH7QqCya/JPx615z2teSY8GtY5cOoWIS72Fxd14/B7Lw7eYGM11iGvT2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=IT36rwuh; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e731a56e111so352412276.1
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 16:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893574; x=1751498374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNUWS5sHgPJ3/TtkkLsM0l/sndwzOVEqU/iJZvqTlnw=;
        b=IT36rwuhwDmmedMvCUyDrVi9/mH+2eAr1RbqCkVG7JmutYiS0f7XpbdAF5Cxgn8mST
         jlUxHdXirzP+dJFDAE5RmZ11KkaZA+Xx7VGXbRP6aLV3MbBr5QQWYTAcRvJpHNTG/0Se
         b9qKnq6VKxgjsHQAh1mSa5HPWUYfZfEbd/VVVHDwsG7y/wdfUHxWW8LMvRjRdR6Ie0IM
         mPPHSZCBxBjTl4IjWfajJ/PLJbvrn3Pm948G4l5K2xI9Ym+SnM7esI38oqtI6AxcyP8k
         WrlaCpkrv391UwCPcLac1oc6iDlDoD8807B4W9sf7NXD3Np2fkvdegQOu5GBpyC45KQE
         bI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893574; x=1751498374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNUWS5sHgPJ3/TtkkLsM0l/sndwzOVEqU/iJZvqTlnw=;
        b=b1KgV342AmzJfhjpqLTneXfvt3AcSnYVZZEp4uAixxnyM3Jj7dH+PMY11bXMS45thC
         YepxLeXskwZm2U21HBtDfgbSPXN3EiyzNmqz2Iey71SasuBp/xlqXwix/GkfHD5m3pyU
         2KMEQfBFcGsiE5EAshj94xWu9Td9s/xvoOxmuxpZbQL5HcXQu3AKYtmfv55YHs0umZam
         jFgIZxOHrUHC2gYwqeKMwBQTB/x3V6PY9qbSgJUK/4nh98cDwKwZtCfbYHmfGEQMSB2y
         wYwIgepBmWjFJrSwi/23TGa5jQ6xzw58cMJAtSbm+kuNBZWW6NH5gestfh8loJoGdKEw
         smrw==
X-Forwarded-Encrypted: i=1; AJvYcCUX0iRsDL2Cda5Dw7cjkrOjuoK75AVxQzQ6NvHVQ+a7C6QUZNRufYKeZlce417V5zrnqzLLQJfsR3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzclUcuMubbGgP/foBn6pXmcRGhEE6WWHTbVc2zBDxwn9G1M3Xw
	k+wIVnoQ+S2mPhNhfAL/2lf8pKV7vmZS7PuamKxS37RaBvR6oz2FSJHgcm7AZRP09bM=
X-Gm-Gg: ASbGncssKZ9aZdsxoPGpqYW+xhed697JJjyHBz8DGkMeDb3wyDgE9eie3VrdCSbY97S
	pjmDMLRfzyzUl9eXEqJCoeeAZMVbMDFMyuZxIIgfbBCc4DhR49pGpXnZyS3BJgkvOu9g+7KZB4r
	3YIOx632fCLccd/cXigN2lEcvjfy7b0/wD3UyLZrSxjYQRsL+QFG0NrHW/2ewkXTXKpqKEgszbu
	68u8WECXfiKFVrCXIUUsQc5E4d54L+Ey3E6JCu+UxIIyITNV9jYN9wTlNAN5Nhyy4exK6Ch1riM
	ZmuDcKvStV3/fDzxoURQHFTuMjIhKhNPc5rZXhLiQYOF3g1ZS0t2IiyHXaB9PC08JfXkqAw/PFp
	s7cpkBY3N14Th/eZYJNLMxF1e4PbbTt/jsQxoFMJ4vgpjKh3GsXO5
X-Google-Smtp-Source: AGHT+IFDGX7NrsfyyxA53ENg0MYMTOghBYuaJBxDrL4i/eRQ4joSzHgyrsvnmaeCiyZ/P1GWMue8rQ==
X-Received: by 2002:a05:6902:278a:b0:e85:eac6:7ae5 with SMTP id 3f1490d57ef6-e860176b5e1mr6314395276.9.1750893573720;
        Wed, 25 Jun 2025 16:19:33 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:33 -0700 (PDT)
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
Subject: [PATCH v1 29/32] docs: add documentation for memfd preservation via LUO
Date: Wed, 25 Jun 2025 23:18:16 +0000
Message-ID: <20250625231838.1897085-30-pasha.tatashin@soleen.com>
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

From: Pratyush Yadav <ptyadav@amazon.de>

Add the documentation under the "Preserving file descriptors" section of
LUO's documentation. The doc describes the properties preserved,
behaviour of the file under different LUO states, serialization format,
and current limitations.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/liveupdate.rst   |   7 ++
 Documentation/mm/index.rst              |   1 +
 Documentation/mm/memfd_preservation.rst | 138 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 4 files changed, 147 insertions(+)
 create mode 100644 Documentation/mm/memfd_preservation.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 41c4b76cd3ec..232d5f623992 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -18,6 +18,13 @@ LUO Preserving File Descriptors
 .. kernel-doc:: kernel/liveupdate/luo_files.c
    :doc: LUO file descriptors
 
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
index d3ada3e45e10..97267567ef80 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -47,6 +47,7 @@ documentation, or deleted if it has served its purpose.
    hugetlbfs_reserv
    ksm
    memory-model
+   memfd_preservation
    mmu_notifier
    multigen_lru
    numa
diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/memfd_preservation.rst
new file mode 100644
index 000000000000..416cd1dafc97
--- /dev/null
+++ b/Documentation/mm/memfd_preservation.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==========================
+Memfd Preservation via LUO
+==========================
+
+Overview
+========
+
+Memory file descriptors (memfd) can be preserved over a kexec using the Live
+Update Orchestrator (LUO) file preservation. This allows userspace to transfer
+its memory contents to the next kernel after a kexec.
+
+The preservation is not intended to be transparent. Only select properties of
+the file are preserved. All others are reset to default. The preserved
+properties are described below.
+
+.. note::
+   The LUO API is not stabilized yet, so the preserved properties of a memfd are
+   also not stable and are subject to backwards incompatible changes.
+
+.. note::
+   Currently a memfd backed by Hugetlb is not supported. Memfds created
+   with ``MFD_HUGETLB`` will be rejected.
+
+Preserved Properties
+====================
+
+The following properties of the memfd are preserved across kexec:
+
+File Contents
+  All data stored in the file is preserved.
+
+File Size
+  The size of the file is preserved. Holes in the file are filled by allocating
+  pages for them during preservation.
+
+File Position
+  The current file position is preserved, allowing applications to continue
+  reading/writing from their last position.
+
+File Status Flags
+  memfds are always opened with ``O_RDWR`` and ``O_LARGEFILE``. This property is
+  maintained.
+
+Non-Preserved Properties
+========================
+
+All properties which are not preserved must be assumed to be reset to default.
+This section describes some of those properties which may be more of note.
+
+``FD_CLOEXEC`` flag
+  A memfd can be created with the ``MFD_CLOEXEC`` flag that sets the
+  ``FD_CLOEXEC`` on the file. This flag is not preserved and must be set again
+  after restore via ``fcntl()``.
+
+Seals
+  File seals are not preserved. The file is unsealed on restore and if needed,
+  must be sealed again via ``fcntl()``.
+
+Behavior with LUO states
+========================
+
+This section described the behavior of the memfd in the different LUO states.
+
+Normal Phase
+  During the normal phase, the memfd can be marked for preservation using the
+  ``LIVEUPDATE_IOCTL_FD_PRESERVE`` ioctl. The memfd acts as a regular memfd
+  during this phase with no additional restrictions.
+
+Prepared Phase
+  After LUO enters ``LIVEUPDATE_STATE_PREPARED``, the memfd is serialized and
+  prepared for the next kernel. During this phase, the below things happen:
+
+  - All the folios are pinned. If some folios reside in ``ZONE_MIGRATE``, they
+    are migrated out. This ensures none of the preserved folios land in KHO
+    scratch area.
+  - Pages in swap are swapped in. Currently, there is no way to pass pages in
+    swap over KHO, so all swapped out pages are swapped back in and pinned.
+  - The memfd goes into "frozen mapping" mode. The file can no longer grow or
+    shrink, or punch holes. This ensures the serialized mappings stay in sync.
+    The file can still be read from or written to or mmap-ed.
+
+Freeze Phase
+  Updates the current file position in the serialized data to capture any
+  changes that occurred between prepare and freeze phases. After this, the FD is
+  not allowed to be accessed.
+
+Restoration Phase
+  After being restored, the memfd is functional as normal with the properties
+  listed above restored.
+
+Cancellation
+  If the liveupdate is canceled after going into prepared phase, the memfd
+  functions like in normal phase.
+
+Serialization format
+====================
+
+The state is serialized in an FDT with the following structure::
+
+  /dts-v1/;
+
+  / {
+      compatible = "memfd-v1";
+      pos = <current_file_position>;
+      size = <file_size_in_bytes>;
+      folios = <array_of_preserved_folio_descriptors>;
+  };
+
+Each folio descriptor contains:
+
+- PFN + flags (8 bytes)
+
+  - Physical frame number (PFN) of the preserved folio (bits 63:12).
+  - Folio flags (bits 11:0):
+
+    - ``PRESERVED_FLAG_DIRTY`` (bit 0)
+    - ``PRESERVED_FLAG_UPTODATE`` (bit 1)
+
+- Folio index within the file (8 bytes).
+
+Limitations
+===========
+
+The current implementation has the following limitations:
+
+Size
+  Currently the size of the file is limited by the size of the FDT. The FDT can
+  be at of most ``MAX_PAGE_ORDER`` order. By default this is 4 MiB with 4K
+  pages. Each page in the file is tracked using 16 bytes. This limits the
+  maximum size of the file to 1 GiB.
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </admin-guide/liveupdate>`
+- :doc:`/core-api/kho/concepts`
diff --git a/MAINTAINERS b/MAINTAINERS
index 163f38cd55b5..8114ce1be57b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14017,6 +14017,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
 F:	Documentation/admin-guide/liveupdate.rst
 F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
 F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
-- 
2.50.0.727.gbf7dc18ff4-goog


