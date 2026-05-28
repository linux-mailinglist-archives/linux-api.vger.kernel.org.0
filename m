Return-Path: <linux-api+bounces-6444-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIfEIosSGGrKbggAu9opvQ
	(envelope-from <linux-api+bounces-6444-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:01:47 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4679A5F0210
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A58F30B925C
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087D73B6BFF;
	Thu, 28 May 2026 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="fB2poWTT"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE263B5E01;
	Thu, 28 May 2026 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962357; cv=pass; b=U66jaQBaFYanWmq68SKk3Mbn2gmVcxqrHHerAPVJX8MAZpk1LiTDom30gbMN2JkPQ74PdFcrs70coIQNbjUZFZ8kMXWKezda8cVzkN+tmw/a1wwCVJL+YWpKSHHcXqPMqD/F8slIXumPPpNE0O/dtWhv0BxHkMXHr2MQV+NcLsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962357; c=relaxed/simple;
	bh=jF3AWoihXMBHsrmmEySe48csTm7qCIg0CUpl56qJ89k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWITcgfLQczGDNNnaLxkIVeD6f59ma2rS45SofPDmcWzB+xqZC4V4PqTsxSZ0xI4N432YsRmz+OK9V5ekeespUhMxCRMbMsvXrb6W8MhO//X8yEyukPOIVct3VSFYm7IsBOm+LmVnK5YKx0e6nDf+8hBsHQMF96cII8OuAl0LDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=fB2poWTT; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1779962086; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IV+H3sR/s4LGSiLXOx1PnR+Nukag6obH8xuIZbHHMcHnvSdvg/dKK9XVoQkzlQYJh8698Un01ZAi4nWycBICxxSSZlpVoDJvtZ6fBuqQaiZCvc+wpfnyybofe8sV8NNlYa4cffCrcEtJ0tXQKhz1D2hmyTNFzKCDkBJRr/lLm2M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779962086; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FDRtEtjtIvSHNVwloa1d75aPePQb0NsWFeazlEaiOCE=; 
	b=MeLLDTsLE+wCC14RD5Fk+oIlV0C7Zwn//LnPiBhw/z+RolOX+VofYUMJMKbVgmhD980fUygLGSfz0Z6r3nqwnjnzUcX9woTYpViTEPeSzfGDKpl5ddPB8eVDUB0HYV4LiG+uZodbDyby2EMJFPt0iEdFXXhDvR88fibKoQLLtEw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779962086;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FDRtEtjtIvSHNVwloa1d75aPePQb0NsWFeazlEaiOCE=;
	b=fB2poWTT4hqNMJvy4+J0IcPlguQBHa1w2BGiMHKSfCz4ps7V84meo3h85WjnwKLs
	arrm+GNyafNthjskyXUMfktGgv7nWUhtxDOhZrUocDO3eGg+xJ0a8dA8YBYLBOoJY5c
	r7Z9ETU8zav0wARgfeMz3M8f3V+Qb5x14QmYgcwk=
Received: by mx.zohomail.com with SMTPS id 1779962083230365.44773868125844;
	Thu, 28 May 2026 02:54:43 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Li Chen <me@linux.beauty>
Subject: [RFC PATCH v1 13/13] selftests/exec: cover spawn template basics
Date: Thu, 28 May 2026 17:52:34 +0800
Message-ID: <20260528095235.2491226-14-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528095235.2491226-1-me@linux.beauty>
References: <20260528095235.2491226-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6444-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,linux.beauty:mid,linux.beauty:dkim]
X-Rspamd-Queue-Id: 4679A5F0210
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add exec selftests for the spawn_template ABI. Cover basic spawning,
relative path rejection, execfd execute-permission checks, default fd
closing, close-range actions using newfd -1, and stale path rejection
after executable metadata changes.

Also cover atomic path replacement while a template fd for an old path is
still alive. The old template must reject the changed path with ESTALE, and
a new template for the same path must execute the replacement.

Signed-off-by: Li Chen <me@linux.beauty>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/exec/Makefile         |   1 +
 tools/testing/selftests/exec/spawn_template.c | 997 ++++++++++++++++++
 3 files changed, 999 insertions(+)
 create mode 100644 tools/testing/selftests/exec/spawn_template.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e737097940f9..77b3da32b4d2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9747,6 +9747,7 @@ F:	include/uapi/linux/spawn_template.h
 F:	kernel/fork.c
 F:	mm/vma_exec.c
 F:	tools/testing/selftests/exec/
+F:	tools/testing/selftests/exec/spawn_template.c
 N:	asm/elf.h
 N:	binfmt
 
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 45a3cfc435cfd..cf39fe916b9ba 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -20,6 +20,7 @@ TEST_FILES := Makefile
 TEST_GEN_PROGS += recursion-depth
 TEST_GEN_PROGS += null-argv
 TEST_GEN_PROGS += check-exec
+TEST_GEN_PROGS += spawn_template
 
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
 	       $(OUTPUT)/S_I*.test
diff --git a/tools/testing/selftests/exec/spawn_template.c b/tools/testing/selftests/exec/spawn_template.c
new file mode 100644
index 0000000000000..26708143ac9dc
--- /dev/null
+++ b/tools/testing/selftests/exec/spawn_template.c
@@ -0,0 +1,997 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/spawn_template.h>
+
+#include "kselftest.h"
+
+#ifndef __NR_spawn_template_create
+#define __NR_spawn_template_create 472
+#endif
+
+#ifndef __NR_spawn_template_spawn
+#define __NR_spawn_template_spawn 473
+#endif
+
+#define SPAWN_TEMPLATE_MISSING_SYSCALL_ERRNO	38
+#define SPAWN_TEMPLATE_KERNEL_NSIG		64
+#define SPAWN_TEMPLATE_KERNEL_SIGSET_WORDS	\
+	(SPAWN_TEMPLATE_KERNEL_NSIG / (8 * sizeof(unsigned long)))
+
+static const char *true_path;
+static char self_path[PATH_MAX];
+
+struct spawn_template_kernel_sigset {
+	unsigned long sig[SPAWN_TEMPLATE_KERNEL_SIGSET_WORDS];
+};
+
+static void spawn_template_kernel_sigempty(struct spawn_template_kernel_sigset *set)
+{
+	memset(set, 0, sizeof(*set));
+}
+
+static void spawn_template_kernel_sigadd(struct spawn_template_kernel_sigset *set,
+					 int sig)
+{
+	sig--;
+	set->sig[sig / (8 * sizeof(unsigned long))] |=
+		1UL << (sig % (8 * sizeof(unsigned long)));
+}
+
+static int read_fd_string(int fd, const char *expected)
+{
+	char buf[128];
+	ssize_t nread;
+
+	nread = read(fd, buf, sizeof(buf) - 1);
+	if (nread < 0)
+		return -errno;
+
+	buf[nread] = '\0';
+	return strcmp(buf, expected) ? -EINVAL : 0;
+}
+
+static int write_file(const char *path, const char *data, mode_t mode)
+{
+	size_t left = strlen(data);
+	const char *p = data;
+	int fd;
+	int ret = 0;
+
+	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, mode);
+	if (fd < 0)
+		return -errno;
+
+	while (left) {
+		ssize_t written = write(fd, p, left);
+
+		if (written < 0) {
+			ret = -errno;
+			break;
+		}
+		left -= written;
+		p += written;
+	}
+
+	close(fd);
+	return ret;
+}
+
+static int create_template_path(const char *path)
+{
+	struct spawn_template_create_args args = {
+		.flags = SPAWN_TEMPLATE_CREATE_CLOEXEC,
+		.execfd = -1,
+		.filename = (uintptr_t)path,
+	};
+
+	return syscall(__NR_spawn_template_create, &args, sizeof(args));
+}
+
+static int create_template_fd(int execfd)
+{
+	struct spawn_template_create_args args = {
+		.flags = SPAWN_TEMPLATE_CREATE_CLOEXEC,
+		.execfd = execfd,
+	};
+
+	return syscall(__NR_spawn_template_create, &args, sizeof(args));
+}
+
+static int spawn_template_start(int template_fd, char *const argv[],
+				struct spawn_template_action *actions,
+				unsigned int actions_len,
+				unsigned long long flags, pid_t *pid_out,
+				int *pidfd_out)
+{
+	char *const envp[] = { "PATH=/usr/bin:/bin", NULL };
+	struct spawn_template_spawn_args args = {
+		.flags = flags,
+		.argv = (uintptr_t)argv,
+		.envp = (uintptr_t)envp,
+		.actions = (uintptr_t)actions,
+		.actions_len = actions_len,
+	};
+	int pidfd = -1;
+	pid_t pid;
+	int ret;
+
+	args.pidfd = (uintptr_t)&pidfd;
+
+	pid = syscall(__NR_spawn_template_spawn, template_fd, &args,
+		      sizeof(args));
+	if (pid < 0) {
+		ret = -errno;
+		if (pidfd >= 0) {
+			siginfo_t info;
+
+			waitid(P_PIDFD, pidfd, &info, WEXITED);
+			close(pidfd);
+		}
+		return ret;
+	}
+
+	*pid_out = pid;
+	*pidfd_out = pidfd;
+	return 0;
+}
+
+static int spawn_template(int template_fd, char *const argv[],
+			  struct spawn_template_action *actions,
+			  unsigned int actions_len, unsigned long long flags)
+{
+	siginfo_t info = {};
+	int pidfd;
+	pid_t pid;
+	int ret;
+
+	ret = spawn_template_start(template_fd, argv, actions, actions_len, flags,
+				   &pid, &pidfd);
+	if (ret)
+		return ret;
+	(void)pid;
+
+	ret = waitid(P_PIDFD, pidfd, &info, WEXITED);
+	if (ret < 0) {
+		ret = -errno;
+		goto out_close_pidfd;
+	}
+
+	if (info.si_code != CLD_EXITED) {
+		ret = -EINVAL;
+		goto out_close_pidfd;
+	}
+
+	ret = info.si_status;
+
+out_close_pidfd:
+	if (pidfd >= 0)
+		close(pidfd);
+	return ret;
+}
+
+static const char *find_true(void)
+{
+	static const char * const paths[] = {
+		"/usr/bin/true",
+		"/bin/true",
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(paths); i++) {
+		if (access(paths[i], X_OK) == 0)
+			return paths[i];
+	}
+	return NULL;
+}
+
+static int copy_file(const char *src, const char *dst)
+{
+	char buf[8192];
+	ssize_t nread;
+	int infd;
+	int outfd;
+	int ret = 0;
+
+	infd = open(src, O_RDONLY | O_CLOEXEC);
+	if (infd < 0)
+		return -errno;
+
+	outfd = open(dst, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0700);
+	if (outfd < 0) {
+		ret = -errno;
+		goto out_close_in;
+	}
+
+	while ((nread = read(infd, buf, sizeof(buf))) > 0) {
+		char *p = buf;
+		ssize_t left = nread;
+
+		while (left > 0) {
+			ssize_t written = write(outfd, p, left);
+
+			if (written < 0) {
+				ret = -errno;
+				goto out_close_out;
+			}
+			left -= written;
+			p += written;
+		}
+	}
+	if (nread < 0)
+		ret = -errno;
+
+out_close_out:
+	close(outfd);
+out_close_in:
+	close(infd);
+	return ret;
+}
+
+static int test_basic_spawn(void)
+{
+	char *const argv[] = { (char *)true_path, NULL };
+	int template_fd;
+	int ret;
+
+	template_fd = create_template_path(true_path);
+	if (template_fd < 0)
+		return -errno;
+
+	ret = spawn_template(template_fd, argv, NULL, 0, 0);
+	close(template_fd);
+	return ret;
+}
+
+static int test_relative_path_rejected(void)
+{
+	int template_fd;
+
+	template_fd = create_template_path("true");
+	if (template_fd >= 0) {
+		close(template_fd);
+		return -EINVAL;
+	}
+
+	return errno == EINVAL ? 0 : -errno;
+}
+
+static int test_execfd_requires_execute(void)
+{
+	char path[] = "/tmp/spawn-template-noexec-XXXXXX";
+	int template_fd;
+	int fd;
+	int ret = 0;
+
+	fd = mkstemp(path);
+	if (fd < 0)
+		return -errno;
+
+	if (fchmod(fd, 0600)) {
+		ret = -errno;
+		goto out;
+	}
+
+	template_fd = create_template_fd(fd);
+	if (template_fd >= 0) {
+		close(template_fd);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = errno == EACCES ? 0 : -errno;
+
+out:
+	close(fd);
+	unlink(path);
+	return ret;
+}
+
+static int test_default_closes_extra_fds(void)
+{
+	char fdarg[32];
+	char *const argv[] = {
+		self_path,
+		"--check-fd-closed",
+		fdarg,
+		NULL,
+	};
+	int template_fd;
+	int extra_fd;
+	int ret;
+
+	extra_fd = open("/dev/null", O_RDONLY);
+	if (extra_fd < 0)
+		return -errno;
+
+	snprintf(fdarg, sizeof(fdarg), "%d", extra_fd);
+
+	template_fd = create_template_path(self_path);
+	if (template_fd < 0) {
+		ret = -errno;
+		goto out_close_extra;
+	}
+
+	ret = spawn_template(template_fd, argv, NULL, 0, 0);
+	close(template_fd);
+
+out_close_extra:
+	close(extra_fd);
+	return ret;
+}
+
+static int test_close_range_max_action(void)
+{
+	char fdarg[32];
+	char *const argv[] = {
+		self_path,
+		"--check-fd-closed",
+		fdarg,
+		NULL,
+	};
+	struct spawn_template_action action = {
+		.type = SPAWN_TEMPLATE_ACTION_CLOSE_RANGE,
+		.fd = -1,
+		.newfd = -1,
+	};
+	int template_fd;
+	int extra_fd;
+	int ret;
+
+	extra_fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	if (extra_fd < 0)
+		return -errno;
+
+	action.fd = extra_fd;
+	snprintf(fdarg, sizeof(fdarg), "%d", extra_fd);
+
+	template_fd = create_template_path(self_path);
+	if (template_fd < 0) {
+		ret = -errno;
+		goto out_close_extra;
+	}
+
+	ret = spawn_template(template_fd, argv, &action, 1,
+			     SPAWN_TEMPLATE_SPAWN_INHERIT_FDS);
+	close(template_fd);
+
+out_close_extra:
+	close(extra_fd);
+	return ret;
+}
+
+static int test_dup2_stdio_actions(void)
+{
+	char *const argv[] = { self_path, "--write-stdio", NULL };
+	struct spawn_template_action actions[2];
+	char out_buf[32];
+	char err_buf[32];
+	int out_pipe[2];
+	int err_pipe[2];
+	int template_fd;
+	int ret = 0;
+
+	if (pipe2(out_pipe, O_CLOEXEC))
+		return -errno;
+	if (pipe2(err_pipe, O_CLOEXEC)) {
+		ret = -errno;
+		goto out_close_out_pipe;
+	}
+
+	actions[0] = (struct spawn_template_action) {
+		.type = SPAWN_TEMPLATE_ACTION_DUP2,
+		.fd = out_pipe[1],
+		.newfd = STDOUT_FILENO,
+	};
+	actions[1] = (struct spawn_template_action) {
+		.type = SPAWN_TEMPLATE_ACTION_DUP2,
+		.fd = err_pipe[1],
+		.newfd = STDERR_FILENO,
+	};
+
+	template_fd = create_template_path(self_path);
+	if (template_fd < 0) {
+		ret = -errno;
+		goto out_close_err_pipe;
+	}
+
+	ret = spawn_template(template_fd, argv, actions, ARRAY_SIZE(actions), 0);
+	close(template_fd);
+	if (ret)
+		goto out_close_err_pipe;
+
+	close(out_pipe[1]);
+	out_pipe[1] = -1;
+	close(err_pipe[1]);
+	err_pipe[1] = -1;
+
+	memset(out_buf, 0, sizeof(out_buf));
+	memset(err_buf, 0, sizeof(err_buf));
+	if (read(out_pipe[0], out_buf, sizeof(out_buf) - 1) < 0) {
+		ret = -errno;
+		goto out_close_err_pipe;
+	}
+	if (read(err_pipe[0], err_buf, sizeof(err_buf) - 1) < 0) {
+		ret = -errno;
+		goto out_close_err_pipe;
+	}
+	if (strcmp(out_buf, "stdout-token\n") ||
+	    strcmp(err_buf, "stderr-token\n"))
+		ret = -EINVAL;
+
+out_close_err_pipe:
+	if (err_pipe[1] >= 0)
+		close(err_pipe[1]);
+	close(err_pipe[0]);
+out_close_out_pipe:
+	if (out_pipe[1] >= 0)
+		close(out_pipe[1]);
+	close(out_pipe[0]);
+	return ret;
+}
+
+static int test_open_action_stdin(void)
+{
+	char dir[] = "/tmp/spawn-template-open-XXXXXX";
+	char path[PATH_MAX];
+	char *const argv[] = {
+		self_path,
+		"--check-fd-content",
+		"0",
+		"open-action-token\n",
+		NULL,
+	};
+	struct spawn_template_open open_arg = {
+		.path = (uintptr_t)path,
+		.how = {
+			.flags = O_RDONLY,
+		},
+	};
+	struct spawn_template_action action = {
+		.type = SPAWN_TEMPLATE_ACTION_OPEN,
+		.fd = AT_FDCWD,
+		.newfd = STDIN_FILENO,
+		.arg = (uintptr_t)&open_arg,
+	};
+	int template_fd;
+	int ret;
+
+	if (!mkdtemp(dir))
+		return -errno;
+
+	snprintf(path, sizeof(path), "%s/input", dir);
+	ret = write_file(path, "open-action-token\n", 0600);
+	if (ret)
+		goto out_unlink;
+
+	template_fd = create_template_path(self_path);
+	if (template_fd < 0) {
+		ret = -errno;
+		goto out_unlink;
+	}
+
+	ret = spawn_template(template_fd, argv, &action, 1, 0);
+	close(template_fd);
+
+out_unlink:
+	unlink(path);
+	rmdir(dir);
+	return ret;
+}
+
+static int test_fchdir_action(void)
+{
+	char dir[] = "/tmp/spawn-template-fchdir-XXXXXX";
+	char resolved[PATH_MAX];
+	char *const argv[] = {
+		self_path,
+		"--check-cwd",
+		resolved,
+		NULL,
+	};
+	struct spawn_template_action action = {
+		.type = SPAWN_TEMPLATE_ACTION_FCHDIR,
+	};
+	int template_fd;
+	int dirfd;
+	int ret;
+
+	if (!mkdtemp(dir))
+		return -errno;
+	if (!realpath(dir, resolved)) {
+		ret = -errno;
+		goto out_rmdir;
+	}
+
+	dirfd = open(dir, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	if (dirfd < 0) {
+		ret = -errno;
+		goto out_rmdir;
+	}
+	action.fd = dirfd;
+
+	template_fd = create_template_path(self_path);
+	if (template_fd < 0) {
+		ret = -errno;
+		goto out_close_dirfd;
+	}
+
+	ret = spawn_template(template_fd, argv, &action, 1, 0);
+	close(template_fd);
+
+out_close_dirfd:
+	close(dirfd);
+out_rmdir:
+	rmdir(dir);
+	return ret;
+}
+
+static int test_sigmask_action(void)
+{
+	char sigarg[16];
+	char *const argv[] = {
+		self_path,
+		"--check-sigmask",
+		sigarg,
+		NULL,
+	};
+	struct spawn_template_kernel_sigset mask;
+	struct spawn_template_sigset sigset_arg = {
+		.sigset = (uintptr_t)&mask,
+		.sigsetsize = sizeof(mask),
+	};
+	struct spawn_template_action action = {
+		.type = SPAWN_TEMPLATE_ACTION_SIGMASK,
+		.arg = (uintptr_t)&sigset_arg,
+	};
+	int template_fd;
+	int ret;
+
+	spawn_template_kernel_sigempty(&mask);
+	spawn_template_kernel_sigadd(&mask, SIGUSR1);
+	snprintf(sigarg, sizeof(sigarg), "%d", SIGUSR1);
+
+	template_fd = create_template_path(self_path);
+	if (template_fd < 0)
+		return -errno;
+
+	ret = spawn_template(template_fd, argv, &action, 1, 0);
+	close(template_fd);
+	return ret;
+}
+
+static int test_sigdefault_action(void)
+{
+	char sigarg[16];
+	char *const argv[] = {
+		self_path,
+		"--check-sigdefault",
+		sigarg,
+		NULL,
+	};
+	struct spawn_template_kernel_sigset mask;
+	struct sigaction old_sa;
+	struct sigaction ignore_sa = {
+		.sa_handler = SIG_IGN,
+	};
+	struct spawn_template_sigset sigset_arg = {
+		.sigset = (uintptr_t)&mask,
+		.sigsetsize = sizeof(mask),
+	};
+	struct spawn_template_action action = {
+		.type = SPAWN_TEMPLATE_ACTION_SIGDEFAULT,
+		.arg = (uintptr_t)&sigset_arg,
+	};
+	int template_fd;
+	int ret;
+
+	spawn_template_kernel_sigempty(&mask);
+	spawn_template_kernel_sigadd(&mask, SIGUSR1);
+	snprintf(sigarg, sizeof(sigarg), "%d", SIGUSR1);
+
+	if (sigaction(SIGUSR1, &ignore_sa, &old_sa))
+		return -errno;
+
+	template_fd = create_template_path(self_path);
+	if (template_fd < 0) {
+		ret = -errno;
+		goto out_restore_signal;
+	}
+
+	ret = spawn_template(template_fd, argv, &action, 1, 0);
+	close(template_fd);
+
+out_restore_signal:
+	sigaction(SIGUSR1, &old_sa, NULL);
+	return ret;
+}
+
+static int test_inherit_fds_flag(void)
+{
+	char fdarg[32];
+	char *const argv[] = {
+		self_path,
+		"--check-fd-open",
+		fdarg,
+		NULL,
+	};
+	int template_fd;
+	int extra_fd;
+	int ret;
+
+	extra_fd = open("/dev/null", O_RDONLY);
+	if (extra_fd < 0)
+		return -errno;
+	snprintf(fdarg, sizeof(fdarg), "%d", extra_fd);
+
+	template_fd = create_template_path(self_path);
+	if (template_fd < 0) {
+		ret = -errno;
+		goto out_close_extra;
+	}
+
+	ret = spawn_template(template_fd, argv, NULL, 0,
+			     SPAWN_TEMPLATE_SPAWN_INHERIT_FDS);
+	close(template_fd);
+
+out_close_extra:
+	close(extra_fd);
+	return ret;
+}
+
+static int test_pidfd_waitid(void)
+{
+	char *const argv[] = { (char *)true_path, NULL };
+	siginfo_t info = {};
+	int template_fd;
+	int pidfd;
+	pid_t pid;
+	int ret;
+
+	template_fd = create_template_path(true_path);
+	if (template_fd < 0)
+		return -errno;
+
+	ret = spawn_template_start(template_fd, argv, NULL, 0, 0, &pid, &pidfd);
+	close(template_fd);
+	if (ret)
+		return ret;
+
+	ret = waitid(P_PIDFD, pidfd, &info, WEXITED);
+	if (ret < 0) {
+		ret = -errno;
+		waitpid(pid, NULL, 0);
+		goto out_close_pidfd;
+	}
+	if (info.si_code != CLD_EXITED || info.si_status)
+		ret = -EINVAL;
+
+out_close_pidfd:
+	close(pidfd);
+	return ret;
+}
+
+static int test_create_actions_rejected(void)
+{
+	struct spawn_template_action action = {
+		.type = SPAWN_TEMPLATE_ACTION_CLOSE,
+		.fd = STDIN_FILENO,
+	};
+	struct spawn_template_create_args args = {
+		.flags = SPAWN_TEMPLATE_CREATE_CLOEXEC,
+		.execfd = -1,
+		.filename = (uintptr_t)true_path,
+		.actions = (uintptr_t)&action,
+		.actions_len = 1,
+	};
+	int template_fd;
+
+	template_fd = syscall(__NR_spawn_template_create, &args, sizeof(args));
+	if (template_fd >= 0) {
+		close(template_fd);
+		return -EINVAL;
+	}
+
+	return errno == EINVAL ? 0 : -errno;
+}
+
+static int test_script_template_unsupported(void)
+{
+	char dir[] = "/tmp/spawn-template-script-XXXXXX";
+	char path[PATH_MAX];
+	int template_fd;
+	int ret;
+
+	if (!mkdtemp(dir))
+		return -errno;
+
+	snprintf(path, sizeof(path), "%s/script", dir);
+	ret = write_file(path, "#!/bin/sh\nexit 0\n", 0700);
+	if (ret)
+		goto out_unlink;
+
+	template_fd = create_template_path(path);
+	if (template_fd >= 0) {
+		close(template_fd);
+		ret = -EINVAL;
+		goto out_unlink;
+	}
+	ret = errno == ENOEXEC ? 0 : -errno;
+
+out_unlink:
+	unlink(path);
+	rmdir(dir);
+	return ret;
+}
+
+static int test_deny_write_while_template_alive(void)
+{
+	char dir[] = "/tmp/spawn-template-deny-write-XXXXXX";
+	char path[PATH_MAX];
+	int template_fd;
+	int write_fd;
+	int ret = 0;
+
+	if (!mkdtemp(dir))
+		return -errno;
+
+	snprintf(path, sizeof(path), "%s/copy", dir);
+	ret = copy_file(self_path, path);
+	if (ret)
+		goto out_unlink;
+
+	template_fd = create_template_path(path);
+	if (template_fd < 0) {
+		ret = -errno;
+		goto out_unlink;
+	}
+
+	write_fd = open(path, O_WRONLY | O_TRUNC | O_CLOEXEC);
+	if (write_fd >= 0) {
+		close(write_fd);
+		ret = -EINVAL;
+	} else {
+		ret = errno == ETXTBSY ? 0 : -errno;
+	}
+
+	close(template_fd);
+out_unlink:
+	unlink(path);
+	rmdir(dir);
+	return ret;
+}
+
+static int test_stale_path_rejected(void)
+{
+	char dir[] = "/tmp/spawn-template-stale-XXXXXX";
+	char path[PATH_MAX];
+	char *const argv[] = { path, "--exit-zero", NULL };
+	int template_fd;
+	int ret = 0;
+
+	if (!mkdtemp(dir))
+		return -errno;
+
+	snprintf(path, sizeof(path), "%s/copy", dir);
+	ret = copy_file(self_path, path);
+	if (ret)
+		goto out_unlink;
+
+	template_fd = create_template_path(path);
+	if (template_fd < 0) {
+		ret = -errno;
+		goto out_unlink;
+	}
+
+	if (chmod(path, 0600)) {
+		ret = -errno;
+		goto out_close_template;
+	}
+
+	ret = spawn_template(template_fd, argv, NULL, 0, 0);
+	if (ret >= 0)
+		ret = -EINVAL;
+	else
+		ret = ret == -ESTALE ? 0 : ret;
+
+out_close_template:
+	close(template_fd);
+out_unlink:
+	unlink(path);
+	rmdir(dir);
+	return ret;
+}
+
+static int test_path_replacement_allows_tool_update(void)
+{
+	char dir[] = "/tmp/spawn-template-update-XXXXXX";
+	char path[PATH_MAX];
+	char new_path[PATH_MAX];
+	char *const argv[] = { path, "--exit-zero", NULL };
+	int new_template_fd = -1;
+	int template_fd = -1;
+	int ret;
+
+	if (!mkdtemp(dir))
+		return -errno;
+
+	snprintf(path, sizeof(path), "%s/tool", dir);
+	snprintf(new_path, sizeof(new_path), "%s/tool.new", dir);
+	ret = copy_file(self_path, path);
+	if (ret)
+		goto out;
+	ret = copy_file(self_path, new_path);
+	if (ret)
+		goto out;
+
+	template_fd = create_template_path(path);
+	if (template_fd < 0) {
+		ret = -errno;
+		goto out;
+	}
+
+	if (rename(new_path, path)) {
+		ret = -errno;
+		goto out;
+	}
+
+	ret = spawn_template(template_fd, argv, NULL, 0, 0);
+	if (ret != -ESTALE) {
+		ret = ret < 0 ? ret : -EINVAL;
+		goto out;
+	}
+
+	new_template_fd = create_template_path(path);
+	if (new_template_fd < 0) {
+		ret = -errno;
+		goto out;
+	}
+
+	ret = spawn_template(new_template_fd, argv, NULL, 0, 0);
+
+out:
+	if (new_template_fd >= 0)
+		close(new_template_fd);
+	if (template_fd >= 0)
+		close(template_fd);
+	unlink(new_path);
+	unlink(path);
+	rmdir(dir);
+	return ret;
+}
+
+static void run_test(const char *name, int (*fn)(void))
+{
+	int ret = fn();
+
+	if (!ret)
+		ksft_test_result_pass("%s\n", name);
+	else
+		ksft_test_result_fail("%s failed: %s (%d)\n",
+				      name, strerror(-ret), -ret);
+}
+
+static void check_syscall_available(void)
+{
+	int template_fd;
+
+	template_fd = create_template_path(true_path);
+	if (template_fd >= 0) {
+		close(template_fd);
+		return;
+	}
+
+	if (errno == SPAWN_TEMPLATE_MISSING_SYSCALL_ERRNO)
+		ksft_exit_skip("spawn_template syscalls are not available\n");
+
+	ksft_exit_fail_msg("spawn_template_create failed: %s (%d)\n",
+			   strerror(errno), errno);
+}
+
+int main(int argc, char **argv)
+{
+	ssize_t len;
+
+	if (argc == 2 && !strcmp(argv[1], "--exit-zero"))
+		return 0;
+
+	if (argc == 3 && !strcmp(argv[1], "--check-fd-closed")) {
+		int fd = atoi(argv[2]);
+
+		return fcntl(fd, F_GETFD) < 0 && errno == EBADF ? 0 : 1;
+	}
+
+	if (argc == 3 && !strcmp(argv[1], "--check-fd-open")) {
+		int fd = atoi(argv[2]);
+
+		return fcntl(fd, F_GETFD) >= 0 ? 0 : 1;
+	}
+
+	if (argc == 4 && !strcmp(argv[1], "--check-fd-content"))
+		return read_fd_string(atoi(argv[2]), argv[3]) ? 1 : 0;
+
+	if (argc == 3 && !strcmp(argv[1], "--check-cwd")) {
+		char cwd[PATH_MAX];
+
+		if (!getcwd(cwd, sizeof(cwd)))
+			return 1;
+		return strcmp(cwd, argv[2]) ? 1 : 0;
+	}
+
+	if (argc == 3 && !strcmp(argv[1], "--check-sigmask")) {
+		sigset_t mask;
+		int sig = atoi(argv[2]);
+
+		if (sigprocmask(SIG_BLOCK, NULL, &mask))
+			return 1;
+		return sigismember(&mask, sig) == 1 ? 0 : 1;
+	}
+
+	if (argc == 3 && !strcmp(argv[1], "--check-sigdefault")) {
+		struct sigaction sa;
+		int sig = atoi(argv[2]);
+
+		if (sigaction(sig, NULL, &sa))
+			return 1;
+		return sa.sa_handler == SIG_DFL ? 0 : 1;
+	}
+
+	if (argc == 2 && !strcmp(argv[1], "--write-stdio")) {
+		if (write(STDOUT_FILENO, "stdout-token\n", 13) != 13)
+			return 1;
+		if (write(STDERR_FILENO, "stderr-token\n", 13) != 13)
+			return 1;
+		return 0;
+	}
+
+	true_path = find_true();
+	if (!true_path)
+		ksft_exit_skip("could not find true executable\n");
+
+	len = readlink("/proc/self/exe", self_path, sizeof(self_path) - 1);
+	if (len < 0)
+		ksft_exit_fail_msg("readlink(/proc/self/exe) failed: %s\n",
+				   strerror(errno));
+	self_path[len] = '\0';
+
+	check_syscall_available();
+
+	ksft_print_header();
+	ksft_set_plan(17);
+
+	run_test("basic spawn", test_basic_spawn);
+	run_test("relative path rejected", test_relative_path_rejected);
+	run_test("execfd execute permission checked",
+		 test_execfd_requires_execute);
+	run_test("default fd close", test_default_closes_extra_fds);
+	run_test("close_range action max fd", test_close_range_max_action);
+	run_test("dup2 stdio actions", test_dup2_stdio_actions);
+	run_test("open action stdin", test_open_action_stdin);
+	run_test("fchdir action", test_fchdir_action);
+	run_test("sigmask action", test_sigmask_action);
+	run_test("sigdefault action", test_sigdefault_action);
+	run_test("inherit fds flag", test_inherit_fds_flag);
+	run_test("pidfd waitid", test_pidfd_waitid);
+	run_test("create-time actions rejected", test_create_actions_rejected);
+	run_test("script template unsupported", test_script_template_unsupported);
+	run_test("deny write while template alive",
+		 test_deny_write_while_template_alive);
+	run_test("stale path rejected", test_stale_path_rejected);
+	run_test("path replacement allows tool update",
+		 test_path_replacement_allows_tool_update);
+
+	ksft_finished();
+}
-- 
2.52.0


