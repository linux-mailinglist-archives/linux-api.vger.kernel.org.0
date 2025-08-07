Return-Path: <linux-api+bounces-4347-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F1EB1D064
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 03:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0902372487A
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 01:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CEA22A7E9;
	Thu,  7 Aug 2025 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="e186YskE"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643721D59B
	for <linux-api@vger.kernel.org>; Thu,  7 Aug 2025 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531111; cv=none; b=RtJdWLTlsKJSBA1D4Q7LwOXRGuUuKm4zc1y+x+IKr8lDKwUxkhW1VS4xAos+QsUdRjXl3KaElkQfU/wKsLAtSF9sUdHri/9k7hBWWx7pnqTGI9qXht2aSR14Z6vgU9src0XP5lboLDoFPUS7CKWQViIyDlGWcKpp/PxXovC/H4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531111; c=relaxed/simple;
	bh=Y1sLhC9y86x1i1cxGNgfSB/iscxWS5gRZuMoBf/oLNc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/hV6dZRunv2XVI/hw355ijvsJbNEBH/hfA2hpxd+5+FV1wRZiWZH/FCMJKXW6BbX5PJRTu8omWZRVt8On2/rKEUlzB1kewbv9wEDMHH4kTzs8A3IXiq4l/t1eWSSQnKWqcIzUukb8Jd2Ss92Sr0ZhzmgyH5lzuG91Xxo0tBr4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=e186YskE; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7074bad0523so5471696d6.3
        for <linux-api@vger.kernel.org>; Wed, 06 Aug 2025 18:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531106; x=1755135906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OTaXTT6jQmKJ4PUph7LgRVFyALKuwMGjifm+qkQzqU=;
        b=e186YskEIVlxlIHYxVG9KrCp23fQgceIHkHPdnlaQPHfXGX10VbEIZklCh65vAjevn
         wkn2a6TCk7kd7vYiCLFsUpUZwAytdiUUGW6HDzUeZHfdA2aEoKbgQtDwb/TX8Q5WOfEr
         9QW08CSFXR/o+h8NmSs+y2lwIVUXT1FHspdEQLtyQT5bsyaZK0gD65Ysn75ywxDGTVZO
         kY3/QfcQ5rsoAPzX8uMiEXyn2zCr5klNa19oLCysdqk9Pu3CwWOtcqztSkJ4FRCcfmFZ
         nlzsPEScqg7cQCV3dU4+TVxEvw+2HU+FJ5L7AnY/Y0cp9o3RbtaSiNLR1yCiaMqiU2fl
         RHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531106; x=1755135906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OTaXTT6jQmKJ4PUph7LgRVFyALKuwMGjifm+qkQzqU=;
        b=s3RHqlT1EdCRCIGJfdoRqeJVTtSd6kJycssk28TiBMARt7x1i5wp7JBMjFtZUDsdYM
         Rx67sqBNf57RV451OIrOMoLn9WKwapNysTlKfCrlyrFSKzK/YgfREHZINfECuG4hBgpk
         tj9+R/fS8yKjj5ezH3IfRA9S45CUg3BkSEXOV+Vaw/LPaNgDKyPMvhZUnqI/Q63mgtX/
         4bdGMzNrP5lytWly8D7tzbvMgY9SksTrecD0CdIvdlOcwWtbZ62tOkQGJ8f36nZ/ovjC
         W4iiQ4AB1Og1Y2CC+nNAOcms0C3Rdtm0Msw55+QGNa83q4+Boi++dFTZtgOCgBwA9eh3
         1jHA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Tlg6s8evGkwxYpPwcnfrPQ1ZgtKxUyKvwVdmRUm6YwBKNorRDV5IWm/zl9tFcUVlZ3i3qAmlrM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0d+vYoYIazDMHtoJzXQs5Uea86BpoVoMN4At2VwMzTtNu3gY
	VfRznJeUXjbTFbOl+FjpZqqgd6UoTVIEIlTYNuFo9Gcu57PghDx7FgXyn+eB7UjI/Ns=
X-Gm-Gg: ASbGncuphSWvJ7z0r/3A6KhrjfgaJzHm9QPHtTNGApxe2QvHVHezPrSuhhZG4uNp/at
	Cx9lx1waYBjnpHHRfwmhJlgischGYhZ7bfPA1O2znzECqCo+gerQbAzRVIttpsW/om5ffDH0kgY
	/leGekj9W9Fqddr0rlP7GIYvbuA+HuIDepEidCwCadUP6U84P8iblvsBoqmYxyOgo5OWf/YfyHe
	1898Bletk9adVJl+1iQr5lMlpucnFLD0ZwhjT0vEFxLWcuR5CtHqub2zD584LqrMmJZGa+6foCZ
	2Pnwf5Luo+ws+RMzjDwk0FIneRPMJ9tFRYFIcJzyQx/VIk7QLlpzx7F/0GuO2Ian7lgBHUksL6d
	RJiyQ31wxjU8B7V1EFQRKSmC/3T3MRxg9R6eMbTMfThOJKDieIB9oEQQ+sapLjEYKZ0UIcFUJAq
	6EbTiLsveSW3Lp
X-Google-Smtp-Source: AGHT+IHkVV1gJ/eLfgNhdc15SxnB7MFyTZ6hI7y1/NB5UoxH3EhPIvvoxDJur8yfTZfudJtjwPns5g==
X-Received: by 2002:a05:6214:482:b0:707:45dc:c36 with SMTP id 6a1803df08f44-709795f4f3amr75094366d6.29.1754531106352;
        Wed, 06 Aug 2025 18:45:06 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:05 -0700 (PDT)
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
Subject: [PATCH v3 13/30] liveupdate: luo_subsystems: implement subsystem callbacks
Date: Thu,  7 Aug 2025 01:44:19 +0000
Message-ID: <20250807014442.3829950-14-pasha.tatashin@soleen.com>
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

Implement the core logic within luo_subsystems.c to handle the
invocation of registered subsystem callbacks and manage the persistence
of their state via the LUO FDT. This replaces the stub implementations
from the previous patch.

This completes the core mechanism enabling subsystems to actively
participate in the LUO state machine, execute phase-specific logic, and
persist/restore a u64 state across the live update transition
using the FDT.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_subsystems.c | 167 ++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/luo_subsystems.c b/kernel/liveupdate/luo_subsystems.c
index 69f00d5c000e..ebb7c0db08f3 100644
--- a/kernel/liveupdate/luo_subsystems.c
+++ b/kernel/liveupdate/luo_subsystems.c
@@ -101,8 +101,81 @@ void __init luo_subsystems_startup(void *fdt)
 	luo_fdt_in = fdt;
 }
 
+static void __luo_do_subsystems_cancel_calls(struct liveupdate_subsystem *boundary_subsystem)
+{
+	struct liveupdate_subsystem *subsystem;
+
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		if (subsystem == boundary_subsystem)
+			break;
+
+		if (subsystem->ops->cancel) {
+			subsystem->ops->cancel(subsystem,
+					       subsystem->private_data);
+		}
+		subsystem->private_data = 0;
+	}
+}
+
+static void luo_subsystems_retrieve_data_from_fdt(void)
+{
+	struct liveupdate_subsystem *subsystem;
+	int node_offset, prop_len;
+	const void *prop;
+
+	if (!luo_fdt_in)
+		return;
+
+	node_offset = fdt_subnode_offset(luo_fdt_in, 0,
+					 LUO_SUBSYSTEMS_NODE_NAME);
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		prop = fdt_getprop(luo_fdt_in, node_offset,
+				   subsystem->name, &prop_len);
+
+		if (!prop || prop_len != sizeof(u64)) {
+			luo_restore_fail("In FDT node '/%s' can't find property '%s': %s\n",
+					 LUO_SUBSYSTEMS_NODE_NAME,
+					 subsystem->name,
+					 fdt_strerror(node_offset));
+		}
+		memcpy(&subsystem->private_data, prop, sizeof(u64));
+	}
+}
+
+static int luo_subsystems_commit_data_to_fdt(void)
+{
+	struct liveupdate_subsystem *subsystem;
+	int ret, node_offset;
+
+	node_offset = fdt_subnode_offset(luo_fdt_out, 0,
+					 LUO_SUBSYSTEMS_NODE_NAME);
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		ret = fdt_setprop(luo_fdt_out, node_offset, subsystem->name,
+				  &subsystem->private_data, sizeof(u64));
+		if (ret < 0) {
+			pr_err("Failed to set FDT property for subsystem '%s' %s\n",
+			       subsystem->name, fdt_strerror(ret));
+			return -ENOENT;
+		}
+	}
+
+	return 0;
+}
+
 static int luo_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data)
 {
+	int node_offset, prop_len;
+	const void *prop;
+
+	node_offset = fdt_subnode_offset(luo_fdt_in, 0,
+					 LUO_SUBSYSTEMS_NODE_NAME);
+	prop = fdt_getprop(luo_fdt_in, node_offset, h->name, &prop_len);
+	if (!prop || prop_len != sizeof(u64)) {
+		luo_state_read_exit();
+		return -ENOENT;
+	}
+	memcpy(data, prop, sizeof(u64));
+
 	return 0;
 }
 
@@ -121,7 +194,30 @@ static int luo_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data)
  */
 int luo_do_subsystems_prepare_calls(void)
 {
-	return 0;
+	struct liveupdate_subsystem *subsystem;
+	int ret;
+
+	guard(mutex)(&luo_subsystem_list_mutex);
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		if (!subsystem->ops->prepare)
+			continue;
+
+		ret = subsystem->ops->prepare(subsystem,
+					      &subsystem->private_data);
+		if (ret < 0) {
+			pr_err("Subsystem '%s' prepare callback failed [%d]\n",
+			       subsystem->name, ret);
+			__luo_do_subsystems_cancel_calls(subsystem);
+
+			return ret;
+		}
+	}
+
+	ret = luo_subsystems_commit_data_to_fdt();
+	if (ret)
+		__luo_do_subsystems_cancel_calls(NULL);
+
+	return ret;
 }
 
 /**
@@ -139,7 +235,30 @@ int luo_do_subsystems_prepare_calls(void)
  */
 int luo_do_subsystems_freeze_calls(void)
 {
-	return 0;
+	struct liveupdate_subsystem *subsystem;
+	int ret;
+
+	guard(mutex)(&luo_subsystem_list_mutex);
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		if (!subsystem->ops->freeze)
+			continue;
+
+		ret = subsystem->ops->freeze(subsystem,
+					     &subsystem->private_data);
+		if (ret < 0) {
+			pr_err("Subsystem '%s' freeze callback failed [%d]\n",
+			       subsystem->name, ret);
+			__luo_do_subsystems_cancel_calls(subsystem);
+
+			return ret;
+		}
+	}
+
+	ret = luo_subsystems_commit_data_to_fdt();
+	if (ret)
+		__luo_do_subsystems_cancel_calls(NULL);
+
+	return ret;
 }
 
 /**
@@ -150,6 +269,18 @@ int luo_do_subsystems_freeze_calls(void)
  */
 void luo_do_subsystems_finish_calls(void)
 {
+	struct liveupdate_subsystem *subsystem;
+
+	guard(mutex)(&luo_subsystem_list_mutex);
+	luo_subsystems_retrieve_data_from_fdt();
+
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		if (subsystem->ops->finish) {
+			subsystem->ops->finish(subsystem,
+					       subsystem->private_data);
+		}
+		subsystem->private_data = 0;
+	}
 }
 
 /**
@@ -163,6 +294,9 @@ void luo_do_subsystems_finish_calls(void)
  */
 void luo_do_subsystems_cancel_calls(void)
 {
+	guard(mutex)(&luo_subsystem_list_mutex);
+	__luo_do_subsystems_cancel_calls(NULL);
+	luo_subsystems_commit_data_to_fdt();
 }
 
 /**
@@ -285,7 +419,34 @@ int liveupdate_unregister_subsystem(struct liveupdate_subsystem *h)
 	return ret;
 }
 
+/**
+ * liveupdate_get_subsystem_data - Retrieve raw private data for a subsystem
+ * from FDT.
+ * @h:      Pointer to the liveupdate_subsystem structure representing the
+ * subsystem instance. The 'name' field is used to find the property.
+ * @data:   Output pointer where the subsystem's raw private u64 data will be
+ * stored via memcpy.
+ *
+ * Reads the 8-byte data property associated with the subsystem @h->name
+ * directly from the '/subsystems' node within the globally accessible
+ * 'luo_fdt_in' blob. Returns appropriate error codes if inputs are invalid, or
+ * nodes/properties are missing or invalid.
+ *
+ * Return:  0 on success. -ENOENT on error.
+ */
 int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data)
 {
-	return 0;
+	int ret;
+
+	luo_state_read_enter();
+	if (WARN_ON_ONCE(!luo_fdt_in || !liveupdate_state_updated())) {
+		luo_state_read_exit();
+		return -ENOENT;
+	}
+
+	scoped_guard(mutex, &luo_subsystem_list_mutex)
+		ret = luo_get_subsystem_data(h, data);
+	luo_state_read_exit();
+
+	return ret;
 }
-- 
2.50.1.565.gc32cd1483b-goog


