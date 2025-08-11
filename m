Return-Path: <linux-api+bounces-4441-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7244B218F6
	for <lists+linux-api@lfdr.de>; Tue, 12 Aug 2025 01:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B83460D3B
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 23:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE423B611;
	Mon, 11 Aug 2025 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSHJWR2A"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9D238174
	for <linux-api@vger.kernel.org>; Mon, 11 Aug 2025 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953875; cv=none; b=KLNAKtlwWYSNdcknuf+2qTP5PR3h39DsAFGjJZmf4eYtnKjlTVgtFuAx31AXXYhfmfXewBGAQdBrsBgjKbJjCFoZNFupvVu2+QCbPeQGwsjsk0Qz8ty0KOA2lUfTNi+sodZG0VlJQ32pj0u3ugztz+Fkw7r8Y7BfQ37BC6LQUwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953875; c=relaxed/simple;
	bh=XlKWe7hGY5MiFreFuz3bf4pAkpABAV4Hc9Q8DzXwtQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCRB46L/2AoRZLXnq/fx5CKNqcbe8ML9HM129ceQedIbw6Q+WPdqFaHVej4TBwwQdHbOflYZJWwzALDdiJ0Kx0rCXMIj+6dlhIfSfIUjwwvl9240PdfAGm3KMyoL0DLFMiSyP6tMJz6rVTsiu3D4wDjk48c3GDZ/SZ0Wupj9D3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSHJWR2A; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-242d1e9c6b4so89655ad.0
        for <linux-api@vger.kernel.org>; Mon, 11 Aug 2025 16:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754953873; x=1755558673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1oV7yVKsQ5TCnNZCaQ3AZrRbIoYDq2nQJuy1DeTjIQ=;
        b=YSHJWR2Ak4gKSANGEL3Fqc1ZINt5iFRbA0zVKdnvL0nnrT5J7nx5tQuwEy6fGH1kka
         UcFrLsH6sQOhTkcUt2VHNlaRXkU9eJ1/6gEJexK7A+fBYC5SgmkTbhrR4MBcBoVvyoOu
         xAe7SjKWG6czv3spPAy4dOGwTs0FNxeCXIHWTScr7tItz/DAOpZJXqBfzWYHSHstTI8c
         sF/Y7AffUIuqhEjogcjUewGZ1DURn34f9y3fS9Ai3O6go+qe4mZCoqKRayKPNgF97GcI
         FZw/9GQTxy6T4Hn/S2l4EXMEaSdGc9j7admfGv6LthS+q7Ah1vmimLLWSXXFhPK5yOpN
         RlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754953873; x=1755558673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1oV7yVKsQ5TCnNZCaQ3AZrRbIoYDq2nQJuy1DeTjIQ=;
        b=ONYkqA78UmZgdiAwLwna4kua/5Kw7P4XKZHIvB98vN49jjf3djs/KSg5SmkvLrsCWI
         proIjDhDzxRycvj5Xn+y3m7bWf1GP8YB9l9we8xyf09DoiMJL2Yz0oLe5nrvtr11EuId
         k0o9sm9nFSLvv9MvL+gv6TynZvi66LU/9UYneFxEY/9pqKoil+Y2L1u50mczsmm9Mz/f
         4z9/FCw0YDPdKMGrAwdpPwbq/fH5cuIFxE1v2TcxUYVTywOBgtuHF6bZOHVzWat0sq0z
         aOMB/vAqME40uxpuPeP6wjhITbh1zblzOuTszx5u8mUGVLVMs5sUdYrLxAPhphbWX8w9
         blSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiwymAuQ3a3ob8AVNHDjH8x+ct/0RkZEipr4CjC6TMET9vDTrFHvWq+aQ08DfxS9Mk2PkoOQV6Q5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIazxLJPc/0xDoFj/ousVP+QhSzmO/8KOOKWA+to8wwZZcZ+u
	/bjc/xwZfzS3see9ANzxONzf8JXaOmAXDLcvc6pxUkpTYT+bX58qTs4HivVDB2ZguQ==
X-Gm-Gg: ASbGnctgXVU0uIjSu2Bs2B1exisMC+ITDT4gZULi+LJ1Du+6olyJ1f9EL0OYOHs3TFa
	tzRmPlcC6+IDuk9NYqxl0WkDi5d1hXXzOV3icuSZMaUZK23mrArNkgJ26dPXwCQGowRgm527000
	mG44Rg/vIlUsqKpkr3DofOisWiDRSMH4mHC0hLtqf5NQnxUdBcN1RzcEWsI6+OjS8XrD++d5wgo
	1ffm87+xmpoPW/DIjA1CB/yLnk3J9cKHDIQU44SzFRAZHz4PZ5WT08jvuwOqWauKQtlxxipRJwI
	m85cm9opiR+ayMrlECcPNjS7rdSNRuDHZQQJoZHzHL/f3ihijEgQT2sx4HlEY6/bP8z96PyNP6f
	ePrK7k87qNCP9XQw83Rz//m1DVHmHMk1LArBNl2zWMvpRMNJ0kC9mLgunIPr3dbXpsz0O7A==
X-Google-Smtp-Source: AGHT+IFzyKR/w1E27eWm6IovhDIP1SONsBPcExVJWFEliFhx+rfqf71Fi48caAfu36gGEzgxJL2HPA==
X-Received: by 2002:a17:903:41c5:b0:240:520b:3cbc with SMTP id d9443c01a7336-242fd3660c2mr1826635ad.14.1754953872909;
        Mon, 11 Aug 2025 16:11:12 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm27859139b3a.54.2025.08.11.16.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:11:12 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:11:07 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v3 26/30] mm: shmem: use SHMEM_F_* flags instead of VM_*
 flags
Message-ID: <20250811231107.GA2328988.vipinsh@google.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-27-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-27-pasha.tatashin@soleen.com>

On 2025-08-07 01:44:32, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> @@ -3123,7 +3123,9 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  	spin_lock_init(&info->lock);
>  	atomic_set(&info->stop_eviction, 0);
>  	info->seals = F_SEAL_SEAL;
> -	info->flags = flags & VM_NORESERVE;
> +	info->flags = 0;

This is not needed as the 'info' is being set to 0 just above
spin_lock_init.

> +	if (flags & VM_NORESERVE)
> +		info->flags |= SHMEM_F_NORESERVE;

As info->flags will be 0, this can be just direct assignment '='.

>  	info->i_crtime = inode_get_mtime(inode);
>  	info->fsflags = (dir == NULL) ? 0 :
>  		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
> @@ -5862,8 +5864,10 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  /* common code */
>  
>  static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
> -			loff_t size, unsigned long flags, unsigned int i_flags)
> +				       loff_t size, unsigned long vm_flags,
> +				       unsigned int i_flags)

Nit: Might be just my editor, but this alignment seems off.

>  {
> +	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
>  	struct inode *inode;
>  	struct file *res;
>  
> @@ -5880,7 +5884,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>  		return ERR_PTR(-ENOMEM);
>  
>  	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
> -				S_IFREG | S_IRWXUGO, 0, flags);
> +				S_IFREG | S_IRWXUGO, 0, vm_flags);
>  	if (IS_ERR(inode)) {
>  		shmem_unacct_size(flags, size);
>  		return ERR_CAST(inode);
> -- 
> 2.50.1.565.gc32cd1483b-goog
> 

