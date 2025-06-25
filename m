Return-Path: <linux-api+bounces-3998-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5263AE922C
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 01:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F314164046
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 23:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82132FCE3A;
	Wed, 25 Jun 2025 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="TQD9Ylfa"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA852F949D
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893532; cv=none; b=V4UXovaWYaCpDxS0J7V3tBd560ZLDbSMRg0smuvmLnmngemoer9jmFEsFDvL3IWd01+11hgbXDQlm1ZJjWcUqeRqE7CqedF4oPh5JlutgnKFXlTk2gDXkFmEhuCOn4p1jXnzzqw/bAKkOZMbKnlRD0XZD5EaPeBM8q6i6Ma5h84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893532; c=relaxed/simple;
	bh=0PDOq00Vvzpi5aidwuocO/LBH8ZpH//f3Oi/CTR/VxM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khXmiv0hbzMsrFtr63Bedz55hEyu+8yYC4DGqOr8XUs2lmDGajjZz++O2zXOfhL8Eb66neazNIp+AwKHHpVm9HSK6BDFOfWl/I7180Oplf1J/ZhnCe0V7u4xcut14tsvcdKxHduy7VZcqHy5qa/kYYzILR2nnXU6EuWuaHqrEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=TQD9Ylfa; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e819ebc3144so351180276.0
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893530; x=1751498330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEd3hEimCm47EV0AQaiIlZfu4Iz9+2FaeBATOaJn9bU=;
        b=TQD9Ylfa9OpH6y1QUUoAcPtowHOdIvB4ASS2jV6r0te9GUxsCNjr1ZD1sa6YrOVUne
         IZqTmnQ0IaKeeYUewoWaGdx58v66xdMMR1WIriO4rmI74qqi8rSx6ncKMS7itX2dZfYP
         HySzDgRFfqNCJzfNBYg5NfM4bdOkGb4pbBEg6i2mk9Xt/dQh/eCpPYN4yBIkG4VNmT0U
         +vitfnMD/vim7ztqZPJs4T+SLHEReI7HY7P4/hXKtqOQCyC7qW4lJ1z3nSIXO2EraKFw
         hQR//pIDLNIqKTdofkzdLX+j27ZiUukmIvgIoGILX898g0baNiu/TGYUYIr2px19Gae+
         wMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893530; x=1751498330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEd3hEimCm47EV0AQaiIlZfu4Iz9+2FaeBATOaJn9bU=;
        b=ea0Eiqh5Ay+qg3r/84Frus2u3c2DBUr5WxymVmG+gqYOl6HHccL5k0HYq39OWYVV8g
         KQtm6aie+gVQwjTw/GzYIaJ8OXqrxmKcuRBt13oy7WyPZWoIwTZ858ilibU0GzDtqKgh
         0hWUaJtqdfUnzLoSzFEK7WUJiO3EUTWpOVQwTnRrugJKxqQSBSIjyol6K/R5Kcvwxvwp
         sKLa85ENzpL8kfhgikCO8hC+eJZDYYr/baN02AroYlbknbTUTrBgsXXi5Rtv4fjoF0SU
         BWeMs7sW5xz+9zajOox/P7P/yIc3yFoPsJXTc5boSZX6ehqeMT/dehvIAAO+R9FXKX/m
         HMyw==
X-Forwarded-Encrypted: i=1; AJvYcCV9WVox7GWHyn6iwiQUwZ2v8vyElZYS4GVXoFbKT0dcAUt3Xu5Q6h/xKP5CJwdIB9tAIWdij9pDlS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyudvAHxtyJQCaSIlSUwVw6BqZJ8yVc8pp3XIEGTCkOdal+HI9r
	jZmoCgY4wLDBTJRo6F1FIJU5kWPz0C624ari4YEoAe7S8yPzmM/3kZ6mGsBSbkgZGlg=
X-Gm-Gg: ASbGncsC+uQAuZigXDLiL5JCH4MLvVfsna9vc6BrjkOn3zQwd9/hQjGGInmypNnHyHV
	cgYHdZvuoqTOJfbSXPvgn2QL/SHJ1hRXY/EHdR9rmlLJ8Qaf/VRpWq4ZSDdW6sY7uMLG+4nPWhV
	05QRepvJCbvAouCWqUBf+HigHYzpIOfHrygXCaVedyKPmiM7JnPit3YFnU0pypewcYJDhtf+wLx
	rUM0bzPN4mDEMBiELGJJudkrsKl47Yv2y04dQle1TmhBhjnh+BSQ+dlkXppBC2RW/fE5DF9P0/4
	2bjsKRRREFVbo9uJ1Y83zOELzrxLdrl0cFeXXuwFq7r0wcjZyorkprwSjevQtxG/1prew3Mh9s+
	wowIDWgkGtKT4cB25S+SlQ7lx2dDj/sg+CTY1D+NFNhkqWy97ftL1
X-Google-Smtp-Source: AGHT+IFV+5+LiyNG0iLZB0IHiIkVDp3jbmaFTSBcfMxeDjEUTB2cISyBkSfyxmu5nuGGQBp9zewiEQ==
X-Received: by 2002:a05:6902:18c3:b0:e81:b5b8:3cc8 with SMTP id 3f1490d57ef6-e879b977913mr2507142276.41.1750893530105;
        Wed, 25 Jun 2025 16:18:50 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:18:49 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 04/32] kho: allow to drive kho from within kernel
Date: Wed, 25 Jun 2025 23:17:51 +0000
Message-ID: <20250625231838.1897085-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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
 kernel/kexec_handover.c        | 58 ++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb13..f98565def593 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -54,6 +54,10 @@ void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
+
+int kho_finalize(void);
+int kho_abort(void);
+
 #else
 static inline bool kho_is_enabled(void)
 {
@@ -104,6 +108,17 @@ static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
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
index 069d5890841c..af6a11f48213 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -757,7 +757,7 @@ static int kho_out_update_debugfs_fdt(void)
 	return err;
 }
 
-static int kho_abort(void)
+static int __kho_abort(void)
 {
 	int err;
 	unsigned long order;
@@ -790,7 +790,34 @@ static int kho_abort(void)
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
+EXPORT_SYMBOL_GPL(kho_abort);
+
+static int __kho_finalize(void)
 {
 	int err = 0;
 	u64 *preserved_mem_map;
@@ -839,6 +866,33 @@ static int kho_finalize(void)
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
+EXPORT_SYMBOL_GPL(kho_finalize);
+
 static int kho_out_finalize_get(void *data, u64 *val)
 {
 	mutex_lock(&kho_out.lock);
-- 
2.50.0.727.gbf7dc18ff4-goog


