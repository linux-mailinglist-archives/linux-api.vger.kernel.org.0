Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD6E2CC8ED
	for <lists+linux-api@lfdr.de>; Wed,  2 Dec 2020 22:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgLBV3i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Dec 2020 16:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgLBV3i (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Dec 2020 16:29:38 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBF7C0613D6;
        Wed,  2 Dec 2020 13:28:57 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so69447ljo.11;
        Wed, 02 Dec 2020 13:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5XxPc3chLSDUNv3JWhSZI6yuRR4/U1OgJnqTGaagloE=;
        b=D8/7JkieV7O7uvLtVcAzL+wIMniFiyKVdeCJY9CRDiOzumSNZJPXRHxgrn4EIXzTg8
         MaPq5BmxvXx5Las/rLGgT6t5AIUC4LZphF5yniGht66nAVoacoc4a1G0Pkuo1BoVohWa
         3Ab2/SIj5qN/U/7MJdND1QCQi/7h9fdK9Dbq2bSLIltGw368pbY8vmiGLW2mLlw1qglz
         tbYtr5T/Zv3dx6k21rlazfL47g9JcgS1XBx5iC5FeTnNeIyk/HY0Tjo5XQ+rYF4/LXEk
         kmatHvuGIsSRWXP0cJF5QIUw1J6w6jhQJickgKXMPWzq/M5rUX2z74KrlkJIeHDU2s3R
         14ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5XxPc3chLSDUNv3JWhSZI6yuRR4/U1OgJnqTGaagloE=;
        b=EDGVXQ9wOmNaEHTEW147AI4+SI7darEALVS5zQ5vdUxgMpgWMffWcOIVeovRIAD9h/
         enS+qnaBEVrHNYzbWH8cQEjDOjTmtoUHQ2D843CsAIFSCxklwJIfY+BR8xD7CWdQey06
         UcZZqrh8ZNylQXkW58tCo8ECLXlq6Ay/e2m+cKtgrD22dULuZWaMxFyEZNYo8JxfvAsy
         j0Fu6dYt5zWAosJttXnINRtCj2C8l4le75wmnCYs4r3xft6rLqthZUp8crKTcPobmsq3
         FWMzLtK5nwDV/jSptiOjx2L6j2qaSpmpL6eJ82Zeyf1QygWbj0Va5CYmaqUcOQJGdhbM
         3KVQ==
X-Gm-Message-State: AOAM533hqgYRgtX1qgRKbxpxF1qPozZRji+QX5mjqhXlXQrmA7WWHm93
        9JDh3bfDY0anjsq2VGjqVUg=
X-Google-Smtp-Source: ABdhPJxgyr4kAy1RMo17xWfFqHcx1e6XFhqRmcr1tNyKq+pGOsciL9vMgmoSwRX9ecNVe2j1TV7cRQ==
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr2148512ljo.36.1606944535669;
        Wed, 02 Dec 2020 13:28:55 -0800 (PST)
Received: from [192.168.1.39] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id y65sm844738lfa.289.2020.12.02.13.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 13:28:54 -0800 (PST)
Subject: Re: [PATCH] mm/vmalloc: randomize vmalloc() allocations
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20201201214547.9721-1-toiwoton@gmail.com>
 <20201202185334.GG11935@casper.infradead.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <ddfe379a-915b-fca8-d191-e60e059e2dae@gmail.com>
Date:   Wed, 2 Dec 2020 23:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202185334.GG11935@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2.12.2020 20.53, Matthew Wilcox wrote:
> On Tue, Dec 01, 2020 at 11:45:47PM +0200, Topi Miettinen wrote:
>> +	/* Randomize allocation */
>> +	if (randomize_vmalloc) {
>> +		voffset = get_random_long() & (roundup_pow_of_two(vend - vstart) - 1);
>> +		voffset = PAGE_ALIGN(voffset);
>> +		if (voffset + size > vend - vstart)
>> +			voffset = vend - vstart - size;
>> +	} else
>> +		voffset = 0;
>> +
>>   	/*
>>   	 * If an allocation fails, the "vend" address is
>>   	 * returned. Therefore trigger the overflow path.
>>   	 */
>> -	addr = __alloc_vmap_area(size, align, vstart, vend);
>> +	addr = __alloc_vmap_area(size, align, vstart + voffset, vend);
>>   	spin_unlock(&free_vmap_area_lock);
> 
> What if there isn't any free address space between vstart+voffset and
> vend, but there is free address space between vstart and voffset?
> Seems like we should add:
> 
> 	addr = __alloc_vmap_area(size, align, vstart + voffset, vend);
> +	if (!addr)
> +		addr = __alloc_vmap_area(size, align, vstart, vend);
> 	spin_unlock(&free_vmap_area_lock);
> 

How about:

	addr = __alloc_vmap_area(size, align, vstart + voffset, vend);
+	if (!addr)
+		addr = __alloc_vmap_area(size, align, vstart, vstart + voffset + size);
	spin_unlock(&free_vmap_area_lock);

That way the search would not be redone for the area that was already 
checked and rejected.

Perhaps my previous patch for mmap() etc. randomization could also 
search towards higher addresses instead of trying random addresses five 
times in case of clashes.

-Topi
