Return-Path: <linux-api+bounces-2087-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E45944B5E
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 14:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB9D281569
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D5119538D;
	Thu,  1 Aug 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6OvicIN"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5349641;
	Thu,  1 Aug 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515598; cv=none; b=rJPlfkUDIkyIyH/ZFu5Y7vq5PdPBYj/k6K5j7XcumfdE7Ee3pudW2fMiiHOXEfIauPDfWupIMFTetFtYvkMlbPzopyIfCNUqzPhL4VJWZFe5piifssAcHxGemvP7Utbo5lqsKd/EmE0wwdfL5Zyh28LgYeF5l+Bz1lcQg8nz5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515598; c=relaxed/simple;
	bh=4aOsClOUPnAaG9L0WTgcWPLsN20TbGHJxOPzz8LH9jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULeIt1k69n4adPTDZp8N/tXZlX3mmA4juYFMZDFPifLpivtuTQQK4PA3/hNOq0mQkebuuoZXD2wrzPXAwYGGU2iif5TiPI27VSQky5jaAfva8EbyxpFTl3WguFdaKUibGPwk6sbMLIrkws7oQsBii4vGYIxQbP6TLNXGnqWPvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6OvicIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A281FC32786;
	Thu,  1 Aug 2024 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722515597;
	bh=4aOsClOUPnAaG9L0WTgcWPLsN20TbGHJxOPzz8LH9jg=;
	h=From:To:Cc:Subject:Date:From;
	b=b6OvicIN5ag2uDECZrMW/7VfkT9HERuTj8qcQQFTP+ojAJ1xLSW9Rl/I6unXUj52n
	 I+kr2gohM/Nz2uGnehivcWGGW6nP0I9vzQOuT4aJoX9XeZPcYGg9VFmnpbqYUfrSfn
	 kL0chkz95j8GFJdvYQMjybRNX1poNzWQZQwnv8ISknQfis+9QYYgZ7IyC1RvqVvnH2
	 ifg4scGA2y9CWR7mAwdvT/OQyLlLEl3YdJR/Guj3s+igv0uix2x2NYAVO0jeZmyPKl
	 L6j6qGuylIr31wKvq/oI+vpB/3J1ktwTLQS5fNTjRY6v0WyCodIKh6EnEWB2eV8irg
	 aEUMT332EEFtA==
From: Arnd Bergmann <arnd@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Andreas Schwab <schwab@suse.de>,
	Florian Weimer <fweimer@redhat.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-api@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	WANG Xuerui <kernel@xen0n.name>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH] syscalls: fix syscall macros for newfstat/newfstatat
Date: Thu,  1 Aug 2024 14:32:33 +0200
Message-Id: <20240801123305.2392874-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The __NR_newfstat and __NR_newfstatat macros accidentally got renamed
in the conversion to the syscall.tbl format, dropping the 'new' portion
of the name.

In an unrelated change, the two syscalls are no longer architecture
specific but are once more defined on all 64-bit architectures, so the
'newstat' ABI keyword can be dropped from the table as a simplification.

Fixes: Fixes: 4fe53bf2ba0a ("syscalls: add generic scripts/syscall.tbl")
Closes: https://lore.kernel.org/lkml/838053e0-b186-4e9f-9668-9a3384a71f23@app.fastmail.com/T/#t
Reported-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/Makefile.syscalls     | 2 +-
 arch/loongarch/kernel/Makefile.syscalls | 3 ++-
 arch/riscv/kernel/Makefile.syscalls     | 2 +-
 scripts/syscall.tbl                     | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/Makefile.syscalls b/arch/arm64/kernel/Makefile.syscalls
index 3cfafd003b2d..0542a718871a 100644
--- a/arch/arm64/kernel/Makefile.syscalls
+++ b/arch/arm64/kernel/Makefile.syscalls
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 syscall_abis_32 +=
-syscall_abis_64 += renameat newstat rlimit memfd_secret
+syscall_abis_64 += renameat rlimit memfd_secret
 
 syscalltbl = arch/arm64/tools/syscall_%.tbl
diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/kernel/Makefile.syscalls
index 523bb411a3bc..ab7d9baa2915 100644
--- a/arch/loongarch/kernel/Makefile.syscalls
+++ b/arch/loongarch/kernel/Makefile.syscalls
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_64 += newstat
+# No special ABIs on loongarch so far
+syscall_abis_64 +=
diff --git a/arch/riscv/kernel/Makefile.syscalls b/arch/riscv/kernel/Makefile.syscalls
index 52087a023b3d..9668fd1faf60 100644
--- a/arch/riscv/kernel/Makefile.syscalls
+++ b/arch/riscv/kernel/Makefile.syscalls
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 syscall_abis_32 += riscv memfd_secret
-syscall_abis_64 += riscv newstat rlimit memfd_secret
+syscall_abis_64 += riscv rlimit memfd_secret
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 797e20ea99a2..4586a18dfe9b 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -98,9 +98,9 @@
 77	common	tee				sys_tee
 78	common	readlinkat			sys_readlinkat
 79	stat64	fstatat64			sys_fstatat64
-79	newstat	fstatat				sys_newfstatat
+79	64	newfstatat			sys_newfstatat
 80	stat64	fstat64				sys_fstat64
-80	newstat	fstat				sys_newfstat
+80	64	newfstat			sys_newfstat
 81	common	sync				sys_sync
 82	common	fsync				sys_fsync
 83	common	fdatasync			sys_fdatasync
-- 
2.39.2


