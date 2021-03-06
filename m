Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918F432F892
	for <lists+linux-api@lfdr.de>; Sat,  6 Mar 2021 07:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCFF5b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 6 Mar 2021 00:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhCFF5X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 6 Mar 2021 00:57:23 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128A3C06175F;
        Fri,  5 Mar 2021 21:57:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 18so8779218lff.6;
        Fri, 05 Mar 2021 21:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nwjJTyix+U1Kuczayf4pZyIBKt0xdJTJx53NO2UO06c=;
        b=Wh379e/7Ed68GiFHDd0MHYS8RReUXNt8l6QoYwJZ4ulllg/NPnLGjwBzSyCqVvwlNi
         TI1FTi3cgGzI0otAhZE7g7bngUVmwdm79W81CycG3OSP9KSiP9PLIzFVQ+9FcaDMvfBH
         pYdIlCH00pbwmJzU4zuUjIq4qUAd3j+OBP6XL77dph2tZDIhrsQBA1aRlVDEpEpC3fAx
         q9prNhsNZFr7qDLAB5kBvhAlqpHwCXKkMfazieoD8hq9bvH4DVBh/I5yNNxNkTI2MKtU
         lHEH1AJz6ClSYLOUfgY+T+ztE9j3owXH0Hhuc8Tvj+5Rs2L0dmCF4phS4+zEu/hNRhGo
         15Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nwjJTyix+U1Kuczayf4pZyIBKt0xdJTJx53NO2UO06c=;
        b=tFw3d5TlPCCIKJIwevUw8tVaAnAv5PwYWTNRg2bz7vrmzk+kXixY5CGep5l7nN5vsf
         0dNY9CxKrcwKytZzjoQ6FSkN7HPw17610dns7niwFEIkAaYGe5qi2F2nSLo1vgT8vLx0
         Z31mdlVN+lNM8BiwvgqqyP8I4RinE5ook7Agg+M1ZClAq8ksAjbw9HXnzwCVSCwLtN2A
         LNrzyZ46TrnnGOKqhzLinqC1/j6iX9oKzXok7cHNXPYDt5prRb9EwKHu3nc7ZAyLP2WP
         xVgj/rSqsTjEuC5g/dtaUGZYAqukrS6R1XllcC/FwSU3sFoI8OPuP524bqGFtt79F/2H
         5FUA==
X-Gm-Message-State: AOAM530ndtPH3ckp75nhaBk8kA1cBXoZfLt97jwI5REj6ZzIYV5dVbO1
        FUHZLHOBln6aJZ6YelZVGzE=
X-Google-Smtp-Source: ABdhPJzpt9b5bh7+ljfymAumEWonaQN+8hHiD1qqEJGWWdDFZ+Jnopl1X0qUt6VH7zue4OrAPvCNDA==
X-Received: by 2002:a19:2402:: with SMTP id k2mr8327660lfk.138.1615010241497;
        Fri, 05 Mar 2021 21:57:21 -0800 (PST)
Received: from [192.168.1.39] (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id o11sm555091lfu.157.2021.03.05.21.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 21:57:20 -0800 (PST)
Subject: Re: [PATCH v3] mm/vmalloc: randomize vmalloc() allocations
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Vlad Rezki <urezki@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>
References: <20210215202634.5121-1-toiwoton@gmail.com>
 <20210305171331.2424b166ed4d2d9da73ac335@linux-foundation.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <124b32de-2422-615c-90fe-ca5a6d64d179@gmail.com>
Date:   Sat, 6 Mar 2021 07:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305171331.2424b166ed4d2d9da73ac335@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6.3.2021 3.13, Andrew Morton wrote:
> On Mon, 15 Feb 2021 22:26:34 +0200 Topi Miettinen <toiwoton@gmail.com> wrote:
> 
>> Memory mappings inside kernel allocated with vmalloc() are in
>> predictable order and packed tightly toward the low addresses, except
>> for per-cpu areas which start from top of the vmalloc area. With
>> new kernel boot parameter 'randomize_vmalloc=1', the entire area is
>> used randomly to make the allocations less predictable and harder to
>> guess for attackers. Also module and BPF code locations get randomized
>> (within their dedicated and rather small area though) and if
>> CONFIG_VMAP_STACK is enabled, also kernel thread stack locations.
>>
>> On 32 bit systems this may cause problems due to increased VM
>> fragmentation if the address space gets crowded.
>>
>> On all systems, it will reduce performance and increase memory and
>> cache usage due to less efficient use of page tables and inability to
>> merge adjacent VMAs with compatible attributes. On x86_64 with 5 level
>> page tables, in the worst case, additional page table entries of up to
>> 4 pages are created for each mapping, so with small mappings there's
>> considerable penalty.
>>
>> ...
>>
> 
> How useful is this expected to be?  What sort of attack scenarios will
> this help to defend against?

Since there's a clear trade-off between best performance and additional 
address space randomization, this will not be useful for those who 
prefer performance. That's also why this is not the default but has to 
be enabled with a boot parameter.

For those who are willing to pay the price for additional hardening, the 
purpose is to make attacks against KASLR (similar to TagBleed [1]) more 
difficult since the targeted memory locations may reside anywhere in the 
32 TB vmalloc region and knowing one address does not reveal the others.

[1] https://download.vusec.net/papers/tagbleed_eurosp20.pdf

-Topi
