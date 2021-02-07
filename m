Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C283122AF
	for <lists+linux-api@lfdr.de>; Sun,  7 Feb 2021 09:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhBGI30 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 03:29:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12472 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhBGI1H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Feb 2021 03:27:07 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYMf65ntqzjKdf;
        Sun,  7 Feb 2021 16:25:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 16:26:16 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     <gregkh@linuxfoundation.org>, <song.bao.hua@hisilicon.com>,
        <jgg@ziepe.ca>, <kevin.tian@intel.com>, <jean-philippe@linaro.org>,
        <eric.auger@redhat.com>, <liguozhu@hisilicon.com>,
        <zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [RFC PATCH v3 2/2] selftests/vm: add mempinfd test
Date:   Sun, 7 Feb 2021 16:18:04 +0800
Message-ID: <1612685884-19514-3-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This test gets a fd from new mempinfd syscall and creates multiple threads
to do pin/unpin memory.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Suggested-by: Barry Song <song.bao.hua@hisilicon.com>
---
 tools/testing/selftests/vm/Makefile   |   1 +
 tools/testing/selftests/vm/mempinfd.c | 131 ++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mempinfd.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index d42115e..2d5b509 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -42,6 +42,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_FILES += mempinfd
 
 ifeq ($(MACHINE),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
diff --git a/tools/testing/selftests/vm/mempinfd.c b/tools/testing/selftests/vm/mempinfd.c
new file mode 100644
index 0000000..51d5cbf
--- /dev/null
+++ b/tools/testing/selftests/vm/mempinfd.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021 HiSilicon Limited. */
+#define _GNU_SOURCE
+#include <linux/mempinfd.h>
+#include <malloc.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+
+#include "../kselftest.h"
+
+#ifdef __NR_mempinfd
+
+#define DEF_PIN_SIZE		(4096 * 1024)
+#define MAX_THREAD_NUM		20
+#define DEF_THREAD_NUM		1
+#define DEF_TIMES		10000
+
+struct test_data {
+	int fd;
+	unsigned long mem_size;
+	unsigned long times;
+};
+
+static void *do_pin_test(void *data)
+{
+	struct mem_pin_address addr;
+	struct test_data *d = data;
+	unsigned long times;
+	int ret, fd;
+	int i = 0;
+	void *p;
+
+	p = malloc(d->mem_size);
+	if (!p) {
+		fprintf(stderr, "fail to allocate memory\n");
+		return NULL;
+	}
+
+	addr.addr = (__u64)p;
+	addr.size = d->mem_size;
+	times = d->mem_size;
+	fd = d->fd;
+
+	while (i++ < times) {
+		ret = ioctl(fd, MEM_CMD_PIN, &addr);
+		if (ret) {
+			fprintf(stderr, "fail to pin memory\n");
+			return NULL;
+		}
+
+		usleep(1000);
+
+		ret = ioctl(fd, MEM_CMD_UNPIN, &addr);
+		if (ret) {
+			fprintf(stderr, "fail to unpin memory\n");
+			return NULL;
+		}
+	}
+
+	free(p);
+
+	return NULL;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long thread_num = DEF_THREAD_NUM;
+	unsigned long mem_size = DEF_PIN_SIZE;
+	unsigned long times = DEF_TIMES;
+	pthread_t threads[MAX_THREAD_NUM];
+	struct test_data data;
+	int fd, opt, i;
+	int ret = 0;
+
+	while ((opt = getopt(argc, argv, "s:n:t:")) != -1) {
+		switch (opt) {
+		case 's':
+			mem_size = atoi(optarg);
+			break;
+		case 'n':
+			thread_num = atoi(optarg);
+			if (thread_num > MAX_THREAD_NUM)
+				return -1;
+			break;
+		case 't':
+			times = atoi(optarg);
+			break;
+		default:
+			return -1;
+		}
+	}
+
+	fd = syscall(__NR_mempinfd);
+	if (fd < 0) {
+		fprintf(stderr, "mempinfd syscall not available in this kernel\n");
+		return -1;
+	}
+
+	data.fd = fd;
+	data.mem_size = mem_size;
+	data.times = times;
+
+	for (i = 0; i < thread_num; i++) {
+		ret = pthread_create(&threads[i], NULL, do_pin_test, &data);
+		if (ret) {
+			fprintf(stderr, "fail to create thread %d: %d\n",
+				i, -errno);
+			return -1;
+		}
+	}
+
+	for (i = 0; i < thread_num; i++)
+		pthread_join(threads[i], NULL);
+
+	close(fd);
+
+	return 0;
+}
+
+#else /* __NR_mempinfd */
+
+#warning "missing __NR_mempinfd definition"
+int main(void)
+{
+	printf("skip: Skipping mempinfd test (missing __NR_mempinfd)\n");
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_mempinfd */
-- 
2.8.1

