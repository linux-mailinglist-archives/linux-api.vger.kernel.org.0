Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823181FAA58
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 09:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFPHts (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 03:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgFPHtp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 03:49:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD02BC05BD43
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 00:49:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so9109611pfn.3
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjcyOk28N/gDNh+lNJI3lw4LaLVWwmKl55JA3X6Dw/I=;
        b=FG9PpeCl4IGZS0FoNmzdMakw2RdED+vA0suD67BJd2Q1POY++LxiBHhwe4plC4cga8
         iDPgxWJGUXT92vT8ZuWCJtOCWA1ztsAt8azrEh5ct14BZQG2ahACYirwzmmPk7G6j8pv
         DaCnf8hnlAC4JZ0uKMWM+knX75nXFBb223vWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjcyOk28N/gDNh+lNJI3lw4LaLVWwmKl55JA3X6Dw/I=;
        b=dk2t6TOKNMuwGPEU0GcR4gAgDphuxLiSzmIlix6ALWZHFxU71m32woZ9ZJcwAMlhUv
         mCSRg0Zizt8wpwYrZ8B4M+AAAVtUNYfKbkVBRaalRl4TnuIZiBKAMgUJS3Gwlish0mfe
         SkwVVxXv2Y+iB0MeRUlySy4EnbaRlAmVpxenr4jWOtQGLwjPyxxEcz8BgzCTKOBta5AL
         wzwtB3GmHHu1wqQypYjgBp+3pBX1FEFZ1Xw+GHrJiQsiGzfwZ4N48m4i3+BeYe7OPMhv
         N4n0d59o1X9fOFlTXnzcxOB0mi84rMwp7I8rq2zhnCaAuahnvdzANOrSC8bzNJp8+dvE
         /ghw==
X-Gm-Message-State: AOAM531hJla+xtw8fYu3JweTI8kmwBVmVpHXc2trm5TTWqbNz3tT8T2V
        4Z7LoRp4ucT9SLuLJH6rXxLOaA==
X-Google-Smtp-Source: ABdhPJyGg39N+96ssceO/9HxF6jdYQbkHmDZ4rA7Tk6OOphboXmqXiNDvckhAdVMS9jNEwdwSrEJpg==
X-Received: by 2002:a63:1862:: with SMTP id 34mr1181225pgy.246.1592293783735;
        Tue, 16 Jun 2020 00:49:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7sm1587517pjd.2.2020.06.16.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:49:42 -0700 (PDT)
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
Subject: [PATCH 1/8] selftests/seccomp: Improve calibration loop
Date:   Tue, 16 Jun 2020 00:49:27 -0700
Message-Id: <20200616074934.1600036-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616074934.1600036-1-keescook@chromium.org>
References: <20200616074934.1600036-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The seccomp benchmark calibration loop did not need to take so long.
Instead, use a simple 1 second timeout and multiply up to target. It
does not need to be accurate.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../selftests/seccomp/seccomp_benchmark.c     | 50 ++++++++++++-------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index eca13fe1fba9..91f5a89cadac 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -18,9 +18,9 @@
 
 unsigned long long timing(clockid_t clk_id, unsigned long long samples)
 {
-	pid_t pid, ret;
-	unsigned long long i;
 	struct timespec start, finish;
+	unsigned long long i;
+	pid_t pid, ret;
 
 	pid = getpid();
 	assert(clock_gettime(clk_id, &start) == 0);
@@ -31,30 +31,43 @@ unsigned long long timing(clockid_t clk_id, unsigned long long samples)
 	assert(clock_gettime(clk_id, &finish) == 0);
 
 	i = finish.tv_sec - start.tv_sec;
-	i *= 1000000000;
+	i *= 1000000000ULL;
 	i += finish.tv_nsec - start.tv_nsec;
 
-	printf("%lu.%09lu - %lu.%09lu = %llu\n",
+	printf("%lu.%09lu - %lu.%09lu = %llu (%.1fs)\n",
 		finish.tv_sec, finish.tv_nsec,
 		start.tv_sec, start.tv_nsec,
-		i);
+		i, (double)i / 1000000000.0);
 
 	return i;
 }
 
 unsigned long long calibrate(void)
 {
-	unsigned long long i;
-
-	printf("Calibrating reasonable sample size...\n");
+	struct timespec start, finish;
+	unsigned long long i, samples, step = 9973;
+	pid_t pid, ret;
+	int seconds = 15;
 
-	for (i = 5; ; i++) {
-		unsigned long long samples = 1 << i;
+	printf("Calibrating sample size for %d seconds worth of syscalls ...\n", seconds);
 
-		/* Find something that takes more than 5 seconds to run. */
-		if (timing(CLOCK_REALTIME, samples) / 1000000000ULL > 5)
-			return samples;
-	}
+	samples = 0;
+	pid = getpid();
+	assert(clock_gettime(CLOCK_MONOTONIC, &start) == 0);
+	do {
+		for (i = 0; i < step; i++) {
+			ret = syscall(__NR_getpid);
+			assert(pid == ret);
+		}
+		assert(clock_gettime(CLOCK_MONOTONIC, &finish) == 0);
+
+		samples += step;
+		i = finish.tv_sec - start.tv_sec;
+		i *= 1000000000ULL;
+		i += finish.tv_nsec - start.tv_nsec;
+	} while (i < 1000000000ULL);
+
+	return samples * seconds;
 }
 
 int main(int argc, char *argv[])
@@ -70,15 +83,16 @@ int main(int argc, char *argv[])
 	unsigned long long samples;
 	unsigned long long native, filter1, filter2;
 
+	printf("Current BPF sysctl settings:\n");
+	system("sysctl net.core.bpf_jit_enable");
+	system("sysctl net.core.bpf_jit_harden");
+
 	if (argc > 1)
 		samples = strtoull(argv[1], NULL, 0);
 	else
 		samples = calibrate();
 
-	printf("Current BPF sysctl settings:\n");
-	system("sysctl net.core.bpf_jit_enable");
-	system("sysctl net.core.bpf_jit_harden");
-	printf("Benchmarking %llu samples...\n", samples);
+	printf("Benchmarking %llu syscalls...\n", samples);
 
 	/* Native call */
 	native = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-- 
2.25.1

