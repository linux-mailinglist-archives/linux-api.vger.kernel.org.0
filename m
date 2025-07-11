Return-Path: <linux-api+bounces-4149-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B10B01AEB
	for <lists+linux-api@lfdr.de>; Fri, 11 Jul 2025 13:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFFE3B9AC3
	for <lists+linux-api@lfdr.de>; Fri, 11 Jul 2025 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72840290092;
	Fri, 11 Jul 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBNZRt8q"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342E28DF16;
	Fri, 11 Jul 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234175; cv=none; b=ucT4UdZwxFQtloxXuoU9/cER6MGDyodDcUCiPndaCwS6RU06TG5DMtmLhl/nQP/4BiVqauqAwJg6CMa8Rq/n8hBwwBRPJnkBRPaSA3B3WrShfnkYvydps8s7z6Tw1/FLQH3fgiMTXVbB+622MqR3WFkKXiX3Cv8xP9FJnsC0HUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234175; c=relaxed/simple;
	bh=9Opt4/IJMc2NlPuX+4s89Cd81HpDGm9vA5MixdcEFvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=at8k8vNG9CvfFRtvI6w7v4CQlgn94Bq0XInTdofOeDGESooEoOP3pdjEGyoVyInm1jos+fnRn5UsCHRvhQa30zQ2TWwWGVZK7LCn9xUrebHw34iV5T0jggcb3/N5fkHkkMhw8RTekSaxzzl1oWa39Tq1Z9RgvW0143evcVStU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBNZRt8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53434C4CEED;
	Fri, 11 Jul 2025 11:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234174;
	bh=9Opt4/IJMc2NlPuX+4s89Cd81HpDGm9vA5MixdcEFvg=;
	h=From:To:Cc:Subject:Date:From;
	b=BBNZRt8qfE0ST1ciGJ9skgnS2m2vcqk61sxQFX1kfk0dW3MdcPC0e8rZkg3EcDb/f
	 R3a6kg4iQ/OCgHAQA1CZyCvlkPfENnTDJkhG4XSXHAWURs9kupRcFOyXxIdTLH/j8i
	 AU6JPBxKBfK5CISSsjPZtiR/AJEoNIVDrLdqiAvOlyrNFJHqMVszbacYFuHUBMY4UB
	 6KhP/Vkxwd7eTWccJsfpf/3d1hFezTR6fyTtEwzMowYDGcvjdtXAvaH3s+F0DT2XW/
	 5HRtxRxQ2vJzeYZukX7wOOBlwPUJEDbe3YK5zdBJ4ZaPCo6pC6QCOJgs+G6qVfzFc7
	 VmUSPg/0rF0ZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v3 0/4] Kernel API Specification Framework with kerneldoc integration
Date: Fri, 11 Jul 2025 07:42:44 -0400
Message-Id: <20250711114248.2288591-1-sashal@kernel.org>
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

The framework represents a fundamental shift from macro-based API
specifications to kerneldoc integration. Instead of requiring developers
to write specifications using C macros separate from documentation, the
framework now leverages the existing kerneldoc infrastructure. This
unification means developers write API specifications as part of their
regular documentation workflow, with the build system automatically
generating machine-readable C macros from these comments.

Changes since RFC v2:

1. Kerneldoc Integration: transition from C macros to kerneldoc
   comments.

2. Structured Parameter Specifications: Support for complex data
   structures with field-level constraints, including ranges, enums, and
   validation groups.

3. Hybrid Documentation Approach: Core API specifications remain inline
   with the implementation for tight coupling, while extended documentation
   (examples, detailed notes, complex constraints) can be maintained in
   separate files under Documentation/.

Sasha Levin (4):
  kernel/api: introduce kernel API specification framework
  kernel/api: enable kerneldoc-based API specifications
  mm/mlock: add API specification for mlock
  kernel/sched: add specs for sys_sched_setattr()

 Documentation/admin-guide/kernel-api-spec.rst |  507 ++++++
 Documentation/userspace-api/syscalls/mlock.rst|  118 ++
 MAINTAINERS                                   |    9 +
 arch/um/kernel/dyn.lds.S                      |    3 +
 arch/um/kernel/uml.lds.S                      |    3 +
 arch/x86/kernel/vmlinux.lds.S                 |    3 +
 include/asm-generic/vmlinux.lds.h             |   20 +
 include/linux/kernel_api_spec.h               | 1527 +++++++++++++++++
 include/linux/syscall_api_spec.h              |  137 ++
 include/linux/syscalls.h                      |   38 +
 init/Kconfig                                  |    2 +
 kernel/Makefile                               |    1 +
 kernel/api/Kconfig                            |   35 +
 kernel/api/Makefile                           |   26 +
 kernel/api/kernel_api_spec.c                  | 1122 ++++++++++++
 kernel/sched/syscalls.c                       |  168 +-
 mm/mlock.c                                    |   85 +
 scripts/Makefile.build                        |   28 +
 scripts/generate_api_specs.sh                 |   59 +
 scripts/kernel-doc.py                         |    5 +
 scripts/lib/kdoc/kdoc_apispec.py              |  623 +++++++
 scripts/lib/kdoc/kdoc_output.py               |    5 +-
 scripts/lib/kdoc/kdoc_parser.py               |   54 +-
 23 files changed, 4574 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/kernel-api-spec.rst
 create mode 100644 Documentation/userspace-api/syscalls/mlock.rst
 create mode 100644 include/linux/kernel_api_spec.h
 create mode 100644 include/linux/syscall_api_spec.h
 create mode 100644 kernel/api/Kconfig
 create mode 100644 kernel/api/Makefile
 create mode 100644 kernel/api/kernel_api_spec.c
 create mode 100755 scripts/generate_api_specs.sh
 create mode 100644 scripts/lib/kdoc/kdoc_apispec.py

-- 
2.39.5


