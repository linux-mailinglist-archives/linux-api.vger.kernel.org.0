Return-Path: <linux-api+bounces-4948-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AF2BA7A72
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 03:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443421757BA
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 01:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B531C54AF;
	Mon, 29 Sep 2025 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="icvHwQhB"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC628EB
	for <linux-api@vger.kernel.org>; Mon, 29 Sep 2025 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107815; cv=none; b=tfTbS+XOe0DF148L2EmCQOuc1DOxfUN7eUB4Qa3qXxdxkDxLpXqNdWCwudN8JH6QWcBgnELCJgDk6r+qevkxce4b4NqQ8VP7gZyezuM6IW1dLf7jYt2w24VXHRVd+Tj58S2nR5b1hwFCFsu2JjFb9iSJCgsX9gcCUS6oHmsH6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107815; c=relaxed/simple;
	bh=zJ0ndXB5pIVHc8rtgviO+MpAzbXlziPyCt0KNqxYU/0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bMBipnI5jlN7dVNBWRMeuQMghmpTuCIiESBeY+zMHkglXDUnRC3EnAacVzZYPI9zIU2HHiy3ct3a06Um5HjO8LXg6zHiA6bbiJfKhV7cbB0enn00VECY5AUqrQ4bI3i6MKX92cS2bMgotJG1SlVwMJ9gBNVADQRZ9GiC7ZWg8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=icvHwQhB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4db0b56f6e7so34619521cf.1
        for <linux-api@vger.kernel.org>; Sun, 28 Sep 2025 18:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107811; x=1759712611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx2NUMjo1lV2HrEdGE9/MkxnCEs7/OOXznUHgDJat/A=;
        b=icvHwQhBvPOZakB7fqxquCixbHDDLtIIVkwcXgt30bwe3AB7UijAg5Dtgb/2XFU53I
         LgTuKBA7kC+EZURaIu8Fo21EmPmz/0ctQTY3R4FDZomkT/Y0QYuGR0+YVnYEl9Rn2Mk2
         CpUOcNoojZi+cOoYAqKQ1wevV9PkciCNdxiNZFOyYNTbkvU0eunLZjNErpQ5Ws6PZBVY
         Hsz5jq3155G+W8ELw3IPwR+93EI5rCWAwXOIsAWgE/xbvUAjrxgomRdRkYY/YXYZnMXy
         mmGu0IaBGhMuM5mgm/ytcFBL95EjLbUTRLMIBDq4sU86qky06NXYlK7aMivYiRe2bWFQ
         D2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107812; x=1759712612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx2NUMjo1lV2HrEdGE9/MkxnCEs7/OOXznUHgDJat/A=;
        b=mF2p8zZ/9GZXZCJfBZneyCDxeX+UEW9J8avdpAlda5WfZl1A4SyzKeUVfkrnhLHivd
         0grmcltFeYQIMciKjwqIFX5gea64deMs3djSw+rKaLj4bTENfkkcIjXK+Wa9iHwdPIZt
         J96H2n+rAz3XiASFaoeVAtRtCWYDHjpgSU5hcSaNgMI0wySjtLbRFEKJBpx661PxkYdZ
         Zn4+O0n1/NgfeqqYmJbbGlGAw5GIzwnBCBsOYoU1lKLoWEJlCjTlZQT9stoKOvoBjxt9
         /q7ruAwm559K7wtzp/6I04lGQAIcofeRT0lQuvs7HQczsetpNcaUXUx5wGeG4+AuaSG0
         VS+g==
X-Forwarded-Encrypted: i=1; AJvYcCXBPy6+h7O9Xx5ue3U8IbEGH5D3bvjCu6bHO+4QXE+Cw8P4oVP73aop4cdxyEmZV18Oq5K7hFUHcQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzC+8xZ1wEkMuw1ZtSe3IOhUR/6l7dQIMxqBDr1qQs32unZWye
	PL1DKEUXD+67jCyHW+VwXGOaFoImV5dDi5kef9+3d+QqbessS3+0bUs7t6WdOIV7rZM=
X-Gm-Gg: ASbGncsBXSF6MzXm7WRfoF6UwQOMSxFfWaGgwNFkazGilxq3WmaIhP1W0oPs16C5Dg9
	X65J2YCQlPzI6Y+4yUv2ykLUNMnON6er/4vBCARIl+eLOdROSqd5igMrTYoQtz8hP4QM1qypjGT
	9cSzyXDbfvOMGTrt7HsBs1oG0uT4OkLPIbUKDcdHFIVPCD6d3OGV9Y6i+P/RAKSezF+qMnIz0rT
	KWik/sv9U/Pz4U6xT38X78cgDvZCj1rJPjXcObViPjMYmIVB8xOi1l/1lHrF0bXVfG9daUUfToG
	QXY5gCdfkx8JuKH2JC9so1nevA5gG1RZhgfireiRay82bUS3HcvAnqxPtUGNvTCUF42YW4eO9Oi
	Z4uqrqj8mQVZYsP3efNoxxescYs+TfGrsJnA9NGwG13XutSL7BK0Np9jXc7jU9OC9Rkw4bi1yMd
	o7TyOBihKXpjoxaQGKgQ==
X-Google-Smtp-Source: AGHT+IHvfQHKNIJph8GKuLGIcgL+56dTeKXQ7+SUATkT/idInZP7Lsbeg86nPFDUslPD6Un+9PFCAA==
X-Received: by 2002:a05:622a:2cd:b0:4b7:b15b:65e7 with SMTP id d75a77b69052e-4ded2c7eb63mr89972641cf.5.1759107811442;
        Sun, 28 Sep 2025 18:03:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:03:30 -0700 (PDT)
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
Subject: [PATCH v4 00/30] Live Update Orchestrator
Date: Mon, 29 Sep 2025 01:02:51 +0000
Message-ID: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the Live Update Orchestrator (LUO), a kernel
subsystem designed to facilitate live kernel updates. LUO enables
kexec-based reboots with minimal downtime, a critical capability for
cloud environments where hypervisors must be updated without disrupting
running virtual machines. By preserving the state of selected resources,
such as file descriptors and memory, LUO allows workloads to resume
seamlessly in the new kernel.

The git branch for this series can be found at:
https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v4

The patch series applies against linux-next tag: next-20250926

While this series is showed cased using memfd preservation. There are
works to preserve devices:
1. IOMMU: https://lore.kernel.org/all/20250928190624.3735830-16-skhawaja@google.com
2. PCI: https://lore.kernel.org/all/20250916-luo-pci-v2-0-c494053c3c08@kernel.org

=======================================================================
Changelog since v3:
(https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@soleen.com):

- The main architectural change in this version is introduction of
  "sessions" to manage the lifecycle of preserved file descriptors.
  In v3, session management was left to a single userspace agent. This
  approach has been revised to improve robustness. Now, each session is
  represented by a file descriptor (/dev/liveupdate). The lifecycle of
  all preserved resources within a session is tied to this FD, ensuring
  automatic cleanup by the kernel if the controlling userspace agent
  crashes or exits unexpectedly.

- The first three KHO fixes from the previous series have been merged
  into Linus' tree.

- Various bug fixes and refactorings, including correcting memory
  unpreservation logic during a kho_abort() sequence.

- Addressing all comments from reviewers.

- Removing sysfs interface (/sys/kernel/liveupdate/state), the state
  can now be queried  only via ioctl() API.

=======================================================================

What is Live Update?

Live Update is a kexec-based reboot process where selected kernel
resources (memory, file descriptors, and eventually devices) are kept
operational or their state is preserved across a kernel transition. For
certain resources, DMA and interrupt activity might continue with
minimal interruption during the kernel reboot.

LUO provides a framework for coordinating live updates. It features:

State Machine
Manages the live update process through states: NORMAL, PREPARED,
FROZEN, UPDATED.

Session Management
==================
Userspace creates named sessions (driven by LUOD: Live Update
Orchestrator Daemon, see: https://tinyurl.com/luoddesign), each
represented by a file descriptor. Preserved resources are tied to a
session, and their lifecycle is managed by the session's FD, ensuring 
automatic cleanup if the controlling process exits unexpectedly.
Furthermore, sessions can be finished, prepared, and frozen
independently of the global LUO states. This granular control allows a
VMM to serialize and resume specific VMs as soon as their resources are
ready, without having to wait for all VMs to be prepared.

After a reboot, a central live update agent can retrieve a session
handle and pass it to the VMM process, which then restores its own file
descriptors. This ensures that resource allocations, such as cgroup
memory charges, are correctly accounted against the workload's cgroup
instead of the administrative agent's.

KHO Integration
===============
LUO programmatically drives KHO's finalization and abort sequences
(KHO may soon to become completely stateless, which will make KHO
interraction with LUO even simpler:
https://lore.kernel.org/all/20250917025019.1585041-1-jasonmiu@google.com)

KHO's debugfs interface is now optional, configured via
CONFIG_KEXEC_HANDOVER_DEBUG. LUO preserves its own metadata via KHO's
kho_add_subtree() and kho_preserve_phys() mechanisms.

Subsystem Participation
=======================
A callback API, liveupdate_register_subsystem(), allows kernel
subsystems (e.g., KVM, IOMMU, VFIO, PCI) to register handlers for LUO
events (PREPARE, FREEZE, FINISH, CANCEL) and persist a u64 payload via
the LUO FDT.

File Descriptor Preservation
============================
An infrastructure (liveupdate_register_file_handler, luo_preserve_file,
luo_retrieve_file) allows specific types of file descriptors (e.g.,
memfd, vfio) to be preserved and restored within a session. Handlers for
specific file types can be registered to manage their preservation,
storing a u64 payload in the LUO FDT.

Userspace Interface
===================
ioctl (/dev/liveupdate): The primary control interface for creating and
retrieving sessions, triggering global LUO state transitions (prepare,
finish, cancel), and managing preserved file descriptors within a
session.

sysfs (/sys/kernel/liveupdate/state)
A read-only interface for monitoring the current LUO state.

Selftests
=========
Includes kernel-side hooks and an extensive userspace selftest suite to
verify core LUO functionality, including subsystem registration, state
transitions, and complex multi-kexec session lifecycles.

LUO State Machine and Events
============================
NORMAL:   Default operational state.
PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE event.
          Subsystems have saved initial state.
FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE event,
          just before kexec. Workloads must be suspended.
UPDATED:  Next kernel has booted via live update, awaiting restoration
          and LIVEUPDATE_FINISH.

Events
LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.

Mike Rapoport (Microsoft) (1):
  kho: drop notifiers

Pasha Tatashin (24):
  kho: allow to drive kho from within kernel
  kho: make debugfs interface optional
  kho: add interfaces to unpreserve folios and page ranes
  kho: don't unpreserve memory during abort
  liveupdate: kho: move to kernel/liveupdate
  liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
  liveupdate: luo_core: integrate with KHO
  liveupdate: luo_subsystems: add subsystem registration
  liveupdate: luo_subsystems: implement subsystem callbacks
  liveupdate: luo_session: Add sessions support
  liveupdate: luo_ioctl: add user interface
  liveupdate: luo_file: implement file systems callbacks
  liveupdate: luo_session: Add ioctls for file preservation and state
    management
  reboot: call liveupdate_reboot() before kexec
  kho: move kho debugfs directory to liveupdate
  liveupdate: add selftests for subsystems un/registration
  selftests/liveupdate: add subsystem/state tests
  docs: add luo documentation
  MAINTAINERS: add liveupdate entry
  selftests/liveupdate: Add multi-kexec session lifecycle test
  selftests/liveupdate: Add multi-file and unreclaimed file test
  selftests/liveupdate: Add multi-session workflow and state interaction
    test
  selftests/liveupdate: Add test for unreclaimed resource cleanup
  selftests/liveupdate: Add tests for per-session state and cancel
    cycles

Pratyush Yadav (5):
  mm: shmem: use SHMEM_F_* flags instead of VM_* flags
  mm: shmem: allow freezing inode mapping
  mm: shmem: export some functions to internal.h
  luo: allow preserving memfd
  docs: add documentation for memfd preservation via LUO

 Documentation/core-api/index.rst              |   1 +
 Documentation/core-api/kho/concepts.rst       |   2 +-
 Documentation/core-api/liveupdate.rst         |  64 ++
 Documentation/mm/index.rst                    |   1 +
 Documentation/mm/memfd_preservation.rst       | 138 +++
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 Documentation/userspace-api/liveupdate.rst    |  25 +
 MAINTAINERS                                   |  18 +-
 include/linux/kexec_handover.h                |  53 +-
 include/linux/liveupdate.h                    | 209 +++++
 include/linux/shmem_fs.h                      |  23 +
 include/uapi/linux/liveupdate.h               | 460 +++++++++
 init/Kconfig                                  |   2 +
 kernel/Kconfig.kexec                          |  15 -
 kernel/Makefile                               |   2 +-
 kernel/liveupdate/Kconfig                     |  72 ++
 kernel/liveupdate/Makefile                    |  14 +
 kernel/{ => liveupdate}/kexec_handover.c      | 507 ++++------
 kernel/liveupdate/kexec_handover_debug.c      | 222 +++++
 kernel/liveupdate/kexec_handover_internal.h   |  45 +
 kernel/liveupdate/luo_core.c                  | 588 ++++++++++++
 kernel/liveupdate/luo_file.c                  | 599 ++++++++++++
 kernel/liveupdate/luo_internal.h              | 114 +++
 kernel/liveupdate/luo_ioctl.c                 | 255 +++++
 kernel/liveupdate/luo_selftests.c             | 345 +++++++
 kernel/liveupdate/luo_selftests.h             |  84 ++
 kernel/liveupdate/luo_session.c               | 887 ++++++++++++++++++
 kernel/liveupdate/luo_subsystems.c            | 452 +++++++++
 kernel/reboot.c                               |   4 +
 mm/Makefile                                   |   1 +
 mm/internal.h                                 |   6 +
 mm/memblock.c                                 |  60 +-
 mm/memfd_luo.c                                | 523 +++++++++++
 mm/shmem.c                                    |  51 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/liveupdate/.gitignore |   2 +
 tools/testing/selftests/liveupdate/Makefile   |  48 +
 tools/testing/selftests/liveupdate/config     |   6 +
 .../testing/selftests/liveupdate/do_kexec.sh  |   6 +
 .../testing/selftests/liveupdate/liveupdate.c | 404 ++++++++
 .../selftests/liveupdate/luo_multi_file.c     | 119 +++
 .../selftests/liveupdate/luo_multi_kexec.c    | 182 ++++
 .../selftests/liveupdate/luo_multi_session.c  | 155 +++
 .../selftests/liveupdate/luo_test_utils.c     | 241 +++++
 .../selftests/liveupdate/luo_test_utils.h     |  51 +
 .../selftests/liveupdate/luo_unreclaimed.c    | 107 +++
 47 files changed, 6757 insertions(+), 410 deletions(-)
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/mm/memfd_preservation.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst
 create mode 100644 include/linux/liveupdate.h
 create mode 100644 include/uapi/linux/liveupdate.h
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (80%)
 create mode 100644 kernel/liveupdate/kexec_handover_debug.c
 create mode 100644 kernel/liveupdate/kexec_handover_internal.h
 create mode 100644 kernel/liveupdate/luo_core.c
 create mode 100644 kernel/liveupdate/luo_file.c
 create mode 100644 kernel/liveupdate/luo_internal.h
 create mode 100644 kernel/liveupdate/luo_ioctl.c
 create mode 100644 kernel/liveupdate/luo_selftests.c
 create mode 100644 kernel/liveupdate/luo_selftests.h
 create mode 100644 kernel/liveupdate/luo_session.c
 create mode 100644 kernel/liveupdate/luo_subsystems.c
 create mode 100644 mm/memfd_luo.c
 create mode 100644 tools/testing/selftests/liveupdate/.gitignore
 create mode 100644 tools/testing/selftests/liveupdate/Makefile
 create mode 100644 tools/testing/selftests/liveupdate/config
 create mode 100755 tools/testing/selftests/liveupdate/do_kexec.sh
 create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_multi_file.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_multi_kexec.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_multi_session.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.h
 create mode 100644 tools/testing/selftests/liveupdate/luo_unreclaimed.c

-- 
2.51.0.536.g15c5d4f767-goog


