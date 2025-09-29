Return-Path: <linux-api+bounces-4949-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7FABA7A84
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 03:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31D3163C22
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 01:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C711E7C38;
	Mon, 29 Sep 2025 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FXHMpFhK"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B84207A
	for <linux-api@vger.kernel.org>; Mon, 29 Sep 2025 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107817; cv=none; b=B+PWDCxw9I+s8/IYcRRj4y8EDSQwW5lLNDkKZl/xOZghz1fB4ixXOcQnv3qq6xPJYehYi8lsFTh7+pFrfzIFOljx/fGYpGjC0MR6LJA6kAMRItl41++ceCejS7P4AD/sGCVfelnfHkuBWuFyH9VIGqBlRcBzYTmslp1oWGLYKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107817; c=relaxed/simple;
	bh=H9bVmk4XNEIhyUuYBpnqxQGGI4EN7gtWE5L1w0h2bJI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fD5bhHrVhm8aMVzMl0Ne7dyNmCUoLp/ZTbWytHsAANUI1wX/GxehK17qCf4hW9Ef2Qo4Yd/KYxAWFicR3UNOEKjevCJ/LJkLDO1BIGqIdyji8k+kEpplKh0qArLUbnaDnbtAG/jtmqvJ5ahFpRQE6lunR/LXNsyzkyTvf/fEuPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FXHMpFhK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-85cee530df9so435773785a.3
        for <linux-api@vger.kernel.org>; Sun, 28 Sep 2025 18:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107813; x=1759712613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RU4szgNN13WysJ6xhtBfiTDK+ejkMnCmbQOqkk33H88=;
        b=FXHMpFhK55fIeMK2ud2Rt4xuVS/+SwhFg2c12I3fXTAYYDZ4ZrC3kU1ecCpYWlgRz3
         BTPAsEhL1G/2oNODFHozE/EK2WTnPwqYy5URo5NSNhwCDuwA8o5ytL1kXfNAQijshBFS
         OdCBzt3LVy9ThgVez0fNbQM5Y+geFwOWozGDWS7SVzXvz+2f6IEgEDuWvX+Fq9D5kVp+
         7Dj5HlNilSGZ/amqU0hjc0QpyrElswpH/OFrx0uhRcdB4VbFMJ2vCXNNSbzzm7ZuEFyS
         jXG5Inw7pi+unnWtP0KAEr67QmnxGtu+Mn0e5hj9eM+85f/7AQExL7hiuJcBVDP/dnij
         c3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107813; x=1759712613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RU4szgNN13WysJ6xhtBfiTDK+ejkMnCmbQOqkk33H88=;
        b=AT8jNBAq0P7B20foQzPKRIoYIaVj06i0MFAoYVLxpfHX1LQsW8NKXCMjzbk9JDSCSw
         wQyVtzPz2Fi0KUHTrW7YJMhYvVk8Ds6PR7XU29OFu8NVyL1CxJgQZURuquMp/xKnQlTG
         U7jowbqUfkJ4Wtb0d5Pnxl8pGYQEHsZuoZlIbgZn44yW1TvpV3ME2BygsHIUB4qRh0Oz
         9E0sCe55obxD5Le/Xv07l6kbD+0f+XTSbLzDUXW29RHKKhqFzlnCJtJ+rxv0QE5YO8zr
         oKlHVycm4a5Ns7KGwWo2q8KFWAzAz6Gyv8bFiZadb1eWgyAVq+nCqefosrzgYkNAysbR
         yhLA==
X-Forwarded-Encrypted: i=1; AJvYcCW2jrupRfIjQTvtGmCbvxsM2TMYyiZNXSqZ8hglfUs3u/WEN7Un83wtF2RTZK0DzkEXDTRLyp7Fm0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygxd6N0Zd9u6T/SaS0+B1MBY5GWUy9Mb5a9rdKL5+LAFtm4foy
	n+395ytyHBtcwhR6VDRlBzZ4zF+eHNJs9H7h8/pJEG/Twmp+CBcnYzwQrAA0Sj8noMQ=
X-Gm-Gg: ASbGncucvi90arhaodzX0xvKVt3jkCfWvUyL0lQ4wQQ2pW9jDIn/uneVliNkg4GpZx1
	8CgiL9UMX5gfrq/KnHwZWXeHOQEAfqJuv9EL08DT5BWqdG55GHGYtwzCfFPU/VLWSNgtMLRieEN
	mHXTNma1jeRDaNWCg3fcVkC5V3i9REgiwDdUKKhq+ZmW4kp9WZLquDxf6X1fW0P1fVuYDCzt1bL
	hRn5+Ku02KvNE6XfFi6Xjmatm6r6edpwtT4SyO4t/kJLPOUKrUNCIrjg65/kX89rZUK1Zgvc+Vt
	WTRbKAjHqhXODydoT6Jzfs/yZUNB8el2O1LozY31zXbhT2vcSTmQaDGy525EKF4Q2LVwY/O2aC9
	EfXuJz/6zlz+0HP6q9m0Bi1wu1Bilv4Xtb8MwV5pL/vVY8+BNW3YsZFTOdmngB3UBASEywk8CNv
	pvb+qeO+IfYAIHigOkzA==
X-Google-Smtp-Source: AGHT+IEzNLDCIUEBf9S5DRDPsrWxtgBORWz8LvfpibpwyTvuEl9/0gmUqA9ZfzRNolrGZ8uq0mC63A==
X-Received: by 2002:a05:620a:1a90:b0:84f:110c:b6e7 with SMTP id af79cd13be357-85adf7bb783mr2147257785a.6.1759107812795;
        Sun, 28 Sep 2025 18:03:32 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:03:32 -0700 (PDT)
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 01/30] kho: allow to drive kho from within kernel
Date: Mon, 29 Sep 2025 01:02:52 +0000
Message-ID: <20250929010321.3462457-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to do finalize and abort from kernel modules, so LUO could
drive the KHO sequence via its own state machine.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec_handover.h | 15 +++++++++
 kernel/kexec_handover.c        | 56 ++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 25042c1d8d54..04d0108db98e 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -67,6 +67,10 @@ void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
+
+int kho_finalize(void);
+int kho_abort(void);
+
 #else
 static inline bool kho_is_enabled(void)
 {
@@ -139,6 +143,17 @@ static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 				phys_addr_t scratch_phys, u64 scratch_len)
 {
 }
+
+static inline int kho_finalize(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int kho_abort(void)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_KEXEC_HANDOVER */
 
 #endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 76f0940fb485..0ba5a2dbae28 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1067,7 +1067,7 @@ static int kho_out_update_debugfs_fdt(void)
 	return err;
 }
 
-static int kho_abort(void)
+static int __kho_abort(void)
 {
 	int err;
 	unsigned long order;
@@ -1100,7 +1100,33 @@ static int kho_abort(void)
 	return err;
 }
 
-static int kho_finalize(void)
+int kho_abort(void)
+{
+	int ret = 0;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&kho_out.lock);
+
+	if (!kho_out.finalized) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	ret = __kho_abort();
+	if (ret)
+		goto unlock;
+
+	kho_out.finalized = false;
+	ret = kho_out_update_debugfs_fdt();
+
+unlock:
+	mutex_unlock(&kho_out.lock);
+	return ret;
+}
+
+static int __kho_finalize(void)
 {
 	int err = 0;
 	u64 *preserved_mem_map;
@@ -1149,6 +1175,32 @@ static int kho_finalize(void)
 	return err;
 }
 
+int kho_finalize(void)
+{
+	int ret = 0;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&kho_out.lock);
+
+	if (kho_out.finalized) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	ret = __kho_finalize();
+	if (ret)
+		goto unlock;
+
+	kho_out.finalized = true;
+	ret = kho_out_update_debugfs_fdt();
+
+unlock:
+	mutex_unlock(&kho_out.lock);
+	return ret;
+}
+
 static int kho_out_finalize_get(void *data, u64 *val)
 {
 	mutex_lock(&kho_out.lock);
-- 
2.51.0.536.g15c5d4f767-goog


