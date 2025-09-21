Return-Path: <linux-api+bounces-4903-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E0B8E8A4
	for <lists+linux-api@lfdr.de>; Mon, 22 Sep 2025 00:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4773A6862
	for <lists+linux-api@lfdr.de>; Sun, 21 Sep 2025 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3F274666;
	Sun, 21 Sep 2025 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PYp+qLmQ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3C25A642
	for <linux-api@vger.kernel.org>; Sun, 21 Sep 2025 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758493289; cv=none; b=LLlIuBqNpLiBfQ9w8Y0tWkvnmUygoq8X8kOQmJ6erPAC9G4WowDp+VPDFqC7OSibCxFDXec9te9tLcuo24aIrKlwZlWLc4d/JduwMUmkSZy7LBDcM1XX3GwQWETULzFKXY9Rb8JbCTsb6tooEGV4+Jc+DA22QuTawieEWycNGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758493289; c=relaxed/simple;
	bh=6oei0aWXFhVRzFAC+ZsItJg6xnA+dZu9f+eLcagd27c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxUsQ5ORQJ06rKJI79Xqx21dKfdRTR/LNbGnoyRLUY5/BAOncMunJ3zJqcQLCGR4CazinKSkU3mgR/zmMDszzeMVjYN9QwiLtdymsIxq/ykQLxRtlPaCQgTQK7KLKP+l6ky4SexRQMP/zDivgOIICx0Zeg7hwfdZULapwOAP8Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PYp+qLmQ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b3d3f6360cso37567891cf.0
        for <linux-api@vger.kernel.org>; Sun, 21 Sep 2025 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758493287; x=1759098087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHLyAWNRRvZ698aiszn9fxUOIJUP3t6BL2WpPwYPRag=;
        b=PYp+qLmQxDpcmaKJAmXMNT4GUpKlnhY6sJMKA98L5JO9raId4BOtZqe4WvAc8WA1zg
         tPLT7hLlrHPZWi7qcn9VILdX7yuKmgioYSnnb6UVNzkerEruUta/TsokQD6GY3314ZLk
         PpFK6/80wRa8dfWftRO3ku1Ayr/N3gSR1QeuLFUNLW0QEChYKfSRh4UDtSAy10HGjtFx
         8U15lT76FdDnIJqfvDxXx+5aBa/a2jzoc8JBxh6ggMbtcG3XqkYEGyRbJPYeEXA9ae9d
         mW9rrKbYxoZ2k9LtHic6v7oeBw3FTSwXE8PjL8G/hukziGsKDx+P5tU46dvcVEIuNl1J
         bDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758493287; x=1759098087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHLyAWNRRvZ698aiszn9fxUOIJUP3t6BL2WpPwYPRag=;
        b=ah3Ob+yIqd3CqbCdabR+gM+x53Cn0wTSVAqgVhN4BM2HNPajCH9qO9X+dEFPclEIXv
         M2f6Xwgb+mWlaoc77F3YRIFpaBqYEM65zWKCCMeaKd71wXFMD9nVJzgmJLU0UyumoEDz
         saLH4EyF9pnx66b7p/F2v7NB8tyekoAQe2QLzb58OfclyKv36iYgz+Ox24uSCMdrw+wO
         4pVgFNhP2XkJ337dpHYZEQEPcpBFDqV3it4Uxc3xxupami78Guw9FT23XhHLFRF3Hyn4
         3M3DhRUbRFuT6PvVpswJmDwjRhPIQxa9XChjR/esPqmkumRzuquO51ccVLgudwM2GeJE
         ZH4A==
X-Forwarded-Encrypted: i=1; AJvYcCXg/b2bkLlAmGz7Ckbz1gmc/KcJUv3BA0LuWTSQR0lYcpiuoCpZJdzINHIafFTycaoW+ZsDyaFN8Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDC4vlWOZ4GOZG53VOpJ+tOpyKoUlRTu1N8/OsSk66iFabq+za
	nZBh6vs7HTMT9tcTikMf25Pot8a7yJDDI3KMwRwjSLdk/cQ+6HqrZDUEyJAgOpS+Xe6nlDSvWzT
	IvY+B8XZWsm9NjvqTGEHvREMz3qyXNBDVReY02hoDvQ==
X-Gm-Gg: ASbGncuEwbCt7t5lY8FySNkMI54IFC9k8KfwBnIOebk1dLuFPB+6LJXlT0ijzY4oU1E
	GtxS5U6SWK0zV86e0KFcSrBU+oBjl/tB4JJ5SayBY8e4hWSu1XDJie1JpwcOgM8JTFjQkRKiRWn
	LSBkqk9FPg/XWMqfvjjg6q9q4de2hava1Ky3s/4OPQWUoldUBk4Zlh81gf4TjKn3pmmBS3lLlGI
	6rznoY=
X-Google-Smtp-Source: AGHT+IF9Bd/LCK7h6/iC83qqAy9wLiFHaZDvz7ruwA4mtaZ7EwXHPx8srwbwmVkArl3yVoSLBLTkv5dGYhCDZ5ZrJps=
X-Received: by 2002:a05:622a:4c06:b0:4ca:10bd:bae5 with SMTP id
 d75a77b69052e-4ca10bdc5dfmr21648151cf.81.1758493287147; Sun, 21 Sep 2025
 15:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-8-pasha.tatashin@soleen.com> <20250814132233.GB802098@nvidia.com>
 <aJ756q-wWJV37fMm@kernel.org> <20250818135509.GK802098@nvidia.com>
In-Reply-To: <20250818135509.GK802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 21 Sep 2025 18:20:50 -0400
X-Gm-Features: AS18NWCcd-5oq0uHFf03h4LWbprCKHRBHh45SwiCRQil-ZYQKwKcHW5Zv6e3HKA
Message-ID: <CA+CK2bDc+-R=EuGM2pU=Phq8Ui-8xsDm0ppH6yjNR0U_o4TMHg@mail.gmail.com>
Subject: Re: [PATCH v3 07/30] kho: add interfaces to unpreserve folios and
 physical memory ranges
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, dmatlack@google.com, 
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

On Mon, Aug 18, 2025 at 9:55=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Aug 15, 2025 at 12:12:10PM +0300, Mike Rapoport wrote:
> > > Which is perhaps another comment, if this __get_free_pages() is going
> > > to be a common pattern (and I guess it will be) then the API should b=
e
> > > streamlined alot more:
> > >
> > >  void *kho_alloc_preserved_memory(gfp, size);
> > >  void kho_free_preserved_memory(void *);
> >
> > This looks backwards to me. KHO should not deal with memory allocation,
> > it's responsibility to preserve/restore memory objects it supports.
>
> Then maybe those are luo_ helpers
>
> But having users open code __get_free_pages() and convert to/from
> struct page, phys, etc is not a great idea.

I added:

void *luo_contig_alloc_preserve(size_t size);
void luo_contig_free_unpreserve(void *mem, size_t size);

Allocate contiguous, zeroed, and preserved memory.

Pasha

