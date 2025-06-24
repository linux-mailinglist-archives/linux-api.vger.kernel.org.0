Return-Path: <linux-api+bounces-3961-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 183EFAE6E13
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AFB18931D5
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A312E3B16;
	Tue, 24 Jun 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGNrkdKo"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6826CE08;
	Tue, 24 Jun 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788467; cv=none; b=OQIGYXk+b/6P/q+KEgHP5a99epaUmtkaTE2bIMsBMogSF+Z5rzPSOEPSsD8mQRJSuY+AFrrwZEphKMrXym0F8xP8YqgFouBLmrCZ8wnUkHJPoEeAIGBf+kzBokOBq4cQwVSvJtqSQghFZR9E7hNDXfrd9jEHhp8GAXS35EFDRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788467; c=relaxed/simple;
	bh=2uM8ZfAK+2ebhVCKsRlO9mp2j5h+pjhyVWwUkYCCus0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A97iZjPJ6o7jQZeTc2KqlE20321c3Id/bCfI4Ey3ptJzNbEWY5iAorcSzISFTkqKIxE/rrlr3aN/QeTo/ftbMkHJ/50P94DDyzEjrZUnl5/WF5BRRQRzn/N/2Y3W1YUovSPXyVBjbmW6M0YOhoPYERA/tEgJFz5EV14YuIWrJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGNrkdKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA49EC4CEE3;
	Tue, 24 Jun 2025 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788467;
	bh=2uM8ZfAK+2ebhVCKsRlO9mp2j5h+pjhyVWwUkYCCus0=;
	h=From:To:Cc:Subject:Date:From;
	b=QGNrkdKosWT9uHKYQ89vGG/xHUp+ntNVuJuDxWP6ZdUfkXvWIrIuu94aiDn97PTaT
	 N9IRXQo+AeZRAD3jrNItAnHzQWyU6XK3S2wsyXS+KQmvAJAuIP0MTSljlWTN8D2iXI
	 2yMhNDc5nouo0Gi1qxmk328ibwmM4mvmAE+s6qlDww/UdxAxQOO3UasiVwFfXRVPW1
	 1oqcCs+cuVn4CI8ujyrbczXXSl4UzlrLfpT/PHG1J9FgjgJufU9PHTaKDNxN2vMTWh
	 GxfvOe1LMrtsbcB85frl2+NBXYG2TVbs2vQ4pCxOvlXkbm10XIaxZW625QdlvN0XCN
	 UoNoXzozoqPyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 00/22] Kernel API specification framework
Date: Tue, 24 Jun 2025 14:07:20 -0400
Message-Id: <20250624180742.5795-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This is a second attempt at a "Kernel API Specification" framework, addressing
the feedback from the initial RFC and expanding the scope to include sysfs
attribute specifications.

Motivation
==========

The Linux kernel has one fundamental promise to userspace: we don't
break it.  This promise is the foundation of Linux's success, allowing
applications written decades ago to still run on modern kernels. Yet
despite this being our most important commitment, we lack reliable
mechanisms to detect when we're about to break this promise.

Currently, we rely on:
- Developer vigilance and review
- User reports after release (often too late)
- Limited testing that can't cover all API usage patterns
- Documentation that's often incomplete or outdated

This gap between our commitment and our tooling is a fundamental problem.
We have sophisticated tools to catch memory leaks, race conditions, and
other bugs, but no systematic way to catch API breakage before it impacts
users.

As the kernel continues to grow, so do the interfaces exposed by it. This
applies to both the userspace API as well as the numerous internal APIs.
Over the years, we've accumulated a lot of documentation, but it's
sometimes lacking, spread out, and often out of date.

In the same way that we have runtime and static checkers to validate that
code is correct, we need a way to validate that the *use* of the various
APIs is correct and that changes don't break existing contracts.

This work aims to provide:

1. A machine-readable format to describe APIs.
2. Runtime validation of API contracts.
3. Generation of documentation and other artifacts.
4. Improved tooling for API exploration and debugging.
5. Most importantly: automated detection of API breakage.

With formal API specifications, we can:
- Detect when patches change API behavior in incompatible ways
- Validate that error codes, parameter constraints, and return values
  remain consistent across kernel versions
- Generate automated tests that verify API contracts
- Provide userspace with machine-readable guarantees about kernel behavior
- Catch subtle breakage (like removing error codes, changing semantics,
  or tightening constraints) that manual review might miss

The idea is to have an in-kernel API specification format that can be used
by tools such as:

- Static analysis tools (checkpatch, sparse, Coccinelle) to detect API
  contract violations at compile time
- CI/CD systems to automatically flag potential userspace breakage
- Runtime verification (API contract validation) during testing
- Tracing and debugging (better BPF/ftrace integration)
- Documentation generation (automated, always up-to-date)
- Userspace helpers (interceptors, mocking frameworks, etc.)
- Fuzzers (can detect API contract violations, not just kernel crashes)

Where are we now?
=================

This series introduces a framework that allows developers to declare API
specifications directly in their subsystem code. These specifications are
then:

1. Exported via debugfs (making them runtime queryable)
2. Compiled into the kernel binary (accessible to tools)
3. Used for runtime validation (when enabled)

The `kapi` tool in tools/kapi/ can extract API specifications from:
- Source code (by parsing the KAPI macros)
- Running kernel (via debugfs)
- vmlinux binary (for offline analysis)

It produces output in multiple formats (plain text, JSON, RST) for easy
integration with existing workflows.

Changes since v1
================

- Added sysfs attribute validation support (patches 19-20)
- Added socket() syscall specification (patch 21)
- Enhanced signal handling with new actions (QUEUE, DISCARD, TRANSFORM)
- Expanded all API specifications with more detailed constraints
- Improved error handling documentation across all patches
- Added network/socket infrastructure to core framework
- Plumbed in syscall runtime validation

Sasha Levin (22):
  kernel/api: introduce kernel API specification framework
  eventpoll: add API specification for epoll_create1
  eventpoll: add API specification for epoll_create
  eventpoll: add API specification for epoll_ctl
  eventpoll: add API specification for epoll_wait
  eventpoll: add API specification for epoll_pwait
  eventpoll: add API specification for epoll_pwait2
  exec: add API specification for execve
  exec: add API specification for execveat
  mm/mlock: add API specification for mlock
  mm/mlock: add API specification for mlock2
  mm/mlock: add API specification for mlockall
  mm/mlock: add API specification for munlock
  mm/mlock: add API specification for munlockall
  kernel/api: add debugfs interface for kernel API specifications
  kernel/api: add IOCTL specification infrastructure
  fwctl: add detailed IOCTL API specifications
  binder: add detailed IOCTL API specifications
  kernel/api: Add sysfs validation support to kernel API specification
    framework
  block: sysfs API specifications
  net/socket: add API specification for socket()
  tools/kapi: Add kernel API specification extraction tool

 Documentation/admin-guide/kernel-api-spec.rst |  699 +++++++
 MAINTAINERS                                   |    9 +
 arch/um/kernel/dyn.lds.S                      |    3 +
 arch/um/kernel/uml.lds.S                      |    3 +
 arch/x86/kernel/vmlinux.lds.S                 |    3 +
 block/blk-integrity.c                         |  131 ++
 block/blk-sysfs.c                             |  243 +++
 block/genhd.c                                 |   99 +
 drivers/android/binder.c                      |  701 +++++++
 drivers/fwctl/main.c                          |  285 ++-
 fs/eventpoll.c                                | 1163 +++++++++++
 fs/exec.c                                     |  702 +++++++
 include/asm-generic/vmlinux.lds.h             |   20 +
 include/linux/kernel_api_spec.h               | 1841 +++++++++++++++++
 include/linux/syscall_api_spec.h              |  137 ++
 include/linux/syscalls.h                      |   38 +
 init/Kconfig                                  |    2 +
 kernel/Makefile                               |    1 +
 kernel/api/Kconfig                            |   55 +
 kernel/api/Makefile                           |   13 +
 kernel/api/ioctl_validation.c                 |  355 ++++
 kernel/api/kapi_debugfs.c                     |  340 +++
 kernel/api/kernel_api_spec.c                  | 1531 ++++++++++++++
 mm/mlock.c                                    |  774 +++++++
 net/socket.c                                  |  489 +++++
 tools/kapi/.gitignore                         |    4 +
 tools/kapi/Cargo.toml                         |   19 +
 tools/kapi/src/extractor/debugfs.rs           |  415 ++++
 tools/kapi/src/extractor/mod.rs               |  411 ++++
 tools/kapi/src/extractor/source_parser.rs     | 1625 +++++++++++++++
 .../src/extractor/vmlinux/binary_utils.rs     |  283 +++
 tools/kapi/src/extractor/vmlinux/mod.rs       |  989 +++++++++
 tools/kapi/src/formatter/json.rs              |  420 ++++
 tools/kapi/src/formatter/mod.rs               |  130 ++
 tools/kapi/src/formatter/plain.rs             |  465 +++++
 tools/kapi/src/formatter/rst.rs               |  468 +++++
 tools/kapi/src/formatter/shall.rs             |  605 ++++++
 tools/kapi/src/main.rs                        |  130 ++
 38 files changed, 15598 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/admin-guide/kernel-api-spec.rst
 create mode 100644 include/linux/kernel_api_spec.h
 create mode 100644 include/linux/syscall_api_spec.h
 create mode 100644 kernel/api/Kconfig
 create mode 100644 kernel/api/Makefile
 create mode 100644 kernel/api/ioctl_validation.c
 create mode 100644 kernel/api/kapi_debugfs.c
 create mode 100644 kernel/api/kernel_api_spec.c
 create mode 100644 tools/kapi/.gitignore
 create mode 100644 tools/kapi/Cargo.toml
 create mode 100644 tools/kapi/src/extractor/debugfs.rs
 create mode 100644 tools/kapi/src/extractor/mod.rs
 create mode 100644 tools/kapi/src/extractor/source_parser.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/binary_utils.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/mod.rs
 create mode 100644 tools/kapi/src/formatter/json.rs
 create mode 100644 tools/kapi/src/formatter/mod.rs
 create mode 100644 tools/kapi/src/formatter/plain.rs
 create mode 100644 tools/kapi/src/formatter/rst.rs
 create mode 100644 tools/kapi/src/formatter/shall.rs
 create mode 100644 tools/kapi/src/main.rs

-- 
2.39.5


