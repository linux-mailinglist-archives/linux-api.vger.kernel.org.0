Return-Path: <linux-api+bounces-4579-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A015B349EC
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 20:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A3F18876E0
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20930DEB7;
	Mon, 25 Aug 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPpEGVvZ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042019D081;
	Mon, 25 Aug 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145677; cv=none; b=LZuypasHGOH+vLOaRTBc5zb7HFVQT8HpgJZbx6hsZboy64D495RwHNEaPy8Xv8wwDYH4/rK3dGOb9J4dY2MfnJ0maRLX1d/ye0EOli7yvdBhom2BXHdooCtUt7P/O6x1HaEf0KbMkiHhoQhyyB6b0QvLRCOmb7iXr3UiYIC+AzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145677; c=relaxed/simple;
	bh=cA9zP7oe/Wj0xeQ31ilu5os5kJlEQUWjsHh3iubtKMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KsO/8fJiZ/FerXULj3EQgM0C04sIDv9E8PK+v4d1jRraXh9CTXgXNaTv/KnFzXip41Ktzl6iuGmu03mRSh1ZIRh3WsZvnUAMQeLLsOe2rCiEl5DpHTr+rH1cxxLbXe+2WqD3mpjKnygB7QlQBcNJrb9+FaBVjqDIBk/5qvxHfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPpEGVvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A889CC4CEED;
	Mon, 25 Aug 2025 18:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145677;
	bh=cA9zP7oe/Wj0xeQ31ilu5os5kJlEQUWjsHh3iubtKMs=;
	h=From:To:Cc:Subject:Date:From;
	b=rPpEGVvZt1JNFBFvgm1+uWS4vfP7NGsTZj9KJQ3AjDNz0PMjpJZVHhVZMDM/04qGt
	 hNAFiThY7skcP5ClItOF1pK2zO37CWxqWnRLSd896JL7sl9si8d5UMv0CTMF0qP6JA
	 x1bpRgPHZe4seiIAk2UkxNYOIxrC5HGaEd614AI8Dt19eMZdt/BwY06vjlBNog2ZiA
	 kATVVs/DjmRTo+JBfhGKR5W5HZtcFzou15ZvpbuRMhcIaXq5nXa+ew7PySWBjTeifT
	 rt+/zHqtnW5/yD6CK9Nm9I9e/qdVWQvbjcwv/T5BIUe4KHrgiDAnAwzEixCICrijTP
	 krsuOvHAt9W1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v4 0/7] Kernel API Specification Framework
Date: Mon, 25 Aug 2025 14:14:27 -0400
Message-ID: <20250825181434.3340805-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a framework for formally specifying kernel APIs,
addressing the long-standing challenge of maintaining stable interfaces between
the kernel and user-space programs. As outlined in previous discussions about
kernel ABI stability, the lack of machine-readable API specifications has led
to inadvertent breakages and inconsistent validation across system calls and
IOCTLs.

Changes since RFC v3:

1. Improved kerneldoc format for better readability.

2. Added kerneldoc parsing support in the kapi tool.

3. Use magic markers in the binary output to simplify extraction.

Sasha Levin (7):
  kernel/api: introduce kernel API specification framework
  kernel/api: enable kerneldoc-based API specifications
  kernel/api: add debugfs interface for kernel API specifications
  kernel/sched: add specs for sys_sched_setattr()
  mm/mlock: add API specification for mlock
  fs/exec: add API specification for execveat
  tools/kapi: Add kernel API specification extraction tool

 .gitignore                                    |    1 +
 Documentation/admin-guide/kernel-api-spec.rst |  699 ++++++++
 MAINTAINERS                                   |    9 +
 arch/um/kernel/dyn.lds.S                      |    3 +
 arch/um/kernel/uml.lds.S                      |    3 +
 arch/x86/kernel/vmlinux.lds.S                 |    3 +
 fs/exec.c                                     |  594 +++++++
 include/asm-generic/vmlinux.lds.h             |   20 +
 include/linux/kernel_api_spec.h               | 1559 +++++++++++++++++
 include/linux/syscall_api_spec.h              |  125 ++
 include/linux/syscalls.h                      |   38 +
 init/Kconfig                                  |    2 +
 kernel/Makefile                               |    1 +
 kernel/api/Kconfig                            |   55 +
 kernel/api/Makefile                           |   30 +
 kernel/api/kapi_debugfs.c                     |  334 ++++
 kernel/api/kernel_api_spec.c                  | 1155 ++++++++++++
 kernel/sched/syscalls.c                       |  315 +++-
 mm/mlock.c                                    |  134 ++
 scripts/Makefile.build                        |   28 +
 scripts/generate_api_specs.sh                 |   68 +
 scripts/kernel-doc.py                         |    5 +
 scripts/lib/kdoc/kdoc_apispec.py              |  714 ++++++++
 scripts/lib/kdoc/kdoc_output.py               |    9 +-
 scripts/lib/kdoc/kdoc_parser.py               |   50 +-
 tools/kapi/.gitignore                         |    4 +
 tools/kapi/Cargo.toml                         |   19 +
 tools/kapi/src/extractor/debugfs.rs           |  442 +++++
 tools/kapi/src/extractor/kerneldoc_parser.rs  |  694 ++++++++
 tools/kapi/src/extractor/mod.rs               |  461 +++++
 tools/kapi/src/extractor/source_parser.rs     |  213 +++
 .../src/extractor/vmlinux/binary_utils.rs     |  180 ++
 .../src/extractor/vmlinux/magic_finder.rs     |  102 ++
 tools/kapi/src/extractor/vmlinux/mod.rs       |  869 +++++++++
 tools/kapi/src/formatter/json.rs              |  468 +++++
 tools/kapi/src/formatter/mod.rs               |  145 ++
 tools/kapi/src/formatter/plain.rs             |  558 ++++++
 tools/kapi/src/formatter/rst.rs               |  621 +++++++
 tools/kapi/src/formatter/shall.rs             |  891 ++++++++++
 tools/kapi/src/main.rs                        |  116 ++
 40 files changed, 11732 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/kernel-api-spec.rst
 create mode 100644 include/linux/kernel_api_spec.h
 create mode 100644 include/linux/syscall_api_spec.h
 create mode 100644 kernel/api/Kconfig
 create mode 100644 kernel/api/Makefile
 create mode 100644 kernel/api/kapi_debugfs.c
 create mode 100644 kernel/api/kernel_api_spec.c
 create mode 100755 scripts/generate_api_specs.sh
 create mode 100644 scripts/lib/kdoc/kdoc_apispec.py
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
 create mode 100644 tools/kapi/src/formatter/shall.rs
 create mode 100644 tools/kapi/src/main.rs

-- 
2.50.1


