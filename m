Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA2B2FF833
	for <lists+linux-api@lfdr.de>; Thu, 21 Jan 2021 23:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAUWty (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Jan 2021 17:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbhAUWtx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Jan 2021 17:49:53 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C36CC06174A
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 14:49:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id e15so2839427wme.0
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 14:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4njFdIv1JViGQi9hUl+dzmIy48TwN3Ut30e6qZPlxrI=;
        b=NvAkVpUjHeM3fm0uBBe1rPkYe7U25Mh6q9McQAPeVLoJ2D+a6S7utQz+Ds42aPO05Z
         ALALqUw/vtzSirFFCqItNmns+C5trIerrdwQRa7uFhJ5zy5MVvR4ANPRjclMydbjWnDC
         5PJ7pOU71qEl8un6PWRNJ9uyEd184Xiuyq6Dguo69iYRYPFhMT+cEoF6zBqZrwlSgELH
         6BDZ44UoVpwLGZzggay1Loyv0xNYoMglFmcUhmzgSN1MfWqDIy329heN1GunsyVZ72bk
         B4lFJbDNcCje9P1KReuEVAeTESb7W61JtH7rGEcTz8P4/7KKSH9dyaiVk1Vz6a5EMuWi
         DUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4njFdIv1JViGQi9hUl+dzmIy48TwN3Ut30e6qZPlxrI=;
        b=iLLnF587QuQerc0huG0owPlw/QsAOyo4NWHDQhxqOM0WOUNPBLcv13OsPG7mnR5fE2
         a4cO/I0K/33oy1L6x11N08iYzxtRRhKPzPOtuyq/O2eBGQrh48BkMerbnlJvqwojCWum
         CubY7JzkDeOrJUHbceMWIiwwDSE9XEyzfTeQDIihPWCl20pFI1voSKSNLr50TgQ3C/ff
         wxJOWrrsFh2t6xs7CVjY1yQ6Ho01gfGcJ3jzNkp2FgBewhj/8EyOKqOM7l8oXxjAypBv
         hQ35nODmD+GUmRRho+7qBR4FdmA36skjgXQAiOMe2FRip5eg80uMM6sPsyl5VF2CqvQQ
         f4Ig==
X-Gm-Message-State: AOAM530igafEKpzvQik2rCSJGII1sWXsvBVjix2zkqckAPUrrUHcklHb
        itiscFcJDN8wHPzKRHqUgf1xF/07x4c=
X-Google-Smtp-Source: ABdhPJwIhG0f6zJ3ZqgJAdkt6mcyyHeL5sbyX/m7MM1lYAyo+R3gjKbxHp5MYD9bm1FJnI3c9cldMA==
X-Received: by 2002:a05:600c:201:: with SMTP id 1mr1286789wmi.104.1611269351915;
        Thu, 21 Jan 2021 14:49:11 -0800 (PST)
Received: from [192.168.0.160] ([170.253.49.0])
        by smtp.gmail.com with ESMTPSA id c6sm10396315wrh.7.2021.01.21.14.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 14:49:11 -0800 (PST)
Subject: Re: [PATCH] tee: Add -q, --quiet option to not write to stdout
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
To:     Bernhard Voelker <mail@bernhard-voelker.de>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Christian Groessler <chris@groessler.org>,
        =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigbrady.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     noloader@gmail.com, Fabrice BAUZAC <noon@mykolab.com>,
        Coreutils <coreutils@gnu.org>, freebsd-hackers@freebsd.org,
        tech@openbsd.org, linux-api@vger.kernel.org
References: <20210121131735.317701-1-alx.manpages@gmail.com>
 <8aa1d0b4-d2ec-7d18-120b-cae59708767c@draigBrady.com>
 <424b9fb9-c740-1a2f-bd79-0b4035104698@gmail.com>
 <e1a3b389-b808-92db-258d-85b60748b4dc@bernhard-voelker.de>
 <06fb3df3-a956-3ec1-eadb-82fd89ec62d5@gmail.com>
 <af2fb24a-a03a-35ef-c86e-545844b61a8d@groessler.org>
 <CAMMLpeRSh5HKi=sJV7y=pav26EzzP-yEe0+Dgp_=mtBUhtFvaQ@mail.gmail.com>
 <3bb6a134-c477-116c-182d-d6e24dc342e0@bernhard-voelker.de>
 <f78ec1a9-f07f-de20-26cc-4be254e3e921@gmail.com>
Message-ID: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
Date:   Thu, 21 Jan 2021 23:49:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <f78ec1a9-f07f-de20-26cc-4be254e3e921@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[CC += mtk, linux-api, freebsd, openbsd]

On 1/21/21 10:26 PM, Alejandro Colomar (man-pages) wrote:
> Hi Berny,
> 
> On 1/21/21 10:01 PM, Bernhard Voelker wrote:
>> On 1/21/21 7:39 PM, Alex Henrie wrote:
>>> That said, I would love to see `tee -q` added to a future revision of
>>> POSIX and adopted everywhere.
>>
>> I like the idea.
>> We have been living for decades without a terminating "pipe end piece",
>> so why hurrying a new option into an implementation of 'tee'?
>> Instead, this could be discussed thoroughly and specified by the OpenGroup
>> and nailed down in a new POSIX issue, and then all implementations
>> could adopt it consistently.
>> Are you willing to start the discussion there?

Hi Berny,

Please don't feel like I'm hurrying with this.
I'm strongly defending my patch to try to
convince you that it's a Good Thing :-)
But if it has to undergo a long discussion
with POSIX, BSD, and whoever, that's fine by me.

I'll send a v2 with --silent in a moment.


Hi Michael,

Talking about designing new APIs,
you might have something to say here,
even if it's not for the kernel.


I also CCd a few lists that might be interested.
Please comment.


Cheers,

Alex

> 
> I am.  However, the Austing Group is a nightmare in terms of login,
> and doing things requiring an account; at least for me.
> 
> I'd prefer that someone else opens a bug there and links to the
> discussion on an open mailing list like this one.
> 
> Do they have an open mailing list?
> 
> Is anyone hepling me report the bug to them?  I should learn at this
> point...
> 
>>
>> BTW: --quiet is usually used to avoid outputting of informational
>> messages (e.g. wget, head, tail, md5sum), while 'tee' would change
>> its functional behavior.
>> Maybe --drain, --drain-stdout, --discard-stdout (-d), --no-stdout (-n),
>> --elide-stdout (-e) or something similar would be more appropriate?
> 
> I stand by -q, --quiet.  Conforming to: grep. Maybe there's some other.
> 
> $ man grep 2>/dev/null | sed -n '/-q, --quiet, --silent/,/^$/p'
>        -q, --quiet, --silent
>               Quiet;  do  not  write  anything to standard output.
>               Exit immediately with zero status if  any  match  is
>               found,  even if an error was detected.  Also see the
>               -s or --no-messages option.
> 
> 
> 
>>
>> Have a nice day,
>> Berny
>>
> 
> Kind regards,
> 
> Alex
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
