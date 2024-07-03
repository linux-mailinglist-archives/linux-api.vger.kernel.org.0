Return-Path: <linux-api+bounces-1833-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0DF9268BD
	for <lists+linux-api@lfdr.de>; Wed,  3 Jul 2024 20:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2980B1F22666
	for <lists+linux-api@lfdr.de>; Wed,  3 Jul 2024 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DAC18A93F;
	Wed,  3 Jul 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="z4d5odtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GHU5L3cj"
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB5185094;
	Wed,  3 Jul 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033163; cv=none; b=uodHo5tSpoTAMhM6Hcm2euYKmancajPFUaI4F+7FKBFItzWz9NohQijm5h+QuqIKyW21DUE6qp1JGp7BDFWWbDGl6/4pyRGBb5YcT8IK9WOLjT/lRr2QJH1DKnoV2gFSnB4dek/5ayk+G5HZcEcPhDqgz0MLY8N6tczBeL9ELpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033163; c=relaxed/simple;
	bh=G37uwdK2DFoSoYhvUmZ+2s694kX02sXqTLYlQrlQwfA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=CV3/7k1OgbyDtSLGD1yJyUtiSdfB5UHB2Yd3SimMG36OYt/5Yrrm/NatL63I50pw3eaBhq3CvF6Zv0KqsGa1KbVEegfzGS+hc37YL+icrkaotamc7L1yMz/0sf3yfos3fd/ErWB1mDptPtmNdvfZPFqE6Mib3rUk+VS3X5AMe9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=z4d5odtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GHU5L3cj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 590131140247;
	Wed,  3 Jul 2024 14:59:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Jul 2024 14:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720033161; x=1720119561; bh=TQ0KUlf6qH
	/cHbOx2W4Z3Oy9UTzvWKmD0KHkZgA7+f0=; b=z4d5odtWssXeBgGWZN+sLFhwpb
	E+EhBg2IOEoqaARs92cH7Ai7cq/bOSLY9fthAbI0l/FD0Av+nO5+R6mvG5toNaB3
	Ql0vbMO47hlQbT7HXLibXv3RpNKGxd0wq4O3Da/VEeFP1pyue+YNkKYDQz3AKm9r
	C/XdsBOmsDdKptc1mSa9szx1NQx3ouKbsxkFepy4DMvaYhEpUlin9HTZ66TA4BWW
	HgeK8pasIREtapsxNutArL0LllODV1aJb+mifFXFKvmPo9kM0Yu/sb52H3I5CTHw
	1cbfxrQCzsrZcHZcedaV//qQnlVgGZisUxeIF1O0UQF8M+iQepAq05q12heQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720033161; x=1720119561; bh=TQ0KUlf6qH/cHbOx2W4Z3Oy9UTzv
	WKmD0KHkZgA7+f0=; b=GHU5L3cj2jJCZEejB9nT4VPCtgPC0Kof0reOSa30Ad1b
	u4HP2hLLlbSHgIrM58VnKaIUvvX2JAF2pV6YZPf306uTWA1M74BsQvM143vLDwrD
	43RYv5KSLVw4n5VFBzt3kpwQUc1UWfa6MrYXw8cY5mz9nnZqsEIoVBus4n9IWKwD
	ydk/3LWOELhpMyrwsgb/hz+oSU6I3eJsn2JYx41SQUQrCMzFq/mfPiVaSlt62dA2
	oX78I1IdF3T33IS+tzqzOrPEe5O9wfsc15LVMxO6tnvx3T9YgQOYg/B2LgEcCEYx
	Dckuqy+2Ipe3RgdAmq5CaVH98/XfblfRmbipfVGE4w==
X-ME-Sender: <xms:iJ-FZowAfMPy9TIO7P_zluHpYdtq7zKVsrje3F4NBgKfdiD-W6dLtw>
    <xme:iJ-FZsQfUNWCnOjITYAFVd-0A2_rw1oyXRPxotQdBDuuazsbGjhGrpA2W8G-JaSka
    oe00tyY2fAFAKXih4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:iJ-FZqX2twdHU14dUK5UK4qEfJpjgDMFgjdayEeiwUYl-Y7sTAMyKQ>
    <xmx:iJ-FZmiu60tHcY0vm7iamrYkGM2AF0h3ooyvdfW1TCZSpRQcKhkYIw>
    <xmx:iJ-FZqB2LkZdlMPI5COvr7mTSE1bC1qbwHoi7nnYPib9rWFE8a-Glg>
    <xmx:iJ-FZnLewjzT5EhexMd9Ai4d2ZQT-4EgznJGW3HLEYOHXbMwm4odwA>
    <xmx:iZ-FZkw96U4IIww9z2LsPSWKYrlsgw8sp4JUZoO_wS0ZGsE5BkkFp0mm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C38FBB6008F; Wed,  3 Jul 2024 14:59:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fa6eb1f8-b681-4c3f-bf5f-4ca19da78b17@app.fastmail.com>
In-Reply-To: <20240703183115.1075219-4-Jason@zx2c4.com>
References: <20240703183115.1075219-1-Jason@zx2c4.com>
 <20240703183115.1075219-4-Jason@zx2c4.com>
Date: Wed, 03 Jul 2024 20:58:59 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, "Thomas Gleixner" <tglx@linutronix.de>
Cc: linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
 "Carlos O'Donell" <carlos@redhat.com>, "Florian Weimer" <fweimer@redhat.com>,
 "Jann Horn" <jannh@google.com>, "Christian Brauner" <brauner@kernel.org>,
 "David Hildenbrand" <dhildenb@redhat.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 "Jiri Olsa" <jolsa@kernel.org>
Subject: Re: [PATCH v20 3/5] arch: allocate vgetrandom_alloc() syscall number
Content-Type: text/plain

On Wed, Jul 3, 2024, at 20:31, Jason A. Donenfeld wrote:
> Add vgetrandom_alloc() as syscall 463 (or 573 on alpha) by adding it to
> all of the various syscall.tbl and unistd.h files.
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I checked that the system calls are all hooked up correctly
across all architectures:

Acked-by: Arnd Bergmann <arnd@arndb.de>

Unfortunately we now have three syscalls scheduled for
the number 463, the other ones being uretprobe (only
for arc, arm64, csky, hexagon, loongarch, nios2, openrisc,
riscv and x86 for some reason) and setxattrat (on
all architectures).

It would be nice if you could all coordinate on this to
pick unique numbers.

       Arnd

