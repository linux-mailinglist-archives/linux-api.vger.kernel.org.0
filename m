Return-Path: <linux-api+bounces-6454-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bw7QMT4iGmow1wgAu9opvQ
	(envelope-from <linux-api+bounces-6454-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2026 01:33:18 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68787609C09
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2026 01:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C55623024F8E
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 23:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C933BBD0;
	Fri, 29 May 2026 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ11a3QO"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE228506C;
	Fri, 29 May 2026 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097596; cv=none; b=uJwtcx6gmpGCKLzA/Pl4pSXZd3qRGoEiUqMTnJJ3tUAz9GHQ5wcnf6oYMwmBrhUflJ/mgoYToi/0F0++Nw0GCfXDCfWMkOCV+x+xw4bDMDHSN54SPDJLqE0A7wWleqlpsijhsb0ayEfcFqlBYXlgOLF0aWlLGSbwja8VNkfHCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097596; c=relaxed/simple;
	bh=cr2J61wIRbdLJ8JeVUMZMRpYithBTTq8UapgpGnMiyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m85PTOUd3GYpi/edYCdAfWDnR7lIL4DeaCjrmH6Q3FrXF4KoYb7r9wbWCOFqMCwga5xNrAI5x1KZQj7qZNT4UtrIW+EArR9goSxMP8hEfXqheneSqt0Sco9quHUXEt2yBul2ztnGFvzqv+ocaQDZG3uERXvJ8/qgtHJdcOk2qUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ11a3QO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DA91F00893;
	Fri, 29 May 2026 23:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097595;
	bh=M2EDTxvUOf0FbYXWsVSHXg6R0s2buLubx0e5ZZg5Khk=;
	h=From:To:Cc:Subject:Date;
	b=hZ11a3QOKXffID46ltLUxrUd2cCaPk+eMhXGx8u5J1Lqig1jyCbNWvY8IBsmmvGge
	 0DXFCUBpnaFeMyS74W4xq2LFH2odLikObxUKzbmJh/8GNG4bUfu6svDhirg+YeyNJX
	 WMVucwiyOf6xkXAt9f00+Lv44Aon5eUvDeyY4v+GA+2D+aDUX2WAYlez231N0t8pjy
	 9RAW5DgtYZ9o8Bz559WbMHBzbrE2Y1RkJUTnvS8vTAlhvqZJtIUw8lwmoQoRSP7Vi1
	 wSqkymW4r18VqTS+PAmMxYrHeFKRqZq5HpaiXQhgiBMjQM5yoX91gGtjdeVpLa/Zy4
	 2MAFG5gCsEeZg==
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
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 00/11] Kernel API Specification Framework
Date: Fri, 29 May 2026 19:32:59 -0400
Message-ID: <20260529233311.1901670-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de,goodmis.org,efficios.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-6454-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 68787609C09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
querying, ftrace tracepoints that report each spec'd syscall's parameters and
return value, and a Rust-based extraction tool (tools/kapi) supporting JSON,
RST, and plain text output formats. Example specifications are provided for the
four fundamental file syscalls (sys_open, sys_close, sys_read, sys_write) and
for sys_madvise. The series also includes a KUnit test suite with 27 tests and
a runtime verification selftest with 29 TAP tests.

The series with runtime testing enabled (CONFIG_KAPI_RUNTIME_CHECKS=y)
currently survives LTP tests in a KVM VM.

Changes since v3:

- Fix the build with CONFIG_KAPI_SPEC=y: scripts/Makefile.build now derives the
  list of instrumented sources from $(real-obj-y)/$(real-obj-m) instead of a
  recursive find, and the detection regex matches "contexts:" (the token the
  syscalls actually use). The previous "context-flags:"-only match found no
  files, so no *.apispec.h was generated and the guarded includes failed to
  compile.

- Force-include the generated *.apispec.h via a per-object -include cflag in
  scripts/Makefile.build rather than a manual "#include" at the end of each
  instrumented source; the include blocks are dropped from fs/open.c and
  fs/read_write.c.

- kernel/Makefile: drop the redundant "obj- += api/"; the
  obj-$(CONFIG_KAPI_SPEC) gate already covers 'make clean'.

- kernel/api/Makefile: build kernel_api_spec.o with obj-y now that the subdir
  gate lives in kernel/Makefile.

- kernel/api/Kconfig: drop the tautological "default n" from KAPI_SPEC,
  KAPI_RUNTIME_CHECKS and KAPI_SPEC_DEBUGFS.

- Add an API specification for sys_madvise.

- Add ftrace tracepoints on the runtime-check path: kapi_syscall_enter (spec
  name and named parameter values) and kapi_syscall_exit (return value and
  spec match).

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

  v3: https://lore.kernel.org/all/20260424165130.2306833-1-sashal@kernel.org/
  v2: https://lore.kernel.org/all/20260322121026.869758-1-sashal@kernel.org/
  v1: https://lore.kernel.org/all/20260313150928.2637368-1-sashal@kernel.org/
  RFC v5: https://lore.kernel.org/lkml/20251218204239.4159453-1-sashal@kernel.org/
  RFC v4: https://lore.kernel.org/lkml/20250825181434.3340805-1-sashal@kernel.org/
  RFC v3: https://lore.kernel.org/lkml/20250711114248.2288591-1-sashal@kernel.org/
  RFC v2: https://lore.kernel.org/lkml/20250624180742.5795-1-sashal@kernel.org/
  RFC v1: https://lore.kernel.org/lkml/20250614134858.790460-1-sashal@kernel.org/

Sasha Levin (11):
  kernel/api: introduce kernel API specification framework
  kernel/api: enable kerneldoc-based API specifications
  kernel/api: add debugfs interface for kernel API specifications
  tools/kapi: add kernel API specification extraction tool
  kernel/api: add API specification for sys_open
  kernel/api: add API specification for sys_close
  kernel/api: add API specification for sys_read
  kernel/api: add API specification for sys_write
  kernel/api: add runtime verification selftest
  kernel/api: add API specification for sys_madvise
  kernel/api: add syscall enter/exit tracepoints

 .gitignore                                    |    1 +
 Documentation/dev-tools/index.rst             |    1 +
 Documentation/dev-tools/kernel-api-spec.rst   |  746 +++++
 MAINTAINERS                                   |   12 +
 Makefile                                      |    1 +
 arch/x86/include/asm/syscall_wrapper.h        |   40 +
 fs/open.c                                     |  561 ++++
 fs/read_write.c                               |  692 ++++
 include/asm-generic/vmlinux.lds.h             |   28 +
 include/linux/kernel_api_spec.h               | 1270 ++++++++
 include/linux/syscalls.h                      |   38 +
 include/trace/events/kapi.h                   |   74 +
 init/Kconfig                                  |    2 +
 kernel/Makefile                               |    1 +
 kernel/api/Kconfig                            |   74 +
 kernel/api/Makefile                           |   14 +
 kernel/api/internal.h                         |   21 +
 kernel/api/kapi_debugfs.c                     |  553 ++++
 kernel/api/kapi_kunit.c                       |  538 ++++
 kernel/api/kernel_api_spec.c                  | 1424 +++++++++
 mm/madvise.c                                  |  575 ++++
 scripts/Makefile.build                        |   20 +
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
 tools/lib/python/kdoc/kdoc_apispec.py         | 1313 ++++++++
 tools/lib/python/kdoc/kdoc_output.py          |    9 +-
 tools/lib/python/kdoc/kdoc_parser.py          |   86 +-
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/kapi/Makefile         |    7 +
 tools/testing/selftests/kapi/kapi_test_util.h |   33 +
 tools/testing/selftests/kapi/test_kapi.c      | 1096 +++++++
 47 files changed, 18167 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/dev-tools/kernel-api-spec.rst
 create mode 100644 include/linux/kernel_api_spec.h
 create mode 100644 include/trace/events/kapi.h
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


