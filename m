Return-Path: <linux-api+bounces-3325-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BABA42ED1
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 22:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B2188F064
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCE41C6FF3;
	Mon, 24 Feb 2025 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilfswtPh"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8E18E377
	for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431875; cv=none; b=CjsqV7XSDkB4ookXZjsn+FR3D8rJ+0MvqkXQAt7RR9ei0OuQqi/DxSbELeYdy8KuF5Xe7gH5hi4ICYbwys3dteu0wuxDV+JJC9+Z+OZ+TCRAFGEyMjYWk2ihJ0/zbTmsCaNlluK7Q4QKkiUnQk/ZE/efOacLRMo7C3kRDTnBI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431875; c=relaxed/simple;
	bh=GVIyCVAC1uYQBZ7YvMgFAfuCk2SCyHk+Rx5O1L7KI4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNJ9TqBF0WAQN2tTcnloN5CLf3JnFTh/3k1omoTwDCV3z97dgZsV7fpL8tm5bzI/oBbMTQlsDxF1say5JSVzL73BkfGunjHAK8tS5+5sh3oOqPxnxobJIhOYxpGiXL29XKktG4dSpqSXHQc/Z1NcwZfBsI/fVJxM69fNq1+mUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilfswtPh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740431872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+pfaFYnZrGg4aP81g3fvxtKUOG+gZ00codvuI9HyJP4=;
	b=ilfswtPhTDQTH05+dnCKciUOSYD7kJ7GW9RzDn7lymrCLLMDK8TN/0BgGpiYO+vHQEhTfr
	wca6vRHRnz6ZRxYneaa7ojaCQSW+5eyevVm5qStixKnlnO3rOjYCGI6fE9UfUFkwl06S2d
	B6D4/axpG9uz3qNsYI/Ptt8kt3DUM7A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-E31NEYucPV2_aQLxQS2P9A-1; Mon, 24 Feb 2025 16:17:50 -0500
X-MC-Unique: E31NEYucPV2_aQLxQS2P9A-1
X-Mimecast-MFC-AGG-ID: E31NEYucPV2_aQLxQS2P9A_1740431869
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f4e47d0b2so2249687f8f.2
        for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 13:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431869; x=1741036669;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+pfaFYnZrGg4aP81g3fvxtKUOG+gZ00codvuI9HyJP4=;
        b=UjnceTB0AlVeIMTOOUWzRRh7UHG8eZvOu4w9vVl5hLpVU12DmwZfKpJRxTjp5EBtKz
         eZxHJVIQDEW9diNKWwALbxl8ekpLYAfHgR+X2T2OsoK9AqkNriaG1irdRP9E9dpEybtS
         pwdXRAE/2hzktb7dzoRRha13dXIlsPwtw+nGIfM70Ehux7Uv8wSUH94LfJ8LTJy92Sp4
         qNmx9I9QcvelAjYpIr1WYEHJg2m/7jrb2W+xt3ghG67uXVhf2PzenuO4Nhwr/IJsBGj0
         5oFNOixM1QtCmunsmREH7OP4vgyU10vQTWpKVX2Hrj534Zt88QfZftJVGc6JGak+oQJs
         +tYg==
X-Forwarded-Encrypted: i=1; AJvYcCUTj8vkzuO8X22ML6kJPCyCnjg9wTSl+M3a3HR06f8L7tnE+pL0TlAvrFkBlF/l01ed55oovHSCSOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUDHV1+cWwhV/a/47G7D5jFEGdy2U0LuMk6306iDENM1q5xsg
	V3o87igTaWxSN8GZ7JH2TMigSao7dv8lKS5y+de/iSFAa8q5R0Or0DUq5rzQ5Smbo3pmduEJ3fK
	yPUiIBpFQXTLt5zXiHojUTpIJ+rVWW2qY3ldmXaBaHfuDw9b7myrIO7zydQ==
X-Gm-Gg: ASbGncsquZnncH4F98R5sAr7RchV9UR+ajAAul4xDRTnxCZ/sKamwe0bLha8RIgVkl9
	NJRuQKY/59N5DwB4Ed1PfAZRkIAYvlquFL7+UgTp1ZV9K/ZvKd6FHKirppdEA5RcZGDISRnKhe+
	FYIHVvFXWhOY6zrpo+uHYb5CVQoOwqzDEjQUoJh+wnvN8QWWdxlkLLeFcmXMbjSJ7QUNC3POyJM
	pyPfCLy/L9drZE85CMBJvuWvi1qcq9VM/4ahdQejvSUcqn5DFuhhNDLN+YtZ/OtJAabyX7QUMz4
	zBlcCv1S224s/tLzWahgSJ0BBAgb5fMYCyZnjHtJE/dT+WlQCZC6ITZBa/FTwVOhRizwBlTyF8s
	qn/bYXG9h/8jyg7jSCpF5OYfDpKizMnrKxRqsAO54f1c=
X-Received: by 2002:a05:6000:186c:b0:38d:eaee:3b32 with SMTP id ffacd0b85a97d-38f6e977bb1mr11433792f8f.26.1740431868847;
        Mon, 24 Feb 2025 13:17:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG33QLU4MJ0xSM0Xmwfzw/OZoX0OLRfIElZNAkzclFnmmRRtf6dMGVpb0BdzzxB/d4Ljuls4Q==
X-Received: by 2002:a05:6000:186c:b0:38d:eaee:3b32 with SMTP id ffacd0b85a97d-38f6e977bb1mr11433771f8f.26.1740431868431;
        Mon, 24 Feb 2025 13:17:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cb08sm150988f8f.29.2025.02.24.13.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 13:17:48 -0800 (PST)
Message-ID: <cca2a98f-b6bc-44d6-a34d-c840f34dfd11@redhat.com>
Date: Mon, 24 Feb 2025 22:17:46 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] fs/proc/task_mmu: remove per-page mapcount
 dependency for smaps/smaps_rollup (CONFIG_NO_PAGE_MAPCOUNT)
To: Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
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
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-20-david@redhat.com>
 <D80Z3H6NZARU.1HP5EKXOJ68QH@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D80Z3H6NZARU.1HP5EKXOJ68QH@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 21:53, Zi Yan wrote:
> On Mon Feb 24, 2025 at 11:56 AM EST, David Hildenbrand wrote:
>> Let's implement an alternative when per-page mapcounts in large folios are
>> no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>>
>> When computing the output for smaps / smaps_rollups, in particular when
>> calculating the USS (Unique Set Size) and the PSS (Proportional Set Size),
>> we still rely on per-page mapcounts.
>>
>> To determine private vs. shared, we'll use folio_likely_mapped_shared(),
>> similar to how we handle PM_MMAP_EXCLUSIVE. Similarly, we might now
>> under-estimate the USS and count pages towards "shared" that are
>> actually "private" ("exclusively mapped").
>>
>> When calculating the PSS, we'll now also use the average per-page
>> mapcount for large folios: this can result in both, an over-estimation
>> and an under-estimation of the PSS. The difference is not expected to
>> matter much in practice, but we'll have to learn as we go.
>>
>> We can now provide folio_precise_page_mapcount() only with
>> CONFIG_PAGE_MAPCOUNT, and remove one of the last users of per-page
>> mapcounts when CONFIG_NO_PAGE_MAPCOUNT is enabled.
>>
>> Document the new behavior.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   Documentation/filesystems/proc.rst | 13 +++++++++++++
>>   fs/proc/internal.h                 |  8 ++++++++
>>   fs/proc/task_mmu.c                 | 17 +++++++++++++++--
>>   3 files changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>> index 1aa190017f796..57d55274a1f42 100644
>> --- a/Documentation/filesystems/proc.rst
>> +++ b/Documentation/filesystems/proc.rst
>> @@ -506,6 +506,19 @@ Note that even a page which is part of a MAP_SHARED mapping, but has only
>>   a single pte mapped, i.e.  is currently used by only one process, is accounted
>>   as private and not as shared.
>>   
>> +Note that in some kernel configurations, all pages part of a larger allocation
>> +(e.g., THP) might be considered "shared" if the large allocation is
>> +considered "shared": if not all pages are exclusive to the same process.
>> +Further, some kernel configurations might consider larger allocations "shared",
>> +if they were at one point considered "shared", even if they would now be
>> +considered "exclusive".
>> +
>> +Some kernel configurations do not track the precise number of times a page part
>> +of a larger allocation is mapped. In this case, when calculating the PSS, the
>> +average number of mappings per page in this larger allocation might be used
>> +as an approximation for the number of mappings of a page. The PSS calculation
>> +will be imprecise in this case.
>> +
>>   "Referenced" indicates the amount of memory currently marked as referenced or
>>   accessed.
>>   
>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>> index 16aa1fd260771..70205425a2daa 100644
>> --- a/fs/proc/internal.h
>> +++ b/fs/proc/internal.h
>> @@ -143,6 +143,7 @@ unsigned name_to_int(const struct qstr *qstr);
>>   /* Worst case buffer size needed for holding an integer. */
>>   #define PROC_NUMBUF 13
>>   
>> +#ifdef CONFIG_PAGE_MAPCOUNT
>>   /**
>>    * folio_precise_page_mapcount() - Number of mappings of this folio page.
>>    * @folio: The folio.
>> @@ -173,6 +174,13 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
>>   
>>   	return mapcount;
>>   }
>> +#else /* !CONFIG_PAGE_MAPCOUNT */
>> +static inline int folio_precise_page_mapcount(struct folio *folio,
>> +		struct page *page)
>> +{
>> +	BUILD_BUG();
>> +}
>> +#endif /* CONFIG_PAGE_MAPCOUNT */
>>   
>>   /**
>>    * folio_average_page_mapcount() - Average number of mappings per page in this
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index d7ee842367f0f..7ca0bc3bf417d 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -707,6 +707,8 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>   	struct folio *folio = page_folio(page);
>>   	int i, nr = compound ? compound_nr(page) : 1;
>>   	unsigned long size = nr * PAGE_SIZE;
>> +	bool exclusive;
>> +	int mapcount;
>>   
>>   	/*
>>   	 * First accumulate quantities that depend only on |size| and the type
>> @@ -747,18 +749,29 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>   				      dirty, locked, present);
>>   		return;
>>   	}
>> +
>> +	if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
>> +		mapcount = folio_average_page_mapcount(folio);
> 
> This seems inconsistent with how folio_average_page_mapcount() is used
> in patch 16 and 18.

It only looks that way. Note that the code below only does

>>   		if (mapcount >= 2)
>>   			pss /= mapcount;

Having it as 0 or 1 doesn't matter in that regard.

Thanks!

-- 
Cheers,

David / dhildenb


