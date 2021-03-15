Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F01133C19E
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhCOQYC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 12:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhCOQXm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 12:23:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5154C06174A;
        Mon, 15 Mar 2021 09:23:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e7so57857252lft.2;
        Mon, 15 Mar 2021 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qaNMP0alddEd7JtTl8zS7eqKdx15H1y0B//YrDmf5gY=;
        b=LPWDZEv6rFVCaqvd1m66r/0dCJ9+wI1htfwLgUiweWo4tBsrQS/Clt/YfyYSgWds0j
         pLF3RXqCPu7lfYFiAU4YcwGKr82Bko8tz48NmEpPJmKLzNAOXyxR3fcM2tuqVvTXnyL2
         eraOHdXKq+S1rztoBhLn66mglA8ev18HI+HfueBneYeHL1Il/+ulzqVSeFfSOc3oykzW
         voyajZhA03rPkzuV69doQwzdLCR5+1DUjaY5uSAaBsYYzm/U478f4hdLvz5HUcWgTbf+
         PJOiv2cCiapdgcwqIOXeuJmKFamorucxMBNInCeMt+Fy1HZci6gfNYsJ6hkvf4VZ5g4o
         lD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qaNMP0alddEd7JtTl8zS7eqKdx15H1y0B//YrDmf5gY=;
        b=PuWzO7NuhVmhk2wjZLirQODYiq9H7Fiq5TJnabfsbi8cl5ujtodH4ybJCRm9SW2kUo
         dX6dp6+wDWOi45qHvGfvuF8e401JPgTdT8w7GaKfkoZ1xh9HKcCCdFI1MzIDZrMnvMzQ
         wOYNxP/MQuWk+LRAr3XPljVCSgssiaRKlbP8yGvWg/MUQcm+dr8KP0K2CtIbP3HHQZ9E
         i9k/YPHWuVaWuS3/4DJq3Eb7cBabFwXUz+2duGpHzVWW/td28VIJo9sa+SD9nwTzX3jq
         G6wEPC1RTvSzNlIRwJHvd6AnC8qwyZJtPcQGfVJlFZIzKR5PAOXXjuMdOcqENcx9YlrH
         eyCA==
X-Gm-Message-State: AOAM533WIGKwTB4gO/DGzznFKEJV3YlUlJ7zxb09Tt4m/bNleJTlISuI
        H8hjvYQYbAAyNpLz9800PIo=
X-Google-Smtp-Source: ABdhPJwrRgvcueCrrRfFRNvh6SNhQrQLTbWu4vNI/52vmnCHyrzJ41jNBtioVGBVOFSq1oTgBldG4A==
X-Received: by 2002:ac2:43a3:: with SMTP id t3mr8229109lfl.340.1615825420417;
        Mon, 15 Mar 2021 09:23:40 -0700 (PDT)
Received: from [192.168.1.39] (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id e15sm2986504ljg.54.2021.03.15.09.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 09:23:39 -0700 (PDT)
Subject: Re: [PATCH v4] mm/vmalloc: randomize vmalloc() allocations
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20210309135757.5406-1-toiwoton@gmail.com>
 <20210314172312.GA2085@pc638.lan>
 <ba975607-9493-c78c-bbd8-6a85573114d1@gmail.com>
 <20210315153510.GA1865@pc638.lan>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <4649f69d-b7cd-d1a6-26e0-9b8bf3b17df5@gmail.com>
Date:   Mon, 15 Mar 2021 18:23:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315153510.GA1865@pc638.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 15.3.2021 17.35, Uladzislau Rezki wrote:
>> On 14.3.2021 19.23, Uladzislau Rezki wrote:
>>> Also, using vmaloc test driver i can trigger a kernel BUG:
>>>
>>> <snip>
>>> [   24.627577] kernel BUG at mm/vmalloc.c:1272!
>>
>> It seems that most tests indeed fail. Perhaps the vmalloc subsystem isn't
>> very robust in face of fragmented virtual memory. What could be done to fix
>> that?
>>
> Your patch is broken in context of checking "vend" when you try to
> allocate next time after first attempt. Passed "vend" is different
> there comparing what is checked later to figure out if an allocation
> failed or not:
> 
> <snip>
>      if (unlikely(addr == vend))
>          goto overflow;
> <snip>


Thanks, I'll fix that.

> 
>>
>> In this patch, I could retry __alloc_vmap_area() with the whole region after
>> failure of both [random, vend] and [vstart, random] but I'm not sure that
>> would help much. Worth a try of course.
>>
> There is no need in your second [vstart, random]. If a first bigger range
> has not been successful, the smaller one will never be success anyway. The
> best way to go here is to repeat with real [vsart:vend], if it still fails
> on a real range, then it will not be possible to accomplish an allocation
> request with given parameters.
> 
>>
>> By the way, some of the tests in test_vmalloc.c don't check for vmalloc()
>> failure, for example in full_fit_alloc_test().
>>
> Where?

Something like this:

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 5cf2fe9aab9e..27e5db9a96b4 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -182,9 +182,14 @@ static int long_busy_list_alloc_test(void)
         if (!ptr)
                 return rv;

-       for (i = 0; i < 15000; i++)
+       for (i = 0; i < 15000; i++) {
                 ptr[i] = vmalloc(1 * PAGE_SIZE);

+               if (!ptr[i])
+                       goto leave;
+       }
+
+
         for (i = 0; i < test_loop_count; i++) {
                 ptr_1 = vmalloc(100 * PAGE_SIZE);
                 if (!ptr_1)
@@ -236,7 +241,11 @@ static int full_fit_alloc_test(void)

         for (i = 0; i < junk_length; i++) {
                 ptr[i] = vmalloc(1 * PAGE_SIZE);
+               if (!ptr[i])
+                       goto error;
                 junk_ptr[i] = vmalloc(1 * PAGE_SIZE);
+               if (!junk_ptr[i])
+                       goto error;
         }

         for (i = 0; i < junk_length; i++)
@@ -256,8 +265,10 @@ static int full_fit_alloc_test(void)
         rv = 0;

  error:
-       for (i = 0; i < junk_length; i++)
+       for (i = 0; i < junk_length; i++) {
                 vfree(ptr[i]);
+               vfree(junk_ptr[i]);
+       }

         vfree(ptr);
         vfree(junk_ptr);

-Topi
