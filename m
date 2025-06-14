Return-Path: <linux-api+bounces-3905-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD800AD9D0A
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0877A188FB71
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7DA2D8DC5;
	Sat, 14 Jun 2025 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaPp6fcb"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9502C327C;
	Sat, 14 Jun 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908941; cv=none; b=nH2BmtYGoDspVqWG50r3i+HO23Z79nuivRItPqamoJWRUwe/UseCMhiY/m0j26x8vShAm5dPGRwYEc7PKT5HwYD07E5xDqIGzptjwtXXVFvcP+HYMn3ckRCucfTrmpC+Epc/MITgPk0FoDOQdA4+YyQSh5hAC5MPc/8hp6EQ+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908941; c=relaxed/simple;
	bh=jDvonqnbryE9GtBftjuAheO62Rkvb7VqMOXFJKZIyPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rRrRT+QxwxUcmVDDo7upC6trlX2JHqux7t7Y85JMn1Agxhr5kkugoOWrvV9y064Hh3rPNnqHHKhmrjPyCuv9uZFq4sjPYXhMEwV/7L9LNNfdR8m0fUCtDFDLVMyM1IYHgmn+GWA/k+THUPzKG96qoxuuxfKlWdHHlSLmY62GXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaPp6fcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6FAC4CEEB;
	Sat, 14 Jun 2025 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908940;
	bh=jDvonqnbryE9GtBftjuAheO62Rkvb7VqMOXFJKZIyPY=;
	h=From:To:Cc:Subject:Date:From;
	b=HaPp6fcbYguYlw9agUQA3WlQFhmMu/qZkzBXN/9cJl5eq/3FcHK6qwU+KvTMknmO2
	 BV0dc9ixBo7osK09Sy6rQ6hvHLxmxoUGbCwT9wDxuoG8m+LNEoKNQJ5MzfaBw1eX1O
	 temyEQpBFNOBAKtbyZYOG2ZyAowl+vdiHa6nGbv4U0dggSPjlRUglGaEy8e03CGMY4
	 AWJFSq0OOH9fL/S0QuHQTFKc34cf1CBv5MiJFJRPbWpRr3UjO4V18exfdGuIHAwvM7
	 GGylTHtIcjB6jwh+jV4D80AhLYw28EbvgjnR2aKPI9si/5uHuJ2L4RnsS1pA6gSSZ5
	 N2DrQx6TrgheQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 00/19] Kernel API Specification Framework
Date: Sat, 14 Jun 2025 09:48:39 -0400
Message-Id: <20250614134858.790460-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a framework for formally specifying kernel
APIs, addressing the long-standing challenge of maintaining stable
interfaces between the kernel and user-space programs. As outlined in
previous discussions about kernel ABI stability, the lack of
machine-readable API specifications has led to inadvertent breakages and
inconsistent validation across system calls and IOCTLs.

The framework provides three key components: declarative macros for
specifying system call and IOCTL interfaces directly in the kernel
source, automated extraction tools for generating machine-readable
specifications, and a runtime validation infrastructure accessible
through debugfs. By embedding specifications alongside implementation
code, we ensure they remain synchronized and enable automated detection
of API/ABI changes that could break user-space applications.

This implementation demonstrates the approach with specifications for
core system calls (epoll, exec, mlock families) and complex IOCTL
interfaces (binder, fwctl).  The specifications capture parameter types,
validation rules, return values, and error conditions in a structured
format that enables both documentation generation and runtime
verification. Future work will expand coverage to additional subsystems
and integrate with existing testing infrastructure to provide
API compatibility guarantees.

To complement the framework, we introduce the 'kapi' tool - a
utility for extracting and analyzing kernel API specifications from
multiple sources. The tool can extract specifications from kernel source
code (parsing KAPI macros), compiled vmlinux binaries (reading the
.kapi_specs ELF section), or from a running kernel via debugfs. It
supports multiple output formats (plain text, JSON, RST) to facilitate
integration with documentation systems and automated testing workflows.
This tool enables developers to easily inspect API specifications,
verify changes across kernel versions, and generate documentation
without requiring kernel rebuilds.

Sasha Levin (19):
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
  tools/kapi: Add kernel API specification extraction tool

 Documentation/admin-guide/kernel-api-spec.rst |  699 +++++++++
 MAINTAINERS                                   |    9 +
 arch/um/kernel/dyn.lds.S                      |    3 +
 arch/um/kernel/uml.lds.S                      |    3 +
 arch/x86/kernel/vmlinux.lds.S                 |    3 +
 drivers/android/binder.c                      |  758 ++++++++++
 drivers/fwctl/main.c                          |  295 +++-
 fs/eventpoll.c                                | 1056 ++++++++++++++
 fs/exec.c                                     |  463 ++++++
 include/asm-generic/vmlinux.lds.h             |   20 +
 include/linux/ioctl_api_spec.h                |  540 +++++++
 include/linux/kernel_api_spec.h               |  942 ++++++++++++
 include/linux/syscall_api_spec.h              |  341 +++++
 include/linux/syscalls.h                      |    1 +
 init/Kconfig                                  |    2 +
 kernel/Makefile                               |    1 +
 kernel/api/Kconfig                            |   55 +
 kernel/api/Makefile                           |   13 +
 kernel/api/ioctl_validation.c                 |  360 +++++
 kernel/api/kapi_debugfs.c                     |  340 +++++
 kernel/api/kernel_api_spec.c                  | 1257 +++++++++++++++++
 mm/mlock.c                                    |  646 +++++++++
 tools/kapi/.gitignore                         |    4 +
 tools/kapi/Cargo.toml                         |   19 +
 tools/kapi/src/extractor/debugfs.rs           |  204 +++
 tools/kapi/src/extractor/mod.rs               |   95 ++
 tools/kapi/src/extractor/source_parser.rs     |  488 +++++++
 .../src/extractor/vmlinux/binary_utils.rs     |  130 ++
 tools/kapi/src/extractor/vmlinux/mod.rs       |  372 +++++
 tools/kapi/src/formatter/json.rs              |  170 +++
 tools/kapi/src/formatter/mod.rs               |   68 +
 tools/kapi/src/formatter/plain.rs             |   99 ++
 tools/kapi/src/formatter/rst.rs               |  144 ++
 tools/kapi/src/main.rs                        |  121 ++
 34 files changed, 9719 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/kernel-api-spec.rst
 create mode 100644 include/linux/ioctl_api_spec.h
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
 create mode 100644 tools/kapi/src/main.rs

-- 
2.39.5


