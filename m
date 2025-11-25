Return-Path: <linux-api+bounces-5528-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B21C86BA9
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 20:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F17254EA2CE
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64A334378;
	Tue, 25 Nov 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ri43bzU9"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C433372C
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097336; cv=none; b=SO3BnHh2IXKDm4c0ftMLLRiyQLhAOUDaBB39e7ZqCE3kTtyi8qNZuuGVoegjRIsCnOHPmUWJ6iTRAZNNSlJbv8mt/mO11OdbTVipYYzaT27WZhHMy3Kk3il5BIqdfjo42too5I+jjffMW52+v1JVRJibnkqOyl3pQun7q/SlDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097336; c=relaxed/simple;
	bh=970Jb+cB9ffJi62n0bHygDXaRpTlD4aGe7LWlTUIJZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/USDGKOhEeH0cn5k126sFdB97nDx6FYNrABK9QYEM/XGjVaPJFthlVsUKTqv46MGWKTv80Tun1QkaCaUN6oNaahIg7zwdD+2zkVPbhY3E6ndmm2/w0T72naSuIo7dlofGbxHusmBirNwiuXq6glIj38SI/NTMQaBCEfiugaFCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Ri43bzU9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so9650108a12.3
        for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 11:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764097332; x=1764702132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZbg8SojFwo+/6fxa8iIzTLQdoY14/XcMqsoNhFxHBw=;
        b=Ri43bzU9PV3GsKnbo5msKUxeko746al/XKpgFUQIawRvXxZ8dbkldE3ryv/+HaQDvC
         6KfH3c7PBTV78p+xxTMsMs1QZI9xg1W2X2VxjjSxH773PeCwaHKyl7GaN8meS/qe/Hba
         lYGw5y2jp9GaXsLEn7KMNvS/8/+5EidpUzLca6fF3OEQjUFL+wNpjpbfq2LjYmfWM+Y1
         UjPfA/vP7q24euMX0piDER9ICqZ/wNKnYXoeS2QNFUn4beB5p2YiuU4KyHIeaBG8QpcV
         7mh6OPBi6TFdKPKBwBH+ZM01b06+QlrjX7rK8b3n3UlEsGZ1A+iSdLsMbKBxIafuONGB
         SQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764097332; x=1764702132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZbg8SojFwo+/6fxa8iIzTLQdoY14/XcMqsoNhFxHBw=;
        b=pqpPZjKsvPLFSY1U0/xwETFWGlOHXH6dayEqj0yl2khwl9h3L5vNgdjfiZSjxY82/N
         c1KTg09Ar/Ipt219XxcZLmMgJdCeu0Dxg4KTaj8uVWfXvS13GqWNP6T9AXnMc9hWEWXU
         q87zTH023jRVxNLSm477hLcr9RkoZboZwYBKBBc9Hj8ZLzanm+RJOM5+kKwMgHi7MuC+
         Ownh4Ww1GV2jZwTndeYoxlMsl/UAPCexOZpufEo8AobEuknfA5XUVr4wkE+Gzl/WdbYi
         w8aYXd/iXeG5Mus6XvLReRtV9sj4DdjMAZvrxItLMfc7/gIkzwDWljrf5NnS6xwLHY2w
         YT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwKA9JCeDOOjawOxfvx4E449bNnij1kUd6aKFer7BwCyrKwT169GO4BQoKJc0gMiBYNx6G4B5Hl7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVB3ZaBBQJFJ1cji8L0wkMXu823hEzZJ+lXt84HMuSFp4hcD0
	ZwwwLAIgGYj0KOTlDyEqvwlzNHkAj2BB63M1sFuu/UQUKqhlV++jmi7D9saCr9wXAqDdVQRpTe9
	Vcb5ToY5BSxh9feCvAzaVW7UBq+VA3OrzqNPe/ffI5Q==
X-Gm-Gg: ASbGnctUcVutwzt2hgL/agpxBpk56wAFBQ9BrUId3bXSy4pwesKcNz2VmNhzffXR2WO
	+Vfr/Z1vE6GKG5pa8/H53wU5THa/gMCSzrieF5hBEBEXJMFYhWbhdQk+/TSwiXrSRveDWcE3Riq
	R6rkjQRoeQKdTIkPSoO7wSZ2qcsPVATN41b9i6QItSLKNwzxBXQtgZBZkQZQIL5cLyIC6NrzKDx
	V5SSJce8Uy2eJPfFoUucRUAQEGfoNyua5+TW6tKiMoRxPCXvoncaWH12rmGyjS18tgx
X-Google-Smtp-Source: AGHT+IHaJ/LbREE5Jpzko9OcKbnJBE1+OgV3WfTKWJciDLFdWD0t5cmLQ1AQFk0Y1AJ05l0WSop6DSkyv43G2Zwocz4=
X-Received: by 2002:a17:907:9720:b0:b6d:5262:a615 with SMTP id
 a640c23a62f3a-b76c5630b03mr446231166b.41.1764097331448; Tue, 25 Nov 2025
 11:02:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com> <aSX19cWypvh1mKWM@google.com>
In-Reply-To: <aSX19cWypvh1mKWM@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 14:01:34 -0500
X-Gm-Features: AWmQ_bmdDcUwBBud3cZl0TGUz3iSEuxf2L3NoBzXOoPUOHJetvLBDiXl30iG0_Y
Message-ID: <CA+CK2bCq3K3dd1a+OGtsqGHpraFZcbxc_LCGt2CPz6euFD=_CQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/18] Live Update Orchestrator
To: David Matlack <dmatlack@google.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 1:31=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-11-25 11:58 AM, Pasha Tatashin wrote:
> >
> > Pasha Tatashin (12):
> >   liveupdate: luo_core: Live Update Orchestrato,
> >   liveupdate: luo_core: integrate with KHO
> >   kexec: call liveupdate_reboot() before kexec
> >   liveupdate: luo_session: add sessions support
> >   liveupdate: luo_core: add user interface
> >   liveupdate: luo_file: implement file systems callbacks
> >   liveupdate: luo_session: Add ioctls for file preservation
> >   docs: add luo documentation
> >   MAINTAINERS: add liveupdate entry
> >   selftests/liveupdate: Add userspace API selftests
> >   selftests/liveupdate: Add simple kexec-based selftest for LUO
> >   selftests/liveupdate: Add kexec test for multiple and empty sessions
> >
> > Pratyush Yadav (6):
> >   mm: shmem: use SHMEM_F_* flags instead of VM_* flags
> >   mm: shmem: allow freezing inode mapping
> >   mm: shmem: export some functions to internal.h
> >   liveupdate: luo_file: add private argument to store runtime state
> >   mm: memfd_luo: allow preserving memfd
> >   docs: add documentation for memfd preservation via LUO
>
> I ran all the new selftests, including those that require kexec on an
> Intel EMR server, and all tests passed.
>
> Tested-by: David Matlack <dmatlack@google.com>

Great, thank you David!

Pasha

