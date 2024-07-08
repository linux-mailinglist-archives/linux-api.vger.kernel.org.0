Return-Path: <linux-api+bounces-1871-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CA6929E3B
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 10:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FE6B22CE5
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD303DBBF;
	Mon,  8 Jul 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVb2Xeaq"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266138FB0
	for <linux-api@vger.kernel.org>; Mon,  8 Jul 2024 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720427000; cv=none; b=r6mozhfKI7Hl/YKr0Xs2jF6KM5FRjz8hGGi5gULxVz6udHSqgLib+3YF9X0boBGA6tHeeSIIj/Irk6kEpHCYpfCT6hCjmj1K7FxRYd066kGaqt8GdJC26Kzy/A5/7DzQzO6cyL72DW+wVt4lOz3W6AsYk9ZVixbkbJE7JZj3Teg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720427000; c=relaxed/simple;
	bh=u9mN5ZVUNKs/SnqYF+TXngxMJE/RrZZ3YGgiYU4pUlc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fxxIjLqwGy4zx+n+pZ8YVC1N9Tk8T3KCVMuFbbRJbGr5VtD0ylrDutfk79EQ646Tn7M5IORRi8jOEIGWJbe3pQVP0mN24smetcUmLzU+AX131r/st0KVSPpeWOEet+GdBDWKhTiVb0IS40PZGck4vVO9ggKtmWxbUki3FwgxYZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVb2Xeaq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720426997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MFZguN8EVoK7OymJmQKuCA2IoYCB5NF4rjLMBNd7sSM=;
	b=CVb2XeaqwoofH6LynmhyPWcPROBzLZJ95x1xLZt7bVaCXGFX6AEK6z0h77S7zXlWPuoYiJ
	yFEUi0w1rczkOJB0CkmErR9OLdc5WpYBc+1eRvt22KLFcTCj649UIwR2uZ9T/rJK42OkR8
	D+cJy4iw3A/nDvmFydqwd0ksZI2q+4Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-8r7PlrCVP8uphQ_5D7tO1g-1; Mon, 08 Jul 2024 04:23:15 -0400
X-MC-Unique: 8r7PlrCVP8uphQ_5D7tO1g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57851ae6090so3262397a12.3
        for <linux-api@vger.kernel.org>; Mon, 08 Jul 2024 01:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720426994; x=1721031794;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MFZguN8EVoK7OymJmQKuCA2IoYCB5NF4rjLMBNd7sSM=;
        b=THILHPIcmgjDJdX050S9/4nVA1dFbn7STmECbACQuiNB8dO7+OBQoELhiyemjDzB0l
         3C0Qt53RaQQr3wmRAdY6CgCmvTpa0Z1QHSYEhRqk1jQlqPXBReC+05zWcAKSHizVxDXS
         MXj7HJ6SeVhDhEHJPZ/4LxpN4TD/hHIlj6o5h6cAha6asTixbHNmbJUxq/yPahNIR2Po
         Vc0t2qWZrkTTcT/ETjjLLQKac5TZBrdWvSjUjfNWexi9nOI89PYYqeVCQ5zUMkEzfHhF
         c8ePD8JDP4XL3p/lLiK1j10FovOJMAi68BRCim51gkVG0ymLczd3xkTbYwp4ElhEDI+i
         zADA==
X-Forwarded-Encrypted: i=1; AJvYcCWZcJHowGJx8SQj/fWfWQ9vf8+85GaQ90Ev5pr6nf+gP6UC+efDTFy4gsXq0UN5sb849TJtXU0BXs0MP3vRj9um/2Qn4wrQr5qt
X-Gm-Message-State: AOJu0YxAf5GTZXEvEKe8Eyfk05Jo2qQjpfMAXvNSCBE/xpylBR/o3EOI
	sbam/STyZBOstPrKp9HSmbV8ORfk5lZ/YL+wvBOKHxgPFTaES/jDP0yX3AxVSi0o1v+2Am0gLy2
	otdvOIqeaYapPG0Qjm9pIzbHubfVDwjnUJ+FRWiQ6V1ZnOEk7FoTk1qd95g==
X-Received: by 2002:a05:6402:1ed4:b0:57d:466a:246 with SMTP id 4fb4d7f45d1cf-58e5a8e8d16mr7877319a12.8.1720426994411;
        Mon, 08 Jul 2024 01:23:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI7JB2DQx/fSTi7SMHizXA4YiB8BrliEg6vtno1cAdZYwZNeZhUcg0gPX1yenfeB1h1VEyFg==
X-Received: by 2002:a05:6402:1ed4:b0:57d:466a:246 with SMTP id 4fb4d7f45d1cf-58e5a8e8d16mr7877294a12.8.1720426993994;
        Mon, 08 Jul 2024 01:23:13 -0700 (PDT)
Received: from [100.81.188.195] ([178.24.249.36])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58fe866155esm3527497a12.20.2024.07.08.01.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 01:23:13 -0700 (PDT)
Message-ID: <8bf64731-9e5c-4c8c-b46b-5b18ae3110a1@redhat.com>
Date: Mon, 8 Jul 2024 10:23:10 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
From: David Hildenbrand <david@redhat.com>
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
 <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> As a side note, I'll raise that I am not a particular fan of the
> "droppable" terminology, at least with the "read 0s" approach.
> 
>   From a user perspective, the memory might suddenly lose its state and
> read as 0s just like volatile memory when it loses power. "dropping
> pages" sounds more like an implementation detail.

Just to raise why I consider "dropping" an implementation detail: in 
combination with a previous idea I had of exposing "nonvolatile" memory 
to VMs, the following might be interesting:

A hypervisor could expose special "nonvolatile memory" as separate guest 
physical memory region to a VM.

We could use that special memory to back these MAP_XXX regions in our 
guest, in addition to trying to make use of them in the guest kernel, 
for example for something similar to cleancache.

Long story short: it's the hypervisor that could be effectively 
dropping/zeroing out that memory, not the guest VM. "NONVOLATILE" might 
be clearer than "DROPPABLE".

But again, naming is hard ... :)

-- 
Cheers,

David / dhildenb


