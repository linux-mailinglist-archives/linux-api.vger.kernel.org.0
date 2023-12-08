Return-Path: <linux-api+bounces-305-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE180AC29
	for <lists+linux-api@lfdr.de>; Fri,  8 Dec 2023 19:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA5E1C20B9C
	for <lists+linux-api@lfdr.de>; Fri,  8 Dec 2023 18:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7CA31A92;
	Fri,  8 Dec 2023 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eNU1EAx2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0040B118
	for <linux-api@vger.kernel.org>; Fri,  8 Dec 2023 10:38:08 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5be30d543c4so1864911a12.2
        for <linux-api@vger.kernel.org>; Fri, 08 Dec 2023 10:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702060688; x=1702665488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtN8RJrSywNd9cqTGDXuX00rE8787z779s5kNZbKPTg=;
        b=eNU1EAx2H0cVhDiB2lfoDQan7fEfMz5udTwfcMi9THoBeXBj746nTvWMWjNVPI/oae
         7u+kXee+wGaH5DFIw6qBonTMD7k84kKyGR+guCa69j7SvDmbG4aK+5dbRq51nuD/XUdv
         QUFMyM/mvvGSEpHl888CNEbL3R2m1SDSlUWCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060688; x=1702665488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtN8RJrSywNd9cqTGDXuX00rE8787z779s5kNZbKPTg=;
        b=KqfcOrXSglNuHjUAr3OHY7MjKsKdtL7bAuMvvQqGDjQlh9uTsFQ04JKmuXVJUZp1Bn
         +uUoZEh88kednUA53ofufCOYmy+K7M8Y32o1GJ4EAS9S10J0lA0vWf0IxFPvU5AU+pdL
         Aa0LYcX1wPxejVguvFzKmh/itKCDMExkPaYP+Otwzyz8qmIRqi+m4YHgi6teCBnzPYcO
         vbwW8v6ZhZceNUqpzYKeTH1JwfE92ChHGw474Cjekl2/diaWW53Jc44kxlPJeqQaHVAl
         mfngx5NOvYfJ9MbeXR1EB375r+ywXi02oscX7oFvuXYuCQYcDdXmxyxLl0KOjsPrxOBl
         /J3w==
X-Gm-Message-State: AOJu0YyuTKUxIXD8CNc8D/2ALlvBxKPj4wcPqY6+y+A3kf2V/YAedyG6
	/omF1lECV5kkkvqv7PH/zdF1Jw==
X-Google-Smtp-Source: AGHT+IHJzNo7Hbj+hV0vS5OXcDWV8L1dA0GJLnVKpqyuVHtDw1XXI/AWkfGTwQ2ZZjG7MnXsry4Z7g==
X-Received: by 2002:a05:6a20:918b:b0:18f:97c:823b with SMTP id v11-20020a056a20918b00b0018f097c823bmr529965pzd.69.1702060688480;
        Fri, 08 Dec 2023 10:38:08 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o73-20020a62cd4c000000b006c875abecbcsm1966803pfg.121.2023.12.08.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:38:07 -0800 (PST)
Date: Fri, 8 Dec 2023 10:38:07 -0800
From: Kees Cook <keescook@chromium.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <202312081037.895E558@keescook>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <202312061236.DE847C52AA@keescook>
 <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
 <202312081027.BA44B7B3@keescook>
 <87lea4czki.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lea4czki.fsf@oldenburg.str.redhat.com>

On Fri, Dec 08, 2023 at 07:35:25PM +0100, Florian Weimer wrote:
> * Kees Cook:
> 
> > I significantly prefer APIs not being arch-specific, so I'd prefer we
> > always include AT_PAGE_SHIFT_MASK. For an architecture that doesn't
> > define its own ARCH_AT_PAGE_SHIFT_MASK, it's not _inaccurate_ to report
> > 1 << PAGE_SHIFT, but it might be incomplete.
> 
> The downside is that as an application programmer, I have to go and
> chase for the information the legacy way if I encounter
> getauxval(AT_PAGE_SHIFT_MASK) == getpagesize() for a longer time
> because the interface does not signal the absence of any extended
> page sizes.

Are there architectures besides x86 where AT_PAGE_SHIFT_MASK isn't a
single bit? If so, let's get them added now along with x86.

-- 
Kees Cook

