Return-Path: <linux-api+bounces-5503-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C1BC860F2
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 17:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DA4B3509DB
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC732AAB8;
	Tue, 25 Nov 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FrlAXVcb"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACB329E6C
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089944; cv=none; b=XgkrWEE5nTZfjMyMK2V3bwnj8VmLRd3tL4H6Eu0b81r05g0v1/n1q/FH8jWfWsXezkc2m5GEOg0tC9QI8fGu5luhCbbxpXpl+g/Zf9IcIlDpuCXg8QOuqEb/69gMJYNbfEI4hTNSZZULhsyDrXI+k7fYI3FxzzF/31BCz5B5Gns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089944; c=relaxed/simple;
	bh=9ZUelKfkvPljv8oQXIuVk1CLomlpXexOI6vdtHAFbG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdqOCJRDLGdoQ1rz6jB21sziyVTVGsGsTo3p+s/ucwplG3vg6W8S42aQV3qAjJiVBlBIsO6Scx2zBsBMDb2dQuhw9lP7sXwAAqCmWag4o4nPbC20vgjgR/O4u+0Cqkr67HS6lPzdonAFAY6rKqlYPYX7JfiZhPjp5A8I5r1jtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FrlAXVcb; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-787ff3f462bso234317b3.0
        for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 08:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089942; x=1764694742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpaVBm1+//tbxkEQIq/GBWXpVmrV48zOyAjTKxFhzXo=;
        b=FrlAXVcbXKUKJcNPrA0qKapgEF9UGLCsmf2E2yXVjGe4RX/6b3gE5dunyIWrHMqCaT
         lWoHwF727hAakvpRD8uMfFVvi/sFXq9MgB12IxlF+ySjdjWTNS8H0dUyelhqbmVbINDe
         rLAMTvltT4ezjlK8okW7p/XSjCFjQlSAoxBgzJZkxBbc0eBvgBkcCvMWhtAkH3PcjGxN
         Yg76Z+7qEHuLH0cax9MTkIVeHQWnMTmFdG1Doriq7V3RIb9GrW+EJ5La9lh78HSankZf
         v1fPfW0Yd97G+LVXu3IMPshEzhl6XXKLAHQ31oU8alh9Cu8h8ys0Ln60bgicf6LOJrdh
         UZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089942; x=1764694742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XpaVBm1+//tbxkEQIq/GBWXpVmrV48zOyAjTKxFhzXo=;
        b=BCdCYtfDP/2VDhvUW+hQRKVSBY3Egg5zXFvIxOLJorIzOdHOBg33oCmwzzo2wFz5sw
         CO/YxULfvYM91F8KbX4+wXzoPs5pi9LlqaQK8u0W4Qb+hlXKE2xKrsXH90lsHaQEwGTM
         FsTHbgEIUSL9PLX0czqqRXSc+U7Xi77mKvAAZUuuZWwz+meU6aa4si7/mYJNCcwof8UW
         Y8UDK+Khv847ytYzNncJE3vQiRR4y+RswNN2XJFfVeByS2RUsw0KQ+5V5YG1/oma39Hl
         RE+zgcKIimQA+8PhpP42qkBNmQD5pDpgyPFNeeygyiLJuKa88OtoaC7QcrRxBEjdWrgs
         1UKw==
X-Forwarded-Encrypted: i=1; AJvYcCX6zNG+96IzcGYIVSwxIVKnMjx91VkoOKUPs/apnyszucj6xXBhEb0GnUH373dgnEJKdRx0Y3nl4FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywoVxaYnAHGh2KXFSdl8Rib3JnTaHvBlerI3CqApUwYUwYzzUP
	87E3R1dAJk7iE8EyokdhkHLJ2RwgmWCFkvBLyDu8UNHqw1smKrLvkGDu0aiwgisnSTA=
X-Gm-Gg: ASbGnctHKzuH5wZNLeKI/oJZgHojVvj5V3eJDl8H/ai88vHh3/an2R75rJyufpU6HWC
	KqMkr31Tv1r+zz1IjEO6v5Ko4tNxEX1TBJ+Dw8lBwavustx/XcmynYGR3tC9lOdaeRL84jD7zo6
	eRB8BumAzzcNPMon88ANvVEvlihT7r04L2B6WRJg6qpZXen+eXJPLRsUmLbPqXPmebx6cdcnP/Y
	i0xnHbtU1LkRl9n2utU7PWZJZ3gd5qq3de7it9ljKzazReExgillKfQ7+Ak2KvquynDtSVnydEz
	4Li7+0ONtfoeGlXuzYZkqXRoN2ofuBBhtdMcIpyjH8vY4RfFCSYZuT7ajSlSTm71gqsSfkwYrCW
	ZAhLRVEnew3CV66sRBNrh2cFH7r1hG2hMhdfTPtcKhvnNkY6UJ5qyp7mKi/Q5a/bZo5C8XXH1rf
	MpRa/vdGzn7/XHAs5aSVvD6Z85+dCAhf1PoWS3azoyEdngIaUiJtPBkaV+hA1U2qut
X-Google-Smtp-Source: AGHT+IGT9/1MeLVmxLppNhw6ATfBnky7RFeGJGgEupGtHFRdbpi4HufaHsrUZln7Z2M/tCwpjqT1eg==
X-Received: by 2002:a05:690e:c41:b0:640:db57:8d93 with SMTP id 956f58d0204a3-642f8dee6bemr14317878d50.15.1764089942010;
        Tue, 25 Nov 2025 08:59:02 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:01 -0800 (PST)
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
Subject: [PATCH v8 03/18] kexec: call liveupdate_reboot() before kexec
Date: Tue, 25 Nov 2025 11:58:33 -0500
Message-ID: <20251125165850.3389713-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the kernel_kexec() to call liveupdate_reboot().

This ensures that the Live Update Orchestrator is notified just
before the kernel executes the kexec jump. The liveupdate_reboot()
function triggers the final freeze event, allowing participating
FDs perform last-minute check or state saving within the blackout
window.

If liveupdate_reboot() returns an error (indicating a failure during
LUO finalization), the kexec operation is aborted to prevent proceeding
with an inconsistent state. An error is returned to user.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a8890dd03a1d..3122235c225b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -15,6 +15,7 @@
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/liveupdate.h>
 #include <linux/highmem.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
@@ -1145,6 +1146,10 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
+	error = liveupdate_reboot();
+	if (error)
+		goto Unlock;
+
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
 		/*
-- 
2.52.0.460.gd25c4c69ec-goog


