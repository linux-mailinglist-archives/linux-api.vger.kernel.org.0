Return-Path: <linux-api+bounces-4361-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F0BB1D09E
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 03:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827091AA170B
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 01:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E62737E8;
	Thu,  7 Aug 2025 01:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ssc+rCxL"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF931B4F1F
	for <linux-api@vger.kernel.org>; Thu,  7 Aug 2025 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531131; cv=none; b=azjIKy/u7eMW16fPbuO6ZTQd5DAVefGZJ4tJJIl8bSmamqx9bNq8bfExSFpbTPZQSe6BLH/33Qber1Sbvba3P3M50peymAvY8NWwWIkHwM9yKiAW95qPrkgVc2ykQT4skrQYyZJbKmImQND3ShuumwoAv3oA4UBTwG6oUR3J0w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531131; c=relaxed/simple;
	bh=alpPo77l/7pgZG8VakBmdAb8i5nQRPDoWfvaWJcTLlE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz3dhQUJ7z7N61s5rILgQ+oRp673w+tVskbG1JSB7qPTbzB62yYrxZOAIngsd6QTlTSs0JWiUpChEUnWsDkNNzP8/JikXAfKaT7MhcbpNz1+kKl7b4psWN7nf3+3n/YwcorfC39lWGVp0MIy6iT5lqD9t9TTeeITFsIoK+XUnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Ssc+rCxL; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b0770954faso7723801cf.1
        for <linux-api@vger.kernel.org>; Wed, 06 Aug 2025 18:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531127; x=1755135927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQny4bvpzR8mZbBN1/IVSyxQ9U+JDItGyGw2v+12Jn8=;
        b=Ssc+rCxL+/PekNC5vdpImp4eezZQQXUkesj3lXT7/LRqLT5EuydORJWfACh5Cn2cIY
         YBcBm306eWtSCd6DMYtn8CAx4zwsq1WD/ZSlEakuZyk0n/qkn4VIfvmlDDoKdqDckvxE
         Lh0QJtZiZl2GNLax0IITljlWdsRn20FcbKc0EBpqeTJldwIl59uNYW8QL9Dl+sFrrGkz
         j10+/4VMwzmnNppVZw/zQs9Lgx+ocFg7fbqf7ZozcMRQHeIyHquf6szREDwAALh+8kqG
         /HzRidnV0987oBRaJS5VxBh7mjGKe9LUp/SFKGa27PKa+SyW+BmUghIMRcBnmlx14Hjd
         YeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531127; x=1755135927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQny4bvpzR8mZbBN1/IVSyxQ9U+JDItGyGw2v+12Jn8=;
        b=km40nTgI5IprZWES5sbrMLFLH0AVmzoXZB8xAperJZlbNY47Viq8/9/MFhu0USE638
         VDHpOlP4duQdPA1eyuRMtrwkd7XElMxVM46rL01iR2wOkiBb3Zenl93F2r+djxsxKtqZ
         VuXdKCnS+jJjbmphSopI0k1FJ0/DdO3sOf+o1y5KVW7/5yFIcdBohtp0TLtlcZixe0BK
         ZyAfP9ayLQXwQuzWvT7uIoppDyhTwaU5zlpiETWM+qcFuJ8KxSU9IOsP0FSxCLfdlnpT
         Uv0qMoPyjNJNOjPU3mtaacwE/nXtw1vZEuW4c1FGJrOfwXz6VhBbbimnMv3N4k4LomZU
         0RcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb5/ApyzSX68NNuxMU5BCFJYNh7vWyt4nnXuxlR4Mj8/9wX8G1uZx28nUmYSV1pYVutMWH90y8Vuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxup6h8UGQfXOT+2hGOeR0SMTF06L2mhd466dn12/RA2uoJXPz5
	SDuNjN1LkyCNZGqneXkDYEkysppIra2GvIY3C8icJOyODrpkDZ94wmgoAY4y4/4pwGY=
X-Gm-Gg: ASbGnctQrbtpNP96g0Opl4JqGl5hIHP8vKKQVPMO9UDvNtXGDBYjqbJp5HBQ7Db4vs0
	bE8yrAeCC+IPjwDGLoDNdRJ5Of7qdtaaK3uq52VfeVWqmU2h7sI1AVlR2FCDLeKKjfnyvMYmYDW
	+AGMR5L+IDltkun8X+i4EaMafYpSpoXabFvcLTTFWrPb+XjlwSeoV+coMbcT+eCBIpfZrNbtGyJ
	3QG8sFqvsJgzqnN8zsmkuOHOCU+sTReWdRcoJV13+kRhLCkM1wsFuTvDJzOOVhJYSgDr3Z2tmdd
	9eUbnsq6QwiQrf6wVeIXTv5cP+r03Pq29hyfDmt3jno/t7bs7S2kQTzxv1fb/8mOsgs8Vzkpmut
	NMXjIm6haEDZb8iFMx7/yJuO7uNl+HyEmSIf7RFq0y6JmLAj/tBDs1QzbSj+MwqQtJAplszHFeR
	4/yAaakIh/a826
X-Google-Smtp-Source: AGHT+IFqMT0HUt9lre9uw9F3rpS7vpTxQLIi22l4S1gL4FMPIdcVTcCnIgm3Am+TvXdeRU0xrWJBwQ==
X-Received: by 2002:ad4:5761:0:b0:707:5694:89e4 with SMTP id 6a1803df08f44-709796c75b1mr72234786d6.47.1754531126973;
        Wed, 06 Aug 2025 18:45:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:26 -0700 (PDT)
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
Subject: [PATCH v3 27/30] mm: shmem: allow freezing inode mapping
Date: Thu,  7 Aug 2025 01:44:33 +0000
Message-ID: <20250807014442.3829950-28-pasha.tatashin@soleen.com>
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

From: Pratyush Yadav <ptyadav@amazon.de>

To prepare a shmem inode for live update via the Live Update
Orchestrator (LUO), its index -> folio mappings must be serialized. Once
the mappings are serialized, they cannot change since it would cause the
serialized data to become inconsistent. This can be done by pinning the
folios to avoid migration, and by making sure no folios can be added to
or removed from the inode.

While mechanisms to pin folios already exist, the only way to stop
folios being added or removed are the grow and shrink file seals. But
file seals come with their own semantics, one of which is that they
can't be removed. This doesn't work with liveupdate since it can be
cancelled or error out, which would need the seals to be removed and the
file's normal functionality to be restored.

Introduce SHMEM_F_MAPPING_FROZEN to indicate this instead. It is
internal to shmem and is not directly exposed to userspace. It functions
similar to F_SEAL_GROW | F_SEAL_SHRINK, but additionally disallows hole
punching, and can be removed.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pahsa.tatashin@soleen.com>
---
 include/linux/shmem_fs.h | 17 +++++++++++++++++
 mm/shmem.c               | 12 +++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 923f0da5f6c4..f68fc14f7664 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -24,6 +24,14 @@ struct swap_iocb;
 #define SHMEM_F_NORESERVE	BIT(0)
 /* Disallow swapping. */
 #define SHMEM_F_LOCKED		BIT(1)
+/*
+ * Disallow growing, shrinking, or hole punching in the inode. Combined with
+ * folio pinning, makes sure the inode's mapping stays fixed.
+ *
+ * In some ways similar to F_SEAL_GROW | F_SEAL_SHRINK, but can be removed and
+ * isn't directly visible to userspace.
+ */
+#define SHMEM_F_MAPPING_FROZEN	BIT(2)
 
 struct shmem_inode_info {
 	spinlock_t		lock;
@@ -186,6 +194,15 @@ static inline bool shmem_file(struct file *file)
 	return shmem_mapping(file->f_mapping);
 }
 
+/* Must be called with inode lock taken exclusive. */
+static inline void shmem_i_mapping_freeze(struct inode *inode, bool freeze)
+{
+	if (freeze)
+		SHMEM_I(inode)->flags |= SHMEM_F_MAPPING_FROZEN;
+	else
+		SHMEM_I(inode)->flags &= ~SHMEM_F_MAPPING_FROZEN;
+}
+
 /*
  * If fallocate(FALLOC_FL_KEEP_SIZE) has been used, there may be pages
  * beyond i_size's notion of EOF, which fallocate has committed to reserving:
diff --git a/mm/shmem.c b/mm/shmem.c
index 8e6b3f003da5..ef57e2649a41 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1329,7 +1329,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		loff_t newsize = attr->ia_size;
 
 		/* protected by i_rwsem */
-		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
+		if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||
+		    (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
@@ -3352,6 +3353,10 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 			return -EPERM;
 	}
 
+	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
+		     pos + len > inode->i_size))
+		return -EPERM;
+
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3725,6 +3730,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	inode_lock(inode);
 
+	if (info->flags & SHMEM_F_MAPPING_FROZEN) {
+		error = -EPERM;
+		goto out;
+	}
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		struct address_space *mapping = file->f_mapping;
 		loff_t unmap_start = round_up(offset, PAGE_SIZE);
-- 
2.50.1.565.gc32cd1483b-goog


