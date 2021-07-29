Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D633DA1C3
	for <lists+linux-api@lfdr.de>; Thu, 29 Jul 2021 13:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhG2LIG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jul 2021 07:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhG2LIG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Jul 2021 07:08:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CB2C061765;
        Thu, 29 Jul 2021 04:08:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q3so6486148wrx.0;
        Thu, 29 Jul 2021 04:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OTaLJ9R+rb2ilx+PxTFczlpa7PXqMK776tysUE+byoI=;
        b=McMApZEvZBR8jEXe9S1dNkjzRyR9v/F81mvzEI0mXDTaR1RxD3/awBoS4CsTDJ8JwV
         IiLmQo3jv9Kj0au6Ppt4JrLFOoyLFKUsqZzWtGyD7G+EFNszAXPq6w9TTt42htqYNqmR
         uhNaaOIZu+tX7Yb3vOSBjr2aTq/dJPxeZaj6dhtOOisbooeZTNDpBq8taePhf03aP0pC
         0gU/loT8jqsUvkEj7WNk/V9aeo5W3ekvbGd+LNE0vSCw7b27KxIe9uxzj56e/qBUmMcm
         rOddEk2y+IFXGANfHXD7llE9d7t76fiSMwEEbBQ6iOx/qUnIFMlHJDSxhVFp0Ffg2NXX
         EfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OTaLJ9R+rb2ilx+PxTFczlpa7PXqMK776tysUE+byoI=;
        b=VWLtFGc9vt55Vta7YvD8BufR4qZHu9UgeOwbQLHHSTMpNC+WmbQSx2rhnzjlSqA48v
         YA7waev937dQtLBdNpQmTlwagBunoC9NDH8gEgYC/EZxRSVT+LY5tMVRo/qBCXQ9+u6v
         KECRAxNhinZ7WfBwU9fKle2j6yVskPW4fy9ceRvo/SQIidwq+2hSvFcv1ItOkXHrHtaP
         wbeP7pyooBihpToLUopMp/qCHh4Dv2jN9FpuJZGhJF7kyzWJ7u0EuOhWLA2guE6ImI0S
         cru1UhZg60OFSYnj4u1+no3+l96cmrSX13hQwgEDAhFD8yZYPdc87X3Ls4LrPt3LuIkS
         mjuQ==
X-Gm-Message-State: AOAM532Hgtttu+hkMfTXe7skq4YSZuKQNy7CClBXUKYvqcx+96GcU1jT
        +OXhiqPfnxybGW5vVSKRrUl6FI9NQNk=
X-Google-Smtp-Source: ABdhPJxSEKkwlYJKBRwsijRHH2bn2dCPJkzZVQ/1yBFvOFXNb9V3jEcMRCzBAhp74O8mOqxGqibUNQ==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr4265896wrr.224.1627556880943;
        Thu, 29 Jul 2021 04:08:00 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id k9sm3060277wrc.6.2021.07.29.04.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 04:08:00 -0700 (PDT)
Subject: Re: [PATCH v2] man2: new page describing memfd_secret() system call
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210729082900.1581359-1-rppt@kernel.org>
 <3572b371-80ab-eac1-e2c5-26b07748f767@gmail.com>
 <YQKDPMmyKdKcqHJf@linux.ibm.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <eaecdc28-20cb-95f1-5761-1569daf3d4da@gmail.com>
Date:   Thu, 29 Jul 2021 13:07:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQKDPMmyKdKcqHJf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Mike,

On 7/29/21 12:30 PM, Mike Rapoport wrote:
> On Thu, Jul 29, 2021 at 12:12:12PM +0200, Alejandro Colomar (man-pages) wrote:
>> Hi Mike,
>>
>> On 7/29/21 10:29 AM, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
[...]

>> Check the parameter list :)
>   
> Argh.
> 
> Would you need v3 or this on top would suffice?

That suffices.  Patch applied.

> 
> diff --git a/man2/memfd_secret.2 b/man2/memfd_secret.2
> index 5a70cb5d2..8263f18d5 100644
> --- a/man2/memfd_secret.2
> +++ b/man2/memfd_secret.2
> @@ -31,8 +31,7 @@ memfd_secret \- create an anonymous file to access secret memory regions
>   .BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
>   .B #include <unistd.h>
>   .PP
> -.BI "int syscall(SYS_memfd_secret, int " cmd ", unsigned int " flags \
> -", int " cpu_id );
> +.BI "int syscall(SYS_memfd_secret, unsigned int " flags ");

I guess you meant ");", but note that the quotes are not necessary there 
(as there aren't any spaces), so I skipped them.

Cheers,

Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
