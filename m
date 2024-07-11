Return-Path: <linux-api+bounces-1927-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3978192DF29
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 06:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36D91F222F7
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 04:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967A2BCE3;
	Thu, 11 Jul 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C38Y3v9V"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21421803D
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720673210; cv=none; b=G3a3Qj3ad/ysaFJ0X4iQDQMcsgMT+VO0MPZfXYP23gTT8FZ4Xu4RqiNvNoGNJGQ/ySkddxofP7VjWgLC7HN2HIa5A8k4P11SSqYeg7R6+XtTUncuIYpmTb2yhsce89JhbmmzgjLizSm9wGR4yl/zxt/X2ivOo3f4926OG9zppVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720673210; c=relaxed/simple;
	bh=+KvGXzUeKuygJalFcpujZdXr7PyCpNIHgikBySpTKi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fl+aMEnMPnlBlQFe3u2icERsy+0RvsDaHsJwMBXW++hI61k7JIGMfUNSRZaIeOOJK6COr7bqHMEGYsjR1vQM80xQhHEOhJ0Ekd1vdkxeXdqWi5Ayya98V6TfThrIijS0doJlGnMageGFVG4i1FyARaqQGaDXzma5yvHkaqIvuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C38Y3v9V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720673207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lyfoEy9OwqFj0Sb+Bhj1Pj43zQ7mqRzrMZDAP0advz0=;
	b=C38Y3v9VlUmeGoV5HGDdI9hjIgAkSGJhBStoqLHhPpwa708Ts58dl8wyllzfKGb9GfgA/r
	aMxbiXIJJaHwYx56x3shhoISoMpv9LND+hFBv2xNsNvgtsKYYf9YmRdGVatbGCIARrrQh+
	KINhxg2d/4CZ4qXZvU7vgmeJHlYTSso=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-MVwBzUOOMW-9FYxbGnptDw-1; Thu, 11 Jul 2024 00:46:44 -0400
X-MC-Unique: MVwBzUOOMW-9FYxbGnptDw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fafbde6c8cso2686675ad.3
        for <linux-api@vger.kernel.org>; Wed, 10 Jul 2024 21:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720673203; x=1721278003;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lyfoEy9OwqFj0Sb+Bhj1Pj43zQ7mqRzrMZDAP0advz0=;
        b=KkYq3bI6MQb8EafcS55x/VosgluajSL3dVMu4oVEw+Abkdl0gywhrm99LVuxaGT7SS
         QVjwzESj/B8a1XYsZwOZuAbbHiorCCdxS9O0CD1djz8HyMGzdy9UwWEiSE7IWyQloXLI
         iQ029GJAmFw9vK/ZksgUxFZMK+gBWiOmX9rNWEa7ocH44ixVA9NfsXckx1drw6RFx4s+
         Hm5HE/XZphJr/zHr90Ix76bxkOz2crGyaVCHxr/yPhucmP33rwsl+KiGlNb7KpmRBtaZ
         oQQbXVxP1EJk1Zf3HnBnhzBQRaox8poTmd/CsG5RQkV/oCRekPLAiTWeHwSnJ3qJr++G
         LPIw==
X-Forwarded-Encrypted: i=1; AJvYcCWGLtgpSxB4jPj2cLXiWLrKHshWzLO2QVf72+ejkNgydr8CaSbOHv4uX0jWmUAwCKf5PRiDDwcayoWjH5Mns4LZjE4bbtzhdGCR
X-Gm-Message-State: AOJu0YwQnh9a3f0GtWNrsQPLirNY7Vd2UW87RbYVjjriAhLgmMAZ+qBj
	yQwL4VaBRQX4SfKFRZrzRZDgKN02Hqm3YGdrwATasczMav4NkiWqyfX2qUMl4TTVG3pFAAL6xsp
	HwbTEGsDOWDSH3rcWyAvI7Ku4JsNNrggI29QtFOmPeoAOoNTMrgaaTQfBhw==
X-Received: by 2002:a17:903:11ce:b0:1fb:365:5e0 with SMTP id d9443c01a7336-1fbb6d25264mr61312155ad.14.1720673203584;
        Wed, 10 Jul 2024 21:46:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr8a+/UDzIKV6GoLXWla7TLTJFMgLIA7t+hPHot2H8qf5AANpsyZ+2DJbcMumnXPLtOqmfpg==
X-Received: by 2002:a17:903:11ce:b0:1fb:365:5e0 with SMTP id d9443c01a7336-1fbb6d25264mr61311985ad.14.1720673203056;
        Wed, 10 Jul 2024 21:46:43 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2c055sm42643835ad.104.2024.07.10.21.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 21:46:42 -0700 (PDT)
Message-ID: <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
Date: Thu, 11 Jul 2024 06:46:40 +0200
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
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
 x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <20240709130513.98102-1-Jason@zx2c4.com>
 <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
 <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com> <Zo9gXAlF-82_EYX1@zx2c4.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zo9gXAlF-82_EYX1@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 06:32, Jason A. Donenfeld wrote:
> On Thu, Jul 11, 2024 at 02:44:29AM +0200, Jason A. Donenfeld wrote:
>> Hi David,
>>
>> On Wed, Jul 10, 2024 at 06:05:34AM +0200, David Hildenbrand wrote:
>>> BTW, do we have to handle the folio_set_swapbacked() in sort_folio() as well?
>>>
>>>
>>> 	/* dirty lazyfree */
>>> 	if (type == LRU_GEN_FILE && folio_test_anon(folio) && folio_test_dirty(folio)) {
>>> 		success = lru_gen_del_folio(lruvec, folio, true);
>>> 		VM_WARN_ON_ONCE_FOLIO(!success, folio);
>>> 		folio_set_swapbacked(folio);
>>> 		lruvec_add_folio_tail(lruvec, folio);
>>> 		return true;
>>> 	}
>>>
>>> Maybe more difficult because we don't have a VMA here ... hmm
>>>
>>> IIUC, we have to make sure that no folio_set_swapbacked() would ever get
>>> performed on these folios, correct?
>>
>> Hmmm, I'm trying to figure out what to do here, and if we have to do
>> something. All three conditions in that if statement will be true for a
>> folio in a droppable mapping. That's supposed to match MADV_FREE
>> mappings.
>>
>> What is the context of this, though? It's scanning pages for good ones
>> to evict into swap, right? So if it encounters one that's an MADV_FREE
>> page, it actually just wants to delete it, rather than sending it to
>> swap. So it looks like it does just that, and then sets the swapbacked
>> bit back to true, in case the folio is used for something differnet
>> later?
>>
>> If that's correct, then I don't think we need to do anything for this
>> one.
>>
>> If that's not correct, then we'll need to propagate the droppableness
>> to the folio level. But hopefully we don't need to do that.
> 
> Looks like that's not correct. This is for pages that have been dirtied
> since calling MADV_FREE. So, hm.
> 

Maybe we can find ways of simply never marking these pages dirty, so we 
don't have to special-case that code where we don't really have a VMA at 
hand?

-- 
Cheers,

David / dhildenb


