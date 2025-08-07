Return-Path: <linux-api+bounces-4351-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164C1B1D076
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 03:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3090018C92E7
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 01:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42C238C0B;
	Thu,  7 Aug 2025 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gF8WDCKl"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6E226D1E
	for <linux-api@vger.kernel.org>; Thu,  7 Aug 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531116; cv=none; b=uPewdgAeBFytYEFFSjpwTnSOCaOW/YbgdUPHr54IUXTAcz6mrwVS1ryudCR6CG76yly6XycCs5OsnMVocRTTo2tZPrwgDjYVuO5khykd45Y0oNx8+eYrq6ObgZn1jAczXeRs/T6shLuruKfl8TVXaIv/xP0kcWqV59IIOtVLksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531116; c=relaxed/simple;
	bh=6IaJ4oC3HjSKXEwPPmdg9sH4w864pWwsUqoUlC5zX5s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grY4owH3lXnMLTP7tS4eJgkWv7wwogmYSArG9ygeIYfAeG3x5sVJ5uFqUkNmxzW9V4BxHELvWhHT7L/9F/AHXXyTRUmnk1duLm/YbaK8GKqDBzlR4c89wGUAyE3JXSbLMVVLll3XvDQExl1xPJ7Rapm5SUuGWTj4v80Cg+l/P5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gF8WDCKl; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b07cb2d13bso7906261cf.1
        for <linux-api@vger.kernel.org>; Wed, 06 Aug 2025 18:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531112; x=1755135912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k1U17r+PzRIJkOEWEh69D1nNoyfvJ+I2xTfX4gnP+M=;
        b=gF8WDCKl7lSirbpvxjc3A32RPgzd74XttEyW4Jsd9Z6qD9CFDGpLG0/QILyXXGq6vT
         VNiyCx4dGT1VKH/hnutlzijUDovc7kjUOthswMqgzUg1ye+DZ9jMuMRg7DCDA2CTqT36
         cqA1XAcrRYZQQP5shvw6qmosaZrxu3hSUJ61vheEB1frWbRQe6P1R1THj6RnxhCYd66A
         TXgv255p0lm0iYpnnkQFZawB3cQ7QI+W2N5gQdE0oZ0phIA4xiZYLXMr0rvTH9shEj83
         HIR5EtNMEaKq4fn5+hGPW0phYNTQd8bTCRTPCrSm4Y26aOQAFJYt0DjVae44Yr0gYQsg
         AgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531112; x=1755135912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k1U17r+PzRIJkOEWEh69D1nNoyfvJ+I2xTfX4gnP+M=;
        b=A28PETQxxfE9Koj8RR7cnYNq1ezJPUuLn6jN4kiPb1IuN48MLgDWOzTENfbx/fFMZd
         WVtMMSaazvNfQx+tfLaP6i/Y7qT3FZpf+B4kW/eWXLq8jr3L+CxWjLbi083vkLWc0nfN
         3VuUA/UBxOWLdATx4JFMKbROa+RTPdrKKDyPowQE7C1SxYO7/86+YBsSKH3GIDfdM3A1
         uDWdmBARCQJxeXnCuE6kuplKsQeJwcbqB9osDgZo6sQmCyMBGjoTAZh22yFVw6k3IJye
         A+8NcE7XcYeuoF+D7vvV91wvtKfOmpMB8I1fqUH0eZT697WF3Del7xSNJ0JirJWaUt2R
         F3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIlOOr5tBd0DvYvqWUsbF6lMguONTPuCEjSZcmOBkTwnj5+VeYaTpydYhhPzgHjh+PGRebsnKyp3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrtZy/oHhUC3E8SbAJlGQk6wW3yZ8fmu3wNAdvmUNb6Vr/6uV
	J7lcxOKLF4R1YTC4o2bMXQe4IQdBClUCNzhJfurGMA19bYEOl1MxHLSik7SyjjmSz/Q=
X-Gm-Gg: ASbGncvhcnK4GSdIcFOJGXg8tQ0JGhpP11PyhudUkxlpbSQvarPcek3bzqRYJdOTl5b
	6Ob3v2Yigo/IufH2vKBS8mGe76QB9ZUoY1y3KzKq74hJcsSC9vUOhWxV7c0KoT1+tvfH06MxtHC
	h1CARsaq+wDdVAOlefLB+oUpgze/R/SW9R18OIsQToKDR0BDAHvcMZZZ9wKDYignNptvGiTWplM
	W1bEZjxGT8l/EBP+hqjeoB5xHMQ2al6Gi+tuj7TX7T5UdkmqN1ZK1yhBP7dQGBI+P/7bK6f1c5P
	tomCFixvyg4GHUmryz7hMI4lW1+DjcajScgRVf8qbw7sRrY+WV6F6cq8zAJZ9D20b/LFBzVfIFA
	CUYZtLEULhhyqRcctPM/N5m5jEafPfop9cT3Sj3qbayF0r418deFFhUdh3q4oNp90gpdZT4Lc1d
	W9DhuDdf8uvWIHPMqXM797y9Y=
X-Google-Smtp-Source: AGHT+IFGhloL5+wAzqGLxdMTz2N8jTfQVk0LrudTV42eJiPSBl97ww3SO5T1gQQT1i9NRyGQ/H+ydQ==
X-Received: by 2002:a05:622a:10d:b0:4b0:7e72:9f05 with SMTP id d75a77b69052e-4b09157a420mr93793331cf.29.1754531112392;
        Wed, 06 Aug 2025 18:45:12 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:11 -0700 (PDT)
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
Subject: [PATCH v3 17/30] liveupdate: luo_files: luo_ioctl: Unregister all FDs on device close
Date: Thu,  7 Aug 2025 01:44:23 +0000
Message-ID: <20250807014442.3829950-18-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a file descriptor registered for preservation via the remains
globally registered with LUO until it is explicitly unregistered. This
creates a potential for resource leaks into the next kernel if the
userspace agent crashes or exits without proper cleanup before a live
update is fully initiated.

This patch ties the lifetime of FD preservation requests to the lifetime
of the open file descriptor for /dev/liveupdate, creating an implicit
"session".

When the /dev/liveupdate file descriptor is closed (either explicitly
via close() or implicitly on process exit/crash), the .release
handler, luo_release(), is now called. This handler invokes the new
function luo_unregister_all_files(), which iterates through all FDs
that were preserved through that session and unregisters them.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_files.c    | 19 +++++++++++++++++++
 kernel/liveupdate/luo_internal.h |  1 +
 kernel/liveupdate/luo_ioctl.c    |  1 +
 3 files changed, 21 insertions(+)

diff --git a/kernel/liveupdate/luo_files.c b/kernel/liveupdate/luo_files.c
index 33577c9e9a64..63f8b086b785 100644
--- a/kernel/liveupdate/luo_files.c
+++ b/kernel/liveupdate/luo_files.c
@@ -721,6 +721,25 @@ int luo_unregister_file(u64 token)
 	return ret;
 }
 
+/**
+ * luo_unregister_all_files - Unpreserve all currently registered files.
+ *
+ * Iterates through all file descriptors currently registered for preservation
+ * and unregisters them, freeing all associated resources. This is typically
+ * called when LUO agent exits.
+ */
+void luo_unregister_all_files(void)
+{
+	struct luo_file *luo_file;
+	unsigned long token;
+
+	luo_state_read_enter();
+	xa_for_each(&luo_files_xa_out, token, luo_file)
+		__luo_unregister_file(token);
+	luo_state_read_exit();
+	WARN_ON_ONCE(atomic64_read(&luo_files_count) != 0);
+}
+
 /**
  * luo_retrieve_file - Find a registered file instance by its token.
  * @token: The unique token of the file instance to retrieve.
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 5692196fd425..189e032d7738 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -37,5 +37,6 @@ void luo_do_subsystems_cancel_calls(void);
 int luo_retrieve_file(u64 token, struct file **filep);
 int luo_register_file(u64 token, int fd);
 int luo_unregister_file(u64 token);
+void luo_unregister_all_files(void);
 
 #endif /* _LINUX_LUO_INTERNAL_H */
diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
index 6f61569c94e8..7ca33d1c868f 100644
--- a/kernel/liveupdate/luo_ioctl.c
+++ b/kernel/liveupdate/luo_ioctl.c
@@ -137,6 +137,7 @@ static int luo_open(struct inode *inodep, struct file *filep)
 
 static int luo_release(struct inode *inodep, struct file *filep)
 {
+	luo_unregister_all_files();
 	atomic_set(&luo_device_in_use, 0);
 
 	return 0;
-- 
2.50.1.565.gc32cd1483b-goog


