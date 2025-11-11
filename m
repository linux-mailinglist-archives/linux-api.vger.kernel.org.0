Return-Path: <linux-api+bounces-5227-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7359C4FC1B
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 21:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9058A18958FC
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9F3A8D7C;
	Tue, 11 Nov 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dukZk/14"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709033A8D72
	for <linux-api@vger.kernel.org>; Tue, 11 Nov 2025 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894700; cv=none; b=G4Dy3uEKIRA98kYpDdb8VylyMetHxG51/Kwe9w+zDjcSnb5XIBySF6UWNp33Td78o/yFKJaQfgA471xfKeE2z1Xd9pNWrH9XavtAhHSKLOiX65Fe5LahWCI/NWIC9uFReUAM2pUYRNH1KzKd9HyM3uyy6B2RsTKCOAc933GgS7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894700; c=relaxed/simple;
	bh=5IPiXaFkwwZtaZuDIqZvEEkFtfPxtooPB1hfynQopyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u65mf6bVVxsNGA7ud3ZF+7QDaQX97t75o2pWQ+PaFbs2yyTm1KdUyxOk4JnGVvDUB1dpcLrIoKGQ04NFFkxuwEqSm+WqWQ8/T7oRHqH2dAIpYuQOzhsxSmlXkbr1Fw7zqn3tFd1lAiLjchqL1LadbMTL9Ut+JCpkBqF4aNvZS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dukZk/14; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso151681a12.3
        for <linux-api@vger.kernel.org>; Tue, 11 Nov 2025 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762894697; x=1763499497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5IPiXaFkwwZtaZuDIqZvEEkFtfPxtooPB1hfynQopyI=;
        b=dukZk/14N6P3AY3E//uOob/83ZX56Gg3zcmtlFUOVT0+RBuc3oVCii9zMzDt0mS7Y7
         pVxePc4+xS3rsb78/9whAgzRXbpZ9dSenr/uKwitxoKL6a39CklQbTWQ84DfE2/2sDpj
         5QrK0yluU7KAdt4/YJyY7bqqDFuGoapuWkAZ/HeBtbDOA+cZvre8wbqZwmo3DpJqRjA0
         AX7ORJWzHwifdvbBKOHF2epxKMLN6oG013yAfpraAz+Z4jBYjZ1Rwwj04Ke5bFL85FyZ
         Hh10I029esix4doxY7fQeqwVT0nERTFDdl81yfWXS23v8Rn7emvqPTcO43gGhwJP6rNh
         ln8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894697; x=1763499497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IPiXaFkwwZtaZuDIqZvEEkFtfPxtooPB1hfynQopyI=;
        b=Db75a0nt9woF2ivXuJEnDrL2PViipLOeDwoeCGumsqB5oZKf0a/wfYJdsHBflQVcUS
         Cm/TjBc2e1sg2mb08YJU6LuFnp7AsA03zoIR200wEOHl2PxnKr9a4okUfp/OUidcTHIg
         hSDtzxxnyoj/DrqEVFjwc1KSkx+/yGbxwlAFDN+IuyAyh6aeHQ6Nrhl3egJVe6wtbt1I
         89YBWIEG6DSd/x4i40pkY8zyGB/iau5FnpHJaLzj9Tvj61TgFgoleoZHUTev2s1OsMe6
         GdtjS8xUqz826969EcOkNhiigkobLHaYwWQDBz2mH3lM76r40VKSOGw326pxx7t+0Obj
         SU7A==
X-Forwarded-Encrypted: i=1; AJvYcCXYnXFCjI5wLYoLhNVhJ+aIuOMkQIB/mEVdgER4uzHdyiAOnrwtOuwOlvKjXOQgamwqcLFGv/Efnms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyorBK1y4UFsa8z6E3nd8ry3QkutJW6WYHJe8T2D82d+zesE5HN
	b/sDtKEYkbtRA+qLj7vSwmf5KWZsWh4bFPzXXkUc/uOcL8GVbs666dAlD0MQl0GqWqL/Vhslj9+
	drb1CEWcj9pGIUABv4aErnwgFagz7lM1cFsGvbJHGgA==
X-Gm-Gg: ASbGncu02D84pK+TYYhG/IWtMNs7psl/OEE/ufocxj3bFEPUGkSsy7gAVAmOC1UynM5
	r4uNVo1bjyjKgKFTDNOzwp8OUP4eBz/BXdGucAqICaDaVj8tdv+FR6kq2Rg9A65snhgVjC4egBt
	cAX2ulB7/7l/97rhEU2T/wOO3PDfhhgHlUHEYS+pggZCcjxyVoOEWcp5W/CpuVKsqq3KMffU3IJ
	0ANCDKMaWQO2ZsBUxow3yTEV/jN5Hh+c6VA5tMbsIWO9xIc5EwvI/bq6Q==
X-Google-Smtp-Source: AGHT+IHuAFVKekWd1XIceTepFQM+2KcFkyr0+Jt/14Gjj3YjuSVXCqO15zGETNvx22Zso3bXtPLN06bMXeUC9RPF4AI=
X-Received: by 2002:a05:6402:1450:b0:640:ee09:bfc1 with SMTP id
 4fb4d7f45d1cf-6431a57e0ecmr566813a12.37.1762894696728; Tue, 11 Nov 2025
 12:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRHiCxoJnEGmj17q@kernel.org>
 <CA+CK2bCHhbBtSJCx38gxjfR6DM1PjcfsOTD-Pqzqyez1_hXJ7Q@mail.gmail.com> <aROZi043lxtegqWE@kernel.org>
In-Reply-To: <aROZi043lxtegqWE@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 11 Nov 2025 15:57:39 -0500
X-Gm-Features: AWmQ_bkvWgSaihTKA4ZFuehWCb49R8fZ8C14CFTHsoW2qubcK_JcQqaA8FvRRnI
Message-ID: <CA+CK2bAsrEqpt9d3s0KXpjcO9WPTJjymdwtiiyWVS6uq5KKNgA@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
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
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
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

Hi Mike,

Thank you for review, my comments below:

> > This is why this call is placed first in reboot(), before any
> > irreversible reboot notifiers or shutdown callbacks are performed. If
> > an allocation problem occurs in KHO, the error is simply reported back
> > to userspace, and the live update update is safely aborted.
>
> This is fine. But what I don't like is that we can't use kho without
> liveupdate. We are making debugfs optional, we have a way to call

Yes you can: you can disable liveupdate (i.e. not supply liveupdate=1
via kernel parameter) and use KHO the old way: drive it from the
userspace. However, if liveupdate is enabled, liveupdate becomes the
driver of KHO as unfortunately KHO has these weird states at the
moment.

> kho_finalize() on the reboot path and it does not seem an issue to do it
> even without liveupdate. But then we force kho_finalize() into
> liveupdate_reboot() allowing weird configurations where kho is there but
> it's unusable.

What do you mean KHO is there but unusable, we should not have such a state...

> What I'd like to see is that we can finalize KHO on kexec reboot path even
> when liveupdate is not compiled and until then the patch that makes KHO
> debugfs optional should not go further IMO.
>
> Another thing I didn't check in this series yet is how finalization driven
> from debugfs interacts with liveupdate internal handling?

I think what we can do is the following:
- Remove "Kconfig: make debugfs optional" from this series, and
instead make that change as part of stateless KHO work.
- This will ensure that when liveupdate=0 always KHO finalize is fully
support the old way.
- When liveupdate=1 always disable KHO debugfs "finalize" API, and
allow liveupdate to drive it automatically. It would add another
liveupdate_enable() check to KHO, and is going to be removed as part
of stateless KHO work.

Pasha

