Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2DD8D3715
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfJKBYt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:24:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40306 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfJKBYh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so9971943wrv.7
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIsTBOVrc7i/Xt/PebQI+G9Xq4ESkiGEHrzlkhmObOg=;
        b=niIziy2dvEqI1eSF09ev12bj3hVTbqP7sAX8FuSapDxJO+pFRWuvWstoPX/1MvlSFj
         21rUWUra9/nyAlbIBI26ao7u2WXM4D8yMTf9jsevT8vVuUepwBr9TvOUy7dMQNUKllpA
         rnUPCM4JQSYLL2XW75NLp4RAwyFVNPqoQP7uOO3XLaUwXEtGj/WZNFFlVbKFT9sAZ2i8
         fTyye+gThrTdz0VUtQQ9N05DDVq7SE9+kathZHG59s8m5TEl8yN1f1Pf4Sh4jaFYC/lM
         IkavpmShCmCQUK1jr1GZyXTdL38QJWldmRa6RgJFKYT+NymWGuWdD3uKnRylsCktOXRw
         Wjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIsTBOVrc7i/Xt/PebQI+G9Xq4ESkiGEHrzlkhmObOg=;
        b=V0kJyS5JxLH+22rhUulTvx4z0m3gV30Cn5og+WwFQ94jn5ur036z8ii8T3T6Bhy7XV
         vK07x4Jx+1zhIz+cih1iflCZ2ak2W6qm7IaUNdAoJGaois3igGKTJOUXj4dXEjRL/xA6
         UenOeVE5mUsVEur+G0iF0Sv19Ci/v2tpx7DL34mYiisIA3y0b5HzkqKPgIky553lySPm
         jDFPmCp43d8KBEEeW01FS6xxxrlCtAcASX6lPoAgHbK/Wa5E63pnGxLOWu/NA3yK6WbI
         bpUzU2eNoCYjAnJOyK0YhepO3asGYH9RVA6ts7td52tJCRtmLRuW7rW/JbUTQo16Jvi0
         cnJQ==
X-Gm-Message-State: APjAAAUx9180zrJU8KQM1PdkBaerSFBE5iMnuTnJXrQ2rdVSRCKTCRyP
        PHCq6bwkljYshJtqVhBD5ArvmQ==
X-Google-Smtp-Source: APXvYqw8Rk7g6c4ujkhI0gg5hVFNwCCkxVbuspM0KC8of90Nal7teSaPqjNqiDCBAbdWZJfYf8AGow==
X-Received: by 2002:a5d:5309:: with SMTP id e9mr11386177wrv.276.1570757074900;
        Thu, 10 Oct 2019 18:24:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:34 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv7 32/33] selftests/timens: Add a simple perf test for clock_gettime()
Date:   Fri, 11 Oct 2019 02:23:40 +0100
Message-Id: <20191011012341.846266-33-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Output on success:
1..4
 ok 1 host:	clock:  monotonic	cycles:	 148323947
 ok 2 host:	clock:   boottime	cycles:	 148577503
 ok 3 ns:	clock:  monotonic	cycles:	 137659217
 ok 4 ns:	clock:   boottime	cycles:	 137959154
 # Pass 4 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

Output with lack of permissions:
 1..4
 ok 1 host:	clock:  monotonic	cycles:	 145671139
 ok 2 host:	clock:   boottime	cycles:	 146958357
 not ok 3 # SKIP need to run as root

Output without support of time namespaces:
 1..4
 ok 1 host:	clock:  monotonic	cycles:	 145671139
 ok 2 host:	clock:   boottime	cycles:	 146958357
 not ok 3 # SKIP Time namespaces are not supported

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore     |  2 +
 tools/testing/selftests/timens/Makefile       |  3 +-
 tools/testing/selftests/timens/gettime_perf.c | 91 +++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/gettime_perf.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 3b7eda8f35ce..16292e4d08a5 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,6 @@
 clock_nanosleep
+gettime_perf
+gettime_perf_cold
 procfs
 timens
 timer
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 08164548a49d..6aefcaccb8f4 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,6 +1,7 @@
 TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
+TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
-LDFLAGS := -lrt
+LDFLAGS := -lrt -ldl
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
new file mode 100644
index 000000000000..3a6d9c485de5
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <dlfcn.h>
+
+#include "log.h"
+#include "timens.h"
+
+typedef int (*vgettime_t)(clockid_t, struct timespec *);
+
+vgettime_t vdso_clock_gettime;
+
+static void fill_function_pointers(void)
+{
+	void *vdso = dlopen("linux-vdso.so.1",
+			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso)
+		vdso = dlopen("linux-gate.so.1",
+			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso) {
+		pr_err("[WARN]\tfailed to find vDSO\n");
+		return;
+	}
+
+	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
+	if (!vdso_clock_gettime)
+		pr_err("Warning: failed to find clock_gettime in vDSO\n");
+
+}
+
+static void test(clock_t clockid, char *clockstr, bool in_ns)
+{
+	struct timespec tp, start;
+	long i = 0;
+	const int timeout = 3;
+
+	vdso_clock_gettime(clockid, &start);
+	tp = start;
+	for (tp = start; start.tv_sec + timeout > tp.tv_sec ||
+			 (start.tv_sec + timeout == tp.tv_sec &&
+			  start.tv_nsec > tp.tv_nsec); i++) {
+		vdso_clock_gettime(clockid, &tp);
+	}
+
+	ksft_test_result_pass("%s:\tclock: %10s\tcycles:\t%10ld\n",
+			      in_ns ? "ns" : "host", clockstr, i);
+}
+
+int main(int argc, char *argv[])
+{
+	time_t offset = 10;
+	int nsfd;
+
+	ksft_set_plan(4);
+
+	fill_function_pointers();
+
+	test(CLOCK_MONOTONIC, "monotonic", false);
+	test(CLOCK_BOOTTIME, "boottime", false);
+
+	nscheck();
+
+	if (unshare_timens())
+		return 1;
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Can't open a time namespace");
+
+	if (_settime(CLOCK_MONOTONIC, offset))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, offset))
+		return 1;
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("setns");
+
+	test(CLOCK_MONOTONIC, "monotonic", true);
+	test(CLOCK_BOOTTIME, "boottime", true);
+
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.23.0

