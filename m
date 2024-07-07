Return-Path: <linux-api+bounces-1863-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A808992994A
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 20:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF4C1C209F3
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 18:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7B57CB4;
	Sun,  7 Jul 2024 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OtnvDFwN"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C655E4C
	for <linux-api@vger.kernel.org>; Sun,  7 Jul 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720376408; cv=none; b=HgitFYIU9iVUN0WCTlG+5oCogisUbLi3xVPGZQIAC7aRWCG4r6LIpiBCPQQGAMVlf/m2JBQTz+QPp5r+QEQZz++EizrVIJxf5RAWgKYUhV96sjzkK47ic3cw/a8wnnw2DQtYYTkyHrduWDwkDFzF15AqbCOcOevruBbM1LNEbow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720376408; c=relaxed/simple;
	bh=IgVGCT2xxQj0d6AEWv1d2oISYtXfXK5QvKatWJYOnV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+rHqeinV/i94SjU8dvrUFlf7jU+YuMIz9/REAtRz/mMY9nn60XomoJLhAKF2zqo0S0zIXbyXVE92/D6gbMkXC2guKdpvxwq8SKusB4FX/eIxfeLiQrqn9KodQASHos6n5LxCj4gNtwMsZnEVsM+0saJBKXKZIBwAbGp3qQni0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OtnvDFwN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38027so3679158a12.1
        for <linux-api@vger.kernel.org>; Sun, 07 Jul 2024 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720376404; x=1720981204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5v0Nkh0XR+jIko5z42PL5jDgcJnA00NhojDwz4yKzQ4=;
        b=OtnvDFwNsYv6zEsIeeKcxWS5u7WCwSKpU2ArUPjM55V0TKxMVYUNkLQQlueSlTCDMQ
         RCkd8L0yoW3hhyZpaulYwt1f1XmC5/m62F0EWirtaamOY1I5Hl1Eo0OTq6JDc2XvTXd6
         juIIdgXRZTCVeSFmbRiSnLrd3oxi/D0svkpq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720376404; x=1720981204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5v0Nkh0XR+jIko5z42PL5jDgcJnA00NhojDwz4yKzQ4=;
        b=hpOyz0T8kxOQMFNsaQxtBHTIdqjT9BDu7HIfu9TuTY5fzBNiqc+KD+tCKtqe6h7re3
         vOkXBaVk9zbJuMKCtW+7iFVxOyTyKfQQLKxRt67dseN8y9m8dZqGOZQr7dDU44FH26U4
         X/icozuchA0fpWgjnVpd6R2/hRM7QA2jQQVF2SKuOAeG746ZCHHWJR/S4iHxC1whgt/v
         xnl5DWFnBc5Pz6leNVdQGZxaWC4IZpRGuZuYS5BlQFQkyLs9uS3SgUGqSDA7h/br25nz
         yVMeNf10KxyvN+cFPezKA73zjsfGnJAfm8s9zZrHyNdMm/rKXyBydqBSxQb3Nc3Ewk4J
         Iviw==
X-Forwarded-Encrypted: i=1; AJvYcCU47Pbu9xG5wI9VngaokF1PWTkNfhmkuJcxmoxb4Z3EesQn6RasKzx2bkEDrMu+bVDbemZyw2MUykMo33wXe1iTy00hRGKqljJq
X-Gm-Message-State: AOJu0Yx5vwEZAV0oDT/r/qhOT/m7pk5p+jgzBB4O1ATvzzEwvaSCFPCW
	X9x3aDdLQ3O9KNclEH8+uAX5fWlhkJf/VTwByKefu8mYqAcfoFGJAI5woxA/utHDam41nay/1uJ
	bzwZuew==
X-Google-Smtp-Source: AGHT+IGBmHmD/EESMU633tAeOPC8X7M6oP4IE7hsdJ4jZLVElvm/wj5D+fMDQ82L8ywWsKM/Y7rBlA==
X-Received: by 2002:a05:6402:d0a:b0:58b:7b90:94e2 with SMTP id 4fb4d7f45d1cf-58e5cd15d55mr7854401a12.38.1720376404435;
        Sun, 07 Jul 2024 11:20:04 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58fd14aad6dsm2967821a12.86.2024.07.07.11.20.03
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 11:20:03 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7527afa23cso388543966b.2
        for <linux-api@vger.kernel.org>; Sun, 07 Jul 2024 11:20:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAZdj+s89Z1VqNBbD6THdbBknkMp9JyoOppQNjZ4EtOl/LfDeoK/vU1X5oVy2gWIBa9H3Jy39mTzbDuTgUJOdt81NFbe6F0xae
X-Received: by 2002:a17:906:bc94:b0:a6f:58a6:fed8 with SMTP id
 a640c23a62f3a-a77ba46f8femr721323266b.28.1720376402830; Sun, 07 Jul 2024
 11:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707002658.1917440-1-Jason@zx2c4.com> <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
In-Reply-To: <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 11:19:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
Message-ID: <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
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

On Sun, 7 Jul 2024 at 00:42, David Hildenbrand <david@redhat.com> wrote:
>
> But I don't immediately see why MAP_WIPEONFORK and MAP_DONTDUMP have to
> be mmap() flags.

I don't think they have to be mmap() flags, but that said, I think
it's technically the better alternative than saying "you have to
madvise things later".

I very much understand the "we don't have a lot of MAP_xyz flags and
we don't want to waste them" argument, but at the same time

 (a) we _do_ have those flags

 (b) picking a worse interface seems bad

 (c) we could actually use the PROT_xyz bits, which we have a ton of

And yes, (c) is ugly, but is it uglier than "use two system calls to
do one thing"? I mean, "flags" and "prot" are just two sides of the
same coin in the end, the split is kind of arbitrary, and "prot" only
has four bits right now, and one of them is historical and useless,
and actually happens to be *exactly* this kind of MAP_xyz bit.

(In case it's not clear, I'm talking about PROT_SEM, which is very
much a behavioral bit for broken architectures that we've actually
never implemented).

We also have PROT_GROSDOWN and PROT_GROWSUP , which is basically a
"match MAP_GROWSxyz and change the mprotect() limits appropriately"

So I actually think we could use the PROT_xyz bits, and anybody who
says "those are for PROT_READ and PROT_WRITE is already very very
wrong.

Again - not pretty, but mappens to match reality.

> Interestingly, when looking into something comparable in the past I
> stumbled over "vrange" [1], which would have had a slightly different
> semantic (signal on reaccess).

We literally talked about exactly this with Jason, except unlike you I
couldn't find the historical archive (I tried in vain to find
something from lore).

  https://lore.kernel.org/lkml/CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com/

I do think that a "explicit populate and get a signal on access" is a
very valid model, but I think the "zero on access" is a more
immediately real model.

And we actually have had the "get signal on access" before: that's
what VM_DONTCOPY is.

And it was the *less* useful model, which is why we added
VM_WIPEONCOPY, because that's the semantics people actually wanted.

So I think the "signal on thrown out data access" is interesting, but
not necessarily the *more* interesting case.

And I think if we do want that case, I think having MAP_DROPPABLE have
those semantics for MAP_SHARED would be the way to go. IOW, starting
off with the "zero on next access after drop" case doesn't make it any
harder to then later add a "fault on next access after drop" version.

> There needs to be better reasoning why we have to consume three mmap
> bits for something that can likely be achieved without any.

I think it goes the other way: why are MAP_xyz bits so precious to
make this harder to actually use?

Together with that whole "maybe use PROT_xyz bits instead" discussion?

               Linus

