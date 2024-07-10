Return-Path: <linux-api+bounces-1920-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DA392C97A
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2024 06:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B354283DEF
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2024 04:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A32D2BB04;
	Wed, 10 Jul 2024 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEp9Y60L"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596304AEE0
	for <linux-api@vger.kernel.org>; Wed, 10 Jul 2024 04:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584345; cv=none; b=GGdwPX67132bk7qLyjwGidL8AwgqyTBvY98oDAOFlEHITqPyaq1c8iFgi9KQpP1rEm+UNPCSl7JbCu/f/lB/clFek5F4bnWmTZd6reKdOvH0N7M8CO7fukuo8xCgVQPGnkaAuDGTsEPTKMPyhLlj9sO5IxPZjHSMLZtK9LfwnXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584345; c=relaxed/simple;
	bh=N1DLSASEZAN3kKjigTdMNNTl81NLknNxhrYdWutM44Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=afEq5y/hohTm2HHErOVf7guTQtEND93fNZ5ozVu+tMaRi80moGOJL8suxvcxMjfuhGTMyVROVzBlWDGcOrx1BFO0AlxmyizkuzTvBkth31CPOHrOxoa2QH5XqRe53aZAYv87OM8SnIjr8H2ghg1RpcAG7TryWVt5F2j/seZWqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEp9Y60L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720584341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DmsPM2YP83ayw/MNMYnl2BCj1FnEks7yViZlukNd1Wc=;
	b=SEp9Y60LQYrv8vSenSPHDb96jWNsjBM1AvUp2zPJd/c+zdDznf/sMQRRtSTWBRhdFcnY2e
	0p4ZRhI1c+InAkiSXGP3DuX7Ap8jCV/Nk4r6sO+KOtvDDY7TkvWqloGQnBuNl8IV1IM+1w
	5ClR8eIuvLuf9Tjaiwlt1VpMsQq84nw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-889cXSZGMAODZeG-xUZRnw-1; Wed, 10 Jul 2024 00:05:40 -0400
X-MC-Unique: 889cXSZGMAODZeG-xUZRnw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3d9e10444fcso12243b6e.2
        for <linux-api@vger.kernel.org>; Tue, 09 Jul 2024 21:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720584339; x=1721189139;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DmsPM2YP83ayw/MNMYnl2BCj1FnEks7yViZlukNd1Wc=;
        b=YnMAiO8GsBhyldFmUwiPwElrHZihcD8y4pp1dx/+6wbo6opX61PeBYlyQEppPXhXoc
         7sqYvRvdhHyAQ3h62FL+KEwbuBScVJ9713z5flbV6lFPgj+0FTrHsrSUOI7xLN6qCiFN
         jAV5hRQTX3lcnLN3clCLdCVHnxts293KhF7z/HKYp20MlhJeMhvfDMb85jeZjCd40LSs
         QMEl5AGsqDgp/Hr+UfElMA/f6MLhN1e3wZgh8P5hg4Ft8wNbTUnaXHUyZsuwlzGq4WJi
         D1ELNzMVh24kn9a8rAtWzqLWdoIa66B+Ocz4luyUb8VIIAQEfA8I+UOMP4ZUWCsd7LU2
         /1ng==
X-Forwarded-Encrypted: i=1; AJvYcCVS6QlfKmnpRvWlOdPXuDtWBxdhLKUMpa+Jt0KSYCi5Az7Oe4Z8/fVNuaV3twf0NQ4ND78NXCcPZgq+p9hF8bcN85d91bxU4yAy
X-Gm-Message-State: AOJu0Yx3zFEf/NJQ4Sw/GJ/xUYkmmaKWDCQWbqsEgj0j2wQgdd+1R85h
	f6rOtU/4v/HeJm0CxCYbL2rdI4BUvIHmkKM1SZ7WXGrTRfclqNZf+csLAcoJ7a4frEll8FYKCMg
	kBqXxW7f8MY8W8T9X0b1wQgZuDhZpAMwSYvcwREu1SWKIpkxYlpl0n7pqkw==
X-Received: by 2002:a05:6808:14c5:b0:3d6:32be:a8a5 with SMTP id 5614622812f47-3d93bee56ddmr5526566b6e.4.1720584339224;
        Tue, 09 Jul 2024 21:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgdLnkHjsM7KRqdvsvUHsf1OJloSf5RcHmhVmwnIt7ECNqQrB5n6pEpzefYp+WqCn1g6D/tg==
X-Received: by 2002:a05:6808:14c5:b0:3d6:32be:a8a5 with SMTP id 5614622812f47-3d93bee56ddmr5526539b6e.4.1720584338879;
        Tue, 09 Jul 2024 21:05:38 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4396740asm2662984b3a.105.2024.07.09.21.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 21:05:36 -0700 (PDT)
Message-ID: <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
Date: Wed, 10 Jul 2024 06:05:34 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
From: David Hildenbrand <david@redhat.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, tglx@linutronix.de
Cc: linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <20240709130513.98102-1-Jason@zx2c4.com>
 <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.24 05:27, David Hildenbrand wrote:
> On 09.07.24 15:05, Jason A. Donenfeld wrote:
>> The vDSO getrandom() implementation works with a buffer allocated with a
>> new system call that has certain requirements:
>>
>> - It shouldn't be written to core dumps.
>>     * Easy: VM_DONTDUMP.
>> - It should be zeroed on fork.
>>     * Easy: VM_WIPEONFORK.
>>
>> - It shouldn't be written to swap.
>>     * Uh-oh: mlock is rlimited.
>>     * Uh-oh: mlock isn't inherited by forks.
>>
>> It turns out that the vDSO getrandom() function has three really nice
>> characteristics that we can exploit to solve this problem:
>>
>> 1) Due to being wiped during fork(), the vDSO code is already robust to
>>      having the contents of the pages it reads zeroed out midway through
>>      the function's execution.
>>
>> 2) In the absolute worst case of whatever contingency we're coding for,
>>      we have the option to fallback to the getrandom() syscall, and
>>      everything is fine.
>>
>> 3) The buffers the function uses are only ever useful for a maximum of
>>      60 seconds -- a sort of cache, rather than a long term allocation.
>>
>> These characteristics mean that we can introduce VM_DROPPABLE, which
>> has the following semantics:
>>
>> a) It never is written out to swap.
>> b) Under memory pressure, mm can just drop the pages (so that they're
>>      zero when read back again).
>> c) It is inherited by fork.
>> d) It doesn't count against the mlock budget, since nothing is locked.
>>
>> This is fairly simple to implement, with the one snag that we have to
>> use 64-bit VM_* flags, but this shouldn't be a problem, since the only
>> consumers will probably be 64-bit anyway.
>>
>> This way, allocations used by vDSO getrandom() can use:
>>
>>       VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE
>>
>> And there will be no problem with using memory when not in use, not
>> wiping on fork(), coredumps, or writing out to swap.
>>
>> In order to let vDSO getrandom() use this, expose these via mmap(2) as
>> MAP_DROPPABLE.
>>
>> Finally, the provided self test ensures that this is working as desired.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> 
> I'll try to think of some corner cases we might be missing.

BTW, do we have to handle the folio_set_swapbacked() in sort_folio() as well?


	/* dirty lazyfree */
	if (type == LRU_GEN_FILE && folio_test_anon(folio) && folio_test_dirty(folio)) {
		success = lru_gen_del_folio(lruvec, folio, true);
		VM_WARN_ON_ONCE_FOLIO(!success, folio);
		folio_set_swapbacked(folio);
		lruvec_add_folio_tail(lruvec, folio);
		return true;
	}

Maybe more difficult because we don't have a VMA here ... hmm

IIUC, we have to make sure that no folio_set_swapbacked() would ever get
performed on these folios, correct?

-- 
Cheers,

David / dhildenb


