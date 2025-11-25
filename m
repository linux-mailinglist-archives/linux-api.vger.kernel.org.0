Return-Path: <linux-api+bounces-5500-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B49C85E1B
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 17:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A84E215F
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C4B23ABA9;
	Tue, 25 Nov 2025 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HaQ0p0lS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E622CBF1
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087027; cv=none; b=VlguJO+xwFBZkHrGuA2gMbLthVQjd1ZVMy3Knn8skRwkVwLEHoDrSJjk08P8OkNvYjdJYeb1y40pNyeU6rJVvUFZGttIqWQ4EU5uAiTSdXIYx3tuS+eSxClBsKpKFbJmD6Tahd++WvwpCXDZQIPQ14ZgTFzvBTmGRToMrie710o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087027; c=relaxed/simple;
	bh=+LXF37LiU3fuJ7QnC+x6GzPR+lrzHoN3xK78QQ9aMzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+YKZqMpv8ryrq33CQI2FCS/blwWD2+CehjsgimtsuVslyOjyJlVE03A0hQ70GRX6iyvtzd5ZBAHcfYmKoVenQoDSXnkVIVCjyt7t8f0hnPjHDDEp9v/ffM6O3OGgx9e10m/FcfGn6S2NJ98lIi41Hlrnf/4E2FJGJc2Sg2svhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HaQ0p0lS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso2927870a12.0
        for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764087023; x=1764691823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZjV6DtXhsZ5AkR3PkxyMa000cMnBKP6+/LjP904D4A=;
        b=HaQ0p0lSW56X6zR1KUOhnv4PeQx2lwGN/tYu/GH9xyPBeutYOe0dGzX/iwDS3ZKspo
         nH2BNZ6SfPIBB5P2P80cjgoTX/Yg39FREOdjc8SlyQw6NGIT3ZgA4F1ssbAprmZEPzZC
         xQ60FRRHM60yM0xSIc0id6TPuKuEbEd/0MSz6/XwODXwp91i7SFcUhXvo6Qm9C1GOint
         3Pwr+FbO5tTX76eyJ1qghWjd/8orHyEWW0fPg/twfLylGI6bSmzrgOItCz+++zSRIGNc
         lHTZIGAhIy2Tcut8YyNEACZPZRJJrSk9Xo0nqzU/Vf0Zkxqx5V8iL2Xv+hQJ7V2R0M3T
         MGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087023; x=1764691823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ZjV6DtXhsZ5AkR3PkxyMa000cMnBKP6+/LjP904D4A=;
        b=CdmjcDjVOlLZm4rr8qvm8zSQX8dNAAcHJzGoPbbB9xFas/i1RLc+T8MMeQo/x9Yl9j
         hmnukPpi1nOP+2bLroSJLeW/MJZYVoq/k8GbmYSwU2ijdmGI2+RmkC0hxrEQltQhbRyS
         eXrys3GjJRZRVlkaLto+8vNrBnYP2eKj+eJyZEHQtTaJyhUDVEEGrsL+xeZEXRat8OGO
         d6iYOJLkgusUUEIRWg8c+lRu+fVAdizNZF/rUOMGTRUWLZUl8FuWJIfyJNgYh6J5ZpAr
         Bi4JJ5rSjGSlxO5juIUN7ZDIuwCu0nh2xAO9FW0ypLRhLQ13uPMLahrLqRLr48/LEty/
         F4Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVoFaM+XgZ0STJBZzvF1qQscjn2JT24dgerXXHJtPH6cPNkLUr1CH4nD2jwnhXEPyTD+Bw5Fp3WOfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTWAqaly1EGfl2SyUY5ylUfZQUrAgMzItQYFh/bspE/6yarmN
	E6Z6vVIw9IY9RQKL4IGuFUvW4RbISSFRYg/9wxlCbrHCEEymhU7owd3ma4lZS4cVGDXU7DMrrtL
	qItbtxhbtRdfr5HkgDT8/rIkXGns3REWg1QQzYc5KVg==
X-Gm-Gg: ASbGncsluu7cunr8l2dtpHyWIaKsnIyI8uFCA7aDXEyYZ+SRlIkua6nw9XjeeRYJdjT
	DECWL9cHYFSqSl7qZHrI4JO+SWQO4wqlkkdKkf+EcsrbaGrrZ9ham6EpqV/buTZrX5NPG+flUha
	Luv3kIJgIp63R5d4+uJjgBF09FUpWRddhNitgPXiv6ZVj6FF5E6zxkFWROxrLeVX+38MqMp6l4G
	rkOHsdZrRsBWc6T3KVRboILo4vbQV8opC0x+iA3J+IeioWSR/E5gAGX9kFkmbCwv6QX
X-Google-Smtp-Source: AGHT+IEE8pFdl7WzD0Q0QybPHjOSG7Z/5A80NYawnvCXoY05NDZWq/KDeZ5UjLXRkONdwsanA3Sa60SF0QSqqiKVFUw=
X-Received: by 2002:a05:6402:1d1c:b0:640:aae6:adc5 with SMTP id
 4fb4d7f45d1cf-6454ddd44e5mr11579420a12.4.1764087023025; Tue, 25 Nov 2025
 08:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-3-pasha.tatashin@soleen.com> <mafs0ikezzf30.fsf@kernel.org>
In-Reply-To: <mafs0ikezzf30.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 11:09:45 -0500
X-Gm-Features: AWmQ_bnmED1MVHVi80Cm4w9yINLIQ5SIv6ctTKaf0R1iFr-NNvQCFN256DGI_UI
Message-ID: <CA+CK2bAbKLocBO8zrhUaevXtsF3BMxyaVznOwSTYxFt6MjYpxg@mail.gmail.com>
Subject: Re: [PATCH v7 02/22] liveupdate: luo_core: integrate with KHO
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, dmatlack@google.com, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:21=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Sat, Nov 22 2025, Pasha Tatashin wrote:
>
> > Integrate the LUO with the KHO framework to enable passing LUO state
> > across a kexec reboot.
> >
> > This patch implements the lifecycle integration with KHO:
> >
> > 1. Incoming State: During early boot (`early_initcall`), LUO checks if
> >    KHO is active. If so, it retrieves the "LUO" subtree, verifies the
> >    "luo-v1" compatibility string, and reads the `liveupdate-number` to
> >    track the update count.
> >
> > 2. Outgoing State: During late initialization (`late_initcall`), LUO
> >    allocates a new FDT for the next kernel, populates it with the basic
> >    header (compatible string and incremented update number), and
> >    registers it with KHO (`kho_add_subtree`).
> >
> > 3. Finalization: The `liveupdate_reboot()` notifier is updated to invok=
e
> >    `kho_finalize()`. This ensures that all memory segments marked for
> >    preservation are properly serialized before the kexec jump.
> >
> > LUO now depends on `CONFIG_KEXEC_HANDOVER`.
>
> Nit: This patch does not add the dependency. That is done by patch 1. I
> guess that change needs to be moved here or the comment removed?
>
> Other than this,
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Done, thank you for review!

>
> [...]
>
> --
> Regards,
> Pratyush Yadav

