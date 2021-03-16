Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B3533CF32
	for <lists+linux-api@lfdr.de>; Tue, 16 Mar 2021 09:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhCPICR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Mar 2021 04:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbhCPIBw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Mar 2021 04:01:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1AEC06174A;
        Tue, 16 Mar 2021 01:01:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p21so60895317lfu.11;
        Tue, 16 Mar 2021 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nhPJC9wzAEpJ+jE+VGfpIliqBXvwzpfxSi1AqRybceE=;
        b=d5cCDtFG4kTdcsmxqRALSq4WBRWUBYtKaYREhuAdZvZgJ2Kp91SFlGjcoJKJ+critV
         JUfXmDt6qmdEsYACsQ4YyQdcpSddCdLQE0l8P0ndEEp6/WPv+xlVFH8eG8lk8t9a7QsF
         1yRGgjS1BJcQgaqqsohpXkLJkWl7htXi9sI5Jw6V7hGVvAtWzxzymly281iO2h27Hu9b
         X5TwhbrLpu/pOmZWEd3WUXiM/odwODUQHHTqYHvpnuqMVJZTzV611WkDOeplEGyYDLNN
         82cGVPUjuDJpViav/ltjWvn9pl2BvLqWKFE37YlEB611X0ICwEeETFy++5Mk2/V5kwqr
         KPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nhPJC9wzAEpJ+jE+VGfpIliqBXvwzpfxSi1AqRybceE=;
        b=TwHyVuQyyMNtR6ssgawPL1453LcC4H/Cbiwrq/9q4PjHITNQGrIMTlkHR9Ljd5nmFe
         MoQHKnaEQ19lUnkKQaMMf9ybXlKBIxz7iOObwcdLWLQg4Nx6WMekBCrtmCgTUIkXH9Lt
         1M4yOhSQfLCdcY6Lx84vHPtnqVD+4thGEd6fStinmPPH00NLyroIYqPveXuUhYSt9FCf
         tPo92Lw3kzD9CAxEtxTPn/yaOdfuQaV//rGoS7OiWTup/xMQiZSLxaxH4i9xvStlSVaH
         P5sV6SVZG2VjITigdmX1kUepn/h/16p8HbAIURZ5VJR4O9/zJnKcfC7RJ8s5lONevmkm
         LqEA==
X-Gm-Message-State: AOAM533zCGzEGsKuY1sH2kl8fVVENxTIWXxNPel5HDRTTiC0EsZfEs+f
        DK3zp6+ciE+Kd/3nTHlWei8=
X-Google-Smtp-Source: ABdhPJxbHKpOtwcSZgEDd4Sb73ytAiD+HkMe1ubr8slYwelIN437r1j1b4kFmaIQnAURidQFkDTWBw==
X-Received: by 2002:a05:6512:3042:: with SMTP id b2mr9693809lfb.480.1615881710506;
        Tue, 16 Mar 2021 01:01:50 -0700 (PDT)
Received: from [192.168.1.39] (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id v22sm2963626lfr.277.2021.03.16.01.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 01:01:49 -0700 (PDT)
Subject: Re: [PATCH v4] mm/vmalloc: randomize vmalloc() allocations
To:     Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20210309135757.5406-1-toiwoton@gmail.com>
 <20210314172312.GA2085@pc638.lan>
 <f2d6965b-1801-ce91-0c7c-2cdc92493393@gmail.com>
 <20210315122410.GA26784@pc636> <202103150914.4172D96@keescook>
 <20210315174742.GA2038@pc638.lan>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <85515ea8-744e-acec-76ba-034b38d0f9fa@gmail.com>
Date:   Tue, 16 Mar 2021 10:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315174742.GA2038@pc638.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 15.3.2021 19.47, Uladzislau Rezki wrote:
> On Mon, Mar 15, 2021 at 09:16:26AM -0700, Kees Cook wrote:
>> On Mon, Mar 15, 2021 at 01:24:10PM +0100, Uladzislau Rezki wrote:
>>> On Mon, Mar 15, 2021 at 11:04:42AM +0200, Topi Miettinen wrote:
>>>> What's the problem with that? It seems to me that nothing relies on specific
>>>> addresses of the chunks, so it should be possible to randomize these too.
>>>> Also the alignment is honored.
>>>>
>>> My concern are:
>>>
>>> - it is not a vmalloc allocator;
>>> - per-cpu allocator allocates chunks, thus it might be it happens only once. It does not allocate it often;
>>
>> That's actually the reason to randomize it: if it always ends up in the
>> same place at every boot, it becomes a stable target for attackers.
>>
> Probably we can randomize a base address only once when pcpu-allocator
> allocates a fist chunk during the boot.
> 
>>> - changing it will likely introduce issues you are not aware of;
>>> - it is not supposed to be interacting with vmalloc allocator. Read the
>>>    comment under pcpu_get_vm_areas();
>>>
>>> Therefore i propose just not touch it.
>>
>> How about splitting it from this patch instead? Then it can get separate
>> testing, etc.
>>
> It should be split as well as tested.

Would you prefer another kernel option `randomize_percpu_allocator=1`, 
or would it be OK to make it a flag in `randomize_vmalloc`, like 
`randomize_vmalloc=3`? Maybe the latter would not be compatible with 
static branches.

-Topi

> 
> --
> Vlad Rezki
> 

