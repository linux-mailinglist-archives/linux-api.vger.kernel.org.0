Return-Path: <linux-api+bounces-1864-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EBA92995E
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46281C20890
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 18:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10861FED;
	Sun,  7 Jul 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHlmbpGb"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC81429B
	for <linux-api@vger.kernel.org>; Sun,  7 Jul 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720378383; cv=none; b=l1pOFe/l2nahMhvAceqmXBGW8GRI4V+bciyr5OAg1AEASGBIgkMIsXeseAxlhYM+WZsAvgf9zVo+LpTDwaPZEEw2L0ASF3GAE6Y3lFxL+7dCXWDUEfoaCUYF3qrECt8ufnxsUwwoBnGvLx/bEwxkct9sw8MNmVDE2+j8DoQKO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720378383; c=relaxed/simple;
	bh=JPYfc9BF9H6U8dBUeojkHLEGzFVngwZiApOd1lH/wrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joCnchuedKWvFJPtMb3IsG5gHpxwD3R7928VQRD9vNk9mrpXq6DDJxPvpE6jczdVQLTvsITny3/KmmwddJiZw+I+yKU2TL56BoZW7zPji7MmoHLhn5hOspTjBZGSu92Lt+n7Txqxam6Y2Y+BF9CSk+M47BqW0gTQZ1yyrt3qrwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHlmbpGb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720378380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3zm/t6SmOseYv8YEoerUNFcg810f9Fqt/p2xQiipACY=;
	b=UHlmbpGbrnpuoiXi9F5s20Ni10PHvlHx2Q8+ATRQP9XU1B4eQ5J2UBjNs8lE3MznyaCdvX
	rH43unDARqLPemIIs/UDTn+B+4lZSggch+Db/yXdYtFYRw6RnLQO499Jai8cQTQCGVe28x
	IQjrrhxgsfzyEupsLi+1pHuMr3tkbwQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-rOk8rYdHNwy0cTqW3Z0qfw-1; Sun, 07 Jul 2024 14:52:54 -0400
X-MC-Unique: rOk8rYdHNwy0cTqW3Z0qfw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42668796626so2639195e9.0
        for <linux-api@vger.kernel.org>; Sun, 07 Jul 2024 11:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720378373; x=1720983173;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3zm/t6SmOseYv8YEoerUNFcg810f9Fqt/p2xQiipACY=;
        b=pBBBCP7QRqX11EqQx3hScxbCksMKAQhIcxJgww4Y4RtZr+81uT/Jwgqn/FtvrHLky3
         yAzTyB0WmNw34LSAOsnb8eKt+CcQJSgAu+y/EHNpzqSfmfa+TtkuhGTHiRP42oR0vPsk
         uGCsp9ASv/DiFyOYnpWQ7BsPWo9n+0iboBAxw8Aj9Nh4lEpoeOuewni2Ll6mv7GvIm7T
         52jBAQxJSALeedPrMClDY6YH5rb+0zxlZMpC/QI0qjgcCd5n6lYKMWJ6O7m1yoQ23JiO
         v1m/ofinbjFxX5Mr3R4L4esD0ZKX6xbDkGwKHKAMv5DUIYVE0I81quQPK2UU/Sj1mnlh
         h3aw==
X-Forwarded-Encrypted: i=1; AJvYcCXV10FQbiLCpRRQSHHaJJJAhe0Vrk/Xs/IezcZ9EsSCzoMPiNr5a69OfDxik9tGTZY46WZgLswC0mX5RHqe4zF4us/069Gb8048
X-Gm-Message-State: AOJu0YyU8AVRWL4dNZD23QcIpjQEdNY/6P9SXac28lu9ewOcsi4aOb1D
	MTyrnw6YUnC9pVvAsKNesVZB0ybgtkDK80kfoCU2nSGf1Cm0j4HkL/YlWreA2luJ8RYFKGSZklR
	EaoPeLWu15Q0JYHpX4YRqeliW03ev3jAOoSE7H5LLHa3NkBKh8xkmy956tg==
X-Received: by 2002:a05:600c:4b2a:b0:426:5f7d:add3 with SMTP id 5b1f17b1804b1-4265f7db016mr30227515e9.36.1720378373220;
        Sun, 07 Jul 2024 11:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHUegYzLDxKbbpZ/irMi+0ltYebxXLPy6KTsfxhiulXv6hHieExZTRA+QgATdClvaAzH0XLQ==
X-Received: by 2002:a05:600c:4b2a:b0:426:5f7d:add3 with SMTP id 5b1f17b1804b1-4265f7db016mr30227425e9.36.1720378372763;
        Sun, 07 Jul 2024 11:52:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c00:10f0:d1a8:c206:17ac? (p200300cbc72f0c0010f0d1a8c20617ac.dip0.t-ipconnect.de. [2003:cb:c72f:c00:10f0:d1a8:c206:17ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367960deabdsm11055402f8f.24.2024.07.07.11.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 11:52:52 -0700 (PDT)
Message-ID: <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
Date: Sun, 7 Jul 2024 20:52:51 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, tglx@linutronix.de, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
 <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.24 20:19, Linus Torvalds wrote:
> On Sun, 7 Jul 2024 at 00:42, David Hildenbrand <david@redhat.com> wrote:
>>
>> But I don't immediately see why MAP_WIPEONFORK and MAP_DONTDUMP have to
>> be mmap() flags.

Hi Linus,

> 
> I don't think they have to be mmap() flags, but that said, I think
> it's technically the better alternative than saying "you have to
> madvise things later".

Having the option to madvise usually means that you can toggle it on/off 
(e.g., MADV_DONTFORK vs. MADV_DOFORK). Not sure if having that option 
could be valuable here (droppable) as well; maybe not.

> 
> I very much understand the "we don't have a lot of MAP_xyz flags and
> we don't want to waste them" argument, but at the same time
> 
>   (a) we _do_ have those flags
> 
>   (b) picking a worse interface seems bad
> 
>   (c) we could actually use the PROT_xyz bits, which we have a ton of
> 

I recall that introducing things like MAP_SHARED_VALIDATE received a lot 
of pushback in the past. But that was before my MM days, and I only had 
people tell me stories about it.

(and at LSF/MM it's been a recurring theme that if you want to propose 
new MMAP flag, you're going to have a hard time)

> And yes, (c) is ugly, but is it uglier than "use two system calls to
> do one thing"? I mean, "flags" and "prot" are just two sides of the
> same coin in the end, the split is kind of arbitrary, and "prot" only
> has four bits right now, and one of them is historical and useless,
> and actually happens to be *exactly* this kind of MAP_xyz bit.

Yeah, I always had the same feeling about prot vs. flags.

My understanding so far was that we should have madvise() ways to toggle 
stuff and add mmap bits if not avoidable; at least that's what I learned 
from the community.

Good to hear that this is changing. (or it's just been an urban myth)


I'll use your mail as reference in the future when that topic pops up ;)


Maybe, historically we used madvise options so it's easier to sense 
which options the current kernel actually supports. (e.g., let mmap() 
succeed but let a separate madvise(MADV_HUGEPAGE) etc. fail if not 
supported by the kernel; no need to fail the whole operation).

> 
> (In case it's not clear, I'm talking about PROT_SEM, which is very
> much a behavioral bit for broken architectures that we've actually
> never implemented).

Yeah.

> 
> We also have PROT_GROSDOWN and PROT_GROWSUP , which is basically a
> "match MAP_GROWSxyz and change the mprotect() limits appropriately"

It's the first time I hear about these two mprotect() options, thanks 
for mentioning that :)

> 
> So I actually think we could use the PROT_xyz bits, and anybody who
> says "those are for PROT_READ and PROT_WRITE is already very very
> wrong.
> 
> Again - not pretty, but mappens to match reality.
> 
>> Interestingly, when looking into something comparable in the past I
>> stumbled over "vrange" [1], which would have had a slightly different
>> semantic (signal on reaccess).
> 
> We literally talked about exactly this with Jason, except unlike you I
> couldn't find the historical archive (I tried in vain to find
> something from lore).

Good that you discussed it, I primarily scanned this patch set here only.

I took notes back when I was looking for something like VM_DROPPABLE 
(also, being more interested in the non-signal version for a VM cache 
use case).

> 
>    https://lore.kernel.org/lkml/CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com/
> 
> I do think that a "explicit populate and get a signal on access" is a
> very valid model, but I think the "zero on access" is a more
> immediately real model.
> 
> And we actually have had the "get signal on access" before: that's
> what VM_DONTCOPY is.
> 
> And it was the *less* useful model, which is why we added
> VM_WIPEONCOPY, because that's the semantics people actually wanted.
> 
> So I think the "signal on thrown out data access" is interesting, but
> not necessarily the *more* interesting case.

Absolutely agreed.

> 
> And I think if we do want that case, I think having MAP_DROPPABLE have
> those semantics for MAP_SHARED would be the way to go. IOW, starting
> off with the "zero on next access after drop" case doesn't make it any
> harder to then later add a "fault on next access after drop" version.
> 
>> There needs to be better reasoning why we have to consume three mmap
>> bits for something that can likely be achieved without any.
> 
> I think it goes the other way: why are MAP_xyz bits so precious to
> make this harder to actually use?

If things changed and we can have as many as we want, good!

Things like MADV_HUGEPAGE/MADV_MERGEABLE might benefit from a mmap flag 
as well.

-- 
Cheers,

David / dhildenb


