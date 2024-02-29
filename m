Return-Path: <linux-api+bounces-1086-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B77686C549
	for <lists+linux-api@lfdr.de>; Thu, 29 Feb 2024 10:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3206B1F277EB
	for <lists+linux-api@lfdr.de>; Thu, 29 Feb 2024 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795875D8E3;
	Thu, 29 Feb 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Sk539cE"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960DE5D8E8
	for <linux-api@vger.kernel.org>; Thu, 29 Feb 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199125; cv=none; b=XKeas39Jgck6QLw73zi13OHOLP6ox+DUWb5uSvUzyk7k9Smpa1NOVF0C8dI43bGxPbRqj7f/5+siiIQU+Qx4RJABG2eP8TkR0qOcTrH3mMktxMSoX3QOkIhtuwqsDzTx11TeN6eq4O9PX1+aC5CDLnW5ceg1geTfdXpvOW6tcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199125; c=relaxed/simple;
	bh=o/MZbNUm82wJ0smN4ZI9fIXzGicdoFKBpqsdICiE+8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLMLCea0aEZ0ir3wX/Hs1oXt5CGnA1cvLbdzYhK+UQ6/RKs3rEUSkXTbjFXQEFvfzJilBjDvaNY/43+ePe43E6CIzDcvlIQmWgBjkzpwBOybzJDdfUddiF1deYWwLvQrblqgG3ZEGvkRCosWYq9ddTFUYgO/iNh2le8laX/X1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Sk539cE; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4cea831ed57so190439e0c.1
        for <linux-api@vger.kernel.org>; Thu, 29 Feb 2024 01:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709199122; x=1709803922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o/MZbNUm82wJ0smN4ZI9fIXzGicdoFKBpqsdICiE+8w=;
        b=1Sk539cE8o5FzNKJBVCxNknb7cr4kQ1+gNS7O6HPIi4yKHgsXR9eWePgrHyQvGADzW
         E5YCtpImhX6r2r1JClF/kcWB1KNBdTbQQH0NHFWDsIR0ookkc4GxUX3+d4puRkTZTDrn
         2HkpRDsYvOyhnjhekT8a0+sWG3qrCWiz9ml/ZSXREn4QrctOv/jGo8AyOwsgPa7GCheL
         sGJv/FgEMuYNdmD/af2bvxd6fPvYMeP7Sg1elK8FXbHE2HRIMbxIBgJ0DwUIUrFHvY5i
         Y9d74GvdrXAkOA9pV7tc5hRpeh4ZDIbDCYADAnPbSKrCwBMBblbOMjwvo9Qd+TW7+ooL
         TGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199122; x=1709803922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/MZbNUm82wJ0smN4ZI9fIXzGicdoFKBpqsdICiE+8w=;
        b=q+iaACedqkv16EksSR3MpfNfj1xRsvlbuDDLFvHQbNBzJQRDX90nIbM+NStK69eGzA
         r4TU0KoyB4FLep7WlOidLtA5EjJsK/sa+7hCv6eIXcP8XzAsDxVeDHbGSP5QKQ+dsRJt
         JL5jPzaQr/MZRVvPeBsHg/IBfo+8tZF5Xes+altvR+xmeWDCtj4yBmUgkb8Liwk5NyVv
         2fZ4Cy77ymgMvDmRIW2EoIPdAQUJDj1gXy+RfFt6epVRoZw5HLHDrH66GFEwzILH80pV
         RV6nsOIOrPv2XXtrI2wlm80yZdx8f3921LrHQorWutqqU31stvLS9GDvEcoBiIJ19NVs
         meig==
X-Forwarded-Encrypted: i=1; AJvYcCW7eAabuZJ+xw7HJb3SDyhOqK0KOI4rZAIFacbok8rSUCnpns++enuDhxpesaQ1hLaRpPUwgECOIzuIflB2OYoltKtAg08JZ40H
X-Gm-Message-State: AOJu0YyA3oV1UhSXInzOD6K+FirMfU2MJWVvZtcNQ5WODn2iwzgSY1By
	fk1hlN8t5J9R3hz99P2JDc+AV8OsoUWLADMuCC1IuBTTl2iULFpTem/FHQ0KXAqwLT/7QJi58qJ
	izFpgrev8Mzh7NYW58AGyn2r13P2T0bSzOpARrRO7JZvpAyilVQ==
X-Google-Smtp-Source: AGHT+IEcI+OzNlTqO+wq1gec5ZnsAEK9sGj+CdGnwfO2S0zJF19vgdJU5vBMHWClUBiikOWVe1MQp9GjXvVA0TX7hhc=
X-Received: by 2002:a1f:da03:0:b0:4c0:25db:3618 with SMTP id
 r3-20020a1fda03000000b004c025db3618mr1508020vkg.0.1709199122221; Thu, 29 Feb
 2024 01:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
 <Zd-AfDcQ-r04CMXk@elver.google.com> <ed828ce7-2046-4884-ab1f-d7bff3c0a714@efficios.com>
In-Reply-To: <ed828ce7-2046-4884-ab1f-d7bff3c0a714@efficios.com>
From: Marco Elver <elver@google.com>
Date: Thu, 29 Feb 2024 10:31:24 +0100
Message-ID: <CANpmjNP9ApuE+FyeSPPEJZK9Q8BdY24i8xuqhTbXEQM_d_HmcQ@mail.gmail.com>
Subject: Re: [PATCH 00/30] RSEQ node id and mm concurrency id extensions
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>, 
	linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com, carlos@redhat.com, 
	Peter Oskolkov <posk@posk.io>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Chris Kennelly <ckennelly@google.com>, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 21:01, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
[...]
> AFAIK the only project using the mm_cid concept I know of today is
> tcmalloc. It's very useful to scale data structures such as memory
> allocator arenas to the number of concurrently running threads
> within a process without having to rely on heuristics on the
> user-space side.
>
> I have plans to migrate LTTng-UST to per-ipc-namespace NUMA-aware
> mm_cid as well (after I get around to submit this extension into the
> Linux kernel) for user-space ring buffers over shared memory, but my
> current focus has been on pushing support for extensible RSEQ into
> GNU libc for the past year or so.
>
> We are getting there though:
>
> https://sourceware.org/pipermail/libc-alpha/2024-February/154390.html

Glad to see this!

> Once we have this key piece in place within GNU libc, it will become
> easier to extend rseq further because the libc will adapt to the extended
> feature set.
>
> Note that the overhead of the mm_cid assignment within the scheduler
> should be negligible after
> commit 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid").
>
> Another thing we've actively been working on is to get the "librseq"
> project [1] in shape so a copy the librseq headers can be integrated
> into the GNU libc project as internal header files. So basically
> librseq will become a GNU libc upstream. This will facilitate
> implementation of rseq critical section within GNU libc. One of
> the possible use-cases will be to move the GNU libc malloc
> implementation to per-mm_cid arenas.

I suppose if GNU libc malloc starts using it then usage would become
ubiquitous in no time.

> > I'm aware that TCMalloc was the inspiration for vCPUs [1], then renamed to
> > CIDs, but am wondering if other users are out there.
>
> I'd be curious to learn about those as well.
>
> I suspect that the lack of official release of librseq critical section
> helper headers may contribute to the fact that few applications use advanced
> rseq features at this point.

I guess you've answered my question, and I conclude "no known open
source usage yet". A simple search on Github or the likes also didn't
yield anything. I will go and check again in a year or so. ;-)

Thanks,
-- Marco

