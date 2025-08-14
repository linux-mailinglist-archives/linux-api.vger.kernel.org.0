Return-Path: <linux-api+bounces-4485-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BAB26A76
	for <lists+linux-api@lfdr.de>; Thu, 14 Aug 2025 17:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8599E1740
	for <lists+linux-api@lfdr.de>; Thu, 14 Aug 2025 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93491FE45A;
	Thu, 14 Aug 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FsQcS5Qb"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923B533D6
	for <linux-api@vger.kernel.org>; Thu, 14 Aug 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183505; cv=none; b=cPxCKq2wesVbKPnowTT/MtAICC7NdA9fap1RqMVxrvu7P/LZEhfQPBgSQfzE76+FF8U8rLlqhuopLGSPm99Nr1s3gj/FEQJUR22NQWCVjmu4mGQ9Byd/ug8LAA2iH8p3WspmwslSFoYidItSIk6lnzdDdwHLkZy2Nx7YrP89MoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183505; c=relaxed/simple;
	bh=MU3gYDGK17uqY3N6k7XJpgqHs7YiCVPOQMg82gPF2no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFaRhtoxDyn7MhcObzUlKcdVm7B1WrHpwr3VgOMFCoocm4co2PqA34dc4z1zFnAA+GVGF4I83jEyeEVvIAriwVTSD2NZXpwoHmqUOeCfVUSpEKikbbC6/HNy+fy6hQF3zZoj7N2BhfCb4URwY+S31ysYIcujFi6j/MYLYsSHD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FsQcS5Qb; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109bc07a4so6253841cf.2
        for <linux-api@vger.kernel.org>; Thu, 14 Aug 2025 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1755183503; x=1755788303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sgUd9YdBOZy0kVdBoXU78NUeqQMRVWLT5DC2WvX4NE=;
        b=FsQcS5Qbo/1jLYAnxFQZ+qc1uAZjN5JiK3pDaliLv+x51YmAJkeLWfMbkEXP3JpbD4
         YvtN37O7qJIp7KrBSBGVlhefE4jp1yXkpyNK3shMVVpsFtgB2f1Et7qxIv9orFu5N+uY
         X3h2PrwVx26bZmuCuQIMoy6ZSJR2kXyLIxm8wOYNotAFCQXtJ7S+ArJ6KZyAu1Mv55aV
         rl3b6FCbmO4T1/+OgvcmDo3NOLsFOsUZWrEZwwFjQEAmcok1vy8IaL+1xFN7eobJ/7RO
         yRsHK1CSHRqocl070dM0b9lpEYsY6LloPKfg4RfOV41YcseqpC9Gq2ZhL7Beojijx4iN
         jcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183503; x=1755788303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sgUd9YdBOZy0kVdBoXU78NUeqQMRVWLT5DC2WvX4NE=;
        b=BaK/8effEI1fZUBucYk6TqmSW51JUCzwPwgCxQ5P32q6vGuaX3UvANskv4d6eCJflU
         AVwcOe79sTA5q3GemC971anv6FMfODKmUoLtxsIv2XH+C8tUsZe0Ifuo3h+4hDBwp+fu
         B3Rxiqkk/fLPb0tBN3YsOuvlMJAKkIf7Cz0pYSv+z5frsYL6f9JQckfEkl3DoAfy3S6H
         1C2RmFhbhUBq83YaJLVowmoREuDPfZ3TjGUlPFljw2nHqUP407omYYzKuYMYiVeoS/qY
         VPt2SFl5SqZHjMD0MWCknmvDfDM5Y5naqeddj3NFfi3s26x1v5dv+tmtppx7VAV+88Xy
         539Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6sjzkaXshCGCvhbJQQbVBBzv4Bbxxk3qVRRNN2E103JJGD+NwLC4qcVde3aAuAxFp+pdL0LOpfEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyboe0sjMdLPSsS2+ndclsXCo6ZPHPL4k3oy5hFRqDtS8AqEiUW
	dCH8ZJtQKXJHmQZgU/pkyrELBw+ZTuP0dhYeU7rPlU1K3fEoNs3gkDjKLboDDSYvN3KNkIKIjlp
	9hOXyMEa5Bjnsb4dwbkWQUJ1JO78VXxQxtaMkF28PrA==
X-Gm-Gg: ASbGncu5Bo/YjkWDaSofPcWcnLVJQ0LogoppNOTFmj3V26OEjgiKIWZ20Xc468exnaJ
	J8fkcXEy5iTckLywrGa9X32voq7fgFycCcjzxbE9xeD1QWgexYR9T2JucogA+r1G+i0IYyxlnh1
	lThM9K1OYPZmlqe2S0QJyj269CNDPGF28iiK3baQpCORlYUHPAnjWwrM2s7NOWaCZFNB9Oi/Nkg
	9zY
X-Google-Smtp-Source: AGHT+IFHaAxoYBbg9LXBtGJVpwf11YGEdCLkE88L9yAIytLzKSm9bsg1ZUT6QEZSsty4xseoM6W0eewH0Y9mwveJD34=
X-Received: by 2002:ac8:7fd6:0:b0:4b0:695d:9ad0 with SMTP id
 d75a77b69052e-4b10a915ec4mr58260861cf.3.1755183502991; Thu, 14 Aug 2025
 07:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-2-pasha.tatashin@soleen.com> <20250814131153.GA802098@nvidia.com>
In-Reply-To: <20250814131153.GA802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Aug 2025 14:57:45 +0000
X-Gm-Features: Ac12FXzhuAauSUYd9gdMUr4m-BLBsxxrJtaDxuhGuUwdJZFXccXBv2CW6TsGSmI
Message-ID: <CA+CK2bBWEFUU728aQ++7Yp5qXApsHzOTjy=nLMyd7WE27RfQbg@mail.gmail.com>
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
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
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 1:11=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 07, 2025 at 01:44:07AM +0000, Pasha Tatashin wrote:
> > -     physxa =3D xa_load_or_alloc(&track->orders, order, sizeof(*physxa=
));
> > -     if (IS_ERR(physxa))
> > -             return PTR_ERR(physxa);
>
> It is probably better to introduce a function pointer argument to this
> xa_load_or_alloc() to do the alloc and init operation than to open
> code the thing.

Agreed, but this should be a separate clean-up, this particular patch
is a hotfix that should land soon (it was separated from this this
series). Once it lands, we are going to do this clean-up.

Pasha

