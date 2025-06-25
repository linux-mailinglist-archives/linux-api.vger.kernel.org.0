Return-Path: <linux-api+bounces-4016-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A78AE9275
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 01:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEDC6A742A
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 23:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A112F0E20;
	Wed, 25 Jun 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Q7H9h6Lq"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C72E5418
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893564; cv=none; b=I0gViUguYIoP9PTlqW9NtDLqCbPZwwYxOa4Ftoq/SodBgbxryZGxWXNAVdiQdj8fZysNh2hOQnOxpQASvE6tAJ/hGkay7UfccvtmHnZxrD0cwyfuF/3Z2rb3mU71NUAo31opxxI1oX2H6olsQSzDUhZFU8LF8d5TZkM79oXmud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893564; c=relaxed/simple;
	bh=LTvazaelJup2RLQo0+ts/x55y7xfpD3AP0z69NBtyJ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3Gm7IsoAp0lKMix8nA6lniitB60vQsiTSY2r5NadzmNBcBEruUIcjhrwRPTrb0ZNi2Xo4+luHBkpi1Ht6Dx05gFIc1nKWq1wbNDuJgsRgPtS3WLBOPrdWJsziZ62+G9guEv3DxM+fB2Cmd+kW9wqSFcbzalZqR01byBvEYFJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Q7H9h6Lq; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e818a572828so238703276.1
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893561; x=1751498361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWmBXVjGh1wc/IzDBDeCQXSx4hXhB+JQyCN77jCTWMc=;
        b=Q7H9h6LqYz7v2wW+2W7SglfaHtpTzorNxzdTRDybawToastYUJWYH4/tOqEng5EaTY
         UmOdT+NFbNaVAX9ixdwql0b6IraYFsQdqO+QyHkLm1mGzlfCT2PiBQdmZb3/vwh6I1VF
         6Z/H4kpRTDmQLkI5stkdDuRe/OTEzlK9KbPOjcBVr9T70S42xR+WfOkE2PELnzgvV9Zz
         3iC2n+UCuyIXZyXz7Yx3nDzhQ0Je/HiKWzwmTidkEhqSE+gkNn/uDDfcwaf9IxrcUIm5
         Gov5anUqooxNJ749XrfzMJj+jOVaUKGG5ir2eMKF4fqct/OFLTEtJCYFy8QC0KydXEr6
         4Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893561; x=1751498361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWmBXVjGh1wc/IzDBDeCQXSx4hXhB+JQyCN77jCTWMc=;
        b=T9xietBO4c8dOeUw1eyPkFhqJscXSvSMu4gZskoSYteLL5qoAjWfS2RLb6DPt3knaC
         l06m0qOPuwGy10hM2w4MrU6cHK9r868nXQh29aaTYQtk3ojgHzObnf4q/PMP+qj5XeEv
         tNYauHeKEB1LZRPKCxuN7Jy42GQAZcv4BqtqET7Xef6dpAEEmy1oU8FXebLHdCaanVxX
         dd5Wy9sJb9s/q0TC6S232ma4yURKcxSSYkuD3kJexLLMmWDEE0ylxdTZwWc9D2XksApF
         MgdANXLQYTLUK/yRD6W7UvuKThd4FxIVACIKnAU8u3IC0mTs5bkPTVpY401jrinqLc2D
         tKjg==
X-Forwarded-Encrypted: i=1; AJvYcCVopjPUfijYSCEkMTHznQ7NkFWuTRnGS44OzwJw//OxtmV1zKJYKkv9GfSf70x8K79ZSos1s5/yiFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjcxw3j57EpoI/VmNll+J4TD5NNWp8Kl4oN7yn5BLa9Ts4eMxJ
	VwnsbAfeVmICDaX+B1gLoyNx8VoHSVeZxxw+1ucocPr2m1nLRqTO6KRLDXhAWZJhXlo=
X-Gm-Gg: ASbGncviXj415JGY99hww2SUGC/m78WBcjsUbSmnb/0evG7XihTrCx7wKNxapeGhz0g
	XIBOskyXh6SNiVPlH+amj8rRl8VSHanzJwisvB7YSrYTHz1eXjkqPzlK4D+RkgXICSVO5Tu2tI2
	aHZKpsE1OlCSgHNLWBmd4NsbzOa1bdC0tbnoL4fV6pwbSDlo4E7pMcTbg4uQxOBdOUZBtND0WBX
	ikU4s6T5bcO7c1i8jmm7AVj1K3sJQSiQ9RNh7gnN2amJrlQ4Z958D3yJRX0+M2QAdXcNxefEX2B
	t3ifVdIwXk0y1q8YzTjsG4e0NwFzANnA+ZHBIcWdvrmi7GZccOsjIWUCLlMCjmJZcMnp+T16Oul
	3qz083+/4Vnh3bfKg7L2X9HOST6j7fiVttQbC2BS8ZYps9qB02sPC
X-Google-Smtp-Source: AGHT+IHBhcERB5WpXtZntroBtxeP7CadGo0+bxbFMxveWkVBexE1WcbHGf8ep4HdbuKr8YEvROFMiA==
X-Received: by 2002:a05:6902:1609:b0:e84:4aef:49f4 with SMTP id 3f1490d57ef6-e86016eeaf5mr7008558276.13.1750893561443;
        Wed, 25 Jun 2025 16:19:21 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:20 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 22/32] selftests/liveupdate: add subsystem/state tests
Date: Wed, 25 Jun 2025 23:18:09 +0000
Message-ID: <20250625231838.1897085-23-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces a new set of userspace selftests for the LUO. These tests
verify the functionality LUO by using the kernel-side selftest ioctls
provided by the LUO module, primarily focusing on subsystem management
and basic LUO state transitions.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |   7 +
 tools/testing/selftests/liveupdate/config     |   6 +
 .../testing/selftests/liveupdate/liveupdate.c | 356 ++++++++++++++++++
 5 files changed, 371 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/.gitignore
 create mode 100644 tools/testing/selftests/liveupdate/Makefile
 create mode 100644 tools/testing/selftests/liveupdate/config
 create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 339b31e6a6b5..d8fc84ccac32 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -53,6 +53,7 @@ TARGETS += kvm
 TARGETS += landlock
 TARGETS += lib
 TARGETS += livepatch
+TARGETS += liveupdate
 TARGETS += lkdtm
 TARGETS += lsm
 TARGETS += membarrier
diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testing/selftests/liveupdate/.gitignore
new file mode 100644
index 000000000000..af6e773cf98f
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/.gitignore
@@ -0,0 +1 @@
+/liveupdate
diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
new file mode 100644
index 000000000000..2a573c36016e
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -Wall -O2 -Wno-unused-function
+CFLAGS += $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS += liveupdate
+
+include ../lib.mk
diff --git a/tools/testing/selftests/liveupdate/config b/tools/testing/selftests/liveupdate/config
new file mode 100644
index 000000000000..382c85b89570
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/config
@@ -0,0 +1,6 @@
+CONFIG_KEXEC_FILE=y
+CONFIG_KEXEC_HANDOVER=y
+CONFIG_KEXEC_HANDOVER_DEBUG=y
+CONFIG_LIVEUPDATE=y
+CONFIG_LIVEUPDATE_SYSFS_API=y
+CONFIG_LIVEUPDATE_SELFTESTS=y
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
new file mode 100644
index 000000000000..989a9a67d4cf
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/liveupdate.h>
+
+#include "../kselftest.h"
+#include "../kselftest_harness.h"
+#include "../../../../kernel/liveupdate/luo_selftests.h"
+
+struct subsystem_info {
+	void *data_page;
+	void *verify_page;
+	char test_name[LUO_NAME_LENGTH];
+	bool registered;
+};
+
+FIXTURE(subsystem) {
+	int fd;
+	int fd_dbg;
+	struct subsystem_info si[LUO_MAX_SUBSYSTEMS];
+};
+
+FIXTURE(state) {
+	int fd;
+	int fd_dbg;
+};
+
+#define LUO_DEVICE	"/dev/liveupdate"
+#define LUO_DBG_DEVICE	"/sys/kernel/debug/liveupdate/luo_selftest"
+#define LUO_SYSFS_STATE	"/sys/kernel/liveupdate/state"
+static size_t page_size;
+
+const char *const luo_state_str[] = {
+	[LIVEUPDATE_STATE_UNDEFINED]   = "undefined",
+	[LIVEUPDATE_STATE_NORMAL]   = "normal",
+	[LIVEUPDATE_STATE_PREPARED] = "prepared",
+	[LIVEUPDATE_STATE_FROZEN]   = "frozen",
+	[LIVEUPDATE_STATE_UPDATED]  = "updated",
+};
+
+static int run_luo_selftest_cmd(int fd_dbg, __u64 cmd_code,
+				struct luo_arg_subsystem *subsys_arg)
+{
+	struct liveupdate_selftest k_arg;
+
+	k_arg.cmd = cmd_code;
+	k_arg.arg = (__u64)(unsigned long)subsys_arg;
+
+	return ioctl(fd_dbg, LIVEUPDATE_IOCTL_SELFTESTS, &k_arg);
+}
+
+static int register_subsystem(int fd_dbg, struct subsystem_info *si)
+{
+	struct luo_arg_subsystem subsys_arg;
+	int ret;
+
+	memset(&subsys_arg, 0, sizeof(subsys_arg));
+	snprintf(subsys_arg.name, LUO_NAME_LENGTH, "%s", si->test_name);
+	subsys_arg.data_page = si->data_page;
+
+	ret = run_luo_selftest_cmd(fd_dbg, LUO_CMD_SUBSYSTEM_REGISTER,
+				   &subsys_arg);
+	if (!ret)
+		si->registered = true;
+
+	return ret;
+}
+
+static int unregister_subsystem(int fd_dbg, struct subsystem_info *si)
+{
+	struct luo_arg_subsystem subsys_arg;
+	int ret;
+
+	memset(&subsys_arg, 0, sizeof(subsys_arg));
+	snprintf(subsys_arg.name, LUO_NAME_LENGTH, "%s", si->test_name);
+
+	ret = run_luo_selftest_cmd(fd_dbg, LUO_CMD_SUBSYSTEM_UNREGISTER,
+				   &subsys_arg);
+	if (!ret)
+		si->registered = false;
+
+	return ret;
+}
+
+static int get_sysfs_state(void)
+{
+	char buf[64];
+	ssize_t len;
+	int fd, i;
+
+	fd = open(LUO_SYSFS_STATE, O_RDONLY);
+	if (fd < 0) {
+		ksft_print_msg("Failed to open sysfs state file '%s': %s\n",
+			       LUO_SYSFS_STATE, strerror(errno));
+		return -errno;
+	}
+
+	len = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+
+	if (len <= 0) {
+		ksft_print_msg("Failed to read sysfs state file '%s': %s\n",
+			       LUO_SYSFS_STATE, strerror(errno));
+		return -errno;
+	}
+	if (buf[len - 1] == '\n')
+		buf[len - 1] = '\0';
+	else
+		buf[len] = '\0';
+
+	for (i = 0; i < ARRAY_SIZE(luo_state_str); i++) {
+		if (!strcmp(buf, luo_state_str[i]))
+			return i;
+	}
+
+	return -EIO;
+}
+
+FIXTURE_SETUP(state)
+{
+	int state;
+
+	page_size = sysconf(_SC_PAGE_SIZE);
+	self->fd = open(LUO_DEVICE, O_RDWR);
+	if (self->fd < 0)
+		SKIP(return, "open(%s) failed [%d]", LUO_DEVICE, errno);
+
+	self->fd_dbg = open(LUO_DBG_DEVICE, O_RDWR);
+	ASSERT_GE(self->fd_dbg, 0);
+
+	state = get_sysfs_state();
+	if (state < 0) {
+		if (state == -ENOENT || state == -EACCES)
+			SKIP(return, "sysfs state not accessible (%d)", state);
+	}
+}
+
+FIXTURE_TEARDOWN(state)
+{
+	enum liveupdate_state state = LIVEUPDATE_STATE_NORMAL;
+
+	ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &state);
+	if (state != LIVEUPDATE_STATE_NORMAL)
+		ioctl(self->fd, LIVEUPDATE_IOCTL_CANCEL, NULL);
+	close(self->fd);
+}
+
+FIXTURE_SETUP(subsystem)
+{
+	int i;
+
+	page_size = sysconf(_SC_PAGE_SIZE);
+	memset(&self->si, 0, sizeof(self->si));
+	self->fd = open(LUO_DEVICE, O_RDWR);
+	if (self->fd < 0)
+		SKIP(return, "open(%s) failed [%d]", LUO_DEVICE, errno);
+
+	self->fd_dbg = open(LUO_DBG_DEVICE, O_RDWR);
+	ASSERT_GE(self->fd_dbg, 0);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++) {
+		snprintf(self->si[i].test_name, LUO_NAME_LENGTH,
+			 NAME_NORMAL ".%d", i);
+
+		self->si[i].data_page = mmap(NULL, page_size,
+					     PROT_READ | PROT_WRITE,
+					     MAP_PRIVATE | MAP_ANONYMOUS,
+					     -1, 0);
+		ASSERT_NE(MAP_FAILED, self->si[i].data_page);
+		memset(self->si[i].data_page, 'A' + i, page_size);
+
+		self->si[i].verify_page = mmap(NULL, page_size,
+					       PROT_READ | PROT_WRITE,
+					       MAP_PRIVATE | MAP_ANONYMOUS,
+					       -1, 0);
+		ASSERT_NE(MAP_FAILED, self->si[i].verify_page);
+		memset(self->si[i].verify_page, 0, page_size);
+	}
+}
+
+FIXTURE_TEARDOWN(subsystem)
+{
+	enum liveupdate_state state = LIVEUPDATE_STATE_NORMAL;
+	int i;
+
+	ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &state);
+	if (state != LIVEUPDATE_STATE_NORMAL)
+		ioctl(self->fd, LIVEUPDATE_IOCTL_CANCEL, NULL);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++) {
+		if (self->si[i].registered)
+			unregister_subsystem(self->fd_dbg, &self->si[i]);
+		munmap(self->si[i].data_page, page_size);
+		munmap(self->si[i].verify_page, page_size);
+	}
+
+	close(self->fd);
+}
+
+TEST_F(state, normal)
+{
+	enum liveupdate_state state;
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &state));
+	ASSERT_EQ(state, LIVEUPDATE_STATE_NORMAL);
+}
+
+TEST_F(state, prepared)
+{
+	enum liveupdate_state state;
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_PREPARE, NULL));
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &state));
+	ASSERT_EQ(state, LIVEUPDATE_STATE_PREPARED);
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_CANCEL, NULL));
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &state));
+	ASSERT_EQ(state, LIVEUPDATE_STATE_NORMAL);
+}
+
+TEST_F(state, sysfs_normal)
+{
+	ASSERT_EQ(LIVEUPDATE_STATE_NORMAL, get_sysfs_state());
+}
+
+TEST_F(state, sysfs_prepared)
+{
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_PREPARE, NULL));
+	ASSERT_EQ(LIVEUPDATE_STATE_PREPARED, get_sysfs_state());
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_CANCEL, NULL));
+	ASSERT_EQ(LIVEUPDATE_STATE_NORMAL, get_sysfs_state());
+}
+
+TEST_F(state, sysfs_frozen)
+{
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_PREPARE, NULL));
+
+	ASSERT_EQ(LIVEUPDATE_STATE_PREPARED, get_sysfs_state());
+
+	ASSERT_EQ(0, ioctl(self->fd_dbg, LIVEUPDATE_IOCTL_FREEZE, NULL));
+	ASSERT_EQ(LIVEUPDATE_STATE_FROZEN, get_sysfs_state());
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_CANCEL, NULL));
+	ASSERT_EQ(LIVEUPDATE_STATE_NORMAL, get_sysfs_state());
+}
+
+TEST_F(subsystem, register_unregister)
+{
+	ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[0]));
+	ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[0]));
+}
+
+TEST_F(subsystem, double_unregister)
+{
+	ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[0]));
+	ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[0]));
+	EXPECT_NE(0, unregister_subsystem(self->fd_dbg, &self->si[0]));
+	EXPECT_TRUE(errno == EINVAL || errno == ENOENT);
+}
+
+TEST_F(subsystem, register_unregister_many)
+{
+	int i;
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[i]));
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
+}
+
+TEST_F(subsystem, getdata_verify)
+{
+	enum liveupdate_state state;
+	int i;
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[i]));
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_PREPARE, NULL));
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &state));
+	ASSERT_EQ(state, LIVEUPDATE_STATE_PREPARED);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++) {
+		struct luo_arg_subsystem subsys_arg;
+
+		memset(&subsys_arg, 0, sizeof(subsys_arg));
+		snprintf(subsys_arg.name, LUO_NAME_LENGTH, "%s",
+			 self->si[i].test_name);
+		subsys_arg.data_page = self->si[i].verify_page;
+
+		ASSERT_EQ(0, run_luo_selftest_cmd(self->fd_dbg,
+						  LUO_CMD_SUBSYSTEM_GETDATA,
+						  &subsys_arg));
+		ASSERT_EQ(0, memcmp(self->si[i].data_page,
+				    self->si[i].verify_page,
+				    page_size));
+	}
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_CANCEL, NULL));
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &state));
+	ASSERT_EQ(state, LIVEUPDATE_STATE_NORMAL);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
+}
+
+TEST_F(subsystem, prepare_fail)
+{
+	int i;
+
+	snprintf(self->si[LUO_MAX_SUBSYSTEMS - 1].test_name, LUO_NAME_LENGTH,
+		 NAME_PREPARE_FAIL ".%d", LUO_MAX_SUBSYSTEMS - 1);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[i]));
+
+	ASSERT_EQ(-1, ioctl(self->fd, LIVEUPDATE_IOCTL_PREPARE, NULL));
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
+
+	snprintf(self->si[LUO_MAX_SUBSYSTEMS - 1].test_name, LUO_NAME_LENGTH,
+		 NAME_NORMAL ".%d", LUO_MAX_SUBSYSTEMS - 1);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[i]));
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_PREPARE, NULL));
+	ASSERT_EQ(0, ioctl(self->fd_dbg, LIVEUPDATE_IOCTL_FREEZE, NULL));
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_CANCEL, NULL));
+	ASSERT_EQ(LIVEUPDATE_STATE_NORMAL, get_sysfs_state());
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
+}
+
+TEST_HARNESS_MAIN
-- 
2.50.0.727.gbf7dc18ff4-goog


