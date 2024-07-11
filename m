Return-Path: <linux-api+bounces-1937-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4A92EE24
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377231F22B9A
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 17:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DDD16D33D;
	Thu, 11 Jul 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="axeJvRzv"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55216CD30
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720660; cv=none; b=sygihiShRqLtwtA9KhPBb5fQcu1yht+YEyNjo5Z0GIej6RRGcyUYSwsg6mFp/lPeOceh+POjrhxEvjO0iLyT8Hl8S6tp4rrOyvffc0NU0atdUGQB0q4cRlBFZwlo1bnuOSOGeoYhy6DGZjiUUzkemEl4bMA7ggI6rlkkaPNzNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720660; c=relaxed/simple;
	bh=vvosbZQCROt/9gCUMQ9029yo2M/stCbxLACDG7WVvAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dw4L7XqsN15FPIB0sc7HH+8FLRT6z/mG34HwisYyhNp+tnkOiboJ7IQFwpVPUaJnO6PNhF5Mokc7bKOf1mW8D0XC+n6t+dYQFEC3e507uNgnPv3Iv/3IkBS9VWcZumZsn85PYxBL2ghQmU8K3XY1q4IUQlrtIW0I1Z3nI0SfLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=axeJvRzv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77cc44f8aaso77713066b.3
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720720657; x=1721325457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd/aM4WVpnq9dMpWhQNC6P88qoE7zzksarngsyWfv5Y=;
        b=axeJvRzvPk4Kn4UUdvRfrWjQMeJRJkW8tkxmypbmoredEsuE8Oz69/End262U+m/Z3
         h439clMal+qG3q49R9sIUgcVkDmhZVoOURzd5HRWNHdwZKgmHwckWPmtIes9/aRjgtuH
         s+itXN/qvbkvIgMPnHAZbYMZKasM9S1uZ53WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720657; x=1721325457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hd/aM4WVpnq9dMpWhQNC6P88qoE7zzksarngsyWfv5Y=;
        b=aHDfR93Nbsfqa/39hdwot9q35F37CiT0mMxWRwhG1WHdNNREixazrtOSOV2pUYzifa
         fuoLm2CSH2Z2ahJcK91TkerUH4PrHax2Rqw672uUrTHcg4zIH49iQdzBakO+N7H6JM4d
         UQ6/QrlvpAfIqkKMxPCkxfeVM8nkeOV6Yjgt3ey1gQoC1K/TPCFh8754NdReA5ZREnrr
         20gHCf6SKlOrID+ZU16gR1XaxGWXHdQq+jE+dVs0RvPJQPHvbZ4kBVXIrOkzMNB+n1D5
         ztCMyP1n3raKLH/fp0r4H6oeXlbr81Adi4RJg4y44qIB0Zv0qScBvqDR/VAzRDc6UNcG
         bABQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4YhnlmoEHViOKNdRyrkTQ557n2yMv+22CkWKW5wbUXRg/XXSxkp2p+E6KqjC/RdbPEjs8X30hMRrJSwtM8sW269iqXlJsHz/I
X-Gm-Message-State: AOJu0YwasbdvPqxrGR72zq8obkF3yGcZrnjuakLDr50mIHJYDFqhWGCI
	ve1J+J/31ThL0h5DnV40Gy8ekD/YMAwtJmSSAmoVhhYuyU6TUpHhJ71Kc/YpA7h1mCpSYtqj4PP
	NllfFjw==
X-Google-Smtp-Source: AGHT+IEW4sE/blqGkKR5rGHNo7bnsfqIplMFELsWrasVcrH6OEIrd7Qx+iZCQwn3JyinI08STUOVXg==
X-Received: by 2002:aa7:c699:0:b0:58a:fa6e:9dae with SMTP id 4fb4d7f45d1cf-594bb180660mr7400987a12.15.1720720657099;
        Thu, 11 Jul 2024 10:57:37 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bda30839sm3696975a12.87.2024.07.11.10.57.35
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 10:57:36 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77d876273dso93296466b.0
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 10:57:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsBE9TZlnGqwUeq7iW1hGucGP0IPlnuwsyAZZDHcpvg64cpb7cySEPYCa1F7xZALLWUvMNsYHkhZDcmU3ae3oBaBqJ01w0xjpM
X-Received: by 2002:a05:6402:50c7:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-594bab80624mr9962641a12.5.1720720655663; Thu, 11 Jul 2024
 10:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709130513.98102-1-Jason@zx2c4.com> <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com> <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com> <Zo9gXAlF-82_EYX1@zx2c4.com> <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com> <ZpAR0CgLc28gEkV3@zx2c4.com>
In-Reply-To: <ZpAR0CgLc28gEkV3@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jul 2024 10:57:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGE_w46zVk=7S0zOcWv4Dp3EYtuJtzU92ab3pSnnmpHw@mail.gmail.com>
Message-ID: <CAHk-=whGE_w46zVk=7S0zOcWv4Dp3EYtuJtzU92ab3pSnnmpHw@mail.gmail.com>
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 10:09, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> When I was working on this patchset this year with the syscall, this is
> similar somewhat to the initial approach I was taking with setting up a
> special mapping. It turned into kind of a mess and I couldn't get it
> working. There's a lot of functionality built around anonymous pages
> that would need to be duplicated (I think?).

Yeah, I was kind of assuming that. You'd need to handle VM_DROPPABLE
in the fault path specially, the way we currently split up based on
vma_is_anonymous(), eg

        if (vma_is_anonymous(vmf->vma))
                return do_anonymous_page(vmf);
        else
                return do_fault(vmf);

in do_pte_missing() etc.

I don't actually think it would be too hard, but it's a more
"conceptual" change, and it's probably not worth it.

> Alright, an hour later of fiddling, and it doesn't actually work (yet?)
> -- the selftest fails. A diff follows below.

May I suggest a slightly different approach: do what we did for "pte_mkwrite()".

It needed the vma too, for not too dissimilar reasons: special dirty
bit handling for the shadow stack. See

  bb3aadf7d446 ("x86/mm: Start actually marking _PAGE_SAVED_DIRTY")
  b497e52ddb2a ("x86/mm: Teach pte_mkwrite() about stack memory")

and now we have "pte_mkwrite_novma()" with the old semantics for the
legacy cases that didn't get converted - whether it's because the
architecture doesn't have the issue, or because it's a kernel pte.

And the conversion was actually quite pain-free, because we have

  #ifndef pte_mkwrite
  static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
  {
        return pte_mkwrite_novma(pte);
  }
  #endif

so all any architecture that didn't want this needed to do was to
rename their pte_mkwrite() to pte_mkwrite_novma() and they were done.
In fact, that was done first as basically semantically no-op patches:

   2f0584f3f4bd ("mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()")
   6ecc21bb432d ("mm: Move pte/pmd_mkwrite() callers with no VMA to _novma()")
   161e393c0f63 ("mm: Make pte_mkwrite() take a VMA")

which made this all very pain-free (and was largely a sed script, I think).

> -                   !pte_dirty(pte) && !PageDirty(page))
> +                   !pte_dirty(pte) && !PageDirty(page) &&
> +                   !(vma->vm_flags & VM_DROPPABLE))

So instead of this kind of thing, we'd have

> -                   !pte_dirty(pte) && !PageDirty(page))
> +                   !pte_dirty(pte, vma) && !PageDirty(page) &&

and the advantage here is that you can't miss anybody by mistake. The
compiler will be very unhappy if you don't pass in the vma, and then
any places that would be converted to "pte_dirty_novma()"

We don't actually have all that many users of pte_dirty(), so it
doesn't look too nasty. And if we make the pte_dirty() semantics
depend on the vma, I really think we should do it the same way we did
pte_mkwrite().

Long-term, maybe we should just aim to always pass in the vma to the
pte_xyz() functions, but...

          Linus

