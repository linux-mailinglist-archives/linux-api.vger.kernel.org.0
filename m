Return-Path: <linux-api+bounces-4304-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D78AB1B9F7
	for <lists+linux-api@lfdr.de>; Tue,  5 Aug 2025 20:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3244189DB4E
	for <lists+linux-api@lfdr.de>; Tue,  5 Aug 2025 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720872951DD;
	Tue,  5 Aug 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cxi2QUyk"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32E277819
	for <linux-api@vger.kernel.org>; Tue,  5 Aug 2025 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418286; cv=none; b=csVHrXzrIBNebR1H824xDwCsmuJowMMlmZKM+GhJBeuhLQ4QGm5bFHvU/RSLJGjiKArLbMrcSvAVcty8trYQu3bVXQkFyxxLGprRz3csH59rk4kuGSVnytk/NAhNhmIbh3dGKBK2cmtxjENXrgy2q+78CKgovTLVew3b8LxgLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418286; c=relaxed/simple;
	bh=OKVLqHIWmibana5VQZUJL0qfjT6gFJPBTJLNVk0SJRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2fwFgTx9aYBMbqqm6fBemRaammzWjRBDW07dSz28cUv0TOQLvOSVwsdbKb6Hfyy++59w/IrHBX2arTsCSPIWxN7Daj6x33n608wUGUCX6gT0SUonLciE429rRUejDwqH+M3yX5+ZEszGUol5NC2eyVIr7JpaoCY6MuGfCJvBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cxi2QUyk; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b07cd5019eso19878441cf.3
        for <linux-api@vger.kernel.org>; Tue, 05 Aug 2025 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754418284; x=1755023084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OKVLqHIWmibana5VQZUJL0qfjT6gFJPBTJLNVk0SJRY=;
        b=cxi2QUyki+j6r+AUnCw3RvWjcY8wIMjzkQZNYirvohpuOLbHcTqWGlWYsBGih7XRuF
         tFCgDzdFxy6+hDAK9GBcr0CwCPPSTwy13E2CkyC8rdhql8M8FQqKY38sbvSRrIlWDFTs
         B5P1qDdfnbnVgRUf1c0JV/ymlLzeeThbf8FhGhHQKpXUFUnDRTn1dRmQr1/397jWil1z
         MBOQ/FPyok5CCskwl9J7N9Lpeze7tBJCuK6DhWIjjRE0adMBmv58evpAHzHNds/ZuAbg
         BBlCMsogK6zHRFvWBP6ULOgAGU1WCvIVdFaB0EUTN0AA4I7Hq8BBai8Umt/V/3EVI60R
         GAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418284; x=1755023084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKVLqHIWmibana5VQZUJL0qfjT6gFJPBTJLNVk0SJRY=;
        b=CP7VtnhjRtQDTPeNAYC3NWFkHwyKlk1DvRNGnAeHo+6Sks2v5o3/cCp+SBP0E5vXHD
         2wt8rZnZ9kFMpQ4Y3GRMP1q9uTk/FtYshIRuf6uwYI9Uii09T2LxygpEhl0hM8R/NaGq
         rrgTbsUVZw7gYVKwXLgsdmyRj0k5a8hzMfknZDxo473JttgXxWo9r7YkbHL3RlxNLjJy
         BQoHNbm/4BJvPTv8a7PSAihrd5uzeQYiSt7j569D019/RD657qg3ofJkUfSvvUXHbOFl
         3wVOEEuBfBTKds/2Erdx7qodEJtEbsjcslC2nwbtn1tMoH2eonrdHCZU0abk2De3gS4j
         PUjg==
X-Forwarded-Encrypted: i=1; AJvYcCUvRfzbBw9yUOTPeRRxzY/0rLWCgCiiah7IdIu8Vx/Ha2LJuo2lUwGV5Kng7w1q5pKm0oyYKgjEVrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw16Pjp8PL/zT43w4CNhLNYhyNdGS7B18Cy0h+0wP0Z+456PBr7
	U4ANE9ziVP4SiwMjelfXwab3exgTUjNWlKPNV34l66LFLyEs2G8+xy5lFybnwjUtXBFPvVNr8ft
	QVQfh7Cqgx99jUysMpy/sMH3H0CIhsDCdcz7iENnvLg==
X-Gm-Gg: ASbGncsGrt2DeSjuIAYnHAPW1JF0kfqBxLCJmljCgibNul+W6hqBy9Hz10KAdy+szqV
	SatBFL1H8YGjoThXr6Py9Sihkddy++m0buG4R5PB22l+77aJLwmkxedEACsieF5mI58FWy9MFhO
	zdm8yk3JlR8eD80/XO0TT9tZbq16Wu/l+KsA0aqsQ4xE3rXTauPdb+N00KRJ+5Hst7VaeHGgFcr
	35A
X-Google-Smtp-Source: AGHT+IECP/Qxkxwml/cf3BCEf7Q2B4NHOjK/2NaPxdggrpfuJmAft+1jLFMG+N7JFiUAXv2wscgyaif0s26EEgdezVo=
X-Received: by 2002:a05:622a:191a:b0:4b0:86b4:251a with SMTP id
 d75a77b69052e-4b086b42b17mr42712121cf.25.1754418283817; Tue, 05 Aug 2025
 11:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-32-pasha.tatashin@soleen.com> <20250729161450.GM36037@nvidia.com>
 <877bzqkc38.ffs@tglx> <20250729222157.GT36037@nvidia.com> <20250729183548.49d6c2dc@gandalf.local.home>
 <mafs07bzqeg3x.fsf@kernel.org>
In-Reply-To: <mafs07bzqeg3x.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 5 Aug 2025 18:24:05 +0000
X-Gm-Features: Ac12FXzHvHvpYHaqyT4n7r9UBwaTJ5dSsQkeIlx-mzYjpvX_Sd5MnNPi6FTtCG4
Message-ID: <CA+CK2bA=pmEtNWc5nN2hWcepq_+8HtbH2mTP2UUgabZ8ERaROw@mail.gmail.com>
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Thomas Gleixner <tglx@linutronix.de>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> To add some context: one of the reasons to include it in the series as
> an RFC at the end was to showcase the userspace side of the API and have
> a way for people to see how it can be used. Seeing an API in action
> provides useful context for reviewing patches.
>
> I think Pasha forgot to add the RFC tags when he created v2, since it is
> only meant to be RFC right now and not proper patches.

Correct, I accidently removed RFC from memfd patches in the version. I
will include memfd preservation as RFCv1 in v3 submission.

>
> The point of moving out of tree was also brought up in the live update
> call and I agree with Jason's feedback on it. The plan is to drop it
> from the series in the next revision, and just leave a reference to it
> in the cover letter instead.

 I will drop libluo/luoctl and will add a pointer to an external repo
where they can be accessed from.

Pasha

