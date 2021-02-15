Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF731C136
	for <lists+linux-api@lfdr.de>; Mon, 15 Feb 2021 19:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBOSND (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Feb 2021 13:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhBOSNC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Feb 2021 13:13:02 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077E4C061574;
        Mon, 15 Feb 2021 10:12:22 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h26so11909470lfm.1;
        Mon, 15 Feb 2021 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0c98g3eufcJurfy0Y/YTjQsVsPETkx4NO8zQfg5IgbA=;
        b=dbDOr6gsxDIzYBObdb47g92Fw0I8kZmiQZF5SxLFATwX7qHRR0Gneisep+6XbjU41p
         K0PWrmNL9h28tGzOGBJuwy0ILkFUKXxKTFtOdiZfo8ECticWgoYdaiThIbv3CQY/Iz8L
         sO9TNG/0kGx9W9PH83eQt+7FkOOOe+F/wplCb+03lowdKs9jDLRvOg2dm0ltoYHnmw8A
         Nn86uRpxOLX+/Z2ou1YZU9oTTinSc8/vxQSOwulkXlttkMQQmJ/4Zy5HRZE0gkC/aAZd
         uqdHJSr/E/BfGpdvnulpE0V8/sm+fcA99kJTARYaAuczENQZ9koCIAIJAFMKGOaCeZUj
         xmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0c98g3eufcJurfy0Y/YTjQsVsPETkx4NO8zQfg5IgbA=;
        b=PHjvDUad+gsU3iJbDs2k2oOhBToK6FWE5Hs9KWkOFRyPXq8to0VSk2F63zIBtJ8rvu
         Y4lqX/yk6ElG7GbguYaKDdqJjg+I6Dc9/m0mI6cMWo+TMX6WZvrAEOLLfOl1OpaQDxCH
         JBfDok7b55r6AwpzNzaXDFfDZjqvD7Vw2SCpk/JCKjz9vzt2C6Aw7R6LnOh0Se2hcv52
         pvi2WayTCuuzpkWKKHBSF9oM+xyDkt7kq0rh7zeTM9T+I1skhW5ZgH5Euj/BtuA5kdAq
         4VRUpK7DlQhdZAaj9a0iYrauNU9ppHJmq7pBgC/eqSrIsUT65GoOOx/PmMkWp+Zg2ZXy
         6XCA==
X-Gm-Message-State: AOAM530UXXFpRcEjPr0OVT5KtEMz5kyQo3m76pGNYSHkVQvJ0c9QknOQ
        XDI+/lbGWdeW2xPWsYHdxUA=
X-Google-Smtp-Source: ABdhPJy8vOz1vhoROPpR1yZSbnTTkBTTB69R0qN0ld5f+xVn9u3aFZeRUYioGb9a53KYbiJLQtHvdg==
X-Received: by 2002:a19:8006:: with SMTP id b6mr9029866lfd.625.1613412740471;
        Mon, 15 Feb 2021 10:12:20 -0800 (PST)
Received: from [192.168.1.39] (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id s4sm2841338lfp.281.2021.02.15.10.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 10:12:19 -0800 (PST)
Subject: Re: [PATCH v2] mm/vmalloc: randomize vmalloc() allocations
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20201212175635.4217-1-toiwoton@gmail.com>
 <795016db-93fa-72ea-f5dd-16b9c56a62e9@gmail.com>
 <20210213115521.GA1907@pc638.lan>
 <8d60ba59-1d16-bb76-f3d3-f1b0c5a5b306@gmail.com>
 <20210215125154.GA2259@pc638.lan>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <325de13f-887f-4a13-df04-7db1ad6f9084@gmail.com>
Date:   Mon, 15 Feb 2021 20:12:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210215125154.GA2259@pc638.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 15.2.2021 14.51, Uladzislau Rezki wrote:
> On Sat, Feb 13, 2021 at 03:43:39PM +0200, Topi Miettinen wrote:
>> On 13.2.2021 13.55, Uladzislau Rezki wrote:
>>>> Hello,
>>>>
>>>> Is there a chance of getting this reviewed and maybe even merged, please?
>>>>
>>>> -Topi
>>>>
>>> I can review it and help with it. But before that i would like to
>>> clarify if such "randomization" is something that you can not leave?
>>
>> This happens to interest me and I don't mind the performance loss since I
>> think there's also an improvement in security. I suppose (perhaps wrongly)
>> that others may also be interested in such features. For example, also
>> `nosmt` can take away a big part of CPU processing capability.
>>
> OK. I was thinking about if it is done for some production systems or
> some specific projects where this is highly demanded.
> 
>>
>> Does this
>> answer your question, I'm not sure what you mean with leaving? I hope you
>> would not want me to go away and leave?
>>
> No-no, that was a type :) Sorry for that. I just wanted to figure out
> who really needs it.

It's not needed. The goal is just to increase address space layout 
randomization, to harden the system against attacks which depend on 
predictable kernel memory layout. This should not be used when 
performance is more important than hardening.

>>> For example on 32bit system vmalloc space is limited, such randomization
>>> can slow down it, also it will lead to failing of allocations much more,
>>> thus it will require repeating with different offset.
>>
>> I would not use `randomize_vmalloc=1` on a 32 bit systems, because in
>> addition to slow down, the address space could become so fragmented that
>> large allocations may not fit anymore. Perhaps the documentation should warn
>> about this more clearly. I haven't tried this on a 32 bit system though and
>> there the VM layout is very different.
>>
> For 32-bit systems that would introduce many issues not limited to fragmentations.
> 
>> __alloc_vm_area() scans the vmalloc space starting from a random address up
>> to end of the area. If this fails, the scan is restarted from the bottom of
>> the area up to this random address. Thus the entire area is scanned.
>>
>>> Second. There is a space or region for modules. Using various offsets
>>> can waste of that memory, thus can lead to failing of module loading.
>>
>> The allocations for modules (or BPF code) are also randomized within their
>> dedicated space. I don't think other allocations should affect module space.
>> Within this module space, fragmentation may also be possible because there's
>> only 1,5GB available. The largest allocation on my system seems to be 11M at
>> the moment, others are 1M or below and most are 8k. The possibility of an
>> allocation failing probably depends on the fill ratio. In practice haven't
>> seen problems with this.
>>
> I think it depends on how many modules your system loads. If it is a big
> system it might be that such fragmentation and wasting of module space
> may lead to modules loading.

# echo 1 > /proc/sys/kernel/kptr_restrict
# grep 0xffffffff /proc/vmallocinfo | awk '{s=s+$2;c++} END {print 
"total\tcount\tavg\tof 1536MB";print s,c,s/c,s/1536/1024/1024}'
total   count   avg     of 1536MB
34201600 1022 33465.4 0.0212351

I think that on my system fragmentation shouldn't be a danger since only 
2% (34MB) of the 1536MB available is used for the 1022 module/BPF blocks.

>> It would be possible to have finer control, for example
>> `randomize_vmalloc=3` (1 = general vmalloc, 2 = modules, bitwise ORed) or
>> `randomize_vmalloc=general,modules`.
>>
>> I experimented by trying to change how the modules are compiled
>> (-mcmodel=medium or -mcmodel=large) so that they could be located in the
>> normal vmalloc space, but instead I found a bug in the compiler (-mfentry
>> produces incorrect code for -mcmodel=large, now fixed).
>>
>>> On the other side there is a per-cpu allocator. Interfering with it
>>> also will increase a rate of failing.
>>
>> I didn't notice the per-cpu allocator before. I'm probably missing
>> something, but it seems to be used for a different purpose (for allocating
>> the vmap_area structure objects instead of the address space range), so
>> where do you see interference?
>>
> 
> 
>     A                       B
>   ---->                   <----
> <---------------------------><--------->
> |   vmalloc address space    |
> |<--------------------------->
> 
> 
> A - is a vmalloc allocations;
> B - is a percpu-allocator.

OK, now I get it, thanks. These can be seen in /proc/vmallocinfo as 
allocations done by pcpu_get_vm_areas(). The way of allocating very 
predictably downwards of a fixed address is bad for ASLR, so I'll try to 
randomize the location of these too. Other allocations by 
pcpu_populate_chunk() and
pcpu_create_chunk() seem to be randomized already.

-Topi

> 
> --
> Vlad Rezki
> 

