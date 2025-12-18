Return-Path: <linux-api+bounces-5551-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA128CCD8BC
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 21:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 879B23049D05
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA22D9792;
	Thu, 18 Dec 2025 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdHblVki"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4512D8DA8;
	Thu, 18 Dec 2025 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090566; cv=none; b=cGDWpY9zHxwiHCoNiQrflW8GYUUA0X3/AAHmY3xbLzbgQ0SqFbJ+OSrTuNYuCYcHMnomR+qKqrdDjrD6DmTZj6bXdnsZ6RxAThXfqoxuY1tVz7W9jHwXDfCvEIlkHR++miWHyd0TAN5UvGDmvuylZ5mh34Q3/nyJvH3Xhr3jyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090566; c=relaxed/simple;
	bh=3loGYdzQvnO2g3Fd0wQ9qrlPlC0PHzRKQT9OMQikIVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7rnZXbu8DlK0lzn9TunNXqhyIoLdMqZmtwnvKqDoeagyYX6rAXFIcVJClGBIQBkRO+ZBZbbh/c9TZj0SeHIIJyDQUemZvYT3tIUmucWaxD16cSEkpJevdNeYW3VExv8Eq+4BBh1VC7X27QNdQ1nLmReeb47ZizfmnmjdfzJjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdHblVki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50680C4CEFB;
	Thu, 18 Dec 2025 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090566;
	bh=3loGYdzQvnO2g3Fd0wQ9qrlPlC0PHzRKQT9OMQikIVw=;
	h=From:To:Cc:Subject:Date:From;
	b=RdHblVki4WyhZK97L1VgOpNqif0Ild7VXQgxTa38V8PwcC7Hng2MlnE3n9wd88QQo
	 p5+CyeVoQM9Sv74QzAPeRSV8TOXsr+qbtON3QMRIYzDUqEai7CetCxHysZxGwUq5u0
	 yWgH35BAWt1lVKlOUr9PzmwOFmrbGKipPVe0nt9MYrg0rfUnZ5US7i5Fjyj2zYJbq+
	 j+sTR+3XeZ2LGlUdREK+H9Ck2BvIj2U5TH1RtSMWtZFlyE86IvqVlkzb8/oqiZToE6
	 nsltjYyrXUYuxDiBUDLuSfgb/026XewghcGqs+9RIOA/EJ4oUYTDTrzSXBgpQ5thhZ
	 39yKzM/XrHWjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 00/15] Kernel API Specification Framework
Date: Thu, 18 Dec 2025 15:42:22 -0500
Message-ID: <20251218204239.4159453-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This proposal introduces machinery for documenting kernel APIs, addressing the
long-standing challenge of maintaining stable interfaces between the kernel and
user-space programs. Despite the kernel's commitment to never breaking user
space, the lack of machine-readable API specifications has led to breakages and
across system calls and IOCTLs.

Specifications can document parameter types, valid ranges, constraints, and
alignment requirements. They capture return value semantics including success
conditions and error codes with their meaning. Execution context requirements,
capabilities, locking constraints, signal handling behavior, and side effects
can all be formally specified.

These specifications live alongside the code they document and are both
human-readable and machine-parseable. They can be validated at runtime when
CONFIG_KAPI_RUNTIME_CHECKS is enabled, exported via debugfs for userspace
tools, and extracted from either vmlinux or source code.

This enables static analysis tools to verify userspace API usage at compile
time, test generation based on formal specifications, consistent error handling
validation, automated documentation generation, and formal verification of
kernel interfaces.

The implementation includes a core framework with ELF section storage,
kerneldoc integration for inline specification, a debugfs interface for runtime
querying, and a Rust-based extraction tool (tools/kapi) supporting JSON, RST,
and plain text output formats. Example specifications are provided for async
I/O, xattr, and basic file operation syscalls.

The series with runtime testing enabled (CONFIG_KAPI_RUNTIME_CHECKS=y)
currently survives LTP tests in a KVM VM.

I am not looking for a review of the actual specs just yet. Those are
LLM generated, and the main focus right now is the format of the spec
rather than the individual specs. Having said that, there is a set with
more syscall specs (100+) available at
git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux.git branch
"spec" for folks who are interested in testing it out.

Changes since RFC v4:

- Rebase on top of v6.19-rc1, addressing a few conflict resulting of how
  Documentation/ now handles python.
- Moved documentation from Documentation/admin-guide/ to
  Documentation/dev-tools/ (Randy Dunlap)
- Different examples of specs to hopefully allow for better review.
- Simplified architecture support by using generic vmlinux.lds.h instead of
  per-architecture linker script modifications.

Sasha Levin (15):
  kernel/api: introduce kernel API specification framework
  kernel/api: enable kerneldoc-based API specifications
  kernel/api: add debugfs interface for kernel API specifications
  tools/kapi: Add kernel API specification extraction tool
  kernel/api: add API specification for io_setup
  kernel/api: add API specification for io_destroy
  kernel/api: add API specification for io_submit
  kernel/api: add API specification for io_cancel
  kernel/api: add API specification for setxattr
  kernel/api: add API specification for lsetxattr
  kernel/api: add API specification for fsetxattr
  kernel/api: add API specification for sys_open
  kernel/api: add API specification for sys_close
  kernel/api: add API specification for sys_read
  kernel/api: add API specification for sys_write

 .gitignore                                    |    1 +
 Documentation/dev-tools/kernel-api-spec.rst   |  699 ++++++++
 MAINTAINERS                                   |    9 +
 fs/aio.c                                      |  982 +++++++++-
 fs/open.c                                     |  565 +++++-
 fs/read_write.c                               |  664 +++++++
 fs/xattr.c                                    |  959 ++++++++++
 include/asm-generic/vmlinux.lds.h             |   28 +
 include/linux/kernel_api_spec.h               | 1597 +++++++++++++++++
 include/linux/syscall_api_spec.h              |  198 ++
 include/linux/syscalls.h                      |   38 +
 init/Kconfig                                  |    2 +
 kernel/Makefile                               |    3 +
 kernel/api/Kconfig                            |   55 +
 kernel/api/Makefile                           |   32 +
 kernel/api/kapi_debugfs.c                     |  358 ++++
 kernel/api/kernel_api_spec.c                  | 1185 ++++++++++++
 scripts/Makefile.build                        |   28 +
 scripts/Makefile.clean                        |    3 +
 scripts/generate_api_specs.sh                 |   87 +
 scripts/kernel-doc.py                         |    5 +
 tools/kapi/.gitignore                         |    4 +
 tools/kapi/Cargo.toml                         |   19 +
 tools/kapi/src/extractor/debugfs.rs           |  442 +++++
 tools/kapi/src/extractor/kerneldoc_parser.rs  |  692 +++++++
 tools/kapi/src/extractor/mod.rs               |  464 +++++
 tools/kapi/src/extractor/source_parser.rs     |  213 +++
 .../src/extractor/vmlinux/binary_utils.rs     |  180 ++
 .../src/extractor/vmlinux/magic_finder.rs     |  102 ++
 tools/kapi/src/extractor/vmlinux/mod.rs       |  864 +++++++++
 tools/kapi/src/formatter/json.rs              |  468 +++++
 tools/kapi/src/formatter/mod.rs               |  140 ++
 tools/kapi/src/formatter/plain.rs             |  549 ++++++
 tools/kapi/src/formatter/rst.rs               |  621 +++++++
 tools/kapi/src/main.rs                        |  116 ++
 tools/lib/python/kdoc/kdoc_apispec.py         |  755 ++++++++
 tools/lib/python/kdoc/kdoc_output.py          |    9 +-
 tools/lib/python/kdoc/kdoc_parser.py          |   86 +-
 38 files changed, 13176 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/dev-tools/kernel-api-spec.rst
 create mode 100644 include/linux/kernel_api_spec.h
 create mode 100644 include/linux/syscall_api_spec.h
 create mode 100644 kernel/api/Kconfig
 create mode 100644 kernel/api/Makefile
 create mode 100644 kernel/api/kapi_debugfs.c
 create mode 100644 kernel/api/kernel_api_spec.c
 create mode 100755 scripts/generate_api_specs.sh
 create mode 100644 tools/kapi/.gitignore
 create mode 100644 tools/kapi/Cargo.toml
 create mode 100644 tools/kapi/src/extractor/debugfs.rs
 create mode 100644 tools/kapi/src/extractor/kerneldoc_parser.rs
 create mode 100644 tools/kapi/src/extractor/mod.rs
 create mode 100644 tools/kapi/src/extractor/source_parser.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/binary_utils.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/magic_finder.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/mod.rs
 create mode 100644 tools/kapi/src/formatter/json.rs
 create mode 100644 tools/kapi/src/formatter/mod.rs
 create mode 100644 tools/kapi/src/formatter/plain.rs
 create mode 100644 tools/kapi/src/formatter/rst.rs
 create mode 100644 tools/kapi/src/main.rs
 create mode 100644 tools/lib/python/kdoc/kdoc_apispec.py

-- 
2.51.0


