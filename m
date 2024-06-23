Return-Path: <linux-api+bounces-1791-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF6B913A18
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2024 13:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C109281493
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2024 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCE2137761;
	Sun, 23 Jun 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUuIeJrr"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDFE13775B;
	Sun, 23 Jun 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719142011; cv=none; b=bHDqsYGx2HQs6Beamv7XakFZqHGgH5gAwNOLAwr7/SZUxhI5eYXTvNnDa7BWVQ1LFzv4wE1kRUJOLrzszndlOlqokrTQTBSn1lzH2HKvU1YPb7Vnx80+tGqOfAV9S+47DqJGiSB4WYPMLyomVaQARmnzpD/IQQDkHJ/WZIT6O0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719142011; c=relaxed/simple;
	bh=OrLlJZLIdpu8469ekNLVgxT7+eFxGI9yqTN5LZeTdZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YpueI2jehFqWQoTjmt7S9kljWFHkcP/wb8c4TmIqThb9OdRvC7zW0L8z4LAaQZMRlNjU+BL2a6gO5NqJppP9OEvntznbfTqIxSjXPRxuEDkRjsMuS4GQmB5A4GZ7os6Kgut3yrYCxxImB+ZpIXD7UMPM0Y8R1pUdxUpA3eaI7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUuIeJrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A83C32782;
	Sun, 23 Jun 2024 11:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719142011;
	bh=OrLlJZLIdpu8469ekNLVgxT7+eFxGI9yqTN5LZeTdZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fUuIeJrreq3hb97SXBQCpnlHZpUeS0dkR+e53R3tVQbKmx1RyfgraVPl0khleh5SH
	 Zsi7jP94n+It2a1gCbSZPlaADPE3R6/D2X10ha3hfVVfKOXkOurCQXo18xSVhucyPh
	 DD+6TXOlu3MnIY4+R7akZaU3KCLCRRZghe1NMt0A4K5gN02l/HjCiSCMKmuTcFcEKN
	 k8Z7LSNdtWMP1AomIrysiuOa38rSbIaRtJvBY4uw4TfWK6qRLy5smptuKxLZoWnkT8
	 huSUdI46HuBqzdHoEPq6n/e+CMmoIjFffNIe9TO+Ll/1i43adtQQhB3rbfmRHZgRNG
	 129rdPTAmP8mg==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 23 Jun 2024 12:23:50 +0100
Subject: [PATCH RFT v6 8/9] selftests/clone3: Allow tests to flag if -E2BIG
 is a valid error code
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-clone3-shadow-stack-v6-8-9ee7783b1fb9@kernel.org>
References: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
In-Reply-To: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OrLlJZLIdpu8469ekNLVgxT7+eFxGI9yqTN5LZeTdZg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmeAZEOoxjXEAkG0hIViajWG+I9U+cB9UUff/zNYM0
 /8m4BrCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZngGRAAKCRAk1otyXVSH0HqlB/
 4hycTEhYrVKpxMlmbk9vT8IxxIZbTM+SmMjs9ow79mXaEA57UDoozZAcUqd0T1uK/l6dbb13GirVYX
 PfECPlgiQZQx0JW+e7Ee0/XDu7UUWMDlwCwoZWgGm6GwVNgQOLMvFo3m43lJKiGJ1PCAogLS6JgYsy
 DdiJkEnftzslMlEVJKGEGywBPOCrPWkMUzAJhJ5jXjw4dbL6iq+qUFqi0aTMAJAsfZnRjjxVdfo/8e
 FRGkAbfdpoSyt05NhLV2hOftf63YcrbPrzmY44dqGUDaJ0TTXcp/kDXScVlTjx7HqbcwLczDzT68e2
 TkhNshXpAz33zp2gHyHNU0MYKJ6HSU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The clone_args structure is extensible, with the syscall passing in the
length of the structure. Inside the kernel we use copy_struct_from_user()
to read the struct but this has the unfortunate side effect of silently
accepting some overrun in the structure size providing the extra data is
all zeros. This means that we can't discover the clone3() features that
the running kernel supports by simply probing with various struct sizes.
We need to check this for the benefit of test systems which run newer
kselftests on old kernels.

Add a flag which can be set on a test to indicate that clone3() may return
-E2BIG due to the use of newer struct versions. Currently no tests need
this but it will become an issue for testing clone3() support for shadow
stacks, the support for shadow stacks is already present on x86.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 3b3a08e6a34d..26221661e9ae 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -39,6 +39,7 @@ struct test {
 	size_t size;
 	size_function size_function;
 	int expected;
+	bool e2big_valid;
 	enum test_mode test_mode;
 	filter_function filter;
 };
@@ -153,6 +154,11 @@ static void test_clone3(const struct test *test)
 	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
 			getpid(), ret, test->expected);
 	if (ret != test->expected) {
+		if (test->e2big_valid && ret == -E2BIG) {
+			ksft_print_msg("Test reported -E2BIG\n");
+			ksft_test_result_skip("%s\n", test->name);
+			return;
+		}
 		ksft_print_msg(
 			"[%d] Result (%d) is different than expected (%d)\n",
 			getpid(), ret, test->expected);

-- 
2.39.2


