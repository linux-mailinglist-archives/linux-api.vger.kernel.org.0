Return-Path: <linux-api+bounces-5330-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B0C65B2C
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 19:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19C2E4E25EC
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A9630AD00;
	Mon, 17 Nov 2025 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S5uKRssT"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B22D876F
	for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403869; cv=none; b=D9jZ8rLScqpVWnRplBPcakTwr8cYfK+4lFc4EeRm1zayKWVXplwP9IzCiYcm+/+iWfXitim95F5DpLqazk01jydBAroAfVheJazf+slIse/IqAI+8R4PrhQC/4G4kxKfUUs8FOnNdqnUABnIRN9OX2xEMU1Cyb6nRqFOWcnvUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403869; c=relaxed/simple;
	bh=DSVaYS00Ppz/lXA0EJ/lwtUlZcIIPkWYwoyJByW18bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiBkcZ3cB0df+vfaU19MvclCo5IeLYePcX7Nnn9m6huD7k+N6yH/gQBJ2OOFwp8cOGrhjuNXWIgZlNk2YL6BvOlVAccRaEs2iL8JqVzZ+9JR4zKsNE0xN0cxHzt7LF/O4ja6hnU8cmHgJKJnohGRoo/FMQ+SaO7CxtlNdFtpyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=S5uKRssT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so7722531a12.3
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763403866; x=1764008666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DSVaYS00Ppz/lXA0EJ/lwtUlZcIIPkWYwoyJByW18bU=;
        b=S5uKRssTjIvfjfTMkVJXvTmWkmBSbpslh9JXGqpBo16LqUCrWfQi2LrOCaDmpZt+F3
         xiFyMPECkusxkEfJWMDqwwcy2gq7Z/UpbMbJIT1nCESE8RV2Mpy9DFugrSmxi36GetDE
         9KxFbApN5ER1PvMLaCxKEeLoOL+sER9gW99arb/ujgI/bPL1xcDMuEikfssfim6MIGS7
         o9VkifnnMbeFiwkVPMa+YjQ6LParO/uVXgGmxTtSQC9sbhhjCfhboPuZ/p3ZafvcXdNn
         My4ZY6zl8rvcq//PL0JLyB3T/pcsCNFcL9+hWlibU8Eiwb8sp4vVNj9NouR0ujak2guu
         lNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403866; x=1764008666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSVaYS00Ppz/lXA0EJ/lwtUlZcIIPkWYwoyJByW18bU=;
        b=cV5jQ7feSuGcGEijGkm2gNzwWSawpB10P/QSB8wwkDjoIe9MtFnB1URdsNbPqL23CI
         AcB79ieODO19Uf9HfpYjBtJv1AK89WZ/8C3GE34PAVBQ2+V5UbNjFZJfa2Lnr7BvtnMH
         oDNXu7NR/pxBzyjthzk45vab7ltq8SNNLKxtNqOTGgDcIUtrjlcX2Yh+ViKzJTWqG0dy
         pm0E6PmDOm9CAAX6aq8SWb7HQ2XRJbFqjb8GTlGaA4NtuPXquhw03U0BgBoNskSyRsCk
         rhe9p/T3H/kpVPAok8vLvLNgSgXI+mBcCgODIbHY3ikLIBPtdQywdtP2Cmmoklp53UET
         s/rA==
X-Forwarded-Encrypted: i=1; AJvYcCXXAhEDI47WZL62QhIHhq/MPITr+Mr9y5VDl1w8O0cefO7HJU/szGOhx+43l4wlnm9DSZ/ieMamoCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzncWxm55gALbIGG2FpOiocFeKDoSjLh4Uwhkb4HsgpD/TycRH6
	eMCztYmroELjhlh/e7euFAaBnb2Xf7sTq74/QyfFABaWCfzek9foBnAKcB0YYJHb0UNSIIWr13U
	b7WAe+MgU4koYYGfkuZgY+FxVrTY3iD19daoON6/PwQ==
X-Gm-Gg: ASbGnctE1eVfwoyHULSfHQec1D0B5myZc30SoDCn/jXKUzFXliQKTeJFHKOiGnYKzg6
	5ALLztG7LELTNu2TR6xpThbko0cybGtRDT2CPe+zEWzJdjQ5EaJC/exCL5qcEbeQBZ9vOugmG78
	J2l/9bHeuiPyY2EI+ajWsaGxWXdkbkBbsKfWMQylLySfKCXmcKvEzYdmlHzvhI1nT11fzbynxmO
	S96busft/39LIbLKh0ztoD3KmHqJiQ7Bv2mqYubUqrQC6xXD5BNYBsGgP4g49ceDU0ZURnXf3YW
	Utg=
X-Google-Smtp-Source: AGHT+IEEWqHLyN23GdmGqxp16gOz0H99ycEtpAQL2MFddiKttxJOs0DiTjbKI+yQFgL9TB9EokEIYjSn2RJfB01X0+U=
X-Received: by 2002:a05:6402:2806:b0:643:60b6:3eed with SMTP id
 4fb4d7f45d1cf-64360b63f56mr10022358a12.31.1763403866324; Mon, 17 Nov 2025
 10:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-19-pasha.tatashin@soleen.com> <c8b46600-d40f-41b4-a5a3-99300ef1a2eb@linux.dev>
In-Reply-To: <c8b46600-d40f-41b4-a5a3-99300ef1a2eb@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:23:49 -0500
X-Gm-Features: AWmQ_bmhggvke7xISGqUn7uC4niyXxh61OdHqC9kU_cJS8AOY1qqJ3NjJ9HlQrw
Message-ID: <CA+CK2bCUG4BVqPJYL5nxC-Uvomx2JT=sE4DrhqFjrBf+zN_m3A@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] selftests/liveupdate: Add kexec-based selftest
 for session lifecycle
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
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

> Thanks a lot. Just with kernel image, it is not enough to boot the host.
> Adding initramfs will avoid the crash when the host boots.
> I have made tests to verify this.
>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thank you!

