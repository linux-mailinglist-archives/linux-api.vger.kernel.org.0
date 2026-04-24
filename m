Return-Path: <linux-api+bounces-6167-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPpyMvWh62kbPgAAu9opvQ
	(envelope-from <linux-api+bounces-6167-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 19:01:41 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3985461813
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 19:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD027301E3FD
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887D23D9035;
	Fri, 24 Apr 2026 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAAAQkrf"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF933E355;
	Fri, 24 Apr 2026 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049496; cv=none; b=Jz45WcWuqI2zC8HpY//Rv0fYwdioOd3TUhNOkESXbdRkxlGT5ujsbbUYZG9ML45qKQ1TR14el8iWDLSQu/C8DNl7IP2dZZoVE0v/8X2rWuN1X//UTHP8FowoLpFzd342smU0LykIepsy4Qinu0VNSELiwar3zQKtWfovSl1PsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049496; c=relaxed/simple;
	bh=H33Ls5pcEb9yVpjrsIIokmBmIDGsoErkqLOTcwUdbMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0E+oeO7jL1h8QgD3mVFY3MeEHzCJFW4Gy31Tz78mZ+JYt5sLRfznf1uMz7HNHCTE3FhBAMUJ/1opYkmABK4wK7WxMNseVc9Fe6FKNUC+jv4vnjiwVovb202gJcLtlNDWMCpDVeXomGzyqH1x0q9JctgUkPKdohXDi9vSOwk/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAAAQkrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E8DC19425;
	Fri, 24 Apr 2026 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777049496;
	bh=H33Ls5pcEb9yVpjrsIIokmBmIDGsoErkqLOTcwUdbMs=;
	h=From:To:Cc:Subject:Date:From;
	b=RAAAQkrfj5d21vWPedH3peKTh0F+ICh0aFRvtsZjOr9eS9YVlpIIW9IE74pTQZvsD
	 hpdJaEJPyFeD1nHKj+i3R7RZ1+Y/ytJIGPfAiVrpTFZH2hWS0KfsiBotOpyz3vMxv4
	 SYmeyxdkX3QrzsIlDxtw/9vZHTHLIC2HkOZqv8JNWwC7DAYEw864EJ/BrP2ahvInVN
	 Fz3dtSQXh0i+OqOlT2AbQZ09teEDwQZ4jR1oX5QpDhjicVtSA7lt06Et8+LyCeDsuW
	 v3zn18Qut0ly8NuQn3a6Ctca9EzoQ6Zpr2RbEfDOFD1FYICfruurPXFa93N1Jp6PJf
	 lgCEBV+ZLD8CA==
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
Subject: [PATCH v3 0/9] Kernel API Specification Framework
Date: Fri, 24 Apr 2026 12:51:20 -0400
Message-ID: <20260424165130.2306833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C3985461813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6167-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

This proposal introduces machinery for documenting kernel APIs, addressing the
long-standing challenge of maintaining stable interfaces between the kernel and
user-space programs. Despite the kernel's commitment to never breaking user
space, the lack of machine-readable API specifications has led to breakages
across kernel interfaces.

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
series also includes a KUnit test suite with 27 tests and a runtime
verification selftest with 29 TAP tests.

The series with runtime testing enabled (CONFIG_KAPI_RUNTIME_CHECKS=y)
currently survives LTP tests in a KVM VM.

Changes since v2:

- Replace statically sized arrays in the spec structs with const char *
  pointers to reduce memory footprint and remove string truncation.

- Simplify the kerneldoc DSL to short tokens (e.g. `type: uint, input`,
  `contexts: process, softirq`, `constraint-type: range(0, KMAX)`,
  `side-effect: alloc_memory`) in place of raw KAPI_* enum names.

- tools/kapi: commit Cargo.lock for reproducible offline builds, add a
  Makefile and README, expand the kerneldoc parser to cover the full
  DSL, and refactor the vmlinux extractor for the const-pointer layout.

- tools/lib/python/kdoc/kdoc_apispec.py expanded to match the DSL so
  scripts/kernel-doc --apispec emits the structure the extractor consumes.

References:

  v2: https://lore.kernel.org/all/20260322121026.869758-1-sashal@kernel.org/
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
  tools/kapi: add kernel API specification extraction tool
  kernel/api: add API specification for sys_open
  kernel/api: add API specification for sys_close
  kernel/api: add API specification for sys_read
  kernel/api: add API specification for sys_write
  kernel/api: add runtime verification selftest

 .gitignore                                    |    1 +
 Documentation/dev-tools/index.rst             |    1 +
 Documentation/dev-tools/kernel-api-spec.rst   |  704 ++++
 MAINTAINERS                                   |   11 +
 arch/x86/include/asm/syscall_wrapper.h        |   40 +
 fs/open.c                                     |  566 ++++
 fs/read_write.c                               |  697 ++++
 include/asm-generic/vmlinux.lds.h             |   28 +
 include/linux/kernel_api_spec.h               | 1269 ++++++++
 include/linux/syscalls.h                      |   38 +
 init/Kconfig                                  |    2 +
 kernel/Makefile                               |    3 +
 kernel/api/.gitignore                         |    2 +
 kernel/api/Kconfig                            |   77 +
 kernel/api/Makefile                           |   14 +
 kernel/api/internal.h                         |   21 +
 kernel/api/kapi_debugfs.c                     |  553 ++++
 kernel/api/kapi_kunit.c                       |  538 ++++
 kernel/api/kernel_api_spec.c                  | 1362 ++++++++
 scripts/Makefile.build                        |   31 +
 scripts/Makefile.clean                        |    3 +
 tools/docs/kernel-doc                         |    5 +
 tools/kapi/.gitignore                         |    4 +
 tools/kapi/Cargo.lock                         |  679 ++++
 tools/kapi/Cargo.toml                         |   20 +
 tools/kapi/Makefile                           |   33 +
 tools/kapi/README.md                          |   32 +
 tools/kapi/src/extractor/debugfs.rs           |  849 +++++
 tools/kapi/src/extractor/kerneldoc_parser.rs  | 2831 +++++++++++++++++
 tools/kapi/src/extractor/mod.rs               |  388 +++
 tools/kapi/src/extractor/source_parser.rs     |  415 +++
 .../src/extractor/vmlinux/binary_utils.rs     |  462 +++
 .../src/extractor/vmlinux/magic_finder.rs     |  115 +
 tools/kapi/src/extractor/vmlinux/mod.rs       |  857 +++++
 tools/kapi/src/formatter/json.rs              |  634 ++++
 tools/kapi/src/formatter/mod.rs               |  122 +
 tools/kapi/src/formatter/plain.rs             |  646 ++++
 tools/kapi/src/formatter/rst.rs               |  726 +++++
 tools/kapi/src/main.rs                        |  123 +
 tools/lib/python/kdoc/kdoc_apispec.py         | 1249 ++++++++
 tools/lib/python/kdoc/kdoc_output.py          |    9 +-
 tools/lib/python/kdoc/kdoc_parser.py          |   86 +-
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/kapi/Makefile         |    7 +
 tools/testing/selftests/kapi/kapi_test_util.h |   33 +
 tools/testing/selftests/kapi/test_kapi.c      | 1096 +++++++
 46 files changed, 17378 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/dev-tools/kernel-api-spec.rst
 create mode 100644 include/linux/kernel_api_spec.h
 create mode 100644 kernel/api/.gitignore
 create mode 100644 kernel/api/Kconfig
 create mode 100644 kernel/api/Makefile
 create mode 100644 kernel/api/internal.h
 create mode 100644 kernel/api/kapi_debugfs.c
 create mode 100644 kernel/api/kapi_kunit.c
 create mode 100644 kernel/api/kernel_api_spec.c
 create mode 100644 tools/kapi/.gitignore
 create mode 100644 tools/kapi/Cargo.lock
 create mode 100644 tools/kapi/Cargo.toml
 create mode 100644 tools/kapi/Makefile
 create mode 100644 tools/kapi/README.md
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
2.53.0


