Return-Path: <linux-api+bounces-3399-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5932A69308
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 16:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B2C1B66517
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B451B0F33;
	Wed, 19 Mar 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4YltSxg"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039F8528E
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395988; cv=none; b=FY0YQ3n0fAQjcTmyQ2qS+rgmOFl8S8SBWv4JLD71U288Zk8s/EVX0996FISDPIyUZGu/jZg48d93bSqzjCyFZGhLUr070MOPFVi30l+K5+0kD35bqqVM14yI17jBDHhsEbRuon2ICpE6e7/ZX2jG/Fyvvsruyn4bmGH224KeaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395988; c=relaxed/simple;
	bh=YOgi5A0ie19P8MA4Y6lQRqa4t3xJ5eTeJCjFRTg09QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdjiojBdNzCkJiLYD8PgMSSUZ+UEqZrpamjAK9BdvrqUNwyTeE5xa9eKj4lXtrkIKBte12mU+MQl14j1/pgddGpTUsKq37ra4+glUpeUVMNluvOvR0tPbhtH9ixtlAq0meJsrbUZorzFvLG5uDz4TUpc3N8NpVyKZkM0Mvh+e0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4YltSxg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742395986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xw9nEI8IIkPA7FZEqnNHbNY1dgUSXzG2QKz9ZdPxI04=;
	b=E4YltSxgQSx69Qr7gyZWOSKpwTgN8V+dFoNHpD2KmMj5iGBVVahUtSKXNdThIH5TmGLRdb
	Wz43MNP0PsOiyoQ1G2cW2Ee400ruKzOd8MkWGo0Ob3jWfSHfGRx4xOLU1qBYpr0glD6f9o
	GO/pci4YM1jZ7vJwma9DEIju+FHj1eM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-LZ6SSn_VMui-AR3TtzV0Ug-1; Wed, 19 Mar 2025 10:53:04 -0400
X-MC-Unique: LZ6SSn_VMui-AR3TtzV0Ug-1
X-Mimecast-MFC-AGG-ID: LZ6SSn_VMui-AR3TtzV0Ug_1742395983
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912b54611dso4652061f8f.1
        for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 07:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395983; x=1743000783;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xw9nEI8IIkPA7FZEqnNHbNY1dgUSXzG2QKz9ZdPxI04=;
        b=rdE0kfTyueE+o4nIlvVYY8/YjkR2f613IxKI2t/OOGNwWrIz3BnCYFQjPi4dWMdx+q
         An/1J5mSX76K52MVdogWS8/bIishfIrexbTnZN3G6Q9OT+1jXxnhHFuTiBR+vqAe5Xl7
         cVVRNPgrQ8uazmcwYpEUpE0qwzR/jjRPP3cFDqpNB3EfSAv9IKgS1Mt8aboyOcF2WAY2
         p09ZUD49sfrNB3YFny4aayWvBFGKaUaQuWsb/CjUQSwTYO4WpfR5Sblu6fu2BAqZqBeX
         fD24ip0urspEL31oigwQgv8rPawo1GxVG6ehaAy3snVYUT7RC1dJp6TdFDX0svJ1yIg3
         BZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMwoXhfaLAtX0Yka5PNfN+PDPjkh1jHyKU9U+AbeP0AbqDjc5q/8RBeZnF4WPMpjv+r7WMr/IF7+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqqDPeyzdl4rCLKnoIitWXsWzxyxmEyNqP2p9oHF/nvI58VCF5
	+SV/I60OxHStJQOtvH4HMcGHYHP1xzygDFaCqDfaVUbNMrClPBjHBceK1ibC7Cb5lhakj/fG2BH
	CL1h+eIQqZfxm2W+WHiOAEwz7SlyB7KK504pdjQaSdqjDAwkYinltcXdwFw==
X-Gm-Gg: ASbGnctamjhpnwlnhIivWLMa5+Ceem5RvDQNTU8Kwo7zNp1LVlOvNIOLHhYngIfF6mH
	wdqu1tdjJY5oE6E0hfiirme0WMyYbuK2IuW32RaQ7aq3o5DppHNyhuN/wBkwH/kSzPhBAy+u4rZ
	Zm0ac/c0r4aK0C1n7NpLY2rJJ3RfbhF+HQkxg+R9W6cw7NwGTxx8LMm6GZZ9mhJ0PSq4NHC1Snv
	RKyZ3j7hqZN6QmJeCa9ddYXXHYkSzuvv3fb2R7xUwyXGmxzA41/Ci3QtbdpBMOESFv6EkG8KSPe
	VpwTtTSWy0XZi2ZiwsONlNAxwQy+277GQxt5S+lhN6d+xCrsymkChY6jP11jcxXHHXevYBOhEYZ
	LQumwFzY1LEavsrBkMYneAi5kH0cZcjgwbp+z08DYxKo=
X-Received: by 2002:adf:a454:0:b0:391:2da8:6e26 with SMTP id ffacd0b85a97d-39973b2dd47mr2031556f8f.52.1742395983174;
        Wed, 19 Mar 2025 07:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJMAACTGpkCFiqQxHj3Q309SaEdbRnKCTQelHyBGMvo5k8U+IEeQ59SOBOaeKpEwVVgqZDCQ==
X-Received: by 2002:adf:a454:0:b0:391:2da8:6e26 with SMTP id ffacd0b85a97d-39973b2dd47mr2031533f8f.52.1742395982663;
        Wed, 19 Mar 2025 07:53:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:df00:67e8:5c3d:de72:4929? (p200300cbc705df0067e85c3dde724929.dip0.t-ipconnect.de. [2003:cb:c705:df00:67e8:5c3d:de72:4929])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f58ab6sm21011405e9.23.2025.03.19.07.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 07:53:01 -0700 (PDT)
Message-ID: <278393de-2729-4ed0-822c-87f33c7ce27e@redhat.com>
Date: Wed, 19 Mar 2025 15:52:56 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] implement lightweight guard pages
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com,
 akpm@linux-foundation.org, arnd@kernel.org, brauner@kernel.org,
 chris@zankel.net, deller@gmx.de, hch@infradead.org, jannh@google.com,
 jcmvbkbc@gmail.com, jeffxu@chromium.org, jhubbard@nvidia.com,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mattst88@gmail.com, muchun.song@linux.dev, paulmck@kernel.org,
 richard.henderson@linaro.org, shuah@kernel.org, sidhartha.kumar@oracle.com,
 surenb@google.com, tsbogend@alpha.franken.de, vbabka@suse.cz,
 willy@infradead.org, criu@lists.linux.dev, Andrei Vagin <avagin@gmail.com>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
 <zihwmp67m2lpuxbfktmztvjdyap7suzd75dowlw4eamu6bhjf3@6euydiqowc7h>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <zihwmp67m2lpuxbfktmztvjdyap7suzd75dowlw4eamu6bhjf3@6euydiqowc7h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.03.25 15:50, Alexander Mikhalitsyn wrote:
> On Mon, Oct 28, 2024 at 02:13:26PM +0000, Lorenzo Stoakes wrote:
>> Userland library functions such as allocators and threading implementations
>> often require regions of memory to act as 'guard pages' - mappings which,
>> when accessed, result in a fatal signal being sent to the accessing
>> process.
>>
>> The current means by which these are implemented is via a PROT_NONE mmap()
>> mapping, which provides the required semantics however incur an overhead of
>> a VMA for each such region.
>>
>> With a great many processes and threads, this can rapidly add up and incur
>> a significant memory penalty. It also has the added problem of preventing
>> merges that might otherwise be permitted.
>>
>> This series takes a different approach - an idea suggested by Vlasimil
>> Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the
>> provenance becomes a little tricky to ascertain after this - please forgive
>> any omissions!)  - rather than locating the guard pages at the VMA layer,
>> instead placing them in page tables mapping the required ranges.
>>
>> Early testing of the prototype version of this code suggests a 5 times
>> speed up in memory mapping invocations (in conjunction with use of
>> process_madvise()) and a 13% reduction in VMAs on an entirely idle android
>> system and unoptimised code.
>>
>> We expect with optimisation and a loaded system with a larger number of
>> guard pages this could significantly increase, but in any case these
>> numbers are encouraging.
>>
>> This way, rather than having separate VMAs specifying which parts of a
>> range are guard pages, instead we have a VMA spanning the entire range of
>> memory a user is permitted to access and including ranges which are to be
>> 'guarded'.
>>
>> After mapping this, a user can specify which parts of the range should
>> result in a fatal signal when accessed.
>>
>> By restricting the ability to specify guard pages to memory mapped by
>> existing VMAs, we can rely on the mappings being torn down when the
>> mappings are ultimately unmapped and everything works simply as if the
>> memory were not faulted in, from the point of view of the containing VMAs.
>>
>> This mechanism in effect poisons memory ranges similar to hardware memory
>> poisoning, only it is an entirely software-controlled form of poisoning.
>>
>> The mechanism is implemented via madvise() behaviour - MADV_GUARD_INSTALL
>> which installs page table-level guard page markers - and
>> MADV_GUARD_REMOVE - which clears them.
>>
>> Guard markers can be installed across multiple VMAs and any existing
>> mappings will be cleared, that is zapped, before installing the guard page
>> markers in the page tables.
>>
>> There is no concept of 'nested' guard markers, multiple attempts to install
>> guard markers in a range will, after the first attempt, have no effect.
>>
>> Importantly, removing guard markers over a range that contains both guard
>> markers and ordinary backed memory has no effect on anything but the guard
>> markers (including leaving huge pages un-split), so a user can safely
>> remove guard markers over a range of memory leaving the rest intact.
>>
>> The actual mechanism by which the page table entries are specified makes
>> use of existing logic - PTE markers, which are used for the userfaultfd
>> UFFDIO_POISON mechanism.
>>
>> Unfortunately PTE_MARKER_POISONED is not suited for the guard page
>> mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
>> handler, so we add our own specific PTE_MARKER_GUARD and adapt existing
>> logic to handle it.
>>
>> We also extend the generic page walk mechanism to allow for installation of
>> PTEs (carefully restricted to memory management logic only to prevent
>> unwanted abuse).
>>
>> We ensure that zapping performed by MADV_DONTNEED and MADV_FREE do not
>> remove guard markers, nor does forking (except when VM_WIPEONFORK is
>> specified for a VMA which implies a total removal of memory
>> characteristics).
>>
>> It's important to note that the guard page implementation is emphatically
>> NOT a security feature, so a user can remove the markers if they wish. We
>> simply implement it in such a way as to provide the least surprising
>> behaviour.
>>
>> An extensive set of self-tests are provided which ensure behaviour is as
>> expected and additionally self-documents expected behaviour of guard
>> ranges.
> 
> Dear Lorenzo,
> Dear colleagues,
> 
> sorry about raising an old thread.
> 
> It looks like this feature is now used in glibc [1]. And we noticed failures in CRIU [2]
> CI on Fedora Rawhide userspace. Now a question is how we can properly detect such
> "guarded" pages from user space. As I can see from MADV_GUARD_INSTALL implementation,
> it does not modify VMA flags anyhow, but only page tables. It means that /proc/<pid>/maps
> and /proc/<pid>/smaps interfaces are useless in this case. (Please, correct me if I'm missing
> anything here.)
> 
> I wonder if you have any ideas / suggestions regarding Checkpoint/Restore here. We (CRIU devs) are happy
> to develop some patches to bring some uAPI to expose MADV_GUARDs, but before going into this we decided
> to raise this question in LKML.


See [1] and [2]

[1] 
https://lkml.kernel.org/r/cover.1740139449.git.lorenzo.stoakes@oracle.com
[2] https://lwn.net/Articles/1011366/


-- 
Cheers,

David / dhildenb


