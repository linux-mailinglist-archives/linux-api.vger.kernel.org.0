Return-Path: <linux-api+bounces-4978-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6EABA7BDA
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 03:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BA53BEB0A
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 01:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400E72C15B4;
	Mon, 29 Sep 2025 01:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iA6Gv4Uf"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEEE2C029F
	for <linux-api@vger.kernel.org>; Mon, 29 Sep 2025 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107900; cv=none; b=V0H6wBp6NM0+V/iS9TzbityUEKDudBy+XL8I1HmwOk1SpMNI9UJNuKicYZNQ2dogUmGshuneG9pcTbtkOmi+7aEIfOgy5RdSIQWSJyJc5kA/sE5FoVAXGXWnWxvxVtSLy7vH1sMxQhk820HUAmplYpLKgxJUwlesAk7L3TB1kzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107900; c=relaxed/simple;
	bh=YxndNYekOIE4c7Py3BfYUApvqGWLMZMwxTdov0PwqSk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXX0ejS8CoDVl/cWnUPQMZaTYmdcbqofKdpNiYC4Abyp5c39UJP1NpWUcIVGUWasp/ffJNg643fP+eTUlhID62qB4aJPYUsRmCF67lhK2oGDnfp3/CamqgECmqW1wVRi9AwFNy/MeIW+A8fdvhAXtOad6uqpZgUS3C6sMRoi1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=iA6Gv4Uf; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4df0467b510so21102481cf.3
        for <linux-api@vger.kernel.org>; Sun, 28 Sep 2025 18:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107896; x=1759712696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ougWc4G/qIZT3q+j2o8YnJ0ye/FPwzyh3Yh9OeHBEk8=;
        b=iA6Gv4UfCuldLImNHDxeF22VUESqTDA4QxoBJLZQFc485cj2iO0lwRGLwYJLqQTAQj
         tQntflsKcN01xTOwwLu9M/WyAVEh2n2DoJvrsqct0dcZtrzeNAncR3JA6hR1cyWtk5a5
         O5jZUw5bvDLIypoo1sQ7qsE0EBwrDE2Uw/0Q7/nZGXpiIoqAaUBA74S+qvCFH8RkhZTO
         UEZ4hLXlH7a7GDPBvU2aPFEYwpa36jMdm9/trun5+92JSrbDs+eaFuqGOUoy6fnygBbn
         KbI94Sh906CF7GxwDzpzVWrhZOVup5yqNaxWuvLUxs+qlMi12/EjmSNlTdAxlam2jhbG
         kkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107896; x=1759712696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ougWc4G/qIZT3q+j2o8YnJ0ye/FPwzyh3Yh9OeHBEk8=;
        b=QBUWnCBO9w9uMNy8b+QV6Prf30Brq7tYUP9SOlLSX1+84Teqhmn9/V8RNZ8GX2vT3L
         A3rKE572rwC+4rnYtjLo4K1g/+vZT2ZAVC1s9C466xGj8sQOzIHwULahp+PfnWCeOzKI
         2rum0tIIqUJEl/k9+UIo/gpXkqb5r1K7zOH8u9nz8bfxckLRMSigzM1I7jSLj7mWN9QV
         GPpkCzHIO4259CcpOCvnQaNeBPADWlj8D9uwa4o89wi82+6Qqn16wTuTRn+0HBWU8E7u
         79IPYFZpedLb6xxISfWLl+LVRXLZHBSHYXVbu0UkwDN7IXCoH7NA6eof8dOfirYUQCMS
         B/bA==
X-Forwarded-Encrypted: i=1; AJvYcCWijYGHooADPJSHc9RupROVOcfWDddtfXz0HAA++TTIo7jRkPy+M10ZDFsy7Vkwm04DzrBmClD2MJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzavvzUIh9wIlvPezcWAvZ1YXtT83+9SmwC83ZUnb726p/ceCjA
	fhw59QwGdl33VM7CHsZr1wgWd5zLQoNZd9FRzjoic+X/1zK8v/C1Kd0xLzmN7TYFwOU=
X-Gm-Gg: ASbGncsVKqi6VQCqlzNeg4G8dJzwjVglsEqqEG0FnGt+gGP59nzSww4Io1kERFSdN/2
	k2gTd4ri4VqjGtkHQdHZYV7Yk/CYvCTgqrsF3joYd49Ti2T8RVTQLeacAvtTQ3tl2s1rgYAk8L0
	hCmRkioadgGQXPJ9I41Ows5MI+I38wl8nwmhPssrlgQCytfi2ZzBB6NzHxEXc5Sw/6I+jUda+Bd
	jw6Y6TVZO2oM4B+3udxXg/VsmfWft/3XVo0YEgmQd67oljaZd8f4YjhALwA9DcVxMyq8S25ZbRR
	6cz2nKA1u8p0ozF0raA/vKPP98D49sJzo9KfeJSdo6L+kjWA3VQl6rW559tGhLVa3iJ4/Rl3ale
	LwWkWOkU8F3HDsie4S8zadykjWLxOGwc/v+yQrsHoJIlAP4vLooYsoRJSikOLRkjxDYS7NklW3i
	u2iNGA/dE=
X-Google-Smtp-Source: AGHT+IFYNaFG7Jc9+8mczCUfL2NG5AxHH54S3++B2bClP4OT/C9rMlU+s2JYq6QncxNId85tdheqhw==
X-Received: by 2002:ac8:7d43:0:b0:4b7:90c0:3156 with SMTP id d75a77b69052e-4da4735376emr195893531cf.9.1759107896425;
        Sun, 28 Sep 2025 18:04:56 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:55 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 30/30] selftests/liveupdate: Add tests for per-session state and cancel cycles
Date: Mon, 29 Sep 2025 01:03:21 +0000
Message-ID: <20250929010321.3462457-31-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce two new, non-kexec selftests to validate the state transition
logic for individual LUO sessions, with a focus on the PREPARE, FREEZE,
and CANCEL events. While other tests cover the full kexec lifecycle, it
is critical to also test the internal per-session state machine's logic
and rollback capabilities in isolation. These tests provide this focused
coverage, ensuring the core session management ioctls behave as
expected.

The new test cases are:
1. session_prepare_cancel_cycle:
  - Verifies the fundamental NORMAL -> PREPARED -> NORMAL state
    transition path.
  - It creates a session, preserves a file, sends a per-session PREPARE
    event, asserts the state is PREPARED, then sends a CANCEL event and
    asserts the state has correctly returned to NORMAL.

2. session_freeze_cancel_cycle:
  - Extends the first test by validating the more critical ... ->
    FROZEN -> NORMAL rollback path.
  - It follows the same steps but adds a FREEZE event after PREPARE,
    asserting the session enters the FROZEN state.
  - It then sends a CANCEL event, verifying that a session can be rolled
    back even from this final pre-kexec state. This is essential for
    robustly handling aborts.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/Makefile   |  9 ++-
 .../testing/selftests/liveupdate/liveupdate.c | 56 +++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index ffce73233149..25a6dec790bb 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -16,11 +16,18 @@ LUO_MANUAL_TESTS += luo_unreclaimed
 
 TEST_FILES += do_kexec.sh
 
-TEST_GEN_PROGS += liveupdate
+LUO_MAIN_TESTS += liveupdate
 
 # --- Automatic Rule Generation (Do not edit below) ---
 
 TEST_GEN_PROGS_EXTENDED += $(LUO_MANUAL_TESTS)
+TEST_GEN_PROGS := $(LUO_MAIN_TESTS)
+
+liveupdate_SOURCES := liveupdate.c $(LUO_SHARED_SRCS)
+
+$(OUTPUT)/liveupdate: $(liveupdate_SOURCES) $(LUO_SHARED_HDRS)
+	$(call msg,LINK,,$@)
+	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
 # Define the full list of sources for each manual test.
 $(foreach test,$(LUO_MANUAL_TESTS), \
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 7c0ceaac0283..804aa25ce5ae 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -17,6 +17,7 @@
 #include <sys/mman.h>
 
 #include <linux/liveupdate.h>
+#include "luo_test_utils.h"
 
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
@@ -52,6 +53,16 @@ const char *const luo_state_str[] = {
 	[LIVEUPDATE_STATE_UPDATED]  = "updated",
 };
 
+static int get_session_state(int session_fd)
+{
+	struct liveupdate_session_get_state arg = { .size = sizeof(arg) };
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_GET_STATE, &arg) < 0)
+		return -errno;
+
+	return arg.state;
+}
+
 static int run_luo_selftest_cmd(int fd_dbg, __u64 cmd_code,
 				struct luo_arg_subsystem *subsys_arg)
 {
@@ -345,4 +356,49 @@ TEST_F(subsystem, prepare_fail)
 		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
 }
 
+TEST_F(state, session_freeze_cancel_cycle)
+{
+	int session_fd;
+	const char *session_name = "freeze_cancel_session";
+	const int memfd_token = 5678;
+
+	session_fd = luo_create_session(self->fd, session_name);
+	ASSERT_GE(session_fd, 0);
+
+	ASSERT_EQ(0, create_and_preserve_memfd(session_fd, memfd_token,
+					       "freeze test data"));
+
+	ASSERT_EQ(0, luo_set_session_event(session_fd, LIVEUPDATE_PREPARE));
+	ASSERT_EQ(get_session_state(session_fd), LIVEUPDATE_STATE_PREPARED);
+
+	ASSERT_EQ(0, luo_set_session_event(session_fd, LIVEUPDATE_FREEZE));
+	ASSERT_EQ(get_session_state(session_fd), LIVEUPDATE_STATE_FROZEN);
+
+	ASSERT_EQ(0, luo_set_session_event(session_fd, LIVEUPDATE_CANCEL));
+	ASSERT_EQ(get_session_state(session_fd), LIVEUPDATE_STATE_NORMAL);
+
+	close(session_fd);
+}
+
+TEST_F(state, session_prepare_cancel_cycle)
+{
+	const char *session_name = "prepare_cancel_session";
+	const int memfd_token = 1234;
+	int session_fd;
+
+	session_fd = luo_create_session(self->fd, session_name);
+	ASSERT_GE(session_fd, 0);
+
+	ASSERT_EQ(0, create_and_preserve_memfd(session_fd, memfd_token,
+					       "prepare test data"));
+
+	ASSERT_EQ(0, luo_set_session_event(session_fd, LIVEUPDATE_PREPARE));
+	ASSERT_EQ(get_session_state(session_fd), LIVEUPDATE_STATE_PREPARED);
+
+	ASSERT_EQ(0, luo_set_session_event(session_fd, LIVEUPDATE_CANCEL));
+	ASSERT_EQ(get_session_state(session_fd), LIVEUPDATE_STATE_NORMAL);
+
+	close(session_fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.51.0.536.g15c5d4f767-goog


