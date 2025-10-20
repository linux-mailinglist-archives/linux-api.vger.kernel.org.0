Return-Path: <linux-api+bounces-5131-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB9BF1A7E
	for <lists+linux-api@lfdr.de>; Mon, 20 Oct 2025 15:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302393B8BD2
	for <lists+linux-api@lfdr.de>; Mon, 20 Oct 2025 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9AB31E115;
	Mon, 20 Oct 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkM/dL8A"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2A246768
	for <linux-api@vger.kernel.org>; Mon, 20 Oct 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968395; cv=none; b=CKeDWQQcWg2K/PJ0KMkmdJ1ZbQKIO1ErUnIN2LX/i0M2urPzY9Gs/CgW6BlUQ93Eqf0iH2gtD4G17W0HOYp32r40hsBMOQ8l5Hrsy3QOPxsfg/5cwn1bzDjAiEGV2Iid3gad2qwe0LP/n3FOT0Ls5/kQng3VzIyMmln6KhWrK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968395; c=relaxed/simple;
	bh=VwKauILfhcSWg3j9lqrsCRW9wbHQzV3XTs+CzgQu1NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOV0SABWbsFaG6p+7jYTkCBBgKS8Obwe9X7WPSXe6Pl+RUR/f4k0EvVF6pumCD0B+Bg6mxH0YAP47d14zdpFubPRMBF+L6X1PVWpaIjHEqM2ef+qjrecoc5W2U1QHJCtrvsjgPrP+ZxRcLfVkIwwmojIdA6WGGqXx5KKeTVhYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkM/dL8A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760968392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bIUQcQqGzVepp2tFG39wK71eceYTNe6sFkAh3btcuUk=;
	b=IkM/dL8AGTaeOC7OZPXiDNLmcdlQBK+pEwrI9GB3hNDZTT7keewwN4CrkDy19V6LJrCue3
	Y6p2gnOIhreO7MOYCDPKnheJ9uGXg2G2NOX8wU57Axj/bHJi190Jd5OZo+NFx6ur2ACv/+
	wKvIvhw05q0bicITReo1/EjxoUm3suk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-VOlVyLZoPrWdR3nuWM70pw-1; Mon, 20 Oct 2025 09:53:09 -0400
X-MC-Unique: VOlVyLZoPrWdR3nuWM70pw-1
X-Mimecast-MFC-AGG-ID: VOlVyLZoPrWdR3nuWM70pw_1760968388
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426ede1d66fso2388304f8f.1
        for <linux-api@vger.kernel.org>; Mon, 20 Oct 2025 06:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968388; x=1761573188;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIUQcQqGzVepp2tFG39wK71eceYTNe6sFkAh3btcuUk=;
        b=Roh31oUB3XGOxN/ceRoQ2R5nE9vqJCFSWE5/dugel03qZpEoI89N0130qjMM8I94Rw
         Q9gYnayuopgBe79fzIxT8GSAZaIJTpjDjcTdZeyyDBben8uk0TK37j3EqMCAqWBChn64
         0Gn6kAnHEwpim1ozRPU4D87UgCa0x7o9SbskRqhIbNgDsxqULO5a3J2cGERBbihUZhej
         WXSwYyUUiefQ5OWRW4kvOFZtVcvP75p4crrMDw605Tlp6eQovbPeKPtAWwJQgjaC7Hmf
         UTVv8urPpfjrCNNd8Ifd1uHrML4IoVqoZjIkaaeSYoZX9TqKUUxI5wPtlZwAOCxj3mZn
         6aAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9lSqVPGQhWc+YiSQj5/4QH/hlPnt5MgO1vTN+oLearS8+sBZYYOofjeYpFy6+dMtO3dHdbDRqoEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBAvYep5OUlVUgUUP9fIoKI2dzoJCdMW6rnAGA9GHd3KfhAoW
	bmRXElFsXxhyou2kunzt1OSNOy5SUqjkIFbP5EKXLV4pOKJnBZ49+gc40eT4sgENpgadxfPUOhN
	97iBVefBwHHL5GkoHb2rq7taMZ/ph7sFsE6bJLkKfxrEbo+hj++xo9WVDG2a53w==
X-Gm-Gg: ASbGncuwdDVxYXaBdk3WvpSEj2+2qtpYEY4exrq6mgN2VpgMAQGkai0WdNcxzpWtXTQ
	PBCYV88c92J9+Y6qphGygwyAb7wxxwrfmgMxnOyAotzgHGF8WrhE3oDVbN0b7OGUuuF2nIitD2f
	PFhErV5DCMqPbNcCqIOxZ4YxcQeWKMJoxE/K54jrQrkIRNT37RKiCi7h14rjPj7QPkl4NTXqgRp
	ik+m8rMI2er7s6SV73SD66HgFAKTy+L5F5xYcC4rqM/l9S3f7cAhmDFepsv7WK4Uw81D228j9n4
	rklgOZVD3n9TpIyHWEfgmxm86o8KM5NDCJCdiihVWjTPlc7ByT4D7aITZvYvmmbutrch3EdaxBV
	qEF8oXywX1+RrX1S/7ZQPNDVBhZIQfg9A2p3BdBdBnTRYodJotdnoowcQoeG6XlRZws85sh6737
	NoltTDyO1ubrv7rArXeVETFiA77u8=
X-Received: by 2002:a5d:64c2:0:b0:427:80a:6bdb with SMTP id ffacd0b85a97d-427080a6be4mr7318994f8f.46.1760968388334;
        Mon, 20 Oct 2025 06:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNJVqO4jkClQAHIXRWj8GsF6qeiRz7gfVAznbjdQ8V6m0yz78pmC4EKThEBfYV6xT0dDAiDw==
X-Received: by 2002:a5d:64c2:0:b0:427:80a:6bdb with SMTP id ffacd0b85a97d-427080a6be4mr7318978f8f.46.1760968387961;
        Mon, 20 Oct 2025 06:53:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3affsm15329118f8f.12.2025.10.20.06.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:53:07 -0700 (PDT)
Message-ID: <d16132cd-81c5-4655-a788-0797553238bf@redhat.com>
Date: Mon, 20 Oct 2025 15:53:05 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/20] mm: stop maintaining the per-page mapcount of
 large folios (CONFIG_NO_PAGE_MAPCOUNT)
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-21-david@redhat.com>
 <20251014122335.dpyk5advbkioojnm@master>
 <71380b43-c23c-42b5-8aab-f158bb37bc75@redhat.com>
 <aO5fCT62gZZw9-wQ@casper.infradead.org>
 <f9d19f72-58f7-4694-ae18-1d944238a3e7@redhat.com>
 <20251015004543.md5x4cjtkyjzpf4b@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251015004543.md5x4cjtkyjzpf4b@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 02:45, Wei Yang wrote:
> On Tue, Oct 14, 2025 at 04:38:38PM +0200, David Hildenbrand wrote:
>> On 14.10.25 16:32, Matthew Wilcox wrote:
>>> On Tue, Oct 14, 2025 at 02:59:30PM +0200, David Hildenbrand wrote:
>>>>> As commit 349994cf61e6 mentioned, we don't support partially mapped PUD-sized
>>>>> folio yet.
>>>>
>>>> We do support partially mapped PUD-sized folios I think, but not anonymous
>>>> PUD-sized folios.
>>>
>>> I don't think so?  The only mechanism I know of to allocate PUD-sized
>>> chunks of memory is hugetlb, and that doesn't permit partial mappings.
>>
>> Greetings from the latest DAX rework :)
> 
> After a re-think, do you think it's better to align the behavior between
> CONFIG_NO_PAGE_MAPCOUNT and CONFIG_PAGE_MAPCOUNT?
> 
> It looks we treat a PUD-sized folio partially_mapped if CONFIG_NO_PAGE_MAPCOUNT,
> but !partially_mapped if CONFIG_PAGE_MAPCOUNT, if my understanding is correct.

I'd just leave it alone unless there is a problem right now.

-- 
Cheers

David / dhildenb


