Return-Path: <linux-api+bounces-5423-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE8C7D8AC
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 23:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2161334E03D
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 22:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CFC2C3248;
	Sat, 22 Nov 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WDoNgmNa"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6424DD17
	for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850243; cv=none; b=rPjSC062VmYm8ybyLwKeMIdKPV5eBqx4oapmm4os1ScSsZEsIis3MDTC76ydB32XQfuT/BbGfQV70WvisjFQcIWcINhARGZgHn9QODChDjzbjf0jBSSt9gjgVNmpRnX8QGACfI+1Q/TMeVieeWijr0Cin/rvkOmQV6cB/s43EJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850243; c=relaxed/simple;
	bh=hPiPO5pjZbR+kxbNSrGZPyo3u+7EVTt3m9zoLAZiV3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QHEtxE5dVrliB1wHeQou3EQIaaHQSpyAtVkTe49h4e4f4V7iLx1rsj6cwUin+13+eP9KbFO6UIdEATzrrTpUp66CcRkEmNNJR3fE9++akSE4fzIgjg9+k7zg1EeVC0KobNmX+1S7j81eh0zXmmdxJmQMQdOrh3lF8zrMWTT9O98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WDoNgmNa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78665368a5cso30144527b3.3
        for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 14:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850237; x=1764455037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MMVLPogxr4xn7qzv+KlhBxAlOABfTn1sftdMF1VGngg=;
        b=WDoNgmNai7k1jskJomMSLs0Qyc3GZmNyp2TkVWREHCsiD+C2WbT8+uR6gr1zuW8G8U
         SywvVyrXXlG0pFSXaa4SmjZ2pu/uLBAGxRxpRB/QmeishD6XWvrd4/4k32nbU5MG/Tea
         eitKKcgcy/+eI78q5h3cjXgJrmi9978vO4UUrNVDOBSrAjxMesn9Ac2/sYhr99Q/+Qzw
         YCbA7gERTc7FtdJd8QcL9n3dxeD1Md37cRWq9U2XwwQOiCsAL7x1SqAjce5Z+gZ5mn8U
         vlOvo87JZsaQmDALxqEnS8i0QvLaMjXYi/oIcjQIyJa8Kj2eZcJ6W6RqJQjQWcJMHGzk
         jz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850237; x=1764455037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMVLPogxr4xn7qzv+KlhBxAlOABfTn1sftdMF1VGngg=;
        b=n19VKmq4LA1XiJZc4QgUYcpbhet/bq8G2+g+fa8wquyH415bxhR2NzUu422nJYfbq0
         qHit0v2mHq/LhRahDQRXiIsSXF7DjV028qt1RPIMaH3JJHamR1keMQYxXlp+1Zub6biv
         mTbBU6kCQxboy6XHM8cGYy0gbeb+FMOTDIQZdIBi7iW0afBp/rmKWuOR5ps4YG1IDkaI
         577b9b/7oGYoUfTocIwp6tmgVV7l4RzfzZuPcoX0yRDqwQPHfet/QLBmR6n+CgPL15Z2
         EtZraa4TahY8X4SzPpmBP7PTECaqDpV6YwYoTLYSNZ2HT4VV679Yzz7saiJR2LcanFAj
         D5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTv/bVqGGk6i9/GoZYuBrcMPduRqGIU9g9xWpKLAQybqRA7o28o8YWvIyCbOX8+56gZX4+uhbASts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJ5JFh2/eAHO9V11RveWkOwWpqMQz5Ks1tNnsaFUjQKJ3Hc71
	XpCCj5uzL7AVQizAtn95ufi3hQxHnxykgsFLMlEizKDvfoM1lAy7GH+3IBjB/aLjEEg=
X-Gm-Gg: ASbGncslqRZRdtm1y4m2uKLoDW4r+5FxwYyGI4hxahnr1yKnzhKvWruCX4Dob69nAE3
	oPtvkjizMFqS6Bj7i2ULm447q3/rriK0hHPIHbuVJ0p7sBdBZxlIE8tm/5q9mLPB+tr1wAoqFyx
	i7rItIsgIQ+UtGl59gFCvmR8JKH0SPwzz8hOFmdmvJrKKN76A+9RqyOsS3PoKHg2c5AiUsA4Qwy
	a1smEaPqlwjzn5hKH9dNXnPTj79o3DfdQ1dDuS7YlS7uhbYdqpT+SHEccAFhxCa4IkjlmdVCjm+
	sJz56BgjRKTGO0Mlc0ima03TxaUFZWkq4BhdC1dsFHEbD5efCsK2qhARjgZwJIH4/9cOtM5C6Vn
	5iTQzma7/7c0KI6+XMYqsVQSscv7dYJfZci6PpKFMV9ItitoQ0ZE4ZWFv53q+hf6d7GCdXJVnjp
	TXvdBAduFsNMdXkDsPdlZxB0WS0TVgygDEG0pUd5qwxp65OFgIfEKOeotyGpIWnHZlCl2jkbM4R
	6Mchr0=
X-Google-Smtp-Source: AGHT+IGXeP0hGbAFwfk3jugXNxMQcj4PmGg4Arhaop1PdEogmVGxKFjSmLggGBZBxrIKW7TxTkSmcQ==
X-Received: by 2002:a05:690c:e3cf:b0:78a:8516:e863 with SMTP id 00721157ae682-78a8b472025mr63326207b3.16.1763850236895;
        Sat, 22 Nov 2025 14:23:56 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:23:56 -0800 (PST)
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
Subject: [PATCH v7 00/22] Live Update Orchestrator
Date: Sat, 22 Nov 2025 17:23:27 -0500
Message-ID: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces the Live Update Orchestrator, a kernel subsystem
designed to facilitate live kernel updates using a kexec-based reboot.
This capability is critical for cloud environments, allowing hypervisors
to be updated with minimal downtime for running virtual machines. LUO
achieves this by preserving the state of selected resources, such as
memory, devices and their dependencies, across the kernel transition.

As a key feature, this series includes support for preserving memfd file
descriptors, which allows critical in-memory data, such as guest RAM or
any other large memory region, to be maintained in RAM across the kexec
reboot.

The other series that use LUO, are VFIO [1], IOMMU [2], and PCI [3]
preservations.

Github repo of this series [4].

The core of LUO is a framework for managing the lifecycle of preserved
resources through a userspace-driven interface. Key features include:

- Session Management
  Userspace agent (i.e. luod [5]) creates named sessions, each
  represented by a file descriptor (via centralized agent that controls
  /dev/liveupdate). The lifecycle of all preserved resources within a
  session is tied to this FD, ensuring automatic kernel cleanup if the
  controlling userspace agent crashes or exits unexpectedly.

- File Preservation
  A handler-based framework allows specific file types (demonstrated
  here with memfd) to be preserved. Handlers manage the serialization,
  restoration, and lifecycle of their specific file types.

- File-Lifecycle-Bound State
  A new mechanism for managing shared global state whose lifecycle is
  tied to the preservation of one or more files. This is crucial for
  subsystems like IOMMU or HugeTLB, where multiple file descriptors may
  depend on a single, shared underlying resource that must be preserved
  only once.

- KHO Integration
  LUO drives the Kexec Handover framework programmatically to pass its
  serialized metadata to the next kernel. The LUO state is finalized and
  added to the kexec image just before the reboot is triggered. In the
  future this step will also be removed once stateless KHO is
  merged [6].

- Userspace Interface
  Control is provided via ioctl commands on /dev/liveupdate for creating
  and retrieving sessions, as well as on session file descriptors for
  managing individual files.

- Testing
  The series includes a set of selftests, including userspace API
  validation, kexec-based lifecycle tests for various session and file
  scenarios, and a new in-kernel test module to validate the FLB logic.

Changelog since v6 [7]
- Collected Reviewed-by tags from Mike Rapoport,
  Pratyush Yadav, and Zhu Yanjun. Addressed all outstanding comments.
- Moved ABI headers from include/linux/liveupdate/abi/ to
  include/linux/kho/abi/ to align with other future users of KHO and KHO
  itself.
- Separated internal APIs to allow kernel subsystems to preserve file
  objects programmatically.
- Introduced struct luo_file_set to manage groups of preserved files,
  decoupling this logic from the luo_session structure. This simplifies
  internal management and serialization.
- Implemented luo_session_quiesce() and luo_session_resume() mechanisms.
  These ensure that file handlers and FLBs can be safely unregistered
  (liveupdate_unregister_file_handler, liveupdate_unregister_flb) by
  preventing new operations while unregistration is in progress.
- Added a comprehensive test orchestration framework. This includes a
  custom init process (init.c) and scripts (luo_test.sh, run.sh) to
  automate kexec testing within QEMU environments across x86_64 and
  arm64.
 
[1] https://lore.kernel.org/all/20251018000713.677779-1-vipinsh@google.com/
[2] https://lore.kernel.org/linux-iommu/20250928190624.3735830-1-skhawaja@google.com
[3] https://lore.kernel.org/linux-pci/20250916-luo-pci-v2-0-c494053c3c08@kernel.org
[4] https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v7
[5] https://tinyurl.com/luoddesign
[6] https://lore.kernel.org/all/20251020100306.2709352-1-jasonmiu@google.com
[7] https://lore.kernel.org/all/20251115233409.768044-1-pasha.tatashin@soleen.com

Pasha Tatashin (16):
  liveupdate: luo_core: Live Update Orchestrator
  liveupdate: luo_core: integrate with KHO
  kexec: call liveupdate_reboot() before kexec
  liveupdate: luo_session: add sessions support
  liveupdate: luo_core: add user interface
  liveupdate: luo_file: implement file systems callbacks
  liveupdate: luo_session: Add ioctls for file preservation
  docs: add luo documentation
  MAINTAINERS: add liveupdate entry
  selftests/liveupdate: Add userspace API selftests
  selftests/liveupdate: Add kexec-based selftest for
  selftests/liveupdate: Add kexec test for multiple and empty sessions
  selftests/liveupdate: add test infrastructure and scripts
  liveupdate: luo_file: Add internal APIs for file preservation
  liveupdate: luo_flb: Introduce File-Lifecycle-Bound global state
  tests/liveupdate: Add in-kernel liveupdate test

Pratyush Yadav (6):
  mm: shmem: use SHMEM_F_* flags instead of VM_* flags
  mm: shmem: allow freezing inode mapping
  mm: shmem: export some functions to internal.h
  liveupdate: luo_file: add private argument to store runtime state
  mm: memfd_luo: allow preserving memfd
  docs: add documentation for memfd preservation via LUO

 Documentation/core-api/index.rst              |   1 +
 Documentation/core-api/liveupdate.rst         |  71 ++
 Documentation/mm/index.rst                    |   1 +
 Documentation/mm/memfd_preservation.rst       |  23 +
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 Documentation/userspace-api/liveupdate.rst    |  20 +
 MAINTAINERS                                   |  16 +
 include/linux/kho/abi/luo.h                   | 243 +++++
 include/linux/kho/abi/memfd.h                 |  77 ++
 include/linux/liveupdate.h                    | 311 ++++++
 include/linux/shmem_fs.h                      |  23 +
 include/uapi/linux/liveupdate.h               | 216 ++++
 kernel/kexec_core.c                           |   5 +
 kernel/liveupdate/Kconfig                     |  27 +
 kernel/liveupdate/Makefile                    |   8 +
 kernel/liveupdate/luo_core.c                  | 454 ++++++++
 kernel/liveupdate/luo_file.c                  | 987 ++++++++++++++++++
 kernel/liveupdate/luo_flb.c                   | 701 +++++++++++++
 kernel/liveupdate/luo_internal.h              | 141 +++
 kernel/liveupdate/luo_session.c               | 645 ++++++++++++
 lib/Kconfig.debug                             |  23 +
 lib/tests/Makefile                            |   1 +
 lib/tests/liveupdate.c                        | 160 +++
 mm/Makefile                                   |   1 +
 mm/internal.h                                 |   6 +
 mm/memfd_luo.c                                | 517 +++++++++
 mm/shmem.c                                    |  57 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/liveupdate/.gitignore |   9 +
 tools/testing/selftests/liveupdate/Makefile   |  34 +
 tools/testing/selftests/liveupdate/config     |  11 +
 .../testing/selftests/liveupdate/do_kexec.sh  |  16 +
 tools/testing/selftests/liveupdate/init.c     | 174 +++
 .../testing/selftests/liveupdate/liveupdate.c | 348 ++++++
 .../selftests/liveupdate/luo_kexec_simple.c   |  89 ++
 .../selftests/liveupdate/luo_multi_session.c  | 162 +++
 .../testing/selftests/liveupdate/luo_test.sh  | 296 ++++++
 .../selftests/liveupdate/luo_test_utils.c     | 266 +++++
 .../selftests/liveupdate/luo_test_utils.h     |  44 +
 tools/testing/selftests/liveupdate/run.sh     |  68 ++
 41 files changed, 6235 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/mm/memfd_preservation.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst
 create mode 100644 include/linux/kho/abi/luo.h
 create mode 100644 include/linux/kho/abi/memfd.h
 create mode 100644 include/linux/liveupdate.h
 create mode 100644 include/uapi/linux/liveupdate.h
 create mode 100644 kernel/liveupdate/luo_core.c
 create mode 100644 kernel/liveupdate/luo_file.c
 create mode 100644 kernel/liveupdate/luo_flb.c
 create mode 100644 kernel/liveupdate/luo_internal.h
 create mode 100644 kernel/liveupdate/luo_session.c
 create mode 100644 lib/tests/liveupdate.c
 create mode 100644 mm/memfd_luo.c
 create mode 100644 tools/testing/selftests/liveupdate/.gitignore
 create mode 100644 tools/testing/selftests/liveupdate/Makefile
 create mode 100644 tools/testing/selftests/liveupdate/config
 create mode 100755 tools/testing/selftests/liveupdate/do_kexec.sh
 create mode 100644 tools/testing/selftests/liveupdate/init.c
 create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_kexec_simple.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_multi_session.c
 create mode 100755 tools/testing/selftests/liveupdate/luo_test.sh
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.h
 create mode 100755 tools/testing/selftests/liveupdate/run.sh


base-commit: 2cb7e27ffe3e3e1d8a837026462ebca22cba3b4f
-- 
2.52.0.rc2.455.g230fcf2819-goog


