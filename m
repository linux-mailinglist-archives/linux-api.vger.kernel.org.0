Return-Path: <linux-api+bounces-4196-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39796B0F5C7
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 16:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F7D1CC2B28
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8845C2F4A05;
	Wed, 23 Jul 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="F2oSPoWX"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307613EFF3
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282018; cv=none; b=DqT6o2FiWWcVX73vBigJxfuIrgN5PzBXyMuAE/NCkM/y7aXsRCBAR6oEBZ9qg7aL/abN5yLkyKg/Wkr5DVX2Lh/59gzgs36xhQ1loz/VmrMWQpJf5rdwc5fIt554yotEnYLJq9mgUw90tEsr4q5yA9eO9di8KrpOUZUGMBnlY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282018; c=relaxed/simple;
	bh=J4eIaLzvrDcATb4L4HQCdRlvnVDQfRNz6W/k9BWJsSM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g0S9yx403tMitMk8K+mw9Gol55Lx6MzNGcC5SOM6UrEyjHQZuX2yokSzwIHm509RZCivXfRN3g9T+CTiLmkI0zUQI58qT6txV+q6LkygPWjumjxd9xf3UtEm+IjZbMV3rz0HOG8Wy+COJzIN4UrVdAmDGg3cJNTNrMEP2NhJ6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=F2oSPoWX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-718425f1172so68312317b3.0
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 07:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282014; x=1753886814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=if8ZeEYWjW8ZrRaLafDDRFmlzkGM98gEOVQVYa5YjdE=;
        b=F2oSPoWXcenG+m8t4DRA8XtNxjpe9/A15hSdF3DQUN7fyCmgZTvIYUJRpC+2++5Px1
         fKy21YofCE96lQmnU/tPx9HV1fuljsHXDLSOQ/5pg/hQPVJk2KtG1PC58bgIKNgu58Mf
         /j8iq0d0BkKojor950kHqpaN0PiVYEsZIZxjkAGyKpP1+MXo/yhLGGjIt9tBd5LnG2GW
         YAtm0karyznRE+sHHFvNITOdXiqDDFtJUtEWtRyFXKmGa3+eF7/Iey7WcXUne1n/beCA
         6/9Ni/C5vsB2bG3Djdp5O2YZLq15CcRZt1D0UAdwApLh8uohlpqfegXNsVhyLDWOzst3
         q2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282014; x=1753886814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=if8ZeEYWjW8ZrRaLafDDRFmlzkGM98gEOVQVYa5YjdE=;
        b=VHA3OVmEQUqDqvCQFlTr9RwuPWQL9MiYAWcjuiWaCRCXF6UvVIos4/4hMXXn8xzD6a
         QJv8SZJlgzjLiKEBRZg1K5e2+Wnv7A936FgyJNV2eADdkkuXvqNxvPjFbIN+ehSTCFYe
         I4AxtPRUOh6pGAweSezkRqTfEXd1wuZk/I9Puj+dYIOPkGLbC7urdfKZpeq1kYNd1CJe
         PE2oR4ej7fYt9rF72QkydY/DDZ6jiPYEUYnknsdWG+0UOm9Oi9FrYeY+u1neS6nxBs94
         KU7W47E9YTD4cKoR4EXa3tubuw5PWUf4qj8qbvgOGDbWiQ2eL2uxWUOoo903ZSt3k1y/
         lM1g==
X-Forwarded-Encrypted: i=1; AJvYcCXBgmQbomUH/qqpLRigmcd+0v/xkjSrriQa8fDCIWUitDinrhsuYE9TYBDJDOPgXfNO8+6BFuLpMeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUyGIDbXlSJIarDum6gjT6B2DdyMCLhqre8SWmeTix/1L0553s
	q5fQG32SFml4eXv0AEg4ZXg15SJSLhfbZ5Jtf+dLrXwfd0meyUrGao8icTemh19w4BI=
X-Gm-Gg: ASbGncv6Y/WXZ4VzRb4KwwFKw+rg6PRFkzSsPXe9y5z9WUurNZn3IyW/YAYzH+bTykC
	wDTNS4Ic8p5ov1XDSlQAtoji3KdugzLbai7L5EsSDnqt0fPJkPnWGnxj4x3RCPs5r2N57TkKE8Q
	OHdF6yQZFLOZZWuvW/irfZCoBWcoAjPSFztRol6/Qzp5ScYfcLkUu0b29G6oCj+Bx7zUxtsUbM0
	+5B1uXxQVPIqvNu2cfJI4VoiRQlVlbxog8OMksp+yBmU4h3arxn1ddRwK6sQLqnhqxsYo9m9Lfj
	+PlPvjGc3oEqcyjuRGvlgF9Z1nKGwJe08rwOfDr0CYPVBbI84SiYD6VmmgSUrMnc3rXEmnTV/Y5
	xZibQCVVol9yO1WqaFYayIOvQfVrFBptw6lLz+7rVcb5Iu3gApFMLXwezUg25VmQQ0gONr0wQEM
	0XI57FNI3Fsp3vEQ==
X-Google-Smtp-Source: AGHT+IHfeyGrGpwMqWoTs+cMnz/MczOHJOsC4r/AMbo9203NvJbVmY/Eapb7Daq4cxr8/D95b08pGA==
X-Received: by 2002:a05:690c:744a:b0:719:3e4f:60f7 with SMTP id 00721157ae682-719b42b63eemr43234707b3.26.1753282014299;
        Wed, 23 Jul 2025 07:46:54 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:46:53 -0700 (PDT)
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
Subject: [PATCH v2 00/32] Live Update Orchestrator
Date: Wed, 23 Jul 2025 14:46:13 +0000
Message-ID: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the LUO, a kernel subsystem designed to
facilitate live kernel updates with minimal downtime,
particularly in cloud delplyoments aiming to update without fully
disrupting running virtual machines.

This series builds upon KHO framework by adding programmatic
control over KHO's lifecycle and leveraging KHO for persisting LUO's
own metadata across the kexec boundary. The git branch for this series
can be found at:

https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v2

Changelog from v1:
- Addressed comments from Randy Dunlap
- Fix from Pratyush Yadav for missing vm_flags update
- v1 submission had mail-server issue, hopefully it is resolved in v2.

Changelog from rfc-v2:
- Addressed review comments from Mike Rapoport, Pratyush Yadav,
  David Matlack
- Moved everything under kernel/liveupdate including KHO.
- Added a number fixes to KHO that were discovered.
- luo_files is not a registred as a subsystem.
- Added sessions support to preserved files.
- Added support for memfd (Pratyush Yadav)
- Added libluo (proposed as RFC) (Pratyush Yadav)
- Removed notifiers from KHO (Mike Rapoport)

What is Live Update?
Live Update is a kexec based reboot process where selected kernel
resources (memory, file descriptors, and eventually devices) are kept
operational or their state preserved across a kernel transition. For
certain resources, DMA and interrupt activity might continue with
minimal interruption during the kernel reboot.

LUO provides a framework for coordinating live updates. It features:
State Machine: Manages the live update process through states:
NORMAL, PREPARED, FROZEN, UPDATED.

KHO Integration:

LUO programmatically drives KHO's finalization and abort sequences.
KHO's debugfs interface is now optional configured via
CONFIG_KEXEC_HANDOVER_DEBUG.

LUO preserves its own metadata via KHO's kho_add_subtree and
kho_preserve_phys() mechanisms.

Subsystem Participation: A callback API liveupdate_register_subsystem()
allows kernel subsystems (e.g., KVM, IOMMU, VFIO, PCI) to register
handlers for LUO events (PREPARE, FREEZE, FINISH, CANCEL) and persist a
u64 payload via the LUO FDT.

File Descriptor Preservation: Infrastructure
liveupdate_register_filesystem, luo_register_file, luo_retrieve_file to
allow specific types of file descriptors (e.g., memfd, vfio) to be
preserved and restored.

Handlers for specific file types can be registered to manage their
preservation and restoration, storing a u64 payload in the LUO FDT.

User-space Interface:

ioctl (/dev/liveupdate): The primary control interface for
triggering LUO state transitions (prepare, freeze, finish, cancel)
and managing the preservation/restoration of file descriptors.
Access requires CAP_SYS_ADMIN.

sysfs (/sys/kernel/liveupdate/state): A read-only interface for
monitoring the current LUO state. This allows userspace services to
track progress and coordinate actions.

Selftests: Includes kernel-side hooks and userspace selftests to
verify core LUO functionality, particularly subsystem registration and
basic state transitions.

LUO State Machine and Events:

NORMAL:   Default operational state.
PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE
          event. Subsystems have saved initial state.
FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE
          event, just before kexec. Workloads must be suspended.
UPDATED:  Next kernel has booted via live update. Awaiting restoration
          and LIVEUPDATE_FINISH.

Events:
LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.

v1: https://lore.kernel.org/all/20250625231838.1897085-1-pasha.tatashin@soleen.com
RFC v2: https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatashin@soleen.com
RFC v1: https://lore.kernel.org/all/20250320024011.2995837-1-pasha.tatashin@soleen.com

Changyuan Lyu (1):
  kho: add interfaces to unpreserve folios and physical memory ranges

Mike Rapoport (Microsoft) (1):
  kho: drop notifiers

Pasha Tatashin (22):
  kho: init new_physxa->phys_bits to fix lockdep
  kho: mm: Don't allow deferred struct page with KHO
  kho: warn if KHO is disabled due to an error
  kho: allow to drive kho from within kernel
  kho: make debugfs interface optional
  kho: don't unpreserve memory during abort
  liveupdate: kho: move to kernel/liveupdate
  liveupdate: luo_core: Live Update Orchestrator
  liveupdate: luo_core: integrate with KHO
  liveupdate: luo_subsystems: add subsystem registration
  liveupdate: luo_subsystems: implement subsystem callbacks
  liveupdate: luo_files: add infrastructure for FDs
  liveupdate: luo_files: implement file systems callbacks
  liveupdate: luo_ioctl: add ioctl interface
  liveupdate: luo_sysfs: add sysfs state monitoring
  reboot: call liveupdate_reboot() before kexec
  liveupdate: luo_files: luo_ioctl: session-based file descriptor
    tracking
  kho: move kho debugfs directory to liveupdate
  liveupdate: add selftests for subsystems un/registration
  selftests/liveupdate: add subsystem/state tests
  docs: add luo documentation
  MAINTAINERS: add liveupdate entry

Pratyush Yadav (8):
  mm: shmem: use SHMEM_F_* flags instead of VM_* flags
  mm: shmem: allow freezing inode mapping
  mm: shmem: export some functions to internal.h
  luo: allow preserving memfd
  docs: add documentation for memfd preservation via LUO
  tools: introduce libluo
  libluo: introduce luoctl
  libluo: add tests

 .../ABI/testing/sysfs-kernel-liveupdate       |  51 +
 Documentation/admin-guide/index.rst           |   1 +
 Documentation/admin-guide/liveupdate.rst      |  16 +
 Documentation/core-api/index.rst              |   1 +
 Documentation/core-api/kho/concepts.rst       |   2 +-
 Documentation/core-api/liveupdate.rst         |  57 ++
 Documentation/mm/index.rst                    |   1 +
 Documentation/mm/memfd_preservation.rst       | 138 +++
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 Documentation/userspace-api/liveupdate.rst    |  25 +
 MAINTAINERS                                   |  20 +-
 include/linux/kexec_handover.h                |  53 +-
 include/linux/liveupdate.h                    | 235 +++++
 include/linux/shmem_fs.h                      |  23 +
 include/uapi/linux/liveupdate.h               | 265 +++++
 init/Kconfig                                  |   2 +
 kernel/Kconfig.kexec                          |  14 -
 kernel/Makefile                               |   2 +-
 kernel/liveupdate/Kconfig                     |  90 ++
 kernel/liveupdate/Makefile                    |  13 +
 kernel/{ => liveupdate}/kexec_handover.c      | 556 +++++-----
 kernel/liveupdate/kexec_handover_debug.c      | 222 ++++
 kernel/liveupdate/kexec_handover_internal.h   |  45 +
 kernel/liveupdate/luo_core.c                  | 525 ++++++++++
 kernel/liveupdate/luo_files.c                 | 946 ++++++++++++++++++
 kernel/liveupdate/luo_internal.h              |  47 +
 kernel/liveupdate/luo_ioctl.c                 | 192 ++++
 kernel/liveupdate/luo_selftests.c             | 344 +++++++
 kernel/liveupdate/luo_selftests.h             |  84 ++
 kernel/liveupdate/luo_subsystems.c            | 420 ++++++++
 kernel/liveupdate/luo_sysfs.c                 |  92 ++
 kernel/reboot.c                               |   4 +
 mm/Makefile                                   |   1 +
 mm/internal.h                                 |   6 +
 mm/memblock.c                                 |  56 +-
 mm/memfd_luo.c                                | 501 ++++++++++
 mm/shmem.c                                    |  52 +-
 tools/lib/luo/LICENSE                         | 165 +++
 tools/lib/luo/Makefile                        |  45 +
 tools/lib/luo/README.md                       | 166 +++
 tools/lib/luo/cli/.gitignore                  |   1 +
 tools/lib/luo/cli/Makefile                    |  18 +
 tools/lib/luo/cli/luoctl.c                    | 178 ++++
 tools/lib/luo/include/libluo.h                | 128 +++
 tools/lib/luo/include/liveupdate.h            | 265 +++++
 tools/lib/luo/libluo.c                        | 203 ++++
 tools/lib/luo/tests/.gitignore                |   1 +
 tools/lib/luo/tests/Makefile                  |  18 +
 tools/lib/luo/tests/test.c                    | 848 ++++++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |   7 +
 tools/testing/selftests/liveupdate/config     |   6 +
 .../testing/selftests/liveupdate/liveupdate.c | 356 +++++++
 55 files changed, 7095 insertions(+), 417 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-liveupdate
 create mode 100644 Documentation/admin-guide/liveupdate.rst
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/mm/memfd_preservation.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst
 create mode 100644 include/linux/liveupdate.h
 create mode 100644 include/uapi/linux/liveupdate.h
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (74%)
 create mode 100644 kernel/liveupdate/kexec_handover_debug.c
 create mode 100644 kernel/liveupdate/kexec_handover_internal.h
 create mode 100644 kernel/liveupdate/luo_core.c
 create mode 100644 kernel/liveupdate/luo_files.c
 create mode 100644 kernel/liveupdate/luo_internal.h
 create mode 100644 kernel/liveupdate/luo_ioctl.c
 create mode 100644 kernel/liveupdate/luo_selftests.c
 create mode 100644 kernel/liveupdate/luo_selftests.h
 create mode 100644 kernel/liveupdate/luo_subsystems.c
 create mode 100644 kernel/liveupdate/luo_sysfs.c
 create mode 100644 mm/memfd_luo.c
 create mode 100644 tools/lib/luo/LICENSE
 create mode 100644 tools/lib/luo/Makefile
 create mode 100644 tools/lib/luo/README.md
 create mode 100644 tools/lib/luo/cli/.gitignore
 create mode 100644 tools/lib/luo/cli/Makefile
 create mode 100644 tools/lib/luo/cli/luoctl.c
 create mode 100644 tools/lib/luo/include/libluo.h
 create mode 100644 tools/lib/luo/include/liveupdate.h
 create mode 100644 tools/lib/luo/libluo.c
 create mode 100644 tools/lib/luo/tests/.gitignore
 create mode 100644 tools/lib/luo/tests/Makefile
 create mode 100644 tools/lib/luo/tests/test.c
 create mode 100644 tools/testing/selftests/liveupdate/.gitignore
 create mode 100644 tools/testing/selftests/liveupdate/Makefile
 create mode 100644 tools/testing/selftests/liveupdate/config
 create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c

-- 
2.50.0.727.gbf7dc18ff4-goog


