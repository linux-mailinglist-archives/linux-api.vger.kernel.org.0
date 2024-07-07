Return-Path: <linux-api+bounces-1866-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2069299C4
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 23:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F00281589
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 21:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1A6026A;
	Sun,  7 Jul 2024 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJeIr0W+"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6102261D
	for <linux-api@vger.kernel.org>; Sun,  7 Jul 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720386070; cv=none; b=WULZrSNnrQxz+EEeOkqgxM7DHDxKFUoAa8loVoHyrn1NOaYzrUwAKTzojit5lboetFKmwCQb/s903b86wyrMmEMFNHFZoB7HRFiMrGCWOjkjRvBg+aqAHjOfEjmaVtnmnAnx8vAFCmhq5jPW8EYfFBliaZqNfPM2r8KIMBGGcUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720386070; c=relaxed/simple;
	bh=Okw5O240u4q+Y/Mg4iX+wPYuhJB7XxrkO8YTRVN2Dqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/qQsa79kcVytckFU0F6DdSPwWQJGtdh0Qc79aq1uF6uq9svQVqPI8CMDGy/dCZLcC1AZ+bPbSVye2hneBnXxtvZQStsN8FC2gWapge806QQV1iyC7TvE16Fsol6ZSG6CrGxJJQiqu9jVHY+9mt9I0mz9TEAIbpkP4iON0g443U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJeIr0W+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720386067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LvIWlwl8DHJhFq3or4kDUP1tA5vzdIeDCGHCo8MeNUs=;
	b=fJeIr0W+nePpFmMtf101pVH6BdqjUP2OB8NT2U9QfKl6M3RjC5XZje6ACZIQPeP8yZxUeu
	cImYl8oZPo5m1P22QJo/+vR+wRMd8OCBAUu/iCkJpvtv/s8iu17/+Q7N2rtfN2TWQSpU5a
	UIbH0x2ZBedApADQ6rUAVstoAMOIaY4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-CJDogTzONJW0j8XV6r6Glg-1; Sun, 07 Jul 2024 17:01:06 -0400
X-MC-Unique: CJDogTzONJW0j8XV6r6Glg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee8ceb0852so34850551fa.0
        for <linux-api@vger.kernel.org>; Sun, 07 Jul 2024 14:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720386065; x=1720990865;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LvIWlwl8DHJhFq3or4kDUP1tA5vzdIeDCGHCo8MeNUs=;
        b=i3RZ5h1RydaxYCBcplKUT137AX1+ni1l3eYRiExpThIvvMpba+37sP6q5JwZH9kKhu
         W0c1EryWWesupPJuxpZPTBvyDDptReUzhsgOG9bK2MCO6fzMzppROfxmzmun8wxgeBaT
         LK8vt7lG+ld4z7dlSsrbtfFGahVkLKaZmHpvi8vKfgpPGJq1p6I8lDG/ylhpmbrByIRZ
         aw9btQcxdYt6ufQ2IawRoBj7S40ZWRwsbQ6k1JX6p/YqfU7louNn59VzUQvTxZkzv2AD
         cZUhYN4IpMSbGMuUUmYDJkZbwo705bk3SRtFTUQGuUcTQnss86uF7WgmciyXVdshhg8N
         kN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEATShu44qRhlk+HFnqIbLBb/2Kw5cA5+73jWDSVbOf7NAaHTEqzCdaeTyhP0+G/Q8ZW3UOvp/DO3kSRMHylAWNDmkmmKzJG/S
X-Gm-Message-State: AOJu0YwdFFRJ3vCyVmNRkiHOKDwd70p15DJMDpdgYwAM+6q5DyKyhJlH
	vR8TJJEXoiVpR7TdHOx9C0FCsTIoAEU3S4+SNybe/DGp/UCja7VcJn9s475CLC3ck4/JF2xrLmy
	N4p7/Vu5rDIbcpnGzm9+jk8l7vNkG6Ki0WGM0wk1AAj1eF/WqXwcZRrImUA==
X-Received: by 2002:a05:651c:19a2:b0:2ec:4086:ea6d with SMTP id 38308e7fff4ca-2ee8ed5f61emr80641111fa.4.1720386064863;
        Sun, 07 Jul 2024 14:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8qeOvMCk8PQe6Rpatbp9qDgVonuvCIsKIw8dx2fcqG8CtClRo7qd9MPYVscr1v+qTwWOOJw==
X-Received: by 2002:a05:651c:19a2:b0:2ec:4086:ea6d with SMTP id 38308e7fff4ca-2ee8ed5f61emr80640981fa.4.1720386064276;
        Sun, 07 Jul 2024 14:01:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c00:10f0:d1a8:c206:17ac? (p200300cbc72f0c0010f0d1a8c20617ac.dip0.t-ipconnect.de. [2003:cb:c72f:c00:10f0:d1a8:c206:17ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266ac156easm9425895e9.38.2024.07.07.14.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 14:01:03 -0700 (PDT)
Message-ID: <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
Date: Sun, 7 Jul 2024 23:01:02 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.24 21:22, Linus Torvalds wrote:
> On Sun, 7 Jul 2024 at 11:52, David Hildenbrand <david@redhat.com> wrote:
>>
>> I recall that introducing things like MAP_SHARED_VALIDATE received a lot
>> of pushback in the past. But that was before my MM days, and I only had
>> people tell me stories about it.
> 
> I think MAP_SHARED_VALIDATE was mostly about worrying about the API impact.
> 
> And I think it worked out so well that this is probably the first time
> it has been brought up ever since ;)
> 
> That said, the *reason* for MAP_SHARED_VALIDATE is actually very
> valid: we have historically just ignored any random flags in the
> mmap() interfaces, and with shared mappings, that can be dangerous.
> 
> IOW, the real issue wasn't MAP_SHARED_VALIDATE itself, but introducing
> *other* flags that affected maps that old kernels would ignore, and
> then the worry was "now old kernels and new kernels work very
> differently for this binary".
> 
> That's technically obviously true of any MAP_DROPPABLE thing too - old
> kernels would happily just ignore it. I suspect that's more of a
> feature than a mis-feature, but..
> 
>> My understanding so far was that we should have madvise() ways to toggle
>> stuff and add mmap bits if not avoidable; at least that's what I learned
>> from the community.
> 
> It doesn't sound like a bad model in general. I'm not entirely sure it
> makes sense for something like "droppable", since that is a fairly
> fundamental behavioral thing. Does it make sense to make something
> undroppable when it can drop pages concurrently with that operation?
> 
> I mean, you can't switch MAP_SHARED around either.
> 
> The other bits already _do_ have madvise() things, and Jason added a
> way to just do it all in one go.

I just recalled that with MAP_HUGETLB, bits [26:31] encode a hugetlb
size (see include/uapi/asm-generic/hugetlb_encode.h). hugetlb, the gift
that keeps on giving.

We're using:

+#define MAP_WIPEONFORK		0x08000000	/* Zero memory in child forks. */
+#define MAP_DONTDUMP		0x10000000	/* Do not write to coredumps. */
+#define MAP_DROPPABLE		0x20000000	/* Zero memory under memory pressure. */

Which should be bit 27-29.

So using these flags with MAP_HUGETLB will result in surprises.

At least MAP_DROPPABLE doesn't quite make sense with hugetlb, but at least
the other ones do have semantics with hugetlb?

It's late Sunday here in Germany, so I might just have messed something up.

Just raising that there might be a "bit" conflict.

-- 
Cheers,

David / dhildenb


