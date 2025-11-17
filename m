Return-Path: <linux-api+bounces-5329-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE9C65B1B
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 19:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B116352750
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132B30DD25;
	Mon, 17 Nov 2025 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IpzOdkO/"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D83302756
	for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403648; cv=none; b=sdrIUpWkGWcG+1cL4TeZzdIJm1RugABipBP1vJ6qqzXVuAaPlDzPliN3EWShYnJL4h7aLCHA/jJ93IudTGEiP0Ek4YUqp8pnxSm9v4ZSF0NBbWK6W96bi4Zgjl51gNFCUwRqzVG8bIrrNV+Ahqp4BfFQq5gCPE7qccZvCL6r3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403648; c=relaxed/simple;
	bh=CZtsj+hifIsZJbKTfeb8TuUonR9rJOLyCJoinWAfVZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H91UGlq+Op+2sOsrYBNF3D+AHnETJicl2r3jbrkdPmcX2k6h0nYfJkWp2O1jbOTa3JIRvAGBmPWzHL2pVDwaX5rFk0QT62LN/RLS7n6GwCoIB5yB5jdQXaScDcWzFD0SeoDkk5SZAxM6L21vVtvGgz/zR9eMJ8CQvTRgxwcAVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=IpzOdkO/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so8214951a12.3
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763403645; x=1764008445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8uyJ9UgvBm8P+z5AaxjU/5GgC74k2Y8kBRaWb+wv/8=;
        b=IpzOdkO/TAphkuNLFQKOlMCFibMB7FXtwyELkClcZK/UQMitx5pYr6aLyTVD7HivrA
         yZ9TyaHfpn1tXwTDvcz9UE1jK6kILYxxIprO1UczbPyJAhZQF/Zw5wKmGg5uBjvB/0Ed
         wu9eUfc8dA9n4Sw2YarHZh4P0Mb7oNH+ULUozCRT/M4kNFBJulpSFaeq19eUR24SWdNA
         tU62ePkikquYMiUW0xcCZfA0igD2z5u5cAGVoxi5edaVuxaUPurQM1FlznHFZ98QCjaD
         olouksHmBWu3Fqn30s2sg1M/TWI9mLVwCrvGVuSL9o1TBhIuPeUTXIt8lrSAsnsOMwEv
         35KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403645; x=1764008445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8uyJ9UgvBm8P+z5AaxjU/5GgC74k2Y8kBRaWb+wv/8=;
        b=kecp5NdeFWlCTivFfDvAJ+g2rej/SMwwEYgqbY1J8tVo9pD1G6pKlq3jJVaVknYSf5
         osg36lOjfbM/jMoH5aRIvOUrpIarL+OIanPO1CxXogu4KI970UeyBN8rOW+kohZeN3xC
         lBBUqC9l6zRUQlHP+84qxtCVe98wswHL0h/Vlh0bObCspfmoV4AUHIsbi5sKRZVg/qYs
         NhEQVgT/iGJ7vAt379B6VfLZswXcMV66bnEGQNY6pYHyn5dCzE9lSAeVZqwlBq0vOimT
         gvFpUfpxG9AQdCuVCwz6tRJUMtVLok5s/Nk6a4AqYQ+J+aMLi0kWMybp41JS2XNYcMAC
         AC9g==
X-Forwarded-Encrypted: i=1; AJvYcCV0ZwJRTGGREokIluw/C0eq+xrj3/OhXrC0SkVdwDW2b91zPgC7r20f1zaktXACPjtoBbTRKoostuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYZL6T3MgKm0plDBAlVAThx3QpKDNoEdeW8qZ7moXBZKxlyHS
	jgW09C/jyIEb6dnm59i1BOp6ZyZB8NXHk2L+JnnOL7Qi5M3Z/nUCVy96uFaqKx6aEeB3uQvOQU3
	an1jDvKAswIMFzSsfezWAFoXH0QI2ugnV3cEsOrTEhQ==
X-Gm-Gg: ASbGncsGfleQpIAzBCEoPryb7XJhw+YCzHbad/01VDjd5AU7n3m43tZfd+Po11Ag8b6
	wZL97f8QCyGWhOmvzZcYhrTh3tC/MKK0g0cJPeEpXbPq3ibfAGwXUYHDNL5R+HIybaueE9ZLQTa
	nPFXIzhmVOy9At7W91W5ll2zINxMoHQ9yJDEMs98o4GWkI3QC/zCTt6fLlhb7Grz1uKemrWf/Yc
	cWkLCC8l+LfhX4OjwcU7zKsLFu/IlyK2w9BiMVT3y7X+NXdz/2b9JtEZgpeOMXTA8go
X-Google-Smtp-Source: AGHT+IGM1Tr15Cbgk4QQHnvYqnvMCGG164LW1Q1ssAN2iVzR9VtHS4h71YwFJlzXxkn+A9bvWz6u1Z5jGfTyNzSIJ9I=
X-Received: by 2002:a05:6402:50d1:b0:640:c807:6af8 with SMTP id
 4fb4d7f45d1cf-64350e9c5c3mr10832591a12.30.1763403644857; Mon, 17 Nov 2025
 10:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-11-pasha.tatashin@soleen.com> <aRrtmy--AWCEEbtg@kernel.org>
In-Reply-To: <aRrtmy--AWCEEbtg@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:20:07 -0500
X-Gm-Features: AWmQ_bngMkZtOLXtzvbIhDYg36rxAp3uf7c25ogdWq8dWGd7IJgw-yYh-gP9XSc
Message-ID: <CA+CK2bCVf2RppZbALAuFZyZarWukzhwkmOgtG2PcKqUQuao6uw@mail.gmail.com>
Subject: Re: [PATCH v6 10/20] MAINTAINERS: add liveupdate entry
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

On Mon, Nov 17, 2025 at 4:41=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 15, 2025 at 06:33:56PM -0500, Pasha Tatashin wrote:
> > Add a MAINTAINERS file entry for the new Live Update Orchestrator
> > introduced in previous patches.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  MAINTAINERS | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 500789529359..bc9f5c6f0e80 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14464,6 +14464,17 @@ F:   kernel/module/livepatch.c
> >  F:   samples/livepatch/
> >  F:   tools/testing/selftests/livepatch/
> >
> > +LIVE UPDATE
> > +M:   Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Please count me in :)
>

Sure, added.

> > +L:   linux-kernel@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/core-api/liveupdate.rst
> > +F:   Documentation/userspace-api/liveupdate.rst
> > +F:   include/linux/liveupdate.h
> > +F:   include/linux/liveupdate/
> > +F:   include/uapi/linux/liveupdate.h
> > +F:   kernel/liveupdate/
> > +
> >  LLC (802.2)
> >  L:   netdev@vger.kernel.org
> >  S:   Odd fixes
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
>
> --
> Sincerely yours,
> Mike.

