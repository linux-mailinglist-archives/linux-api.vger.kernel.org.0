Return-Path: <linux-api+bounces-1893-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E53892AA72
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 22:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806E1B21410
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 20:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DF414B94E;
	Mon,  8 Jul 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGbbsjJ8"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB265146593
	for <linux-api@vger.kernel.org>; Mon,  8 Jul 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470078; cv=none; b=Vbo9DndDgy1NFQpfuzzmukjDVDevGvlf79GB/laCJR9Ft5u7tp7Za89iuLWoeSptPPbViwoXJinw7T7vhUReA2W4G8yhSNC4uTTykLo1k4E4QMbdigaBjF7s25yjjCWMV+A/z1sJ+WsTnVgH4aN4oYZiUvyfaR8TjAQslM1BazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470078; c=relaxed/simple;
	bh=dNXn4UIlKhRE5TBVs8kI24gLbeohXHAO07ly2n41evo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gg5EBkRpSwpRL3GqHmQH0Ww0ilMU+wnP0Pczpb+e61A4azu9zUr4uEIzDsF0sCKDeaRoG614Lr3sn8zgB82dvZQGkTuRIKAk0v9iOCEDlO6tekG/6OZuQ5/TxU7sKfbL9tPMrt+CLE8qRQA7CvOJgxii/Sd5OQsImKBtqikU8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGbbsjJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720470075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7oVPk684/Jee4fyU3Xo2I2OovbaYGuiC7tV3FtZZveo=;
	b=IGbbsjJ8V6lQOdvHi/lj7c+QhJAIbp9icpx9aA+ZU/ysIs4Ng63pd5OJ1qiRFEf6B6/e6N
	RE0aWhWG+Ri1skpKIW21jsFW7UNLcWibhOzFaJP/2zfTlSqSV3EXlj1/y80LKSXVgfM9I4
	hKmaqgbKcb9TgBh0CA4ES2XT0i+CvM4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-tpMJzqWlMSu0SLmWBLVL4w-1; Mon, 08 Jul 2024 16:21:13 -0400
X-MC-Unique: tpMJzqWlMSu0SLmWBLVL4w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42661d7c011so15307975e9.1
        for <linux-api@vger.kernel.org>; Mon, 08 Jul 2024 13:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720470072; x=1721074872;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7oVPk684/Jee4fyU3Xo2I2OovbaYGuiC7tV3FtZZveo=;
        b=qv1Ek9CT0V4vmjRfXtcfuvh2u9+x9H8gS27y2EIWKWcw816uLjZjRvM4zqcuEIY2lG
         cr83noJSBPZdLzkObNS8Y83vTFMh/dWN2zV0haJ0GvwW3AoijaJJ5s/rQaOhEeHIca1a
         VGhGvuy+iGEQ3Fkr2GQhTHNkgtHO6D4bgXF4+PDRVQYg8xrsEvA1jFUw+5SYfv806/Cx
         hflF/Q6cWxV89Uc1EXiQCTDlQR79Fh9Rcyk+Oh5OX5VBPucHTEmd+91XaZaeiiVDzYQz
         zbg7iAwGCnCHay4fnTXhtBRqEHnanq0NxdEuSwOiMXs4fYtUkinUTiZZqOIjXxk9ZAMH
         tnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrryCed9yeSuNBscTfxgTGzosV+6YbNdfxyGBWrQfZayrCuyR+16MT3L9lwgxrhz+c1xv+qIhr6cREbF1ayh12EPvNPAsi2Iml
X-Gm-Message-State: AOJu0YxWgQAwbbdu/MBKyd5qvLxZ8Napn975ZcLMSyri4ZMqZ383yOfy
	0ZJKalU1FF7RbVInEo4E0HYs8xJzXV+w7rkkf/TakBaUEE/qwMaRhVv20czxULAhm7oBCs+rz/v
	+fyJ2oHvApYEZcImUWXe0Fk3vh/yiz+lWOsGxXm0wUHcbQrjkWqw+MmB8bQ==
X-Received: by 2002:a05:600c:3209:b0:426:593c:9351 with SMTP id 5b1f17b1804b1-426707ceec7mr3883765e9.6.1720470072126;
        Mon, 08 Jul 2024 13:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx3aLlmm5Hgrb2t4oVnTmEQf0lq/M/EC9E4x2oYM1/yFEsBUNemhv5NCCFcZmmLcHky8PICw==
X-Received: by 2002:a05:600c:3209:b0:426:593c:9351 with SMTP id 5b1f17b1804b1-426707ceec7mr3883515e9.6.1720470071697;
        Mon, 08 Jul 2024 13:21:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:2200:bad7:95bd:e25e:a9e? (p200300cbc7442200bad795bde25e0a9e.dip0.t-ipconnect.de. [2003:cb:c744:2200:bad7:95bd:e25e:a9e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7361b5sm10565245e9.29.2024.07.08.13.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 13:21:11 -0700 (PDT)
Message-ID: <75d6c45d-deea-464d-b0fd-b36e5d73b898@redhat.com>
Date: Mon, 8 Jul 2024 22:21:09 +0200
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
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
 <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
 <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
 <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
 <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
 <Zovv4lzM38EHtnms@zx2c4.com> <Zov6SZZCKrqmigua@zx2c4.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zov6SZZCKrqmigua@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.24 16:40, Jason A. Donenfeld wrote:
> Hi David, Linus,
> 
> Below is what I understand the suggestions about the UX to be. The full
> commit is in https://git.zx2c4.com/linux-rng/log/ but here's the part
> we've been discussing. I've held off on David's suggestion changing
> "DROPPABLE" to "VOLATILE" to give Linus some time to wake up on the west
> coast and voice his preference for "DROPPABLE". But the rest is in
> place.
> 
> Jason
> 
> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> index a246e11988d5..e89d00528f2f 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -17,6 +17,7 @@
>   #define MAP_SHARED	0x01		/* Share changes */
>   #define MAP_PRIVATE	0x02		/* Changes are private */
>   #define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
> +#define MAP_DROPPABLE	0x08		/* Zero memory under memory pressure. */
>   
>   /*
>    * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
> diff --git a/mm/madvise.c b/mm/madvise.c
> index a77893462b92..cba5bc652fc4 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1068,13 +1068,16 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>   		new_flags |= VM_WIPEONFORK;
>   		break;
>   	case MADV_KEEPONFORK:
> +		if (vma->vm_flags & VM_DROPPABLE)
> +			return -EINVAL;
>   		new_flags &= ~VM_WIPEONFORK;
>   		break;
>   	case MADV_DONTDUMP:
>   		new_flags |= VM_DONTDUMP;
>   		break;
>   	case MADV_DODUMP:
> -		if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL)
> +		if ((!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) ||
> +		    (vma->vm_flags & VM_DROPPABLE))
>   			return -EINVAL;
>   		new_flags &= ~VM_DONTDUMP;
>   		break;
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 30b51cdea89d..b87b3d8cc9cc 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -485,7 +485,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>   
>   	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
>   	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
> -	    vma_is_dax(vma) || vma_is_secretmem(vma))
> +	    vma_is_dax(vma) || vma_is_secretmem(vma) || (oldflags & VM_DROPPABLE))
>   		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
>   		goto out;
>   
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 83b4682ec85c..b3d38179dd42 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1369,6 +1369,34 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>   			pgoff = 0;
>   			vm_flags |= VM_SHARED | VM_MAYSHARE;
>   			break;
> +		case MAP_DROPPABLE:
> +			/*
> +			 * A locked or stack area makes no sense to be droppable.
> +			 *
> +			 * Also, since droppable pages can just go away at any time
> +			 * it makes no sense to copy them on fork or dump them.
> +			 *
> +			 * And don't attempt to combine with hugetlb for now.
> +			 */
> +			if (flags & (MAP_LOCKED | MAP_HUGETLB))
> +			        return -EINVAL;
> +			if (vm_flags & (VM_GROWSDOWN | VM_GROWSUP))
> +			        return -EINVAL;
> +
> +			vm_flags |= VM_DROPPABLE;
> +
> +			/*
> +			 * If the pages can be dropped, then it doesn't make
> +			 * sense to reserve them.
> +			 */
> +			vm_flags |= VM_NORESERVE;

That is certainly interesting. Nothing that we might not be able to 
reclaim these pages reliably in all cases: for example when long-term 
pinning them.

In some environments (OVERCOMMIT_NEVER) MAP_NORESERE would never be 
effective. I wonder if we want to stick to the same behavior here ... 
but in theory I agree that we can set this here unconditionally, it's 
just the corner case of "there are ways to prohibit reclaim" that makes 
me wonder.

BTW, I was just trying to understand how MADV_FREE + MAP_DROPPABLE would 
behave without any swap space around.

Did you experiment with that?

I'm reading can_reclaim_anon_pages(), and I'm wondering how 
good/reliable that works when there is no swap configured.

Also, the comment in get_scan_count(): "If we have no swap space, do not 
bother scanning anon folios." makes me wonder if some work in that area 
is needed.

-- 
Cheers,

David / dhildenb


