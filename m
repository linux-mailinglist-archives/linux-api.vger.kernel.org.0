Return-Path: <linux-api+bounces-3849-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B969CAC39F1
	for <lists+linux-api@lfdr.de>; Mon, 26 May 2025 08:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A91318897A8
	for <lists+linux-api@lfdr.de>; Mon, 26 May 2025 06:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB601A76D4;
	Mon, 26 May 2025 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgymWtG+"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107531876;
	Mon, 26 May 2025 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748241180; cv=none; b=GM2HyLxEk1J3ndvgJad9YSDR+MWKWpKksaqYhkwffNhMo8vxa7tQ/ZkCXQgWxi6wvIUN1X3P/qgTx8JLvsTW5xCcspqb8pLxtTtNzR5jcSHIwN0Fz/r3KPnG7IWzjrsW1Xstukd5BWPahVEtmkUiWO6pWd0ssEPpgsCk5OzzL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748241180; c=relaxed/simple;
	bh=1SesHpH2CP4usADRmgfgQeKfD4QmxgxLDTCgDd3G+Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9oVBc9I6fvUmWT2XFXWeaE4DN5E0SKxUHfcuxZ23W029ftEZn+s/SFVg84+vpOjNqJK2/h5NzqohY03uE1/QSDOHj9FgptrlJlruYXZIut0yUmxFqti20OCZu9UR+VpC+HWxmyzD5EBgz2BjJDZGS/2/rXy7IOseBnBg9RDeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgymWtG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A531C4CEE7;
	Mon, 26 May 2025 06:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748241179;
	bh=1SesHpH2CP4usADRmgfgQeKfD4QmxgxLDTCgDd3G+Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgymWtG+WQtWWgZU/ituPtgvWA7eQ3ol4RmsQ/kt+lpkvS8hpC3Dbg5TPDE//B+xo
	 k763m5GVaGO5GaxTbUe+WVHc9M6epuBWl3wERloYnnWtZ6ZCf46LP76/gjlp574c3x
	 ExBbvLHscqD6iOpL5stQFwJ8/F5NpN67grFjlThzmUfUct28r4/xffG/h9lQAZf8bx
	 i10V1IuOut58DJTeq6+VypAusmC2bwNVslb08hEwB/sodZRIEnPuzHv8T37lg690Ur
	 RnouW58DxjFxQVL8YQQtwelBOThqwoo12r7vtHFFJM23cCD3z9C0UqrgDmsoTI0FgG
	 y//+1+CNZ85Kw==
Date: Mon, 26 May 2025 09:32:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de,
	linux-api@vger.kernel.org
Subject: Re: [RFC v2 00/16] Live Update Orchestrator
Message-ID: <aDQLCS6DJHo0QbsC@kernel.org>
References: <20250515182322.117840-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515182322.117840-1-pasha.tatashin@soleen.com>

(cc'ing linux-api)

On Thu, May 15, 2025 at 06:23:04PM +0000, Pasha Tatashin wrote:
> This v2 series introduces the LUO, a kernel subsystem designed to
> facilitate live kernel updates with minimal downtime,
> particularly in cloud delplyoments aiming to update without fully
> disrupting running virtual machines.
> 
> This series builds upon KHO framework [1] by adding programmatic
> control over KHO's lifecycle and leveraging KHO for persisting LUO's
> own metadata across the kexec boundary. The git branch for this series
> can be found at:
> https://github.com/googleprodkernel/linux-liveupdate/tree/luo/rfc-v2
> 
> Changelog from v1:
> - Control Interface: Shifted from sysfs-based control
>   (/sys/kernel/liveupdate/{prepare,finish}) to an ioctl interface
>   (/dev/liveupdate). Sysfs is now primarily for monitoring the state.
> - Event/State Renaming: LIVEUPDATE_REBOOT event/phase is now
>   LIVEUPDATE_FREEZE.
> - FD Preservation: A new component for preserving file descriptors.
>   Subsystem Registration: A formal mechanism for kernel subsystems
>   to participate.
> - Device Layer: removed device list handling from this series, it is
>   going to be added separately.
> - Selftests: Kernel-side selftest hooks and userspace selftests are
>   now included.
> KHO Enhancements:
> - KHO debugfs became optional, and kernel APIs for finalize/abort
>   were added (driven by LUO's needs).
> - KHO unpreserve functions were also added.
> 
> What is Live Update?
> Live Update is a specialized reboot process where selected kernel
> resources (memory, file descriptors, and eventually devices) are kept
> operational or their state preserved across a kernel transition (e.g.,
> via kexec). For certain resources, DMA and interrupt activity might
> continue with minimal interruption during the kernel reboot.
> 
> LUO v2 Overview:
> LUO v2 provides a framework for coordinating live updates. It features:
> State Machine: Manages the live update process through states:
> NORMAL, PREPARED, FROZEN, UPDATED.
> 
> KHO Integration:
> 
> LUO programmatically drives KHO's finalization and abort sequences.
> KHO's debugfs interface is now optional configured via
> CONFIG_KEXEC_HANDOVER_DEBUG.
> 
> LUO preserves its own metadata via KHO's kho_add_subtree and
> kho_preserve_phys() mechanisms.
> 
> Subsystem Participation: A callback API liveupdate_register_subsystem()
> allows kernel subsystems (e.g., KVM, IOMMU, VFIO, PCI) to register
> handlers for LUO events (PREPARE, FREEZE, FINISH, CANCEL) and persist a
> u64 payload via the LUO FDT.
> 
> File Descriptor Preservation: Infrastructure
> liveupdate_register_filesystem, luo_register_file, luo_retrieve_file to
> allow specific types of file descriptors (e.g., memfd, vfio) to be
> preserved and restored.
> 
> Handlers for specific file types can be registered to manage their
> preservation and restoration, storing a u64 payload in the LUO FDT.
> 
> Example WIP for memfd preservation can be found here [2].
> 
> User-space Interface:
> 
> ioctl (/dev/liveupdate): The primary control interface for
> triggering LUO state transitions (prepare, freeze, finish, cancel)
> and managing the preservation/restoration of file descriptors.
> Access requires CAP_SYS_ADMIN.
> 
> sysfs (/sys/kernel/liveupdate/state): A read-only interface for
> monitoring the current LUO state. This allows userspace services to
> track progress and coordinate actions.
> 
> Selftests: Includes kernel-side hooks and userspace selftests to
> verify core LUO functionality, particularly subsystem registration and
> basic state transitions.
> 
> LUO State Machine and Events:
> 
> NORMAL:   Default operational state.
> PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE
>           event. Subsystems have saved initial state.
> FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE
>           event, just before kexec. Workloads must be suspended.
> UPDATED:  Next kernel has booted via live update. Awaiting restoration
>           and LIVEUPDATE_FINISH.
> 
> Events:
> LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
> LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
> LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
> LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.
> 
> [1] https://lore.kernel.org/all/20250509074635.3187114-1-changyuanl@google.com
>     https://github.com/googleprodkernel/linux-liveupdate/tree/luo/kho-v8
> [2] https://github.com/googleprodkernel/linux-liveupdate/tree/luo/memfd-v0.1
> 
> RFC v1: https://lore.kernel.org/all/20250320024011.2995837-1-pasha.tatashin@soleen.com
> 
> Changyuan Lyu (1):
>   kho: add kho_unpreserve_folio/phys
> 
> Pasha Tatashin (15):
>   kho: make debugfs interface optional
>   kho: allow to drive kho from within kernel
>   luo: luo_core: Live Update Orchestrator
>   luo: luo_core: integrate with KHO
>   luo: luo_subsystems: add subsystem registration
>   luo: luo_subsystems: implement subsystem callbacks
>   luo: luo_files: add infrastructure for FDs
>   luo: luo_files: implement file systems callbacks
>   luo: luo_ioctl: add ioctl interface
>   luo: luo_sysfs: add sysfs state monitoring
>   reboot: call liveupdate_reboot() before kexec
>   luo: add selftests for subsystems un/registration
>   selftests/liveupdate: add subsystem/state tests
>   docs: add luo documentation
>   MAINTAINERS: add liveupdate entry
> 
>  .../ABI/testing/sysfs-kernel-liveupdate       |  51 ++
>  Documentation/admin-guide/index.rst           |   1 +
>  Documentation/admin-guide/liveupdate.rst      |  62 ++
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |  14 +-
>  drivers/misc/Kconfig                          |   1 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/liveupdate/Kconfig               |  60 ++
>  drivers/misc/liveupdate/Makefile              |   7 +
>  drivers/misc/liveupdate/luo_core.c            | 547 +++++++++++++++
>  drivers/misc/liveupdate/luo_files.c           | 664 ++++++++++++++++++
>  drivers/misc/liveupdate/luo_internal.h        |  59 ++
>  drivers/misc/liveupdate/luo_ioctl.c           | 203 ++++++
>  drivers/misc/liveupdate/luo_selftests.c       | 283 ++++++++
>  drivers/misc/liveupdate/luo_selftests.h       |  23 +
>  drivers/misc/liveupdate/luo_subsystems.c      | 413 +++++++++++
>  drivers/misc/liveupdate/luo_sysfs.c           |  92 +++
>  include/linux/kexec_handover.h                |  27 +
>  include/linux/liveupdate.h                    | 214 ++++++
>  include/uapi/linux/liveupdate.h               | 324 +++++++++
>  kernel/Kconfig.kexec                          |  10 +
>  kernel/Makefile                               |   1 +
>  kernel/kexec_handover.c                       | 343 +++------
>  kernel/kexec_handover_debug.c                 | 237 +++++++
>  kernel/kexec_handover_internal.h              |  74 ++
>  kernel/reboot.c                               |   4 +
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/liveupdate/.gitignore |   1 +
>  tools/testing/selftests/liveupdate/Makefile   |   7 +
>  tools/testing/selftests/liveupdate/config     |   6 +
>  .../testing/selftests/liveupdate/liveupdate.c | 440 ++++++++++++
>  31 files changed, 3933 insertions(+), 238 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-liveupdate
>  create mode 100644 Documentation/admin-guide/liveupdate.rst
>  create mode 100644 drivers/misc/liveupdate/Kconfig
>  create mode 100644 drivers/misc/liveupdate/Makefile
>  create mode 100644 drivers/misc/liveupdate/luo_core.c
>  create mode 100644 drivers/misc/liveupdate/luo_files.c
>  create mode 100644 drivers/misc/liveupdate/luo_internal.h
>  create mode 100644 drivers/misc/liveupdate/luo_ioctl.c
>  create mode 100644 drivers/misc/liveupdate/luo_selftests.c
>  create mode 100644 drivers/misc/liveupdate/luo_selftests.h
>  create mode 100644 drivers/misc/liveupdate/luo_subsystems.c
>  create mode 100644 drivers/misc/liveupdate/luo_sysfs.c
>  create mode 100644 include/linux/liveupdate.h
>  create mode 100644 include/uapi/linux/liveupdate.h
>  create mode 100644 kernel/kexec_handover_debug.c
>  create mode 100644 kernel/kexec_handover_internal.h
>  create mode 100644 tools/testing/selftests/liveupdate/.gitignore
>  create mode 100644 tools/testing/selftests/liveupdate/Makefile
>  create mode 100644 tools/testing/selftests/liveupdate/config
>  create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c
> 
> -- 
> 2.49.0.1101.gccaa498523-goog
> 

-- 
Sincerely yours,
Mike.

