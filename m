Return-Path: <linux-api+bounces-1664-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61F78D6998
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 21:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F5FB26B50
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E917D17D8BC;
	Fri, 31 May 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NMNzQnYP"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B9015B96F;
	Fri, 31 May 2024 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182966; cv=none; b=sfc7omXo2SQQSRunkMRd6Nj/9V1b7UQe2ukvLAoMxsqxkef13J/3MQhDOcHt/oZNAWQNZPIuLyah0TuooWn3gKPOXWRWDuJW7v7OB1YeGAc1UJLdF7NaJsZF4MdeDjEt/q6H1eWFJ7vGhQweKSdh4yvSRRfyMUVo2mg5lKqeAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182966; c=relaxed/simple;
	bh=/6f2BFnXlCY+TMZKoklwGpsgUO6E6EdXvHtsPgtZCoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G305icc86lh0bu30rR14koPKscEbTIZEwPUr4HehDT5Lmrj/UOoZAo2xXiv5rFC9wlz8TTPQsP4h2DvIFvfPI1SGpbigB8RpLqFOhwZGXKrodN7+1CQu2Cu2/C0ZciNR9Johv9+frFN6XtDNGuiRGA97JQ74jYgSRcYn5GbaT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NMNzQnYP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hPyof/EOj4v+XgKM3joe70Y5CZ+IX8DZjsDqOIZCxPs=; b=NMNzQnYP8iGOF1xtsYwfuylVYT
	wF10rwcKmLlx4Gb0vPuQpVkl6f83Hi8GCNMdXUAqxy2KutR8vigueSbbqVJpNUtWJi4nWTyWLHm96
	eBEgXHpQ0Y7A6TUnB27JTUu9aGsFCm7aEIONfBoqdVFcwFtMxh/pmCsMRoi2k6cvTcQwiKR1aIpci
	0uwX4SAUfatKIyun7wLLjskZf75p95a3IKjAA3wOY11D2yB97C/y+s4GPgKcYpxPi2HIjz71KOx5d
	vf442zpq6F2KoZpeUdoGTUfUHAz8AWBx1fyhmac5aQ3x8iMgJFPVMOw1qXA1rppVxMv9OvSB2wgc3
	DFu5HivA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD7jQ-0000000BDnz-0GMj;
	Fri, 31 May 2024 19:16:04 +0000
Message-ID: <2b21f479-cf4f-49a3-b7c8-33f87a1998ac@infradead.org>
Date: Fri, 31 May 2024 12:16:03 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 5/5] x86: vdso: Wire up getrandom() vDSO
 implementation
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, tglx@linutronix.de
Cc: linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, Samuel Neves <sneves@dei.uc.pt>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-6-Jason@zx2c4.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240528122352.2485958-6-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/24 5:19 AM, Jason A. Donenfeld wrote:
> +/**
> + * getrandom_syscall - Invoke the getrandom() syscall.
> + * @buffer:	Destination buffer to fill with random bytes.
> + * @len:	Size of @buffer in bytes.
> + * @flags:	Zero or more GRND_* flags.
> + * Returns the number of random bytes written to @buffer, or a negative value indicating an error.

    * Returns:

> + */

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

