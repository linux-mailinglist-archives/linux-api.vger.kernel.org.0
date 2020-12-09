Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507312D49D2
	for <lists+linux-api@lfdr.de>; Wed,  9 Dec 2020 20:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbgLITJI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Dec 2020 14:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733001AbgLITJI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Dec 2020 14:09:08 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016E7C0613D6;
        Wed,  9 Dec 2020 11:08:28 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id m12so4608573lfo.7;
        Wed, 09 Dec 2020 11:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fxoqPCiWc/8hrZVyGnb4WQe69RSDUFwDEYNSupu9kTE=;
        b=p021/NJzb5lga2xfuZKepqETedOgd01WzHXccbDMWgRKdjLQsBwTVCTK/XCU8YqrOw
         irgaKKjsAfOBvwH/XayYaHNLSw1HVi1z0f//SZJY8gI5O1l5Mvl/UcrYuDA6cNCGXAGs
         /lwGdlwfo3wS7x4N4+Ivh1wlTZ5jbgTmLXGkx1PRPTUkxrF0C/Kl0IWJ4e9zWojEn/zS
         iYJV8hMyrRkRqm95ATOOIymEm4Z7Y8CpWyPvUzdK94fElRQdBhKg6uqKQET0UXIHm7PT
         De1aeKEVRLkjNGcLoX2j94jQmrnt+hrdHOeLBni2ppcigkbYnP+a0UeVRENlMWv/rBWc
         pfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fxoqPCiWc/8hrZVyGnb4WQe69RSDUFwDEYNSupu9kTE=;
        b=G2wwAecxFPmFQizydqLVNrAzBwB7A6iR1of+M9w7K1bMd/2zYNPVx9cIkl9NK1K3Yc
         2jGfqT097q368U83LsAxZPWAExwlHqXwijkomAEfEx5fbMMvlp51mq+kAiFKsIpjnBx2
         A7VKHfIvkqoTxpPRDOoCPmzcZVCrqEZ3My6evuTdVEDg2V+kxqxIpxpj66P0PCoWpfg9
         OTVQdL3A4osuAhjsKGntCqVsjZjeokN0rP5A9y870MKx4JEMjUAUSPaaVcgMfTi/ffeN
         w4MGbGdjUPARY2KeDZ3RZR0wp8U9bzTzO245BrgC2/zNRqjIOgSFyqg9Bi95LfYrp5b/
         NcKQ==
X-Gm-Message-State: AOAM531xyOzuaw9XRX78/H6fF5r2H6g+oc25/QlGhhBH17liSrXwVBy1
        xtSSyORxWFynrGAiQWkR+tg=
X-Google-Smtp-Source: ABdhPJwAVj0KWYoPE8X87RlhX9U9TcYDY+m+hwZazqGkQzpN/orl6GwDOnli4aU2j5TqSqwu9PDwBA==
X-Received: by 2002:a19:cbc3:: with SMTP id b186mr1441910lfg.554.1607540906424;
        Wed, 09 Dec 2020 11:08:26 -0800 (PST)
Received: from [192.168.1.33] (88-114-222-21.elisa-laajakaista.fi. [88.114.222.21])
        by smtp.gmail.com with ESMTPSA id s22sm260505lfi.187.2020.12.09.11.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 11:08:25 -0800 (PST)
Subject: Re: [PATCH] mm/vmalloc: randomize vmalloc() allocations
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20201201214547.9721-1-toiwoton@gmail.com>
 <9d34fb0a-7aba-1e84-6426-006ea7c3d9f5@gmail.com>
 <20201203065801.GH751215@kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <26f0c73a-3a81-4ba6-2b6f-c5ca73ea866b@gmail.com>
Date:   Wed, 9 Dec 2020 21:08:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201203065801.GH751215@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3.12.2020 8.58, Mike Rapoport wrote:
> On Wed, Dec 02, 2020 at 08:49:06PM +0200, Topi Miettinen wrote:
>> On 1.12.2020 23.45, Topi Miettinen wrote:
>>> Memory mappings inside kernel allocated with vmalloc() are in
>>> predictable order and packed tightly toward the low addresses. With
>>> new kernel boot parameter 'randomize_vmalloc=1', the entire area is
>>> used randomly to make the allocations less predictable and harder to
>>> guess for attackers.
>>>
>>
>> This also seems to randomize module addresses. I was going to check that
>> next, so nice surprise!
> 
> Heh, that's because module_alloc() uses vmalloc() in that way or another :)

The modules are still allocated from their small (1.5GB) separate area 
instead of the much larger (32TB/12.5PB) vmalloc area, which would 
greatly improve ASLR for the modules. To fix that, I tried to to #define 
MODULES_VADDR to VMALLOC_START etc. like x86_32 does, but then kernel 
dies very early without even any output.

-Topi
