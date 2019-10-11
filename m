Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F35D3713
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfJKBYo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:24:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34342 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfJKBYi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id j11so9980485wrp.1
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5eaDNBSmVXGNikxTASAAVr379HTYFLSnqmsvd9z1BGU=;
        b=eRrec1ImQliuH62wowXB3L9eORKv/H4hLSq7vSnzY29UbO6LMUTPgPeKAG3yQ6wk8o
         fnuI26sTegYYTU2C8ZBgA4HZQQvGd9TQJ6dqbnoTMCs1JVXDgggHSwDI81idQDNM9PkF
         PHlAxymV0xgiLoJ6f9gmRPZ0irafyjiwjT8GwfO4CdhJnbI9GE6DGJ7KV21aRZ9vtLl1
         jJamdHQASjrVvqZNLmvf8HAHABKG3kAQhPIiUlm9FrvanLuS3+yhO8poYGyXdWQ7UdKM
         iA/1UMVEjkf2QlMuuU6oNGmnbXAeg0Fh54i5G6esxn/ZY/gj3BVokKXenV/1ezChV8gh
         kNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5eaDNBSmVXGNikxTASAAVr379HTYFLSnqmsvd9z1BGU=;
        b=tVyWnCyDPTWOezb6O8VPRvmCl7RFiaChdp0c0Tf7yo5VI/e1c66l+o9VqmMgPXUekq
         Q0CbxUEEzTby9eKX5GL47Upt9Q7CcwbO9bC1iewCHyeqyga7UTrktQAutI4DQD9JNnou
         Cm4aquWy0bkVES6AEQaXb3LsCkeNBWMpkQ5aqKyMRaLUUD+jQMeBC+d2q8DS6sntQzxR
         c3InWlA0j4r11wEL5u+EboFJ9Zc31BGdGmDcrOquPc5uLZyhfioPJ1Jpp0PqFbcfkjdN
         /oNak9gLjUv4WDWbcVMXQP/3MY1jf2TrAut3SWvmWIQw9uOU7UtjMz+KOReu+kqpXOR4
         wEfw==
X-Gm-Message-State: APjAAAU7ovsKfZpown9M1Ta5qvheqWtkawxA73+lNlE6UHjm4W9VcQeB
        iwAVapgK3GXfn7MW4kqzGLz4EQ==
X-Google-Smtp-Source: APXvYqz5zMSvTbiDlxsAuE4LN2XRd79kPspahi+2eECJdNGxGjqw+cMSpTsRQNFOkT+7x+rzR9hMkg==
X-Received: by 2002:adf:f50a:: with SMTP id q10mr10374678wro.157.1570757076528;
        Thu, 10 Oct 2019 18:24:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:35 -0700 (PDT)
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
Subject: [PATCHv7 33/33] selftests/timens: Check for right timens offsets after fork and exec
Date:   Fri, 11 Oct 2019 02:23:41 +0100
Message-Id: <20191011012341.846266-34-dima@arista.com>
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
 1..1
 ok 1 exec
 # Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

Output on failure:
 1..1
 not ok 1 36016 16
 Bail out!

Output with lack of permissions:
 1..1
 not ok 1 # SKIP need to run as root

Output without support of time namespaces:
 1..1
 not ok 1 # SKIP Time namespaces are not supported

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |  1 +
 tools/testing/selftests/timens/Makefile   |  2 +-
 tools/testing/selftests/timens/exec.c     | 94 +++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/exec.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 16292e4d08a5..789f21e81028 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,5 @@
 clock_nanosleep
+exec
 gettime_perf
 gettime_perf_cold
 procfs
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 6aefcaccb8f4..e9fb30bd8aeb 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
new file mode 100644
index 000000000000..87b47b557a7a
--- /dev/null
+++ b/tools/testing/selftests/timens/exec.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+#define OFFSET (36000)
+
+int main(int argc, char *argv[])
+{
+	struct timespec now, tst;
+	int status, i;
+	pid_t pid;
+
+	if (argc > 1) {
+		if (sscanf(argv[1], "%ld", &now.tv_sec) != 1)
+			return pr_perror("sscanf");
+
+		for (i = 0; i < 2; i++) {
+			_gettime(CLOCK_MONOTONIC, &tst, i);
+			if (abs(tst.tv_sec - now.tv_sec) > 5)
+				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
+		}
+		return 0;
+	}
+
+	nscheck();
+
+	ksft_set_plan(1);
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+
+	if (unshare_timens())
+		return 1;
+
+	if (_settime(CLOCK_MONOTONIC, OFFSET))
+		return 1;
+
+	for (i = 0; i < 2; i++) {
+		_gettime(CLOCK_MONOTONIC, &tst, i);
+		if (abs(tst.tv_sec - now.tv_sec) > 5)
+			return pr_fail("%ld %ld\n",
+					now.tv_sec, tst.tv_sec);
+	}
+
+	if (argc > 1)
+		return 0;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("fork");
+
+	if (pid == 0) {
+		char now_str[64];
+		char *cargv[] = {"exec", now_str, NULL};
+		char *cenv[] = {NULL};
+
+		/* Check that a child process is in the new timens. */
+		for (i = 0; i < 2; i++) {
+			_gettime(CLOCK_MONOTONIC, &tst, i);
+			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+				return pr_fail("%ld %ld\n",
+						now.tv_sec + OFFSET, tst.tv_sec);
+		}
+
+		/* Check for proper vvar offsets after execve. */
+		snprintf(now_str, sizeof(now_str), "%ld", now.tv_sec + OFFSET);
+		execve("/proc/self/exe", cargv, cenv);
+		return pr_perror("execve");
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("waitpid");
+
+	if (status)
+		ksft_exit_fail();
+
+	ksft_test_result_pass("exec\n");
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.23.0

