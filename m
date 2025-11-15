Return-Path: <linux-api+bounces-5295-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D53C60D53
	for <lists+linux-api@lfdr.de>; Sun, 16 Nov 2025 00:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE02C4E971B
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94738273809;
	Sat, 15 Nov 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="abUQnKFp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBD6299AB3
	for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249687; cv=none; b=M6xp40wAOyeoiWF1FlV62YhOCy6CoYNRdd/Blcy693I0DMYJxsrYcOv5A3TDiNqXXdiAaNw7kcYEu58uvqUAteGIikdL68yp3/HvXTaKBtp76fXLuq0G/vpY1FzakokMCDXydenoGwuLN4EcObKUV/OfI/tyXxzJoXYDQOlNaVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249687; c=relaxed/simple;
	bh=h2vjGzbBg4AU2ifY5ek+1jbDzqzMBe5yccYCDtitHbo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh16/l9HO7gK+/5VxIs/htyKcTAC9M4Vi/gbWM4K5NMwJOAFrqfQQOtSVWQ7B1IBjdvRQLbhNxf1N4aMp1dEC/DhI8OKvZFGhwjhERKmBIDVnvrpfytZ+Gymo/mwrEIkJcmJJWVtvrVYmKri+rwauO6qqE9rFG9BncHaTqFSOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=abUQnKFp; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-641e9422473so1691188d50.2
        for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 15:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249684; x=1763854484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjp2i+yn5YhJt0E9Cm6hXiIeiW1VzlvDXGR3nMqDfIY=;
        b=abUQnKFpmpaAioTjEc5MaZxSqpGfaR0hBJjJPKmL7grHOerbjdMmY/E/rnBdz4Zhp+
         4f4MzmBxe2yXt3/aZ8GGFg3PoDEr0EK9xI2QfWEyy5kxcZO6eokfC88/6rrn3r0elnUl
         6rmp6vVwi3S5b7+HYnCUfC35j+v8fLarRvPWy/tys6dv+Vit9G/k0UpS4BI0rn469xk2
         efuYF2WtmLWf1gnPhZzveTFPrdjrOG92+HC59YwQe98cWvLIgZ7GRWxqkv1RKmlNyG/7
         T07zhjiovMSPdvCvYYZYNQRa3zmMRuValDIePY9NCniS5ueEd+/NrWk8XrfQ3w1ykU0B
         i/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249684; x=1763854484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rjp2i+yn5YhJt0E9Cm6hXiIeiW1VzlvDXGR3nMqDfIY=;
        b=VAaKacV/i+hmfCgyzsLChH3KCuI48d10oIiqcxRzGAO1g6p7SdSuVGj5lYjGbwfwgB
         ZydrzBp4BPoTNwu9HlcVHph+pU2rLgerLdBR95VlWSalYGc3dwu0YBlp4V1wjKdTsNq/
         ELwNcU3n7fySyu/KNAjCFmRX9ID0r+FUy4tbGfDyvVJhfmws0Z2vQt507jfUZDLwHjWW
         N2BXDE6cYn1UNhmvMK3lD5qGb1wP/ApUOhp92oYQCitgPYA0Iyq1oPaDY5LvRk2AiQTE
         3nUT+e7xktHGhk9IzC4YwRtoea34DDXGAYbsOgPnaiueZm1Xun2cXfhbdece+RZrVKdG
         xbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2wKOfLpOHvs+VCRL4Cxa3IO63MNaV5naJNqh7BiXE2WBfww3SmS9Muhsidw2L+M0YthzyMfao8wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0b9g0fU8Nni0gTlnyiICtpgpoQNfe4lOOiUFbYylm9fs10nE
	SrM3G14J2jF7V1kjqx+N9FL7dqxgAcGqWEZblH8wVnSihz1gvTiIn2qhK9ZpmtdwYpM=
X-Gm-Gg: ASbGncse27Q8DSn8HsSEvqgkTgOqvNeNBcz0nBD6r4iGg/QVX7NMypMYItJ9eKSfsD3
	QdaPyDiBwi33G1eX0kY1UEXg6/+n4bz+r9sesjo1o5xEIrnxBVAalBiX3M15I8JUSpG1qfzgygx
	0jc6nNe9+uNDF2zhsEBKRcpNouNjeRcWbh7j70Ms1m7BzRTUfAKDi+3UjcrJagIxOE+sOKGoWKf
	Smmtu9LXXSakdYRc+/vzuYKIYkod/ZiXqZUyaDA3TYyZjSWxhQa0HSE/tErTTYf8KVjHIGv/KiF
	WFqwlDsJRKkmeDrvjzEuwbu4+4/WdE3hdP1oEBH5+s6QLG5ILcAFa/SP/6lxEtZMSsTdQXq4+mz
	tfZLrALn+qXGBcz8IgR275v/HUt0vrGl5Vb4q0qIOsyFNqe6cEkBZRlGX5a2aXy4SdsfujpIzRQ
	SNQ2IaFwLLtbViPzyzU1n3dMpAf8gaeX+ZLY4RwBy/4y1C2pMonP/+HIGyyMjeyuXaYWknPn/dU
	Xxr3ko=
X-Google-Smtp-Source: AGHT+IEqQqw8FjtFSAai2c9iP1dDJFDaXC1XcmhVkOppI5F0MwDFeehYvZcQ8y1up6QBmlqTCYD2LA==
X-Received: by 2002:a05:690c:7408:b0:787:d456:2e62 with SMTP id 00721157ae682-78929ed2da6mr132263187b3.33.1763249683921;
        Sat, 15 Nov 2025 15:34:43 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:43 -0800 (PST)
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
Subject: [PATCH v6 12/20] mm: shmem: allow freezing inode mapping
Date: Sat, 15 Nov 2025 18:33:58 -0500
Message-ID: <20251115233409.768044-13-pasha.tatashin@soleen.com>
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
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
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
index 1d5036dec08a..05c3db840257 100644
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
 
@@ -3289,6 +3290,10 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 			return -EPERM;
 	}
 
+	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
+		     pos + len > inode->i_size))
+		return -EPERM;
+
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3662,6 +3667,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
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
2.52.0.rc1.455.g30608eb744-goog


