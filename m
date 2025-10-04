Return-Path: <linux-api+bounces-4990-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6BFBB8833
	for <lists+linux-api@lfdr.de>; Sat, 04 Oct 2025 04:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1D54C1C35
	for <lists+linux-api@lfdr.de>; Sat,  4 Oct 2025 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387FC27CB02;
	Sat,  4 Oct 2025 02:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ERaRtHRm"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F122F01
	for <linux-api@vger.kernel.org>; Sat,  4 Oct 2025 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543687; cv=none; b=R57ZvTAj5orjNQ96Qq90IWvtMoiTtRoYk8Fm9nRITyPVSc/SSomJzny4B4l3pxkYHKzvJfvo4oHEi25fWX8YBo9NlGCxmWu12Jj/aLsPUS6OhJ4DcPJAfE6VL23A1K4iFFYPq7Z8IjYaMmOYHHLWj+phMo16c6nwHYMxCpl7mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543687; c=relaxed/simple;
	bh=9GkZ2ovBhlrelu07cpIypphZYtifcDUvN/jmG88PUQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVfcXd68RT1VMO9qMReC1yuRMfOrcOnCwErcO+vuIWkUP9qcEwjDRyEJEY8U2Po1hbvjmy8MjG/XaTo0+wZevB84IPbeo8ZobAypRojzHPsD9zrqSkWiREuPP+7eMrjAolh4l4GgsveLVLKtz2uazWPMEz8r0O4M6w6IvsbVpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ERaRtHRm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ddabf2ada5so42998841cf.1
        for <linux-api@vger.kernel.org>; Fri, 03 Oct 2025 19:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759543684; x=1760148484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUzxeZbPvk/JfjYehvQ9soJfDbesrcMGvdBByvWxU1A=;
        b=ERaRtHRmELC6MLzov4Q5lUCizzsGcbNoDiUj6nu3VrTw4cunvIvR7UlAgFaHBn9tYP
         sdx1gvDlic91ZNXnpfLgLN6ZH5y6k9WZOZgRLD/2W28h61VH9LfU54oKMGBI43Cu3ttw
         asAnetsAWcmmDibxQyDRArTsZmB9HPs1r9F7/ZLM1cfvKueLkbi2StD2u1tVqc7RSVX8
         x8zOhDuxZxHVCVJFH5HrwjY/7HdxJ9EVT0ywY8ul7q9Hg1j4rzeCj6MmalmINsBT06NL
         fVAIGx46FcceLSywRonlH4guKs0HDinYNDcWzh1uEE9qXBUjImUHXLn7M/fFQqD9so1S
         rhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759543684; x=1760148484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUzxeZbPvk/JfjYehvQ9soJfDbesrcMGvdBByvWxU1A=;
        b=UThEWGLKUCFJMIl/3lsXHv/p/VllVxq04r51nU7Rn+/jjZ/4NUE5eTnsjIy2fWDWvq
         EB2NePmd46kq1cF347ppdcaRl8duEZdEQGb/opMwY79DXidSoQ+aIMLDaa1eli8wJ/23
         rY2tWpy066NwoAeK8rzXS1YepCy1wJm3nPuESxDxJKFBgomX5G3OO/C6ju96iiQFBMeW
         Y4NA6vwGfZALDvf+wUT1g2/WmhDVxCj8Mdg5TKjI7gdxvlgeiOfs2kTbTrotihC9vwZD
         dmsa6cSFOYR6aEeC/UXTUwC+NrLoMSZ2L7satZdmZju5KWZnGpHgWZjO6i9gmIsOiwuL
         bawA==
X-Forwarded-Encrypted: i=1; AJvYcCVdVDknhwPWqXA34bfoOcGHxUMQp9o2OWopx60ZEve+lzMVSePr/VK7nEJOpmDhkTDkh1oYrssdPB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2EyS/O5c6N7gM1Af/zIzRV0K1qTNz5k0aNbwjgxzqoeJhJpm
	aM0vA04nU/kIYf5KSvln3pwg0CKdKgW/H6z7GxqKU4rbQUmVmbFcq/gcUI7Oyw6r7SwMrVJnZgU
	Jb7yQvCiXKfoMD/6lW7Kp7o8FCfEB836SCoycEKLkNQ==
X-Gm-Gg: ASbGncvd6bEKFR3GAZ8q9eieZBkI5obYLQx8rTDps8gKjc9vY841/N3nuTwbNgwLY/f
	3C3m3+PdQ2vCFd8TO1budLbF7z+AuPXG6V+qnrX3PobPn5GJHiEgjvA6rXrNJT59pXinh5Ibphx
	smrlxdGr4DRlHrGh6Nr51wNxdKXiRPAanrRNEyGbVl9nBZM/cA002SST7IApCwosbwTtes5LAy2
	nfEvKPARR1bmJSvTiwlvPOdZk4E
X-Google-Smtp-Source: AGHT+IFAx1beBR5GfbaocbXfkSDXQDNMN60sJRbMybIKRDn++zqfipiOogFVh7nBoj/mLbN0/PW9BivaXIC2sgg2LhQ=
X-Received: by 2002:a05:622a:728d:b0:4dd:7572:216f with SMTP id
 d75a77b69052e-4e57e29e758mr31789071cf.32.1759543684209; Fri, 03 Oct 2025
 19:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-27-pasha.tatashin@soleen.com> <20251003225120.GA2035091.vipinsh@google.com>
In-Reply-To: <20251003225120.GA2035091.vipinsh@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 3 Oct 2025 22:07:27 -0400
X-Gm-Features: AS18NWBWoPm9Z7b0vbgm_XuBKnUybemYL0aTisq9eF8wk73w7jPTSRsrgP_RACE
Message-ID: <CA+CK2bBuO5YaL8MNqb5Xo_us600vTe2SF_yMNU-O9D2_RBoMag@mail.gmail.com>
Subject: Re: [PATCH v4 26/30] selftests/liveupdate: Add multi-kexec session
 lifecycle test
To: Vipin Sharma <vipinsh@google.com>
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 6:51=E2=80=AFPM Vipin Sharma <vipinsh@google.com> wr=
ote:
>
> On 2025-09-29 01:03:17, Pasha Tatashin wrote:
> > diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/test=
ing/selftests/liveupdate/.gitignore
> > index af6e773cf98f..de7ca45d3892 100644
> > --- a/tools/testing/selftests/liveupdate/.gitignore
> > +++ b/tools/testing/selftests/liveupdate/.gitignore
> > @@ -1 +1,2 @@
> >  /liveupdate
> > +/luo_multi_kexec
>
> In next patches new tests are not added to gitignore.

Will fix it, thanks.

>
> > diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testin=
g/selftests/liveupdate/Makefile
> > index 2a573c36016e..1cbc816ed5c5 100644
> > --- a/tools/testing/selftests/liveupdate/Makefile
> > +++ b/tools/testing/selftests/liveupdate/Makefile
> > @@ -1,7 +1,38 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +
> > +KHDR_INCLUDES ?=3D -I../../../usr/include
>
> If make is run from the tools/testing/selftests/liveupdate directory, thi=
s
> will not work because it needs one more "..".
>
> If this is built using selftest Makefile from root directory
>
>   make -C tools/testing/selftests TARGETS=3Dliveupdate
>
> there will not be build errors because tools/testing/selftests/Makefile
> defines KHDR_INCLUDES, so above definition will never happen.
>
> >  CFLAGS +=3D -Wall -O2 -Wno-unused-function
> >  CFLAGS +=3D $(KHDR_INCLUDES)
> > +LDFLAGS +=3D -static
>
> Why static? Can't we let user pass extra flags if they prefer static

Because these tests are executed in a VM and not on the host, static
makes sense to be able to run in a different environment.

> > +
> > +# --- Test Configuration (Edit this section when adding new tests) ---
> > +LUO_SHARED_SRCS :=3D luo_test_utils.c
> > +LUO_SHARED_HDRS +=3D luo_test_utils.h
> > +
> > +LUO_MANUAL_TESTS +=3D luo_multi_kexec
> > +
> > +TEST_FILES +=3D do_kexec.sh
> >
> >  TEST_GEN_PROGS +=3D liveupdate
> >
> > +# --- Automatic Rule Generation (Do not edit below) ---
> > +
> > +TEST_GEN_PROGS_EXTENDED +=3D $(LUO_MANUAL_TESTS)
> > +
> > +# Define the full list of sources for each manual test.
> > +$(foreach test,$(LUO_MANUAL_TESTS), \
> > +     $(eval $(test)_SOURCES :=3D $(test).c $(LUO_SHARED_SRCS)))
> > +
> > +# This loop automatically generates an explicit build rule for each ma=
nual test.
> > +# It includes dependencies on the shared headers and makes the output
> > +# executable.
> > +# Note the use of '$$' to escape automatic variables for the 'eval' co=
mmand.
> > +$(foreach test,$(LUO_MANUAL_TESTS), \
> > +     $(eval $(OUTPUT)/$(test): $($(test)_SOURCES) $(LUO_SHARED_HDRS) \
> > +             $(call msg,LINK,,$$@) ; \
> > +             $(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@ ; \
> > +             $(Q)chmod +x $$@ \
> > +     ) \
> > +)
> > +
> >  include ../lib.mk
>
> make is not building LUO_MANUAL_TESTS, it is only building liveupdate.
> How to build them?

I am building them out of tree:
make O=3Dx86_64 -s -C tools/testing/selftests TARGETS=3Dliveupdate install
make O=3Dx86_64 -s -C tools/testing/selftests TARGETS=3Dkho install

And for me it worked, but I forgot to test with the normal make
options,  thank you for reporting, and providing your fixes, I will
address them.

Pasha

