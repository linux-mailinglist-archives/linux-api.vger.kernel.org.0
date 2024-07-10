Return-Path: <linux-api+bounces-1919-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA892C96E
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2024 05:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965B81C2198E
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2024 03:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036241799B;
	Wed, 10 Jul 2024 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+2TPm4A"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761D482CD
	for <linux-api@vger.kernel.org>; Wed, 10 Jul 2024 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720583600; cv=none; b=QfNveMfwRDcuRlUL9piAvFrpWLJl3Ql077M7Ruq92/vWW5YBkJNVjDY7r6CVhESyUBsyiIeT+/CH7Md+J3m+gmTOfitCKl7a9mXi8Bqg0FGlpwrf61jViml1iurJsvnPjrMBTAza7w9b7wL5golH6pb2a43+ORBL/3NtF44N4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720583600; c=relaxed/simple;
	bh=G128oUr+qCIRBR7nowEROTw1zOSfR0auy4jqH2JVQkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPtTvmSiof7EMvyU1zjHOdoH6jZpcNpdYzHOnadsBVhk+eSn0uQfU85i4HIYgl7ILF27SsLzdI8lI4YivoTOAYhFoRlGAqxWoO8F5DvNQ/9BveHW08odwOCuB4e2UZ2q19en/ZwJ2RAczlw2bagDZ0doQqQflcSyMWPxCcqQg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+2TPm4A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720583598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8rIGnL/7yS1yko4wAcwcwoYD4aALcV2EdKmJ89sPeeo=;
	b=K+2TPm4AuNBtNSIzjyHbxOI4I5QQMSv9tdIe+mMvUKkjp17r6VQLD/Ti9TxJRAkqX3z3rY
	rR+8AsidDzg9k1Rge6OJEnAIkWKqTf5zG7DMtu19PFz9RXZgYsxL4C2kSx/4u+pkq3wsIv
	18af0B64vu2mkUlqA6IJj5BojgDc9rU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-jfo9GrkdNRaIigJBCjhGvQ-1; Tue, 09 Jul 2024 23:53:17 -0400
X-MC-Unique: jfo9GrkdNRaIigJBCjhGvQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70affd53d90so5433349b3a.1
        for <linux-api@vger.kernel.org>; Tue, 09 Jul 2024 20:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720583596; x=1721188396;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rIGnL/7yS1yko4wAcwcwoYD4aALcV2EdKmJ89sPeeo=;
        b=bOHYS+lzxkGm8GWpk0VmUurWBu/GVfuF89C+k5zW8ZxTEQxX4xM2Owj/6Z+i61wAJu
         BzDi4NctcJDAyrqiZannd0KK35a3kjKMgLYyatHXC9b2AZQs69qai9cPRC8VGDPIuVsk
         kBuSAUCHmtrSFrz1A+UxyqZviD0+M8bOLQ3FivW1o7ARpfYnyJ/vGRPHeJTmu9f98sxN
         HDsMn8x1Iyyszh3KlrkPSs8N7ekMzuqo7I43McIh2/EinMW06uuet3VA7sgxjXUiClqL
         IuHwwfpvcNimmAJE/ZoSWqqHN+qa4yHiIsvTM9hQYd24TomZ283qEXZlhBXazX+nGWWo
         Zh4w==
X-Forwarded-Encrypted: i=1; AJvYcCXSww/OIjV1pQdZTlsAcPVc92AQy5zmDZrccKIdpqbiiTUZQis+DFryCmi/pfmEdItO7uztF7QWQ42LwagJjbklYGMTxs8LeJap
X-Gm-Message-State: AOJu0YxGO+y8apgI7eLNhIUGKYTlvlk8R5q+Fio8KvZDQm+eVHFYhMyK
	pfBi8FxLU2yvmhxNlrztnSRz4lqfd2RughVdnuzwtZ8NoYvu3BYAPTq4EnYksBIFblQ/MSRJuqN
	+DNnw3qg/dHAJESgut3Hv/TaQRpOz9tQsL2wlpJ/iA8Y1qoDWHTPxHRG0cA==
X-Received: by 2002:a05:6a00:1748:b0:705:b81b:6ee2 with SMTP id d2e1a72fcca58-70b4356a698mr5890536b3a.19.1720583595921;
        Tue, 09 Jul 2024 20:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn3njPMJJBJ5F0Zt8iJ6gKpKa4GsBSnEFY4YFOmgLnTJeV0xDzKBATDsOFxABmhNHKJN8Ipw==
X-Received: by 2002:a05:6a00:1748:b0:705:b81b:6ee2 with SMTP id d2e1a72fcca58-70b4356a698mr5890525b3a.19.1720583595531;
        Tue, 09 Jul 2024 20:53:15 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43898af8sm2649036b3a.42.2024.07.09.20.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 20:53:15 -0700 (PDT)
Message-ID: <6e978965-5bfd-483d-9504-f362fdf19ec5@redhat.com>
Date: Wed, 10 Jul 2024 05:53:12 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
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
References: <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
 <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
 <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
 <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
 <Zovv4lzM38EHtnms@zx2c4.com> <Zov6SZZCKrqmigua@zx2c4.com>
 <75d6c45d-deea-464d-b0fd-b36e5d73b898@redhat.com>
 <Zoyd1DYuD7cmJbgx@zx2c4.com>
 <b71d8619-1182-43b6-940b-d68f672aa379@redhat.com>
 <Zo4BPjTIitoYSBMP@zx2c4.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zo4BPjTIitoYSBMP@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.24 05:34, Jason A. Donenfeld wrote:
> On Wed, Jul 10, 2024 at 05:05:06AM +0200, David Hildenbrand wrote:
>> On 09.07.24 04:17, Jason A. Donenfeld wrote:
>>> Hi David,
>>>
>>> On Mon, Jul 08, 2024 at 10:21:09PM +0200, David Hildenbrand wrote:
>>>> BTW, I was just trying to understand how MADV_FREE + MAP_DROPPABLE would
>>>> behave without any swap space around.
>>>>
>>>> Did you experiment with that?
>>>
>>> You mean on a system without any swap configured? That's actually my
>>> primary test environment for this. It behaves as expected: when ram
>>> fills up and the scanner is trying to reclaim what it can,
>>> folio_test_swapbacked(folio) is false, and the memory gets freed. After,
>>> reads fault in a zero page. So it's working as expected.
>>
>> Okay, just to be clear: no swap/zram/zswap. The reclaim code regarding
>> not scanning anonymous memory without swap was a bit confusing.
> 
> Right, no swap, as boring a system as can be. I've experimented with
> that behavior on my swap-less 64GB thinkpad, as well as on little
> special purpose VMs, where I hacked the VM_DROPPABLE test code into the
> wireguard test suite.

Great, thanks!

-- 
Cheers,

David / dhildenb


