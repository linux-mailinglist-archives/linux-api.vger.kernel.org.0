Return-Path: <linux-api+bounces-5343-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA223C669DE
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 01:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6487235D214
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 00:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B0F175A5;
	Tue, 18 Nov 2025 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3qgVtAJ3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F674C98
	for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424396; cv=none; b=G2aN4lg8HwMBBcY381jAsnAzoUVLXnkZMldIEgVTe86DZuq4h3gauN7c2ZNOJyrFNsSsarXlka24Rmg4TEV8JshvfIlPrUtrZDamxqUNkStZOWTPe+hceBh01xKM15kZaojuNDiwZkNUWCUVSHkHTXXvWib1vzGEGx9I1A6B/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424396; c=relaxed/simple;
	bh=rk9BkAFB9pdLx2olw5XHN6msU0jlCk1qBAL54eaWXh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8CQkKUFw9IgQOL2nleFNk38FeNgvWcWiCuct6tp2bcdi0zVdg7RKvltsyrBkMAxsygqhK1pUDl+XUeXvKplOCOxRWK2+W4m90cRpaV72VfQK7Q1GMDZBb1iyXyBYtjo27F0A9lLOXSLD843p2aKmNi8Drk8mkXRi0VGyM7SXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3qgVtAJ3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aad4823079so4436318b3a.0
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 16:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763424394; x=1764029194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1v4fRZdVLhKe/ktZvpTDlH6fFhc+2rF0aLfRAFXmPdc=;
        b=3qgVtAJ3lvQRcYfWoRq16P3YXc5lv2KdpdEBCVnTc76+vq3jnAQ5/Xb869vp0ltXgn
         ZhfxgUDMpZfOOJJoMyMsXVUsV+u3ohEWeR6b0S3+GSqlsNi/SZmk+POZ48b7jlDdCTI+
         N+wB3ezS9PmMBZVSOSkh3Xf8kSIagm1Z3t3mxk2BtHy1zOuVp3kg+/nRO3JwnGsYiM1w
         HaSRhz4bEo7mtvYnagaLWI5gCu/3bftl//4Ev9kzy4L6aoE3fJp1WK/1v62Jo81osa1P
         7u5CumnDkhogztvL0KQyLnuiJUZ1xUqabpET3vqkOZaGSUBRqaTDvzXsEdnP0TtTl75d
         qcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763424394; x=1764029194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1v4fRZdVLhKe/ktZvpTDlH6fFhc+2rF0aLfRAFXmPdc=;
        b=HGyDwvlkYAMttBnzQL0csEavmhGVm2stKGEkbbfju1c0uOZF2D9b3TYerV+Y0F0Kh7
         0l5mMucfKNM0Scv7M+wS3PgQrq5vtFdh6MRZTEEwhSSnrpCqYxgsdX1ZmrxM64Q82Pzt
         Vs7Z2Vm4Kk6wN5MVHIVQT6AIyGeVIgo1uUhciQyUmyZh249ePwbNMags8I1EDm5h3p7M
         H60f5ZDQ6MDBsoIqkwYcv2yfkq+H9ZyzDAuWt8Tvi+/poICcKlsOuhARVJDt2NOfQ83x
         GkTy9fQFNBASxERZoXy4HFegRMtbIWltyCOUOxT+g7e43GLU8gfMgQyfPhKlsPDrvaAN
         1vvg==
X-Forwarded-Encrypted: i=1; AJvYcCW+6pE9aNWFOf0WdYxzK2WRXy+RBmH/V54mVPMO4fp0UxS/BjD58NuvzCNbtfbA9r//WQpG4nt3Liw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmRiYmP5bt63JRDv4uZzHmjV7srQtPOVhrMdNlI8a2UpGb2D4
	zlwKjnCXj9XS3RYPZScS/rgtUeMgN0EHWm49zav9xL93CD22vCCJ82uVtoMZYxTBtg==
X-Gm-Gg: ASbGncuhmRAY8FOpTKFawIsvSh7T3CDgDuBhkwv0P4zUXUP+5TAKqlM8e4bDIp08BG7
	miQb9f4AhMfCg/nuZy8jpa87GySFiiffqsRqpVvk/TbHg2PIkYR4HlskbK/oJY49sDpGEeqUY0w
	3gdSy49d/blgZMKI4SILsVyddUyr1gv27Zj9DtX7yl/G1IrRUmWl/mNwobM8wyMEpVtc4yKUMcL
	xI+kFQjoRCBD8rvdagVOYgt+iNfMRDQ4JrgZRViVLlxug8KtckoqKpTfj2ac0pa5KRx5EsOWwMN
	/Vowjf9zBwz5GosPgHPpigIAiY0029r5PmsDDm87lc184Qv6C1trpZGexqj7VdYiCnQyGJMNVgu
	9toAeWrV1pL/aVp1vqcMsmlh62Q75mZIFU8bD7w3kvoDTAD4/W5mpzilWOksY02fl6CYC3Ww+L+
	/qLhhLC1oGhPez3VJCrQcJ9JBr4FLK4F8maSMZschU4gRr4Cxa8OcJSUQ2bcXsfoc=
X-Google-Smtp-Source: AGHT+IHkJBvRbGUG30Kr3T5gR1UjB+qV085NIT1CUVV/7jNIJcaOzKed5XoscCfn8280NZXc0GRAQQ==
X-Received: by 2002:a05:6a00:2d1e:b0:7b8:c7f7:645e with SMTP id d2e1a72fcca58-7ba3c07eeebmr19714686b3a.17.1763424393959;
        Mon, 17 Nov 2025 16:06:33 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924be37fbsm14602912b3a.1.2025.11.17.16.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:06:33 -0800 (PST)
Date: Tue, 18 Nov 2025 00:06:28 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	rppt@kernel.org, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v6 18/20] selftests/liveupdate: Add kexec-based selftest
 for session lifecycle
Message-ID: <aRu4hBPz2g-cealt@google.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-19-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-19-pasha.tatashin@soleen.com>

On 2025-11-15 06:34 PM, Pasha Tatashin wrote:

> +/* Stage 1: Executed before the kexec reboot. */
> +static void run_stage_1(int luo_fd)
> +{
> +	int session_fd;
> +
> +	ksft_print_msg("[STAGE 1] Starting pre-kexec setup...\n");
> +
> +	ksft_print_msg("[STAGE 1] Creating state file for next stage (2)...\n");
> +	create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, 2);
> +
> +	ksft_print_msg("[STAGE 1] Creating session '%s' and preserving memfd...\n",
> +		       TEST_SESSION_NAME);
> +	session_fd = luo_create_session(luo_fd, TEST_SESSION_NAME);
> +	if (session_fd < 0)
> +		fail_exit("luo_create_session for '%s'", TEST_SESSION_NAME);
> +
> +	if (create_and_preserve_memfd(session_fd, TEST_MEMFD_TOKEN,
> +				      TEST_MEMFD_DATA) < 0) {
> +		fail_exit("create_and_preserve_memfd for token %#x",
> +			  TEST_MEMFD_TOKEN);
> +	}
> +
> +	ksft_print_msg("[STAGE 1] Executing kexec...\n");
> +	if (system(KEXEC_SCRIPT) != 0)
> +		fail_exit("kexec script failed");
> +	exit(EXIT_FAILURE);

Can we separate the kexec from the test and allow the user/automation to
trigger it however is appropriate for their system? The current
do_kexec.sh script does not do any sort of graceful shutdown, and I bet
everyone will have different ways of initiating kexec on their systems.

For example, something like this (but sleeping in the child instead of
busy waiting):

diff --git a/tools/testing/selftests/liveupdate/luo_kexec_simple.c b/tools/testing/selftests/liveupdate/luo_kexec_simple.c
index 67ab6ebf9eec..513693bfb77b 100644
--- a/tools/testing/selftests/liveupdate/luo_kexec_simple.c
+++ b/tools/testing/selftests/liveupdate/luo_kexec_simple.c
@@ -24,6 +24,7 @@
 static void run_stage_1(int luo_fd)
 {
 	int session_fd;
+	int ret;
 
 	ksft_print_msg("[STAGE 1] Starting pre-kexec setup...\n");
 
@@ -42,10 +43,17 @@ static void run_stage_1(int luo_fd)
 			  TEST_MEMFD_TOKEN);
 	}
 
-	ksft_print_msg("[STAGE 1] Executing kexec...\n");
-	if (system(KEXEC_SCRIPT) != 0)
-		fail_exit("kexec script failed");
-	exit(EXIT_FAILURE);
+	ksft_print_msg("[STAGE 1] Forking child process to hold session open\n");
+	ret = fork();
+	if (ret < 0)
+		fail_exit("fork() failed");
+	if (!ret)
+		for (;;) {}
+
+	ksft_print_msg("[STAGE 1] Child Process: %d\n", ret);
+	ksft_print_msg("[STAGE 1] Complete!\n");
+	ksft_print_msg("[STAGE 1] Execute kexec to continue\n");
+	exit(0);
 }
 
 /* Stage 2: Executed after the kexec reboot. */

> +int main(int argc, char *argv[])
> +{
> +	int luo_fd;
> +	int state_session_fd;
> +
> +	luo_fd = luo_open_device();
> +	if (luo_fd < 0)
> +		ksft_exit_skip("Failed to open %s. Is the luo module loaded?\n",
> +			       LUO_DEVICE);
> +
> +	/*
> +	 * Determine the stage by attempting to retrieve the state session.
> +	 * If it doesn't exist (ENOENT), we are in Stage 1 (pre-kexec).
> +	 */
> +	state_session_fd = luo_retrieve_session(luo_fd, STATE_SESSION_NAME);

I don't think the test should try to infer the stage from the state of
the system. If a user runs this test, then does the kexec, then runs
this test again and the session can't be retrieved, that should be a
test failure (not just run stage 1 again).

I think it'd be better to require the user to pass in what stage of the
test should be run when invoking the test. e.g.

 $ ./luo_kexec_simple stage_2

