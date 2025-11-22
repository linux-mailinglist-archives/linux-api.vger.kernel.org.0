Return-Path: <linux-api+bounces-5425-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E40C7D882
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 23:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 439F04E10D3
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 22:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDD92D3A70;
	Sat, 22 Nov 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ahw62As7"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFCB2D0600
	for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850245; cv=none; b=MeAMUL5aMvur6yS/kfCxO1ZDny0qu8T2RnHFExDRlYLc4lXZiQqcvddpGVtRMCPPy374gkKqLsvqNkNk8DS1ZYmXpnEcqgnQDBaRN9oW+asjFvMSt9JUNtGZMN0rICEop2RjV0FBa9mfZfZHlGrIVBL1UOQ3q3NgtqrxXIWP7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850245; c=relaxed/simple;
	bh=yqW0eNnuY6iaIAb81qp9+q3ixuk1RWq84gZvp3pOj+Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MavMHovyjP0tO0LB4vq6MI27SeBxsP95zP3YNILG8VJjmn3+snpK63clvhhW29SCscFjsLyCtCfZFftoZGJvjOO2qnjHyav/zF249sA3dvpFC+5/qD4EpyaTjUX0PknGYgRL8Mg7RT3izgR4ktb5IHvssj4ynUGw0amxZyTMiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ahw62As7; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-640d43060d2so2756114d50.2
        for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850242; x=1764455042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5KiW0twGUwiDqt6nePE1kGiL7dytg0Q0KVXgthRcks=;
        b=ahw62As7z5Pp8+KVpJHLR9K98pdIlj4hIScu5BSMiqHYogLBwdt0Z3cU0D8d6e4cQt
         KEdBqtYBy+hQMXiTLQf73825DkW9KUJlGFg5wrca2+TTLZI1Ur4KXZqPrj5A1aLjpM3v
         w3L1ODvFkjxH01tstd9dWyuBICRTf96ckT7HYnN7rCREQ5ruCucOR91nlwm7W0CGPePH
         yoQmUtOBjgdVuBMaCbFfF4thHh/bOOVJImlmIY2YqT0YGOqj2UzZ2AZpVIixd38MOMNp
         UVM5X1Dlvuxe3qHPkEuvpKUCjkPTOehJIUCBlwzitQsR1h2Q4l7ayDq+dCI99jJVKS0t
         +7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850242; x=1764455042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5KiW0twGUwiDqt6nePE1kGiL7dytg0Q0KVXgthRcks=;
        b=DUnTWKHnotG/rhsXtWISavVp4uQoa/JN/1w23N+CPqLl8UdyTHiXheqMHAfoShjJqz
         88mZkv8jehITGk18BrGAfmC80KsRPDu6zzzwaqbEWC/VnmcFv/92dwthasisQ9+AIg/a
         xu/wzcl5gfOw2kmFk2m9e43FQyGnTvmOHzLP9CXAzd46vAjPo30Qu/WQ+U1NTcLrgN1I
         oOXJzYFd606FCOlfyDu1gkTgsjqYks281/SQ+Fu7ddFu6fpjphu2QVSDCC4x3Zv3S8ay
         IUarZGAbXQgyoaijh9EKxC/4cg+NhY0ZigmAw0t5VWmAAB3pyUi/YXiAuNPRlYD7Nl7u
         GO+A==
X-Forwarded-Encrypted: i=1; AJvYcCWh5/3vB3j/WnEfXO0ZY5pktuTDlc4i7NvQKknMNVktHvG5u54KLPeWTDoFjt9+7Ag0aRnQtlqxWCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0E4ga8bu34prMemeZJ6I8lf0tRcPopqIAGa3c1G2wLCC95Ty
	9K3aZLZ7RoHrcT3mHeqW67sION/1Pwaar8ld1M7VOTTlbdzrCIOPFUN3fTLkqzA9ET4=
X-Gm-Gg: ASbGncuLFWInol3v6+EA4c0wRdpqqzbQFoIW+q4mHFkItpl0e/6lz8dh5kkXGWk4cJh
	MzCiwZDAyatMEbZLLP/OMhz3QFXl2LTUugyhp1ed9op8rUKnsHJtaRgJFs037/+lAa6r3nglaO2
	CgVneEAiYYVgHIkdhHpC9fIkeTTUlmsJ73nKFpBM5kIL6sf4mQgNfK9tH0ynjIv/wkFKxlgmtrP
	AQGcnl9+oi93DfUG+j3R3zr79/pAaEiXxFurM1J6h68p9jqBUvspUpORYgaeGciQnSg4CawsK/n
	3MOMu6OtMTOWitO8KH2u20uyVs3W2CwHwGwQa9/9SXWm4HiQVMM4kmPcU1bpVOgfS63y8UDQeQV
	abVA5cdtQqVJTCC84D8YbZoGis81tdOw+qGCTorMuoV451VdJt3GEgE1P4C/FhJgRUPGWg/M0fX
	sMOC+8JiqX7CWX9nwe+QBM55EKxOuhpP3eB0hawehX3mlkegsMcwU8IzKFnVkpkAxdpij1Q7Tl9
	moxT00=
X-Google-Smtp-Source: AGHT+IHuoY23QTvRNhRkhmDmGHRrDBpwbesFLAGgRZdemrA8LoJ/P/EIeiLQ/hTmePkctRQeLMtVhA==
X-Received: by 2002:a05:690e:130d:b0:63f:abf6:1c9 with SMTP id 956f58d0204a3-64302a4b3fdmr5160190d50.25.1763850242430;
        Sat, 22 Nov 2025 14:24:02 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:02 -0800 (PST)
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
Subject: [PATCH v7 03/22] kexec: call liveupdate_reboot() before kexec
Date: Sat, 22 Nov 2025 17:23:30 -0500
Message-ID: <20251122222351.1059049-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
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
2.52.0.rc2.455.g230fcf2819-goog


