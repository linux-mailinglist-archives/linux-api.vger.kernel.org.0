Return-Path: <linux-api+bounces-1663-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6598D6994
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 21:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5E8289ABB
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E792717D341;
	Fri, 31 May 2024 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="REdAg7gc"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C98063C;
	Fri, 31 May 2024 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182918; cv=none; b=Ft6Nm2WkI21vZGjOhgL3h+GI2s6uE2FjFdr44HddbUGrfuG8YuRGgfCFbIYWXceKiDqFcGjncytRxQX4KPAn56/CZE4+VZT0P7dixOepdFl/T7lS3VowFjOXu3DvQQuBGBaZMTGdR/yL+m38KVnm+H+jhn9YWcOBkhow6gsRoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182918; c=relaxed/simple;
	bh=DUlJAMG6VtwvoyO4lKU2qtv4Guzyd5yLV54zhkBQpLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Brg5A8Bjg7BTqw2wKVYD3AjVM84P6/1X4Y3grG9/jjmaJLW30v6lJ5KhBMt3rUygJuH60D3zPfJh8FSsUoXwIppNZXHddGfmudf3Mu8uWsiKC8vDy1nTZsahSJt+OA4OJk9j0WzvNqI0FDs3lBR/RfsNPFWAsR+6RXUCTZbDOz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=REdAg7gc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=u/g1j5mYG7Zir9s2o+HTGAW2a6hjFEiH6+1szjteCnM=; b=REdAg7gcqz7o0aDLXsHBfdUAKm
	dMQye5x6Cg/sTyaN2LgZPWLcQCXBi5N1sMfl1vBsqep8+qae8DmlDu/Knj9Pjl0aytbFbzYKOZkYG
	3mx8cJrHSqb+Kef+HbwTaV3AvRis9iBPCxIcpTYprbif9Q5LORgiDtPxnDU5656xX0XUqVbXnGNqG
	J70a80uI9zh2UOLhiyCxZuH/JusIiLqTOlfzcG1vQxaMPBl78ggV9Emr/340N1mmS3lbzZKnRlzhF
	3WX06z4JAVIxEtsksR/gEQMvQp6m7J+x3/V9KtA/27wZVB75paUBrx7NRfwrWSOImhHM76FR1hn4d
	vrs7hs4g==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD7ie-0000000BDZx-3TST;
	Fri, 31 May 2024 19:15:16 +0000
Message-ID: <d3f7e1c5-5945-48c0-b263-e09979a987a3@infradead.org>
Date: Fri, 31 May 2024 12:15:16 -0700
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
Content-Transfer-Encoding: 7bit



On 5/28/24 5:19 AM, Jason A. Donenfeld wrote:
> +/**
> + * __cvdso_getrandom_data - Generic vDSO implementation of getrandom() syscall.
> + * @rng_info:		Describes state of kernel RNG, memory shared with kernel.
> + * @buffer:		Destination buffer to fill with random bytes.
> + * @len:		Size of @buffer in bytes.
> + * @flags:		Zero or more GRND_* flags.
> + * @opaque_state:	Pointer to an opaque state area.
> + *
> + * This implements a "fast key erasure" RNG using ChaCha20, in the same way that the kernel's
> + * getrandom() syscall does. It periodically reseeds its key from the kernel's RNG, at the same
> + * schedule that the kernel's RNG is reseeded. If the kernel's RNG is not ready, then this always
> + * calls into the syscall.
> + *
> + * @opaque_state *must* be allocated using the vgetrandom_alloc() syscall.  Unless external locking
> + * is used, one state must be allocated per thread, as it is not safe to call this function
> + * concurrently with the same @opaque_state. However, it is safe to call this using the same
> + * @opaque_state that is shared between main code and signal handling code, within the same thread.
> + *
> + * Returns the number of random bytes written to @buffer, or a negative value indicating an error.

    * Returns:


> + */

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

