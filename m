Return-Path: <linux-api+bounces-4028-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBDBAE92EA
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 01:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0635C5A01B0
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 23:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED282D3EF9;
	Wed, 25 Jun 2025 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lGaQVf+M"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2A287262
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895096; cv=none; b=gPdvvV6aWRqzwPt4dzerBLmUGIGHcthqvS5ScpZS837zr4XnrnG4PbBQvSdJg0G7w1g4bMLGB9mMyDp1MGCMj7fSRZ9yHIEriIyf/pbj+MH+78UsPWWL+Sl3pTSbz2m6iT2leNZQTiTjGwnyeS6lPeoJPgc67N12DmfIWxqmJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895096; c=relaxed/simple;
	bh=bg3Ch3oaeSTn0gw9pOu0G8fmMZicuhfiYO3wgc/W9g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTGS5utoQnmcphn2Wu0/xWFvDn2WfkWD3rAgLSV98/fjc+xYWQCOv9cZqiCgQMO53bRTtC1QSX/mZJIznGAC8sl1pmrzr3GrCbz2mKk0YbIquVankZf3aMwznkoGuGWSi17eZ5pOh7OB0vsCSiDDLlP9p9AM/KaVlVKqDwvH9qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lGaQVf+M; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a43972dcd7so6473421cf.3
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 16:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750895092; x=1751499892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK7GsFF88lqGjvQm8ZMWAKGf8qGndWj9zjttanlA1xU=;
        b=lGaQVf+MWTUO6Prrql7qBABPKF7bQhXoUPoZMOtU40/XioQy4/hGdqA7dFgcybjzxb
         KqqAe2RhYb/Vf2+oapsaza/a2XmXKUUHdJCnu1PSOejoKGmi7tNCi4TfhOmndap8RDSy
         A0jWv7IdCDJvEtV+oYyLC8W/J23oSfTLCQwSZPQze2frfpzSz1i2kuFTmPRmJ4QLqwxM
         kKPiWflEZYwCwgvQpFJGojlekwKGcZtkAT45E+lJieMJn7RXwVj3iufuBxRURwdqm2ww
         GfDLnxv1zqG9673BfdZ1+smjU1r6P0TzSgbxbk8hViHCvuAlBPpngkbMyWT2QWTm5ekw
         q/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750895092; x=1751499892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK7GsFF88lqGjvQm8ZMWAKGf8qGndWj9zjttanlA1xU=;
        b=OBGgFJ/bXBiVK1VJulEZtXupcMDD9+Ae7CbI8mLM0cz/VvUlGpvWgvT4Vz0Ih4v8BW
         LCUU2QbTPC4ikcztteqE9hvHpZ5BsxuaKKk/ImAuNljItPD9U0GX2pDZmwJ6t3PADMw9
         WFAYt52VqVjy4RYb/teuazII2OwF3yMl0L4/mCSSCISAFLJyU/GMkWS+9ElA6kRpRND4
         7FPYPvve5Ok3qXvuhgpa3HylOagL/iNIdwu/nDgwAh24WH6pE9JLP5Hy1dkmKw8Gl4W0
         Xi+aCe+w6I5CjCfYeEjNYR5ZepRs7f1UODD39YjFKRFU2NRCo3Xy0AixmWny2MtZXTK8
         EfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs7mvDTvGGI5d2neYoRq6KLJ6IU7+5KmmjQU1RgrotTuUyU1r9o3yZCyvdxbocGVQdI4J+qZ7KRvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxfUOqb1YJz8hikRmwSOqSCnszXtj/Mx9nA5Loo2SnGt5KoR7
	vjnwSh7TZu1Kyi/7L+LznVcmJTZp6e8Z2AB4CoHxmFFxT0FKrkN/kPiQBR+R3S2MDdNe7s0Eihy
	2K1X+wMAOPo8rAia70YXLrgG5tjdUwUV8ITL3KcCYbw==
X-Gm-Gg: ASbGncve77Tzwk1rzmG1mKEBPR4s9J4U/kWQSsg0mzVVTBXN2WbTesNu9aW8z/z3zqM
	bTO96ZzyDGlfyS9Lm1NFjcKVJ8/9l68FtLz+NmwZcu8PyVzTMArGP4l4N6L5WV/R/MnmxYdxuAz
	uqCkO9axJQ29GMnZ2BBzxPrsgwTnVJ9cVReZKd0YH6vg==
X-Google-Smtp-Source: AGHT+IFA1dw/Tbh1ngrhBlKF8dPXkDASOz9bRitH3ybBqQXjF3c1snI3GefczU+R9hvfnnbVRHa47Akh8WxSx3KKBaU=
X-Received: by 2002:a05:622a:1aa3:b0:4a4:3449:2b82 with SMTP id
 d75a77b69052e-4a7c0675de3mr94942221cf.13.1750895091918; Wed, 25 Jun 2025
 16:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com> <20250625232653.GJ369@kvack.org>
In-Reply-To: <20250625232653.GJ369@kvack.org>
From: "pasha.tatashin" <pasha.tatashin@soleen.com>
Date: Wed, 25 Jun 2025 19:44:12 -0400
X-Gm-Features: Ac12FXw9JQy4g0DzAGeQjJ73rJNx0LH5nXFC6RmoGr5lfqNnNC58y1Z2DsYDqVc
Message-ID: <CA+CK2bAsz4Zz2_Kp8QMKxG5taY52ykhhykROd0di85ax5eeOrw@mail.gmail.com>
Subject: Re: [PATCH v1 00/32] Live Update Orchestrator
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 7:26=E2=80=AFPM Benjamin LaHaise <bcrl@kvack.org> w=
rote:
>
> FYI: Every one of your emails to the list for this series was bounced by
> all the recipients using @gmail.com email addresses.
>
>                 -ben (owner-linux-mm)

This is extremely annoying, I will need to figure out why this is
happening. soleen.com uses google workspace.

Pasha

>
> On Wed, Jun 25, 2025 at 11:17:47PM +0000, Pasha Tatashin wrote:
> > This series introduces the LUO, a kernel subsystem designed to
> > facilitate live kernel updates with minimal downtime,
> > particularly in cloud delplyoments aiming to update without fully
> > disrupting running virtual machines.
> >
> > This series builds upon KHO framework by adding programmatic
> > control over KHO's lifecycle and leveraging KHO for persisting LUO's
> > own metadata across the kexec boundary. The git branch for this series
> > can be found at:
> >
> > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v1
> >
> > Changelog from rfc-v2:
> > - Addressed review comments from Mike Rapoport, Pratyush Yadav,
> >   David Matlack
> > - Moved everything under kernel/liveupdate including KHO.
> > - Added a number fixes to KHO that were discovered.
> > - luo_files is not a registred as a subsystem.
> > - Added sessions support to preserved files.
> > - Added support for memfd (Pratyush Yadav)
> > - Added libluo (proposed as RFC) (Pratyush Yadav)
> > - Removed notifiers from KHO (Mike Rapoport)
> >
> > What is Live Update?
> > Live Update is a kexec based reboot process where selected kernel
> > resources (memory, file descriptors, and eventually devices) are kept
> > operational or their state preserved across a kernel transition. For
> > certain resources, DMA and interrupt activity might continue with
> > minimal interruption during the kernel reboot.
> >
> > LUO provides a framework for coordinating live updates. It features:
> > State Machine: Manages the live update process through states:
> > NORMAL, PREPARED, FROZEN, UPDATED.
> >
> > KHO Integration:
> >
> > LUO programmatically drives KHO's finalization and abort sequences.
> > KHO's debugfs interface is now optional configured via
> > CONFIG_KEXEC_HANDOVER_DEBUG.
> >
> > LUO preserves its own metadata via KHO's kho_add_subtree and
> > kho_preserve_phys() mechanisms.
> >
> > Subsystem Participation: A callback API liveupdate_register_subsystem()
> > allows kernel subsystems (e.g., KVM, IOMMU, VFIO, PCI) to register
> > handlers for LUO events (PREPARE, FREEZE, FINISH, CANCEL) and persist a
> > u64 payload via the LUO FDT.
> >
> > File Descriptor Preservation: Infrastructure
> > liveupdate_register_filesystem, luo_register_file, luo_retrieve_file to
> > allow specific types of file descriptors (e.g., memfd, vfio) to be
> > preserved and restored.
> >
> > Handlers for specific file types can be registered to manage their
> > preservation and restoration, storing a u64 payload in the LUO FDT.
> >
> > User-space Interface:
> >
> > ioctl (/dev/liveupdate): The primary control interface for
> > triggering LUO state transitions (prepare, freeze, finish, cancel)
> > and managing the preservation/restoration of file descriptors.
> > Access requires CAP_SYS_ADMIN.
> >
> > sysfs (/sys/kernel/liveupdate/state): A read-only interface for
> > monitoring the current LUO state. This allows userspace services to
> > track progress and coordinate actions.
> >
> > Selftests: Includes kernel-side hooks and userspace selftests to
> > verify core LUO functionality, particularly subsystem registration and
> > basic state transitions.
> >
> > LUO State Machine and Events:
> >
> > NORMAL:   Default operational state.
> > PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE
> >           event. Subsystems have saved initial state.
> > FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE
> >           event, just before kexec. Workloads must be suspended.
> > UPDATED:  Next kernel has booted via live update. Awaiting restoration
> >           and LIVEUPDATE_FINISH.
> >
> > Events:
> > LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
> > LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
> > LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
> > LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.
> >
> > RFC v1: https://lore.kernel.org/all/20250320024011.2995837-1-pasha.tata=
shin@soleen.com
> > RFC v2: https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatas=
hin@soleen.com/
> >
> > Changyuan Lyu (1):
> >   kho: add interfaces to unpreserve folios and physical memory ranges
> >
> > Mike Rapoport (Microsoft) (1):
> >   kho: drop notifiers
> >
> > Pasha Tatashin (22):
> >   kho: init new_physxa->phys_bits to fix lockdep
> >   kho: mm: Don't allow deferred struct page with KHO
> >   kho: warn if KHO is disabled due to an error
> >   kho: allow to drive kho from within kernel
> >   kho: make debugfs interface optional
> >   kho: don't unpreserve memory during abort
> >   liveupdate: kho: move to kernel/liveupdate
> >   liveupdate: luo_core: Live Update Orchestrator
> >   liveupdate: luo_core: integrate with KHO
> >   liveupdate: luo_subsystems: add subsystem registration
> >   liveupdate: luo_subsystems: implement subsystem callbacks
> >   liveupdate: luo_files: add infrastructure for FDs
> >   liveupdate: luo_files: implement file systems callbacks
> >   liveupdate: luo_ioctl: add ioctl interface
> >   liveupdate: luo_sysfs: add sysfs state monitoring
> >   reboot: call liveupdate_reboot() before kexec
> >   liveupdate: luo_files: luo_ioctl: session-based file descriptor
> >     tracking
> >   kho: move kho debugfs directory to liveupdate
> >   liveupdate: add selftests for subsystems un/registration
> >   selftests/liveupdate: add subsystem/state tests
> >   docs: add luo documentation
> >   MAINTAINERS: add liveupdate entry
> >
> > Pratyush Yadav (8):
> >   mm: shmem: use SHMEM_F_* flags instead of VM_* flags
> >   mm: shmem: allow freezing inode mapping
> >   mm: shmem: export some functions to internal.h
> >   luo: allow preserving memfd
> >   docs: add documentation for memfd preservation via LUO
> >   tools: introduce libluo
> >   libluo: introduce luoctl
> >   libluo: add tests
> >
> >  .../ABI/testing/sysfs-kernel-liveupdate       |  51 +
> >  Documentation/admin-guide/index.rst           |   1 +
> >  Documentation/admin-guide/liveupdate.rst      |  16 +
> >  Documentation/core-api/index.rst              |   1 +
> >  Documentation/core-api/kho/concepts.rst       |   2 +-
> >  Documentation/core-api/liveupdate.rst         |  57 ++
> >  Documentation/mm/index.rst                    |   1 +
> >  Documentation/mm/memfd_preservation.rst       | 138 +++
> >  Documentation/userspace-api/index.rst         |   1 +
> >  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
> >  Documentation/userspace-api/liveupdate.rst    |  25 +
> >  MAINTAINERS                                   |  20 +-
> >  include/linux/kexec_handover.h                |  53 +-
> >  include/linux/liveupdate.h                    | 235 +++++
> >  include/linux/shmem_fs.h                      |  23 +
> >  include/uapi/linux/liveupdate.h               | 265 +++++
> >  init/Kconfig                                  |   2 +
> >  kernel/Kconfig.kexec                          |  14 -
> >  kernel/Makefile                               |   2 +-
> >  kernel/liveupdate/Kconfig                     |  90 ++
> >  kernel/liveupdate/Makefile                    |  13 +
> >  kernel/{ =3D> liveupdate}/kexec_handover.c      | 556 +++++-----
> >  kernel/liveupdate/kexec_handover_debug.c      | 222 ++++
> >  kernel/liveupdate/kexec_handover_internal.h   |  45 +
> >  kernel/liveupdate/luo_core.c                  | 525 ++++++++++
> >  kernel/liveupdate/luo_files.c                 | 946 ++++++++++++++++++
> >  kernel/liveupdate/luo_internal.h              |  47 +
> >  kernel/liveupdate/luo_ioctl.c                 | 192 ++++
> >  kernel/liveupdate/luo_selftests.c             | 344 +++++++
> >  kernel/liveupdate/luo_selftests.h             |  84 ++
> >  kernel/liveupdate/luo_subsystems.c            | 420 ++++++++
> >  kernel/liveupdate/luo_sysfs.c                 |  92 ++
> >  kernel/reboot.c                               |   4 +
> >  mm/Makefile                                   |   1 +
> >  mm/internal.h                                 |   6 +
> >  mm/memblock.c                                 |  56 +-
> >  mm/memfd_luo.c                                | 501 ++++++++++
> >  mm/shmem.c                                    |  46 +-
> >  tools/lib/luo/LICENSE                         | 165 +++
> >  tools/lib/luo/Makefile                        |  45 +
> >  tools/lib/luo/README.md                       | 166 +++
> >  tools/lib/luo/cli/.gitignore                  |   1 +
> >  tools/lib/luo/cli/Makefile                    |  18 +
> >  tools/lib/luo/cli/luoctl.c                    | 178 ++++
> >  tools/lib/luo/include/libluo.h                | 128 +++
> >  tools/lib/luo/include/liveupdate.h            | 265 +++++
> >  tools/lib/luo/libluo.c                        | 203 ++++
> >  tools/lib/luo/tests/.gitignore                |   1 +
> >  tools/lib/luo/tests/Makefile                  |  18 +
> >  tools/lib/luo/tests/test.c                    | 848 ++++++++++++++++
> >  tools/testing/selftests/Makefile              |   1 +
> >  tools/testing/selftests/liveupdate/.gitignore |   1 +
> >  tools/testing/selftests/liveupdate/Makefile   |   7 +
> >  tools/testing/selftests/liveupdate/config     |   6 +
> >  .../testing/selftests/liveupdate/liveupdate.c | 356 +++++++
> >  55 files changed, 7091 insertions(+), 415 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-kernel-liveupdate
> >  create mode 100644 Documentation/admin-guide/liveupdate.rst
> >  create mode 100644 Documentation/core-api/liveupdate.rst
> >  create mode 100644 Documentation/mm/memfd_preservation.rst
> >  create mode 100644 Documentation/userspace-api/liveupdate.rst
> >  create mode 100644 include/linux/liveupdate.h
> >  create mode 100644 include/uapi/linux/liveupdate.h
> >  create mode 100644 kernel/liveupdate/Kconfig
> >  create mode 100644 kernel/liveupdate/Makefile
> >  rename kernel/{ =3D> liveupdate}/kexec_handover.c (74%)
> >  create mode 100644 kernel/liveupdate/kexec_handover_debug.c
> >  create mode 100644 kernel/liveupdate/kexec_handover_internal.h
> >  create mode 100644 kernel/liveupdate/luo_core.c
> >  create mode 100644 kernel/liveupdate/luo_files.c
> >  create mode 100644 kernel/liveupdate/luo_internal.h
> >  create mode 100644 kernel/liveupdate/luo_ioctl.c
> >  create mode 100644 kernel/liveupdate/luo_selftests.c
> >  create mode 100644 kernel/liveupdate/luo_selftests.h
> >  create mode 100644 kernel/liveupdate/luo_subsystems.c
> >  create mode 100644 kernel/liveupdate/luo_sysfs.c
> >  create mode 100644 mm/memfd_luo.c
> >  create mode 100644 tools/lib/luo/LICENSE
> >  create mode 100644 tools/lib/luo/Makefile
> >  create mode 100644 tools/lib/luo/README.md
> >  create mode 100644 tools/lib/luo/cli/.gitignore
> >  create mode 100644 tools/lib/luo/cli/Makefile
> >  create mode 100644 tools/lib/luo/cli/luoctl.c
> >  create mode 100644 tools/lib/luo/include/libluo.h
> >  create mode 100644 tools/lib/luo/include/liveupdate.h
> >  create mode 100644 tools/lib/luo/libluo.c
> >  create mode 100644 tools/lib/luo/tests/.gitignore
> >  create mode 100644 tools/lib/luo/tests/Makefile
> >  create mode 100644 tools/lib/luo/tests/test.c
> >  create mode 100644 tools/testing/selftests/liveupdate/.gitignore
> >  create mode 100644 tools/testing/selftests/liveupdate/Makefile
> >  create mode 100644 tools/testing/selftests/liveupdate/config
> >  create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c
> >
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
>
> --
> "Thought is the essence of where you are now."

