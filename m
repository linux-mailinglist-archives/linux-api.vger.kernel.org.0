Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5A1FAA62
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgFPHuA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgFPHtu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 03:49:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3BEC08C5D1
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 00:49:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d8so8013493plo.12
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 00:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wt0dnmhR56V/P6llfsBTHQQvjngTx36J9Qjg5uVymmU=;
        b=IaxMJQ7nBNiW5yMR3uEv+C0sfD9cWFXioN0idRkD1TyTDHTD3tjSieVkLQPYYJXrN9
         UG6DPRLyd6b0Nkl+H0xAFSlOV80Bgr+l1zUu6QPhgWP8WQRiciWN8PPoIcTdZS1q5VcL
         Z/2hOwYi9tyaYY0xQbA4ecFT+gFRiaKCQId3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wt0dnmhR56V/P6llfsBTHQQvjngTx36J9Qjg5uVymmU=;
        b=rHapeR/JxvcxN6W7W19c3D5y1po8dDVvpcyjLLnsGqTigqHIRcVtKZyOPOm4EmwA5X
         gZvZ7SaRcYeKMSyRS24x/nM+3NcciTQakzdRvmvHWD5A3JYLyTJbnAf1IndtYE3xYW9H
         hhVc6S6gy2q/haUNRuB3NrVbz9ufgLjlzwN3zhR//orPTeJl9V2RjCLfgAqXIdK4a5GS
         6rW7HOOFVEV0oaMziOM547PNip1A0zDUcq3QauaUi8ejlUbjFnRem5SkTCXW63k6QNoB
         Kn5/4dE0+vi+WDsYmlLcsfB6XiAvs/sb4zJ9pqTv8ilsms48O2vT7ZKUy/JbGRavA3aH
         ojSw==
X-Gm-Message-State: AOAM531kXjQom3Y7PkWlhgKJ3ycg0EdW8PlS3xd7272YufszVGfSde+A
        PktwgaXC7SkBmpJH7L/9kNoOWg==
X-Google-Smtp-Source: ABdhPJz51Cj3QahaU02gjrHM4b4Cws12LNOG8GBUTha+3SWwT0/3aI1Q636W96Qx6LeNZBs7QwuWyA==
X-Received: by 2002:a17:902:b710:: with SMTP id d16mr1054700pls.28.1592293787567;
        Tue, 16 Jun 2020 00:49:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n65sm15622327pfn.17.2020.06.16.00.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:49:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, x86@kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 5/8] selftests/seccomp: Compare bitmap vs filter overhead
Date:   Tue, 16 Jun 2020 00:49:31 -0700
Message-Id: <20200616074934.1600036-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616074934.1600036-1-keescook@chromium.org>
References: <20200616074934.1600036-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As part of the seccomp benchmarking, include the expectations with
regard to the timing behavior of the constant action bitmaps, and report
inconsistencies better.

Example output with constant action bitmaps on x86:

$ sudo ./seccomp_benchmark 30344920
Current BPF sysctl settings:
net.core.bpf_jit_enable = 1
net.core.bpf_jit_harden = 0
Benchmarking 30344920 syscalls...
22.113430452 - 0.005691205 = 22107739247 (22.1s)
getpid native: 728 ns
44.867669556 - 22.113755935 = 22753913621 (22.8s)
getpid RET_ALLOW 1 filter (bitmap): 749 ns
67.649040358 - 44.868003056 = 22781037302 (22.8s)
getpid RET_ALLOW 2 filters (bitmap): 750 ns
92.555661414 - 67.650328959 = 24905332455 (24.9s)
getpid RET_ALLOW 3 filters (full): 820 ns
118.170831065 - 92.556057543 = 25614773522 (25.6s)
getpid RET_ALLOW 4 filters (full): 844 ns
Estimated total seccomp overhead for 1 bitmapped filter: 21 ns
Estimated total seccomp overhead for 2 bitmapped filters: 22 ns
Estimated total seccomp overhead for 3 full filters: 92 ns
Estimated total seccomp overhead for 4 full filters: 116 ns
Estimated seccomp entry overhead: 20 ns
Estimated seccomp per-filter overhead (last 2 diff): 24 ns
Estimated seccomp per-filter overhead (filters / 4): 24 ns
Expectations:
        native ≤ 1 bitmap (728 ≤ 749): ✔️
        native ≤ 1 filter (728 ≤ 820): ✔️
        per-filter (last 2 diff) ≈ per-filter (filters / 4) (24 ≈ 24): ✔️
        1 bitmapped ≈ 2 bitmapped (21 ≈ 22): ✔️
        entry ≈ 1 bitmapped (20 ≈ 21): ✔️
        entry ≈ 2 bitmapped (20 ≈ 22): ✔️
        native + entry + (per filter * 4) ≈ 4 filters total (844 ≈ 844): ✔️

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../selftests/seccomp/seccomp_benchmark.c     | 151 +++++++++++++++---
 tools/testing/selftests/seccomp/settings      |   2 +-
 2 files changed, 130 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 91f5a89cadac..fcc806585266 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -4,12 +4,16 @@
  */
 #define _GNU_SOURCE
 #include <assert.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
 #include <unistd.h>
 #include <linux/filter.h>
 #include <linux/seccomp.h>
+#include <sys/param.h>
 #include <sys/prctl.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -70,18 +74,74 @@ unsigned long long calibrate(void)
 	return samples * seconds;
 }
 
+bool approx(int i_one, int i_two)
+{
+	double one = i_one, one_bump = one * 0.01;
+	double two = i_two, two_bump = two * 0.01;
+
+	one_bump = one + MAX(one_bump, 2.0);
+	two_bump = two + MAX(two_bump, 2.0);
+
+	/* Equal to, or within 1% or 2 digits */
+	if (one == two ||
+	    (one > two && one <= two_bump) ||
+	    (two > one && two <= one_bump))
+		return true;
+	return false;
+}
+
+bool le(int i_one, int i_two)
+{
+	if (i_one <= i_two)
+		return true;
+	return false;
+}
+
+long compare(const char *name_one, const char *name_eval, const char *name_two,
+	     unsigned long long one, bool (*eval)(int, int), unsigned long long two)
+{
+	bool good;
+
+	printf("\t%s %s %s (%lld %s %lld): ", name_one, name_eval, name_two,
+	       (long long)one, name_eval, (long long)two);
+	if (one > INT_MAX) {
+		printf("Miscalculation! Measurement went negative: %lld\n", (long long)one);
+		return 1;
+	}
+	if (two > INT_MAX) {
+		printf("Miscalculation! Measurement went negative: %lld\n", (long long)two);
+		return 1;
+	}
+
+	good = eval(one, two);
+	printf("%s\n", good ? "✔️" : "❌");
+
+	return good ? 0 : 1;
+}
+
 int main(int argc, char *argv[])
 {
+	struct sock_filter bitmap_filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS, offsetof(struct seccomp_data, nr)),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog bitmap_prog = {
+		.len = (unsigned short)ARRAY_SIZE(bitmap_filter),
+		.filter = bitmap_filter,
+	};
 	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS, offsetof(struct seccomp_data, args[0])),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
 	struct sock_fprog prog = {
 		.len = (unsigned short)ARRAY_SIZE(filter),
 		.filter = filter,
 	};
-	long ret;
-	unsigned long long samples;
-	unsigned long long native, filter1, filter2;
+
+	long ret, bits;
+	unsigned long long samples, calc;
+	unsigned long long native, filter1, filter2, bitmap1, bitmap2;
+	unsigned long long entry, per_filter1, per_filter2;
 
 	printf("Current BPF sysctl settings:\n");
 	system("sysctl net.core.bpf_jit_enable");
@@ -101,35 +161,82 @@ int main(int argc, char *argv[])
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	assert(ret == 0);
 
-	/* One filter */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
+	/* One filter resulting in a bitmap */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
 	assert(ret == 0);
 
-	filter1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-	printf("getpid RET_ALLOW 1 filter: %llu ns\n", filter1);
+	bitmap1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
+	printf("getpid RET_ALLOW 1 filter (bitmap): %llu ns\n", bitmap1);
+
+	/* Second filter resulting in a bitmap */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
+	assert(ret == 0);
 
-	if (filter1 == native)
-		printf("No overhead measured!? Try running again with more samples.\n");
+	bitmap2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
+	printf("getpid RET_ALLOW 2 filters (bitmap): %llu ns\n", bitmap2);
 
-	/* Two filters */
+	/* Third filter, can no longer be converted to bitmap */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
 	assert(ret == 0);
 
-	filter2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-	printf("getpid RET_ALLOW 2 filters: %llu ns\n", filter2);
-
-	/* Calculations */
-	printf("Estimated total seccomp overhead for 1 filter: %llu ns\n",
-		filter1 - native);
+	filter1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
+	printf("getpid RET_ALLOW 3 filters (full): %llu ns\n", filter1);
 
-	printf("Estimated total seccomp overhead for 2 filters: %llu ns\n",
-		filter2 - native);
+	/* Fourth filter, can not be converted to bitmap because of filter 3 */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
+	assert(ret == 0);
 
-	printf("Estimated seccomp per-filter overhead: %llu ns\n",
-		filter2 - filter1);
+	filter2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
+	printf("getpid RET_ALLOW 4 filters (full): %llu ns\n", filter2);
+
+	/* Estimations */
+#define ESTIMATE(fmt, var, what)	do {			\
+		var = (what);					\
+		printf("Estimated " fmt ": %llu ns\n", var);	\
+		if (var > INT_MAX)				\
+			goto more_samples;			\
+	} while (0)
+
+	ESTIMATE("total seccomp overhead for 1 bitmapped filter", calc,
+		 bitmap1 - native);
+	ESTIMATE("total seccomp overhead for 2 bitmapped filters", calc,
+		 bitmap2 - native);
+	ESTIMATE("total seccomp overhead for 3 full filters", calc,
+		 filter1 - native);
+	ESTIMATE("total seccomp overhead for 4 full filters", calc,
+		 filter2 - native);
+	ESTIMATE("seccomp entry overhead", entry,
+		 bitmap1 - native - (bitmap2 - bitmap1));
+	ESTIMATE("seccomp per-filter overhead (last 2 diff)", per_filter1,
+		 filter2 - filter1);
+	ESTIMATE("seccomp per-filter overhead (filters / 4)", per_filter2,
+		 (filter2 - native - entry) / 4);
+
+	printf("Expectations:\n");
+	ret |= compare("native", "≤", "1 bitmap", native, le, bitmap1);
+	bits = compare("native", "≤", "1 filter", native, le, filter1);
+	if (bits)
+		goto more_samples;
+
+	ret |= compare("per-filter (last 2 diff)", "≈", "per-filter (filters / 4)",
+			per_filter1, approx, per_filter2);
+
+	bits = compare("1 bitmapped", "≈", "2 bitmapped",
+			bitmap1 - native, approx, bitmap2 - native);
+	if (bits) {
+		printf("Skipping constant action bitmap expectations: they appear unsupported.\n");
+		goto out;
+	}
 
-	printf("Estimated seccomp entry overhead: %llu ns\n",
-		filter1 - native - (filter2 - filter1));
+	ret |= compare("entry", "≈", "1 bitmapped", entry, approx, bitmap1 - native);
+	ret |= compare("entry", "≈", "2 bitmapped", entry, approx, bitmap2 - native);
+	ret |= compare("native + entry + (per filter * 4)", "≈", "4 filters total",
+			entry + (per_filter1 * 4) + native, approx, filter2);
+	if (ret == 0)
+		goto out;
 
+more_samples:
+	printf("Saw unexpected benchmark result. Try running again with more samples?\n");
+out:
 	return 0;
 }
diff --git a/tools/testing/selftests/seccomp/settings b/tools/testing/selftests/seccomp/settings
index ba4d85f74cd6..6091b45d226b 100644
--- a/tools/testing/selftests/seccomp/settings
+++ b/tools/testing/selftests/seccomp/settings
@@ -1 +1 @@
-timeout=90
+timeout=120
-- 
2.25.1

