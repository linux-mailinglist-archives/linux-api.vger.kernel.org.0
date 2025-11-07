Return-Path: <linux-api+bounces-5161-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF9BC41AF0
	for <lists+linux-api@lfdr.de>; Fri, 07 Nov 2025 22:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652864EFAA6
	for <lists+linux-api@lfdr.de>; Fri,  7 Nov 2025 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838B0339707;
	Fri,  7 Nov 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Dxrtp3Dp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BAC334C09
	for <linux-api@vger.kernel.org>; Fri,  7 Nov 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549544; cv=none; b=iD3CzItZEZVTLUCaSn6V9JBhAEhEpZMAnXkZ2cegpg9LPUqD/fy0tAdIX+7bV5lR0b2D4bwqZdhZzMxO3yvHeD/qAChg1N0Vhxm98Rcwkx4kEqnLn5zf9s9VlMxg0PFoIQSRxH4TbUFWMPwJTTT79BhvuVRZJA5wqTvox+WCUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549544; c=relaxed/simple;
	bh=rJJzACH6ND4KsnbPDxqHJ1cqaNF23c/cUIT9/Mg0NMc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTgmQe1X1Al3QIWtIhJcEv5JeVKtorpehG1ndYZ541eA/xNv/1IEdJyqdLjEbOsN2f5LSzgsbvl6PBquC3hy7xGm8+6qF1L0qRmuSnxQ0vSSV2ZNRrCSPYXHiRVy/VQwtZq2sJFz7F2Xn+/dujGJho3YFjBWQFlFzw/BA4TSfxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Dxrtp3Dp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7866c61a9bbso11319467b3.1
        for <linux-api@vger.kernel.org>; Fri, 07 Nov 2025 13:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549542; x=1763154342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9ls15f+4MIh5Yb5Zu+WvMWjZ1HqhhM9dptW1sLofus=;
        b=Dxrtp3DpJ8bM8lUNVIKmMBmLhQroPEWgsBFR8pWmBfpoVhz3x2TFW2ZT8YQtHeAv8n
         mAs8UBGOJehkVKbX2yFsXnkNzBIeqH4u7ClYrhMp5O5YSfnK3/n2/8Wy2NQAOspk0USY
         FORl/pAIc2ra5TUvQR4sPksfOVdfwCboqX2GSOBiSwFsAQROk9+SvC5uE/RfooLsaPPv
         N++K1UzVnHxCu1NC7n9U0DBz2S2/Q85ORQR9sT4ya/Mjq7+LK0NPTnmlDZPOQjcr/Cpx
         CpzSlw873HUqc0+aitwaUsBz5vZ9Ea/VlGLVc30uH/RS6F8NliiGwK0NidR+IYJAiT81
         mxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549542; x=1763154342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b9ls15f+4MIh5Yb5Zu+WvMWjZ1HqhhM9dptW1sLofus=;
        b=g8IVRvjgEjqDCzV/srGtEPH8OXfwdtIfjahb+aeW1rhEQSG05+648/0+S1riE9rQAd
         eOnDOG2/QmHWpKckk0+m1e/hJ5OBKql3WB+Vh0kLmqriite/Zts3NC7Bt8Cu3MPOCgUP
         2tMqY0xKD6x5YoXFBO8sdDfrfBaqKF9xQHjSAxCk1m+0GX3QI6ZfhichgoePqWwAswXJ
         JatvKmVOA0RdCdU/7U34NW5aOFH41AO5yoPK1NWSvLK1vQPq1QOct/cHwvlPIc5MCs8Q
         SKNF1c04TkLBXvDH7EkYdZfjcFkv07eMsAUxScGoqImmoS6RSIDakOEZmmQxRhYUHfdp
         FZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCViZK23Ma9J2OHbRKjpYG4rzralkWqM7DX2J/QLr2Gku7+aLoUJioHQGwcoxeVE1sbMiVR2GyDwYkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHiAUn+Zy6eEI5YwFkSPp7PteptvjssevjwbjyJbnqitWvOmxS
	lqLuT0cUpw5a4RKifWp/J4qwSV0medX/+UBWM11PeJSpTJAQyUchBmNq/zvT7Y08K7I=
X-Gm-Gg: ASbGncvhKRePxWS43c8hkNKoN4vRhhwdks+Tvi54aumOAS6RgtKnLOQM0m99DLixIK8
	9ooCUA++s3QcDfpFeAi4+pet/To5wxJ/8hey6xyh3bpQKfFp5Y0OpKntqZdqn8ujGEIL727LRBM
	JgCoPwOa43t8qhaN2wogAqxkO3APD8RLig7NcFuGqwZ1LGo/KBTJNVV3wLx+CmBcjRWgK2hvuuY
	tBcIFMNTLpck1hWU7XPR/8b5RjxKcLq/zXRJp+c2LpjdW7v+q+2p2itOuywa96m0KwJBuxxQUdb
	xs2sJbpvR8xrbnE4oLT2Kk2uqYJsmFitxpotyxm+9FPEixnzOhSMq9H4uO3jNqI0moqfCWQ+OFO
	kTA5tEHXNZK27pdcAEp/jLbIzkW4LVt5ixbKKNqXnLuA42O0fDppeP2/Hy/FVMNcN4eUTJmnt8g
	5xBOEUNGiZojJOl7rHm1NnrOZ65lYP8mUKMpUQLIT5zLPPhjq2Q9TvfdM9fddqfdU=
X-Google-Smtp-Source: AGHT+IFMBy2As0ojpganARRAtGLKmm8lcgodoc22XvJ7tunGfpqLiCKm9BOIEA7E25Bvbl2mUycg2A==
X-Received: by 2002:a0d:d0c5:0:b0:787:bf16:d489 with SMTP id 00721157ae682-787d5467e1cmr5985997b3.62.1762549541688;
        Fri, 07 Nov 2025 13:05:41 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:41 -0800 (PST)
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
Subject: [PATCH v5 05/22] liveupdate: kho: when live update add KHO image during kexec load
Date: Fri,  7 Nov 2025 16:03:03 -0500
Message-ID: <20251107210526.257742-6-pasha.tatashin@soleen.com>
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

In case KHO is driven from within kernel via live update, finalize will
always happen during reboot, so add the KHO image unconditionally.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9f0913e101be..b54ca665e005 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -15,6 +15,7 @@
 #include <linux/kexec_handover.h>
 #include <linux/libfdt.h>
 #include <linux/list.h>
+#include <linux/liveupdate.h>
 #include <linux/memblock.h>
 #include <linux/page-isolation.h>
 #include <linux/vmalloc.h>
@@ -1489,7 +1490,7 @@ int kho_fill_kimage(struct kimage *image)
 	int err = 0;
 	struct kexec_buf scratch;
 
-	if (!kho_out.finalized)
+	if (!kho_out.finalized && !liveupdate_enabled())
 		return 0;
 
 	image->kho.fdt = virt_to_phys(kho_out.fdt);
-- 
2.51.2.1041.gc1ab5b90ca-goog


