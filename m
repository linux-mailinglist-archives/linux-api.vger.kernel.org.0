Return-Path: <linux-api+bounces-1939-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BC92EED6
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 20:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FA8280795
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60DA16DC3B;
	Thu, 11 Jul 2024 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7Qm7GQo"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0D16D9CD
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722255; cv=none; b=aqYsOhhBGsKC6NXLcq/yt//sXIT4EhYyPb74GtPIYftcT0bRxKP9Cba80iwgpJGVUHesdgEogHgdvzJe5Twj+6LgbVIn9Yu8D0xCnHhZT8wXsxabuUj5s4wpTI9krv8nusyRLzZEPGhPVkVnFY/i8VIeVIlf4+fZFRVjq9g93G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722255; c=relaxed/simple;
	bh=4yc6TTybyvbq7r+wQzEg9hfuNL618Dtw76lL5URUVIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQjbLIRtMPh/kc06SdQA8QA/m+6KxczuMoBllMvF46FShtk6sYY06+QDcLsrcvMbVrFSgmcLnj5owQxtLmj4U64C/CN+vhO3cE96Jj0+EvkAiUTI8yjlIaRXNr1BUgAbpDK9J3IHfyiZYppERI0FqnzyanWJMqnpk3UefG2g7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7Qm7GQo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720722252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Cm66rg1XZxCCsZjKT6Mp2kABO5AQZLpHZVrfTgemS9w=;
	b=P7Qm7GQoT79VsOJnZz1njZMp7dKpKxb214E9FChgHYqtCm62VSZT8K+C6Vq/k3O/ja9Lql
	FhqjtaXA3jKNQMjbUgX89wz8Z4ma8sFz49QpDbqwcNg2zJWB9MD7ugLrz6P/BBjBR1SjiB
	CqkaQ+zIVMHGgRlRs+5Cl9S1jGCaeZY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-L6J4ZT_XOVWlTxx425rXLw-1; Thu, 11 Jul 2024 14:24:11 -0400
X-MC-Unique: L6J4ZT_XOVWlTxx425rXLw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70b1e0a2c59so1796254b3a.1
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 11:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720722250; x=1721327050;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cm66rg1XZxCCsZjKT6Mp2kABO5AQZLpHZVrfTgemS9w=;
        b=NQd5X4FU5RQY27xJ/xbZPxKmlvKXLmlEpb9SXpEbUn6JGZ9pR/eYZ4e3uWPNNSybyh
         HGsacGdu53ZDebwM2MFPbywhHbnFrIkPRrYAtL1rRjwP3wohS7zyLCaUBvdW+SUX24jK
         tVTPldZKGvOnBQvWxlt7nm2Lew9rmFbb+IjnRDcaAI7ZZ4FAdzcznWbLhOqvzbXAylCL
         ncRBWmW5NxAdmXohWoF9h5ryT87UYLhJPWkwPCteyw3tr2iSWL5tVXyMvlj5CkhFvrGj
         cKowZz9DAeMbClhLG+uJwgPfbDETQqhT0Op4YQDBP54vMqCuQhh4ocbojgIo4OvIXYho
         OqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpiqrqATyEDItRyv51cLFGgNk7zbxFrGQ8p38jzT01OHhKQgakJFIC3W2O37zrYn7cmVxkptw9psABxGQlFo5o7Dwr9jJfgiZu
X-Gm-Message-State: AOJu0Yxz4cnNEZ5zEBW4qy8GGLy2fH1/aXpUw536NybMwSwZfhdotEgP
	pVFR7Hc+Zl/qQ+7/B+w5Q0G0Q+RXfo7uGVDt7H7R/UeTRxhCeB0gtAQy6VSvLO4hxr8v6QzJxSo
	UCqnHNkMLI9wuJYy7zlFXh3M1KFgUDpA8nJ3lba393MLkVa2fwVN5Cu19WQ==
X-Received: by 2002:a05:6a20:4328:b0:1c0:ebca:963d with SMTP id adf61e73a8af0-1c3becb2121mr586166637.4.1720722250578;
        Thu, 11 Jul 2024 11:24:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4jCYKJblZyB+FBweYmfvmonb9H5CH5xNShBFvfLtVj6t3jF8KoVnfT8+Sq9FycQr3reRt/w==
X-Received: by 2002:a05:6a20:4328:b0:1c0:ebca:963d with SMTP id adf61e73a8af0-1c3becb2121mr586130637.4.1720722250166;
        Thu, 11 Jul 2024 11:24:10 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b70b4sm6003781b3a.185.2024.07.11.11.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 11:24:09 -0700 (PDT)
Message-ID: <8586b19c-2e14-4164-888f-8c3b86f3f963@redhat.com>
Date: Thu, 11 Jul 2024 20:24:07 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de,
 linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <Zo8q7ePlOearG481@zx2c4.com> <Zo9gXAlF-82_EYX1@zx2c4.com>
 <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com> <ZpATx21F_01SBRnO@zx2c4.com>
 <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
 <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com>
 <ZpAcWvij59AzUD9u@zx2c4.com> <ZpAc118_U7p3u2gZ@zx2c4.com>
 <ZpAfigBHfHdVeyNO@zx2c4.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZpAfigBHfHdVeyNO@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 20:08, Jason A. Donenfeld wrote:
> On Thu, Jul 11, 2024 at 07:56:39PM +0200, Jason A. Donenfeld wrote:
>> On Thu, Jul 11, 2024 at 07:54:34PM +0200, Jason A. Donenfeld wrote:
>>> On Thu, Jul 11, 2024 at 07:27:27PM +0200, David Hildenbrand wrote:
>>>>> PG_owner_priv_1 maps to PG_swapcache? :)
>>>>
>>>> Maybe the combination !swapbacked && swapcache could be used to indicate
>>>> such folios. (we will never set swapbacked)
>>>>
>>>> But likely we have to be a bit careful here. We don't want
>>>> folio_test_swapcache() to return for folios that ... are not in the
>>>> swapcache.
>>>
>>> I was thinking that too, but I'm afraid it's going to be another
>>> whack-a-mole nightmare. Even for things like task_mmu in procfs that
>>> show stats, that's going to be wonky.
>>>
>>> Any other flags we can overload that aren't going to be already used in
>>> our case?
>>
>> PG_error / folio_set_error seems unused in the non-IO case.
> 

Note that Willy is about to remove PG_error IIRC.

> And PG_large_rmappable seems to only be used for hugetlb branches.

It should be set for THP/large folios.

-- 
Cheers,

David / dhildenb


