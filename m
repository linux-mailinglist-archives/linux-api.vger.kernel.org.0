Return-Path: <linux-api+bounces-5286-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC6AC60CDE
	for <lists+linux-api@lfdr.de>; Sun, 16 Nov 2025 00:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175E83B9672
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 23:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63A92737FC;
	Sat, 15 Nov 2025 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Vv5M4s4M"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F9271468
	for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249665; cv=none; b=qHNsTQUZSVwRDROUTqADXnj4k3Xb9daLgoMTI39aqwXbx8iFmtADC/rZB4tiNKqyxXR8KlPCUzo9yg4DFaT/A6PNZLgcmCa8YKib/Pc58k9UFvUBmjkqEaKIuilZPMRhNi+3UfKIO7sKo4RAq+VNT6E8zeTY1AKzIk9TvpWh5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249665; c=relaxed/simple;
	bh=E5mYrrro8NuMkC7HPDRevyvgCJvESo2IchKI5QmQD24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbMDZx5hNMDIqESWvbpyXCqRJK1covmnH/0+JtOAk+vLo57ngSfVfIMR2PaEYhSqGutFMyEP/iIBkgt7aY81ZGAORpxyEr0KI+W6lX6sDBzSiOSfgcTmxuNqPDjF8ZbLA7G4LsPfP3IH3GEiMIh2aMnqYsyrYhJi3AE17YJrrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Vv5M4s4M; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f96d5038dso2589016d50.1
        for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249663; x=1763854463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffF6ShDH072kEeRsAneEmG7BXpD8z3YnDwKiTvXVzXs=;
        b=Vv5M4s4MbrZaPZzUnOkFJ76hhvkmuERgaGRqL1tIN8y5KepaYZOw/Tu+Xu3Edtl9t3
         25ZzhmpORqXbdS5edKlWEm8miyI4KHd7WrhVY/GlR5x9/Tfxa7Ehko7PnW0rhCYHMN9W
         2EByd+g5tDX+koAZ2B1VF+N7NYy39cMtfh0fgPezQ9fyndvKYl6ZhEVVAyTzRiT4yEoE
         m+4ZOebyBqp07E0dzUi/V23AdQIkp9wNWMusu9Jn+hD6trtyRonySzmz3T2beA5STHE1
         dnoMYv0YvAD3k9es+LFyckE4vVWCpJ8aJAPBjIbDNxvhtWIMmoIpAJbRL2RXb+kE6ELY
         Avrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249663; x=1763854463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffF6ShDH072kEeRsAneEmG7BXpD8z3YnDwKiTvXVzXs=;
        b=bhMFPaCuPDXRkSFbbp5XLnhghYhFUvta7fSPXefs4z8oFIvw/Oqry2bGpDEq410H9z
         4Eqx2bxBr+0sOp18s6k6mJ59ZK9v4kkn5Jm9LRqI8NdpnLe5XFauD4XF2yzQqAcU/F2R
         PAf/vLfwgaPzqHysdCAzsGx9fLWfHAYqMV5YcAPM6SNqzD0gMQaOSNRdstaq9gZNGnyw
         dNu7NsDa4NCWcjPUT2t2E5gYbx+vwKt8ngliwHJ4Eb7vzvbG4FyHQLxJ4405Wq/xV0ld
         qtSHQ3h3ZA5d7FMkhSPlp2gf3xPYqbWVHMNVk/8gs9oO1pE88fSw52tlZja4r6aZdziU
         oKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIgOdCQDl2ePea/JnU13vVhxD+r8XfEvDvb7fp38P6MWYONpWOeXGWQPxmKnvG7Yet/i+wgAhTFig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6ATa9OOUJN4iNyLb8iTIxaTHGnf/Hhk5IF0hb9AQFflHRS4M
	2GkCaKu92JINE7/RE1oQGYTL0E267abSWPAHNat0MXTHZg4isxr2TheodAg4d4Ef6X0=
X-Gm-Gg: ASbGncsZdDjUY+mrhUWbAetGz10YRB+kFllCni17fUl8pgPpoXEb7gFbEMSftTWbuHv
	O69ynp8FtoZen7hZXmvL1qar4U7yedK5qDqyf84tSvmQ3BCOTHq9v0rcbSuIY+5JEqxLYQGhAm8
	SQGWnZ2JkM3awYHuO/yfKe/IRQuImfjSmZcf6AKhFxNZAt7+4HY/z1sZR4zg/nZE0WKJM9vVZ29
	kQhZwSupfhfsRbg8NdX6zrg6WCNCj8y/DVQ6+IqkdCOfcMGVww0KUJ5v5C/Ry/L3VL87Yg2bulD
	afN7p34IrKzfsSGegc+/kgeB+6hv6uTSZYwW5KMUpJBeg2pbEa98hjV7/0LsSO1PP4Iu89hYB3l
	6jjCrPGa+noJLj6pti2pXhGcs4Nhkco9nRnKJjwnQtrVWlmNvUOM/FGbu/6gCnmbxmRe4XO3tjK
	6cv3LpIBcxwxCeFhxOpeYKfypAOCiHPk3s97G9rmi5UIlI/qWLUOdkEsrNDESisgPqZLL8y1XN+
	bHgNbw=
X-Google-Smtp-Source: AGHT+IGaaou1T8IlNwnvhEGAvgtl5hmvWdjNxQr9knw88/sarPOBHEpKzr0vdGK9CACIRmLZkXd5Qw==
X-Received: by 2002:a05:690e:4366:b0:63f:b6a4:dcbb with SMTP id 956f58d0204a3-641e76b2c36mr5840850d50.69.1763249662685;
        Sat, 15 Nov 2025 15:34:22 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:21 -0800 (PST)
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
Subject: [PATCH v6 03/20] kexec: call liveupdate_reboot() before kexec
Date: Sat, 15 Nov 2025 18:33:49 -0500
Message-ID: <20251115233409.768044-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
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
2.52.0.rc1.455.g30608eb744-goog


