Return-Path: <linux-api+bounces-6621-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id myrgGj5rMWpxiwUAu9opvQ
	(envelope-from <linux-api+bounces-6621-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 17:26:54 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD6269107B
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 17:26:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=iu7JZ1NI;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6621-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6621-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 011ED31A5285
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CBE441022;
	Tue, 16 Jun 2026 15:20:30 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D998C26B0A9;
	Tue, 16 Jun 2026 15:20:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623230; cv=none; b=qh9ZWa1MSXRVEBKSpy1BrBQ2Xdyh2ih1zORkvbjcmkT6IHdg2E4rXIJLMRIpL3ro8Qn4lpld5h1uxJkBLfSHVy6xIvUSc7Yxjtvku+3ua4v9zDiOnYYCulT6FRB2R/PMPGxyuz1ayGS6KwvQC7NmBY6r0Gb6q009p14IXgIs7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623230; c=relaxed/simple;
	bh=3bntggysMvaqWGNyuovp3HC8CmiME/BB/W0AGKZpZZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRVaKlhUNe0TCHah00maSchfQ+Xa+ah9rwFyOtG01LnhAgahiAfUbEBtP4ISipnOPqWWLZ2QzSMUuT0LBwa5g+uCLA3K2A1sY4qBVJmfRfP4J3SxJYNUcsO+89D4Ls3fvwYbEMPo05K80dlZCcYIiht24Wtcv4UGggRPrjv6Qxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iu7JZ1NI; arc=none smtp.client-ip=35.83.148.184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781623227; x=1813159227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xhWLMEayqFK+tm6wEdcadubHmr+HyhG/Y6jBJfIiJHQ=;
  b=iu7JZ1NIQMfxGS0e1r8XGWJv0o8p5DIoOwv0I7Ud5LuEjgY3qNEwjcWC
   iM3HmIsgLyCtDKBcxi6m0ozRthK8w6Me8IlaDQPvRdAwJHC1E8WVjmB9f
   LAV8B2+UpS0tg219vRNBV7yin1QK7tkfgTS8rZWwzUMoj6ZwbPxaIY6xx
   EskpZtc6nem54lQIHRwJThOXa/itOKO640TcjHgOxMwYYKelslq4eZKBN
   /jGx177sH9d8V8xfmnG+RgtXOsZLXwFdCRckg1fw004VFH900ZIlDqFAX
   WKU8yblUhRMbAG7mVUg6LSrW3dIPXZXfj2W0+n/PxPOAubDn3FpI5Vvry
   Q==;
X-CSE-ConnectionGUID: PS8h0ih8TFuj1YMjl4cvKQ==
X-CSE-MsgGUID: rsqHxYyiQsKhlF71tOujMw==
X-IronPort-AV: E=Sophos;i="6.24,208,1774310400"; 
   d="scan'208";a="21655545"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 15:20:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:18972]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.253:2525] with esmtp (Farcaster)
 id 30ff908a-bfee-46ff-9cb4-aade9d0972ec; Tue, 16 Jun 2026 15:20:26 +0000 (UTC)
X-Farcaster-Flow-ID: 30ff908a-bfee-46ff-9cb4-aade9d0972ec
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 16 Jun 2026 15:20:26 +0000
Received: from dev-dsk-jamz-1e-e35f4cd9.us-east-1.amazon.com (10.189.35.140)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 16 Jun 2026 15:20:25 +0000
From: Jimmy Zuber <jamz@amazon.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <fuse-devel@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH 2/2] selftests/fuse: add test for FUSE_HAS_SYNCFS privilege gating
Date: Tue, 16 Jun 2026 15:19:09 +0000
Message-ID: <20260616151909.916667-3-jamz@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616151909.916667-1-jamz@amazon.com>
References: <20260616151909.916667-1-jamz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6621-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBD6269107B

Add a selftest that talks the raw FUSE protocol over /dev/fuse (rather
than via libfuse, which negotiates INIT internally) so it can both choose
whether to advertise FUSE_HAS_SYNCFS and directly observe whether a
FUSE_SYNCFS opcode is forwarded by the kernel.

Three cases are covered:

  T1: host-root mount, server sets FUSE_HAS_SYNCFS
      -> FUSE_SYNCFS must reach the server.
  T2: host-root mount, server does not opt in
      -> FUSE_SYNCFS must not be sent (back-compat).
  T3: unprivileged user-namespace mount, server sets FUSE_HAS_SYNCFS
      -> kernel must still withhold FUSE_SYNCFS.

T3 requires CONFIG_USER_NS and the ability to create an unprivileged
user-namespace mount; it is skipped otherwise.

Signed-off-by: Jimmy Zuber <jamz@amazon.com>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 .../selftests/filesystems/fuse/.gitignore     |   1 +
 .../selftests/filesystems/fuse/Makefile       |   2 +-
 .../selftests/filesystems/fuse/test_syncfs.c  | 318 ++++++++++++++++++
 3 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_syncfs.c

diff --git a/tools/testing/selftests/filesystems/fuse/.gitignore b/tools/testing/selftests/filesystems/fuse/.gitignore
index 3e72e742d08e..4e92f363c74a 100644
--- a/tools/testing/selftests/filesystems/fuse/.gitignore
+++ b/tools/testing/selftests/filesystems/fuse/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 fuse_mnt
 fusectl_test
+test_syncfs
diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/testing/selftests/filesystems/fuse/Makefile
index 612aad69a93a..cbba01635226 100644
--- a/tools/testing/selftests/filesystems/fuse/Makefile
+++ b/tools/testing/selftests/filesystems/fuse/Makefile
@@ -2,7 +2,7 @@
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := fusectl_test
+TEST_GEN_PROGS := fusectl_test test_syncfs
 TEST_GEN_FILES := fuse_mnt
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/fuse/test_syncfs.c b/tools/testing/selftests/filesystems/fuse/test_syncfs.c
new file mode 100644
index 000000000000..c00375ffeaea
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/test_syncfs.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that FUSE_SYNCFS is propagated to a userspace server only when the
+ * server opts in with FUSE_HAS_SYNCFS *and* the mount is owned by the initial
+ * user namespace (i.e. set up with real host privilege).
+ *
+ * Unlike the libfuse-based selftests, this talks the raw FUSE wire protocol
+ * over /dev/fuse so it can (a) choose whether to advertise FUSE_HAS_SYNCFS in
+ * the INIT reply and (b) observe directly whether a FUSE_SYNCFS opcode arrives.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/eventfd.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include <linux/fuse.h>
+
+#include "../../kselftest.h"
+
+#define FUSE_ROOT_ID 1
+
+/*
+ * eventfd the server child writes once when it receives FUSE_SYNCFS; the
+ * parent poll()s it to observe (or rule out) propagation.
+ */
+static int syncfs_evfd;
+
+static void reply(int fd, uint64_t unique, int error, void *data, size_t len)
+{
+	struct fuse_out_header oh = {
+		.len = sizeof(oh) + len,
+		.error = error,
+		.unique = unique,
+	};
+	struct iovec iov[2] = {
+		{ &oh, sizeof(oh) },
+		{ data, len },
+	};
+
+	if (writev(fd, iov, data ? 2 : 1) < 0)
+		ksft_print_msg("server writev failed: %s\n", strerror(errno));
+}
+
+static void fill_attr(struct fuse_attr *a, uint64_t ino, uint32_t mode,
+		      uint32_t nlink)
+{
+	memset(a, 0, sizeof(*a));
+	a->ino = ino;
+	a->mode = mode;
+	a->nlink = nlink;
+	a->blksize = 4096;
+}
+
+/*
+ * Minimal FUSE server.  Advertises FUSE_HAS_SYNCFS in its INIT reply iff
+ * @advertise is set.  Signals syncfs_evfd when a FUSE_SYNCFS opcode arrives.
+ */
+#define SERVER_MAX_WRITE 65536
+static void run_server(int fd, int advertise)
+{
+	/*
+	 * The kernel rejects reads (EINVAL) whose buffer is smaller than
+	 * max_write + header, so size generously for the max_write we
+	 * advertise in the INIT reply below.
+	 */
+	static char buf[SERVER_MAX_WRITE + 4096];
+
+	for (;;) {
+		ssize_t n = read(fd, buf, sizeof(buf));
+		struct fuse_in_header *ih = (void *)buf;
+
+		if (n < 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
+			return;		/* device closed on unmount/abort */
+		}
+		if (n < (ssize_t)sizeof(*ih))
+			continue;
+
+		switch (ih->opcode) {
+		case FUSE_INIT: {
+			struct fuse_init_in *in = (void *)(ih + 1);
+			struct fuse_init_out out = {0};
+			uint64_t flags = FUSE_INIT_EXT;
+
+			out.major = FUSE_KERNEL_VERSION;
+			out.minor = FUSE_KERNEL_MINOR_VERSION;
+			out.max_readahead = in->max_readahead;
+			out.max_write = SERVER_MAX_WRITE;
+			out.max_background = 16;
+			out.congestion_threshold = 12;
+			if (advertise)
+				flags |= FUSE_HAS_SYNCFS;
+			out.flags = flags;
+			out.flags2 = flags >> 32;
+			reply(fd, ih->unique, 0, &out, sizeof(out));
+			break;
+		}
+		case FUSE_GETATTR: {
+			struct fuse_attr_out out = {0};
+
+			fill_attr(&out.attr, FUSE_ROOT_ID, S_IFDIR | 0755, 2);
+			reply(fd, ih->unique, 0, &out, sizeof(out));
+			break;
+		}
+		case FUSE_SYNCFS: {
+			uint64_t one = 1;
+
+			if (write(syncfs_evfd, &one, sizeof(one)) < 0)
+				ksft_print_msg("server eventfd write failed: %s\n",
+					       strerror(errno));
+			reply(fd, ih->unique, 0, NULL, 0);
+			break;
+		}
+		default:
+			/*
+			 * Anything else (e.g. OPENDIR from opening the mount
+			 * root) is not needed to drive this test; -ENOSYS lets
+			 * the kernel proceed.
+			 */
+			reply(fd, ih->unique, -ENOSYS, NULL, 0);
+			break;
+		}
+	}
+}
+
+/*
+ * Mount a fuse fs backed by a forked server, issue syncfs(), and report
+ * whether the server observed FUSE_SYNCFS.  Returns 0 on success, -1 if the
+ * environment could not support the test (caller should skip).
+ */
+static int do_mount_and_syncfs(const char *mnt, int advertise, int *seen)
+{
+	struct pollfd pfd = { .events = POLLIN };
+	char opts[256];
+	int fd, mfd = -1, i;
+	pid_t pid;
+
+	syncfs_evfd = eventfd(0, EFD_CLOEXEC);
+	if (syncfs_evfd < 0)
+		return -1;
+
+	fd = open("/dev/fuse", O_RDWR);
+	if (fd < 0)
+		goto out_evfd;
+
+	mkdir(mnt, 0755);
+	snprintf(opts, sizeof(opts),
+		 "fd=%d,rootmode=40000,user_id=%d,group_id=%d",
+		 fd, getuid(), getgid());
+
+	if (mount("fuse", mnt, "fuse", 0, opts) < 0)
+		goto out_fd;
+
+	pid = fork();
+	if (pid < 0)
+		goto out_umount;
+	if (pid == 0) {
+		run_server(fd, advertise);
+		_exit(0);
+	}
+
+	/*
+	 * The parent does not service the fuse fd; the child does.  Close our
+	 * copy so the kernel sees a single server, and so that if the child
+	 * dies the connection aborts instead of hanging us forever.
+	 */
+	close(fd);
+
+	/*
+	 * mount() returns before the server has answered FUSE_INIT, so the
+	 * first open() can race and fail with ENOTCONN; retry until the
+	 * handshake settles.
+	 */
+	for (i = 0; i < 1000; i++) {
+		mfd = open(mnt, O_RDONLY | O_DIRECTORY);
+		if (mfd >= 0)
+			break;
+		usleep(1000);
+	}
+	if (mfd >= 0) {
+		syncfs(mfd);
+		close(mfd);
+	}
+
+	/*
+	 * No waiting is needed: the server writes syncfs_evfd before it replies
+	 * to FUSE_SYNCFS, and that reply is what unblocks the synchronous
+	 * syncfs() above.  So once syncfs() has returned, the eventfd is already
+	 * signalled if the opcode was propagated, and will never be otherwise.
+	 * poll() with a zero timeout therefore decides both cases immediately.
+	 */
+	pfd.fd = syncfs_evfd;
+	*seen = poll(&pfd, 1, 0) > 0 && (pfd.revents & POLLIN);
+
+	kill(pid, SIGKILL);
+	waitpid(pid, NULL, 0);
+	umount2(mnt, MNT_DETACH);
+	close(syncfs_evfd);
+	return 0;
+
+out_umount:
+	umount2(mnt, MNT_DETACH);
+out_fd:
+	close(fd);
+out_evfd:
+	close(syncfs_evfd);
+	return -1;
+}
+
+/* T3: same as above but the mount is created inside a new user namespace. */
+static int run_in_userns(const char *mnt, int advertise, int *seen)
+{
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+	char map[64];
+	int f;
+
+	if (unshare(CLONE_NEWUSER | CLONE_NEWNS) < 0)
+		return -1;	/* unprivileged userns mounts unavailable */
+
+	f = open("/proc/self/setgroups", O_WRONLY);
+	if (f >= 0) {
+		dprintf(f, "deny");
+		close(f);
+	}
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	f = open("/proc/self/uid_map", O_WRONLY);
+	if (f < 0 || dprintf(f, "%s", map) < 0)
+		return -1;
+	close(f);
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	f = open("/proc/self/gid_map", O_WRONLY);
+	if (f < 0 || dprintf(f, "%s", map) < 0)
+		return -1;
+	close(f);
+
+	/* Need a mount namespace where we can mount fuse unprivileged. */
+	if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) < 0)
+		return -1;
+
+	return do_mount_and_syncfs(mnt, advertise, seen);
+}
+
+int main(void)
+{
+	char mnt[] = "/tmp/fuse_syncfs_XXXXXX";
+	int seen, ret;
+
+	ksft_print_header();
+	ksft_set_plan(3);
+
+	/* Hard watchdog: never let a stuck syncfs hang the test runner. */
+	signal(SIGALRM, SIG_DFL);
+	alarm(60);
+
+	if (geteuid() != 0)
+		ksft_exit_skip("test requires root to mount fuse\n");
+
+	if (!mkdtemp(mnt))
+		ksft_exit_fail_msg("mkdtemp failed\n");
+
+	/* T1: host-root mount, server opts in -> syncfs must reach server. */
+	ret = do_mount_and_syncfs(mnt, 1, &seen);
+	if (ret < 0)
+		ksft_test_result_skip("T1: could not mount fuse\n");
+	else
+		ksft_test_result(seen,
+				 "T1 host-root + FUSE_HAS_SYNCFS: server receives FUSE_SYNCFS\n");
+
+	/* T2: host-root mount, server does NOT opt in -> no FUSE_SYNCFS. */
+	ret = do_mount_and_syncfs(mnt, 0, &seen);
+	if (ret < 0)
+		ksft_test_result_skip("T2: could not mount fuse\n");
+	else
+		ksft_test_result(!seen,
+				 "T2 host-root, no opt-in: server does NOT receive FUSE_SYNCFS\n");
+
+	/*
+	 * T3: unprivileged userns mount, server opts in -> kernel must still
+	 * withhold FUSE_SYNCFS.  Run in a child since it unshares namespaces.
+	 */
+	{
+		pid_t p = fork();
+
+		if (p == 0) {
+			int s = 0;
+			int r = run_in_userns(mnt, 1, &s);
+
+			_exit(r < 0 ? 2 : (s ? 1 : 0));
+		} else {
+			int status;
+
+			waitpid(p, &status, 0);
+			if (!WIFEXITED(status))
+				ksft_test_result_error("T3: child crashed\n");
+			else if (WEXITSTATUS(status) == 2)
+				ksft_test_result_skip("T3: userns fuse mount unavailable\n");
+			else
+				ksft_test_result(WEXITSTATUS(status) == 0,
+						 "T3 unpriv userns + opt-in: FUSE_SYNCFS withheld\n");
+		}
+	}
+
+	rmdir(mnt);
+	ksft_finished();
+}
-- 
2.50.1


