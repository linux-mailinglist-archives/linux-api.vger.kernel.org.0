Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8360F33CE50
	for <lists+linux-api@lfdr.de>; Tue, 16 Mar 2021 08:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCPHB3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Mar 2021 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhCPHBX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Mar 2021 03:01:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277BCC06174A;
        Tue, 16 Mar 2021 00:01:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r3so52596343lfc.13;
        Tue, 16 Mar 2021 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxGKDkVfXGKRna8iTes4kKAsxWi/i4GQ3tOLDP6GpoQ=;
        b=vBUkvWkwbtG8vyiRoj73LMOZGE5jZs6YXdymjwqFgRrn7JBgNqAz1g/FeqyO9Lo7aV
         wDd0ovRVBne4iF+lNUuw+xOOLejKKloq3TXqOfDS++B+JfRwj1imgVnDe6coNFsE0nge
         OQlJ9AuqLuEH7qAAprpzScUxNTzqvV3DTpPfqVDavOTqifjzVgPrX/T3ZTix1mMmTHio
         9YPAF3GTetgOmohJpy753d5Q9Vc4A+RQPgS4JyV4R8Mt+1ouxReKo2oA8HlKLNm2ICcH
         mHCSHmvQzkMQp9eGiNCUrwnvao49mvYuVMQvMcDO59S8Y8GTjRL0UoZIOooDoJZxmaF+
         wj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxGKDkVfXGKRna8iTes4kKAsxWi/i4GQ3tOLDP6GpoQ=;
        b=eYOU1GZEZ6X0Pct4NCAJ2ulGaSrzs7U6sUjYfFU1H99rjZ2WICQeVT7TKyaaTJPCre
         toibFS8MbmgG/U+M4dkfdrrl07MI8WrhfSdCt7WwvtRQLEz9xQKCMlrqMR69++x6iQIW
         PCP7vn549QKoc+H8qnSKnqBn87uOln2shNTSKWvbLFRVCPR4sK9XzapRa6DhuDP8koai
         MVekP65YarlvLYgHVfx23VP0OpjXThDKbIGjBp2FtUZFqjibmFQltbGvZ6gyAqCV7caL
         w7/1TXh4A5jDu34KmW2j457l0DatSbTg16cTjinrc17Aa7bqUIzOo14GAv6kzhd8IjQN
         kKYQ==
X-Gm-Message-State: AOAM533x6QGkFZ9wZ6SQDU/oHmYc9IErxHJZr/4RvoLW/8hVLO67yjTp
        kRd7UHE5LSDJ5GyjwhhtAK8=
X-Google-Smtp-Source: ABdhPJyMAE8C/sIfU75yfYl+rcee6p15k6kf1B6GndQrRvtbx/qWrWoqKFUHhIBzwyqHx380aPHg6A==
X-Received: by 2002:a19:488e:: with SMTP id v136mr10457749lfa.611.1615878075482;
        Tue, 16 Mar 2021 00:01:15 -0700 (PDT)
Received: from [192.168.1.39] (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id t201sm3028596lff.70.2021.03.16.00.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 00:01:14 -0700 (PDT)
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
 <4649f69d-b7cd-d1a6-26e0-9b8bf3b17df5@gmail.com>
 <20210315180239.GA2117@pc638.lan>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <b2103eff-1181-4192-aaa3-003d115eaf97@gmail.com>
Date:   Tue, 16 Mar 2021 09:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315180239.GA2117@pc638.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 15.3.2021 20.02, Uladzislau Rezki wrote:
> On Mon, Mar 15, 2021 at 06:23:37PM +0200, Topi Miettinen wrote:
>> On 15.3.2021 17.35, Uladzislau Rezki wrote:
>>>> On 14.3.2021 19.23, Uladzislau Rezki wrote:
>>>>> Also, using vmaloc test driver i can trigger a kernel BUG:
>>>>>
>>>>> <snip>
>>>>> [   24.627577] kernel BUG at mm/vmalloc.c:1272!
>>>>
>>>> It seems that most tests indeed fail. Perhaps the vmalloc subsystem isn't
>>>> very robust in face of fragmented virtual memory. What could be done to fix
>>>> that?
>>>>
>>> Your patch is broken in context of checking "vend" when you try to
>>> allocate next time after first attempt. Passed "vend" is different
>>> there comparing what is checked later to figure out if an allocation
>>> failed or not:
>>>
>>> <snip>
>>>       if (unlikely(addr == vend))
>>>           goto overflow;
>>> <snip>
>>
>>
>> Thanks, I'll fix that.
>>
>>>
>>>>
>>>> In this patch, I could retry __alloc_vmap_area() with the whole region after
>>>> failure of both [random, vend] and [vstart, random] but I'm not sure that
>>>> would help much. Worth a try of course.
>>>>
>>> There is no need in your second [vstart, random]. If a first bigger range
>>> has not been successful, the smaller one will never be success anyway. The
>>> best way to go here is to repeat with real [vsart:vend], if it still fails
>>> on a real range, then it will not be possible to accomplish an allocation
>>> request with given parameters.
>>>
>>>>
>>>> By the way, some of the tests in test_vmalloc.c don't check for vmalloc()
>>>> failure, for example in full_fit_alloc_test().
>>>>
>>> Where?
>>
>> Something like this:
>>
>> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
>> index 5cf2fe9aab9e..27e5db9a96b4 100644
>> --- a/lib/test_vmalloc.c
>> +++ b/lib/test_vmalloc.c
>> @@ -182,9 +182,14 @@ static int long_busy_list_alloc_test(void)
>>          if (!ptr)
>>                  return rv;
>>
>> -       for (i = 0; i < 15000; i++)
>> +       for (i = 0; i < 15000; i++) {
>>                  ptr[i] = vmalloc(1 * PAGE_SIZE);
>>
>> +               if (!ptr[i])
>> +                       goto leave;
>> +       }
>> +
>>
> Hmm. That is for creating a long list of allocated areas before running
> a test. For example if one allocation among 15 000 fails, some index will
> be set to NULL. Later on after "leave" label vfree() will bypass NULL freeing.
> 
> Either we have 15 000 extra elements or 10 000 does not really matter
> and is considered as a corner case that is probably never happens. Yes,
> you can simulate such precondition, but then a regular vmalloc()s will
> likely also fails, thus the final results will be screwed up.

I'd argue that if the allocations fail, the test should be aborted 
immediately since the results are not representative.

-Topi

> 
>> +
>>          for (i = 0; i < test_loop_count; i++) {
>>                  ptr_1 = vmalloc(100 * PAGE_SIZE);
>>                  if (!ptr_1)
>> @@ -236,7 +241,11 @@ static int full_fit_alloc_test(void)
>>
>>          for (i = 0; i < junk_length; i++) {
>>                  ptr[i] = vmalloc(1 * PAGE_SIZE);
>> +               if (!ptr[i])
>> +                       goto error;
>>                  junk_ptr[i] = vmalloc(1 * PAGE_SIZE);
>> +               if (!junk_ptr[i])
>> +                       goto error;
>>          }
>>
>>          for (i = 0; i < junk_length; i++)
>> @@ -256,8 +265,10 @@ static int full_fit_alloc_test(void)
>>          rv = 0;
>>
>>   error:
>> -       for (i = 0; i < junk_length; i++)
>> +       for (i = 0; i < junk_length; i++) {
>>                  vfree(ptr[i]);
>> +               vfree(junk_ptr[i]);
>> +       }
>>
>>          vfree(ptr);
>>          vfree(junk_ptr);
>>
> Same here.
> 
> --
> Vlad Rezki
> 

