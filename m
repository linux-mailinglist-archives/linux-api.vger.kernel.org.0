Return-Path: <linux-api+bounces-5522-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D00E7C86A24
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 19:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496563B3EF0
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488753314B6;
	Tue, 25 Nov 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYGZ5fqB"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED8330D3D
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095494; cv=none; b=tWGK8k7furGpj9UaO9I8ofhmXX+ToRZsK8C3kAQCWu7EGE7+M/Pd+JhcbqpkWb4yLTWyQt6opmenwr3KyOY86NNxGkCP5m/Fhjq6scnnS+qgduvUZvCLKTyBZvM/zN302Z9sXDlLqmKu9RdGOx5tG5/ZKdPe/S+0gN/XErVld8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095494; c=relaxed/simple;
	bh=5tz2aAHBD7vTNYLjZkzJH3s9gWYpFddvilCC/4yN7Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puEgf0MtqHPScyeITv1WWDwLNGFfCJZ723tWfEGGSaiEHWsFKZWZOqXq/+cBnmDez6V4aufkLyDefg5/0Aekysb5DygzvmpLqGGLfyujC1iyGPGlWyucU2XYDybx5R/zrAbBKZR9tD0dR7whiRuWy+2Q2CruBi9OFmzirLBYqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYGZ5fqB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29806bd47b5so35708805ad.3
        for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764095483; x=1764700283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7O4GSlYSAloya2gWAKt06Wd2oP8bRALkgcDobg98SWs=;
        b=aYGZ5fqB44pcrFVN8TRn947PWEw4614zXbXiJ67T3hNxZYwAWtkslkYq+4QZAL9ZHU
         Xz2/Kb/GUjT/9T92647u39aYnmz30z3PMv4eSjIcimJbMlc5YfdGxkD9iQJUmzpo7YAk
         PoEtFVfyeHuMFC1znRZrd6Y82Mg5WtEVct9WxztFv3T86rPp/MPuVMvq2MsZp47Io6RH
         Uxa8LWtwTSUi4Mac1UDbAbpjUbyIKHp0OPMKw//ygq16YYazGu7ZsaehloVTbOXe6NYY
         39SbxX6P7TAsIyRlooEfamSOE/nL6mzozue0sa7zLXvBkZyNP6io1RQQPRFp8nC6J7Fh
         /l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764095483; x=1764700283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7O4GSlYSAloya2gWAKt06Wd2oP8bRALkgcDobg98SWs=;
        b=LYdACES0wdXfLvWBxPoWRO7NR42M740IOZB8qBtMo+V0wF5GADR7k+9JM4wf3y0k+p
         KsRam35tZFWyaLoP7+8DN23YseHuesZQFaGnynvmTLfatObQlqb+I4f6j+iqoUyNZIbE
         f0L8j/sr9O244lAjeeX8l1ElL0EsThP73TwGw3KX1xVWGGLEVGC3WXXhgSf7ThsPVoKN
         NXuAv7ds9rjSq9uKOg9s3EgvtMrc5IbfHdtmLbJoOER2mhMuTt7jQQRtvVHBG0C9MhFO
         cckVDLenWZA3Raxm+ZFHwgD85uTpEDuETKZE8FlKXqpfXwAr9PgFSFQ5A3xun7LyWSfG
         yQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVqXtABWNBwQmy11fFq0EpzhmwspHMDIrpAVxKr2z5uyFjxuPKkbDGqGHlA0AFJWnAFEEhHNfhWjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegSe5fdzXop9QLr6QegNFlSvTYtI5P5tUI8PkuUra8cAI+l+O
	0MxEjgLoGd3C65I858LeSTz8ZGGTFWHjzJFm+QGtJSoDF+jlXNfQ6M+QXFCMYXZL8g==
X-Gm-Gg: ASbGnctw5zuETsMXhI09n8n0uwdHnh+Sl8w8b6DWxcyjcUi5vWRUEMEvFGzrvktMbJQ
	qLYi1mpi6q294x2R6zAOaHWOQQXtbtiGeP2wgsWoosSgmagG1YjPLhh2AeD1BDEr3kuJEEvkIIs
	Yj+y3VVBCeOX2aCgfMCCYJ/bRRqsVR7hj1C2XO5/gilZQtdky5seOMGnWEan8lxESNoz/GHFYJs
	bh/t1piX8x7I8tz4A4VAfD3Ubk4K5z/HQ/LJXlGRd4aD28TYQ/ykfRjLQF4jmwM8Asqu+WT4Zzc
	1W2BMLSpTSXSWyCio58uUfvDUKkPXYjgdBab3egeFPHHhkOORK0iCnA/bRoq72CquIURXTVgxEC
	lzvZN8dPzh7h8qXGEK3R2m3IkqziQQBySeWefsYOOxhqmWRmG5w+8MaWxVB+zD7RBM3uiZ/7X3R
	MljOhhAgvr/8s10rRJWg4mykLwDDJw/uivbFMzjgtYHUtrVYc=
X-Google-Smtp-Source: AGHT+IH53ckBol+4yeTGTxnoskxcelqMTn+43AKcIW+arxac7wzKqrO4rD1ChIviUV6IKHO85b4pJw==
X-Received: by 2002:a17:902:f691:b0:295:68dd:4ebf with SMTP id d9443c01a7336-29b6c3e3c48mr197452115ad.16.1764095482759;
        Tue, 25 Nov 2025 10:31:22 -0800 (PST)
Received: from google.com (28.29.230.35.bc.googleusercontent.com. [35.230.29.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b26fff4sm176035005ad.68.2025.11.25.10.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 10:31:21 -0800 (PST)
Date: Tue, 25 Nov 2025 18:31:17 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	rppt@kernel.org, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v8 00/18] Live Update Orchestrator
Message-ID: <aSX19cWypvh1mKWM@google.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>

On 2025-11-25 11:58 AM, Pasha Tatashin wrote:
> 
> Pasha Tatashin (12):
>   liveupdate: luo_core: Live Update Orchestrato,
>   liveupdate: luo_core: integrate with KHO
>   kexec: call liveupdate_reboot() before kexec
>   liveupdate: luo_session: add sessions support
>   liveupdate: luo_core: add user interface
>   liveupdate: luo_file: implement file systems callbacks
>   liveupdate: luo_session: Add ioctls for file preservation
>   docs: add luo documentation
>   MAINTAINERS: add liveupdate entry
>   selftests/liveupdate: Add userspace API selftests
>   selftests/liveupdate: Add simple kexec-based selftest for LUO
>   selftests/liveupdate: Add kexec test for multiple and empty sessions
> 
> Pratyush Yadav (6):
>   mm: shmem: use SHMEM_F_* flags instead of VM_* flags
>   mm: shmem: allow freezing inode mapping
>   mm: shmem: export some functions to internal.h
>   liveupdate: luo_file: add private argument to store runtime state
>   mm: memfd_luo: allow preserving memfd
>   docs: add documentation for memfd preservation via LUO

I ran all the new selftests, including those that require kexec on an
Intel EMR server, and all tests passed.

Tested-by: David Matlack <dmatlack@google.com>

