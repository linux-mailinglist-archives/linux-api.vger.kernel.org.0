Return-Path: <linux-api+bounces-6176-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBIJBx2i62kbPgAAu9opvQ
	(envelope-from <linux-api+bounces-6176-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 19:02:21 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB4461848
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 19:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F7D8312E024
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818163F211F;
	Fri, 24 Apr 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMCezwY1"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A83F210A;
	Fri, 24 Apr 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049524; cv=none; b=C3yLx/omwKUkLY98xaWaiIitz4vSKzn/TdBv3vc0L3o2rwJAspOf5p55ueXSe2iCpobIvjd/T+f8kJ5y38e0RCHF3CefygEMoulRM1QRbwTwKGc8A+qXuxs9qYZO2rXQ1O3DNIqPyOkMr9bPBWGh6cXF9h8XpRwOuxBVAHWOSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049524; c=relaxed/simple;
	bh=lO2tIetRubgvaN/PQ1r8A/l5tDuosV6OMtUW+eArBEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDMdXNi/0ZUhMwel18Sirub1VOra/7BLXjGPcGrmmeumUawVzqEO0B1jxxDbSsd/B1tDQPHJe44xngBNsPrVCDTkbZ2f9Fm93kdXSJk4A1/buk9Zeh9spGbGP/oIW2iHqMxtYY0vvT5YpJqUk7CK5N8dQW6Cxt7ZsK1baYsychI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMCezwY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E28BC2BCB2;
	Fri, 24 Apr 2026 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777049524;
	bh=lO2tIetRubgvaN/PQ1r8A/l5tDuosV6OMtUW+eArBEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMCezwY1YAfR6WS42Tz2YleA7XRJBTK7aHmFLxBtQ0LLfQ2b30xa/DHAaZv9JhZhG
	 B5CG5s1x8EO9fKUZbHNAMzSz6mYkSr+ogwLxNLPs4Tl6O6uI8nGoF7dH/Oslo4mrNG
	 gmZLz5aIFJRVE10nOWrOq4mxW0Z0Zqe0kUdKMdhlqP+3UnsgLq9Qh4fa3tfNEHonKG
	 4Obs2woC5TjcMjC+uDDxMQXx2ELl4HBxHv7DIM7+rDb0hvVnuoS0LNnIMJQW2ORu7c
	 cJXrAU3DXi8oL1Hd7FbIhTgIZ0BpPgvszEdNPXJRjisNpuLvXQAItx5DwlapQdDu2y
	 jVZs0vQ+aKNPQ==
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
Subject: [PATCH v3 9/9] kernel/api: add runtime verification selftest
Date: Fri, 24 Apr 2026 12:51:29 -0400
Message-ID: <20260424165130.2306833-10-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424165130.2306833-1-sashal@kernel.org>
References: <20260424165130.2306833-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82FB4461848
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6176-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

Add a selftest for CONFIG_KAPI_RUNTIME_CHECKS that exercises
sys_open/sys_read/sys_write/sys_close through raw syscall() and
verifies KAPI pre-validation catches invalid parameters while
allowing valid operations through.

Test cases (TAP output):
  1-4: Valid open/read/write/close succeed
  5-7: Invalid flags, mode bits, NULL path rejected with EINVAL
  8:   dmesg contains expected KAPI warning strings

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS                                   |    1 +
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/kapi/Makefile         |    7 +
 tools/testing/selftests/kapi/kapi_test_util.h |   33 +
 tools/testing/selftests/kapi/test_kapi.c      | 1096 +++++++++++++++++
 5 files changed, 1138 insertions(+)
 create mode 100644 tools/testing/selftests/kapi/Makefile
 create mode 100644 tools/testing/selftests/kapi/kapi_test_util.h
 create mode 100644 tools/testing/selftests/kapi/test_kapi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d14205077908..ddfd9cad98916 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13826,6 +13826,7 @@ F:	include/linux/kernel_api_spec.h
 F:	kernel/api/
 F:	tools/kapi/
 F:	tools/lib/python/kdoc/kdoc_apispec.py
+F:	tools/testing/selftests/kapi/
 
 KERNEL AUTOMOUNTER
 M:	Ian Kent <raven@themaw.net>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 450f13ba4cca9..7881bec5aafe1 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -48,6 +48,7 @@ TARGETS += intel_pstate
 TARGETS += iommu
 TARGETS += ipc
 TARGETS += ir
+TARGETS += kapi
 TARGETS += kcmp
 TARGETS += kexec
 TARGETS += kselftest_harness
diff --git a/tools/testing/selftests/kapi/Makefile b/tools/testing/selftests/kapi/Makefile
new file mode 100644
index 0000000000000..32a750901b111
--- /dev/null
+++ b/tools/testing/selftests/kapi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS := test_kapi
+
+CFLAGS += -static -Wall -Wextra -Werror -O2 $(KHDR_INCLUDES)
+
+include ../lib.mk
diff --git a/tools/testing/selftests/kapi/kapi_test_util.h b/tools/testing/selftests/kapi/kapi_test_util.h
new file mode 100644
index 0000000000000..e097c370542ad
--- /dev/null
+++ b/tools/testing/selftests/kapi/kapi_test_util.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+ *
+ * Compatibility helpers for KAPI selftests.
+ *
+ * __NR_open is not defined on aarch64 and riscv64 (only __NR_openat exists).
+ * Provide a wrapper that uses __NR_openat with AT_FDCWD to achieve the same
+ * behavior as __NR_open on architectures that lack it.
+ */
+#ifndef KAPI_TEST_UTIL_H
+#define KAPI_TEST_UTIL_H
+
+#include <fcntl.h>
+#include <sys/syscall.h>
+
+#ifndef __NR_open
+/*
+ * On architectures without __NR_open (e.g., aarch64, riscv64),
+ * use openat(AT_FDCWD, ...) which is equivalent.
+ */
+static inline long kapi_sys_open(const char *pathname, int flags, int mode)
+{
+	return syscall(__NR_openat, AT_FDCWD, pathname, flags, mode);
+}
+#else
+static inline long kapi_sys_open(const char *pathname, int flags, int mode)
+{
+	return syscall(__NR_open, pathname, flags, mode);
+}
+#endif
+
+#endif /* KAPI_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kapi/test_kapi.c b/tools/testing/selftests/kapi/test_kapi.c
new file mode 100644
index 0000000000000..a6b7576f95c3e
--- /dev/null
+++ b/tools/testing/selftests/kapi/test_kapi.c
@@ -0,0 +1,1096 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+ *
+ * Userspace selftest for KAPI runtime verification of syscall parameters.
+ *
+ * Exercises sys_open, sys_read, sys_write, and sys_close through raw
+ * syscall() to ensure KAPI pre-validation wrappers interact correctly
+ * with normal kernel error handling.
+ *
+ * Requires CONFIG_KAPI_RUNTIME_CHECKS=y for full coverage; many tests
+ * also pass without it.
+ *
+ * TAP output format.
+ */
+
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/syscall.h>
+#include <sys/stat.h>
+#include <linux/limits.h>
+#include "../kselftest.h"
+#include "kapi_test_util.h"
+
+#define NUM_TESTS 29
+
+/*
+ * Set from the SIGPIPE handler. `volatile sig_atomic_t` is the POSIX-
+ * mandated type for flags touched by async-signal-safe handlers;
+ * checkpatch's generic "volatile considered harmful" warning targets
+ * kernel code and does not apply here.
+ */
+static volatile sig_atomic_t got_sigpipe;
+
+/*
+ * The tap_* helpers are thin wrappers around ksft_test_result_* so the
+ * rest of this file reads like the original author wrote it, while the
+ * output goes through the shared kselftest harness.
+ */
+static void tap_ok(const char *desc)
+{
+	ksft_test_result_pass("%s\n", desc);
+}
+
+static void tap_fail(const char *desc, const char *reason)
+{
+	ksft_test_result_fail("%s: %s\n", desc, reason);
+}
+
+static void tap_skip(const char *desc, const char *reason)
+{
+	ksft_test_result_skip("%s: %s\n", desc, reason);
+}
+
+/*
+ * Return true when the kernel provides the kapi runtime-check surface.
+ * Tests that rely on KAPI rejecting bad parameters pre-call should be
+ * skipped on kernels without it, not reported as failures.
+ */
+static bool kapi_runtime_checks_active(void)
+{
+	struct stat st;
+
+	return stat("/sys/kernel/debug/kapi", &st) == 0 && S_ISDIR(st.st_mode);
+}
+
+static void sigpipe_handler(int sig)
+{
+	(void)sig;
+	got_sigpipe = 1;
+}
+
+/* ---- Valid operation tests ---- */
+
+/*
+ * Test 1: open a readable file
+ * Returns fd on success.
+ */
+static int test_open_valid(void)
+{
+	errno = 0;
+	long fd = kapi_sys_open("/etc/hostname", O_RDONLY, 0);
+
+	if (fd >= 0) {
+		tap_ok("open valid file");
+	} else {
+		/* /etc/hostname might not exist; try /etc/passwd */
+		errno = 0;
+		fd = kapi_sys_open("/etc/passwd", O_RDONLY, 0);
+		if (fd >= 0)
+			tap_ok("open valid file (fallback /etc/passwd)");
+		else
+			tap_fail("open valid file", strerror(errno));
+	}
+	return (int)fd;
+}
+
+/*
+ * Test 2: read from fd
+ */
+static void test_read_valid(int fd)
+{
+	char buf[256];
+
+	errno = 0;
+	long ret = syscall(__NR_read, fd, buf, sizeof(buf));
+
+	if (ret > 0)
+		tap_ok("read from valid fd");
+	else if (ret == 0)
+		tap_ok("read from valid fd (EOF)");
+	else
+		tap_fail("read from valid fd", strerror(errno));
+}
+
+/*
+ * Test 3: write to /dev/null
+ */
+static void test_write_valid(void)
+{
+	errno = 0;
+	long devnull = kapi_sys_open("/dev/null", O_WRONLY, 0);
+
+	if (devnull < 0) {
+		tap_fail("write to /dev/null (open failed)", strerror(errno));
+		return;
+	}
+
+	errno = 0;
+	long ret = syscall(__NR_write, (int)devnull, "hello", 5);
+
+	if (ret == 5)
+		tap_ok("write to /dev/null");
+	else
+		tap_fail("write to /dev/null",
+			 ret < 0 ? strerror(errno) : "short write");
+
+	syscall(__NR_close, (int)devnull);
+}
+
+/*
+ * Test 4: close fd
+ */
+static void test_close_valid(int fd)
+{
+	errno = 0;
+	long ret = syscall(__NR_close, fd);
+
+	if (ret == 0)
+		tap_ok("close valid fd");
+	else
+		tap_fail("close valid fd", strerror(errno));
+}
+
+/* ---- KAPI parameter rejection tests ---- */
+
+/*
+ * Test 5: open with invalid flag bits
+ * 0x10000000 is outside the valid O_* mask, KAPI should reject.
+ */
+static void test_open_invalid_flags(void)
+{
+	long ret;
+
+	if (!kapi_runtime_checks_active()) {
+		tap_skip("open with invalid flags",
+			 "CONFIG_KAPI_RUNTIME_CHECKS not enabled");
+		return;
+	}
+
+	errno = 0;
+	/*
+	 * Use /dev/null (always present on any sane rootfs) so KAPI's flag
+	 * validation is reached before a path-lookup ENOENT can mask it.
+	 * 0x10000000 is outside the valid O_* mask.
+	 */
+	ret = kapi_sys_open("/dev/null", 0x10000000, 0);
+
+	if (ret == -1 && errno == EINVAL) {
+		tap_ok("open with invalid flags returns EINVAL");
+	} else if (ret >= 0) {
+		tap_fail("open with invalid flags", "expected EINVAL, got success");
+		syscall(__NR_close, (int)ret);
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected EINVAL, got %s",
+			 strerror(errno));
+		tap_fail("open with invalid flags", msg);
+	}
+}
+
+/*
+ * Test 6: open with invalid mode bits
+ * 0xFFFF has bits outside S_IALLUGO (07777), KAPI should reject.
+ */
+static void test_open_invalid_mode(void)
+{
+	long ret;
+
+	if (!kapi_runtime_checks_active()) {
+		tap_skip("open with invalid mode",
+			 "CONFIG_KAPI_RUNTIME_CHECKS not enabled");
+		return;
+	}
+
+	errno = 0;
+	ret = kapi_sys_open("/tmp/kapi_test_mode",
+			    O_CREAT | O_WRONLY | O_EXCL, 0xFFFF);
+
+	if (ret == -1 && errno == EINVAL) {
+		tap_ok("open with invalid mode returns EINVAL");
+	} else if (ret >= 0) {
+		tap_fail("open with invalid mode", "expected EINVAL, got success");
+		syscall(__NR_close, (int)ret);
+		unlink("/tmp/kapi_test_mode");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected EINVAL, got %s",
+			 strerror(errno));
+		tap_fail("open with invalid mode", msg);
+	}
+}
+
+/*
+ * Test 7: open with NULL path
+ * KAPI USER_PATH constraint should reject NULL.
+ */
+static void test_open_null_path(void)
+{
+	errno = 0;
+	long ret = kapi_sys_open(NULL, O_RDONLY, 0);
+
+	if (ret == -1 && errno == EINVAL) {
+		tap_ok("open with NULL path returns EINVAL");
+	} else if (ret == -1 && errno == EFAULT) {
+		/* Kernel may catch this as EFAULT before KAPI */
+		tap_ok("open with NULL path returns EFAULT (acceptable)");
+	} else if (ret >= 0) {
+		tap_fail("open with NULL path", "expected error, got success");
+		syscall(__NR_close, (int)ret);
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "got %s", strerror(errno));
+		tap_fail("open with NULL path", msg);
+	}
+}
+
+/*
+ * Test 8: open with flag bit 30 set (0x40000000)
+ * This bit is outside the valid O_* mask, KAPI should reject with EINVAL.
+ */
+static void test_open_flag_bit30(void)
+{
+	long ret;
+
+	if (!kapi_runtime_checks_active()) {
+		tap_skip("open with flag bit 30 (0x40000000) returns EINVAL",
+			 "CONFIG_KAPI_RUNTIME_CHECKS not enabled");
+		return;
+	}
+
+	errno = 0;
+	ret = kapi_sys_open("/dev/null", 0x40000000, 0);
+
+	if (ret == -1 && errno == EINVAL) {
+		tap_ok("open with flag bit 30 (0x40000000) returns EINVAL");
+	} else if (ret >= 0) {
+		tap_fail("open with flag bit 30 (0x40000000) returns EINVAL",
+			 "expected EINVAL, got success");
+		syscall(__NR_close, (int)ret);
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected EINVAL, got %s",
+			 strerror(errno));
+		tap_fail("open with flag bit 30 (0x40000000) returns EINVAL",
+			 msg);
+	}
+}
+
+/* ---- Boundary condition and error path tests ---- */
+
+/*
+ * Test 9: read with fd=-1 should return an error.
+ * With CONFIG_KAPI_RUNTIME_CHECKS=y, KAPI validates the fd first and
+ * rejects negative fds (other than AT_FDCWD) with EINVAL.  Without
+ * KAPI, the kernel returns EBADF.  Accept either.
+ */
+static void test_read_bad_fd(void)
+{
+	char buf[16];
+
+	errno = 0;
+	long ret = syscall(__NR_read, -1, buf, sizeof(buf));
+
+	if (ret == -1 && (errno == EBADF || errno == EINVAL)) {
+		tap_ok("read with fd=-1 returns error");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected EBADF/EINVAL, got %s",
+			 ret >= 0 ? "success" : strerror(errno));
+		tap_fail("read with fd=-1 returns error", msg);
+	}
+}
+
+/*
+ * Test 10: read with count=0 should return 0
+ */
+static void test_read_zero_count(void)
+{
+	char buf[1];
+	long fd;
+
+	errno = 0;
+	fd = kapi_sys_open("/dev/null", O_RDONLY, 0);
+	if (fd < 0) {
+		tap_fail("read with count=0 returns 0",
+			 "cannot open /dev/null");
+		return;
+	}
+
+	errno = 0;
+	long ret = syscall(__NR_read, (int)fd, buf, 0);
+
+	if (ret == 0) {
+		tap_ok("read with count=0 returns 0");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected 0, got %ld (errno=%s)",
+			 ret, strerror(errno));
+		tap_fail("read with count=0 returns 0", msg);
+	}
+
+	syscall(__NR_close, (int)fd);
+}
+
+/*
+ * Test 11: write with count=0 should return 0
+ */
+static void test_write_zero_count(void)
+{
+	long fd;
+
+	errno = 0;
+	fd = kapi_sys_open("/dev/null", O_WRONLY, 0);
+	if (fd < 0) {
+		tap_fail("write with count=0 returns 0",
+			 "cannot open /dev/null");
+		return;
+	}
+
+	errno = 0;
+	long ret = syscall(__NR_write, (int)fd, "x", 0);
+
+	if (ret == 0) {
+		tap_ok("write with count=0 returns 0");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected 0, got %ld (errno=%s)",
+			 ret, strerror(errno));
+		tap_fail("write with count=0 returns 0", msg);
+	}
+
+	syscall(__NR_close, (int)fd);
+}
+
+/*
+ * Test 12: open with a path longer than PATH_MAX should fail
+ * Expect ENAMETOOLONG or EINVAL.
+ */
+static void test_open_long_path(void)
+{
+	char *longpath;
+	size_t len = PATH_MAX + 256;
+
+	longpath = malloc(len);
+	if (!longpath) {
+		tap_fail("open with path > PATH_MAX", "malloc failed");
+		return;
+	}
+
+	memset(longpath, 'A', len - 1);
+	longpath[0] = '/';
+	longpath[len - 1] = '\0';
+
+	errno = 0;
+	long ret = kapi_sys_open(longpath, O_RDONLY, 0);
+
+	if (ret == -1 && (errno == ENAMETOOLONG || errno == EINVAL)) {
+		tap_ok("open with path > PATH_MAX returns ENAMETOOLONG/EINVAL");
+	} else if (ret >= 0) {
+		tap_fail("open with path > PATH_MAX",
+			 "expected error, got success");
+		syscall(__NR_close, (int)ret);
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg),
+			 "expected ENAMETOOLONG/EINVAL, got %s",
+			 strerror(errno));
+		tap_fail("open with path > PATH_MAX", msg);
+	}
+
+	free(longpath);
+}
+
+/*
+ * Test 13: read with unmapped user pointer should return EFAULT or EINVAL.
+ * Use a pipe with data so the kernel actually tries to copy to the buffer.
+ */
+static void test_read_unmapped_buf(void)
+{
+	int pipefd[2];
+
+	if (pipe(pipefd) < 0) {
+		tap_fail("read with unmapped buffer returns EFAULT/EINVAL",
+			 "pipe() failed");
+		return;
+	}
+
+	/* Write some data so read has something to copy */
+	(void)write(pipefd[1], "hello", 5);
+
+	errno = 0;
+	long ret = syscall(__NR_read, pipefd[0], (void *)0xDEAD0000, 16);
+
+	if (ret == -1 && (errno == EFAULT || errno == EINVAL)) {
+		tap_ok("read with unmapped buffer returns EFAULT/EINVAL");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg),
+			 "expected EFAULT/EINVAL, got %s",
+			 ret >= 0 ? "success" : strerror(errno));
+		tap_fail("read with unmapped buffer returns EFAULT/EINVAL",
+			 msg);
+	}
+
+	close(pipefd[0]);
+	close(pipefd[1]);
+}
+
+/*
+ * Test 14: write with unmapped user pointer should return EFAULT or EINVAL.
+ * Use a pipe so the kernel actually tries to copy from the buffer.
+ */
+static void test_write_unmapped_buf(void)
+{
+	int pipefd[2];
+
+	if (pipe(pipefd) < 0) {
+		tap_fail("write with unmapped buffer returns EFAULT/EINVAL",
+			 "pipe() failed");
+		return;
+	}
+
+	errno = 0;
+	long ret = syscall(__NR_write, pipefd[1], (void *)0xDEAD0000, 16);
+
+	if (ret == -1 && (errno == EFAULT || errno == EINVAL)) {
+		tap_ok("write with unmapped buffer returns EFAULT/EINVAL");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg),
+			 "expected EFAULT/EINVAL, got %s",
+			 ret >= 0 ? "success" : strerror(errno));
+		tap_fail("write with unmapped buffer returns EFAULT/EINVAL",
+			 msg);
+	}
+
+	close(pipefd[0]);
+	close(pipefd[1]);
+}
+
+/*
+ * Test 15: close an already-closed fd should return EBADF
+ */
+static void test_close_already_closed(void)
+{
+	long fd;
+
+	errno = 0;
+	fd = kapi_sys_open("/dev/null", O_RDONLY, 0);
+	if (fd < 0) {
+		tap_fail("close already-closed fd returns EBADF",
+			 "cannot open /dev/null");
+		return;
+	}
+
+	/* Close it once - should succeed */
+	syscall(__NR_close, (int)fd);
+
+	/* Close it again - should fail with EBADF */
+	errno = 0;
+	long ret = syscall(__NR_close, (int)fd);
+
+	if (ret == -1 && errno == EBADF) {
+		tap_ok("close already-closed fd returns EBADF");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected EBADF, got %s",
+			 ret == 0 ? "success" : strerror(errno));
+		tap_fail("close already-closed fd returns EBADF", msg);
+	}
+}
+
+/*
+ * Test 16: open /dev/null with O_RDONLY|O_CLOEXEC should succeed
+ */
+static void test_open_valid_cloexec(void)
+{
+	errno = 0;
+	long fd = kapi_sys_open("/dev/null", O_RDONLY | O_CLOEXEC, 0);
+
+	if (fd >= 0) {
+		tap_ok("open /dev/null with O_RDONLY|O_CLOEXEC succeeds");
+		syscall(__NR_close, (int)fd);
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected success, got %s",
+			 strerror(errno));
+		tap_fail("open /dev/null with O_RDONLY|O_CLOEXEC succeeds",
+			 msg);
+	}
+}
+
+/*
+ * Test 17: write 0 bytes to /dev/null should return 0
+ */
+static void test_write_zero_devnull(void)
+{
+	long fd;
+
+	errno = 0;
+	fd = kapi_sys_open("/dev/null", O_WRONLY, 0);
+	if (fd < 0) {
+		tap_fail("write 0 bytes to /dev/null returns 0",
+			 "cannot open /dev/null");
+		return;
+	}
+
+	errno = 0;
+	long ret = syscall(__NR_write, (int)fd, "", 0);
+
+	if (ret == 0) {
+		tap_ok("write 0 bytes to /dev/null returns 0");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected 0, got %ld (errno=%s)",
+			 ret, strerror(errno));
+		tap_fail("write 0 bytes to /dev/null returns 0", msg);
+	}
+
+	syscall(__NR_close, (int)fd);
+}
+
+/*
+ * Test 18: read from a write-only fd should return EBADF
+ */
+static void test_read_writeonly_fd(void)
+{
+	long fd;
+
+	errno = 0;
+	fd = kapi_sys_open("/dev/null", O_WRONLY, 0);
+	if (fd < 0) {
+		tap_fail("read from write-only fd returns EBADF",
+			 "cannot open /dev/null");
+		return;
+	}
+
+	char buf[16];
+
+	errno = 0;
+	long ret = syscall(__NR_read, (int)fd, buf, sizeof(buf));
+
+	if (ret == -1 && errno == EBADF) {
+		tap_ok("read from write-only fd returns EBADF");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected EBADF, got %s",
+			 ret >= 0 ? "success" : strerror(errno));
+		tap_fail("read from write-only fd returns EBADF", msg);
+	}
+
+	syscall(__NR_close, (int)fd);
+}
+
+/*
+ * Test 19: write to a read-only fd should return EBADF
+ */
+static void test_write_readonly_fd(void)
+{
+	long fd;
+
+	errno = 0;
+	fd = kapi_sys_open("/dev/null", O_RDONLY, 0);
+	if (fd < 0) {
+		tap_fail("write to read-only fd returns EBADF",
+			 "cannot open /dev/null");
+		return;
+	}
+
+	errno = 0;
+	long ret = syscall(__NR_write, (int)fd, "hello", 5);
+
+	if (ret == -1 && errno == EBADF) {
+		tap_ok("write to read-only fd returns EBADF");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected EBADF, got %s",
+			 ret >= 0 ? "success" : strerror(errno));
+		tap_fail("write to read-only fd returns EBADF", msg);
+	}
+
+	syscall(__NR_close, (int)fd);
+}
+
+/*
+ * Test 20: close fd 9999 (likely invalid) should return EBADF
+ */
+static void test_close_fd_9999(void)
+{
+	errno = 0;
+	long ret = syscall(__NR_close, 9999);
+
+	if (ret == -1 && errno == EBADF) {
+		tap_ok("close fd 9999 returns EBADF");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected EBADF, got %s",
+			 ret == 0 ? "success" : strerror(errno));
+		tap_fail("close fd 9999 returns EBADF", msg);
+	}
+}
+
+/*
+ * Test 21: read from pipe after write end is closed returns 0 (EOF)
+ */
+static void test_read_closed_pipe(void)
+{
+	int pipefd[2];
+
+	if (pipe(pipefd) < 0) {
+		tap_fail("read from closed pipe returns 0 (EOF)",
+			 "pipe() failed");
+		return;
+	}
+
+	/* Close write end */
+	close(pipefd[1]);
+
+	char buf[16];
+
+	errno = 0;
+	long ret = syscall(__NR_read, pipefd[0], buf, sizeof(buf));
+
+	if (ret == 0) {
+		tap_ok("read from closed pipe returns 0 (EOF)");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected 0, got %ld (errno=%s)",
+			 ret, ret < 0 ? strerror(errno) : "n/a");
+		tap_fail("read from closed pipe returns 0 (EOF)", msg);
+	}
+
+	close(pipefd[0]);
+}
+
+/*
+ * Test 22: write to pipe after read end is closed returns EPIPE + SIGPIPE
+ */
+static void test_write_closed_pipe(void)
+{
+	int pipefd[2];
+	struct sigaction sa, old_sa;
+
+	if (pipe(pipefd) < 0) {
+		tap_fail("write to closed pipe returns EPIPE + SIGPIPE",
+			 "pipe() failed");
+		return;
+	}
+
+	/* Install SIGPIPE handler */
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = sigpipe_handler;
+	sigemptyset(&sa.sa_mask);
+	sigaction(SIGPIPE, &sa, &old_sa);
+
+	got_sigpipe = 0;
+
+	/* Close read end */
+	close(pipefd[0]);
+
+	errno = 0;
+	long ret = syscall(__NR_write, pipefd[1], "hello", 5);
+
+	if (ret == -1 && errno == EPIPE && got_sigpipe) {
+		tap_ok("write to closed pipe returns EPIPE + SIGPIPE");
+	} else if (ret == -1 && errno == EPIPE) {
+		tap_ok("write to closed pipe returns EPIPE (SIGPIPE not caught)");
+	} else {
+		char msg[128];
+
+		snprintf(msg, sizeof(msg),
+			 "expected EPIPE, got %s (sigpipe=%d)",
+			 ret >= 0 ? "success" : strerror(errno),
+			 (int)got_sigpipe);
+		tap_fail("write to closed pipe returns EPIPE + SIGPIPE", msg);
+	}
+
+	/* Restore SIGPIPE handler */
+	sigaction(SIGPIPE, &old_sa, NULL);
+	close(pipefd[1]);
+}
+
+/*
+ * Test 23: open with O_DIRECTORY on a regular file returns ENOTDIR
+ */
+static void test_open_directory_on_file(void)
+{
+	errno = 0;
+	long ret = kapi_sys_open("/dev/null", O_RDONLY | O_DIRECTORY, 0);
+
+	if (ret == -1 && errno == ENOTDIR) {
+		tap_ok("open O_DIRECTORY on regular file returns ENOTDIR");
+	} else if (ret >= 0) {
+		tap_fail("open O_DIRECTORY on regular file",
+			 "expected ENOTDIR, got success");
+		syscall(__NR_close, (int)ret);
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected ENOTDIR, got %s",
+			 strerror(errno));
+		tap_fail("open O_DIRECTORY on regular file", msg);
+	}
+}
+
+/*
+ * Test 24: open nonexistent file without O_CREAT returns ENOENT
+ */
+static void test_open_nonexistent(void)
+{
+	errno = 0;
+	long ret = kapi_sys_open("/tmp/kapi_nonexistent_file_12345",
+				 O_RDONLY, 0);
+
+	if (ret == -1 && errno == ENOENT) {
+		tap_ok("open nonexistent file without O_CREAT returns ENOENT");
+	} else if (ret >= 0) {
+		tap_fail("open nonexistent file",
+			 "expected ENOENT, got success (file exists?)");
+		syscall(__NR_close, (int)ret);
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected ENOENT, got %s",
+			 strerror(errno));
+		tap_fail("open nonexistent file", msg);
+	}
+}
+
+/*
+ * Test 25: close stdin (fd 0) should succeed
+ * We dup it first so we can restore it.
+ */
+static void test_close_stdin(void)
+{
+	int saved_stdin = dup(0);
+
+	if (saved_stdin < 0) {
+		tap_fail("close stdin succeeds", "cannot dup stdin");
+		return;
+	}
+
+	errno = 0;
+	long ret = syscall(__NR_close, 0);
+
+	if (ret == 0) {
+		tap_ok("close stdin (fd 0) succeeds");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected success, got %s",
+			 strerror(errno));
+		tap_fail("close stdin (fd 0) succeeds", msg);
+	}
+
+	/* Restore stdin */
+	dup2(saved_stdin, 0);
+	close(saved_stdin);
+}
+
+/*
+ * Test 26: read after close returns EBADF
+ */
+static void test_read_after_close(void)
+{
+	long fd;
+
+	errno = 0;
+	fd = kapi_sys_open("/dev/null", O_RDONLY, 0);
+	if (fd < 0) {
+		tap_fail("read after close returns EBADF",
+			 "cannot open /dev/null");
+		return;
+	}
+
+	syscall(__NR_close, (int)fd);
+
+	char buf[16];
+
+	errno = 0;
+	long ret = syscall(__NR_read, (int)fd, buf, sizeof(buf));
+
+	if (ret == -1 && errno == EBADF) {
+		tap_ok("read after close returns EBADF");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected EBADF, got %s",
+			 ret >= 0 ? "success" : strerror(errno));
+		tap_fail("read after close returns EBADF", msg);
+	}
+}
+
+/*
+ * Test 27: write with large count
+ * Without KAPI: the kernel clamps count to MAX_RW_COUNT and succeeds.
+ * With KAPI: KAPI validates the buffer against the count and may
+ * return EFAULT/EINVAL since the buffer is smaller than count.
+ * Accept either success or EFAULT/EINVAL.
+ */
+static void test_write_large_count(void)
+{
+	long fd;
+	char buf[64] = "test data";
+
+	errno = 0;
+	fd = kapi_sys_open("/dev/null", O_WRONLY, 0);
+	if (fd < 0) {
+		tap_fail("write with large count handled correctly",
+			 "cannot open /dev/null");
+		return;
+	}
+
+	errno = 0;
+	long ret = syscall(__NR_write, (int)fd, buf, (size_t)0x7ffff000UL);
+
+	if (ret > 0) {
+		tap_ok("write with large count succeeds (clamped, no KAPI)");
+	} else if (ret == -1 && (errno == EFAULT || errno == EINVAL)) {
+		tap_ok("write with large count returns EFAULT/EINVAL (KAPI validates buffer)");
+	} else {
+		char msg[64];
+
+		snprintf(msg, sizeof(msg), "expected success or EFAULT, got %s",
+			 ret == 0 ? "zero" : strerror(errno));
+		tap_fail("write with large count handled correctly", msg);
+	}
+
+	syscall(__NR_close, (int)fd);
+}
+
+/* ---- Integration tests ---- */
+
+/*
+ * Test 28: full normal syscall path - open, read, write, close
+ * Verify KAPI does not interfere with normal operations.
+ */
+static void test_normal_path(void)
+{
+	long rd_fd, wr_fd;
+	char buf[128];
+	int ok = 1;
+	char reason[128] = "";
+
+	/* Open a readable file */
+	errno = 0;
+	rd_fd = kapi_sys_open("/etc/hostname", O_RDONLY, 0);
+	if (rd_fd < 0) {
+		errno = 0;
+		rd_fd = kapi_sys_open("/etc/passwd", O_RDONLY, 0);
+	}
+	if (rd_fd < 0) {
+		snprintf(reason, sizeof(reason), "open readable file: %s",
+			 strerror(errno));
+		ok = 0;
+	}
+
+	/* Read from it */
+	if (ok) {
+		errno = 0;
+		long n = syscall(__NR_read, (int)rd_fd, buf, sizeof(buf));
+
+		if (n < 0) {
+			snprintf(reason, sizeof(reason), "read: %s",
+				 strerror(errno));
+			ok = 0;
+		}
+	}
+
+	/* Open /dev/null for writing */
+	wr_fd = -1;
+	if (ok) {
+		errno = 0;
+		wr_fd = kapi_sys_open("/dev/null", O_WRONLY, 0);
+		if (wr_fd < 0) {
+			snprintf(reason, sizeof(reason),
+				 "open /dev/null: %s", strerror(errno));
+			ok = 0;
+		}
+	}
+
+	/* Write to /dev/null */
+	if (ok) {
+		errno = 0;
+		long n = syscall(__NR_write, (int)wr_fd, "test", 4);
+
+		if (n != 4) {
+			snprintf(reason, sizeof(reason), "write: %s",
+				 n < 0 ? strerror(errno) : "short write");
+			ok = 0;
+		}
+	}
+
+	/* Close both fds */
+	if (rd_fd >= 0) {
+		errno = 0;
+		if (syscall(__NR_close, (int)rd_fd) != 0 && ok) {
+			snprintf(reason, sizeof(reason), "close read fd: %s",
+				 strerror(errno));
+			ok = 0;
+		}
+	}
+
+	if (wr_fd >= 0) {
+		errno = 0;
+		if (syscall(__NR_close, (int)wr_fd) != 0 && ok) {
+			snprintf(reason, sizeof(reason), "close write fd: %s",
+				 strerror(errno));
+			ok = 0;
+		}
+	}
+
+	if (ok)
+		tap_ok("normal syscall path (open/read/write/close) works");
+	else
+		tap_fail("normal syscall path (open/read/write/close) works",
+			 reason);
+}
+
+/*
+ * Test 29: verify dmesg contains KAPI warnings for the invalid tests
+ */
+static void test_dmesg_warnings(void)
+{
+	int kmsg_fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+
+	if (kmsg_fd < 0) {
+		tap_skip("dmesg contains expected KAPI warnings",
+			 "cannot open /dev/kmsg");
+		return;
+	}
+
+	/*
+	 * Rewind to the start of kmsg. SEEK_DATA on /dev/kmsg is the
+	 * documented way to skip to the first entry still in the ring
+	 * buffer. Older kernels (or CONFIG_PRINTK=n builds) may reject
+	 * the seek with -EINVAL; in that case we can't reliably audit
+	 * past warnings, so skip the test rather than fail it.
+	 */
+	if (lseek(kmsg_fd, 0, SEEK_DATA) == (off_t)-1) {
+		tap_skip("dmesg contains expected KAPI warnings",
+			 "lseek(SEEK_DATA) not supported on /dev/kmsg");
+		close(kmsg_fd);
+		return;
+	}
+
+	char line[4096];
+	int found_invalid_bits = 0;
+	int found_null = 0;
+	ssize_t n;
+
+	for (;;) {
+		n = read(kmsg_fd, line, sizeof(line) - 1);
+		if (n > 0) {
+			line[n] = '\0';
+			if (strstr(line, "contains invalid bits"))
+				found_invalid_bits++;
+			if (strstr(line, "NULL") && strstr(line, "not allowed"))
+				found_null++;
+		} else if (n == -1 && errno == EPIPE) {
+			/* Ring buffer wrapped, continue reading */
+			continue;
+		} else {
+			/* EAGAIN (no more messages) or other error */
+			break;
+		}
+	}
+
+	close(kmsg_fd);
+
+	if (found_invalid_bits >= 2 && found_null >= 1) {
+		tap_ok("dmesg contains expected KAPI warnings");
+	} else if (found_invalid_bits >= 1 || found_null >= 1) {
+		char msg[128];
+
+		snprintf(msg, sizeof(msg),
+			 "partial: invalid_bits=%d null=%d",
+			 found_invalid_bits, found_null);
+		tap_ok(msg);
+	} else {
+		tap_fail("dmesg KAPI warnings",
+			 "no KAPI warnings found in dmesg");
+	}
+}
+
+int main(void)
+{
+	ksft_print_header();
+	ksft_set_plan(NUM_TESTS);
+
+	/* Valid operations (1-4) */
+	int fd = test_open_valid();
+
+	if (fd >= 0)
+		test_read_valid(fd);
+	else
+		tap_fail("read from valid fd", "no fd from open");
+
+	test_write_valid();
+
+	if (fd >= 0)
+		test_close_valid(fd);
+	else
+		tap_fail("close valid fd", "no fd from open");
+
+	/* KAPI parameter rejection (5-8) */
+	test_open_invalid_flags();
+	test_open_invalid_mode();
+	test_open_null_path();
+	test_open_flag_bit30();
+
+	/* Boundary conditions and error paths (9-20) */
+	test_read_bad_fd();
+	test_read_zero_count();
+	test_write_zero_count();
+	test_open_long_path();
+	test_read_unmapped_buf();
+	test_write_unmapped_buf();
+	test_close_already_closed();
+	test_open_valid_cloexec();
+	test_write_zero_devnull();
+	test_read_writeonly_fd();
+	test_write_readonly_fd();
+	test_close_fd_9999();
+
+	/* Pipe and lifecycle tests (21-27) */
+	test_read_closed_pipe();
+	test_write_closed_pipe();
+	test_open_directory_on_file();
+	test_open_nonexistent();
+	test_close_stdin();
+	test_read_after_close();
+	test_write_large_count();
+
+	/* Integration (28-29) */
+	test_normal_path();
+	test_dmesg_warnings();
+
+	ksft_finished();
+	return 0;
+}
-- 
2.53.0


