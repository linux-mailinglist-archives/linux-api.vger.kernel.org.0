Return-Path: <linux-api+bounces-3869-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B124ACDD5B
	for <lists+linux-api@lfdr.de>; Wed,  4 Jun 2025 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00608178393
	for <lists+linux-api@lfdr.de>; Wed,  4 Jun 2025 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EACC22A1FA;
	Wed,  4 Jun 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="FhEX+H60"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701A1A5BBD
	for <linux-api@vger.kernel.org>; Wed,  4 Jun 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749038423; cv=none; b=PX2kpZdWw8/iaU8P+yhOhuDgvXDNO+yoKOqEHgGorIPlkMPDKAvmYo0FCG/GRbGp1ZR9sn3WcWquVkjlo1RvK9CYMfvARZgjBDo5ALFXTnWcjS7ug037xQZq14dof2iJcYn8z0B8UcngS1YDCmn54qi0PZbgjDnz/8GJV7No/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749038423; c=relaxed/simple;
	bh=zVY9XzhhWcHzqUqNnnyNii3ba4FGUocj04/QVzLzR3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euhoPA8hGHpdBNzWrrlvDeljPwjWDId+5g1zuaBumNwKKRlGYJ5QWnvXfIVEij9wukT3KlLYesrnvZHac86nAOuSiDsOPovTiNrLYndCy1rqX9xfuaWQ244iu3+Il0ytMSk/DzudnX1/GGv0Tac9t/yNjJOdQ685JYEuSu1Xs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=FhEX+H60; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d7b50815so28467225e9.2
        for <linux-api@vger.kernel.org>; Wed, 04 Jun 2025 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1749038419; x=1749643219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+nqsQ82kt+Zea8zn/pb02YPbww1gbCosRGb705bohss=;
        b=FhEX+H60z8jWIs2AbbU6bw8uIkILhdOwG1gFlrg1+OnmO3NXv4zOuK0bnhW2GwJoHC
         +REFawsff3Ve3aOavihdXmVVF/ioSL61U6pARlJfb8t8VbVzeKdmRMjOuRnTu90Qw22q
         zplpJOGhpSlDCHZNpG2Imj1HXecpvqzScqeABpxli+KhDUM81F87ppbiSbBrHaS2dfU1
         jkKpRFre9M95/0t4Z/3qsrFn/ZmCp0oK3DaZpSx5Z8D1ee5un+utuVSY8wEUeh/cr+gY
         3td7k+9+nxIiBMyQQvbgMO9GJJTDx7AUSlxtwr847qAjpDyHxzbyV3X9edEB+AXN44Ho
         8wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749038419; x=1749643219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nqsQ82kt+Zea8zn/pb02YPbww1gbCosRGb705bohss=;
        b=YAeub6btq8/+LGOxINDYfly1SxelrqxRuSVbP4yRhlaOdVwNIW9T2/sGwcnZZm/Nuj
         URunhdJ1nD1KdJhaSZy6K55mNszQg7DJGxZMjNosEswMoBMftqIIcWxKNNjaiJ1PQWdf
         53f8HLm1r/eCymFqLVTzKUhQk5esqZu33/QVOSgVmnL+vRgEqFcJCaEabXCIYuhVvDx6
         t3QFWUfwK4oFJYmjI3eLP+NMAj0iQtuPrwcXCvq+LwizewNjORC8YNhEjSwdF53TYUCK
         FWS46P5Vs7ysT8DqBBC0vL9Cp7Pj36YYBMXkH4oT14t5VlQYefIzqopnDUMlr7trrlPM
         HVQA==
X-Forwarded-Encrypted: i=1; AJvYcCUlRmcHtbWoI0mR43B2IEP4oX6qeR2+rjLbyHSlQPDiH5xr1Dmko/kx81J1VXhAIF2gQM6maJni5WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPKf+jdGuHOlq296LW5SKB9D7Vs9Xrg37k3+Js6boBXAwP7Lt
	hu55SHuy0yYaUBRVbtfxUt3ddsKrCSTwxJeRH7DVIT2a/KiPj/oG4xWCkkdQ4FV6stg=
X-Gm-Gg: ASbGncsALckwAr4A8SdWHyIVuH5mSafvJEktBuL2Qon414zE/GgwH0yefY/+gnReREp
	bicBvJsTkr75dzzuup9MhKUutWH1rtBgalsX8RP36cr9BZmbuEWNdV8Kg0+JlkDrK9bAlqSkmDz
	y6bk6mrbWRjqg9NZXZadEfLrOcu8AfGv2Ssq1qMliB7RkVo0jmE0pIr6TI9942RaGl5OA5wP/Bc
	pSiFYxrClnnaSih6uHC16vW80H4ChSFajqLWYxFezH1ERKNzDtUzKUNozwUKFMOCMVWFNV1O80J
	GAUW8/JqN6ZOMa/TBdquTHR+tVMNh4uhzgGHiSMaZT3lzUps
X-Google-Smtp-Source: AGHT+IEMm/wavbNrVrfyOME8tFK/mY4+K5X1c4/6nmOVfXnr2qJvVXbyJyEJqELmggltmokAdLxjpw==
X-Received: by 2002:a05:6000:178a:b0:3a5:1266:e9ce with SMTP id ffacd0b85a97d-3a51d96cfffmr2078263f8f.36.1749038418886;
        Wed, 04 Jun 2025 05:00:18 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:da11:6260:39d6:12c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d7f92585sm210408665e9.5.2025.06.04.05.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:00:17 -0700 (PDT)
Date: Wed, 4 Jun 2025 08:00:13 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <20250604120013.GA1431@cmpxchg.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
 <CAGsJ_4yKDqUu8yZjHSmWBz3CpQhU6DM0=EhibfTwHbTo+QWvZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yKDqUu8yZjHSmWBz3CpQhU6DM0=EhibfTwHbTo+QWvZA@mail.gmail.com>

On Fri, May 30, 2025 at 07:52:28PM +1200, Barry Song wrote:
> On Fri, May 30, 2025 at 9:14 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> > > Barry's problem is that we're all nervous about possibly regressing
> > > performance on some unknown workloads.  Just try Barry's proposal, see
> > > if anyone actually compains or if we're just afraid of our own shadows.
> >
> > I actually explained why I think this is a terrible idea. But okay, I
> > tried the patch anyway.
> >
> > This is 'git log' on a hot kernel repo after a large IO stream:
> >
> >                                      VANILLA                      BARRY
> > Real time                 49.93 (    +0.00%)         60.36 (   +20.48%)
> > User time                 32.10 (    +0.00%)         32.09 (    -0.04%)
> > System time               14.41 (    +0.00%)         14.64 (    +1.50%)
> > pgmajfault              9227.00 (    +0.00%)      18390.00 (   +99.30%)
> > workingset_refault_file  184.00 (    +0.00%)    236899.00 (+127954.05%)
> >
> > Clearly we can't generally ignore page cache hits just because the
> > mmaps() are intermittent.
> 
> Hi Johannes,
> Thanks!
> 
> Are you on v1, which lacks folio demotion[1], or v2, which includes it [2]?
> 
> [1] https://lore.kernel.org/linux-mm/20250412085852.48524-1-21cnbao@gmail.com/
> [2] https://lore.kernel.org/linux-mm/20250514070820.51793-1-21cnbao@gmail.com/

The subthread is about whether the reference dismissal / demotion
should be unconditional (v1) or opt-in (v2).

I'm arguing for v2.

