Return-Path: <linux-api+bounces-5334-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC8EC65C58
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 19:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 741FA293A0
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1ED2D480F;
	Mon, 17 Nov 2025 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UEYm5eQH"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A24314B90
	for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405165; cv=none; b=qJh0VwqJPpi4q3HUAR/AqV5TOUvbmcGDX/hyLVU9tUtE/F40fgpXR5geRTqPSTuvWKhiXTMQXRQdN2DjBiFv6kwXX/5GbqNzpSKX9OgYu16MY4A25xwNbArOKRo8LV3JhHC+3CLp3PcdOEDjjCkREZfkubedvHK7IDqFzi8WU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405165; c=relaxed/simple;
	bh=9L0PWDNFpIwYA9Tdoy4gSq9mMo+JaoLTYqKodPhceek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkTNpTOYYJuSLAOv7Aa/xyjIqWwt0rjxHkz5SkZo3VBDKQheHvp2vvUnep6u/6FL9U+PUO8LY6jEvAgL1pIwUKLof1HjwVf3guUurhghGjLZJRDoV2VcmgYiB3I6mGtg49fUggmu9Y3cxo8HXYdQ9lcLXp+3ci+fkpU3afAQI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UEYm5eQH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so8181725a12.3
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 10:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763405162; x=1764009962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9L0PWDNFpIwYA9Tdoy4gSq9mMo+JaoLTYqKodPhceek=;
        b=UEYm5eQH/ZaHFTniJ/bWeAQjEfOaBtxfEXk1TCtKFVN9k23U2kyh+2CZwX8yhe0Qb3
         rFFtXAJw2fNQt37zw/8uOu74ndcqA5jmCtAY3gquwM6NVFjweAQ2fokorELyBSt3RwXo
         Ytoqf6RjHhAJzZmnSVW9rQL2AsDCo0qfJ2h/WHd443/i/I849h+SJZdF+f0S11tw1le3
         uQeNNR+R9MK6J5lEYRiEXYVT/hhSXe855am6ZUvsN+1RL4tOtn3a4X4oDb/NSshwHIb7
         6VwlEyN6+mGDu5CW/HA6Zy4NEhgpHbYrhHZJC0a5EhHGz78svG58AN8PgLwJXyagetgL
         qwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763405162; x=1764009962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L0PWDNFpIwYA9Tdoy4gSq9mMo+JaoLTYqKodPhceek=;
        b=syoEV+g1EXskqU9FMUoe76SOsJsuMoLCO+DnlJL4RUnpFIzQbBG5yx9e1WUXV9DB+E
         HU6MlQWKx+Q7cBdA2E6DMtJ6J8R49nhPNP3aQw9DfkWTqaOKsRegCL4QnRvu14B56UPu
         ssChKFieVHnfdDynYkW/iM8DzofRZ/b+4HmWtrwxUlgAJUtJT8szyqzd0tATEpFYtj0n
         RuQy9lu/wnmbgA0KKmtxOjUvFhGiQZJGkkz991os29yFqIQHOBpqRFxJMPyHCupjXKEX
         mHMuYDw32W51+yr4E1UzFC6kc9K2bEyMetrqfnADveTUJsX1cqLEmNiV/wFBrX7/NnfY
         ngzg==
X-Forwarded-Encrypted: i=1; AJvYcCXCpPZt2C6Z6TYQG8A/ZF+eW4+Iv62LpJSuLDgXNRfoOz4yFo1x2zHlky8RdATwyLNXvumrbtyjsTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSHMnm7JStP1oMGwtDbA+5be0Vq0KZJlh1Z69tOHWr5rmORbT
	u8BvuOwOdBWnE2HHfyKNhjYxwOwKvW/kO/ulkPUl8AWR/HGVPwwBux3+roBNcnbI3heGe+jn5c3
	1yvlHBD4KtksfAKN2H6Kslz/YxCGT1S6EKJ1ugB4VZA==
X-Gm-Gg: ASbGnctQiak76/wDsNzaEaijMhZEteb42xD5B1lbeKQzjWdWIhZoEKKcjuRa6mXodtO
	CdA+tsa0wOHvtmRLAh1jcH/vLxkoBs/R+EWqrOfgPZqRpA9qMtzTLHzDmWBaqjNrnU1gSNuQAvO
	HkLUCylATn+WVildXfXbmW0S+pZuPoJTFKwq8i+ektffZ71ILFu5uJtGYKRxPrZDXWQBD0CUD/M
	J5ayzQjS8TmfCCXkYJxkR5/lxqEX6kMqA4f5KzDwYMwo5GVJULYFzhTPlCxFM0wWfLmEQsEkfla
	AAI=
X-Google-Smtp-Source: AGHT+IHTS9jPR539K9D88biPeBpW9OArAzo2mtlZDaqK9aFcfZt0G8LfWzYGUIJ/Wa0xrvoSHRJmq2qQHBOC/QtRtDw=
X-Received: by 2002:a05:6402:50cf:b0:640:c9ff:c06a with SMTP id
 4fb4d7f45d1cf-64350e1e3c6mr13108669a12.15.1763405162259; Mon, 17 Nov 2025
 10:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-15-pasha.tatashin@soleen.com> <aRr13Q1xk9eunilo@kernel.org>
In-Reply-To: <aRr13Q1xk9eunilo@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:45:24 -0500
X-Gm-Features: AWmQ_bmw4ppe8XlI-hroPbUkA515iug7-539nPCKhJSWJUeaHTdUDKi6DO6pH6k
Message-ID: <CA+CK2bC2_r4Nbjh0CuJwcMeGxpctSZMTodG8Cf=zoue6zj-gyw@mail.gmail.com>
Subject: Re: [PATCH v6 14/20] liveupdate: luo_file: add private argument to
 store runtime state
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

> > Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> > Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you!

Pasha

