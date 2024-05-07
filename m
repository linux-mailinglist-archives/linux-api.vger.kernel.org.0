Return-Path: <linux-api+bounces-1493-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ABA8BE06C
	for <lists+linux-api@lfdr.de>; Tue,  7 May 2024 12:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E841F27EE6
	for <lists+linux-api@lfdr.de>; Tue,  7 May 2024 10:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897A8156C6A;
	Tue,  7 May 2024 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um9Npo7M"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2151514F8;
	Tue,  7 May 2024 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079298; cv=none; b=LBYZjqsMY/sh730TmzegS3bPVd/wvhpGqova1qhqvYWPetkCFLroVsEbzPWJcFGhj1nhx/EuhR5QlQ3yhzPM623uTYwXjNfJ0Lopk2NeMhPHKYDfOvTJEtkFZkps082K1JvCfDkj1PYSdBPIjmvbVzuQBgSgSZAnDBufYRddyZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079298; c=relaxed/simple;
	bh=rkhifOud3Xw62+0WzcH/TUiWiCAIoKRXhKfeTNZ5TtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NloUdIHtxo6VviSCVSOB92NB+LDGuBIoem34TtujeHUYwva8Bhhn9BBkGT0DewAPqqBqTDmTjbZfdb0Mkn8eDRFQvxTYs+2UaFFG4lFPByPFo3cO/9ApgueYSqRMJZfUaAAQcr8fjL9vNa+jX6eN/kD9tsJcnEQq4HC/euSoJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um9Npo7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EAAC2BBFC;
	Tue,  7 May 2024 10:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715079297;
	bh=rkhifOud3Xw62+0WzcH/TUiWiCAIoKRXhKfeTNZ5TtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Um9Npo7MovB8wjoKHKIoytIscrHEbWnyBD2ibolD80D+gFW5ygOqKGl1FzClrx20W
	 PznycYBvqFEwTfKwJGW2e/IYFnWOe0SuOiiZLgRQSALKN4eXLRDs43fR0+DaqosR4t
	 Xr0vD86j2IB+Dqjqa4qr5jRF5vQD9MthLJ/LKffN6SzVuYdQb4pw9CPf9ZLGZH9Kd+
	 JltRor1EQcoe1cfkO+J/hlDKxGof/Po0palt5rgFT6NVoLLsbRQ4ULzPPe1zgijbIv
	 YzhNUFcM+sjeKIPXTsOPyu7/bNho3giNn/3ZDBwFafkRKDXNuyRLwIN59pRHJIJ47J
	 VORuZDbJIJOcw==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCHv5 bpf-next 7/8] selftests/x86: Add return uprobe shadow stack test
Date: Tue,  7 May 2024 12:53:20 +0200
Message-ID: <20240507105321.71524-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507105321.71524-1-jolsa@kernel.org>
References: <20240507105321.71524-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding return uprobe test for shadow stack and making sure it's
working properly. Borrowed some of the code from bpf selftests.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/x86/test_shadow_stack.c | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index 757e6527f67e..1b919baa999b 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -34,6 +34,7 @@
 #include <sys/ptrace.h>
 #include <sys/signal.h>
 #include <linux/elf.h>
+#include <linux/perf_event.h>
 
 /*
  * Define the ABI defines if needed, so people can run the tests
@@ -681,6 +682,141 @@ int test_32bit(void)
 	return !segv_triggered;
 }
 
+static int parse_uint_from_file(const char *file, const char *fmt)
+{
+	int err, ret;
+	FILE *f;
+
+	f = fopen(file, "re");
+	if (!f) {
+		err = -errno;
+		printf("failed to open '%s': %d\n", file, err);
+		return err;
+	}
+	err = fscanf(f, fmt, &ret);
+	if (err != 1) {
+		err = err == EOF ? -EIO : -errno;
+		printf("failed to parse '%s': %d\n", file, err);
+		fclose(f);
+		return err;
+	}
+	fclose(f);
+	return ret;
+}
+
+static int determine_uprobe_perf_type(void)
+{
+	const char *file = "/sys/bus/event_source/devices/uprobe/type";
+
+	return parse_uint_from_file(file, "%d\n");
+}
+
+static int determine_uprobe_retprobe_bit(void)
+{
+	const char *file = "/sys/bus/event_source/devices/uprobe/format/retprobe";
+
+	return parse_uint_from_file(file, "config:%d\n");
+}
+
+static ssize_t get_uprobe_offset(const void *addr)
+{
+	size_t start, end, base;
+	char buf[256];
+	bool found = false;
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -errno;
+
+	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
+		if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
+			found = true;
+			break;
+		}
+	}
+
+	fclose(f);
+
+	if (!found)
+		return -ESRCH;
+
+	return (uintptr_t)addr - start + base;
+}
+
+static __attribute__((noinline)) void uretprobe_trigger(void)
+{
+	asm volatile ("");
+}
+
+/*
+ * This test setups return uprobe, which is sensitive to shadow stack
+ * (crashes without extra fix). After executing the uretprobe we fail
+ * the test if we receive SIGSEGV, no crash means we're good.
+ *
+ * Helper functions above borrowed from bpf selftests.
+ */
+static int test_uretprobe(void)
+{
+	const size_t attr_sz = sizeof(struct perf_event_attr);
+	const char *file = "/proc/self/exe";
+	int bit, fd = 0, type, err = 1;
+	struct perf_event_attr attr;
+	struct sigaction sa = {};
+	ssize_t offset;
+
+	type = determine_uprobe_perf_type();
+	if (type < 0)
+		return 1;
+
+	offset = get_uprobe_offset(uretprobe_trigger);
+	if (offset < 0)
+		return 1;
+
+	bit = determine_uprobe_retprobe_bit();
+	if (bit < 0)
+		return 1;
+
+	sa.sa_sigaction = segv_gp_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+
+	/* Setup return uprobe through perf event interface. */
+	memset(&attr, 0, attr_sz);
+	attr.size = attr_sz;
+	attr.type = type;
+	attr.config = 1 << bit;
+	attr.config1 = (__u64) (unsigned long) file;
+	attr.config2 = offset;
+
+	fd = syscall(__NR_perf_event_open, &attr, 0 /* pid */, -1 /* cpu */,
+		     -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
+	if (fd < 0)
+		goto out;
+
+	if (sigsetjmp(jmp_buffer, 1))
+		goto out;
+
+	ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
+
+	/*
+	 * This either segfaults and goes through sigsetjmp above
+	 * or succeeds and we're good.
+	 */
+	uretprobe_trigger();
+
+	printf("[OK]\tUretprobe test\n");
+	err = 0;
+
+out:
+	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
+	signal(SIGSEGV, SIG_DFL);
+	if (fd)
+		close(fd);
+	return err;
+}
+
 void segv_handler_ptrace(int signum, siginfo_t *si, void *uc)
 {
 	/* The SSP adjustment caused a segfault. */
@@ -867,6 +1003,12 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	if (test_uretprobe()) {
+		ret = 1;
+		printf("[FAIL]\turetprobe test\n");
+		goto out;
+	}
+
 	return ret;
 
 out:
-- 
2.44.0


