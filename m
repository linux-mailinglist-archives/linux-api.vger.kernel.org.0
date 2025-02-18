Return-Path: <linux-api+bounces-3239-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB5FA3A446
	for <lists+linux-api@lfdr.de>; Tue, 18 Feb 2025 18:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2041672F7
	for <lists+linux-api@lfdr.de>; Tue, 18 Feb 2025 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E71270EC9;
	Tue, 18 Feb 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2t1UKTm"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4E726FA6A
	for <linux-api@vger.kernel.org>; Tue, 18 Feb 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899543; cv=none; b=dijCU8cvIggmC+bcFRdGIEy6XbcMasJvkcL+tVp3O7I++/sFTMp/dLcTJd6dTaq9y80fKaiWejtZqH9rmhbAgF9zJ55g1i7gMaB0rwcaJI0j7sqLSDXEzxA54xvd5Z5ck6BE0av6BDjPNGOolWYIP6FVeM7RN+Nhv/ki/pJdEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899543; c=relaxed/simple;
	bh=ZBmNuh8e+hGXc2RihpyjnpMDMZycLEQxzdeZb3blLC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgP2tUWiowVBVAw/E4T5uC0w5x7bEu6JHp2b5qSBuGZ7AOAhj809FnJIVlJYQTmIHBycXq8E4tGAF9LWftv2YBUkkEjNCUcr2BqnZW2Wm8+XHzYqfHBl994kT+BUGares+8Ds9d5kthCXTfMCpmR21ods2hWuHh8TTOgcyCnT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2t1UKTm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739899540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z2KIThAKSXbMAxXKkxhdA+pi6hkhBcx5GYzFEyXYhOs=;
	b=J2t1UKTmGdHgEjJXWIjGnMXt6M+INOzkQgbYoZzqdDi/B5YeFCvbJlXntF1bpfWUlOm9xc
	TbdgZgErzUDaRFo09VaNp7eLYiHvEyK/EuWr9sHLzc/aw3xIxjQJ5+9CJtFRUVLKxbmhw6
	lxIltwJ5Ir0z/1lR9vZslDYwjoomIpY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-rGKR591qOx-auTn_XTAmrw-1; Tue, 18 Feb 2025 12:25:38 -0500
X-MC-Unique: rGKR591qOx-auTn_XTAmrw-1
X-Mimecast-MFC-AGG-ID: rGKR591qOx-auTn_XTAmrw_1739899537
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394b2c19ccso47293085e9.1
        for <linux-api@vger.kernel.org>; Tue, 18 Feb 2025 09:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899537; x=1740504337;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z2KIThAKSXbMAxXKkxhdA+pi6hkhBcx5GYzFEyXYhOs=;
        b=GNrDn3h3AVdtSjgEn61179m/XRDN55KwO5Ebo8cX6FbwWUnGJI+e3rhx6xezP2FHkU
         yOdSY3QBiUwK0DftH1o1PLxCHT8agbxrJZrAtUb6kUlnk75/RFiAsvVmT2h7cv/jSJqk
         /T+6X3O3r1ZSF3X5KHH3fRDtbsM+J2g382CvJ6HWCemHgEMEWpx1FgpKlZ7SVclJbJC4
         4AGbKya9+UyzxRyWdMgywlQnP8leaqkPfUjaJ1clYAmUAE6N6OOGeIT/jQZ5aHs6/wn3
         DF9o9KjYbOP1AZtWmY0ac4MwlDfK0aMl1Erdu/tDg6Z6oaxV61q6PMbsyvsI/xHyRIL9
         crmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWKH+/XHGs1IlaHVHwjjHplzlO1fpOPK0TDWxR6k97pp+oiprxw5fYCFw+pk8lKm1wqSvh71tEzZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVK1YUJiFEBwyMi6jZwvZKEwOzhuB+ru5cxRHWJcVcAPFCkBdW
	cqwhPzXMsImpj7fVO1rtkMGD3+9qUhM2pBJy5wLeqox3Vfe3FDvDl/BSPs/VwsaAtZo6oeDKIbl
	ojp2OTUEF4gIz2dlI1w+w2fwxwNI2zCnEfznqyahq/uIvBzn9BEK8gtMJWg==
X-Gm-Gg: ASbGnctx/y+AgeOT/46Swj3wlYLYBAbVDKObTati37bPqlyfgD/Pe3fsLvHFFYRReKt
	m3Sp6c9UNIqBd55emwyON0eDWYhMl8LzWY2Ml1iAm4jXur07VRhsh0y+p/4DrmIJqgKuN/2Mrym
	XRmQFxpXMsWPPgWhFoC9xaLbiI7j3FATZ+XTytQKCB1uo3D8htlueeaBQYeeZfxGhOVKMTXHNFO
	AOV758FrWSRWytD9qsC/O9kHq1ZbWvyWo9FLPPoIVpYM1/kiSNHlQJzRIRq0bBZRbfgow6Nnxb2
	c+pJEgM7Ynaz7R40gsXRdHAmwsNKQituHBibzz7/GYsUHczDlql7keAjik5HZRovM+Q7XreCJXy
	HWMrxCWyht7AvkY9nfnVrdB4SOKhOBE8m
X-Received: by 2002:a05:600d:8:b0:439:86c4:a8ec with SMTP id 5b1f17b1804b1-43986c4ac03mr88049365e9.15.1739899537315;
        Tue, 18 Feb 2025 09:25:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGZhYvbDq2WUizrszTM8iYX04G2U/dqlmU+WV7dwgdizkRY2Js8nAXYnoDUJFl5Cc3yTHEsA==
X-Received: by 2002:a05:600d:8:b0:439:86c4:a8ec with SMTP id 5b1f17b1804b1-43986c4ac03mr88049015e9.15.1739899536896;
        Tue, 18 Feb 2025 09:25:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43995391824sm21752235e9.23.2025.02.18.09.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 09:25:36 -0800 (PST)
Message-ID: <b30a6306-d62b-4515-add8-4550d044501c@redhat.com>
Date: Tue, 18 Feb 2025 18:25:35 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
 <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
 <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
 <6eb33b5d-3040-4637-b627-48f8f78e4e28@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6eb33b5d-3040-4637-b627-48f8f78e4e28@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> QEMU, for example, will issue an mlockall(MCL_CURRENT | MCL_FUTURE); when
>> requested to then exit(); if it fails.
> 
> Hm under what circumstances? I use qemu extensively to test this stuff with
> no issues. Unless you mean it's using it in the 'host' code somehow.


-overcommit mem-lock=on

or (legacy)

-realtime mlock=on

I think.

[...]

>>>
>>> It fails because it tries to 'touch' the memory, but 'touching' guard
>>> region memory causes a segfault. This kind of breaks the idea of
>>> mlock()'ing guard regions.
>>>
>>> I think adding workarounds to make this possible in any way is not really
>>> worth it (and would probably be pretty gross).
>>>
>>> We already document that 'mlock()ing lightweight guard regions will fail'
>>> as per man page so this is all in line with that.
>>
>> Right, and I claim that supporting VM_LOCKONFAULT might likely be as easy as
>> allowing install/remove of guard regions when that flag is set.
> 
> We already allow this flag! VM_LOCKED and VM_HUGETLB are the only flags we
> disallow.


See mlock2();

SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
{
	vm_flags_t vm_flags = VM_LOCKED;

	if (flags & ~MLOCK_ONFAULT)
		return -EINVAL;

	if (flags & MLOCK_ONFAULT)
		vm_flags |= VM_LOCKONFAULT;

	return do_mlock(start, len, vm_flags);
}


VM_LOCKONFAULT always as VM_LOCKED set as well.

-- 
Cheers,

David / dhildenb


