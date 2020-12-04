Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDAA2CF26E
	for <lists+linux-api@lfdr.de>; Fri,  4 Dec 2020 17:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgLDQyd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Dec 2020 11:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLDQyc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Dec 2020 11:54:32 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C36DC0613D1;
        Fri,  4 Dec 2020 08:53:52 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y16so7382149ljk.1;
        Fri, 04 Dec 2020 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y/IbC3R3yHppHu57kqKA7zrXcN/DsD6GsCLQOq/2qUg=;
        b=WjGUYSYMwE3yHVyPlEBheNQxqyu8hdd0DbFmZqMVoXlKWnalLQD6/Ib8vv3sZxWKqC
         f80p1UIyW8uz1JyGnYkh2eX/XZoEMfEBwN3PxgeNiyDYjfsJdsMip4LHbR6+3/6fns41
         BjfXQ2lhRVW8cAfaF8zc1t4vtpU/q5NVyyDQ9lUpwFpIBh4UEDxc5bng6SFzP08Raib0
         VOrKpm6juleWQHLmR+K/FsGJLRxRz3Hdej35RSwAV5xriKFl7bZb9Iaek+xwxEs3clTc
         UNwCZT6IjFJQUO5875ITREFXehJaGXDQAHMe5fksc0IWQ3MaFKIwgMw07lxVuWUKr4LB
         7qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y/IbC3R3yHppHu57kqKA7zrXcN/DsD6GsCLQOq/2qUg=;
        b=U3/nvD0qBT157KYrrJme2aA6dcmb8bP4OmS+uqUteCnbfvZZ2uAzAUk+iv00jmLv5d
         To9wj91iMXsEfs3eZ65y6oz7on+jvUTo+pE8PstgM8vcErVcSz7Np3Fyk5ccTbWIXoBT
         JVqbgX9sJLB8qvSlaDiwbB29DzLbKXCipq4VyztSqKzGk7Cv7L8QSjUf8OVLvPZFkZg2
         LMeHe+XGnvt7AshJczX3VfHef7+i6vSuc0obhi2eI+js956N56Hni6Qgx2WRruvgs5At
         qHem2kZiZLaNPs7+AN+SiE1+F/7qFfbW25SsIHYaasQJZYOd+rKzS83NAuYbmkt6vX+K
         tt5Q==
X-Gm-Message-State: AOAM530Ktb71IEMyPpQkaym22cD1nowhp9DQ5u765Bm8uv/72tEHtlHE
        khWTnSHQzZEZMfdQr9ATZes=
X-Google-Smtp-Source: ABdhPJwultFBOJgQT3ysP+9kgKzKO3u0wVsacD5/1hFIsJybo96kEFmu83YAbf3DKOUwg2Epaj3uXg==
X-Received: by 2002:a05:651c:1067:: with SMTP id y7mr3938057ljm.357.1607100830612;
        Fri, 04 Dec 2020 08:53:50 -0800 (PST)
Received: from [192.168.1.40] (88-114-216-158.elisa-laajakaista.fi. [88.114.216.158])
        by smtp.gmail.com with ESMTPSA id a16sm1856239lfg.16.2020.12.04.08.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 08:53:50 -0800 (PST)
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
 <3d20f41c-6c8e-755b-33b4-964b5cc5ac71@gmail.com>
 <f2f19b0c0f4148a8aaa64fd7bdc821d1@AcuMS.aculab.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <dd8cf1b1-112c-3045-2b4c-bc6c1a6ee382@gmail.com>
Date:   Fri, 4 Dec 2020 18:53:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <f2f19b0c0f4148a8aaa64fd7bdc821d1@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4.12.2020 15.33, David Laight wrote:
> From: Topi Miettinen
>> Sent: 04 December 2020 10:58
>>
>> On 4.12.2020 1.15, David Laight wrote:
>>> From: Mike Rapoport
>>>> Sent: 03 December 2020 06:58
>>>>
>>>> On Wed, Dec 02, 2020 at 08:49:06PM +0200, Topi Miettinen wrote:
>>>>> On 1.12.2020 23.45, Topi Miettinen wrote:
>>>>>> Memory mappings inside kernel allocated with vmalloc() are in
>>>>>> predictable order and packed tightly toward the low addresses. With
>>>>>> new kernel boot parameter 'randomize_vmalloc=1', the entire area is
>>>>>> used randomly to make the allocations less predictable and harder to
>>>>>> guess for attackers.
>>>
>>> Isn't that going to horribly fragment the available address space
>>> and make even moderate sized allocation requests fail (or sleep).
>>
>> For 32 bit architecture this is a real issue, but I don't think for 64
>> bits it will be a problem. You can't fragment the virtual memory space
>> for small allocations because the resulting page tables will not fit in
>> RAM for existing or near future systems.
> 
> Hmmm truly random allocations are going to need 3 or 4 extra page tables
> on 64bit systems. A bit overhead for 4k allocates.
> While you won't run out of address space, you will run out of memory.

There are 3500 entries in /proc/vmallocinfo on my system with lots of 
BPF filters (which allocate 8kB blocks). The total memory used is 740MB. 
Assuming that every entry needed additional 4 pages, it would mean 55MB, 
or 7.4% extra. I don't think that's a problem and even if it would be in 
some case, there's still the option of not using randomize_vmalloc.

-Topi
