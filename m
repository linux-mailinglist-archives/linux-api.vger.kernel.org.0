Return-Path: <linux-api+bounces-6084-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGIhGJyk22ldEgkAu9opvQ
	(envelope-from <linux-api+bounces-6084-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 12 Apr 2026 15:56:44 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A23E4176
	for <lists+linux-api@lfdr.de>; Sun, 12 Apr 2026 15:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D9C4300620F
	for <lists+linux-api@lfdr.de>; Sun, 12 Apr 2026 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B8230F540;
	Sun, 12 Apr 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="iPB7TpxD"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1D30EF68
	for <linux-api@vger.kernel.org>; Sun, 12 Apr 2026 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002171; cv=none; b=Vjd0Jv6D7AsebCy5sHOgac5v8brrk2WSMzOxF7CJromz/GaqCauQyJY/S2nNhSLKyEK3h7CNEwzwfTm85H3GodK6H7y/HG3qx9OjRtd+Qug1tkMncvZUfXgpS31YszIanfOpHCN7bq0ihNJMk8Sw6ileTeu1tQJfEK/vFfKc3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002171; c=relaxed/simple;
	bh=l637JqBP885E0vHJ0i8snxCumNNbzRwHwozNuNIKUn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6FrHs1t0C1G5UfWs/J/XeZpUGN+4xz8Lb7wFxaBxaLtsfquTSkmJip6/oHn2ElJJocomnyYBkKlCyiDI19nWmiTRBa+wrPr7N1032afB04f+bLZcRdZVbfsoJS7aQ1caaJe7zufr6LDoI9Y469Cq8GY3bmH/ou/+nqoPtku+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=iPB7TpxD; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 327ba1b9-3677-11f1-b185-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 327ba1b9-3677-11f1-b185-005056abad63;
	Sun, 12 Apr 2026 15:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=5gvFaaq6B7M0xCNBpS1nvaP3wWXLqpCrPac4g4LlB4k=;
	b=iPB7TpxDhDFtkgPPnD2XEWlqzX0qJHACvYbMaoQuqU8aNSMVCRD6P0F59sslm8IhKl/BvX0jR0leh
	 9YTdd9I5Ht8ChGu8SpSQ1GzdXGrgxORwHljAjB5ZkZbWZZuBxXN+AtWLtQmD1HHW2pvIYbfIvKgm4l
	 YkBl3ScJSHnyrZtnolKKzHt75n7Yg2GZ7oiypyzkoGK8tUhI5Yoo0ETxQd0p/HN4LtlBQm2DliumLz
	 yI8PcOWbQEqF5Wf8inK0bz4Tt5KnKIcX1j/vbiEsfUjkXblJOu0vA7/iOg3Ced8roYA7+4P6JG+2cg
	 uKZdzrcS2BjKXchC0f0s0F//Um4DdZQ==
X-KPN-MID: 33|dYE8HLHPTgvqykGVvdAKeg5uO9EyrKxQ/H3dddIYqJv7RBNoINcf5QfWuW6V5DJ
 MJanI0EXnnALDE0pSgHyrV9bMmcXJXGpCbYHvGVBmDfQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|8AcZBqmKEp7Eizv1oLy8R1DxIkPqGUjGebq+ov2JfG4NcCWjgVjShv8CxJFvAN7
 4evOnfLa3up9+sUuxS8iLog==
Received: from daedalus.home (unknown [178.230.185.145])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 320dac09-3677-11f1-8011-005056ab7447;
	Sun, 12 Apr 2026 15:55:00 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jeff Layton <jlayton@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	cmirabil@redhat.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [RFC PATCH v2 2/2] selftest: add tests for mkdirat2()
Date: Sun, 12 Apr 2026 15:54:34 +0200
Message-ID: <20260412135434.3095416-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	FREEMAIL_CC(0.00)[zytor.com,suse.cz,infradead.org,redhat.com,kernel.org,xs4all.nl,linutronix.de,efficios.com,cyphar.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6084-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid]
X-Rspamd-Queue-Id: 678A23E4176
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add some tests for the new mkdirat2() syscall to test compliance and
to showcase its behaviour.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 tools/include/uapi/asm-generic/unistd.h       |   5 +-
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 .../selftests/filesystems/mkdirat_fd_test.c   | 143 ++++++++++++++++++
 4 files changed, 150 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/mkdirat_fd_test.c

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index a627acc8fb5f..6efc21779b62 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -863,8 +863,11 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
+#define __NR_mkdirat2 472
+__SYSCALL(__NR_mkdirat2, sys_mkdirat2)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 473
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 64ac0dfa46b7..84e2175d171f 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -5,3 +5,4 @@ fclog
 file_stressor
 anon_inode_test
 kernfs_test
+mkdirat_fd_test
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 85427d7f19b9..7357769db57a 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
+CFLAGS += $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog mkdirat_fd_test
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/mkdirat_fd_test.c b/tools/testing/selftests/filesystems/mkdirat_fd_test.c
new file mode 100644
index 000000000000..a02c0223d63b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mkdirat_fd_test.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/stat.h>
+
+#include <asm-generic/unistd.h>
+
+#include "kselftest_harness.h"
+
+#ifndef VALID_MKDIRAT2_FLAGS
+#define VALID_MKDIRAT2_FLAGS (AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT)
+#endif
+
+#define mkdirat2_checked_flags(dfd, pathname, flags) ({		\
+	struct stat __st;					\
+	int __fd = sys_mkdirat2(dfd, pathname, S_IRWXU, flags);	\
+	ASSERT_GE(__fd, 0);					\
+	EXPECT_EQ(fstat(__fd, &__st), 0);			\
+	EXPECT_TRUE(S_ISDIR(__st.st_mode));			\
+	__fd;							\
+})
+
+#define mkdirat2_checked(dfd, pathname) \
+	mkdirat2_checked_flags(dfd, pathname, 0)
+
+
+static inline int sys_mkdirat2(int dfd, const char *pathname, mode_t mode,
+				 unsigned int flags)
+{
+	return syscall(__NR_mkdirat2, dfd, pathname, mode, flags);
+}
+
+FIXTURE(mkdirat2) {
+	char dirpath[PATH_MAX];
+	int dfd;
+};
+
+FIXTURE_SETUP(mkdirat2)
+{
+	snprintf(self->dirpath, sizeof(self->dirpath),
+		 "/tmp/mkdirat2_test.%d", getpid());
+	ASSERT_EQ(mkdir(self->dirpath, S_IRWXU), 0);
+
+	self->dfd = open(self->dirpath, O_DIRECTORY);
+	ASSERT_GE(self->dfd, 0);
+}
+
+FIXTURE_TEARDOWN(mkdirat2)
+{
+	close(self->dfd);
+	rmdir(self->dirpath);
+}
+
+/* Does mkdirat2 return a fd at all */
+TEST_F(mkdirat2, returns_fd)
+{
+	int fd = mkdirat2_checked(self->dfd, "newdir");
+	EXPECT_EQ(close(fd), 0)
+	EXPECT_EQ(unlinkat(self->dfd, "newdir", AT_REMOVEDIR), 0);
+}
+
+/* The fd must refer to the directory that was just created. */
+TEST_F(mkdirat2, fd_is_created_dir)
+{
+	int fd;
+	struct stat st_via_fd, st_via_path;
+	char path[PATH_MAX];
+
+	fd = mkdirat2_checked(self->dfd, "checkdir");
+
+	ASSERT_EQ(fstat(fd, &st_via_fd), 0);
+
+	snprintf(path, sizeof(path), "%s/checkdir", self->dirpath);
+	ASSERT_EQ(stat(path, &st_via_path), 0);
+
+	EXPECT_EQ(st_via_fd.st_ino, st_via_path.st_ino);
+	EXPECT_EQ(st_via_fd.st_dev, st_via_path.st_dev);
+
+	EXPECT_EQ(close(fd), 0)
+	EXPECT_EQ(rmdir(path), 0);
+}
+
+
+/* Missing parent component must fail with ENOENT. */
+TEST_F(mkdirat2, enoent_missing_parent)
+{
+	EXPECT_EQ(sys_mkdirat2(self->dfd, "nonexistent/child", S_IRWXU, 0), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+/* An invalid dfd must fail with EBADF. */
+TEST_F(mkdirat2, ebadf)
+{
+	EXPECT_EQ(sys_mkdirat2(-42, "badfdir", S_IRWXU, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
+/* A dfd that points to a file (not a directory) must fail with ENOTDIR. */
+TEST_F(mkdirat2, enotdir_dfd)
+{
+	int file_fd;
+
+	file_fd = openat(self->dfd, "file",
+			 O_CREAT | O_WRONLY, S_IRWXU);
+	ASSERT_GE(file_fd, 0);
+
+	EXPECT_EQ(sys_mkdirat2(file_fd, "subdir", S_IRWXU, 0), -1);
+	EXPECT_EQ(errno, ENOTDIR);
+
+	EXPECT_EQ(close(file_fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "file", 0), 0);
+}
+
+/*
+ * The returned fd must be usable as a dfd for further *at() calls.
+ */
+TEST_F(mkdirat2, fd_usable_as_dfd)
+{
+	int parent_fd, child_fd;
+
+	parent_fd = mkdirat2_checked(self->dfd, "parent");
+	child_fd = mkdirat2_checked(parent_fd, "child");
+
+	EXPECT_EQ(close(child_fd), 0);
+	EXPECT_EQ(close(parent_fd), 0);
+
+	char path[PATH_MAX];
+	snprintf(path, sizeof(path), "%s/parent/child", self->dirpath);
+	EXPECT_EQ(rmdir(path), 0);
+	snprintf(path, sizeof(path), "%s/parent", self->dirpath);
+	EXPECT_EQ(rmdir(path), 0);
+}
+
+/* Unknown flags must be rejected with EINVAL. */
+TEST_F(mkdirat2, einval_unknown_flags)
+{
+	EXPECT_EQ(sys_mkdirat2(self->dfd, "flagsdir", S_IRWXU, ~VALID_MKDIRAT2_FLAGS ), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.53.0


