Return-Path: <linux-api+bounces-5112-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A7EBD97E4
	for <lists+linux-api@lfdr.de>; Tue, 14 Oct 2025 14:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CD53E3C04
	for <lists+linux-api@lfdr.de>; Tue, 14 Oct 2025 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E5313E05;
	Tue, 14 Oct 2025 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e56PBtSl"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37C31353C
	for <linux-api@vger.kernel.org>; Tue, 14 Oct 2025 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446781; cv=none; b=eQdHZRUbvXA2J1WnI9Axd5hGNPR/rYhEfLpkW6V17j562PZOdYaU48Y5zm87CSw0acCZC3qUIatAgwnlbTmUuP+vtyc4h36D8pSIr8fAGb0vf216NsJEkzjmTcd9FA0LqCU/c4YCutPArTiLcl9yNMv2CzZ/cANgJJAgnKnACHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446781; c=relaxed/simple;
	bh=Z1Th0V3A9t5q0RL6uoXSwWvKS3kowUSTZ0Ef18CL46Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSc3sT6XMM/y+oheGjh9drC1MwbcZx8GoLGOuy68KtOhRE5jocm0MNqmFXuqJMkSkIIuIjNqHSDZidrH0qrfFa00ket8yw+xf34/+y01Tr4FFIGMJJ8C3XRauT2R376/MSmS5YBkuQhla3saKuvQ4WW361lvHZRZ7lvWqfP2Ksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e56PBtSl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760446778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iu1mp0L5rze+u9w9cyraP7Gulphe1rkUj/3PhF2TPeI=;
	b=e56PBtSlEuqYhpAU8UfdK8lr5zBZWehoc+3O2kyssRnNld2xMxrVBqbQSyT9TdteC7kyTW
	hdUCjbs12W5BbQB0gQLybsmkEAloCTUjXfSzWNRFMYXDekqYupyAWjd11SqBjnHK0l+tzn
	JguuSNVii4U3Bf3T3WWcNhFlOii54NY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-9NPmS4t6MxCcvA0qoTKrUQ-1; Tue, 14 Oct 2025 08:59:34 -0400
X-MC-Unique: 9NPmS4t6MxCcvA0qoTKrUQ-1
X-Mimecast-MFC-AGG-ID: 9NPmS4t6MxCcvA0qoTKrUQ_1760446773
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-639494bed86so7720082a12.1
        for <linux-api@vger.kernel.org>; Tue, 14 Oct 2025 05:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446773; x=1761051573;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iu1mp0L5rze+u9w9cyraP7Gulphe1rkUj/3PhF2TPeI=;
        b=sFLui8Vt5rMpGxwU+e0N4veJP/4ItGE6Tp7kvO10lFTjryuKsWgTruwS5xynyfn7Dr
         XnsJP+lWeCDwOiIamOnlsNecjSbPND2+e6aJitDbMA6Fl3IOCbWuVay3hCWyvqEXPLSQ
         jy9/6Jdtlu/pX8mDJlw8wJscOP53qkak3f8R/O7Pju5UzZhO5BhDf/3aa+BTc+dEuZxh
         4s664JpZz7JqWuCZnAvqLOahFykgDVkNa7d17yu5XWaRDH8flBk+g9yxoQSY82Sfm2oH
         1wbng2545BeH0lziBjPwSu5Shx9bXrYHLzEUS7Jh/x70fNNvWI72P980XNdFyVzrmwWK
         WoOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdMTX+y+hhePqeGrL3chLh/tKNm7CFAEnqmL4hAU7O9pcfx74gpZ0yISMIVayPfVtqK324C9qSJ9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBToZ6h7oMkIvz+vKC99aMV4y+N9FuwOUdVYYei41wAvch2JL
	q8GNTiQqVvNeyp0MIhxY8dV0dLozLF6kL8lpnq4PEzDVW/oFFlz1JSkI4z7wUImCamGRT+hxAaX
	MM/h23Ved//LYgyUTWc0X6kBEBoSOeGQTQi1o3bf/x5g8xtymwBY/SQorlHkTKA==
X-Gm-Gg: ASbGncvb7PnaNG6W06D8pSnfEu+Yuz8wXbR1qXkIt99BRasYRpDGUwVdQdejYBIroCc
	bQYPor8Yrc9VUJN+mMM9ttVWT04zmMWP8NN355eMHx7Rr+J+tzJRMu3UO+d0UnKvYnQA3yArhdD
	5DIc4LCsHVCilSCWhWTGWs+KA9KQf9jnZeObZVXDHuCcsOQsvkS/V0rpMwIZp7sX8mUxcsFAJPC
	sM/Ar7gORBme3cHlVnmLNNYEDsNfEvfc8bupSkkWvkmh7yVvMba8leA8omxRvsWTSnRSSBjxHJM
	Wy++Aj9oFZMjGxE6PVk8QefKdL0rMvfaYFIabA0W+b9NNvZ2axT1b4uSRQNDrPf77S3Bxots3w=
	=
X-Received: by 2002:a17:906:f5a5:b0:b29:c2ae:78f8 with SMTP id a640c23a62f3a-b50ac5d08bamr2706963766b.46.1760446773178;
        Tue, 14 Oct 2025 05:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkEiy+cHw9UIH18Z36gnOBTWV4pz/7vpgUvMjb/aSdBKnsv8qXvi1i95BnCc/gOYElOXfN6Q==
X-Received: by 2002:a17:906:f5a5:b0:b29:c2ae:78f8 with SMTP id a640c23a62f3a-b50ac5d08bamr2706957766b.46.1760446772515;
        Tue, 14 Oct 2025 05:59:32 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b58244d17e1sm725071566b.75.2025.10.14.05.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:59:31 -0700 (PDT)
Message-ID: <71380b43-c23c-42b5-8aab-f158bb37bc75@redhat.com>
Date: Tue, 14 Oct 2025 14:59:30 +0200
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
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014122335.dpyk5advbkioojnm@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 14:23, Wei Yang wrote:
> On Mon, Mar 03, 2025 at 05:30:13PM +0100, David Hildenbrand wrote:
> [...]
>> @@ -1678,6 +1726,22 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>> 		break;
>> 	case RMAP_LEVEL_PMD:
>> 	case RMAP_LEVEL_PUD:
>> +		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
>> +			last = atomic_add_negative(-1, &folio->_entire_mapcount);
>> +			if (level == RMAP_LEVEL_PMD && last)
>> +				nr_pmdmapped = folio_large_nr_pages(folio);
>> +			nr = folio_dec_return_large_mapcount(folio, vma);
>> +			if (!nr) {
>> +				/* Now completely unmapped. */
>> +				nr = folio_large_nr_pages(folio);
>> +			} else {
>> +				partially_mapped = last &&
>> +						   nr < folio_large_nr_pages(folio);
> 
> Hi, David

Hi!

> 
> Do you think this is better to be?
> 
> 	partially_mapped = last && nr < nr_pmdmapped;

I see what you mean, it would be similar to the CONFIG_PAGE_MAPCOUNT 
case below.

But probably it could then be

	partially_mapped = nr < nr_pmdmapped;

because nr_pmdmapped is only set when "last = true".

I'm not sure if there is a good reason to change it at this point 
though. Smells like a micro-optimization for PUD, which we probably 
shouldn't worry about.

> 
> As commit 349994cf61e6 mentioned, we don't support partially mapped PUD-sized
> folio yet.

We do support partially mapped PUD-sized folios I think, but not 
anonymous PUD-sized folios.

So consequently the partially_mapped variable will never really be used 
later on, because the folio_test_anon() will never hit in the PUD case.

-- 
Cheers

David / dhildenb


