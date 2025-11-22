Return-Path: <linux-api+bounces-5435-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB4FC7D921
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 23:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17E00350933
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC312E1744;
	Sat, 22 Nov 2025 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="V39WykpW"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB842DFA26
	for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850266; cv=none; b=ElxLVJ5j6bMGQudklFQqBwY2p0o62pU2dWwTr7XkETYjztyU1ZGRTA5wglS98ZzlNxaemhvHJmf8Dkp9+zQUMaNw6J5/Z94it2YYIA7GkImNtYp7ATbJ0R+QMFQGR3AN6F2KPuQoNKGkVbvD0HdkZ8jR2ogqEqVLA4TXLMMagwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850266; c=relaxed/simple;
	bh=0xJF18qOKcU5eAzQ6HxIuG25uSo6cc+l5rprPtdnC7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCfYkfmjo7GfVQclIEi4GZUpTUGOPNFiqZHrl6ARK4aeeM2iyW2usY7cXFqVLGchovvceQXsJuMH/Z4QLB+PvSC4AZFxAbky74/QXFbE2SFUqYhs5m/aLLiScHItykDew7tdRbNC0vFidTlLJtjygLb/Tm3xoIxEBflu+XMxxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=V39WykpW; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78a7af9ff1dso30358157b3.1
        for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 14:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850263; x=1764455063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ff4h/Y+aeCaryuraEaQmIoWWBfglnwQ79bUWNkRIqMI=;
        b=V39WykpWUjGUgm+ihW2Lf6k42X2ugYC5LmhkjulLjEOtWOR/Q+xaLPN+L3OKHyYNef
         GK22D12dfWSwNm05DVqmbdlOYE8z9y1SCTsJTd/mpp4I/v1Yr33e1uh/VCw9Ci+j5ym9
         ZE3kh9FkMNA3ptK8GsDCh9TneMNzQ/AS+nb+FGvTLZ6sUC8WnsWZjemhW98dypXFeuci
         Gw+xREXybTuIkhJhfs32e62gbzYiCTubfGKGU+2TN+NkM+y20lPwxVInI1k8klT610B3
         WTsQzOD0J39F678w5Q/6wPWbi9wzHZ8FvmhVlHcgA24gccdaY/lr+QbRFElZWgLX8pp4
         boQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850263; x=1764455063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ff4h/Y+aeCaryuraEaQmIoWWBfglnwQ79bUWNkRIqMI=;
        b=vK2CP5s+CcbdBF1xKZgk7kQ+ni+iv82gSd03BcCJmn7W/Z/I1bVaI9nk6asMU5HpC4
         0nPwtzG5zokpoCroYGGbEo6mx8yWUWUAvnFLQKv6GKcL3toX5/8S0r+KbI5dmQnQufbj
         i7WsaqevWHKhbtfcYLPcIs1LypDCQ3tdBlBqdtaFYlTZbiHhZSs+YTmhVoEuB3ePDPuJ
         JIpO1nOZZae4HSjsgLt/ahTesA0ZLKutdtspBbttVqyNTLPAZlkmIqQAj7cB08CGEIfD
         QvmchpHgYZxmMcuERuR7FvyEtMMT43VyiWd2SrvU/96i58BrFfnmEmR9ClohBzE07mse
         R7SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjHRn7MWSSWeqFRcF05fGLBmWjbdA3vLbnrC7qg4JbRMJhauyZ8NVvCxwE/pNS24bcZvrnOV5oxrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAE2TKDWgLa5SHpwWnr8VatsrFzArb6gHDaBxjRvbA9I/sgbM
	dlGhfoyANPYV84kKn5jdmhi4GpV7YCV23+QngL3qevrnIhNdTLOauKCpmhgrooWvzeg=
X-Gm-Gg: ASbGncvxw8bgGlKytgBza3+Yomm/vYxJPjn343doL3vl8jb/c/hRh2ejBX4qMwxamxX
	VuV8Mf/fKLNOVn5XLKvvrpV2oKSVDhrSzv4EW/bSPjOxmM7QXtXvDlvgKhDAWDGscypQXSkRk0h
	1TLxo+u5lzISt6u13Z+nlcdgg45qmkb83irVkAEFRZ2pMHIhk5Sc0LpGRpP0UnrMn/6bcfTsUxd
	iuGWFJD4fYqIbqfj/dkmnwV5PX1Cc01zPs/ed00uJJIS99VNwdntJzn7/eZi6UR/bl3HHILd3H8
	FNheOWRDD9fEKilvfXHdyC8aNjySNL5cvvdEMD/M7TAfvHRgh6BdZ9nPb+QAY8p9xJEbkL2z10V
	mpka2gWm0kMTlJ9hE2EYzgohvCha+DyWt8jygEosQR54C+5pZpSk1S2c5Xrsk+TjZSMB8YcMpKT
	P5GryMnhQS/XZSgMfzrlarJK5G8FSVrQEboCT8Ja62r/+vvrbSycRC+OKchL0nScMBCdlL7nn21
	U9Nesc=
X-Google-Smtp-Source: AGHT+IEh/qsJ9xlDDV/YCr14e57USKSEfNEr00YTzpdoNrXFY7RlW6SCMXKos9LFs3pSvdRKqhUulg==
X-Received: by 2002:a05:690c:6282:b0:789:24a4:59dc with SMTP id 00721157ae682-78a8b54896emr60698047b3.70.1763850262632;
        Sat, 22 Nov 2025 14:24:22 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:22 -0800 (PST)
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
Subject: [PATCH v7 13/22] liveupdate: luo_file: add private argument to store runtime state
Date: Sat, 22 Nov 2025 17:23:40 -0500
Message-ID: <20251122222351.1059049-14-pasha.tatashin@soleen.com>
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

From: Pratyush Yadav <ptyadav@amazon.de>

Currently file handlers only get the serialized_data field to store
their state. This field has a pointer to the serialized state of the
file, and it becomes a part of LUO file's serialized state.

File handlers can also need some runtime state to track information that
shouldn't make it in the serialized data.

One such example is a vmalloc pointer. While kho_preserve_vmalloc()
preserves the memory backing a vmalloc allocation, it does not store the
original vmap pointer, since that has no use being passed to the next
kernel. The pointer is needed to free the memory in case the file is
unpreserved.

Provide a private field in struct luo_file and pass it to all the
callbacks. The field's can be set by preserve, and must be freed by
unpreserve.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/liveupdate.h   | 5 +++++
 kernel/liveupdate/luo_file.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 122ad8f16ff9..a7f6ee5b6771 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -27,6 +27,10 @@ struct file;
  *                    this to the file being operated on.
  * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
  *                    this field.
+ * @private_data:     Private data for the file used to hold runtime state that
+ *                    is not preserved. Set by the handler's .preserve()
+ *                    callback, and must be freed in the handler's
+ *                    .unpreserve() callback.
  *
  * This structure bundles all parameters for the file operation callbacks.
  * The 'data' and 'file' fields are used for both input and output.
@@ -36,6 +40,7 @@ struct liveupdate_file_op_args {
 	bool retrieved;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 };
 
 /**
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index f10d6c37328c..b235d1b562ad 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -129,6 +129,10 @@ static LIST_HEAD(luo_file_handler_list);
  *                 This handle is passed back to the handler's .freeze(),
  *                 .retrieve(), and .finish() callbacks, allowing it to track
  *                 and update its serialized state across phases.
+ * @private_data:  Pointer to the private data for the file used to hold runtime
+ *                 state that is not preserved. Set by the handler's .preserve()
+ *                 callback, and must be freed in the handler's .unpreserve()
+ *                 callback.
  * @retrieved:     A flag indicating whether a user/kernel in the new kernel has
  *                 successfully called retrieve() on this file. This prevents
  *                 multiple retrieval attempts.
@@ -155,6 +159,7 @@ struct luo_file {
 	struct liveupdate_file_handler *fh;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 	bool retrieved;
 	struct mutex mutex;
 	struct list_head list;
@@ -300,6 +305,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 		goto err_kfree;
 
 	luo_file->serialized_data = args.serialized_data;
+	luo_file->private_data = args.private_data;
 	list_add_tail(&luo_file->list, &file_set->files_list);
 	file_set->count++;
 
@@ -346,6 +352,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
 
 		list_del(&luo_file->list);
@@ -372,6 +379,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		err = luo_file->fh->ops->freeze(&args);
 		if (!err)
@@ -392,6 +400,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		luo_file->fh->ops->unfreeze(&args);
 	}
-- 
2.52.0.rc2.455.g230fcf2819-goog


