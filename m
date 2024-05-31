Return-Path: <linux-api+bounces-1662-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E898D697E
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 21:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757231C22FD8
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D6C178369;
	Fri, 31 May 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NkubCPox"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC317D36D;
	Fri, 31 May 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182747; cv=none; b=qM0PClENSTBdnbhKW3YMbCc0BaLRqg/38LrFuKad4M5RVLl04LJhuYtafaOHevlGUFNn1WNBTtRDjtkRELQhW1qFChX3uTtW+KDdubnxfCtpNpo9Giv/ZW8InuQGS9czvM8vyqoqb4tsvFihxsXHVV2ihZqQoH5KtN1b/NZVvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182747; c=relaxed/simple;
	bh=sFsB5dqdy3gZRk50dI6z/h66URse+3gNEkhEkUqmsgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+ZWo/nXtBaL6cgaRARYgkWcigNtkZmyjHjkCNu2vNW9tjv6QvZ7l4oaKDz37lbdrrzkgo4qMFa8zItf5xiPhsi4yWn4Q45QAqUlZFGkKOwab1how974YL4PLfH6EoymOW451kxSorB/dXvpzrII4BRs+CRi90ohPNDZ/TM7V/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NkubCPox; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WusGXCsAP8jLvsx8zCO8SWtowPYaOe3WkJ+UrPpN66k=; b=NkubCPox2v0/24Di9p78k3teLJ
	rPt60VFZf5BlsFEh4KekHeGTRsJtoqjRbk7INTfkQLC6czg/eFvcKOFed1CqZ7k1Msx1SCVYAMU+A
	AnXj6yCqi4JJxBI40UiFH5jw1OV6djwOuBVce7ET6sSEo5igfyZqy2/SNZxyFYQcREfitSw0eAysk
	LH4e9UyiBz92JCFTBJih508iNv++M6PrzDdAPFd74DDttP9B7nf+r3LHk14pLm78EQ4owWOvuMvYu
	pIXxYtQvROat9d49Tzok7zPM48Ay8k46CgRWrvkNZMyXUWfmejUMFmZcva9PIlW4iWt/N2M94lyMw
	MHeoMTXA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD7ft-0000000BD8i-1Abg;
	Fri, 31 May 2024 19:12:25 +0000
Message-ID: <173853ee-348d-4f76-bc50-c5727d76b3c9@infradead.org>
Date: Fri, 31 May 2024 12:12:23 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 4/5] random: introduce generic vDSO getrandom()
 implementation
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, tglx@linutronix.de
Cc: linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-5-Jason@zx2c4.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240528122352.2485958-5-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/28/24 5:19 AM, Jason A. Donenfeld wrote:
> +/**
> + * type vdso_kernel_ulong - unsigned long type that matches kernel's unsigned long

s/type/typedef/ (for first "type" only)

> + *
> + * Data shared between userspace and the kernel must operate the same way in both 64-bit code and in
> + * 32-bit compat code, over the same potentially 64-bit kernel. This type represents the size of an
> + * unsigned long as used by kernel code. This isn't necessarily the same as an unsigned long as used
> + * by userspace, however.
> + *
> + *                 +-------------------+-------------------+------------------+-------------------+
> + *                 | 32-bit userspace  | 32-bit userspace  | 64-bit userspace | 64-bit userspace  |
> + *                 | unsigned long     | vdso_kernel_ulong | unsigned long    | vdso_kernel_ulong |
> + * +---------------+-------------------+-------------------+------------------+-------------------+
> + * | 32-bit kernel | ✓ same size       | ✓ same size       |
> + * | unsigned long |                   |                   |
> + * +---------------+-------------------+-------------------+------------------+-------------------+
> + * | 64-bit kernel | ✘ different size! | ✓ same size       | ✓ same size      | ✓ same size       |
> + * | unsigned long |                   |                   |                  |                   |
> + * +---------------+-------------------+-------------------+------------------+-------------------+
> + */
> +#ifdef CONFIG_64BIT
> +typedef u64 vdso_kernel_ulong;
> +#else
> +typedef u32 vdso_kernel_ulong;
> +#endif

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

