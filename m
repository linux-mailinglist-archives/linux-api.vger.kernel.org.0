Return-Path: <linux-api+bounces-2536-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DADBC9AC34D
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2024 11:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927011F24749
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2024 09:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2A6194136;
	Wed, 23 Oct 2024 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDl5N70k"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650B4503C
	for <linux-api@vger.kernel.org>; Wed, 23 Oct 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675040; cv=none; b=opn7eWaWTz95tf0KcH5GgKZya+Z97+GdHirgddA54LoaKkLDESI5oZJglLGwSzi/RGei9SERxfr/UvG2ULUdseHO9/AQaKAr/LieZA5qdxGxheVe//eZuz2tUiGKNpdHaPw0IviMPWiTShMtT5kCt05yTq+slnkJxPW4srQdZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675040; c=relaxed/simple;
	bh=wtB++VIztt5HrzVDtGHAG03WXfiePjTR9YlbhZgm7nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPz33YJeYm2/Z3s65eO1iPFr6iqKHFQekwHnSH9NHaRgTK6vr++Jjz7XXvOsLBOpT0BxFKqJMC/v5Lg+qgjzQnaEe4zYfZAkpESgoHN36Kv7o8xbeNMBsQIiGHY6zJlNCRU3PTyzBqK5P0yXtUygNapoWewXAxKzvZPOYfaAxYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDl5N70k; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb561f273eso65192901fa.2
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2024 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729675036; x=1730279836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtB++VIztt5HrzVDtGHAG03WXfiePjTR9YlbhZgm7nk=;
        b=cDl5N70kW4qZ92fU3zt9XzrqqbmPXBPAR1397nRyl8QFe2280rQWAEVMnPnOEXfzyr
         CQpf7IerO4IQRmZyROB25M4v5cD3bVyixJ5PzTMGla2pzMQVv5VW8hzCmXOsF4t6ALCC
         DEIP6658YoISqPJGBgq3GUyOdtkIAl56f80J0yMCifAAEvXP5xKzmLelybI1sYAr5O7y
         jU6Qsij7SkfqYVzwMcn1rxlneUor0LXCkfbq8yH1mYfKkHgAwtzAJVjtE/PR9q02FFi4
         8/JCQU8rMY8y2ILwvD+NB30kGipYxS5zfVYnZCAGbf1HjbASG4cyELEU9wcnJRsI8mU2
         80/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675036; x=1730279836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtB++VIztt5HrzVDtGHAG03WXfiePjTR9YlbhZgm7nk=;
        b=FuhkD6HHKFbeVmO2qG18PEgjalQaq2aAatfnBQh0951SRn936Padwld6xhlU73sVPz
         8UrBGg3gCjhiQvWOaZp97lyYLzvHHqKPwptP411u910Tv7K2ximYWPtA0y1jCL23HGLv
         SE0FaMU/qwtp92tZkl2qYlyMFEAMnk8aWhO/PgC3AYvxPeWsZjtDKBO/C2xrBBlaySC+
         aArDYClnKsNtU+355FAGjiDTw4tfBgXMV1eEw9rZJJaVj4FIUknQHLGwssmxGk3rMb7Z
         LsBaJScXzvZx2+1hecN+Lj4yVsj7LylOHDzjFG6tXUQgOKBulcQ+6frWwA9US1zA+d8Y
         Il2A==
X-Forwarded-Encrypted: i=1; AJvYcCXXOFDhac7snnfPPxih1L/Oz2KdJQrJPLxD+Zu+gJEpUYlTE1zMhZ720sbfj/Pmx/NG28OkA0Frm40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHR8vQQLZ6OUD3F+p1MDX9r0fc2qHOcQSMHY9Zd8oFfEb1ZkOI
	57vDapqwKVXPQ024kMJZEy47weZN9D7ghZ+/ize0dDdpOgC6mRMKs4cOzqhGnqn7VJ8Qk72yAI4
	DOZoSnV3TjWiXnzGyDQ8KI9WuVBb+Afkrvqbe
X-Google-Smtp-Source: AGHT+IFvkPWDLHQT3Gtx5JJGGOJecwZ7B/rbkd7cgrlXZ9fP+lFzPxCiaYSOPYzYujteUjqgXjdomewJxB+DT79mLAc=
X-Received: by 2002:a2e:a9a6:0:b0:2fb:565a:d93c with SMTP id
 38308e7fff4ca-2fc9d33a85emr9429421fa.1.1729675036276; Wed, 23 Oct 2024
 02:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a5eysmj1.fsf@mid.deneb.enyo.de> <20241023062417.3862170-1-dvyukov@google.com>
 <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com> <5a3d3bc8-60db-46d0-b689-9aeabcdb8eab@lucifer.local>
 <CACT4Y+ZE9Zco7KaQoT50aooXCHxhz2N_psTAFtT+ZrH14Si7aw@mail.gmail.com> <b1df934e-7012-4523-a513-d3d1536b7f72@suse.cz>
In-Reply-To: <b1df934e-7012-4523-a513-d3d1536b7f72@suse.cz>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 23 Oct 2024 11:17:05 +0200
Message-ID: <CACT4Y+Z=fjoOxn8NY8kYJd2CC1SkmjkmAmqSzJbQiU04G=BEvw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, fw@deneb.enyo.de, 
	James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org, 
	chris@zankel.net, deller@gmx.de, hch@infradead.org, ink@jurassic.park.msu.ru, 
	jannh@google.com, jcmvbkbc@gmail.com, jeffxu@chromium.org, 
	jhubbard@nvidia.com, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org, mattst88@gmail.com, 
	muchun.song@linux.dev, paulmck@kernel.org, richard.henderson@linaro.org, 
	shuah@kernel.org, sidhartha.kumar@oracle.com, surenb@google.com, 
	tsbogend@alpha.franken.de, willy@infradead.org, elver@google.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 11:06, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/23/24 10:56, Dmitry Vyukov wrote:
> >>
> >> Overall while I sympathise with this, it feels dangerous and a pretty major
> >> change, because there'll be something somewhere that will break because it
> >> expects faults to be swallowed that we no longer do swallow.
> >>
> >> So I'd say it'd be something we should defer, but of course it's a highly
> >> user-facing change so how easy that would be I don't know.
> >>
> >> But I definitely don't think a 'introduce the ability to do cheap PROT_NONE
> >> guards' series is the place to also fundmentally change how user access
> >> page faults are handled within the kernel :)
> >
> > Will delivering signals on kernel access be a backwards compatible
> > change? Or will we need a different API? MADV_GUARD_POISON_KERNEL?
> > It's just somewhat painful to detect/update all userspace if we add
> > this feature in future. Can we say signal delivery on kernel accesses
> > is unspecified?
>
> Would adding signal delivery to guard PTEs only help enough the ASAN etc
> usecase? Wouldn't it be instead possible to add some prctl to opt-in the
> whole ASANized process to deliver all existing segfaults as signals instead
> of -EFAULT ?

ASAN per se does not need this (it does not use page protection).
However, if you mean bug detection tools in general, then, yes, that's
what I had in mind.
There are also things like stack guard pages in libc that would
benefit from that as well.

But I observed that some libraries intentionally use EFAULT to probe
for memory readability, i.e. use some cheap syscall to probe memory
before reading it. So changing behavior globally may not work.

