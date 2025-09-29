Return-Path: <linux-api+bounces-4969-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1103BBA7B5D
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 03:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572D81898C47
	for <lists+linux-api@lfdr.de>; Mon, 29 Sep 2025 01:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE9B21D3CD;
	Mon, 29 Sep 2025 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XVMFzDf5"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C027F16F
	for <linux-api@vger.kernel.org>; Mon, 29 Sep 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107888; cv=none; b=We0XmN2liVUXkVTSja1x66m0yMdPODyKj7bwcAafi+ujYfy9Fuv34SFgybd1W7q/OFmjYeL5sfFMuy5NMtukvaKOK68aXXQA+M16wMKccCYn3Pg75Ni16dYqBgAr/UwWxJMG41+GIrwzfvYKvednDGzzzC/QJ5nLjEoJNPCbx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107888; c=relaxed/simple;
	bh=wKkOsRSYJa3vc4lYOd4d9l8kUjqRigmITBj/yOFEkIE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b42x46mxPGdBL5yrFy9TSBGllRJA+r/HwDRoV/Ify3mwLrcjEcgViTCNBtRyAJ4lyxrpbcyK1xepl/K3C4bHZ/eQ2n4fBeXbVwPf2vz1HpA/hUb2QTyaJnWHyD3LVdXr71Xdhum3Q+DoZrN2W4fVaL6MeSStMSJ/gSYjbGzkyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=XVMFzDf5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-855733c47baso596237985a.0
        for <linux-api@vger.kernel.org>; Sun, 28 Sep 2025 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107885; x=1759712685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5jod2izHbVl6GoMuI25PsEFlFJNITXcz8AeEB8I3yk=;
        b=XVMFzDf55KpUL/PhJzfKCV3iKDZ5TJ0eWvCFG0YemrtrljsavxwxjoXxLTYJVeXaJ/
         godOw6SVBFUcXrgXwopBV1k5CagHO2hm+JLDxxkR+ykmzomjXOiRbvstKUCC56FTOa/U
         Rv7ojf+Ib0S/8DZNajvbPdZ5GKtFFT/Jep+Zkx1PcxUQhkRkmZ9dXS6uDgASRYm04V0N
         GAmUNrBuTrbLvzfxKWffm0+sqsVW1swJCFW6SxLiS29UEc/HhrGcsyjFo7pgAsCuvfft
         SpjsZ53vGFfxC97OzW9hC7vWMtpFUCIXPox2NMQSn5cH75eeizoMDwm4oOsm5jjOvYpY
         /X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107885; x=1759712685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5jod2izHbVl6GoMuI25PsEFlFJNITXcz8AeEB8I3yk=;
        b=Psvxjm/JeM+fHpzEm6Y3qXArvDbtznFh3V8Xk3GS5JZeE0ZKkevCBDrj8fXUnRmtp6
         IRd0gga5VpCMIZqCM0ruoneWIrZ+2pq2fDnjbgQy547tq9ClKaGif35vG7lNK6grOweU
         3SsD+rzFdQTCywsreBpcYeCNyEAMc6j9wB6FMuZaJE61bg0iNfoHYc2RBrjnnOSYrw8D
         5PNOU4RQpaENFlyESk6W0mvPUrPjwtAwqN7hTdf96h2a/JERK7r4UI7RZGMAR1lXGPwu
         f76Pwczb2hSgE1/E75V7K0rAGLJKx0wDylsQt7Jy57tyJ/Bvj3je82XCdKfvatYMrNrX
         y80A==
X-Forwarded-Encrypted: i=1; AJvYcCWA0oyoPZVkr62S0Hvqd7vKwoaskPGv4BvD8F0eyf45Z1FRvDg665cwHC9z44wVi3NGqflwu1ekCHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXe7rB7+o8gB9xeY/YQ7dKyvq4zWLNgTZ9POhPDNLAGTgvpR3h
	5EBkdkyu/fl4RtmvCaH/E89iDxj7qwCOK3RXfhixYKALw82FVxz9pm/q24vts0l/RwM=
X-Gm-Gg: ASbGnctE3HFY8NjpirF9vW72qH4AAWJS7jzL43ubktFholvmGZGxHzDEGdQY7LnTJcs
	PWeyNPkMwnEQCamqZSbqdNkpBsJA6/u7iB3Nu2CWMLgomEQwQvDOyn6wdKjVhLuAYGTWHOEhdJA
	H224Vkks1zRgKsBzbxmgJ6pRMm+rie9P9VcLcyN6wjNy4UMdS4mlWgSh8p7IMuqQyMPhLSZPibw
	4LyDL/+mp7LVlz3ibTYeI/SmHK2O1JyDBwUF/Teim2Ff3roPXobKKhTdHxSuoGpmAyz1ACtILOa
	nbtNFMwIzJC0/FJgMzpBQrPAaCDHVTg7vSUiix+2fmnT0+nqYJDw9dZd1I/GOkxOvFY3EjZKgGs
	YYqOVdaWkHvfx2fjLFB5UF7D97Rln/r6xnCPbhaHZGdHz3O6PguElMv9/9wu/dQvTQvCQs2srSY
	Kzg8Gqfg8=
X-Google-Smtp-Source: AGHT+IHcWK3+r2DO1mFFWuWSG7txN7iCjmZaeFDLs8Xu4WrTbTEg8yxHdhQIyiKJ1YNZRSeC44Oztw==
X-Received: by 2002:a05:620a:618b:b0:85c:809:3f10 with SMTP id af79cd13be357-85c080943d0mr1326429385a.26.1759107884637;
        Sun, 28 Sep 2025 18:04:44 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:44 -0700 (PDT)
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
Subject: [PATCH v4 22/30] mm: shmem: allow freezing inode mapping
Date: Mon, 29 Sep 2025 01:03:13 +0000
Message-ID: <20250929010321.3462457-23-pasha.tatashin@soleen.com>
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
index 650874b400b5..a9f5db472a39 100644
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
index ce3b912f62da..bd7d9afe5a27 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1292,7 +1292,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		loff_t newsize = attr->ia_size;
 
 		/* protected by i_rwsem */
-		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
+		if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||
+		    (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
@@ -3287,6 +3288,10 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 			return -EPERM;
 	}
 
+	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
+		     pos + len > inode->i_size))
+		return -EPERM;
+
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3660,6 +3665,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
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
2.51.0.536.g15c5d4f767-goog


