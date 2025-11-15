Return-Path: <linux-api+bounces-5297-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9842C60D5F
	for <lists+linux-api@lfdr.de>; Sun, 16 Nov 2025 00:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F4A3BE068
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 23:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1E3064B1;
	Sat, 15 Nov 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="C3iCx/rG"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AAA30C371
	for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249692; cv=none; b=NGdJDbx3yNEwjg4tgTu/gPFehUZtx0AtfQRUc/zYJMz/EhWhPyJNT4MQNZxliL8d73G30hPPf9Ezs4R3ShG4WYxvyW2bJdGeaodNl7InJOEXh+/ylj+sr/jB9I/rXzRD0PFOejJS9j3noMy6kysvfNSNlyS0nyb9ME+OOSbyq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249692; c=relaxed/simple;
	bh=xccKVGMJ06tz/lkKn64u87jb4PRZGDO1HSTw7IKUbOs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/E8l2an9m6QakL9gU3KcR693ysqbAQMNbpAQjkEnfPuoMY0XuBdQdKRILInV1r9iSNEDTNfvQJo9g5EMKzIIvqq9RqPrYKPNn2FyUdQrm2ZqI9erdU181USqwCD4JGdBzu5xGCq8h77J+VS9X2GRoNWxF5cyqn/Fh9HnWtH6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=C3iCx/rG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78933de9ab5so14588837b3.1
        for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 15:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249689; x=1763854489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyQXl7tWXRV/YETkSwjN2Plb4i1qeg0xlo6fhXkHNVA=;
        b=C3iCx/rGV582hC4pEfJpW/VhjJ52sbI6jrHAV/ts15eo/ss0O/5uY9h42uFZ+GvVtS
         mUzRTu2/FHfMi7gspOsL2/p7doxgbIZkmGFRm3i6U09Vf6Y7ChbtNVa9OiStJCc3pRHc
         9DNU8tZX6OKA+ksAFGUBmaGYgl4W6wvoGEPj9VEB/9TWiCqUU+FkOzroBO1tdLT8sMXe
         Nr1NTwePJ6L8QbueNIVx73is9waW/AM4duOUe+l1L+NFfPShFwjPE+4jIc8Av2hlkRHd
         B6wrOHskrO+V/KCuaqtRqLHT3BqA9RmwxXdLNYXU5WjeFh3njfIKdH2Bv4Q/754yf0Mf
         Mr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249689; x=1763854489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VyQXl7tWXRV/YETkSwjN2Plb4i1qeg0xlo6fhXkHNVA=;
        b=rREKQ0amFQYd4WVFNE6izra+nEKitaogJxQaAKy+Zlvida5Oz+atK4evFKzAHoFVtw
         pHSwKlikR4T+8KwKcgO3Um8v/XnTKeNDRtvYGIpm14Q1e2rm9sksy1/CgLHdv2fYr1vA
         TKrTKg+EtNBa98FS3z6WclS/yMPR4EGMe0zrUqX+lR/XaYyLyRbkDKUFwq1Yz80pI8UC
         j3Ivr/W+WcWto7UFwpgYWYN2PykHnwgqw6QgOb5fd2xdb1NvzYeVTyqIsJICTZYHnRud
         5rNTSHHjvf8dPqLO/VN0OVGXRiA4TgAHcQ0C/6jSGSJmQpVQvndF3CUduK7+0ufMuCaj
         V0kg==
X-Forwarded-Encrypted: i=1; AJvYcCWy6Ie1QDbjgOXBsYJjWcZd+g/QY/5PSnuMUGyr3IxusfPze+qVUsyYXZ2ysf1KhxcHdVbqyvEbzRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzqsfpq6ZwqcLy1Ydp8JkL7kzW8tM5PcGK+Vwv4njTQf0cYxcE
	dORJXBvvL96wUDmhNm9GwNUUK165d16t89tPZFr//CWcmMmmGFsYhfQ10QMm4pRUYRM=
X-Gm-Gg: ASbGncsXVFVaCq98tfJ9W99kvuXMXSbrIHw/eJo1ZKtQmCR+YkLp+i38Ch+7e9i4vUg
	+CY7w0qq3a7DMdv7Bmw81DJHS3JYrs3RKzPqnKA+SKGPOt0GBrXDY8mSwppPBk7fQdbs+gJv+KZ
	Qj3euh8bHy64YDtXda2Mo4pCiaP0QuzmWDe1NGJZeu/k5jGF2xX91YaAn9TQ6O82t9nYQXPQVhY
	FIbW7HtqPAo3cSNd97mA/lTaiOAekK7zYpGwf6zFfbKcsAJ7sjszbjw70BBz7G/u3uaJGBxcpuQ
	j1k1WebHBUOLRxSo0mEzSy81ki0JotShBKo0bV6NW6QXR5j6hH/FT4vkusPcgb/JAWFDcBN8Vdp
	WPQXMf8fpbroKvd5nDssPNRkqjuZNtOE7jUmgpz70ZNxQbESpDHCp3ez0LtXVwAZGVGX+B/gZJw
	9eTjFSIp9QHzZGDvslMyyT/yVXwEv6UxCnTLtaV+z769JG+SEQhADO8biEoxFg/TT1cyBy
X-Google-Smtp-Source: AGHT+IEy3rWCZZa0SeOLBQxT1yFnRWPZjFkRUtPU+kVtuy5howb5ZMUGXRB8KQbRbOWcLX2jr1XF1w==
X-Received: by 2002:a05:690c:a003:b0:788:161c:722e with SMTP id 00721157ae682-78929e81770mr63042867b3.26.1763249689113;
        Sat, 15 Nov 2025 15:34:49 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:48 -0800 (PST)
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
Subject: [PATCH v6 14/20] liveupdate: luo_file: add private argument to store runtime state
Date: Sat, 15 Nov 2025 18:34:00 -0500
Message-ID: <20251115233409.768044-15-pasha.tatashin@soleen.com>
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

From: Pratyush Yadav <pratyush@kernel.org>

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

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h   | 5 +++++
 kernel/liveupdate/luo_file.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 36a831ae3ead..defc69a1985d 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -29,6 +29,10 @@ struct file;
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
@@ -39,6 +43,7 @@ struct liveupdate_file_op_args {
 	bool retrieved;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 };
 
 /**
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 3d3bd84cb281..df337c9c4f21 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -126,6 +126,10 @@ static LIST_HEAD(luo_file_handler_list);
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
@@ -152,6 +156,7 @@ struct luo_file {
 	struct liveupdate_file_handler *fh;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 	bool retrieved;
 	struct mutex mutex;
 	struct list_head list;
@@ -309,6 +314,7 @@ int luo_preserve_file(struct luo_session *session, u64 token, int fd)
 		goto exit_err;
 	} else {
 		luo_file->serialized_data = args.serialized_data;
+		luo_file->private_data = args.private_data;
 		list_add_tail(&luo_file->list, &session->files_list);
 		session->count++;
 	}
@@ -356,6 +362,7 @@ void luo_file_unpreserve_files(struct luo_session *session)
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
 		luo_flb_file_unpreserve(luo_file->fh);
 
@@ -384,6 +391,7 @@ static int luo_file_freeze_one(struct luo_session *session,
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		err = luo_file->fh->ops->freeze(&args);
 		if (!err)
@@ -405,6 +413,7 @@ static void luo_file_unfreeze_one(struct luo_session *session,
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		luo_file->fh->ops->unfreeze(&args);
 	}
-- 
2.52.0.rc1.455.g30608eb744-goog


