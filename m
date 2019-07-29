Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A24D79BC4
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbfG2V6u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35563 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389294AbfG2V6u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so54776797wmg.0
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEfCJbdMxKYDawKCbJAyWHD0Eo3/cUETUwVUhZGJGmo=;
        b=D9j6Ff4c4rkh9VHKRQgUk1IM7k5ysbrhF/oCKiEguJMTZYxxjjmHxqh8lVDxVfRYmF
         ThQ0mJxr4gKdu9+twJsQKUH6rmFlLkMG1EzFQ/WXP+MuDteoDAX0oFUopwYt1vHQQqtZ
         QJm1246g0Lx/dx7NocTNWaJkqFogD0ydj6DbdnuRI3gfpHBSiAImJ/BWePgDjvFTYrN3
         Sjq57AwaYyoDE44qB2H9+SgqPjy7hbZLMAjPGfzPH5NTdb+8OjREwt63d0UBLzRm3vDA
         aKMq3EFlZKdK70EFrks//C1vLVvBmEN3BPaMJbx4o0Lfo5TTspMFDUJzPFYakzTHyBC8
         UlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEfCJbdMxKYDawKCbJAyWHD0Eo3/cUETUwVUhZGJGmo=;
        b=QahHluydoqwAuIEOnBYXNttD22JzMxyy44z9CNEs1PERWYNSf2HLrNDjy982Axbbc8
         0O1ju+/CDRUrYdvTXaWyfNuvBMApSK8wyx6yMSDANteq5WveKcfV0CqsTYHqfAhBuLFM
         CuYllgiff6KfsMrIkgxX43AtlGyj+dGGG+XQr4kGmDkdg1sihTHFJfJ016AO+i8GU3RI
         XSq4h0o1rDlw5TOIx6mGl6CKvYfW9O7O+eFtDrrax5PmR9c9ed+Y2XnJ6k4gOKa2TzrK
         TLRE65d0G9CWzmc/qkQdioI3WF1ErePEBDkQmzpjVGX+Bjg2FeuC8YxysbJdG9ApOcmE
         sabQ==
X-Gm-Message-State: APjAAAWhF8xkq2jgtNZCZYm8fE6bG9dYVxqPoYBR8PaArD5m1ijNPOMS
        OxL3xMWkgLfqo+dM0smO18fEBM64rHpvLockszVMqkrhL5Tl7T7wU1QOsjQVBwPdOFaxGNpU6IN
        632kZ4M6JwAzN8Eu0hM9glv2X7sLAp+0z8xxC8Q01px+UCzxTfHBMYE+ibwl0aVn+nYDgNqnnpk
        HJBZ+iEwFXnE8BNX1D6zCMd70dNg==
X-Google-Smtp-Source: APXvYqxDvQUc4PsZBAOd6KsnV3TljNwim5nmPju6v5/sLVVEJm4F68CmLxGjQT1h5gViuvQY2L3Rtg==
X-Received: by 2002:a1c:6643:: with SMTP id a64mr104032922wmc.154.1564437528991;
        Mon, 29 Jul 2019 14:58:48 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:48 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv5 35/37] selftest/timens: Add timer offsets test
Date:   Mon, 29 Jul 2019 22:57:17 +0100
Message-Id: <20190729215758.28405-36-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Check that timer_create() takes into account clock offsets.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   3 +-
 tools/testing/selftests/timens/timer.c    | 118 ++++++++++++++++++++++
 3 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/timer.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 94ffdd9cead7..3b7eda8f35ce 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,5 @@
 clock_nanosleep
 procfs
 timens
+timer
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index f96f50d1fef8..ae1ffd24cc43 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,5 +1,6 @@
-TEST_GEN_PROGS := timens timerfd clock_nanosleep procfs
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
 
 CFLAGS := -Wall -Werror
+LDFLAGS := -lrt
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
new file mode 100644
index 000000000000..45a9dd3cbb12
--- /dev/null
+++ b/tools/testing/selftests/timens/timer.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <signal.h>
+#include <time.h>
+
+#include "log.h"
+#include "timens.h"
+
+int run_test(int clockid, struct timespec now)
+{
+	struct itimerspec new_value;
+	long long elapsed;
+	timer_t fd;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct sigevent sevp = {.sigev_notify = SIGEV_NONE};
+		int flags = 0;
+
+		new_value.it_value.tv_sec = 3600;
+		new_value.it_value.tv_nsec = 0;
+		new_value.it_interval.tv_sec = 1;
+		new_value.it_interval.tv_nsec = 0;
+
+		if (i == 1) {
+			new_value.it_value.tv_sec += now.tv_sec;
+			new_value.it_value.tv_nsec += now.tv_nsec;
+		}
+
+		if (timer_create(clockid, &sevp, &fd) == -1)
+			return pr_perror("timerfd_create");
+
+		if (i == 1)
+			flags |= TIMER_ABSTIME;
+		if (timer_settime(fd, flags, &new_value, NULL) == -1)
+			return pr_perror("timerfd_settime");
+
+		if (timer_gettime(fd, &new_value) == -1)
+			return pr_perror("timerfd_gettime");
+
+		elapsed = new_value.it_value.tv_sec;
+		if (abs(elapsed - 3600) > 60) {
+			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
+					      clockid, elapsed);
+			return 1;
+		}
+	}
+
+	ksft_test_result_pass("clockid=%d\n", clockid);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, status, len, fd;
+	char buf[4096];
+	pid_t pid;
+	struct timespec btime_now, mtime_now;
+
+	nscheck();
+
+	ksft_set_plan(3);
+
+	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
+	clock_gettime(CLOCK_BOOTTIME, &btime_now);
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("unshare");
+
+	len = snprintf(buf, sizeof(buf), "%d %d 0\n%d %d 0",
+			CLOCK_MONOTONIC, 70 * 24 * 3600,
+			CLOCK_BOOTTIME, 9 * 24 * 3600);
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+	mtime_now.tv_sec += 70 * 24 * 3600;
+	btime_now.tv_sec += 9 * 24 * 3600;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("Unable to fork");
+	if (pid == 0) {
+		ret = 0;
+		ret |= run_test(CLOCK_BOOTTIME, btime_now);
+		ret |= run_test(CLOCK_MONOTONIC, mtime_now);
+		ret |= run_test(CLOCK_BOOTTIME_ALARM, btime_now);
+
+		if (ret)
+			ksft_exit_fail();
+		ksft_exit_pass();
+		return ret;
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Unable to wait the child process");
+
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 1;
+}
+
-- 
2.22.0

