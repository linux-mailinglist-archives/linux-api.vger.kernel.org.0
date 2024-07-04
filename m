Return-Path: <linux-api+bounces-1839-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A49927D8E
	for <lists+linux-api@lfdr.de>; Thu,  4 Jul 2024 21:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542C3285FF7
	for <lists+linux-api@lfdr.de>; Thu,  4 Jul 2024 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A5F14375C;
	Thu,  4 Jul 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="sz775JKN"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04613A252
	for <linux-api@vger.kernel.org>; Thu,  4 Jul 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119740; cv=none; b=ZzQeMmdCwHzubs9IH7JlYc7n1S+xv6j88C8BCkeMW2wSkriMQIctbVTd3fvkBirSDJVROPXWTj+kqGEJt4chH1kWEwLZVuDJ/7g59pdxMFwJewBEP5tzl+jpb+hHRuKukurUDc2QvdeBxYOtBZvxb3Xb084ap135GtBg/SGKqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119740; c=relaxed/simple;
	bh=oF6rZ0nuBxG6YDixlM9cat48r0Oum2JdP1zOs4FQ5/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaMys/Qf01ePkhYjCnELFvcfdtVpgkfzqIp/TJuUGS9i4dixkG6j88HQD8iyez8wnvfZDySSSPODHDnJaC7471z/Vk0I6Ezqd8k/6t+w2XIf9WHwXOgu8DQ98ZNLYZ2Bwuz3l4Kg7wvcl2u4D8I8QEEqjM0WU+U30SuCPY0w0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=sz775JKN; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WFQxd4WXSz114p;
	Thu,  4 Jul 2024 21:02:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720119733;
	bh=v0fxaXOdLtc/Ju12bV32vY14OcdVSThIgNKjl9+i++A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sz775JKNODOr34yQ+Cv6KYcDvi+5ptHtkytGJ4G92ILUZoxk4zmBBIN1RY/1M1tms
	 ZO3bjuRTATAsvIlizxMEmtFYYYIpG6mKsV5ckhQqA6RKyNXIXh9DUoYxtxxVrb/Yc1
	 MGjtdlShlQavT56SM7tKhkep7CajraMh20U4V77E=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WFQxc5zxzzTK7;
	Thu,  4 Jul 2024 21:02:12 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	Theodore Ts'o <tytso@mit.edu>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alejandro Colomar <alx.manpages@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v19 5/5] samples/should-exec: Add set-should-exec
Date: Thu,  4 Jul 2024 21:01:37 +0200
Message-ID: <20240704190137.696169-6-mic@digikod.net>
In-Reply-To: <20240704190137.696169-1-mic@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a simple tool to set SECBIT_SHOULD_EXEC_CHECK,
SECBIT_SHOULD_EXEC_RESTRICT, and their lock counterparts before
executing a command.  This should be useful to easily test against
script interpreters.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240704190137.696169-6-mic@digikod.net
---
 samples/Kconfig                       |  7 +++
 samples/Makefile                      |  1 +
 samples/should-exec/.gitignore        |  1 +
 samples/should-exec/Makefile          | 13 ++++
 samples/should-exec/set-should-exec.c | 88 +++++++++++++++++++++++++++
 5 files changed, 110 insertions(+)
 create mode 100644 samples/should-exec/.gitignore
 create mode 100644 samples/should-exec/Makefile
 create mode 100644 samples/should-exec/set-should-exec.c

diff --git a/samples/Kconfig b/samples/Kconfig
index b288d9991d27..d8f2639bc830 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -180,6 +180,13 @@ config SAMPLE_SECCOMP
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
 
+config SAMPLE_SHOULD_EXEC
+	bool "Should-exec secure bits examples"
+	depends on CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  Build a tool to easily configure SECBIT_SHOULD_EXEC_CHECK,
+	  SECBIT_SHOULD_EXEC_RESTRICT and their lock counterparts.
+
 config SAMPLE_TIMER
 	bool "Timer sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..0e7a97fb222d 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -19,6 +19,7 @@ subdir-$(CONFIG_SAMPLE_PIDFD)		+= pidfd
 obj-$(CONFIG_SAMPLE_QMI_CLIENT)		+= qmi/
 obj-$(CONFIG_SAMPLE_RPMSG_CLIENT)	+= rpmsg/
 subdir-$(CONFIG_SAMPLE_SECCOMP)		+= seccomp
+subdir-$(CONFIG_SAMPLE_SHOULD_EXEC)	+= should-exec
 subdir-$(CONFIG_SAMPLE_TIMER)		+= timers
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS) += trace_events/
diff --git a/samples/should-exec/.gitignore b/samples/should-exec/.gitignore
new file mode 100644
index 000000000000..ac46c614ec80
--- /dev/null
+++ b/samples/should-exec/.gitignore
@@ -0,0 +1 @@
+/set-should-exec
diff --git a/samples/should-exec/Makefile b/samples/should-exec/Makefile
new file mode 100644
index 000000000000..c4294278dd07
--- /dev/null
+++ b/samples/should-exec/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: BSD-3-Clause
+
+userprogs-always-y := set-should-exec
+
+userccflags += -I usr/include
+
+.PHONY: all clean
+
+all:
+	$(MAKE) -C ../.. samples/should-exec/
+
+clean:
+	$(MAKE) -C ../.. M=samples/should-exec/ clean
diff --git a/samples/should-exec/set-should-exec.c b/samples/should-exec/set-should-exec.c
new file mode 100644
index 000000000000..b3c31106d916
--- /dev/null
+++ b/samples/should-exec/set-should-exec.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Simple tool to set SECBIT_SHOULD_EXEC_CHECK,  SECBIT_SHOULD_EXEC_RESTRICT,
+ * and their lock counterparts before executing a command.
+ *
+ * Copyright © 2024 Microsoft Corporation
+ */
+
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+#include <errno.h>
+#include <linux/prctl.h>
+#include <linux/securebits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+
+static void print_usage(const char *argv0)
+{
+	fprintf(stderr, "usage: %s -c|-r [-l] -- <cmd> [args]...\n\n", argv0);
+	fprintf(stderr, "Execute a command with\n");
+	fprintf(stderr, "- SECBIT_SHOULD_EXEC_CHECK set: -c\n");
+	fprintf(stderr, "- SECBIT_SHOULD_EXEC_RESTRICT set: -r\n");
+	fprintf(stderr, "- SECBIT_SHOULD_EXEC_*_LOCKED set: -l\n");
+}
+
+int main(const int argc, char *const argv[], char *const *const envp)
+{
+	const char *cmd_path;
+	char *const *cmd_argv;
+	int opt, secbits, err;
+	bool has_policy = false;
+
+	secbits = prctl(PR_GET_SECUREBITS);
+
+	while ((opt = getopt(argc, argv, "crl")) != -1) {
+		switch (opt) {
+		case 'c':
+			secbits |= SECBIT_SHOULD_EXEC_CHECK;
+			has_policy = true;
+			break;
+		case 'r':
+			secbits |= SECBIT_SHOULD_EXEC_RESTRICT;
+			has_policy = true;
+			break;
+		case 'l':
+			secbits |= SECBIT_SHOULD_EXEC_CHECK_LOCKED;
+			secbits |= SECBIT_SHOULD_EXEC_RESTRICT_LOCKED;
+			break;
+		default:
+			print_usage(argv[0]);
+			return 1;
+		}
+	}
+
+	if (!argv[optind] || !has_policy) {
+		print_usage(argv[0]);
+		return 1;
+	}
+
+	err = prctl(PR_SET_SECUREBITS, secbits);
+	if (err) {
+		perror("Failed to set secure bit(s).");
+		fprintf(stderr,
+			"Hint: The running kernel may not support this feature.\n");
+		return 1;
+	}
+
+	fprintf(stderr, "SECBIT_SHOULD_EXEC_CHECK: %d\n",
+		!!(secbits & SECBIT_SHOULD_EXEC_CHECK));
+	fprintf(stderr, "SECBIT_SHOULD_EXEC_CHECK_LOCKED: %d\n",
+		!!(secbits & SECBIT_SHOULD_EXEC_CHECK_LOCKED));
+	fprintf(stderr, "SECBIT_SHOULD_EXEC_RESTRICT: %d\n",
+		!!(secbits & SECBIT_SHOULD_EXEC_RESTRICT));
+	fprintf(stderr, "SECBIT_SHOULD_EXEC_RESTRICT_LOCKED: %d\n",
+		!!(secbits & SECBIT_SHOULD_EXEC_RESTRICT_LOCKED));
+
+	cmd_path = argv[optind];
+	cmd_argv = argv + optind;
+	fprintf(stderr, "Executing command...\n");
+	execvpe(cmd_path, cmd_argv, envp);
+	fprintf(stderr, "Failed to execute \"%s\": %s\n", cmd_path,
+		strerror(errno));
+	return 1;
+}
-- 
2.45.2


