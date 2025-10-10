Return-Path: <linux-api+bounces-5085-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8940EBCDA57
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 16:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00D5C34AF8C
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF12F745E;
	Fri, 10 Oct 2025 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bFoqyy02"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D82F3C08
	for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108320; cv=none; b=H0ZbG32XqPh2Kxl7yCPZAeeAuBgBNhyf0erSIKXhzPO8AaLlE0DfZu25WRLdBCPs9bADyMP7m0F3AH1gog8BIiGZNgsXwqhezt6BkcJXDcQ0uI5tAljL80SM0BElCPmV/gOQXEBPiVlxWq0E/tmTAfrC7Fz0fyCA48mvn1MiX9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108320; c=relaxed/simple;
	bh=O/f5MiBij3IECEF2d6NbqhVZBoXbyknaX3YNy+v2jBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BElVDR8dtjr09qulPrkfPm8ZymlGDZhEZIVdG/3qoE8eawh79b9NlBREUEx0q43T4440DD6AeEZLLf4I8VqlIKsa2KRxRdVndEsueCLsUsltMVLS2l504kroqo79shnHtFybLFXeupi41NCpbhWO+CR4PAGbkdnLufDpBRozMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bFoqyy02; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e4d9fc4316so27134001cf.2
        for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760108318; x=1760713118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/f5MiBij3IECEF2d6NbqhVZBoXbyknaX3YNy+v2jBg=;
        b=bFoqyy02oYGr/LuWsFyi0W5Ej8pKXhjqyohD00Z5dbmSNvYpgSVewN3J+q15yRc6ii
         69LaSyM2tnR+luiCcl5eZPTkuEaxMlBkiqscmQBocaCErkJ/8uoJ8JQzcs/JRWsBs492
         ZgPrk5u9q1Nk7hg3EotW9qKnKWO2J2gL22sOWZM97MJcIR6WyTyUXzhBNsJN5wICsyuR
         jr0+y7OHElysr7a1Coplm6vDUbPt5vsBjlh30Ozonuo3yKa9UDglFAxvSAn3SFNb9k0+
         iE+F9gR9VJLEooADnWPNwfzCIFrP6cM7wD85seJ/G3+4aKMou9VK6t3t4TxBQuuxR0l7
         xq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108318; x=1760713118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/f5MiBij3IECEF2d6NbqhVZBoXbyknaX3YNy+v2jBg=;
        b=P9fV3fv+nSl0cypltGBBgykgwON+CahUxGq6QRX7umqNEPrHwrrlvpMKyI+0qm8ONf
         aOuU70L849hTR9DxGS9gtUzgF9DYkKzEZcEzOpcBZr0NFOzgPIfamJj/9+j0eavFHnJD
         KioCxDXXrrDQ2uFMbkt0XjKy5sQBUkGY9e128FPoBH7fcOr/NrQPMIjDEbi0Hkm7SjgY
         l+1VJC9hGL4EMgDt4WcJPDo3kDjsEkrdgK74sVY2F38uDCaU23GCwwBSxJgDMs79x9zs
         iBMrYi1hP1onrTlTRKd0y5OQUvSKJLvUPdGckbIRPVgsPjrPwZABMOXK58MhT6OrJml+
         Xfrg==
X-Forwarded-Encrypted: i=1; AJvYcCV3r47xe5QbvoXB/NxZBeqzmcytHavNSrEptDO/DvZxqMyr8GQ4+mECB/5VffN73zQS7U6gJp0eFfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKq4+ZrmMWHv9rf69u2zkm6nB02MgJN09E5mSBCfYsNfr4ZWTd
	9KcSRS5m5S8B8rX5UEtpun+GC7qqAXM29WTPp2u+ngbnF3YvvEbws/k1o/NIEb1upYZFoVuIlyP
	5XvvDjjJefQFEJO0c9u1wKVfWvAgo74ddoq8cHQ3QQA==
X-Gm-Gg: ASbGncsPS+z9fViMS5k6XlG7Bf071UBOcyEdPEiMnnvgeIFs2vudC+ehqWZw3cRNply
	YHJXaFC2kRL9ZKjHPaJyc+6JQo1DHchznV3tM2Ebzh9rb4rya3B9cGZQNyrMPOtZhJIlFt06sLU
	R/4S/utlSk1Ps8qR2MnpOkmsp9cQ1cAJCpB5JE6YGOR7qLLafKXsq0m1eTMm6/wb9lbQkGylEVE
	SrjCF71O/oFkxi18a7hqr8=
X-Google-Smtp-Source: AGHT+IE0WXDhjauHLcC2POBv0t7LgQCplfzbTEHy7h2aL8mobxzYVpt1EHLlI6ZDdZuKo41ZojriIaW0+E5fBHESUrw=
X-Received: by 2002:a05:622a:90f:b0:4b9:b915:a26f with SMTP id
 d75a77b69052e-4e6ead514a2mr181154551cf.52.1760108317513; Fri, 10 Oct 2025
 07:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhT_9vV-V+BBs1_=QqhCGQqHo89qWy7r5zW1ej51yHPGJA@mail.gmail.com>
 <CA+CK2bAe3yk4NocURmihcuTNPUcb2-K0JCaQQ5GJ4B58YLEwEw@mail.gmail.com> <20251010144248.GB3901471@nvidia.com>
In-Reply-To: <20251010144248.GB3901471@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 10 Oct 2025 10:58:00 -0400
X-Gm-Features: AS18NWBORXQFPGvPP__b4olxbKs0hTzftz4XLJRMqdjSudzyOrwIdA4I2ICtXVo
Message-ID: <CA+CK2bBxMpb=jXy3-i19PdBHqxLoLrMMg1sOnditOYwNe1Fr+w@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:42=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Thu, Oct 09, 2025 at 06:42:09PM -0400, Pasha Tatashin wrote:
> >
> > It looks like the combination of an enforced ordering:
> > Preservation: A->B->C->D
> > Un-preservation: D->C->B->A
> > Retrieval: A->B->C->D
> >
> > and the FLB Global State (where data is automatically created and
> > destroyed when a particular file type participates in a live update)
> > solves the need for this query mechanism. For example, the IOMMU
> > driver/core can add its data only when an iommufd is preserved and add
> > more data as more iommufds are added. The preserved data is also
> > automatically removed once the live update is finished or canceled.
>
> IDK I think we should try to be flexible on the restoration order.

It is easier to be inflexible at first and then relax the requirement
than the other way around. I think it is alright to enforce the order
for now, as it is driven only by userspace.

> Eg, if we project ahead to when we might need to preserve kvm and
> iommufd FDs as well, the order would likely be:
>
> Preservation: memfd -> kvm -> iommufd -> vfio
> Retrieval: iommud_domain (early boot) kvm -> iommufd -> vfio -> memfd

At some point, we will implement orphaned VMs, where a VM can run
without a VMM during the live-update period. This would allow us to
reduce the blackout time and later enable vCPUs to keep running even
during kexec.

With that, I would assume KVM itself would drive the live update and
would make LUO calls to preserve the resources in an orderly fashion
and then restore them in the same order during boot.

Pasha

