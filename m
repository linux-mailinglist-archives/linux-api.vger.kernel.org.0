Return-Path: <linux-api+bounces-4342-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543CB1D04C
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 03:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6AD724254
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 01:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70724211499;
	Thu,  7 Aug 2025 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IQdmmI+C"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565C51FE45D
	for <linux-api@vger.kernel.org>; Thu,  7 Aug 2025 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531102; cv=none; b=hKxFEDTLy4AJHaO+lkGU6RtGsVq46YeQt6PTb08EMjPKtFMxF+ToAcS78W/NpouU3tOoKlK1ohmH1gkVhNt0ItxQCwniDO2yIo6NYSCcR9Ue+oy0rEKA5pf3Xt6DML//jC2zJMff28f1MRoDycZQ9d5mmPnxopZaSxdRH6LpohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531102; c=relaxed/simple;
	bh=vVfONrVyjedFUgoOJUn6GW1APtTwOCiADsyg5cO0faw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxxPmP9w9cKkX+QeRmmQhPav4bYzlvqhMaZr0mjnSwNQvHegKLK8qPEFhXGYpT/++yrSNT3lalkOIZy8VT4yjFeU0el0YBt6eJgaZUM58LqfE0zKnEWPcUF24zgQgN2LG3M6gj/vDmYIJXcoPD11wwzWaNaMNLcs+3UT/3sR6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=IQdmmI+C; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7094f298dc3so4813486d6.2
        for <linux-api@vger.kernel.org>; Wed, 06 Aug 2025 18:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531099; x=1755135899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7G+m/ldx5Lte6prj7fLyPcxxJI86crKx906ZhMWQQk=;
        b=IQdmmI+Cv+zDt/QzpCqEFU+RsJufI9UrlJanooqH41E/pSGh2xBX94CkOdyOKWaTE7
         Bmfm0FqP5g2LTu+YVfYqUjdv6aCwkxI20wKMnNTgpJ05adCDLYJ/C9qFtb973WX3Fmhn
         tJx02/qy0r90B+GLvXJluBS2j+PwRGuaGT+AHB8wqAkuRZEzhbmn+cN0vhz0y4kS+dl7
         6m0zEJLm/8tzaLdZN8ZNea5IuCPxRf/aQMqzOltWNW+mkVfprHfbV7Rudb1IJatZGWeQ
         vIPQO7P77to93JH+NOFLHZZa304TZHzbfoauEnSih7VdITG783ffpWOlvKUQmDazuXzT
         FJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531099; x=1755135899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7G+m/ldx5Lte6prj7fLyPcxxJI86crKx906ZhMWQQk=;
        b=nwpMIMxgxgiAjQ7eZGHZuMkh2Jcny6a1lceon2YcFqMJ2kB++ayX7QS7SWlHMwCsng
         GkqsysSv4qTfZop9rALOrqEzxHhSFXHfCV8VC/0UbiIjXBtwipWKMnQBNoUERRaOu/rz
         cU1mn8JRnsi7taQLWNj0YcBCn2Ojt1fr//mQsLEJyqdX+ymDHTRf1JM+vsT/U/vrmA5T
         kHrS7bMRJ4KbTICM8gtuHWtCBov/gClA60tRw8mlnYxuPF6dzxbEQANyxFl0kMIKR+ZG
         TXZ9yShjgMxZMxWuBdow35Qm66+8gBl7pzpKU+r09d0Ic4o1H+vo3FyH4iAl7HPiquJh
         hI9A==
X-Forwarded-Encrypted: i=1; AJvYcCX+K1mF5PTp1ZEGjxwntn9Fu+nJy7oQ2l3TE54wWEVye9KduSuS2sfdEexXvxxZE8iw1OBXl3ZqDLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIfKpPvuZQh4gcAoGu4sdGGzhrOyEQHwOrx+qCVnE0rEKlQnJ
	VOirEp9aR553PXFdoRMa+M/yDM+IXrGnsMWeskYaxvoUG4KUyWGAJL2Ywhob0LHcoow=
X-Gm-Gg: ASbGncuoF7Yg9U1cDfDe8poXKc9XOLpS4lL8CWE5w+HUgmuYwugegAXIP6fhmHHg0Tq
	a7rQ3A6w4z46zc9emjMryW+cQHqAiHzHqZ1cFt4iM++Nt5anZ+CqOQWccnEp3azJW0dZz9HeqcB
	AhmWnCriZYAk4hb+6T4jhMc71xgjYBNvuEMfwUhCj4D3iaeOmRCt8zjO6kGADpO2B/I9Mu6dzgu
	jud7YW7hD8ES5GZ4SWSFlOPQxFSSmwQxVKvaxbzIdxPIzqPSY7TgV4x8K49heSbMhiv4TbBoC6p
	fuMNJa6jAulWVjIRcWITtI2n9Qq444Kdvg7E4nWfUTxSONtc5P58QJx9fxs4kYTZpLC9KeUS8s1
	ilK/FnR1Ug3fvZssbvV0iqxXGIoZ3SvhCvk6zIfjwGk7FZavoEp7W1hv6K8/esRnmXOgsiaHNS1
	j2d14RYcbvG0mL
X-Google-Smtp-Source: AGHT+IFrm+HnX+DKqjrzyDEzZevUOzkckUB98RzWsO6EpAjPOvGPrTYO1ThdZbbOoF0JmkLR1SS4uA==
X-Received: by 2002:a05:6214:c62:b0:707:43a1:5b0d with SMTP id 6a1803df08f44-7097964cf4cmr68796306d6.41.1754531099046;
        Wed, 06 Aug 2025 18:44:59 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:44:58 -0700 (PDT)
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
Subject: [PATCH v3 08/30] kho: don't unpreserve memory during abort
Date: Thu,  7 Aug 2025 01:44:14 +0000
Message-ID: <20250807014442.3829950-9-pasha.tatashin@soleen.com>
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

KHO allows clients to preserve memory regions at any point before the
KHO state is finalized. The finalization process itself involves KHO
performing its own actions, such as serializing the overall
preserved memory map.

If this finalization process is aborted, the current implementation
destroys KHO's internal memory tracking structures
(`kho_out.ser.track.orders`). This behavior effectively unpreserves
all memory from KHO's perspective, regardless of whether those
preservations were made by clients before the finalization attempt
or by KHO itself during finalization.

This premature unpreservation is incorrect. An abort of the
finalization process should only undo actions taken by KHO as part of
that specific finalization attempt. Individual memory regions
preserved by clients prior to finalization should remain preserved,
as their lifecycle is managed by the clients themselves. These
clients might still need to call kho_unpreserve_folio() or
kho_unpreserve_phys() based on their own logic, even after a KHO
finalization attempt is aborted.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index b2e99aefbb32..07755184f44b 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -778,31 +778,12 @@ EXPORT_SYMBOL_GPL(kho_unpreserve_phys);
 
 static int __kho_abort(void)
 {
-	int err = 0;
-	unsigned long order;
-	struct kho_mem_phys *physxa;
-
-	xa_for_each(&kho_out.track.orders, order, physxa) {
-		struct kho_mem_phys_bits *bits;
-		unsigned long phys;
-
-		xa_for_each(&physxa->phys_bits, phys, bits)
-			kfree(bits);
-
-		xa_destroy(&physxa->phys_bits);
-		kfree(physxa);
-	}
-	xa_destroy(&kho_out.track.orders);
-
 	if (kho_out.preserved_mem_map) {
 		kho_mem_ser_free(kho_out.preserved_mem_map);
 		kho_out.preserved_mem_map = NULL;
 	}
 
-	if (err)
-		pr_err("Failed to abort KHO finalization: %d\n", err);
-
-	return err;
+	return 0;
 }
 
 int kho_abort(void)
-- 
2.50.1.565.gc32cd1483b-goog


