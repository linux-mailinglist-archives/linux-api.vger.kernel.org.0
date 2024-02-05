Return-Path: <linux-api+bounces-834-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A00849B06
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448EF1F25F04
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70EB482FC;
	Mon,  5 Feb 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mfp/C/w0"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE02D056
	for <linux-api@vger.kernel.org>; Mon,  5 Feb 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137291; cv=none; b=VnSjk7y7gxnnav+ZklhjKLFJwmIOoqB1EomvHVHqea7xTDnhixJoSXdCmG2JTZuK05Vh6w38FiYfZKKMhNzySnhatfC/J8FZMipT5WYVHpU4vKAWwLVQEA5VpuXyRSE/1fi5An59pDaktNDjS1zoR5OW3Ek9jolImiiLUt/0huU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137291; c=relaxed/simple;
	bh=hMQsxleb2DgLiOtL+XcLnQPzsO2TotOD/Pmi3+oKloU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6sv0bpm3/uqeLSC882oaL6adC36Rnbv/hB2y/AFkoJ5hTt7urGgWAaphMvPaiYBikrkXAd/GbXdjBLaCHF8ncvMJQ/NlrcpojXxRx3mTFLOT7wpGbg5nlMUdIlX9oiwAQqvWKD1QSNzsS+t9YaeNayJoqgjpFZiHy7zU4vssbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mfp/C/w0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d94b222a3aso35419745ad.2
        for <linux-api@vger.kernel.org>; Mon, 05 Feb 2024 04:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707137289; x=1707742089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jp4Q5U+zIlzWB/BXVKcZBw8dz1qw2kebfH71OdMWBLA=;
        b=mfp/C/w0RUq0WdHImmd1e5PIByl8SjgLcocSUhdGKfJiLLA+Ej7uC5hh/b3uRhczvu
         HrZQmgZu+7H6Rb3L3SiEI8GKfAM1wIU6MTYMj2kfvrhxWvDOsH+bLufs2C1T4ajflRdl
         6vmu4EWt5mfJdSJChg1xgzRCt4aedwf9PI3cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137289; x=1707742089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp4Q5U+zIlzWB/BXVKcZBw8dz1qw2kebfH71OdMWBLA=;
        b=BJVKxzUOmiUzW73d6iT6I8ctRh3dHwGEuFloCPVSddNmw5MIUS+oEc11ZSYN9VZ4UB
         yN+HMUAiA41nSNUArsDloaWkSen1PyueNupk7FLlMhtAu1jnd5jETnmLPFrLe2avauVA
         Z1ukeSkWawsSqISaGM1KE8+5JZpq6C8wZU0bf+KcuouH9lLl9FaBUUZSc65LDsJBp3ve
         3Uzg7vRo7zHgntj1zzswn9JcyH2BuS5y4R3o0eC2quFsvSGtQxWkBalld4wKkIALBa6A
         iQwOQo055DM2B3MoUnDdWrB3Jrr/NydSFIUsxZEkyu1rMmbiw10BjmaXyDC0CRAPd/oI
         BmIQ==
X-Gm-Message-State: AOJu0YyF9XjPwwEgKd40iVMuKyrmvcbawSTaPP8v4dmF9q436Vq/1DxH
	yW/8Pn/jjHxNk5f8770woNtCZt9eOfxY6w1NUrgmA4Cf9no7WK0L8BwapqUOhA==
X-Google-Smtp-Source: AGHT+IHYbwF4AZxr+BIBzkFZlJurA2gYc1bK0rKQHMh9C8dej+7vIsMA2pXzfcqyntpLUgE85vHpwA==
X-Received: by 2002:a17:902:650c:b0:1d7:5943:21b8 with SMTP id b12-20020a170902650c00b001d7594321b8mr10194131plk.16.1707137289454;
        Mon, 05 Feb 2024 04:48:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUtCqunCXxFNFT2rH8Qo2NHg52HZy+4Sa2MQq2EyuiWJcNqHwBIykWLL0u4UqEOMaCvzCtpjJoWSPJUbo7DhzhZ89KO+u16Y1JBm7o5562Gp5pgdhGCm8ufKd7vcjieySULkIG/nzq0GkLQsstXEXl735jvLqddCGKwuHrNHkKp5ZiLBWIes7Vokht2n+r5MJeiPbiSiASXCuBhAAgdrAVebtCTsIVjqdKCwkMRQMYSwJsF6A0+Iz1F5wUcBFMa1Nqw08Pqw1euJtfaGsVLoDWOyTvqaNfiTKMjqmL/vrlUN5In9PeXNXXyH69zZaeBBLX2H/QFEFDCWpg/TUy18gJVkR0z9HhIcZhfZ7GxZndTXSPRoqSjSaq21UcPhGN2Z3TPQSo=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b001d8f99e4737sm6318404plb.49.2024.02.05.04.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:48:08 -0800 (PST)
Date: Mon, 5 Feb 2024 04:48:08 -0800
From: Kees Cook <keescook@chromium.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v4] ELF: AT_PAGE_SHIFT_MASK -- supply userspace with
 available page shifts
Message-ID: <202402050445.0331B94A73@keescook>
References: <ecb049aa-bcac-45c7-bbb1-4612d094935a@p183>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb049aa-bcac-45c7-bbb1-4612d094935a@p183>

On Mon, Feb 05, 2024 at 12:51:43PM +0300, Alexey Dobriyan wrote:
> +#define ARCH_AT_PAGE_SHIFT_MASK					\
> +	do {							\
> +		u32 val = 1 << 12;				\
> +		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
> +			val |= 1 << 21;				\
> +		}						\
> +		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
> +			val |= 1 << 30;				\
> +		}						\

Can we use something besides literal "12", "21", and "30" values here?

-Kees

-- 
Kees Cook

