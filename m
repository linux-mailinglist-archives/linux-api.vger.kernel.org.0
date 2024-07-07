Return-Path: <linux-api+bounces-1865-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B37929983
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 21:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EF51C208C5
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A976F2FA;
	Sun,  7 Jul 2024 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LJJKKpSQ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463060B96
	for <linux-api@vger.kernel.org>; Sun,  7 Jul 2024 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720380187; cv=none; b=OZ33l446yrYrqxssfJM8ApBTs/6duDEMOlkHU7gZFhwT7Hn7nykY/Snd/Qa9Q2GqbX4NpRNs1Mmsmfv+qefgqpNrT8mrVS3wPlM187L0OgImm/G9wuZj9wvZP0jTx7ySIGlN64m3JeIxs4c548AVzEbek0uYBJ61ZuO9e9sMB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720380187; c=relaxed/simple;
	bh=EpPs/PieXAoJ9C1Niu2SR/rTGpSjbWX77CzmDxsNsCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HclbT+vxWNN16A/u2RhEKcRJKNOP18kW7EICJPqy6eBKXpXKjgHBwqLY8sYCWeWZEaiW6KMnAW/8MEc5FnKKLAxJpYZ5PeNQkWGq/IizhstlSueY+CzGnaCYLuTghqmK7MquyX5NP80fYUckPMRLLqJUFdRGUmlU3hoiyOjVJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LJJKKpSQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso3675689a12.2
        for <linux-api@vger.kernel.org>; Sun, 07 Jul 2024 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720380183; x=1720984983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r0kqfSkBdmswPIG4hqXsZ+rgeH3ZVa2Soxi8UY2qccM=;
        b=LJJKKpSQJEbgpPC0e5dLUegsrAZfV1YpeKUYE0CKpgem4iOwt9BFKZyQ1uL2NBdGiI
         hjQM6EO6EC/OAvB3tQhxwGukO2ih8WU30YN0SbHELE5WiLRBDMSp/ESjfPl0774dQFAk
         jMS4AXxgTggUAjTFvY6uXJUO6olBcaeynIkRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720380183; x=1720984983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0kqfSkBdmswPIG4hqXsZ+rgeH3ZVa2Soxi8UY2qccM=;
        b=Wauh1VR53bo3Bov1CgH/E0vYf4RnCIAI3FwryreCvatoavZ7B6AoS6Qkh1JlEup+by
         QZCvA5IbTeqbPgo5DhR5UG/F0wNGbQuuVNNHIh/5/Ak20j42Eog0CTM1sHdRBOkOA5ei
         TIepNWAHEO5ypkwROhPJ7BpqykEr2zY4VsHImZazZKhVHZLVIx1OPDzLPTEarFJj3Ki9
         XCXlJe7/lKrOUkfnSXmU6jr0RB3sLual8Xmd1/hjMFF7VZtA6G9rfxtP4/BqhwQFUGQt
         1gPc2gzXaTfJXOucYvhBph+wGgSBZY9/dKCyQY5ruKDmJ4k+BWuPuIzgIpc4YGQUwVgY
         0MeA==
X-Forwarded-Encrypted: i=1; AJvYcCVeOzgft8misF/xDbY84MNl/A9TjXXJYOqP3cCYvLBRrPVOFe4lmcBcICR4YFqvGKmXo7SQ9fXwRms4cr3pg3ZF65bNLHmrK+I9
X-Gm-Message-State: AOJu0YyooHoGZyKNAYykrx24axWbnvPgenBpYecRkuOY7ZO3Lnv78fEw
	uhj6GzLhYZgVyMbKWoSfE4gd361h4MmEG/H/LscHoegkuHDNKV+2cm7GH9+EeiDvua3FfG2AOrt
	xedMZ7A==
X-Google-Smtp-Source: AGHT+IGBs4uAxP9P71KOP4+v7RjxxvpZLNVB2frErN+Un0//NZpeXZcWmiyuauQbgIlpeNuUU3VI+A==
X-Received: by 2002:a05:6402:2353:b0:57d:4ca4:61ba with SMTP id 4fb4d7f45d1cf-58e5abd9fb8mr7391784a12.10.1720380183429;
        Sun, 07 Jul 2024 12:23:03 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58d0bfeec43sm5692227a12.48.2024.07.07.12.23.01
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 12:23:01 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77e2f51496so142084766b.0
        for <linux-api@vger.kernel.org>; Sun, 07 Jul 2024 12:23:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtSrU5s4g5xRAUtkg8B2E616aNNbFRPB0oZGSQynqC89Yu32HOT1TFe/EPqjOki7v4wicfdP0I8V0SJpTE+JmfeQN7ImKxe8to
X-Received: by 2002:a17:906:7708:b0:a75:3c31:4f58 with SMTP id
 a640c23a62f3a-a77ba46fa2bmr620405066b.32.1720380181227; Sun, 07 Jul 2024
 12:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707002658.1917440-1-Jason@zx2c4.com> <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com> <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
In-Reply-To: <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 12:22:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
Message-ID: <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 11:52, David Hildenbrand <david@redhat.com> wrote:
>
> I recall that introducing things like MAP_SHARED_VALIDATE received a lot
> of pushback in the past. But that was before my MM days, and I only had
> people tell me stories about it.

I think MAP_SHARED_VALIDATE was mostly about worrying about the API impact.

And I think it worked out so well that this is probably the first time
it has been brought up ever since ;)

That said, the *reason* for MAP_SHARED_VALIDATE is actually very
valid: we have historically just ignored any random flags in the
mmap() interfaces, and with shared mappings, that can be dangerous.

IOW, the real issue wasn't MAP_SHARED_VALIDATE itself, but introducing
*other* flags that affected maps that old kernels would ignore, and
then the worry was "now old kernels and new kernels work very
differently for this binary".

That's technically obviously true of any MAP_DROPPABLE thing too - old
kernels would happily just ignore it. I suspect that's more of a
feature than a mis-feature, but..

> My understanding so far was that we should have madvise() ways to toggle
> stuff and add mmap bits if not avoidable; at least that's what I learned
> from the community.

It doesn't sound like a bad model in general. I'm not entirely sure it
makes sense for something like "droppable", since that is a fairly
fundamental behavioral thing. Does it make sense to make something
undroppable when it can drop pages concurrently with that operation?

I mean, you can't switch MAP_SHARED around either.

The other bits already _do_ have madvise() things, and Jason added a
way to just do it all in one go.

> Good to hear that this is changing. (or it's just been an urban myth)

I don't know if that's an urban myth.  Some people are a *lot* more
risk-averse than I personally am. I want things to make sense, but I
also consider "this is fixable if it causes issues" to be a valid
argument.

So for example, who knows *what* garbage people pass off to mmap() as
an argument. That worry was why MAP_SHARED_VALIDATE happened.

But at the same time, does it make sense to complicate things because
of some theoretical worry? Giving random bits to mmap() sounds
unlikely to be a real issue to me, but maybe I'm being naive.

I do generally think that user mode programs can pretty much be
expected to do random things, but how do you even *create* a mmap
MAP_xyz flags field that has random high bits set?

> > We also have PROT_GROSDOWN and PROT_GROWSUP , which is basically a
> > "match MAP_GROWSxyz and change the mprotect() limits appropriately"
>
> It's the first time I hear about these two mprotect() options, thanks
> for mentioning that :)

Don't thank me.

They actually do make sense in a "what if I want to mprotect() the
stack, but I don't know what the stack range is since it's dynamic"
kind of sense, so I certainly don't hate them.

So they are not bad bits, but at the same time they are examples of
how there is a fuzzy line between MAP_xyz and PROT_xyz.

And sometimes the line is literally just "mprotect() only gets one of
them, but we want to pass in the other one, so we duplicate them as a
very very special case".

                     Linus

