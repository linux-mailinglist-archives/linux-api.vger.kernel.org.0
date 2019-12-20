Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F5E1272E9
	for <lists+linux-api@lfdr.de>; Fri, 20 Dec 2019 02:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfLTBld (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Dec 2019 20:41:33 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37675 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfLTBlc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Dec 2019 20:41:32 -0500
Received: by mail-il1-f195.google.com with SMTP id t8so6569328iln.4
        for <linux-api@vger.kernel.org>; Thu, 19 Dec 2019 17:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kihFHk0I3eiSjPlsPOEWwLG5M5I3W9sqheb6sgl2P4k=;
        b=hiDu43S+ngvlMBE/4HJGTNYC1y1RavL4d+i+AbAdZAnmrfii3Ek2G5DaS1DHwSceO2
         hkYpdiXmsDhaduWGWG7ZuISR/pQrC7JlsMNpMQLaPA7Zvco28exuJNPYEMTjQa71P3p1
         nSmP3yaHXzQRXTKiyg9VPBxyCj7audWltZfb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kihFHk0I3eiSjPlsPOEWwLG5M5I3W9sqheb6sgl2P4k=;
        b=VfiLg6n1oiMLU4ScoVGFmmiTRr78UoKomfMFCMEZghlrSWclo8wE1ZWcUNjka0/bzK
         XVQn1ujFr2ihT+5owJ6bISWimINIwUUQheYBX7/Jusoan8ocYyUQ1cYCAjgYOLuITOdY
         LlfjuX5HS3/kE8CE7pXP+2tUhoidzJfp7cRVaSiYdYPbRGTD5BCwmnlQ3s7Risip1THL
         ATSm5CqnP3Fj2CCZCN9q3PIjcMy0wtRD1+UTCIn2l54X4uT7vp2V9hZCLmJt7Pg9GJJL
         4JSfUw+cZSS/ZLrPrAXb+QcmQBuXrWBAfYDdbEOXdAMu/n6L1pa3Z26Tt9BtLL2kznfS
         5Q8w==
X-Gm-Message-State: APjAAAWWcTWoI04pBvGwcICmfwzzcSIOqXYZd01eWljYzVrHZK6wOwLt
        63IyfmwXL1E8aKI4CQ1yqq/gqA==
X-Google-Smtp-Source: APXvYqxJ1wlBxbfbo8n32neUIKY7qhlUNucAfrLjjhF9jQmtKljvxSLHrLQZTJntHeTRF1avB9VQhA==
X-Received: by 2002:a92:84dd:: with SMTP id y90mr9120333ilk.99.1576806092085;
        Thu, 19 Dec 2019 17:41:32 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i136sm1505454ild.23.2019.12.19.17.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 17:41:31 -0800 (PST)
Subject: Re: [PATCH for 5.4 0/3] Restartable Sequences Fixes
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190917182959.16333-1-mathieu.desnoyers@efficios.com>
 <211848436.2172.1576078102568.JavaMail.zimbra@efficios.com>
 <b67930c1-c8e0-124f-9a88-6ecace27317c@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7fd53b32-8d9e-5c24-56c5-86c1c7c700dc@linuxfoundation.org>
Date:   Thu, 19 Dec 2019 18:41:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b67930c1-c8e0-124f-9a88-6ecace27317c@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 12/11/19 8:47 AM, Shuah Khan wrote:
> On 12/11/19 8:28 AM, Mathieu Desnoyers wrote:
>> Hi Thomas,
>>
>> I thought those rseq fixes posted in September were in the -tip tree, 
>> but it
>> seems that they never made it to mainline.
>>
>> Now Shuah Khan noticed the issue with gettid() compatibility with glibc
>> 2.30+. This series contained that fix.
>>
>> Should I re-post it, or is this series on track to get into mainline
>> at some point ?
>>
> 
> It will be great this can make it into 5.5-rc2 or so.
> 
> thanks,
> -- Shuah
> 

I am pulling this patch in for Linux 5.5-rc4.

Let me know if you have any objections.

thanks,
-- Shuah
