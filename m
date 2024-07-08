Return-Path: <linux-api+bounces-1870-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79695929E14
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 10:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA6F1F21124
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 08:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA03D3B8;
	Mon,  8 Jul 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQj/i6xA"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2953BBEB
	for <linux-api@vger.kernel.org>; Mon,  8 Jul 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426295; cv=none; b=GStjw3cWeuxwxEesMO2V0jYFJ+sQmqkm15W49l0pAinWBXoOnRVfzISyPg2umk7Oa53avR/sHor53Zh8H/3+CaouVkz1tMZv33zQ3EtNoHXmZafJ03YSgOC/JGVTlBZGZadkddwYlBnweHRZ5zaqK198lpAJsl9RTJsG2sIw/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426295; c=relaxed/simple;
	bh=2oLuXobac5roJSa3IO5/5qzJKdTUjyDWzEQLC8i5HaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeYvCKmtzdTV72jAsolSdMiIhNNlphotBbUkz9ILlnXJGmha5EFXRYgjn2S3GSFN7yANJLmErDZd1PDC+UZnQdvQeID6vOqvZivBo1ZtupGPvvbCUDFNoKf1tZ9h2a2KL8dGfwDrtxKRGkvWofmNP9vhi3/FHZg/4ftOqBwg5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQj/i6xA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720426293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Gp+JU/F91iJfi0msXelpd8IVzKHprY8FUr3nyaI8s/Y=;
	b=AQj/i6xA+LYqxDIsG7aKzr3LV8xfKBA5DUMG18vctmCDJXIBjNWXZcDt3N6h6roZXon5i/
	7KZXxScnwcOO8zN06vVw8fNHN4TjmLM1z9tfsxy7Y9zZ66udZA27o9u6rBlGtPH03j9bmm
	X35Jia3m97cBPZUbyCdvCB84i7J7omU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-pq6s-uh2Pu2r4aVD6c3snw-1; Mon, 08 Jul 2024 04:11:28 -0400
X-MC-Unique: pq6s-uh2Pu2r4aVD6c3snw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77c539bfbcso246853166b.1
        for <linux-api@vger.kernel.org>; Mon, 08 Jul 2024 01:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720426287; x=1721031087;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gp+JU/F91iJfi0msXelpd8IVzKHprY8FUr3nyaI8s/Y=;
        b=WQs7vnySBLMkiN1X0JxetZ8K68UtQMSFlxP/uFh2suixSibGV/NFXd8TtjgFLNvf8R
         1rDlZ2JtgacyrOKEhSFm6RTkR/J4ZrzO6CFlRpNgAPv5zSmh/esMZIRLySgEZQgsMkNN
         6/hQSJPE7UcvWJGGke1bvA1gNolqFrzS2oBw32poGIwYcUz3/7CHctJ48PAfSQI0/cnQ
         b72K0dKBCqECpS0MYIEi1LPKLhUE2TDxSDBaMFRQOCcd3XwJJ5d2P8gnKDVMVFwp2uoG
         NdwrecxTsMcG1Va87C8vE5Jgnvs3bH1mXI0Jg5+bvfR8tLDAHxvEGWSYWLYCmUD5VKNN
         kpiw==
X-Forwarded-Encrypted: i=1; AJvYcCVH6dtNPvP07eQod1Q/UdZ/og9Dxg0KtpfHkvoXslBMK+Oy7eSIWVm1hz1I0fbVb7h7/A5yNYmGW+VFfhiZJv2AXrRsWPjBDEh7
X-Gm-Message-State: AOJu0YxBF/nAGECuCQzP1ozHYRGGtFHZR6KxAgAhYIc0R/SgFxXixeGu
	cQTbdEPsI91QG/TgOu31aUm43PHpeg61emAnhIwjycE7NBcNjwYozmPJ5L2+xui9WhNQ41DIOxR
	WUM1z6kbxD/eqaPWXCvJbPOa24foaUYZMZv7ajYXiSZ3HUCc2TGPM9g0wEg==
X-Received: by 2002:a05:6402:311c:b0:58c:adad:cbb with SMTP id 4fb4d7f45d1cf-58e5cc0b694mr5634049a12.38.1720426287092;
        Mon, 08 Jul 2024 01:11:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERhu1ncMdDmYLIvyQzpQhR84SA4zIqAfzm6r9bAw/Jyk06nNBrd+LkPTmKZbo4Xr0uenl3oQ==
X-Received: by 2002:a05:6402:311c:b0:58c:adad:cbb with SMTP id 4fb4d7f45d1cf-58e5cc0b694mr5634038a12.38.1720426286701;
        Mon, 08 Jul 2024 01:11:26 -0700 (PDT)
Received: from [100.81.188.195] ([178.24.249.36])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-593c7f2845fsm411567a12.95.2024.07.08.01.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 01:11:26 -0700 (PDT)
Message-ID: <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
Date: Mon, 8 Jul 2024 10:11:24 +0200
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
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
 <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
 <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.24 02:08, Linus Torvalds wrote:
> On Sun, 7 Jul 2024 at 14:01, David Hildenbrand <david@redhat.com> wrote:
>>
>> At least MAP_DROPPABLE doesn't quite make sense with hugetlb, but at least
>> the other ones do have semantics with hugetlb?
> 
> Hmm.
> 
> How about we just say that VM_DROPPABLE really is something separate
> from MAP_PRIVATE or MAP_SHARED..

So it would essentially currently imply MAP_ANON|MAP_PRIVATE, without 
COW (not shared with a child process).

Then, we should ignore any fd+offset that is passed (or bail out); I 
assume that's what your proposal below does automatically without diving 
into the code.

> 
> And then we make the rule be that VM_DROPPABLE is never dumped and
> always dropped on fork, just to make things simpler.

The semantics are much more intuitive. No need for separate mmap flags.

> 
> It not only avoids a flag, but it actually makes sense: the pages
> aren't stable for dumping anyway, and not copying them on fork() not
> only avoids some overhead, but makes it much more reliable and
> testable.
> 
> IOW, how about taking this approach:
> 
>     --- a/include/uapi/linux/mman.h
>     +++ b/include/uapi/linux/mman.h
>     @@ -17,5 +17,6 @@
>      #define MAP_SHARED  0x01            /* Share changes */
>      #define MAP_PRIVATE 0x02            /* Changes are private */
>      #define MAP_SHARED_VALIDATE 0x03    /* share + validate extension flags */
>     +#define MAP_DROPPABLE       0x08    /* 4 is not in MAP_TYPE on parisc? */
> 
>      /*
> 
> with do_mmap() doing:
> 
>     --- a/mm/mmap.c
>     +++ b/mm/mmap.c
>     @@ -1369,6 +1369,23 @@ unsigned long do_mmap(struct file *file,
>                          pgoff = 0;
>                          vm_flags |= VM_SHARED | VM_MAYSHARE;
>                          break;
>     +            case MAP_DROPPABLE:
>     +                    /*
>     +                     * A locked or stack area makes no sense to
>     +                     * be droppable.
>     +                     *
>     +                     * Also, since droppable pages can just go
>     +                     * away at any time, it makes no sense to
>     +                     * copy them on fork or dump them.
>     +                     */
>     +                    if (flags & MAP_LOCKED)
>     +                            return -EINVAL;

Likely we'll have to adjust mlock() as well. Also, I think we should 
just bail out with hugetlb as well.

>     +                    if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
>     +                            return -EINVAL;
>     +
>     +                    vm_flags |= VM_DROPPABLE;
>     +                    vm_flags |= VM_WIPEONFORK | VM_DONTDUMP;

Further, maybe we want to disallow madvise() clearing these flags here, 
just to be consistent.

>     +                    fallthrough;
>                  case MAP_PRIVATE:
>                          /*
>                           * Set pgoff according to addr for anon_vma.
> 
> which looks rather simple.
> 
> The only oddity is that parisc thing - every other archiecture has the
> MAP_TYPE bits being 0xf, but parisc uses 0x2b (also four bits, but
> instead of the low four bits it's 00101011 - strange).

I assume, changing that would have the risk of breaking stupid user 
space, right? (that sets a bit without any semantics)

> 
> So using 8 as a MAP_TYPE bit for MAP_DROPPABLE works everywhere, and
> if we eventually want to do a "signaling" MAP_DROPPABLE we could use
> 9.

Sounds good enough.

> 
> This has the added advantage that if somebody does this on an old
> kernel,. they *will* get an error. Because unlike the 'flag' bits in
> general, the MAP_TYPE bit space has always been tested.
> 
> Hmm?

As a side note, I'll raise that I am not a particular fan of the 
"droppable" terminology, at least with the "read 0s" approach.

 From a user perspective, the memory might suddenly lose its state and 
read as 0s just like volatile memory when it loses power. "dropping 
pages" sounds more like an implementation detail.

Something like MAP_VOLATILE might be more intuitive (similar to the 
proposed MADV_VOLATILE).

But naming is hard, just mentioning to share my thought :)

-- 
Cheers,

David / dhildenb


