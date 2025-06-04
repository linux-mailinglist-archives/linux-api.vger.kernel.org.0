Return-Path: <linux-api+bounces-3870-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9731BACDD75
	for <lists+linux-api@lfdr.de>; Wed,  4 Jun 2025 14:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0EF1899161
	for <lists+linux-api@lfdr.de>; Wed,  4 Jun 2025 12:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1B28ECF5;
	Wed,  4 Jun 2025 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oyuaq+l3"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8B24C692
	for <linux-api@vger.kernel.org>; Wed,  4 Jun 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749038748; cv=none; b=mq2lXuWULv8gOfqgMXBZg9FqtEzrKTSXjBhLTvkfyQ3UlNTVtFaCOtmaUDgepjQR9SdQHAdI958X1rjEAsYEiSJ3fLilpwqbMySw8SSr61WDxBWweQmKs9zlhp/+hS32SAcRyGzP8aNUEW+teUqOGAmYAOGwOru9B94mUMyeUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749038748; c=relaxed/simple;
	bh=U8AVzAlrbEZ0aChrxNGmrNRiyqyM220uTc6XmlAQjho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fda+yU4J0Tan2tw9obyuYDgspTcCiFtGZKZrvIUmMw/ceoifovMy1SIa8JvMUL92WC7hA8LE4vflGL31WsKVLpItqbrlhsdVHIaibxPHCdAbdCrfh9RGOszl673fqmOCPtF2yw8hRfTNrZjjS0GENuoIIzmuLFJWWctxgR21m+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oyuaq+l3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749038745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rs0btbQ6D2xanKsfDuTxjlpnDIaLcj7WvAFOziSOBxI=;
	b=Oyuaq+l3IUIcmZ99l3IeOZuGQpONBKjMb3jShpuhb2bSDk0+4CYxC1/5UxcpDrUkvcI3QL
	g2cWbYZARZFJFRo5y0ltBQL9VKcsJuRW/uFIVT9flGva53B1+pbS8euQGDd356+b5QvIys
	Pn88+Q+i4YXXFR+mogHhD59dq3PJMfM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-CjoU4xQtP4yKGhYKDk5cvg-1; Wed, 04 Jun 2025 08:05:42 -0400
X-MC-Unique: CjoU4xQtP4yKGhYKDk5cvg-1
X-Mimecast-MFC-AGG-ID: CjoU4xQtP4yKGhYKDk5cvg_1749038741
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442f90418b0so36502155e9.2
        for <linux-api@vger.kernel.org>; Wed, 04 Jun 2025 05:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749038741; x=1749643541;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rs0btbQ6D2xanKsfDuTxjlpnDIaLcj7WvAFOziSOBxI=;
        b=lkm1Y9IeTaIrHZfspqO7b/rRNiDALNf0s+/0ky2z7kM0nCQdEs2+GXz7nORe1qI+t/
         zIvnvjj9Ga4XQ3Sm3MQOXl0zUn7Uu2SOTW2d0lEaPjhEJwaWnoSpY6RUrWs2oKtDOwdT
         JX9w1o7RHFOfRatD920bTbrCe6nQrS343Ym+3QDKxWNZNTYTu3c8yGjlTZZeqNGOxPP6
         WuZlEdu/nS1JSzWO3+G0hYqzwWhcv+rbZiBxrXUhPXODxvSsEfFT/bKZF4WibGbUyf2H
         zLx18UMmuv6t8I5dC6STN85jJ9387wMWk6rRRK6/0GHTZKwD5wOauyLgkGIRd6bo6qe4
         wFTA==
X-Forwarded-Encrypted: i=1; AJvYcCVN0kBtRXCPYjMd7bj2QJ+uJyJVy06E8eEy+RbMOEwXnKoXQbCN6AzMGLz4u49mfxcHPTceY9vVwHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCzewasVkY9YX55FScsbnfef0PquktPlyqI0egb2w020R3ecp
	i6Cb7TW1lzanllyB/phu8YnYecQ3ne2zz1C0i0eXwNouYkXUWw3Nw3zJuIPWtwa8GA1HKIeSVhy
	a+NkIvk/yRQA8KhiMQ6b6x6FJllhhPykex3/Xxyz8gH/JP2NFS2OGLXs7MwrEYQ==
X-Gm-Gg: ASbGncsLYH5L3NSNpxX5onivxHvQHzVb41hBNeKkm8r98UhYmy54Mjz80Rst1ySqJr4
	zQTQRCVcdsLWsoz2EmM4tnXLu8yxdhfPTumq1mmNa/ZUSfdJmf3Xl9mJy7EGkhUUCU1ZMBX9QTj
	2pkEhkGGM67qHfnNV1rAZL018Z3kAFwcmJcZx3yuLtecWDuMUUqzf0/5BbvymkXRsk8sHID+4HG
	+i35xxzLQj7HFkEAxsHQe4ekSLUsbqS+EZOXDdZbkfvlWsw6u7eg9yyiKxZzQmEAD6xfGJcx7Iw
	24SjM6wHnAD188qNt8H8LDNanRyo5GUlW04sFqBKAvXfB1SFfcvB0wIyyZoMTqK1HvXgU2ybF2a
	leeRifrDb3US8lUT++c8DCTR9lybXfiwckOnqkR8=
X-Received: by 2002:a05:600c:34c2:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-451f0b09f62mr18360255e9.20.1749038741070;
        Wed, 04 Jun 2025 05:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBsuyo9l+yFSCcNj2JR7ZoUNJ4TDGNXGCjYZQjJw2vbSw0Yu0DciIRlxFRq3I5iJNsenYpfg==
X-Received: by 2002:a05:600c:34c2:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-451f0b09f62mr18359835e9.20.1749038740628;
        Wed, 04 Jun 2025 05:05:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf? (p200300d82f1bb8006fdb1af24fbd1fdf.dip0.t-ipconnect.de. [2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d8csm196532255e9.24.2025.06.04.05.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 05:05:40 -0700 (PDT)
Message-ID: <5c054941-62c2-483c-ac19-592aa795ed93@redhat.com>
Date: Wed, 4 Jun 2025 14:05:39 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] proposed mctl() API
To: Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
 <CAGsJ_4yKDqUu8yZjHSmWBz3CpQhU6DM0=EhibfTwHbTo+QWvZA@mail.gmail.com>
 <20250604120013.GA1431@cmpxchg.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250604120013.GA1431@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.06.25 14:00, Johannes Weiner wrote:
> On Fri, May 30, 2025 at 07:52:28PM +1200, Barry Song wrote:
>> On Fri, May 30, 2025 at 9:14 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>
>>> On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
>>>> Barry's problem is that we're all nervous about possibly regressing
>>>> performance on some unknown workloads.  Just try Barry's proposal, see
>>>> if anyone actually compains or if we're just afraid of our own shadows.
>>>
>>> I actually explained why I think this is a terrible idea. But okay, I
>>> tried the patch anyway.
>>>
>>> This is 'git log' on a hot kernel repo after a large IO stream:
>>>
>>>                                       VANILLA                      BARRY
>>> Real time                 49.93 (    +0.00%)         60.36 (   +20.48%)
>>> User time                 32.10 (    +0.00%)         32.09 (    -0.04%)
>>> System time               14.41 (    +0.00%)         14.64 (    +1.50%)
>>> pgmajfault              9227.00 (    +0.00%)      18390.00 (   +99.30%)
>>> workingset_refault_file  184.00 (    +0.00%)    236899.00 (+127954.05%)
>>>
>>> Clearly we can't generally ignore page cache hits just because the
>>> mmaps() are intermittent.
>>
>> Hi Johannes,
>> Thanks!
>>
>> Are you on v1, which lacks folio demotion[1], or v2, which includes it [2]?
>>
>> [1] https://lore.kernel.org/linux-mm/20250412085852.48524-1-21cnbao@gmail.com/
>> [2] https://lore.kernel.org/linux-mm/20250514070820.51793-1-21cnbao@gmail.com/
> 
> The subthread is about whether the reference dismissal / demotion
> should be unconditional (v1) or opt-in (v2).
> 
> I'm arguing for v2.

+1

-- 
Cheers,

David / dhildenb


