Return-Path: <linux-api+bounces-5159-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0353DC41AD5
	for <lists+linux-api@lfdr.de>; Fri, 07 Nov 2025 22:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 274B64F3595
	for <lists+linux-api@lfdr.de>; Fri,  7 Nov 2025 21:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71632329376;
	Fri,  7 Nov 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bN97aslA"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659902727FD
	for <linux-api@vger.kernel.org>; Fri,  7 Nov 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549541; cv=none; b=rUjLOA45QSUGMEhBIm0QbnURT4jQ16L5b7virfvKsTqQMFjm4bFDofz41jeaSyKI7t2kOjDi09E492sXtLfdXlavKbY6nDFz8ixomz7FeKVhNcUxBQ321QV19Htn6cEaFEQ50LNowbxijekSp6V4kAx4rZ/Nqoi9THLNDbIv5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549541; c=relaxed/simple;
	bh=frmW4uur/JiJP0+axQ4M0kbVoUhK8VyFB7s+YzrbZmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+dRpYYVYFNY7JCuOaHP9CmslzvMzp9BYFPSRZwsfhoI8BTTuRwZPM1Kg9lfcZMzI5BaEB0Rt3RJ2bMIixJ5kO3KQDwdATr3lhN4CnjklZCchW+RGJOWz2PUrlNqAQfBbZRpJ+7WTdgWpfYWIkIyLRXVNGideiGvPan63JvQf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bN97aslA; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787cc9de986so8595147b3.2
        for <linux-api@vger.kernel.org>; Fri, 07 Nov 2025 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549538; x=1763154338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAfmXKExFsP/wCpt9jvB5iXqu6nwsrz4tNI+tUSnwDI=;
        b=bN97aslAgDHF9EpIrRRoahib39FwTlRaylf7ZUHm3nMtLWNtDm0fHBnz+9skzMLgoE
         q/YLCa6wI4G8G9pFzO5+mPiBGlK6yZpsAm4gF5s/FGBdLOEYWGQytYNw4aNHN5/0CZus
         znKxXV4D/NC+3IlLnVBBTgIMnyyqiyVzmwd7hG8xPEgos8oo51nFd/yJdrroy35XcJmg
         TX3e/r+hAP2rLJWc78b+k5LWRuA6ZBC3uTuS+WGLEB8DHQlbpJxj3y0llXa7mR215Gbz
         PKWTow9F/zRCRED9CrUDQdcYpuLlEUVnpBrYB5esWwmM+DtrwLqRVysmKc9WG8IeZ3Vb
         QgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549538; x=1763154338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LAfmXKExFsP/wCpt9jvB5iXqu6nwsrz4tNI+tUSnwDI=;
        b=C8BoCC/qQRbd6J/uOwzlIKPVY/08EkphgOFCUwDnjwLoc87CbCRVsSzj6To9iyspjZ
         Y8I6Jvx2EVi2diuODxbVOl4O8NPXZHv4rsE6Ten+h+8lUu0lHT0Jz9lRaZjPRbEmfSuW
         3df3QIAxeo+ABFESv4i6eeAtwGL+QiLM68oN5JHkNIge5cH/aTAnSCBNJQM49Mb+RwcT
         HRS3kNxsrlXzoo1YXNA2AeccUp27V4NXRG3pjD7v+ydOXaRx+341XTtmxc0T0KsgfkB7
         iEMMaOxS525+lvHHCByD+g0Sy95m76Hczb7PIphMY3XpJ81rzKRbLqPoiYFEeV0BwCCX
         Fjxw==
X-Forwarded-Encrypted: i=1; AJvYcCUj7172z7A20lPjPvooHUPYq6Pwa0Glt0z6VtqLLt4wqY9WnvuulE+clLwd6Hq1QZ5yKitb5djM2Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHgHLii1rPboFwsYk1NJieIuYVkqBBIdP7zJ1f+0FRUsJ4TZjm
	VwY894oNAYlQBA3lsYkX/4C0KeGutkFMrB0c04eOx5GwdOdgQjNChA6CqIb9D40VbFE=
X-Gm-Gg: ASbGncsLB+9DrooOqAzwhSgNW74xMPit655wUN+tuuF8Q7Are4NAi647xkVCbrgcpvb
	bk9500F+eCBIoLdzzIZMi0r3qKvGhixcFv61pdzTTKcXgHIA5pf7nvzdL0sDNla/+McIKGj6EO2
	oQSzTKM6QQQvoHFvMtt/qbRh3A/Z0enXaPVQU+16afLJpCyHUh/HnqXVwG3a11PJ3qO5C/9LS12
	jgPqMVjP6IA/CbXbTByol0fAubPaYBPlf7IGHrIq5kAMlaWEVggjLb20EmGubj5sGDAN9qv2C+w
	BCP905xo5Eqw77u4THuheZd3D5gF7oHlhGx28TeKkZBh9fhaQANLUrUZAFnpwrZJ3LbEULw9SuU
	rOfeqyRQxv0A4nnzqTNZoIBgbfNCmDGcNh4bpqGiIyC0VCJYCP2ts0L0TrQFjl44A49bJLlolRc
	S5N2446bKW2lU5mOLnA2oAI4xYxaHlczAZvE/jhN9qoq/aw+gsWlf6UxWgnIF20pjJXRW5SulP7
	w==
X-Google-Smtp-Source: AGHT+IHP3QoDDPe69Dq6qZNTn006B72sZIHWCNrPLWZh2Sy97b00SWoXLarWg9cKIVLBa+/0WbjfEw==
X-Received: by 2002:a05:690c:a003:b0:785:e76e:59bf with SMTP id 00721157ae682-787d542919dmr6289787b3.50.1762549537853;
        Fri, 07 Nov 2025 13:05:37 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:37 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
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
	chrisl@kernel.org
Subject: [PATCH v5 03/22] reboot: call liveupdate_reboot() before kexec
Date: Fri,  7 Nov 2025 16:03:01 -0500
Message-ID: <20251107210526.257742-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
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
function triggers the final freeze event, allowing participating
FDs perform last-minute check or state saving within the blackout
window.

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
2.51.2.1041.gc1ab5b90ca-goog


