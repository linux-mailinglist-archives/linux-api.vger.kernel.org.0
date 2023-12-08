Return-Path: <linux-api+bounces-303-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E580AC0C
	for <lists+linux-api@lfdr.de>; Fri,  8 Dec 2023 19:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38001F21115
	for <lists+linux-api@lfdr.de>; Fri,  8 Dec 2023 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A1247A6A;
	Fri,  8 Dec 2023 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kHVnjikM"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B849BA
	for <linux-api@vger.kernel.org>; Fri,  8 Dec 2023 10:29:27 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ceda123d4fso837332b3a.2
        for <linux-api@vger.kernel.org>; Fri, 08 Dec 2023 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702060167; x=1702664967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYr+i/5NYC3JxHFPI2U93kF4hGY9T4auZhKGKiOPNQ0=;
        b=kHVnjikMJ8sBJkpxzMJH8TGeYPDCRNcWe0xMt9OuB/ulypTZPHYi+fTnQSgz1g6gVM
         7lfMOdf8ZmsFg0HVpyBjTxEGA9DWqzjsfwsfsdnk6r9rfmLGVtioc6Qkmubo7Rn2GB8y
         SuvlggiglrNgLjK7M047un0d4ZF00oX3FJh8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060167; x=1702664967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYr+i/5NYC3JxHFPI2U93kF4hGY9T4auZhKGKiOPNQ0=;
        b=sgNXVFnWAaLG05bU7p1XFm1rhDVGVaF2rz7UYrzS1MdX3786cE8cRawn6izCZ+N/QF
         ntADIT9RsrEBrF5JGl0D+seI6hz6LVVa2g+qXCPVDilZSBfxe08Ez1o2DJgVf4AKjPU6
         Kc6SVVi5+h6t3YL2/Y0zLNs/dhd4JcH4ZtPeSltqDIomu3n1wIU5YyradIsltnoneXrl
         PJVPR6ULZ37MtI3viGmHIQLcoboP9K2R4aBnYKNJM78o/yd7J1eAnhg1wQe3PeguaCWD
         VC9RqI4m/xrqRbO68QoeUTrzjF+4FNS6trotEMNDI5SpxytmPAbFG7laPUcBzCnQvGJf
         oUJg==
X-Gm-Message-State: AOJu0Yz/AW/YoKFvY56AsPlD5+KdcDabas063jl/USjDRzZnvf189bjE
	tF7Fknw+95PDxqe4fJ0eUOozZQ==
X-Google-Smtp-Source: AGHT+IEma1zSM6Y9S/+UI5j3p/5Dq4kkVNLpVZGExv6IrOEFo4uGT5o+AV+5AuIOPLXchpFMpklmRA==
X-Received: by 2002:a05:6a00:15cb:b0:6ce:49f9:d3e1 with SMTP id o11-20020a056a0015cb00b006ce49f9d3e1mr494561pfu.12.1702060166997;
        Fri, 08 Dec 2023 10:29:26 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ff16-20020a056a002f5000b006ce742b6b1fsm1900019pfb.63.2023.12.08.10.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:29:26 -0800 (PST)
Date: Fri, 8 Dec 2023 10:29:25 -0800
From: Kees Cook <keescook@chromium.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <202312081027.BA44B7B3@keescook>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <202312061236.DE847C52AA@keescook>
 <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>

On Thu, Dec 07, 2023 at 05:57:05PM +0300, Alexey Dobriyan wrote:
> On Wed, Dec 06, 2023 at 12:47:27PM -0800, Kees Cook wrote:
> > Can't we have a generic ARCH_AT_PAGE_SHIFT_MASK too? Something like:
> > 
> > #ifndef ARCH_AT_PAGE_SHIFT_MASK
> > #define ARCH_AT_PAGE_SHIFT_MASK
> > 	NEW_AUX_ENT(AT_PAGE_SHIFT_MASK, 1 << PAGE_SHIFT)
> > #endif
> > 
> > Or am I misunderstanding something here?
> 
> 1) Arch maintainers can opt into this new way to report information at
>    their own pace.
> 
> 2) AT_PAGE_SHIFT_MASK is about _all_ pagesizes supported by CPU.
>    Reporting just one is missing the point.
> 
>    I'll clarify comment: mmap() support require many things including
>    tests for hugetlbfs being mounted, this is about CPU support.

I significantly prefer APIs not being arch-specific, so I'd prefer we
always include AT_PAGE_SHIFT_MASK. For an architecture that doesn't
define its own ARCH_AT_PAGE_SHIFT_MASK, it's not _inaccurate_ to report
1 << PAGE_SHIFT, but it might be incomplete.

-- 
Kees Cook

