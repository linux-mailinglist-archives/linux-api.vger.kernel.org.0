Return-Path: <linux-api+bounces-109-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0217F34A8
	for <lists+linux-api@lfdr.de>; Tue, 21 Nov 2023 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB18B20FEF
	for <lists+linux-api@lfdr.de>; Tue, 21 Nov 2023 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE085A100;
	Tue, 21 Nov 2023 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOpT3uUb"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A172F10C1;
	Tue, 21 Nov 2023 09:13:06 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5ca77fc0f04so22365807b3.0;
        Tue, 21 Nov 2023 09:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700586785; x=1701191585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3AE1vsaCg/OCpsM8DXy41/9s8SNdAdOfniKnePQoU6s=;
        b=eOpT3uUbu7aJoO2m943tCCnvtyH+xgW8QRT9gX+UlvWV/HsICy6rgzl+tLpXqJRGRD
         RVteTpaGyrhiGfAOSbtxTLOiqbsuTeK8ydCAgIIEhzMTzdIP4g6CEAGDQ8cj3zH5R/fh
         T/LpVEfH8RGRgNFtgISCyZfiP0wD9VroNUOonbuMFczernWUWUyIY1VytvXRfCb8e/lF
         lIuFBYkFEJ7kROaI7Vk0muLV9VG//QGHmZdQCcKpU1s/mJUQmUOxIG+wrb+4DmT5/xQ/
         PhECaavV6BfmGGe7lfmIOPyzNmo65uMskbroUwKdXrQCaIFB+4UCOtmin0BLGDK01f4X
         xSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586785; x=1701191585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AE1vsaCg/OCpsM8DXy41/9s8SNdAdOfniKnePQoU6s=;
        b=DuPVW+sfCMml9z+KqPdoNYknoJFBEtrXPSuK/ZT42Fg3vFsufJraaPZXHywLUHfV6Y
         hk7SR2AGHehhsrEeXe12jJz71k+n6BY70+xOIKQbQnqdryW027+hrOXY4BgArAyI1Xa9
         chYuu4aVehyQrhDhEY6lnybBXNNC6H3w21RJMDwn3D61Mk0/F31om57bTXqPSqlzXKQD
         pn4N04s/ecNZUemHfm5AoZPfq+oRxKgyBR0k50LM9QRRXayEy3AY5EwpQW1k56ykOrbq
         9tOthHC/mY980Bv1aPn+zemHx1FmvIBt0guo6RLEjZWb4t78p6CqpHFSMXgLkEC8pFd2
         l3Hw==
X-Gm-Message-State: AOJu0YwEBBamGsRmPJKq+WACwxA2NTYT+Xfivj62UGZfubZ9N1ZyKx3Y
	LVrxbvwtkcFZFKtB5caJwY0=
X-Google-Smtp-Source: AGHT+IHT3ZApSXGATslgtejB/P1iO54fqZKujt8TRiYqECERZwq3b3xGOgsDOV7noQMCcVdL1wlb7g==
X-Received: by 2002:a25:a206:0:b0:da0:53d2:8f46 with SMTP id b6-20020a25a206000000b00da053d28f46mr8261338ybi.25.1700586785446;
        Tue, 21 Nov 2023 09:13:05 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e005:b808:45e:1b60])
        by smtp.gmail.com with ESMTPSA id y5-20020a259b05000000b00d9cd730e4d0sm803882ybn.26.2023.11.21.09.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:13:05 -0800 (PST)
Date: Tue, 21 Nov 2023 09:13:04 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
	linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
	carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH 23/30] cpumask: Implement
 cpumask_{first,next}_{not,}andnot
Message-ID: <ZVzlIAUrxGUFsoyt@yury-ThinkPad>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
 <20221122203932.231377-24-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122203932.231377-24-mathieu.desnoyers@efficios.com>

On Tue, Nov 22, 2022 at 03:39:25PM -0500, Mathieu Desnoyers wrote:
> Allow finding the first or next bit within two input cpumasks which is
> either:
> 
> - both zero and zero,
> - respectively one and zero.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  include/linux/cpumask.h | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index c2aa0aa26b45..271bccc0a6d7 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -153,6 +153,32 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
>  	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
>  }
>  
> +/**
> + * cpumask_first_andnot - return the first cpu from *srcp1 & ~*srcp2
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static inline
> +unsigned int cpumask_first_andnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +	return find_first_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
> +}
> +
> +/**
> + * cpumask_first_notandnot - return the first cpu from ~*srcp1 & ~*srcp2
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static inline
> +unsigned int cpumask_first_notandnot(const struct cpumask *srcp1, const struct cpumask *srcp2)

cpumask_first_zero_or

> +{
> +	return find_first_notandnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
> +}

Can you be consistent - either add cpumask_check for all new
functions, or don't.

> +
>  /**
>   * cpumask_last - get the last CPU in a cpumask
>   * @srcp:	- the cpumask pointer
> @@ -195,6 +221,40 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>  	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
>  }
>  
> +/**
> + * cpumask_next_andnot - return the next cpu from *srcp1 & ~*srcp2
> + * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static inline
> +unsigned int cpumask_next_andnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpumask_check(n);
> +	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
> +}
> +
> +/**
> + * cpumask_next_notandnot - return the next cpu from ~*srcp1 & ~*srcp2
> + * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static inline
> +unsigned int cpumask_next_notandnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)

same here: cpumask_next_zero_or()

Thanks,
        Yury

> +{
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpumask_check(n);
> +	return find_next_notandnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
> +}
> +
>  #if NR_CPUS == 1
>  /* Uniprocessor: there is only one valid CPU */
>  static inline unsigned int cpumask_local_spread(unsigned int i, int node)
> -- 
> 2.25.1
> 

