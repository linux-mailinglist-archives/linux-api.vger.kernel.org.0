Return-Path: <linux-api+bounces-4282-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C21C7B1910C
	for <lists+linux-api@lfdr.de>; Sun,  3 Aug 2025 01:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A354189AB5C
	for <lists+linux-api@lfdr.de>; Sat,  2 Aug 2025 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C141E5B7C;
	Sat,  2 Aug 2025 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cgPACfat"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD24689
	for <linux-api@vger.kernel.org>; Sat,  2 Aug 2025 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754178411; cv=none; b=GnS0FwveMJm0wUWP8evPzNmeNlHPx99UxdU5yHLe5aNkrHCLO2lrbHpwWRO39vAR8jwfOaLFvn4ucOXcn1cfGErMkcRVxiuMm/vtXicnRBAnN/qNv8xJvPtxAZdMIVfGPmJLwwUtjr/N3502f+O9hTwiWSVvViyI8/wyw8241KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754178411; c=relaxed/simple;
	bh=vAc/4KiHAcjlsBQPHI3wMhShkkf1hfeQY3lbP94F0mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnEMSSAr2EJWrQh0dHzBgYCd20rTwqzEVvy0QOWj8RMKZXvFez+DRbU7Sa4vNldBwPpcwswPYbJdIFnfQAM0H5aowZh0/6XbpKQnjCfpcgy/6esJchLIWPgRt0L8BA2Z1WamUK9j6TH/aEzX2o4ewSR6IPCPoaERsJdk9uaSQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cgPACfat; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4af156685e2so10320741cf.1
        for <linux-api@vger.kernel.org>; Sat, 02 Aug 2025 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754178408; x=1754783208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omSxCOyrH+cAC0v6maS2PTOyG9YcJYfYvPlLW3DY1LU=;
        b=cgPACfat0WhI8UuC2n8WP0kbRDCjkhg0j6kz0R6iMWhaa83EHI+pZc8A9rse91mHpG
         URd5Pm5YArkSOGxuO9aq/aSLMYEqFjojqI/lfgVjkqc+djODqw0ow28sKDEkzjmwvvSM
         HeKUFh7gMBei1E4OxNZwqzql40QU7t/IJtPTvWjTdMdbAhlYoIqrGahPzOm4zRPD2gZF
         blFBD4UxSdcl8NhLw3ebkw4SfL8NACRQ6ZvntGH7p0RLidog89esDacio51ADmAHbVe8
         vvo8rFXGFojfzfswxTN+pfspK5Y2FDQh/2jktHBQbaf4vASEjmgG3KR40W1FSK3U4wni
         mIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754178408; x=1754783208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omSxCOyrH+cAC0v6maS2PTOyG9YcJYfYvPlLW3DY1LU=;
        b=LAtGHO7Owy2Oa4WdVcM5UBsQGabtYGFqTBSYyTjisNFy1HLs19ydHEgZ3dDILjBRkw
         3s0fbmrvzxaaJ4ogoeAFg3UflVhZW7Yq01p+qAVX7oh6gyDsciAys2/SfpF0hdMd0+Ca
         HDH7aRlD+GxL/p/oozpq3nGczXn0JPL5Z/AjKGmpB8bZ0ZHgOhtKa/v+hTa5F4t/QXPh
         cCKQg28Mv56nBP6ze6o5hA/jNazYuqQpnqOyagEfdLhUsE+xO1BV4h22bxoCJJVIe6N1
         dYE0iK4MC00JMmCNGT9JH5NC64qmZOGkmAK6DIPAvTVc+OdBEJdfbv6Q/0vCDfUHU91h
         Gu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSpHoWhxDz4lOIWkN7PIKBGFdvtGyEgQGMKhcIOPvDR6Tc1Tvm40awmLYMnslogTIhq4UXqIcNCbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSqK4CdJStgufaN7HlOM0lVfupKZOG7QIvMINTamPNM1xOTA9
	fVpAjHYeru8MQnK0llhmq8H7rZYqEdETHs8NvSBmLRCe/S4zvndBbPk4lPv3OOueHgbUa1IArjc
	jFL1opsu91C9weN6wIW6A+XltxYG4KiwrTzX3CjvtYw==
X-Gm-Gg: ASbGncv+LIzzeRlYW8xGxx3F+eCvzgX8nb935mdrbYBklUe8Nm9NJ0GlyxA8Tf0E7fF
	TIY0BrLq7Aepb2G2nEJuH/+AUKz/X1F4bb7nwyfDaK/9dHKVX5hv9msgRgIPaqVI1mqma3cdoaF
	qPc71aLXHkENkxTu4oW6kZn3y2SSHQ+VrN/5OZ4HlU+vIIgVq/3wJBGeq5qMRZlG5VHPROWtzvf
	ahQ
X-Google-Smtp-Source: AGHT+IHdEITyYGYGGvkUJ/FLXWfXeXO8iQNocqY+DuXZ+nO0UMVJgqKLU07m6mpEY1xZc8NU3/+RPBwpxH4hgExqjBU=
X-Received: by 2002:ac8:5e4e:0:b0:4ab:3963:c650 with SMTP id
 d75a77b69052e-4aef16dc96cmr147684491cf.10.1754178407719; Sat, 02 Aug 2025
 16:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-10-pasha.tatashin@soleen.com> <20250729171454.GO36037@nvidia.com>
In-Reply-To: <20250729171454.GO36037@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 2 Aug 2025 19:46:11 -0400
X-Gm-Features: Ac12FXzVHD70UwSnRqGNkZr2cSuqC2q4gMi23eZp3qK6a2xJfpUPm-pdMLJYecM
Message-ID: <CA+CK2bDz0t4+r9Yw+rpf_8K_GFDygXQ_b6wvPFtNYkssfX7wew@mail.gmail.com>
Subject: Re: [PATCH v2 09/32] liveupdate: kho: move to kernel/liveupdate
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

On Tue, Jul 29, 2025 at 1:14=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Jul 23, 2025 at 02:46:22PM +0000, Pasha Tatashin wrote:
> > Move KHO to kernel/liveupdate/ in preparation of placing all Live Updat=
e
> > core kernel related files to the same place.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  Documentation/core-api/kho/concepts.rst       |  2 +-
> >  MAINTAINERS                                   |  2 +-
> >  init/Kconfig                                  |  2 ++
> >  kernel/Kconfig.kexec                          | 25 ----------------
> >  kernel/Makefile                               |  3 +-
> >  kernel/liveupdate/Kconfig                     | 30 +++++++++++++++++++
> >  kernel/liveupdate/Makefile                    |  7 +++++
> >  kernel/{ =3D> liveupdate}/kexec_handover.c      |  6 ++--
> >  .../{ =3D> liveupdate}/kexec_handover_debug.c   |  0
> >  .../kexec_handover_internal.h                 |  0
> >  10 files changed, 45 insertions(+), 32 deletions(-)
> >  create mode 100644 kernel/liveupdate/Kconfig
> >  create mode 100644 kernel/liveupdate/Makefile
> >  rename kernel/{ =3D> liveupdate}/kexec_handover.c (99%)
> >  rename kernel/{ =3D> liveupdate}/kexec_handover_debug.c (100%)
> >  rename kernel/{ =3D> liveupdate}/kexec_handover_internal.h (100%)
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thank you,
Pasha

