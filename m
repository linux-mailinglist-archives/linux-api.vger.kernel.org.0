Return-Path: <linux-api+bounces-5943-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO00AuYstGkEigAAu9opvQ
	(envelope-from <linux-api+bounces-5943-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:27:34 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C6E285F14
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 824FC307599B
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22AC3A8750;
	Fri, 13 Mar 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELk6eE1P"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B2399009;
	Fri, 13 Mar 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414587; cv=none; b=gZenCXpa3qS4kK3xNdQwcBwZk8IygXunuhEJO2iXSKOSBCZ/i6ydjGWUTB9a5O5yRVMU2qyoDbUIUDCEIgEAgozUJHV2ck2LIFLU1TA+puh83RqfIGlZwyuFSwy81htZTRUxk62SiAIELMvoj25iny1BvlgUv0CMglqV1bINgvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414587; c=relaxed/simple;
	bh=G8+4urbwl/kl8Syy8w8X2OZmP6dOqFG95NsWDRZd+Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEhu/ho8Vj933aiz+nUhKGZbq2Yx+53YXvKKuJCHcxC/C2MuuSQ53HvALK1X0REEpo22f50Qg1nCUDoXRIBUOWaxB6LWB8+9m2tdfOoogNNrm6MuXSNlFj8FfK1SMTjskmVpHdbHDvPtaxHQUkCb45UNtYWNHfLiELbKdBcciYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELk6eE1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49068C19421;
	Fri, 13 Mar 2026 15:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773414587;
	bh=G8+4urbwl/kl8Syy8w8X2OZmP6dOqFG95NsWDRZd+Zg=;
	h=From:To:Cc:Subject:Date:From;
	b=ELk6eE1PBmYWdy9eoLPDeApT2mrAgrUGPLIq4yDpcDkR6SZbwjuDub7i/gczjtq3Q
	 hppNUMyp8D9z5XbNGowoqAfxLbZTKtUzCRiKL5PmmXRQaP0z2foRrpcuhgaTseg5ch
	 oiSJU7vcTBgcDxAOfCVjHqJbdPy9NzlNH+WvajyPZ79n17pP05ouKOekZ9/iEOBHSh
	 Vtijio3ng6Cr7zeD/InpBh55xaHLSO/EFk7R1YT2YB2nbOCIF/L1X8360iOPjAhl6V
	 7Fr7VwC1YkJR3xgElJkg4ggviJ5rstKwgNEmQ+VpFTrSbIZPGJAL77Wz7xQT4DRQmH
	 tdc62ySffmE0g==
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
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: [PATCH 0/9] Kernel API Specification Framework
Date: Fri, 13 Mar 2026 11:09:10 -0400
Message-ID: <20260313150928.2637368-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-5943-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05C6E285F14
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

Changes since RFC v5:

- Streamlined example specs: focus on open/close/read/write to start with.

- Added KUnit test suite.

- Added runtime verification selftest.

- Fixed kernel test robot warnings from v5: fixed "document isn't included in
  any toctree" (kernel-api-spec.rst now properly added to
  Documentation/dev-tools/index.rst), fixed sparse "non size-preserving
  integer to pointer cast" warnings in kernel_api_spec.c.

- Rebased on v7.0-rc1.

References:

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
 Documentation/dev-tools/kernel-api-spec.rst   |  629 +++++++
 MAINTAINERS                                   |   12 +
 arch/x86/include/asm/syscall_wrapper.h        |   40 +
 fs/open.c                                     |  576 +++++-
 fs/read_write.c                               |  687 +++++++
 include/asm-generic/vmlinux.lds.h             |   28 +
 include/linux/kernel_api_spec.h               | 1580 +++++++++++++++++
 include/linux/syscall_api_spec.h              |  192 ++
 include/linux/syscalls.h                      |   39 +
 init/Kconfig                                  |    2 +
 kernel/Makefile                               |    3 +
 kernel/api/.gitignore                         |    2 +
 kernel/api/Kconfig                            |   70 +
 kernel/api/Makefile                           |   14 +
 kernel/api/kapi_debugfs.c                     |  503 ++++++
 kernel/api/kapi_kunit.c                       |  536 ++++++
 kernel/api/kernel_api_spec.c                  | 1277 +++++++++++++
 scripts/Makefile.build                        |   31 +
 scripts/Makefile.clean                        |    3 +
 tools/docs/kernel-doc                         |    5 +
 tools/kapi/.gitignore                         |    4 +
 tools/kapi/Cargo.toml                         |   19 +
 tools/kapi/src/extractor/debugfs.rs           |  581 ++++++
 tools/kapi/src/extractor/kerneldoc_parser.rs  | 1554 ++++++++++++++++
 tools/kapi/src/extractor/mod.rs               |  463 +++++
 tools/kapi/src/extractor/source_parser.rs     |  405 +++++
 .../src/extractor/vmlinux/binary_utils.rs     |  505 ++++++
 .../src/extractor/vmlinux/magic_finder.rs     |  112 ++
 tools/kapi/src/extractor/vmlinux/mod.rs       |  842 +++++++++
 tools/kapi/src/formatter/json.rs              |  727 ++++++++
 tools/kapi/src/formatter/mod.rs               |  140 ++
 tools/kapi/src/formatter/plain.rs             |  708 ++++++++
 tools/kapi/src/formatter/rst.rs               |  852 +++++++++
 tools/kapi/src/main.rs                        |  119 ++
 tools/lib/python/kdoc/kdoc_apispec.py         |  887 +++++++++
 tools/lib/python/kdoc/kdoc_output.py          |    9 +-
 tools/lib/python/kdoc/kdoc_parser.py          |   86 +-
 tools/testing/selftests/kapi/Makefile         |    7 +
 tools/testing/selftests/kapi/kapi_test_util.h |   31 +
 tools/testing/selftests/kapi/test_kapi.c      | 1021 +++++++++++
 42 files changed, 15294 insertions(+), 9 deletions(-)
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


