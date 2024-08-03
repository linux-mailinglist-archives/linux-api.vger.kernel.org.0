Return-Path: <linux-api+bounces-2103-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE89468A2
	for <lists+linux-api@lfdr.de>; Sat,  3 Aug 2024 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190A01C20B5C
	for <lists+linux-api@lfdr.de>; Sat,  3 Aug 2024 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B617814D2AC;
	Sat,  3 Aug 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="foAR1euZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nmz9zZ1v"
X-Original-To: linux-api@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152C847B;
	Sat,  3 Aug 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722672791; cv=none; b=oMkbojpkcef3NCNuWRRsNVPFPryltTVnI5jOcbaFwdXJ7LbiKeSmV+WA5cv+QRCcT+w1maWHOE3VQInlFQhiX0+MnBvbiTIt3jazGmO4PuAasC342rTluUu1ZerSReIYiQABA2NphiwDC4U0sNYMC/7J5ufXce6uKR0GyLQz5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722672791; c=relaxed/simple;
	bh=dvE5VKCkS5zNzIrEjKd2s+54/r3fU46etA/tG36HYuA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kBmC/EZy67iQdj1V7eyZL5q4xH9IgSRBbA7D7s/TauIZYm8RfMbZoHsxyOd3tOFN6mSjTvleetFCPkzPnUmWd37yxsgxnpQraiwSm1KlVNejQcDq5cW0MH+n1+X60MZko+sDSzdfTsp8G/YqW+l4bA89H3fMhprb6XTmi9Y20/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=foAR1euZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nmz9zZ1v; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id BF0F0138FD79;
	Sat,  3 Aug 2024 04:13:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Sat, 03 Aug 2024 04:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722672788;
	 x=1722759188; bh=sCg1QVf69WV5BKyj0Bz6F+tGawADHTPiS5wm9bbqpj4=; b=
	foAR1euZsEklJ2VYaRRfjKL1MD/JLYGXZFenHUzaZz8RDoIwcXQ1ePV3DpiLXwR0
	PdLlWsfw6ryEwEWXdo68vNf6P1kI5fvApTIX8c0iDAf3dRNfH4wE48Bpcj+RYvlz
	MFzu/UGdxKNXbZR0Gv8PJZTMeNVFPD8reWsOloMByXxA8gEK4PRhOoRw/iS36dSY
	p2ZUFKuQfI8I6MoiSPPFqgRtMUTBsKhLzJ8ccqnqFfTVm/oNrsbV2e5kFbx9tOoX
	uswafvgCd/v19CQ99PWQvEgkpWNRnamGK0blOHWNeF2tfRVahnAjLqLY1oezpYcS
	XzxbcQxUsiLiMDzq998eag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722672788; x=
	1722759188; bh=sCg1QVf69WV5BKyj0Bz6F+tGawADHTPiS5wm9bbqpj4=; b=N
	mz9zZ1va3nyzLqX7qEb/4LHiKSFpgbb/5/isTz3YA9uqm3u0rkDQw/3qKl7xFzGZ
	fQBCNH0O1YAgSPK1bnWgas2r0ZhjbnR9m6lai0MEiIakAN6XPO2gX6zl1CMIdwvE
	41LSbe1pPPdvY8tM9vSAZyZw2SEOTohL/1tNqwJ0eX8UZ4MRMGsslVUpzqeQ1Fa+
	M8IJy14I+Zn2QeSfFlDisPhWlyinANPzlIb8qGr+en0nC8uycjWlx+pr+0g4Cgf3
	uPFUxbcUTpZjHhC+RdCqXhug6gZgBBfO15o3ri6qlMUfTUF+py5ZNMIIFDEQD0YL
	AY1n63pAK1sChmoqpcKKQ==
X-ME-Sender: <xms:k-atZjZIi_nb6xQzV4QZquEwGkYpdvFdVJFzpEXdRJ3lVfhRHouZ7w>
    <xme:k-atZiZf7BBkTF0rEXdFyOh-bv5DONr5Dyp8LqB8hclcmmLJNOLuoXoZLK7KNNNpw
    FeFODjW83S8aRsXBYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedugddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefh
    vdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:k-atZl__iDSgqUxsbYqIfmleR-5TCNYMf7IFOKsYaB-ZzDX1D3Jgdw>
    <xmx:k-atZpqBO4YvtbDZkcIbm_g1-picVDknmfyrXlHldEPPhpeJlzPXMw>
    <xmx:k-atZupOAuDXZb52VKCUTxkxKa2CsAR1srXuA9y1B2pDRxAu9-JaWg>
    <xmx:k-atZvRxgKDMGtyYNVmHMuNnSd0cyBZGa-O8Nx617LGQJkep9lWCQw>
    <xmx:lOatZh93VFfrxjFWmkADAfIVDHcCOvVk7LyN1LyGv89RwHsxQE9GT4Ig>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7E37CB6008D; Sat,  3 Aug 2024 04:13:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 03 Aug 2024 10:12:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jakub Jelinek" <jakub@redhat.com>, "Rudi Heitbaum" <rudi@heitbaum.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Huacai Chen" <chenhuacai@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Andreas Schwab" <schwab@suse.de>, "Florian Weimer" <fweimer@redhat.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-api@vger.kernel.org, "WANG Xuerui" <kernel@xen0n.name>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev
Message-Id: <c78916da-ee59-4ecb-9886-7bbc7f077fa5@app.fastmail.com>
In-Reply-To: <Zq3jqeq6USL066k+@tucnak>
References: <20240801123305.2392874-1-arnd@kernel.org>
 <Zq28wejX3U9J1_JV@faede8dcc269> <Zq3jqeq6USL066k+@tucnak>
Subject: Re: [PATCH] syscalls: fix syscall macros for newfstat/newfstatat
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Aug 3, 2024, at 10:00, Jakub Jelinek wrote:
> On Sat, Aug 03, 2024 at 05:14:41AM +0000, Rudi Heitbaum wrote:
>> With this patch to kernel 6.11-rc1 the error whilst compiling gcc-14.2 for
>> aarch64 with libsanitizer has changed from '__NR_newfstatat' to
>> '__NR_fstat', so some change, but still fail8ng.
>> 
>> sanitizer_syscall_linux_aarch64.inc:13:23: error: '__NR_newfstatat' was not declared in this scope
>>    13 | #define SYSCALL(name) __NR_ ## name
>>       |                       ^~~~~
>> 
>> sanitizer_syscall_linux_aarch64.inc:13:23: error: '__NR_fstat' was not declared in this scope
>>    13 | #define SYSCALL(name) __NR_ ## name
>>       |                       ^~~~~
>

Thanks for the report!

Yes, I think I messed it up again by changing both fstatat and
fstat. Our internal names in the kernel are a bit inconsistent
and I failed to realize that only newfstatat uses the "new" name
in the user-facing macro.

> Probably it would be useful to check
> echo '#include <asm/unistd.h>' | gcc -E -dD -xc - | grep '#define __NR_' | sort
> for all arches between 6.10 and the latest git, diff them and resolve any
> unintended differences.

Right, I should have done that before the original series really:
I spent a lot of time validating the kernel's internal changes for
consistency (which found a dozen bugs that were unrelated to my
series) but missed the unintended changes to the external header
contents.

I'll do that now and send another fixup.

    Arnd

