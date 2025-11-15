Return-Path: <linux-api+bounces-5299-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD7C60DA1
	for <lists+linux-api@lfdr.de>; Sun, 16 Nov 2025 00:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9BBE361AC3
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE2030DED9;
	Sat, 15 Nov 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Fe01lsQq"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5E30DD2A
	for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249696; cv=none; b=a7634rhUnY5LlaxZsFujrsCwhHovKE4qjx2WZ4wiB8QH2M7gTZj7eWEPQ1HVvRzwzgU+N/h8/inzIS7wvvaQP+FL6Q8Iap7JX0NVGv+XzpPQtVnzLgiehfpnbBYckbm8c09ny33fGjSiUcrlLKERblhKdlLy0BqIrQPai0cSab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249696; c=relaxed/simple;
	bh=ozB694jmbnonJd7q0YUnhbTNPWhn9EUs4khf2so6x4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aihhp08t3fJbnfC87YOOu9MumzTT5sNIJi1XThoQU7uPqqf+9DIXreYg8rsZkDUWdaxof5pvzwvpmSh3MdhxcKRSaVg6p17mTtRVMtylGOYqpdN713Fr2oe2gx3tllcD1u92jpg3osn2uPBZG2AyyqRfgyr4nDIzM3HxheXBFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Fe01lsQq; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-640d8b78608so2312700d50.1
        for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 15:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249694; x=1763854494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTOw5RLmNkeRdWzsM1mSOCwBuPeRYehGrzOUVePWwho=;
        b=Fe01lsQqg+ABF38Ii8gQw3+qtMhC+EuRx1QflpJXzZNME+8qvFr/P4UbqtHpD0evDu
         AQ7mde8yT7bKaiaWpo4MlpYZ8ziCH7yLn8Ax06mruSzgl1wnaFf6H+RJzQbhqUtx3Cd2
         e1S5SYsld6+CMOlCTP0SV6WA2ch/Xy8Q2smWrJ5nec6ZLE0VgAFechKO3KAPN5cE61O+
         3IbVe0I1b6NYK2TcrBzXfSOF0VNNgW0JzNDs5q4O8Q1cqO1ry1/3ZmWdpvx80XarZ2fn
         QvQ5Ft69wID/5KvK7WLQwd8hx+7g9XB9Cfi28uebAwQ9nefmtUOUJprapiWNVTd9ZVdP
         rGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249694; x=1763854494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fTOw5RLmNkeRdWzsM1mSOCwBuPeRYehGrzOUVePWwho=;
        b=v+wa79qH9M2pYB8RYLYlf0N3rQr5Qp5AKKQFMbl5+0O4mbT2Wlcy+oVmS4Euq5Fh3B
         24MuZNRt8isCPr9f8XcM+wNQVvisy6z9t+S/PicllrNG9DSPYCN03EKCV0pjEgjdmoJm
         qyFzrXk6zh2cg3wPhzMWu/EYIa+qKtWNwNjTwL41xDBLVYnLuV0GJ7G7zRFmq+5SzZby
         NIMkPfHhT8FZRqDI2Dx+M2onYGjieQ0ZM9NmLju/+Eyp/l6gFS65kP1ZXikCxMsR4nSQ
         fcvXVNOxFxt935o5ko9If8X0nrCWmFNkYMYE9BF3j80qHQVU8sO/PrKwtAR2ZG9+2y+P
         Ousg==
X-Forwarded-Encrypted: i=1; AJvYcCXV//VGFV2rz3mGDbobhrfAMJ5jn46aZu16RlimqyTK9BW8Dnu+GnNcdRmPEFyOJ/57hb8TmAxBQ+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK0R5Z831kUt6tCEyqpZ/sF4Gr2u+dUNKQG8bvGMTO7EhF8Td5
	v0/PkVOkeQyK7Pr/NjkHUTwv2rUBDFnLb+TIbnCRHEnVGi33GRCfl04PFVmNXdi5SOY=
X-Gm-Gg: ASbGncszACYAqX1S38vyWucL2puNMdjNr/iPRv8fWWIEwUgV/hH1yHaBdkATooHLyaB
	zqryspXMhCtePNjYgLmUuBbjjl6AoNoKHX2b6/eFoTyMhrmjeFCWQ1SzRW1xExE3yt28pGss1wD
	eTN+0zN6+YWNyRsWNdpUFVfvfANMoOqb2dtGhHIP3/w3hq9aDTZufVXtikQv+gvKVV0S+7nqTF+
	6GSGTQAeif+xutYZPfNtv9pjnGcNMbKdFNyKp57gL3+VBvZjg9H7HiAGnCdVBlJ4SWBgsxxG4zS
	5wrT7cGHXePFSHDPsFK/8lM6FGxG0hQ6v0XRclLGBQYk9R0ELE4pw+5nqBVDTEJmJ00NLETF5iF
	942em4SDApavv8siHgbWMtN83iVThVggwJc7+7DxVJUYPCQmsPauyiElEOA9lFAE5Jb2N7VXmxo
	H2VBDTjyV4+G7/AIDVwsrvfxnjKMaFyjXpHyL+DOrrlCWu0sjc5H45nuPc4BGL/SllqwsNyMuz2
	K5j8oE=
X-Google-Smtp-Source: AGHT+IE86X5p/xDAl3c7gipm+lk2CKoWWGbQ3TowepV0QBeNnwP3lOoccaKcpzs5yPfF3BpHdJYzlA==
X-Received: by 2002:a53:d006:0:b0:641:f5bc:6944 with SMTP id 956f58d0204a3-641f5bc71acmr2800491d50.72.1763249693809;
        Sat, 15 Nov 2025 15:34:53 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:52 -0800 (PST)
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
Subject: [PATCH v6 16/20] docs: add documentation for memfd preservation via LUO
Date: Sat, 15 Nov 2025 18:34:02 -0500
Message-ID: <20251115233409.768044-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
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
index deacc098d024..384de79a2457 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -28,6 +28,13 @@ Live Update Orchestrator ABI
 .. kernel-doc:: include/linux/liveupdate/abi/luo.h
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
index 000000000000..4f09c3921893
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
+.. kernel-doc:: include/linux/liveupdate/abi/memfd.h
+   :doc: DOC: memfd Live Update ABI
+
+.. kernel-doc:: include/linux/liveupdate/abi/memfd.h
+   :internal:
+
+See Also
+========
+
+- :doc:`/core-api/liveupdate`
+- :doc:`/core-api/kho/concepts`
diff --git a/MAINTAINERS b/MAINTAINERS
index ad9fee6dc605..6ffe4425adbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14470,6 +14470,7 @@ R:	Pratyush Yadav <pratyush@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
 F:	include/linux/liveupdate.h
 F:	include/linux/liveupdate/
-- 
2.52.0.rc1.455.g30608eb744-goog


