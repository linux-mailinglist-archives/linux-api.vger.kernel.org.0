Return-Path: <linux-api+bounces-1949-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1496292EFFC
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB6D1F207C6
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088C16D321;
	Thu, 11 Jul 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuZege+w"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC85450FA
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727636; cv=none; b=P0fDbTyvc4MdrsZYSj1Zfrc3oI4b09iojTwPlxIzs/LTfVx1WGYn4YfA2UI+P3o5kXqgvXqRNHkZZSKZu+0ArFBQ2lOnGSJEPIuOFbLlwzGUt8PpctzsN/yamSzDwbBe2IPJRzEGUdoDM+q1emxQVSBKp6Kfr5RZk4bJMng2m7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727636; c=relaxed/simple;
	bh=Co4U5qfOVFbz4KP89a6YM4RcuM7RvrAV6qfB3tKNxHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drKbgaLR4W13Xbe7QbRySeiiWFiMFSbUN2nfAZwQouEkzqngmb9I60iLHW7zwE3I23hD2u1P6yvsA0W3liQTT3KobRTqSxsZOJhqoNJOxK/3sU/k/A0VpDy2/Q+bIVjjPhTi5hmSD9+exjr5dwOjgVn31tsIOScv8RnwhR/zxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fuZege+w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720727632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AdkZLuBHAFu1NlBWQ528vXW6pSbswVbwFYHsGJnllJc=;
	b=fuZege+w7ug0zC/mExMsepBeLtwgcuqyUW7sFXqs9LB9CywFIiEG+oGajwxtX51u5o0t5R
	xkGOI3S75bcpSiTVDTlsfqdtEubZwJpQMkUHLDGgnzynHNzbin8qzZWxKDLCDGZXwKLf5t
	HMKuHeSZVy77WUHxjPf1wVUgGVMN3po=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-bYoWIi4kPjK9Rb9IFPLoDQ-1; Thu, 11 Jul 2024 15:53:51 -0400
X-MC-Unique: bYoWIi4kPjK9Rb9IFPLoDQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70af28c2665so1303547b3a.0
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 12:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720727630; x=1721332430;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AdkZLuBHAFu1NlBWQ528vXW6pSbswVbwFYHsGJnllJc=;
        b=G+v6osPK1IrHS9AfWWHk9HQblF1p0dRZbfktU7Z6zDJvLNEY5C30szQHppmAxhLpR+
         1hTeFs8NxZYRovcyjZqSnP/c+C3wIxpMmLPK7YvImtom9NfIOFIafqIT9FgdoAaomocI
         Qe2QBrFYOJmx92pwGoK6odCwEa59bfYy45SGdwq2MYKrCuN2ApdIYjJXEbSjVdX/s8C+
         zR1clGR6MAvJgwc0bJEFEiEwUSu+c1Wfkej887GOXr++XOwKNa98plTvEWMAWZkDSw84
         g/gu61iTdS5anLjX8/X74g9KLSy+D57xqnjFDoOHzb8R5L1MLoldgmBQ4fpoVHa87DXB
         O86g==
X-Forwarded-Encrypted: i=1; AJvYcCVOogObyPzzyfSRr6B04CcS/Ypv2i1j60HUtQSDsGdm4Qafh3I3Xei2U9PhWafd45tcjQAGILkY3HRjoIpw0jX877sCUEY5uIkp
X-Gm-Message-State: AOJu0YzDKqxzK7f3qerM8F1SqKrhfipcnocSO6ez4WfrtEf8ceqHaqnr
	27Bo1y+0DbBxXT97fF5d8B0XXiCFFF0J5d3FHuY0LIShkbyuhZpUVQFognEMFYcYq78rUD+yUb5
	ARorXYvoScLjgcBP9fzoifXgmaBhvzPrE5LWiXHsGk9UHShss6DlSLbKSoQ==
X-Received: by 2002:a05:6a00:1990:b0:706:8319:f239 with SMTP id d2e1a72fcca58-70b6cb7cde2mr848922b3a.11.1720727630486;
        Thu, 11 Jul 2024 12:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHljdbMwKdDehx3QiEPn7CMDa8PO73tumvsCxvQbxsfjokHDzsa+ROIQJLbymVtmsULrA7gaA==
X-Received: by 2002:a05:6a00:1990:b0:706:8319:f239 with SMTP id d2e1a72fcca58-70b6cb7cde2mr848895b3a.11.1720727630037;
        Thu, 11 Jul 2024 12:53:50 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c6f83sm6074995b3a.82.2024.07.11.12.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 12:53:49 -0700 (PDT)
Message-ID: <da3ea234-d6dd-4809-b2f5-fbfedacb9748@redhat.com>
Date: Thu, 11 Jul 2024 21:53:48 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: Yu Zhao <yuzhao@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de,
 linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com> <ZpATx21F_01SBRnO@zx2c4.com>
 <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
 <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com>
 <ZpAcWvij59AzUD9u@zx2c4.com> <ZpAc118_U7p3u2gZ@zx2c4.com>
 <ZpAfigBHfHdVeyNO@zx2c4.com>
 <8586b19c-2e14-4164-888f-8c3b86f3f963@redhat.com>
 <ZpAqbh3TnB9hIRRh@zx2c4.com>
 <443146f4-9db8-4a19-91f1-b6822fad8ce8@redhat.com>
 <1c8632b4-06a5-49da-be0c-6fc7ac2b3257@redhat.com>
 <2c464271-1c61-4cd8-bd4e-4bd8aa01fa00@redhat.com>
 <CAOUHufYsxCb=taWWfUbuzi1Hmmug=ThQMoTjsxrtFkt=UXEu6w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAOUHufYsxCb=taWWfUbuzi1Hmmug=ThQMoTjsxrtFkt=UXEu6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.07.24 21:49, Yu Zhao wrote:
> On Thu, Jul 11, 2024 at 1:20 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 11.07.24 21:18, David Hildenbrand wrote:
>>> On 11.07.24 20:56, David Hildenbrand wrote:
>>>> On 11.07.24 20:54, Jason A. Donenfeld wrote:
>>>>> On Thu, Jul 11, 2024 at 08:24:07PM +0200, David Hildenbrand wrote:
>>>>>>> And PG_large_rmappable seems to only be used for hugetlb branches.
>>>>>>
>>>>>> It should be set for THP/large folios.
>>>>>
>>>>> And it's tested too, apparently.
>>>>>
>>>>> Okay, well, how disappointing is this below? Because I'm running out of
>>>>> tricks for flag reuse.
>>>>>
>>>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>>>> index b9e914e1face..c1ea49a7f198 100644
>>>>> --- a/include/linux/page-flags.h
>>>>> +++ b/include/linux/page-flags.h
>>>>> @@ -110,6 +110,7 @@ enum pageflags {
>>>>>              PG_workingset,
>>>>>              PG_error,
>>>>>              PG_owner_priv_1,        /* Owner use. If pagecache, fs may use*/
>>>>> +   PG_owner_priv_2,
>>>>
>>>> Oh no, no new page flags please :)
>>>>
>>>> Maybe just follow what Linux suggested: pass vma to pte_dirty() and
>>>> always return false for these special VMAs.
>>>
>>> ... or look into removing that one case that gives us headake.
>>>
>>> No idea what would happen if we do the following:
>>>
>>> CCing Yu Zhao.
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 0761f91b407f..d1dfbd4fd38d 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -4280,14 +4280,9 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
>>>                    return true;
>>>            }
>>>
>>> -       /* dirty lazyfree */
>>> -       if (type == LRU_GEN_FILE && folio_test_anon(folio) && folio_test_dirty(folio)) {
>>> -               success = lru_gen_del_folio(lruvec, folio, true);
>>> -               VM_WARN_ON_ONCE_FOLIO(!success, folio);
>>> -               folio_set_swapbacked(folio);
>>> -               lruvec_add_folio_tail(lruvec, folio);
>>> -               return true;
>>> -       }
>>> +       /* lazyfree: we may not be allowed to set swapbacked: MAP_DROPPABLE */
>>> +       if (type == LRU_GEN_FILE && folio_test_anon(folio) && folio_test_dirty(folio))
>>> +               return false;
> 
> This is an optimization to avoid an unnecessary trip to
> shrink_folio_list(), so it's safe to delete the entire 'if' block, and
> that would be preferable than leaving a dangling 'if'.

Great, thanks.

> 
>> Note that something is unclear to me: are we maybe running into that
>> code also if folio_set_swapbacked() is already set and we are not in the
>> lazyfree path (in contrast to what is documented)?
> 
> Not sure what you mean: either rmap sees pte_dirty() and does
> folio_mark_dirty() and then folio_set_swapbacked(); or MGLRU does the
> same sequence, with the first two steps in walk_pte_range() and the
> last one here.

Let me rephrase:

Checking for lazyfree is

"folio_test_anon(folio) && !folio_test_swapbacked(folio)"

Testing for dirtied lazyfree is

"folio_test_anon(folio) && !folio_test_swapbacked(folio) &&
  folio_test)dirty(folio)"

So I'm wondering about the missing folio_test_swapbacked() test.

-- 
Cheers,

David / dhildenb


