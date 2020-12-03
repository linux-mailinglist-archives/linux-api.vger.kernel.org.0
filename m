Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF872CD514
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 13:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgLCMDJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 07:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgLCMDJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 07:03:09 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0DDC061A4E;
        Thu,  3 Dec 2020 04:02:28 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f18so2218537ljg.9;
        Thu, 03 Dec 2020 04:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IaH1Ay2WDIAxMFtXzoOalR9PJQnL9IHu/7OpcWmCb60=;
        b=GqwPxheJDKpMMqbf8GKtCQsRNdkZ9ty6yZMmX6GnvUKlV8uPMeTHJAWdu0SBMriDtz
         t/lSst+rrTVjLuyRcEtwSE+uQGscgLF5LcBHrqxErP3K/8K0mc5blLZcS/IpnyfADSq/
         7B5vQViuH30s4qz6gP6RqkB/NGf59Fv42R/uVzopGsPW8tSqVRjstXsgx0XVmWIdyQNU
         +sehwVV5DSpWBdFXfjmCr+hPaIveMTNvIi+gpim6bOo/njHtZZZusWOxX0nGW0h6BiQr
         SNB0hrrz25XEhG6Qgw70P0FBtrfsmskcFnm7j0vAzrhS2czUcX1UQEV1aXV9qUMnEY3t
         zrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IaH1Ay2WDIAxMFtXzoOalR9PJQnL9IHu/7OpcWmCb60=;
        b=fNrBg564IGtCwZZPVkS9iPy5sOUnIxx2UIKsnt6Khv5oDjrulkWjFDv0+HPzk8JDnC
         ZN0rKUTknJdSFxVv8voAku9HNhbb/66fAX1UynAPo8BG1Y6gbPdo5SYOiMvBgOb9+Ylu
         gvBpOYMeZHXXhvcZ5yuYtBh4RdjfPrWcuJWyVtMBy+4bJ2Foptw/MdYI3sY9xDzRIVhJ
         8vWI9pz6pDWgkVZoWTo3431ftmFA6gLb3hlOrSqg3V+JIMfNoF1FDl6ia0rNeVNZFxQ7
         e+tSmFKf47Eau80udpK9aey9uz7W1e/GM/S0EjclpovyJARr1Q2Za4svznrTgS3DuuOr
         BbhA==
X-Gm-Message-State: AOAM5305WsqpZe9KboLSdUQ92xHzz2htnrkPVIWp8U+02FNxv7Lub9ti
        ug4WdEGs4F7IQmTmeL8wdbZDtbeoXW4=
X-Google-Smtp-Source: ABdhPJyCzognIJDPh7B1KJBBA0Nm3ojFxr32mjSG1N0v0D144se4CngiUAVcQ5T5T5QBJYTOlu8EUA==
X-Received: by 2002:a2e:9550:: with SMTP id t16mr1098917ljh.117.1606996946693;
        Thu, 03 Dec 2020 04:02:26 -0800 (PST)
Received: from [192.168.1.40] (88-114-216-158.elisa-laajakaista.fi. [88.114.216.158])
        by smtp.gmail.com with ESMTPSA id h23sm443031lfk.148.2020.12.03.04.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 04:02:26 -0800 (PST)
Subject: Re: [PATCH v5] mm: Optional full ASLR for mmap(), mremap(), vdso and
 stack
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20201129211517.2208-1-toiwoton@gmail.com>
 <87im9j2pbs.fsf@oldenburg2.str.redhat.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <e8c458fe-073b-2c4d-4d80-3637041c1485@gmail.com>
Date:   Thu, 3 Dec 2020 14:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87im9j2pbs.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3.12.2020 11.47, Florian Weimer wrote:
> * Topi Miettinen:
> 
>> +3   Additionally enable full randomization of memory mappings created
>> +    with mmap(NULL, ...). With 2, the base of the VMA used for such
>> +    mappings is random, but the mappings are created in predictable
>> +    places within the VMA and in sequential order. With 3, new VMAs
>> +    are created to fully randomize the mappings.
>> +
>> +    Also mremap(..., MREMAP_MAYMOVE) will move the mappings even if
>> +    not necessary and the location of stack and vdso are also
>> +    randomized.
>> +
>> +    On 32 bit systems this may cause problems due to increased VM
>> +    fragmentation if the address space gets crowded.
> 
> Isn't this a bit of an understatement?  I think you'll have to restrict
> this randomization to a subregion of the entire address space, otherwise
> the reduction in maximum mapping size due to fragmentation will be a
> problem on 64-bit architectures as well (which generally do not support
> the full 64 bits for user-space addresses).

Restricting randomization would reduce the address space layout 
randomization and make this less useful. There's 48 or 56 bits, which 
translate to 128TB and 64PB of VM for user applications. Is it really 
possible to build today (or in near future) a system, which would 
contain so much RAM that such fragmentation could realistically happen? 
Perhaps also in a special case where lots of 1GB huge pages are 
necessary? Maybe in those cases you shouldn't use randomize_va_space=3. 
Or perhaps there could be randomize_va_space=3 which does something, and 
randomize_va_space=4 for those who want maximum randomization.

>> +    On all systems, it will reduce performance and increase memory
>> +    usage due to less efficient use of page tables and inability to
>> +    merge adjacent VMAs with compatible attributes. In the worst case,
>> +    additional page table entries of up to 4 pages are created for
>> +    each mapping, so with small mappings there's considerable penalty.
> 
> The number 4 is architecture-specific, right?

Yes, I only know x86_64. Actually it could have 5 level page tables. 
I'll fix this in next version.

-Topi
