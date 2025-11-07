Return-Path: <linux-api+bounces-5169-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71D6C41B51
	for <lists+linux-api@lfdr.de>; Fri, 07 Nov 2025 22:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628CC3B4DC7
	for <lists+linux-api@lfdr.de>; Fri,  7 Nov 2025 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F96A342C88;
	Fri,  7 Nov 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hh/RsXVr"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2260342151
	for <linux-api@vger.kernel.org>; Fri,  7 Nov 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549561; cv=none; b=s5WRc8gp8LEPwAL1h15rFlrfXLzaJfb+BmXPbeX3sbWX2ODK3joIdhk8llIWxRlXHGDCB3emaAMqZK0xyJLl2b8Ehw347q3n4hpUK0Jx+o2WTDk6wrKTdpGAisR9fnVQzICaqQqXPfJ4UaHCcHioGSY2ps7lB2HREM9tUSwKQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549561; c=relaxed/simple;
	bh=OQDXqRJEO4eJVEoDOo87c6PBDuVjCEXxPA4VkxAZLEY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojqN9bIitUvEFXIaUq0ZhqRCchTJCx/MmBboUn/0A8H4TyZveYu4Q8cFBlQSP1OI1pYSItaSagetWRRhuutRhOBtQ4BivOaVWKjuc3wJtpBzOW2MMOvRyA9KVf/H+ZuXKByuXLNuSj8rly1NXGqLppoWPm5jYSHPXidhzevKiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=hh/RsXVr; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f96d5038dso1192213d50.1
        for <linux-api@vger.kernel.org>; Fri, 07 Nov 2025 13:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549557; x=1763154357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hhpreoxnn+nlJNzkmlMtkdI0F+At6xhejoNztjrsnbs=;
        b=hh/RsXVrZjbaHBkByitZJZVc3aDqbcYzGZTsx3ZpP8ymkkh1m/Tk2ncsz9wmhka5fU
         s1PCyuLMIweCiJKAoBUhxyqTs1ezQFhcCnhKeKnaqSqha9+zUSOMSsKa2d08aKsphAV7
         FxoQ0SmGD23EPtKofv76n8ObNkbHIlx9ZHoN9bVlmfys/GOgLepiIjORIqHRJPHOaydK
         t8ALay7cTzU2EJ2DTeA71JiGnhavZU/NYz9k8qlgTfcxaGuTnYTiBlpXH2BsJjqNfNKQ
         /BOl1Usf+7Eu9i7c9+KJ0QTjoUr//LLIzicC8b3TUNYuLXhnS2Mz2LkXEcXrcAHhpNPF
         bwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549557; x=1763154357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hhpreoxnn+nlJNzkmlMtkdI0F+At6xhejoNztjrsnbs=;
        b=UQ4nb4bmROg7CK67Lt/yHYekNCwEw5WeLOoAZoHZMcEKKdRB3U5dzg3rRjJZv0Sj7m
         wpfOfAQjpWeeCGaLVGDzlQF2+rLrYeTZZKv7IucL1R9oYvOaAhVObsPb4F7UX5/D2cy0
         5K5l5YhZOF9919cc1GzOG9Y9It5jWt+H+cHWVba2HJ0b6v+7ch2p1102tiS20tv+tlhk
         O0TXr5WiJuLKNjAVxZE2aAyl9+WoNb0QJZYmqp2lkkpQ4uKIPzDlCh+hapNIHkEU10H5
         JyyJswez7kC2iXgn2FVfrMHYZS+ss6nR3ogN7qTX1AA75JRRCI0zVHxyl5fjGGxNsQjH
         jdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsQOT0LQuqe9EbDyVAWsl1nDtT6syZhxCF7H9rgO7Lkzgc8uVVPVE1evfYdg7Im7ShJt8m1PJGTq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Wib/HRyvBasVzte/+RTjXSuNIru9W/wrX64parzXD/3mBNi6
	xJyjwHCthxtMz/bXLoMQbfat0XRFrjyh4qr5iiiuOp5hYZE9qKv7ZjPT1ZQgqPGuYp0=
X-Gm-Gg: ASbGncvkITGFtqnkJkrR4arwTbD1afNUhu31Ak7HOJxvmDYiVj2dPIzhePWwEYRLXhK
	5K8lB8uu0Vv3VCoigkqE0IKfKVZwXmq+bkrv3/2tYiss8QmsM+PPQMYihhFtaCebNlTwffqIEUW
	hp7dCiZLNsMDr87u1VgDUBWrwT5aMX66YHVF8keWmvSxGVLfKbRu729NxBZ23+smJTWzLqc3X1c
	QJ5k/pIEfJtrf4DxDHN7OIChvaqrekE0SP2NkK9LDX4kCuQ5ExweKqlMUbvXxsxdxO3TEz/MCCR
	yssqmDDeAYecqsaVIsqrk7m31khKD/FuLnV8EWoRfKC/Df50W2Caq/JIN1p06TJUqGd9eErZmcN
	Dve6YJ2Ww7BxctPA8xYMXknzkpUm9EQYuWYf1yzdCcTfKxaqZC6b69tT+E6U3+4e1FFebY33sya
	+4rPdRQ/cDK5zoTvF4sUVxZW6gjOOZTra/srJUnCgv4fYaVYZk1PKia4v+uveU3Cw=
X-Google-Smtp-Source: AGHT+IHM85YUuXPyVoM2odrjHYP+mwyWLe1kB8N8z+ntfjkrejgyHe3L+oNXvJsvcedHEWGfvX9bBw==
X-Received: by 2002:a53:b113:0:b0:63f:31f7:b956 with SMTP id 956f58d0204a3-640d455a4b6mr353591d50.27.1762549557262;
        Fri, 07 Nov 2025 13:05:57 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:56 -0800 (PST)
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
	chrisl@kernel.org
Subject: [PATCH v5 13/22] mm: shmem: use SHMEM_F_* flags instead of VM_* flags
Date: Fri,  7 Nov 2025 16:03:11 -0500
Message-ID: <20251107210526.257742-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

shmem_inode_info::flags can have the VM flags VM_NORESERVE and
VM_LOCKED. These are used to suppress pre-accounting or to lock the
pages in the inode respectively. Using the VM flags directly makes it
difficult to add shmem-specific flags that are unrelated to VM behavior
since one would need to find a VM flag not used by shmem and re-purpose
it.

Introduce SHMEM_F_NORESERVE and SHMEM_F_LOCKED which represent the same
information, but their bits are independent of the VM flags. Callers can
still pass VM_NORESERVE to shmem_get_inode(), but it gets transformed to
the shmem-specific flag internally.

No functional changes intended.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/shmem_fs.h |  6 ++++++
 mm/shmem.c               | 29 ++++++++++++++++-------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 5b368f9549d6..710b1dd681bf 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -10,6 +10,7 @@
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/bits.h>
 
 struct swap_iocb;
 
@@ -19,6 +20,11 @@ struct swap_iocb;
 #define SHMEM_MAXQUOTAS 2
 #endif
 
+/* Suppress pre-accounting of the entire object size. */
+#define SHMEM_F_NORESERVE	BIT(0)
+/* Disallow swapping. */
+#define SHMEM_F_LOCKED		BIT(1)
+
 struct shmem_inode_info {
 	spinlock_t		lock;
 	unsigned int		seals;		/* shmem seals */
diff --git a/mm/shmem.c b/mm/shmem.c
index 5c07e2b57c34..19be8c575647 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -175,20 +175,20 @@ static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
  */
 static inline int shmem_acct_size(unsigned long flags, loff_t size)
 {
-	return (flags & VM_NORESERVE) ?
+	return (flags & SHMEM_F_NORESERVE) ?
 		0 : security_vm_enough_memory_mm(current->mm, VM_ACCT(size));
 }
 
 static inline void shmem_unacct_size(unsigned long flags, loff_t size)
 {
-	if (!(flags & VM_NORESERVE))
+	if (!(flags & SHMEM_F_NORESERVE))
 		vm_unacct_memory(VM_ACCT(size));
 }
 
 static inline int shmem_reacct_size(unsigned long flags,
 		loff_t oldsize, loff_t newsize)
 {
-	if (!(flags & VM_NORESERVE)) {
+	if (!(flags & SHMEM_F_NORESERVE)) {
 		if (VM_ACCT(newsize) > VM_ACCT(oldsize))
 			return security_vm_enough_memory_mm(current->mm,
 					VM_ACCT(newsize) - VM_ACCT(oldsize));
@@ -206,7 +206,7 @@ static inline int shmem_reacct_size(unsigned long flags,
  */
 static inline int shmem_acct_blocks(unsigned long flags, long pages)
 {
-	if (!(flags & VM_NORESERVE))
+	if (!(flags & SHMEM_F_NORESERVE))
 		return 0;
 
 	return security_vm_enough_memory_mm(current->mm,
@@ -215,7 +215,7 @@ static inline int shmem_acct_blocks(unsigned long flags, long pages)
 
 static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 {
-	if (flags & VM_NORESERVE)
+	if (flags & SHMEM_F_NORESERVE)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
@@ -1580,7 +1580,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 	int nr_pages;
 	bool split = false;
 
-	if ((info->flags & VM_LOCKED) || sbinfo->noswap)
+	if ((info->flags & SHMEM_F_LOCKED) || sbinfo->noswap)
 		goto redirty;
 
 	if (!total_swap_pages)
@@ -2938,15 +2938,15 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 	 * ipc_lock_object() when called from shmctl_do_lock(),
 	 * no serialization needed when called from shm_destroy().
 	 */
-	if (lock && !(info->flags & VM_LOCKED)) {
+	if (lock && !(info->flags & SHMEM_F_LOCKED)) {
 		if (!user_shm_lock(inode->i_size, ucounts))
 			goto out_nomem;
-		info->flags |= VM_LOCKED;
+		info->flags |= SHMEM_F_LOCKED;
 		mapping_set_unevictable(file->f_mapping);
 	}
-	if (!lock && (info->flags & VM_LOCKED) && ucounts) {
+	if (!lock && (info->flags & SHMEM_F_LOCKED) && ucounts) {
 		user_shm_unlock(inode->i_size, ucounts);
-		info->flags &= ~VM_LOCKED;
+		info->flags &= ~SHMEM_F_LOCKED;
 		mapping_clear_unevictable(file->f_mapping);
 	}
 	retval = 0;
@@ -3091,7 +3091,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	spin_lock_init(&info->lock);
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
-	info->flags = flags & VM_NORESERVE;
+	if (flags & VM_NORESERVE)
+		info->flags = SHMEM_F_NORESERVE;
 	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
@@ -5833,8 +5834,10 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 /* common code */
 
 static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
-			loff_t size, unsigned long flags, unsigned int i_flags)
+				       loff_t size, unsigned long vm_flags,
+				       unsigned int i_flags)
 {
+	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
 	struct inode *inode;
 	struct file *res;
 
@@ -5851,7 +5854,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
-				S_IFREG | S_IRWXUGO, 0, flags);
+				S_IFREG | S_IRWXUGO, 0, vm_flags);
 	if (IS_ERR(inode)) {
 		shmem_unacct_size(flags, size);
 		return ERR_CAST(inode);
-- 
2.51.2.1041.gc1ab5b90ca-goog


