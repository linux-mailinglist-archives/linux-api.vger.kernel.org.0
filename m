Return-Path: <linux-api+bounces-6046-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HIUEiEKzGn+NQYAu9opvQ
	(envelope-from <linux-api+bounces-6046-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 19:53:37 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE9C36F716
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 19:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 115D43114C1E
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05D1345CBC;
	Tue, 31 Mar 2026 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Z9/cUuft"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF023643F
	for <linux-api@vger.kernel.org>; Tue, 31 Mar 2026 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977639; cv=none; b=dlgUm4GF7AKy7e7vGe49JVGzevJ41XCIZB2lYtFOX+f3HlCAMbVr7gvxlnFSx8hsXd9uHzbHMNZJ8Uy8wX36nCrD2nf1ouYQqratWEN9vICZjiYh01LZeBm0gEnIzDzR4iFTCE2of0eHSxN9qREJobrD9CdfB3SAVhgNoKDUyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977639; c=relaxed/simple;
	bh=LXGIe2EbKEgpeH0Y3XR7VUj1ALQtEFbVCyxTICzraSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfNonmuaRAVI4DJuMnkz/WUtwU1osIXZlYV7ZQRuAVtwQHDZVZ6qJ7aAst8ZoXqCKvImeEi4Qz5H5dOmQ91TSupi20IiRaxE59ph2Fnl5BTGL0YAAA+CElDIVXu+VY5+AOixk+AjgDEwKOpsDQFTtS0HKPwAxmCbyuWe+2G9LgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Z9/cUuft; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: eb083a41-2d25-11f1-89dd-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id eb083a41-2d25-11f1-89dd-00505699b430;
	Tue, 31 Mar 2026 19:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=zDP/iu2bYslX1MKM5Ro/UsGWemjCD4by8j49Ok9YqUI=;
	b=Z9/cUuftDVDCQkdTQLqdCiSeMZMVXZPTADgtNig+MEIP2mPBTjDplgPtxG+ceEmet8u+RdoEg3nbs
	 UMvRPZ5ucT8tZAiss8WadzlDev5e76yOfcqTCXFrCMZZLaNtBjSBz8qOqwUnSe0Zgr688HgBvwdQ5K
	 SlWcxFZ1rVEvkLF/k5ZbYYH/RodIHl+ApLBm0WvYxl9gjtz+2BmIlMc2kyFrpREQNG7J998rFtcXzK
	 iBn9wrjyJdxQKxnntNmUo/XBsZzBnlHwVx9PvpTiq3XK0wNHGeaMy1RLKBSoX/xP/fZOXEbGN4pO22
	 xM2xlX+JALZkWtZiDwqsWpSOz2CZIoQ==
X-KPN-MID: 33|sikx9ZcHd/fInEMSfVbSNHhMDyIs4oGsjHeL/W8Z7mI2Bm3I565SPcupuicIDP3
 rdLtexMWR+4Zl7NdQamsboA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nr5woH1BD8GZbCzHqoBN7y6lJ5aJDQ+LMqUCyp20FGKwuVwbmxrUdUBNnk670m1
 YseKZw3G8i96sRps4/UBWfA==
Received: from daedalus.home (unknown [178.227.25.158])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ea964dfe-2d25-11f1-86d5-005056998788;
	Tue, 31 Mar 2026 19:20:30 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	cmirabil@redhat.com,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 2/2] selftest: add tests for mkdirat_fd()
Date: Tue, 31 Mar 2026 19:19:59 +0200
Message-ID: <20260331172011.3512876-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,suse.cz,gmail.com,infradead.org,redhat.com,kernel.org,efficios.com,linutronix.de,cyphar.com,vger.kernel.org,xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-6046-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid]
X-Rspamd-Queue-Id: 9DE9C36F716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add some tests for the new mkdirat_fd() syscall to test compliance and
to showcase its behaviour.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 tools/include/uapi/asm-generic/unistd.h       |   5 +-
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 .../selftests/filesystems/mkdirat_fd_test.c   | 139 ++++++++++++++++++
 3 files changed, 145 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/mkdirat_fd_test.c

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index a627acc8fb5f..5bae1029f5d9 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -863,8 +863,11 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
+#define __NR_mkdirat_fd 472
+__SYSCALL(__NR_mkdirat_fd, sys_mkdirat_fd)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 473
 
 /*
  * 32 bit systems traditionally used different
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
index 000000000000..9058be49dc7b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mkdirat_fd_test.c
@@ -0,0 +1,139 @@
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
+#ifndef MKDIRAT_FD_NEED_FD
+#define MKDIRAT_FD_NEED_FD 0x01
+#endif
+
+#define mkdirat_fd_checked(dfd, pathname) ({					\
+	struct stat __st;							\
+	int __fd = sys_mkdirat_fd(dfd, pathname, S_IRWXU, MKDIRAT_FD_NEED_FD);	\
+	ASSERT_GE(__fd, 0);							\
+	EXPECT_EQ(fstat(__fd, &__st), 0);					\
+	EXPECT_TRUE(S_ISDIR(__st.st_mode));					\
+	__fd;									\
+})
+
+static inline int sys_mkdirat_fd(int dfd, const char *pathname, mode_t mode,
+				 unsigned int flags)
+{
+	return syscall(__NR_mkdirat_fd, dfd, pathname, mode, flags);
+}
+
+FIXTURE(mkdirat_fd) {
+	char dirpath[PATH_MAX];
+	int dfd;
+};
+
+FIXTURE_SETUP(mkdirat_fd)
+{
+	snprintf(self->dirpath, sizeof(self->dirpath),
+		 "/tmp/mkdirat_fd_test.%d", getpid());
+	ASSERT_EQ(mkdir(self->dirpath, S_IRWXU), 0);
+
+	self->dfd = open(self->dirpath, O_DIRECTORY);
+	ASSERT_GE(self->dfd, 0);
+}
+
+FIXTURE_TEARDOWN(mkdirat_fd)
+{
+	close(self->dfd);
+	rmdir(self->dirpath);
+}
+
+/* Does mkdirat_fd return a fd at all */
+TEST_F(mkdirat_fd, returns_fd)
+{
+	int fd = mkdirat_fd_checked(self->dfd, "newdir");
+	EXPECT_EQ(close(fd), 0)
+	EXPECT_EQ(unlinkat(self->dfd, "newdir", AT_REMOVEDIR), 0);
+}
+
+/* The fd must refer to the directory that was just created. */
+TEST_F(mkdirat_fd, fd_is_created_dir)
+{
+	int fd;
+	struct stat st_via_fd, st_via_path;
+	char path[PATH_MAX];
+
+	fd = mkdirat_fd_checked(self->dfd, "checkdir");
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
+TEST_F(mkdirat_fd, enoent_missing_parent)
+{
+	EXPECT_EQ(sys_mkdirat_fd(self->dfd, "nonexistent/child", S_IRWXU, MKDIRAT_FD_NEED_FD), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+/* An invalid dfd must fail with EBADF. */
+TEST_F(mkdirat_fd, ebadf)
+{
+	EXPECT_EQ(sys_mkdirat_fd(-42, "badfdir", S_IRWXU, MKDIRAT_FD_NEED_FD), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
+/* A dfd that points to a file (not a directory) must fail with ENOTDIR. */
+TEST_F(mkdirat_fd, enotdir_dfd)
+{
+	int file_fd;
+
+	file_fd = openat(self->dfd, "file",
+			 O_CREAT | O_WRONLY, S_IRWXU);
+	ASSERT_GE(file_fd, 0);
+
+	EXPECT_EQ(sys_mkdirat_fd(file_fd, "subdir", S_IRWXU, MKDIRAT_FD_NEED_FD), -1);
+	EXPECT_EQ(errno, ENOTDIR);
+
+	EXPECT_EQ(close(file_fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "file", 0), 0);
+}
+
+/*
+ * The returned fd must be usable as a dfd for further *at() calls.
+ */
+TEST_F(mkdirat_fd, fd_usable_as_dfd)
+{
+	int parent_fd, child_fd;
+
+	parent_fd = mkdirat_fd_checked(self->dfd, "parent");
+	child_fd = mkdirat_fd_checked(parent_fd, "child");
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
+TEST_F(mkdirat_fd, einval_unknown_flags)
+{
+	EXPECT_EQ(sys_mkdirat_fd(self->dfd, "flagsdir", S_IRWXU, ~MKDIRAT_FD_NEED_FD), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.53.0


