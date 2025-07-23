Return-Path: <linux-api+bounces-4214-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F14B0F613
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 16:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41BF58835E
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B09F2D879C;
	Wed, 23 Jul 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Yyy7zBhk"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD52FCFC5
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282057; cv=none; b=ScLQzcOOXj2BtgTtvtG1F0/kHijBSNCbCq31qYxmivpLEXj0by1rCRveK5tfVocGWKHFXASMtENoQnMGbUPoTmbVUvhdhKaomkVvmuNDHA/RwjRPwQ85sEeQOA27D3YWFmxfDH1/fJtpiBseFLLPWCAIMQnLCE+P3UyeJoccRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282057; c=relaxed/simple;
	bh=MeL5rpabCOQ9W64WCDzEoX0aCqKWSq3A09PvP5YRATc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltZypk+K+ECFZM4sGgaUaKeB3Py6X3QhICSi7e+XKp39tnF5viiD8TdLeBEZwzCM/j0rCBC4smrJ/RU+xfhAEOwYrtCPVZjFSCreFTzVbeDa6niwWbOXVrfQAU4+f963ZjRbPloYa3Z9fUw+NmasaVxf/jKdvdKd6KBDmNj/8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Yyy7zBhk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-708d90aa8f9so63909117b3.3
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282051; x=1753886851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FWnE5Bow2uoaZcwISvBgq/4l5cKqkAoia4t69mDLc0=;
        b=Yyy7zBhkzE9t6E8ma3qmVy6Xxm+sC68V/EvMLhqxTwRVXtMOh14j3t1ZR3jFnbZhVL
         gCkDWN9JRIpqI0pgC4qc/1p1lbggJ45t6IGJjc4xPt4zCxPSiAf+WEr71IZGBO3tpMt9
         eEX17hJV+76mpL8wSoMwgWYa/2ogjO5ld5LF5aJ1V+YRv3HP68kBDUx4NY237tGtBCOR
         PTOYqBRUi/RVpW0msVaUOV57yLYuQc/88nP1HQY0dao5tosixpnQXVvdFwRIwv8AiwE+
         DGy6dn5kCoPB5xFMr4f1quxO+OyymmeG7L1abtzK0tX74IoFqMDmbW7ibeukt4TASkub
         2HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282051; x=1753886851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FWnE5Bow2uoaZcwISvBgq/4l5cKqkAoia4t69mDLc0=;
        b=vhlUGUVyOtgHapxvrbEqusGoSXKv3ZN531m9dfW2KSEbYbwluOb5AXHJ01SKrBLdXv
         7mypoYEFKUCESJtt3WsqZo2yKBMvvNGPIH0bjdjOLTw+On7g4wse31v4gC2Rw750CYkB
         egPWDuJfp91jM+bbWPZwH8HwCwY8LeKVz6tZQXoq4j8Uz5adChH/GM4+srmsbyRcmRIB
         w0trPVpRCf/fYVMCGDH28+jmskGVDKzn9wVJxGoI8hp8acpi5kS9o98hvVcOHNcQjenY
         YVz17ZkZD/gagVnzYtKb8AMeuRFrIS3TJQgOp5RNVoXPAalhgcjlTqH3O1DBCu14as8o
         t8cQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3t9Pjhgdv/YGt81Z9Lditd3PIcgNQfBlWbJko9vugL/P2M+tyPCaTFgybwaMCruR41QwogJkAzIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvaotFG541iH4Uk9ZOJ9s7zXMvSlwoXi4sTp6NOqgv7mLOPqg6
	mvc/cUQAudPhTxr1sp+da4nIQR4VvLECuMv2xp9XPqrvpL7J/PUQt4dXjXt+/hfsBJ0=
X-Gm-Gg: ASbGncvAmpSA2L3upQGoxb7LcfBUp+GstBmal6MlMGpn2nVcA/1GrAGJCcFQQg1wjK4
	g8peCAI88xqGT7PHf7gHEkop5IwMvka163BOjklqd0eioe2ohwPFQkBqMbQDNiGGxYtq09xd1WG
	XrovcHeaqgwv9gouWN6KMadGdpO2SYDp3TFL27c+1H4PH9DHXCe1GXtRZmOWQJq4R0ehPNJF9Zw
	IY2A6QwS7mPtItn8jvwm2/ULXhDL7DfN8QS39x3z68W8KNfUolIAIoYvsyG7zzQRz+krxNtKza3
	pxxho/9B/daF2/jdp3gOcW2SxGXvPgKymzs0EQ1S2QzGS+l010XnbiyBrkYGCEmsSUZiVKe/EVv
	0YMeOpyhAH0ZnNUiJygi2OZv5RP7EHketaGVNnlJobfBHsKkHGZ0CyWWLioqjkph3LbrsW7QThP
	J9/FqG+Z7T72fhdQ==
X-Google-Smtp-Source: AGHT+IHLyQqcsnOqnRO6HNMaeplbRrfZNdB8+kP2xWX2qbNG9/moHQNfSe1QScqIpYGuy7dJX/Q6FQ==
X-Received: by 2002:a05:690c:d1b:b0:719:61b8:ffd7 with SMTP id 00721157ae682-719b422f811mr42827367b3.16.1753282051271;
        Wed, 23 Jul 2025 07:47:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:30 -0700 (PDT)
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
	witu@nvidia.com
Subject: [PATCH v2 18/32] reboot: call liveupdate_reboot() before kexec
Date: Wed, 23 Jul 2025 14:46:31 +0000
Message-ID: <20250723144649.1696299-19-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the reboot() syscall handler in kernel/reboot.c to call
liveupdate_reboot() when processing the LINUX_REBOOT_CMD_KEXEC
command.

This ensures that the Live Update Orchestrator is notified just
before the kernel executes the kexec jump. The liveupdate_reboot()
function triggers the final LIVEUPDATE_FREEZE event, allowing
participating subsystems to perform last-minute state saving within
the blackout window, and transitions the LUO state machine to FROZEN.

The call is placed immediately before kernel_kexec() to ensure LUO
finalization happens at the latest possible moment before the kernel
transition.

If liveupdate_reboot() returns an error (indicating a failure during
LUO finalization), the kexec operation is aborted to prevent proceeding
with an inconsistent state.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/reboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85c..bdeb04a773db 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/liveupdate.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -797,6 +798,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 #ifdef CONFIG_KEXEC_CORE
 	case LINUX_REBOOT_CMD_KEXEC:
+		ret = liveupdate_reboot();
+		if (ret)
+			break;
 		ret = kernel_kexec();
 		break;
 #endif
-- 
2.50.0.727.gbf7dc18ff4-goog


