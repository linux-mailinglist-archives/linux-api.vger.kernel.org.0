Return-Path: <linux-api+bounces-5527-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4874EC86B90
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 20:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC27B4E4585
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60632D452;
	Tue, 25 Nov 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gaz/sIUP"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869D2528FD
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097312; cv=none; b=NH9DgbYRtA+csqsH+ou7oGhdHNRdXtdp1OYTMQcZRH3tPPAjyKlOzlLpG9GW8BOWIIswdvxjGfMH0KPnS1NZvfcjdNdtoCvPnYT6eEdBmOEY7CW+1nRzXpKFPXEZ3tHL1iISOKwT3XjJgPrC29Y8MmyPf7lY0gx27kXyEpJHY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097312; c=relaxed/simple;
	bh=MOyjrq9o6VhvNdGxsukEhpqXDWstKGHoaaJHOE/8nqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IO2cAMA9c0E2Wm4YqXpTsxZfawT13+26ChBs0iwbPMrBisdYfrMKvlLA3+Dv4ansHbl/C8QE3xnFlIZ851TzS1E5eVjRFPluhjba087zJI22thZMO3X8veCt706NsN6r/EeWc4URNYujIjixpKDJQpvZ5VB3AYWguXZ0LA/SJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gaz/sIUP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so10077151a12.0
        for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764097309; x=1764702109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+cab5OoFiSAnh0Rr1KkIMrwuY0x0IPZJPyGZAN91W0=;
        b=gaz/sIUPnVyEAbMa4nHlq67irq9G8tHlouy1AmrGF3ax4IsbJHIwRGSpkPO2NOm5xc
         PaIQ6tRg6jdyKqWAVpdIEIAJPw3+zg9UedPjStCHsaRdpCFtp0QWKacaMO0aP4kYu7/X
         tyJ8PwlLH6lGzh+gUVrLUF+PjvaN/dAbxyKS3LXsAlYU7m4VBzctEH5lSVzuLh5DVAIp
         TmTvfnSGC+pufTBskrZNocvBbRnKsOq5TC2eTr+gMCaRYPE++dR+G3n4Syt0bPQsUtqK
         Havf51x/0gdPFrOa+AqrmtuDnUdy7EhvCSd2CMX5ZAVIE37MIJVFMiCobFtlLSnUWg/v
         gOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764097309; x=1764702109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c+cab5OoFiSAnh0Rr1KkIMrwuY0x0IPZJPyGZAN91W0=;
        b=kl71AFsSMwde2hUGuhRuCK2O77i6wSYEXEnfZc97FQpVPqbNRr6m8ZQTWVLTuh0c+N
         zzU/JiIP7mIC+mwzS21tuQ7cY1Zrb54cncLVEXDT8e8oI6r+vLgXxs2mFs+anKD+G6vN
         HFGFcQsEc7B7JfwGMT/oAIGH7NtsBeXz1aeEp+1q+t8qZzDDB9IxU+GCAWdGkzgPdIFU
         kfnOftlt3AY0O549C+J9LWKi9CJshiGn2AdiAQISecHstGkXF6JoTjL5YaDV2MbZMfMb
         di/X960ABhnrMr1NqlJLDAO6TqxeVDieRGpaH++stxDMiSLDCY/BVMf11pkNTmKPUKVd
         sC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCB51+51cf2dsszGO7kNb3GnF8sN2a1PAkzARk2gIAMoBEAdeTFp5WBUwzE+Gamc9uqi4ilkWd77E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfN1j80uY5Snn8ztPWQNkOfDPfH64eKfiQbJ85x1BuBoWlYWO7
	J8dQ+uHvk9BB9pf0YvYfZb2jOOvc+y4ag2TMqUlFki7cbPleF4nuYEiF6MF4nTpmXgk+LSe/DcZ
	1/1sDrf0WCAzVBo7HyDsKiRYuHgj8XyKO0C9iJoFUtQ==
X-Gm-Gg: ASbGncsr4fZHEHo6krYmaD/34Mf9mXK9BzIpyJMWpmtxaqYA96EjyDsuhLOJo7ocqSr
	De5emduASx0hr3MBNgPm3D7bragxaPBZTejDwuqfZzyUsdgnV2/iI0DP0/y74YGAjCwDPRX4bvE
	I6Njbf0H0PQmXJBg4lQ1har2XP1jtKlNO12OxOkB1ve/8KhCTzgLoQZYI8OzxfaFi/kNLkzs2Ex
	DGsHVg9YzHFOrfp7NEch+zvA42dK9SkxwWr2XzwnyT3ZwO5UtyGVDA1dfstGL6oseb3
X-Google-Smtp-Source: AGHT+IE7rh2493kGukystiIbPKWb0LUwVClME9rpzIqFBySy1Ee89iOW2xWboR8KNUdfVwKxse2RLFaevMjMIITj+Qo=
X-Received: by 2002:a05:6402:5252:b0:643:4e9c:d166 with SMTP id
 4fb4d7f45d1cf-6455443ed4cmr14156611a12.8.1764097309246; Tue, 25 Nov 2025
 11:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
 <20251125165850.3389713-3-pasha.tatashin@soleen.com> <aSX7Nm_yrXHeejQU@kernel.org>
In-Reply-To: <aSX7Nm_yrXHeejQU@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 14:01:12 -0500
X-Gm-Features: AWmQ_bn2a3c7qeqfEVEla4N9ePeEsUIzOpDhVQeyvGV93y9dTtTiY8YHmxuVAOw
Message-ID: <CA+CK2bDJ0QwbVi07A2tAohceuOur8JNp2Dut3DEZ5z4EFwXz5g@mail.gmail.com>
Subject: Re: [PATCH v8 02/18] liveupdate: luo_core: integrate with KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
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
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 1:54=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Nov 25, 2025 at 11:58:32AM -0500, Pasha Tatashin wrote:
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
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you!

Pasha

