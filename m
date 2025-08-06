Return-Path: <linux-api+bounces-4332-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90411B1CD55
	for <lists+linux-api@lfdr.de>; Wed,  6 Aug 2025 22:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1316518C6302
	for <lists+linux-api@lfdr.de>; Wed,  6 Aug 2025 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623342BE7BE;
	Wed,  6 Aug 2025 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BV3X5JA3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6212BE04A
	for <linux-api@vger.kernel.org>; Wed,  6 Aug 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511298; cv=none; b=W6jO3BgSpJSoRGv1EhlkcyRvZapA2VkTw5lAvtlfRMwVi5i6SHlT8K7MqZA8pSrAtBfrM0lUnbj2PXZWSoR/hG8FFYG4MrQt/K818ChBsUGzDkD3npC+CFBgdXC64YvwjAyGsWF/JBz5lBn6b6K1O6dgOyDryfFuIwEwZcb/6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511298; c=relaxed/simple;
	bh=ZDHpr0+0p20pkDv2mu3Q9yjs57G8bc2Ou1cKrq4mu+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJieHw+7DrfIpuBPRSIxfzx7Qz5ySLMNaJwWbkAQfE1AyFoQ6p9kzShi3OPZaOMYjdrwCryxeMAi2y/OEcPD2fQ9rmadYUL13bqIJbjU/LB98ls3n1JisoGAlHtpYloC+IqTKKL8/1KKq0bwR5zYvPMmf+IjsBbJPTIdhkZm4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BV3X5JA3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b0862d2deaso3215791cf.2
        for <linux-api@vger.kernel.org>; Wed, 06 Aug 2025 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754511295; x=1755116095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDHpr0+0p20pkDv2mu3Q9yjs57G8bc2Ou1cKrq4mu+Q=;
        b=BV3X5JA3dDtbNQxiVnQw1uFN7WwqabrDUNcPeXHfZTHPHAKlHLXxGurjs1DLjmkV93
         tqtLsb8ysYSzBROuOkhmBA/pSY9zwqItwnNaokyLJ+vR+7TXgpz+a8MqzJg+L1P3zczN
         iIVU6OLx92d7v4s+AIEkuX+w79g2pZngaOplGIO71IDwwBANVyaRPgsrpqHXvrHJazT0
         vHSjr5bBkdrHp9SAyiv//bzm5cimoAuNFdmKpPOJNbJ2kZJt4gOvIslC63fhB1G7HrXA
         rTlc1MAA4NRLDHaxa5sX48Jjz5Bsf3p9laLIxUB9aUHYxymqFwyFzRGvyuwPWLJIt1iO
         VF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511295; x=1755116095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDHpr0+0p20pkDv2mu3Q9yjs57G8bc2Ou1cKrq4mu+Q=;
        b=cOQ+QZWKuqhQAz5Zl4t2WzSoX6tX58NLlym9ABJIFmfEWkz/dJ9DA0Zc87Md5IqdXS
         5Dw+ZodE32+a6ODLLG4NYiYvPxkae+e5jnAyw1JannMDO/xbACDqJpHNj5dTwKw0nVQw
         mSxQjbrNoiNypeNZzXcUlJ1cHTQx8H3O/6xYLcJKY8FFhteZcGnUtfnW8/SeEGeOruPx
         MmoQTEHcIz80u3b7DWYxHgcfR3onzdJLbevpfvk9II5wk72ocBnuzsAbfnFTXYv0Zckq
         Drii1Iko77QSMNhDfyffh8bPYCFb+IzSIFu9ww+WNhepKdzL4HY25OuZa7aR02seyJHb
         L40A==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZmpcX+hf9wB5GjwGpF77ucPZZnnRQi0SukVxYFvZ1zMNWrd6ghn8jv+VZYrF6jtOz2GgwVpQjIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KPFCv8t6qJUDdvSXxQFjkcGB2lW9/cL1T/xlFvegB2Dj7Alk
	+mMtvQfoJusrf4j2WKS+jtqyR41NBr/RB8mzQESlV00i4k4i2YwsMuorapSv14zmDVDK+9S4HLl
	YVh/WO1ck5EOxA2GzUQ9BPB2c1vqSB5lJ8sYHN/y0PA==
X-Gm-Gg: ASbGnct3zpS/dTLtcZW7HixjDuuQzVYQXdbgKu2TSQTpCiVYVghAOedEBiuolrtkYG7
	ekinRSimWdX5dC13xkUfdfGlaXuUl4vu5wWulgK0goklwD+tRb/PIY1QYcJR433FHo3nRtOvia6
	Bj3UHikXwWgv2fO84A5I9LCWV6cF8alGAgVQahky2T85FT9CoWeKcpVhtB2mI0XKPdgyE4HqokJ
	dwL
X-Google-Smtp-Source: AGHT+IG1pTZIp3NhezI/eRT45NKH+mtzWFGAo+1iZoAphp7Sfj8eCIzIiMWt+Cx51Yqtbvyg1UAKQ14ylzy/wQGMu4A=
X-Received: by 2002:a05:622a:3cb:b0:4b0:7950:8cdb with SMTP id
 d75a77b69052e-4b09267f8cdmr58173331cf.31.1754511295380; Wed, 06 Aug 2025
 13:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-32-pasha.tatashin@soleen.com> <20250729161450.GM36037@nvidia.com>
 <877bzqkc38.ffs@tglx> <20250729222157.GT36037@nvidia.com> <20250729183548.49d6c2dc@gandalf.local.home>
 <mafs07bzqeg3x.fsf@kernel.org> <CA+CK2bA=pmEtNWc5nN2hWcepq_+8HtbH2mTP2UUgabZ8ERaROw@mail.gmail.com>
 <mafs0ectod5eb.fsf@kernel.org>
In-Reply-To: <mafs0ectod5eb.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 6 Aug 2025 20:14:18 +0000
X-Gm-Features: Ac12FXzhqMjLum8cECX_x2Yzk_OzuXfSOe_mHCnoev6H-Zqbf5NvubJCxtWA6gg
Message-ID: <CA+CK2bCwe-9QzEbG60csWAWwKC+XMrv5=3DHOJFkBVLgkzTsEg@mail.gmail.com>
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Thomas Gleixner <tglx@linutronix.de>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> I didn't mean this for the memfd patches, only for libluo.

Makes, sense, memfd patches are going to be submitted together with
the rest of the series as PATCH, sorry for confusion.

Pasha

