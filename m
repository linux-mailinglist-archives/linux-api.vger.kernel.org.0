Return-Path: <linux-api+bounces-3377-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE5A4FBF5
	for <lists+linux-api@lfdr.de>; Wed,  5 Mar 2025 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C811892BE0
	for <lists+linux-api@lfdr.de>; Wed,  5 Mar 2025 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A24207656;
	Wed,  5 Mar 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZh3vfUL"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9A2063F8
	for <linux-api@vger.kernel.org>; Wed,  5 Mar 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170602; cv=none; b=Z8+i5tWgQ/xp9Zu7MigrE7uDCSXkoDTtmzpHhdUzvnuO9yXQ/Q5MlDzCKoyQuTZKFOzc30r3rMtgYyRiEJ+XGH8+ihTjF9aJmVX8SbQx3me0j092QxnSjn7jTkrUhJsOkxr/bH12ZYW80vZ/yL/01uoSlFUKcwUkkrFtdf2u3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170602; c=relaxed/simple;
	bh=ZIqceabQfJX8R/JGfPkeny57EsKqNJLvxvryLCwHQ+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkzEgyiXo2hKhyfKQ0S7GD3j+qwksN3cw2A9sQeNPwI9trRb8McnaU2DkumPx6qOfc9jcm+ezwSXr1WBpdif6FAOvSVSiLpWQwkg6Sb5cAkTqWn6NsZGyflazKf6fgQTLKeEEOo7g6/X1oqYLH2q6CcQ043HNL9Z1/iGr9ksAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZh3vfUL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741170599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DwfrVJB2IPkMjhKdEJbWHuXqPqDoaFm43Z3NiVADH/M=;
	b=fZh3vfULo/RqEKU58tfpvrrgZ4/Kf3F2OYBxl/+gN+g8EmimaELkfazC5U77+8785WDzG1
	TUtSQeKkk+jU9ARIarFPqkKFerURRW2Xe5o+GcbhHeVNPd45qu1lbcOU8jAM2Wm9tT3zp1
	VF6rdwqDVfMId4MH11sXzOuk2yNbYg8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-RPSG0epAOoGhOTb3XYatAA-1; Wed, 05 Mar 2025 05:29:58 -0500
X-MC-Unique: RPSG0epAOoGhOTb3XYatAA-1
X-Mimecast-MFC-AGG-ID: RPSG0epAOoGhOTb3XYatAA_1741170597
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391189236e7so1134925f8f.0
        for <linux-api@vger.kernel.org>; Wed, 05 Mar 2025 02:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170597; x=1741775397;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DwfrVJB2IPkMjhKdEJbWHuXqPqDoaFm43Z3NiVADH/M=;
        b=aW98l5CyyL+SXENYO5mG1ldBJbi1VQWEpXBz3cOKEQFx9JzyCE41+XPwRCbQVL+wZV
         X8QrOu1IdjsRZeAST9xv30EAiP9Po3g0ivknMxBaKGxHloulGkmlAfh+Ecvy2yaEmdzT
         pylQ5iapfwYWGujtiTjpxD3693yk+9TMVHljRkrzG2RpiOwbF+RVo0u1xRA6cZlLgkmL
         1U6HLHMK0iHE04rxddcUWZt4RBkI7plFo+DSuisZPAzxowcDvR0To6tTP/Uq7o6YGaqi
         SSaMAenEd7e6ng6tGT82tXnnWEiIAVFalFxtU2TYtdLMPtjvseXBQiyDhAN8OP0hZ2t8
         ex5w==
X-Forwarded-Encrypted: i=1; AJvYcCXlmn/kjBdFbMgy2uuswchMpfSqPcG+mwAftNohdWdzx3IxumKEydVhbTEC9+dFwJ1sb+tIguNwfNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDpEQ2Yj5pQvJ7XfXRddePdhuP6n0czPhGgsj3++n8bTltqOt
	zZCz99gaQGo5ZfD1G6J8eKb2p9rpY8DZuqg8t/tfv3OFgR4oXTtYphxfzz7D4qz9FuorYGzKvCA
	2RnnbSCQ1BkmaoLU3MYMw0dK33Y1Uhphso/cjRUkCUysM6F3ciXzKSSWPTA==
X-Gm-Gg: ASbGncvRcWoJD+2PFGorYS43/nZeenBJoOlY4N6akCb8FjCFbMIbP1VpPUvFcF4EEWL
	YDEOL7TlZzBxJjWjrBBzHioZy/i9kD5v7SvOoS/ocVnUkQDv/pyzfuzHc9esbeA8jbNMbsQ1jzN
	HUHnMUhknHM4h49H6tn4pYIalm5+ictqRH+sWsVu4ZFKnbLAw3typb2CYZJnfKSMQ82DGnSxK/z
	4QCQKlXD8gX25yLFnvzMsmbCmSgqgtgj/PtHtL2RJXz5ab/IBuyRposhYjE369zfd0YuPHWf+A6
	PUkhrK25+rMRq9MunHLpaJFOjceW9oC0VARHVJ0PROpA2mp1Dg==
X-Received: by 2002:a5d:6c62:0:b0:38f:503a:d93f with SMTP id ffacd0b85a97d-3911f7b349cmr1849712f8f.40.1741170596798;
        Wed, 05 Mar 2025 02:29:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWt7nqNGJWcxZ3sniy7h3PrfZcFzKDyC306gbJ7KAAn7ebAdfJmPYIrJ3yzoj/ABCPOc+44w==
X-Received: by 2002:a5d:6c62:0:b0:38f:503a:d93f with SMTP id ffacd0b85a97d-3911f7b349cmr1849668f8f.40.1741170596371;
        Wed, 05 Mar 2025 02:29:56 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a9fsm20821992f8f.36.2025.03.05.02.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 02:29:55 -0800 (PST)
Message-ID: <a97f8a91-ec41-4796-81e3-7c9e0e491ba4@redhat.com>
Date: Wed, 5 Mar 2025 11:29:54 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] mm: let _folio_nr_pages overlay memcg_data in
 first tail page
To: linux-kernel@vger.kernel.org
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
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-4-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250303163014.1128035-4-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.03.25 17:29, David Hildenbrand wrote:
> Let's free up some more of the "unconditionally available on 64BIT"
> space in order-1 folios by letting _folio_nr_pages overlay memcg_data in
> the first tail page (second folio page). Consequently, we have the
> optimization now whenever we have CONFIG_MEMCG, independent of 64BIT.
> 
> We have to make sure that page->memcg on tail pages does not return
> "surprises". page_memcg_check() already properly refuses PageTail().
> Let's do that earlier in print_page_owner_memcg() to avoid printing
> wrong "Slab cache page" information. No other code should touch that
> field on tail pages of compound pages.
> 
> Reset the "_nr_pages" to 0 when splitting folios, or when freeing them
> back to the buddy (to avoid false page->memcg_data "bad page" reports).
> 
> Note that in __split_huge_page(), folio_nr_pages() would stop working
> already as soon as we start messing with the subpages.
> 
> Most kernel configs should have at least CONFIG_MEMCG enabled, even if
> disabled at runtime. 64byte "struct memmap" is what we usually have
> on 64BIT.
> 
> While at it, rename "_folio_nr_pages" to "_nr_pages".
> 
> Hopefully memdescs / dynamically allocating "strut folio" in the future
> will further clean this up, e.g., making _nr_pages available in all
> configs and maybe even in small folios. Doing that should be fairly easy
> on top of this change.
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/mm.h       |  4 ++--
>   include/linux/mm_types.h | 30 ++++++++++++++++++++++--------
>   mm/huge_memory.c         | 16 +++++++++++++---
>   mm/internal.h            |  4 ++--
>   mm/page_alloc.c          |  6 +++++-
>   mm/page_owner.c          |  2 +-
>   6 files changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a743321dc1a5d..694704217df8a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1199,10 +1199,10 @@ static inline unsigned int folio_large_order(const struct folio *folio)
>   	return folio->_flags_1 & 0xff;
>   }
>   
> -#ifdef CONFIG_64BIT
> +#ifdef NR_PAGES_IN_LARGE_FOLIO
>   static inline long folio_large_nr_pages(const struct folio *folio)
>   {
> -	return folio->_folio_nr_pages;
> +	return folio->_nr_pages;
>   }
>   #else
>   static inline long folio_large_nr_pages(const struct folio *folio)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 689b2a7461892..e81be20bbabc6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -287,6 +287,11 @@ typedef struct {
>   	unsigned long val;
>   } swp_entry_t;
>   
> +#if defined(CONFIG_MEMCG) || defined(CONFIG_SLAB_OBJ_EXT)
> +/* We have some extra room after the refcount in tail pages. */
> +#define NR_PAGES_IN_LARGE_FOLIO
> +#endif
> +
>   /**
>    * struct folio - Represents a contiguous set of bytes.
>    * @flags: Identical to the page flags.
> @@ -312,7 +317,7 @@ typedef struct {
>    * @_large_mapcount: Do not use directly, call folio_mapcount().
>    * @_nr_pages_mapped: Do not use outside of rmap and debug code.
>    * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
> - * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
> + * @_nr_pages: Do not use directly, call folio_nr_pages().
>    * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
>    * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
>    * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
> @@ -377,13 +382,20 @@ struct folio {
>   			unsigned long _flags_1;
>   			unsigned long _head_1;
>   	/* public: */
> -			atomic_t _large_mapcount;
> -			atomic_t _entire_mapcount;
> -			atomic_t _nr_pages_mapped;
> -			atomic_t _pincount;
> -#ifdef CONFIG_64BIT
> -			unsigned int _folio_nr_pages;
> -#endif
> +			union {
> +				struct {
> +					atomic_t _large_mapcount;
> +					atomic_t _entire_mapcount;
> +					atomic_t _nr_pages_mapped;
> +					atomic_t _pincount;
> +				};
> +				unsigned long _usable_1[4];
> +			};
> +			atomic_t _mapcount_1;
> +			atomic_t _refcount_1;
> +#ifdef NR_PAGES_IN_LARGE_FOLIO
> +			unsigned int _nr_pages;
> +#endif /* NR_PAGES_IN_LARGE_FOLIO */
>   	/* private: the union with struct page is transitional */

@Andrew

The following on top to make htmldoc happy.

There will be two conflicts to be resolved in two patches because of
the added "/* private: " under "_pincount".

It's fairly straight forward to resolve (just keep "/* private:" below
any changes), but let me know if I should resend a v4 instead for this.


 From 9d9ff38c2ea14f1b4dab29f099ec0f6be683f3fe Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 5 Mar 2025 11:14:52 +0100
Subject: [PATCH] fixup: mm: let _folio_nr_pages overlay memcg_data in first
  tail page

Make "make htmldoc" happy by marking non-private placeholder entries
private.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/mm_types.h | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e81be20bbabc..6062c12c3871 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -381,18 +381,20 @@ struct folio {
  		struct {
  			unsigned long _flags_1;
  			unsigned long _head_1;
-	/* public: */
  			union {
  				struct {
+	/* public: */
  					atomic_t _large_mapcount;
  					atomic_t _entire_mapcount;
  					atomic_t _nr_pages_mapped;
  					atomic_t _pincount;
+	/* private: the union with struct page is transitional */
  				};
  				unsigned long _usable_1[4];
  			};
  			atomic_t _mapcount_1;
  			atomic_t _refcount_1;
+	/* public: */
  #ifdef NR_PAGES_IN_LARGE_FOLIO
  			unsigned int _nr_pages;
  #endif /* NR_PAGES_IN_LARGE_FOLIO */
-- 
2.48.1


-- 
Cheers,

David / dhildenb


