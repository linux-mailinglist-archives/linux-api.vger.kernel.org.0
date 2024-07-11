Return-Path: <linux-api+bounces-1955-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8C92F08F
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 22:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0482F284084
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 20:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD019EEC4;
	Thu, 11 Jul 2024 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiebzYfJ"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4916E894
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731565; cv=none; b=ROcW2xGr8EKh13R1kc3mp1qdEi7b50vfJONL0ovHno3O1pQHpIFIxy3zjiV+C0WRMv1+Q20TA4yJ6S5OoG+/VbS0FC+ITAA7YsR4MLKJd0iMkWZQcdzCXWPK+4PQotlLqR1+8t1zQfFtQHMDcFhuTLpZfNABNNYfiQSfJE2N/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731565; c=relaxed/simple;
	bh=QQsgAsDAjlmdZlcOkXsBLSszukt65MSwcRGa9RewC/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2Bkz+w+bfmQL0xWqDj1Gwqj8ollj5qb+OyVgHbQdpfmFer4au0ZfdNJjdG8QYIM6HHgIwUPofX/wxAf2SEGCaOiM8PqKgIegRaKtIqApr2oEVwl0JnpJzkato0L9r50+mnpyoUCBi362iH3T+M6CjY6+OLpP6xpQVw3SOpL6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiebzYfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720731562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LZQ+a9DmpNAaUKr5Arm0el2gXwdPADPIa0ljBv25PlY=;
	b=CiebzYfJzn4VfbHCGrsTCeHZjdZKEo9M/2xLBsL8G5gOKYeMgQ4CAGHrPV5QTyk+Op05M8
	u/KudJi6AOd1w3bqccjKycaNudLqQ/6RMFa0pROaL/HbVd1OvBwcttg4c6L2IetOlN4NBG
	ehZdiXbq8GB1HEKfzEEYmGX0AyPW17g=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-VbejUEYtMNWlyzePyBsOYw-1; Thu, 11 Jul 2024 16:59:21 -0400
X-MC-Unique: VbejUEYtMNWlyzePyBsOYw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-703775b7dbeso1279518a34.1
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 13:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720731560; x=1721336360;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZQ+a9DmpNAaUKr5Arm0el2gXwdPADPIa0ljBv25PlY=;
        b=itj+cvtf0zMWWygyV4EC5fpCRyz9ccJkmXrTYKfFPPPfOaj+Fo2KEe35pmCI/j0B+K
         ERgW5CtDsYqMfTsXRhYlU0bpUOor3tAKX14woOpu053IafIyX7F7iOATxOUe1WF115F5
         l+mqy/OEQ97kbUYTp+mAIwX9JV0EYQVFQwo9KIQffljUXuB2Fr0+XRAi8Kd4/DSKx866
         ZQKHJQai/fPHD8puOav07wffu2RPwEwK6dgqo2Acm7Pd/Uw8E9xykxMUmFbN2BbzdCPc
         EKFE709ZHU2G0BkDt31xhIWV+ensTud5N2C50lcpNOpoNq4MSpEJuEGoINUfNVLPBMBR
         vZSw==
X-Forwarded-Encrypted: i=1; AJvYcCXgsnKNCI8qpJsj8fHL3e+8ipAlZkcfFafy1Gyq22cdU1GHe6q/52itSUsIiA3C5ZYBd1vx+i5DYj4anLI+o49O38Q45SpMxrsJ
X-Gm-Message-State: AOJu0YxcJ7//n+7MuyBs0/DehXIRTGxG4CZubFTrgkEDzBQHyh7h9u6Z
	RUJ7qNNk8uhfdRui6IUi3FQ+nfzr/dDekN+HHYV45KiHKUdUdnDz3qY2XY30ToLz1so9JNcLE9v
	FjW0aAJLjO4hyvaBYpZ3BANB9DF45EnU68DQYaPreMxBTn220FMUR4x+nPMVIQ0ZmHv5r
X-Received: by 2002:a05:6359:459f:b0:1ab:f2b3:f018 with SMTP id e5c5f4694b2df-1abf2b3f356mr829569355d.0.1720731560651;
        Thu, 11 Jul 2024 13:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES9jTxXw9aqKIz5yO9tX4m+yDeq6TI47YACdc8XKO2Tsd7kHzFe6TfXf8OAFM3rZSFS7A7pQ==
X-Received: by 2002:a05:6359:459f:b0:1ab:f2b3:f018 with SMTP id e5c5f4694b2df-1abf2b3f356mr829567355d.0.1720731560266;
        Thu, 11 Jul 2024 13:59:20 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d60117addsm4705877a12.20.2024.07.11.13.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 13:59:19 -0700 (PDT)
Message-ID: <ac230cd8-11b0-48f2-94dd-6195967c08e9@redhat.com>
Date: Thu, 11 Jul 2024 22:59:18 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Yu Zhao <yuzhao@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de,
 linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com>
 <ZpAcWvij59AzUD9u@zx2c4.com> <ZpAc118_U7p3u2gZ@zx2c4.com>
 <ZpAfigBHfHdVeyNO@zx2c4.com>
 <8586b19c-2e14-4164-888f-8c3b86f3f963@redhat.com>
 <ZpAqbh3TnB9hIRRh@zx2c4.com>
 <443146f4-9db8-4a19-91f1-b6822fad8ce8@redhat.com>
 <1c8632b4-06a5-49da-be0c-6fc7ac2b3257@redhat.com>
 <2c464271-1c61-4cd8-bd4e-4bd8aa01fa00@redhat.com>
 <CAOUHufYsxCb=taWWfUbuzi1Hmmug=ThQMoTjsxrtFkt=UXEu6w@mail.gmail.com>
 <ZpA-iuAItDxBSfBS@zx2c4.com>
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
In-Reply-To: <ZpA-iuAItDxBSfBS@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.07.24 22:20, Jason A. Donenfeld wrote:
> Hi David,
> 
> On Thu, Jul 11, 2024 at 01:49:42PM -0600, Yu Zhao wrote:
>> On Thu, Jul 11, 2024 at 1:20 PM David Hildenbrand <david@redhat.com> wrote:
>>>> -       /* dirty lazyfree */
>>>> -       if (type == LRU_GEN_FILE && folio_test_anon(folio) && folio_test_dirty(folio)) {
>>>> -               success = lru_gen_del_folio(lruvec, folio, true);
>>>> -               VM_WARN_ON_ONCE_FOLIO(!success, folio);
>>>> -               folio_set_swapbacked(folio);
>>>> -               lruvec_add_folio_tail(lruvec, folio);
>>>> -               return true;
>>>> -       }
> 
>> This is an optimization to avoid an unnecessary trip to
>> shrink_folio_list(), so it's safe to delete the entire 'if' block, and
>> that would be preferable than leaving a dangling 'if'.
> 
> Alright, I'll just remove that entire chunk then, for v+1 of this patch?
> That sounds prettttty okay.

Yes!

-- 
Cheers,

David / dhildenb


