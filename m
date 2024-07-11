Return-Path: <linux-api+bounces-1956-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E692F1F5
	for <lists+linux-api@lfdr.de>; Fri, 12 Jul 2024 00:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A618E2842AA
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 22:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082B01A00FE;
	Thu, 11 Jul 2024 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrdWg0/U"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B416EB4E
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736964; cv=none; b=I4IsNIwGaot4fM+8U55x9fBAc/sd95SUYfi3W9x9nKQPb+UwjQBLRi4o4mkRON4QvnyyvYfpi37eMS+bAWDSD8R9WA40VZbkKrAYoyvngn6J50bKSfG3QvrrXk0OLNnvaMbqsrfae+5/C4dc35ZDEfUTH/lptt2jYK42iMFkyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736964; c=relaxed/simple;
	bh=WWkBDQdzh3njbJuzudzTlTiHwd4ekS0EVCYXKrvOnJQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B5ECTKThDATDVW6o9NdNpH1xDuUCvYNH7mUweq5SJApmw1DK3xXg5tuQZJYLndWH1yYwH8Ej5j+nJT3ILR9eFwlVgywFNfD+FzGQtC5fXXzgMbbHV3/j8DwGq/ngC9Y8oqzwYPdsEHd/v9Uuv2ibA8qPBN1njJjjHSG597sBSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrdWg0/U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720736962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8suwGbZaDEfaEhHxk+SPcUQE6Zt9W0rGkYpluhSm8MY=;
	b=DrdWg0/U4ZStQqd/g66Jp8WMutS4F30KBl4UOf6nal999oRjmPiMls/vL0w1k6LOMVR8BQ
	Gi1rQoTY5/O93M5etSslUX8+ZPWTOVzqrfH/KdAInSnK3CPwpXBpnMXDYarVKj3EEgrtoS
	ZTi3IT+EkSlbSTBaGbk9RFKB24Rj/Ck=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-9kzrJqNjMTqa42c8UAT--g-1; Thu, 11 Jul 2024 18:29:21 -0400
X-MC-Unique: 9kzrJqNjMTqa42c8UAT--g-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70b1808deeaso1335116b3a.1
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 15:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720736960; x=1721341760;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8suwGbZaDEfaEhHxk+SPcUQE6Zt9W0rGkYpluhSm8MY=;
        b=by6jS8WSgBeX7eCX1s/taxIuUKGMsVkRHDyjKhGvraDX7Boxw9RxXYGym5xslc25SS
         NqSZeJBBUMbpXFTb/g6Tk1gRNvBS1dxxWQYmOWVCzzvxFosuhtxq+1gIwuViLRzZE+s+
         WmhutRAV08LZfcFqZMRk58/vbNft9N3JcXcum4GzOq4/XqHXm+shPbOznYQ6eW/7f6WO
         +asOeviCy5iZA1rszszw0M1HFtu8MRW79zBtLbdb6WstYR0+2d67BgRzv2TohNwvMBio
         RVDCdCH9F3mGYwd4PgQy1Ks6/cMkLG2hI2RxZ2HoDEQ72y64+gBFJPF2eBT6PRoW2QJ9
         cNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWImmkwUL951+dV9V53SIpdg1k4AYpoADNCK1vAle6ByNc1htjjrH2+7ED4VvrA1FbJEmLt70Z4hviMtR6lcLSB0WcFYGjEOE1W
X-Gm-Message-State: AOJu0Yxjl6dtdqSzckn8r1Ej4XJtZCIwcD/gvQGooP8H2enldozpY80n
	CvHWf8aHem6MnfcNjfZoCPVhC4VvNXAvcVcqQSDv/t1RoB/yUCPr45tVpuz+t3JTllTmpivc8uO
	ICSwFwqbkaJ1/Z+/HhONlT0flcuQuLD+GsA+trVSS6d94jCwy7mIvYAVQOQ==
X-Received: by 2002:a05:6a00:1387:b0:705:a600:31da with SMTP id d2e1a72fcca58-70b435f628bmr11966944b3a.23.1720736960234;
        Thu, 11 Jul 2024 15:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgxrcFMxU09Qc3/IvccbRFptfU3EUxrhjacGDTiDAHwqY4HWSq/pqfbnxMnMrO7ubxDKoWlw==
X-Received: by 2002:a05:6a00:1387:b0:705:a600:31da with SMTP id d2e1a72fcca58-70b435f628bmr11966921b3a.23.1720736959751;
        Thu, 11 Jul 2024 15:29:19 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438ed892sm6365205b3a.96.2024.07.11.15.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 15:29:19 -0700 (PDT)
Message-ID: <5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com>
Date: Fri, 12 Jul 2024 00:29:17 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
From: David Hildenbrand <david@redhat.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, tglx@linutronix.de
Cc: linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <20240709130513.98102-1-Jason@zx2c4.com>
 <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.24 05:27, David Hildenbrand wrote:
> On 09.07.24 15:05, Jason A. Donenfeld wrote:
>> The vDSO getrandom() implementation works with a buffer allocated with a
>> new system call that has certain requirements:
>>
>> - It shouldn't be written to core dumps.
>>     * Easy: VM_DONTDUMP.
>> - It should be zeroed on fork.
>>     * Easy: VM_WIPEONFORK.
>>
>> - It shouldn't be written to swap.
>>     * Uh-oh: mlock is rlimited.
>>     * Uh-oh: mlock isn't inherited by forks.
>>
>> It turns out that the vDSO getrandom() function has three really nice
>> characteristics that we can exploit to solve this problem:
>>
>> 1) Due to being wiped during fork(), the vDSO code is already robust to
>>      having the contents of the pages it reads zeroed out midway through
>>      the function's execution.
>>
>> 2) In the absolute worst case of whatever contingency we're coding for,
>>      we have the option to fallback to the getrandom() syscall, and
>>      everything is fine.
>>
>> 3) The buffers the function uses are only ever useful for a maximum of
>>      60 seconds -- a sort of cache, rather than a long term allocation.
>>
>> These characteristics mean that we can introduce VM_DROPPABLE, which
>> has the following semantics:
>>
>> a) It never is written out to swap.
>> b) Under memory pressure, mm can just drop the pages (so that they're
>>      zero when read back again).
>> c) It is inherited by fork.
>> d) It doesn't count against the mlock budget, since nothing is locked.
>>
>> This is fairly simple to implement, with the one snag that we have to
>> use 64-bit VM_* flags, but this shouldn't be a problem, since the only
>> consumers will probably be 64-bit anyway.
>>
>> This way, allocations used by vDSO getrandom() can use:
>>
>>       VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE
>>
>> And there will be no problem with using memory when not in use, not
>> wiping on fork(), coredumps, or writing out to swap.
>>
>> In order to let vDSO getrandom() use this, expose these via mmap(2) as
>> MAP_DROPPABLE.
>>
>> Finally, the provided self test ensures that this is working as desired.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> 
> I'll try to think of some corner cases we might be missing.

Sorry that I keep coming up with corner cases :) But these should be easy to handle:

1) We should disallow KSM.

diff --git a/mm/ksm.c b/mm/ksm.c
index df6bae3a5a2c..d6744183ba41 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -713,7 +713,7 @@ static bool vma_ksm_compatible(struct vm_area_struct *vma)
  {
         if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
                              VM_IO      | VM_DONTEXPAND | VM_HUGETLB |
-                            VM_MIXEDMAP))
+                            VM_MIXEDMAP | VM_DROPPABLE))
                 return false;           /* just ignore the advice */
  
         if (vma_is_dax(vma))


We don't want to suddenly get pages that are swapbacked.


2) We should disable userfaultfd

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 05d59f74fc88..a12bcf042551 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -218,6 +218,9 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
  {
         vm_flags &= __VM_UFFD_FLAGS;
  
+       if (vm_flags & VM_DROPPABLE)
+               return false;
+
         if ((vm_flags & VM_UFFD_MINOR) &&
             (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
                 return false;


Otherwise someone could place swapbacked pages in there (using UFFDIO_MOVE)
I think. But conceptually, I don't think userfaultfd might not make sense at
all with uffd. And if there are good reasons for it in the future, we could
enable the parts that make sense.


I think other places like khugepaged should handle it correctly (not set
swapbacked) due to your changes to folio_add_new_anon_rmap().

-- 
Cheers,

David / dhildenb


