Return-Path: <linux-api+bounces-1917-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D78892C923
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2024 05:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48DEB212E9
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2024 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE1934545;
	Wed, 10 Jul 2024 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irg/T1gA"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822832A8D0
	for <linux-api@vger.kernel.org>; Wed, 10 Jul 2024 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582061; cv=none; b=S1Njxgfta6vBPnk/dy6rru1K+E0BOEBbnphiT2PKo9IFhYztwRwMzi3WEJDJ8bBhZ3szcA5wFRtFDo7O1B9lRnxrYKSldQyk62TLJXxMuOAijaNeLPmK4+reVjDR0LrYLp3J1fntKJ8vM5IhuWsc4OaKsBey6XgtmCKkarbkzdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582061; c=relaxed/simple;
	bh=mBBE7dz15efOv1uV6FrYeD3DVCzx7sajU7jqGksA5e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+Fwvm6R5VPBuuKgFaf92LgD2GgTUqXnrwOPHOHIOwhPk0oS2FhZ50Sm1UzN2yleKy1uEAKhmFA7U2RYviG5xS0WrvgIGhVVDAzq2qDyIZEDxicVYQIORUicgsmkjtTTVI9qqeKyjr3WlnrOJ4J3/tchQLHkY5q7uHdV+1EnEc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=irg/T1gA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720582059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nEckqOHWAICqj0R4qpukWbnuiOvcD4K2Po42Rz92Tf4=;
	b=irg/T1gAgf8I4LoyglhimA5Eeh1mjhI1JITmPBnIrfgbyGa7js0SHFD9OC2jep4IMcgwjX
	rfOM57v3BdPm1zo7CSsJoOOymyqjzNV+v2vfZCXmeyrkF8pRlbsP2+O8o96UWnbK/87Ed1
	NBNrCn8zNRy6BcI/tfequnZB9oPVES0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-gVezi9gaPm6c3cyN0ZrJhQ-1; Tue, 09 Jul 2024 23:27:38 -0400
X-MC-Unique: gVezi9gaPm6c3cyN0ZrJhQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fb294a0915so3108035ad.1
        for <linux-api@vger.kernel.org>; Tue, 09 Jul 2024 20:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720582057; x=1721186857;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nEckqOHWAICqj0R4qpukWbnuiOvcD4K2Po42Rz92Tf4=;
        b=cgi8fmj9JrYNl0pUM0Ks1Pk83mvmltnpAsdfuXQ6/jXh8FmbyXiRx3CT9KaZid0Ct5
         X+8M5uz3MoNRLiSqVBP9Ho0r3z2Wk6iKmlw4rph/p3g/+T/WxOGUsO4irEAHZoZX496S
         jwgvsIlj3pySpof5eWkKHcaWgQn/Xc8y6bWw0bZt2PahS9hUkfUOP9lx+a3UjIqmG7rL
         FAyh5fPSsZtqf/yk1DC2sl0BMXKCN7UD74excAsK6a2+/5HVRB7WJysaKNT1lawQJfsN
         mcAxK5uHe0Hj8Q+6whaP8smOrZYG4nrjZyqrOvx0wkYEAZWDzd/2oxk61RwzTAHTpl7b
         km2A==
X-Forwarded-Encrypted: i=1; AJvYcCVfkdP5LjxuNc+TihWH/0r3HLX2D6vNVvNRlOTL25dpC9e3rQkr+MK9XANeXekyW29JrcOdSFLY8MNm3dfEKkpnoK345v6QwXoD
X-Gm-Message-State: AOJu0Yz3t4kEsnsKaWgygPPaRA4XgXR3cxqZP3hwxpL2IL+mble9/KmK
	k9Pzu1WPd4n+dTb18NASup/vuDwaML+OPOPXE8nx4njB3iyAhsKAeVhYzgwsDBUQWPaZu3hvwGY
	6MQpHAmc+J+VXGE5LIRDzYGl3cMVH1IEBR6SgvHz3chLl21fWAZYYFCZzOA==
X-Received: by 2002:a17:902:ecca:b0:1fb:5f9c:a86c with SMTP id d9443c01a7336-1fbb7f7a04fmr59105035ad.3.1720582056947;
        Tue, 09 Jul 2024 20:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUVK0nH1Se25EIwQVyIEijRjpXH84dUEDJcH0ZXbsfSp49EQ3gXIiQ4XlrrEc+daVm/RqcSQ==
X-Received: by 2002:a17:902:ecca:b0:1fb:5f9c:a86c with SMTP id d9443c01a7336-1fbb7f7a04fmr59104895ad.3.1720582056558;
        Tue, 09 Jul 2024 20:27:36 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac321asm23853985ad.220.2024.07.09.20.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 20:27:36 -0700 (PDT)
Message-ID: <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
Date: Wed, 10 Jul 2024 05:27:34 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240709130513.98102-2-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.07.24 15:05, Jason A. Donenfeld wrote:
> The vDSO getrandom() implementation works with a buffer allocated with a
> new system call that has certain requirements:
> 
> - It shouldn't be written to core dumps.
>    * Easy: VM_DONTDUMP.
> - It should be zeroed on fork.
>    * Easy: VM_WIPEONFORK.
> 
> - It shouldn't be written to swap.
>    * Uh-oh: mlock is rlimited.
>    * Uh-oh: mlock isn't inherited by forks.
> 
> It turns out that the vDSO getrandom() function has three really nice
> characteristics that we can exploit to solve this problem:
> 
> 1) Due to being wiped during fork(), the vDSO code is already robust to
>     having the contents of the pages it reads zeroed out midway through
>     the function's execution.
> 
> 2) In the absolute worst case of whatever contingency we're coding for,
>     we have the option to fallback to the getrandom() syscall, and
>     everything is fine.
> 
> 3) The buffers the function uses are only ever useful for a maximum of
>     60 seconds -- a sort of cache, rather than a long term allocation.
> 
> These characteristics mean that we can introduce VM_DROPPABLE, which
> has the following semantics:
> 
> a) It never is written out to swap.
> b) Under memory pressure, mm can just drop the pages (so that they're
>     zero when read back again).
> c) It is inherited by fork.
> d) It doesn't count against the mlock budget, since nothing is locked.
> 
> This is fairly simple to implement, with the one snag that we have to
> use 64-bit VM_* flags, but this shouldn't be a problem, since the only
> consumers will probably be 64-bit anyway.
> 
> This way, allocations used by vDSO getrandom() can use:
> 
>      VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE
> 
> And there will be no problem with using memory when not in use, not
> wiping on fork(), coredumps, or writing out to swap.
> 
> In order to let vDSO getrandom() use this, expose these via mmap(2) as
> MAP_DROPPABLE.
> 
> Finally, the provided self test ensures that this is working as desired.

Acked-by: David Hildenbrand <david@redhat.com>


I'll try to think of some corner cases we might be missing.

As raised, I think we could do better at naming, such as "MAP_FREEABLE" 
to match MADV_FREE, MAP_VOLATILE, ... but if nobody else care, I shall 
not care :)

-- 
Cheers,

David / dhildenb


