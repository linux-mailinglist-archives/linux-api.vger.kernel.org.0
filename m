Return-Path: <linux-api+bounces-6013-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC2mFGzcv2m69QMAu9opvQ
	(envelope-from <linux-api+bounces-6013-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 13:11:24 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A65DA2E9085
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3BD630151CF
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9290236C59E;
	Sun, 22 Mar 2026 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STYWrpAg"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C533E372;
	Sun, 22 Mar 2026 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181433; cv=none; b=MkdZTo5hbSEiwO8zuJqn4M1UHuzunsxisfLWng/vEdEyIa474rCdWZ+wjC1dvD71PioAh6JtYpmCXr6Qpmld8HSpDZzMni/vsPEdOuQJfvosL0y0A34K2Q7xez12OGfL0qNwjtLKEYOLbU13sc30h38+QLqILwJa+q7kaDTtuE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181433; c=relaxed/simple;
	bh=eXYFZ7uGHI3Grre4sTGmBcfewI49V9FG78PjTdQ1SKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzLbTbw/aldSqPzTsmg8KJQ1J5Y2+Nb/Tj7yBR6SLzbX4UU64Sua3jbkkicvoWZUF8DkOIkYlNJHJTB2UuZYpbpAgig/F+i1OMeFcv93MZa6vts6rO++D3PAkRU2UtIvO4AnM9x+0ge28tBzBkSnWAbv5QwV4QS8enuSo5bj2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STYWrpAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5834EC2BCB1;
	Sun, 22 Mar 2026 12:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774181433;
	bh=eXYFZ7uGHI3Grre4sTGmBcfewI49V9FG78PjTdQ1SKY=;
	h=From:To:Cc:Subject:Date:From;
	b=STYWrpAgCo41wKZJhW7NJkEr3ztVpp0KU68Z2HYStMzLGJOHOBfqD6YN6swWHBaca
	 V/nCHHRjylD36MiDuZD8GAu3wRAldXDHs1YuhQoJ7N5s2gFBAEPUODB8MUdyW9hS8W
	 NemHjFt5jTsRk8tX9TVj+ob0JWYD8D7QSS5wjIHJEdj+TYIdEdxiFERbELTnXkzQuu
	 hV3K7eeDhoSNlRTPR5h2Egpr5Yw42qOpG7ideiI3AL+bvntDvfLVKTGIVysqpBR0al
	 0865/BdVyJSpulywHd8/Ez4pUEm+f5CNjnG4lCax8TfheOi35lBT9bYQIxS5/hgxO+
	 Cem9dVcC/Rd0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 0/9] Kernel API Specification Framework
Date: Sun, 22 Mar 2026 08:10:14 -0400
Message-ID: <20260322121026.869758-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-6013-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A65DA2E9085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
and plain text output formats. Example specifications are provided for the four
fundamental file syscalls (sys_open, sys_close, sys_read, sys_write). The
series also includes a KUnit test suite with 38 tests and a runtime
verification selftest with 29+ TAP tests.

The series with runtime testing enabled (CONFIG_KAPI_RUNTIME_CHECKS=y)
currently survives LTP tests in a KVM VM.

Changes since v1:

- Removed DEFINE_KERNEL_API_SPEC macro from user-facing documentation and
  examples. The macros are now internal plumbing only; kerneldoc annotations
  are the sole authoring interface. (Jonathan Corbet, Mauro Carvalho Chehab)

- Removed IOCTL specification section from documentation, as no IOCTL specs
  are included in this series. (Jonathan Corbet)

- Removed since-version field entirely from the framework: struct
  kernel_api_spec, debugfs output, JSON export, kdoc parser, and all
  extractors/formatters in the kapi tool. (Jonathan Corbet)

- Removed stale :Date: field from documentation. (Jonathan Corbet)

- Fixed kmalloc documentation example to include both parameters (size and
  flags) and a side-effect entry, matching the output example. (Jonathan Corbet)

- Simplified DSL references in documentation: converted Common Patterns
  section from raw macros to kerneldoc annotation format, removed macro
  references from Implementation Details and Troubleshooting. (Jonathan Corbet, Mauro Carvalho Chehab)

- Reworded sys_close spec to describe behavior without referencing kernel
  internal callbacks: "flush callback" replaced with "close-time flush
  operation", "release callback" references removed entirely. (Greg Kroah-Hartman)

- Removed HP-UX reference and "implementation-defined behavior" phrasing
  from sys_close spec. (Greg Kroah-Hartman)

- Added copyright lines to all new files: C headers, kernel modules, Python
  scripts, Rust source files, and selftests. (Greg Kroah-Hartman)

- Fixed rebasing artifact where patch 3 removed content from patch 1's
  documentation additions. (Greg Kroah-Hartman)

- Removed unnecessary pr_info() from debugfs init and braces from
  single-line for loop. (Greg Kroah-Hartman)

- Added commit message changelogs to all patches. (Greg Kroah-Hartman)

References:

  v1: https://lore.kernel.org/all/20260313150928.2637368-1-sashal@kernel.org/
  RFC v5: https://lore.kernel.org/lkml/20251218204239.4159453-1-sashal@kernel.org/
  RFC v4: https://lore.kernel.org/lkml/20250825181434.3340805-1-sashal@kernel.org/
  RFC v3: https://lore.kernel.org/lkml/20250711114248.2288591-1-sashal@kernel.org/
  RFC v2: https://lore.kernel.org/lkml/20250624180742.5795-1-sashal@kernel.org/
  RFC v1: https://lore.kernel.org/lkml/20250614134858.790460-1-sashal@kernel.org/

Sasha Levin (9):
  kernel/api: introduce kernel API specification framework
  kernel/api: enable kerneldoc-based API specifications
  kernel/api: add debugfs interface for kernel API specifications
  tools/kapi: Add kernel API specification extraction tool
  kernel/api: add API specification for sys_open
  kernel/api: add API specification for sys_close
  kernel/api: add API specification for sys_read
  kernel/api: add API specification for sys_write
  kernel/api: add runtime verification selftest

 .gitignore                                    |    1 +
 Documentation/dev-tools/index.rst             |    1 +
 Documentation/dev-tools/kernel-api-spec.rst   |  620 +++++++
 MAINTAINERS                                   |   12 +
 arch/x86/include/asm/syscall_wrapper.h        |   40 +
 fs/open.c                                     |  565 +++++-
 fs/read_write.c                               |  683 +++++++
 include/asm-generic/vmlinux.lds.h             |   28 +
 include/linux/kernel_api_spec.h               | 1580 +++++++++++++++++
 include/linux/syscall_api_spec.h              |  186 ++
 include/linux/syscalls.h                      |   39 +
 init/Kconfig                                  |    2 +
 kernel/Makefile                               |    3 +
 kernel/api/.gitignore                         |    2 +
 kernel/api/Kconfig                            |   70 +
 kernel/api/Makefile                           |   14 +
 kernel/api/kapi_debugfs.c                     |  499 ++++++
 kernel/api/kapi_kunit.c                       |  538 ++++++
 kernel/api/kernel_api_spec.c                  | 1277 +++++++++++++
 scripts/Makefile.build                        |   31 +
 scripts/Makefile.clean                        |    3 +
 tools/docs/kernel-doc                         |    5 +
 tools/kapi/.gitignore                         |    4 +
 tools/kapi/Cargo.toml                         |   19 +
 tools/kapi/src/extractor/debugfs.rs           |  578 ++++++
 tools/kapi/src/extractor/kerneldoc_parser.rs  | 1555 ++++++++++++++++
 tools/kapi/src/extractor/mod.rs               |  461 +++++
 tools/kapi/src/extractor/source_parser.rs     |  408 +++++
 .../src/extractor/vmlinux/binary_utils.rs     |  508 ++++++
 .../src/extractor/vmlinux/magic_finder.rs     |  115 ++
 tools/kapi/src/extractor/vmlinux/mod.rs       |  844 +++++++++
 tools/kapi/src/formatter/json.rs              |  720 ++++++++
 tools/kapi/src/formatter/mod.rs               |  142 ++
 tools/kapi/src/formatter/plain.rs             |  707 ++++++++
 tools/kapi/src/formatter/rst.rs               |  850 +++++++++
 tools/kapi/src/main.rs                        |  122 ++
 tools/lib/python/kdoc/kdoc_apispec.py         |  888 +++++++++
 tools/lib/python/kdoc/kdoc_output.py          |    9 +-
 tools/lib/python/kdoc/kdoc_parser.py          |   85 +-
 tools/testing/selftests/kapi/Makefile         |    7 +
 tools/testing/selftests/kapi/kapi_test_util.h |   33 +
 tools/testing/selftests/kapi/test_kapi.c      | 1023 +++++++++++
 42 files changed, 15268 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/dev-tools/kernel-api-spec.rst
 create mode 100644 include/linux/kernel_api_spec.h
 create mode 100644 include/linux/syscall_api_spec.h
 create mode 100644 kernel/api/.gitignore
 create mode 100644 kernel/api/Kconfig
 create mode 100644 kernel/api/Makefile
 create mode 100644 kernel/api/kapi_debugfs.c
 create mode 100644 kernel/api/kapi_kunit.c
 create mode 100644 kernel/api/kernel_api_spec.c
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
 create mode 100644 tools/testing/selftests/kapi/Makefile
 create mode 100644 tools/testing/selftests/kapi/kapi_test_util.h
 create mode 100644 tools/testing/selftests/kapi/test_kapi.c

-- 
2.51.0


