Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F432CEC9F
	for <lists+linux-api@lfdr.de>; Fri,  4 Dec 2020 11:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbgLDK67 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Dec 2020 05:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387665AbgLDK66 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Dec 2020 05:58:58 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E329C0613D1;
        Fri,  4 Dec 2020 02:58:18 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so7037931lfe.12;
        Fri, 04 Dec 2020 02:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qtIAXOcxRabCMPvEwXMKiWTvZ88Jq+DkCvoV5zCNXL8=;
        b=JFKq0FEFiPghTMWZ5ZinnRN8lTLvOfbUm7hU92RDXl09NwBQaBOMCk9mjOzbLwS1VG
         w8rX14z+U4WKujCiPH35D0UhkRWjsqDDkF+HJpKbdMPPw2KqsTkQsF1dyzVciOg3pQ5l
         0SchU/4U/S8aFHf+i/2UwpYUfhJ0cLgl3R4LkwvqsCQzIP3nfIet9gWYbrhRGv3lcDEj
         ea57cwolFyAasYaSUW6dojp2m0i8TbLhJt8t3icQwho6/hZC+ApKEcmQfG7PuEI4Qknb
         a0hYZB9VLZpxkrea3DhouOJU3dEkEk93W8xljJ8FqdfAWuwMwn161yTIuY8CYeu6MPS6
         L+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qtIAXOcxRabCMPvEwXMKiWTvZ88Jq+DkCvoV5zCNXL8=;
        b=l1cqUn8bSQpbMOCy0UQjzkZTrGJy7KV1e2jDcDidcsd80twYY527fgMoBg2NOGwekZ
         UePhD1jNnphMvVOEcXo8wV3/jSd2ZpCBXXqNbRIPYeTZF3DbWczacGdCXYSXSbmfb0zC
         vzlMqjFwyYrsgKdzzn0geI1dCkJpsm6ePYaEn6aiHuakFPg/gN9vA+++aT/3071RS7Cg
         6pvoZJsOBeKc5fc03AOoZ21lHsH5POMolwXMachMukS6UmJjrer/ZjK/AX2KVQp3ObfT
         o3Vq2XeB8IfZCTdjoVrRnvCUnTxsQic6VSbDMaVtyMt9zIioIp3KTe/pZ9HklEuQIGjQ
         saQw==
X-Gm-Message-State: AOAM533vKK2r1ZC5aI//GJ62DA4MEEZ7AY8APN0LLEcZ5Gb0CkxnpFt/
        NwAGYaJcp3vPaVz+5HN4r5s=
X-Google-Smtp-Source: ABdhPJxlLXhd7wUbkedJWv9Ap4s+cr5UC/8/cWDCTbchAAUojNGs/af2FNxS8xQwagHGwOrF86oDcg==
X-Received: by 2002:a05:6512:3fc:: with SMTP id n28mr1185605lfq.93.1607079496769;
        Fri, 04 Dec 2020 02:58:16 -0800 (PST)
Received: from [192.168.1.40] (88-114-216-158.elisa-laajakaista.fi. [88.114.216.158])
        by smtp.gmail.com with ESMTPSA id u23sm1579640ljj.83.2020.12.04.02.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 02:58:15 -0800 (PST)
Subject: Re: [PATCH] mm/vmalloc: randomize vmalloc() allocations
To:     David Laight <David.Laight@ACULAB.COM>,
        'Mike Rapoport' <rppt@kernel.org>
Cc:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20201201214547.9721-1-toiwoton@gmail.com>
 <9d34fb0a-7aba-1e84-6426-006ea7c3d9f5@gmail.com>
 <20201203065801.GH751215@kernel.org>
 <2a672ff3df0c47538ed7d1974c864f0b@AcuMS.aculab.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <3d20f41c-6c8e-755b-33b4-964b5cc5ac71@gmail.com>
Date:   Fri, 4 Dec 2020 12:58:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2a672ff3df0c47538ed7d1974c864f0b@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4.12.2020 1.15, David Laight wrote:
> From: Mike Rapoport
>> Sent: 03 December 2020 06:58
>>
>> On Wed, Dec 02, 2020 at 08:49:06PM +0200, Topi Miettinen wrote:
>>> On 1.12.2020 23.45, Topi Miettinen wrote:
>>>> Memory mappings inside kernel allocated with vmalloc() are in
>>>> predictable order and packed tightly toward the low addresses. With
>>>> new kernel boot parameter 'randomize_vmalloc=1', the entire area is
>>>> used randomly to make the allocations less predictable and harder to
>>>> guess for attackers.
> 
> Isn't that going to horribly fragment the available address space
> and make even moderate sized allocation requests fail (or sleep).

For 32 bit architecture this is a real issue, but I don't think for 64 
bits it will be a problem. You can't fragment the virtual memory space 
for small allocations because the resulting page tables will not fit in 
RAM for existing or near future systems.

For large allocations (directly mapping entire contents of TB sized NVME 
drives or a special application which needs 1GB huge pages) this could 
be a risk. Maybe this could be solved by reserving some space for them, 
or perhaps in those cases you shouldn't use randomize_vmalloc=1.

The method for reserving the large areas could something like below.

First, consider a simple arrangement of reserving high addresses for 
large allocations and low addresses for smaller allocations. The 
allocator would start searching downwards from high addresses for a free 
large block and upwards from low addresses for small blocks. Also the 
address space would be semi-rigidly divided to priority areas: area 0 
with priority for small allocations, area 1 with equal priority for both 
small and large, and area 2 where small allocations would be placed only 
as a last resort (which probably would never be the case).

The linear way of dividing the allocations would of course be very much 
non-random, so this could be improved with a pseudo-random scrambling 
function to distribute the addresses in memory. A simple example would 
be to randomly choose a value for one bit in the address for large 
allocations (not necessarily the most significant available but also 
large enough to align 1GB/TB sized allocations if needed), or a bit 
pattern across several address bits for non-even distribution.

The addresses would be also fully randomized inside each priority area.

The division would mean some loss of randomization. A simple rigid 
division of 50%/50% for small vs. large allocations would mean a loss of 
one bit but the above methods could help this. Dividing the address 
space less evenly would improve one side at the expense of the other. 
Cracking the scrambling function would reveal the bit(s) used for the 
division.

It would be nice to remove the current rigid division of the kernel 
address space (Documentation/x86/x86_64/mm.rst) and let the allocations 
be placed more randomly in the entire 47 bit address space. Would the 
above priority scheme (perhaps with a rigid priority for certain users) 
be good enough to allow this?

Even better would be to remove the use of highest bit for selecting 
kernel/user addresses but I suppose it would be a lot of work for 
gaining just one extra bit of randomness. There could be other effects 
though (good or bad).

-Topi

> I'm not even sure that you need to use 'best fit' rather than
> 'first fit'.
> 'best fit' is certainly a lot better for a simple linked list
> user space malloc.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

