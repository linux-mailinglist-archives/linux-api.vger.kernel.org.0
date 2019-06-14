Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F6A46102
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfFNOjR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 10:39:17 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35723 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfFNOjR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 10:39:17 -0400
Received: by mail-wm1-f50.google.com with SMTP id c6so2594123wml.0;
        Fri, 14 Jun 2019 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Wfk6KM9+Bziif5CBcrH982VpksXg1a3KjqRA9Jrsy8=;
        b=FhajIOOjwj4/AtDgZsFMqv7pF+AibrxRxRgT4meVZQckZRWWoAMPCDERBvd+jff0fx
         t7pn9Ge5xhPtm/yWpZAuf+ufF3T7HwC0diJ0LBBbfhkPM0/1kewKRDA2NacHnryUNOUH
         sH9J/GYARSc59mKfmcczwngtSnel9mAgvP3GaeasbKOi7ThKAX4yi7PaTL8vYjpVp6ML
         K7Ft9EQKL11BU1vvoHt2l1NWt3dDgw8Uyp1NK2FBe7cNBPGGijL9ebzxB+n/JLrBHrlE
         X8JVE6dHfNpHwL8MKZSK+g5DNeZvKgtYFeINTAJC0tKL+58+vqsGu16XCutIGhEum7ZS
         PfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Wfk6KM9+Bziif5CBcrH982VpksXg1a3KjqRA9Jrsy8=;
        b=H6mWZgNd5CaOTp0uLYE6sEWkDrKL7G70jt3JDu152yQTjH6fFD1tlx9lbjcFjOcpYe
         7e5PA+00gwjG7BBQv2yfTZBJ37lJLBIoacQsjGMTqIS55sW7fdllCcOiLGzNCVdbQmfH
         NJ4JmBsehiiGJJuIPX0n/7V2yq/EiUq71msf8CUYlTEFarwLsJryNmUJGCKK2Y+e3n7K
         sAle0UVgaP7ftAS7/UgesiKgeY2Fx6hVdkLHD8nKiHgPaWgN97GK5yltyYntj3TU+B96
         79VGhR+1e9Aj06gGYA1EEfWABuIwZlSa61HfXT3WD5fImAf2pBSNBj85VZza1svf/tlI
         S00A==
X-Gm-Message-State: APjAAAVAPkYpwEtTRDlIlCDxtGNxd0JvKSpbOkEoIZQmgBkaPqMHJNqp
        2xsCbjgZcgsPlDcv5m84c6M=
X-Google-Smtp-Source: APXvYqydNtsY2l+qwL4x42OHD17qR1ZOzSUd/557u11zIKs/ZQgACXNDQnje+J3tayxKIpx97iSh8A==
X-Received: by 2002:a05:600c:2507:: with SMTP id d7mr8115493wma.2.1560523155303;
        Fri, 14 Jun 2019 07:39:15 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z19sm2401900wmi.7.2019.06.14.07.39.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 07:39:14 -0700 (PDT)
Subject: Re: [PATCHv4 03/28] posix-clocks: add another call back to return
 clock time in ktime_t
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190612192628.23797-1-dima@arista.com>
 <20190612192628.23797-4-dima@arista.com>
 <alpine.DEB.2.21.1906141511440.1722@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <af700944-694c-822b-4633-7de945f9d228@gmail.com>
Date:   Fri, 14 Jun 2019 15:39:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141511440.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Thomas,

Thanks much for the review,

On 6/14/19 2:32 PM, Thomas Gleixner wrote:
> Dmitry,
> 
> On Wed, 12 Jun 2019, Dmitry Safonov wrote:
> 
>> From: Andrei Vagin <avagin@gmail.com>
>>
>> The callsite in common_timer_get() has already a comment:
>>         /*
>>          * The timespec64 based conversion is suboptimal, but it's not
>>          * worth to implement yet another callback.
>>          */
>>         kc->clock_get(timr->it_clock, &ts64);
>>         now = timespec64_to_ktime(ts64);
>>
>> Now we are going to add time namespaces and we need to be able to get:
> 
> Please avoid 'we' and try to describe the changes in a neutral technical
> form, e.g.:
> 
>  The upcoming support for time namespaces requires to have access to:
> 
>> * clock value in a task time namespace to return it from the clock_gettime
>>   syscall.
> 
>   - The time in a tasks time namespace for sys_clock_gettime()
> 
>> * clock valuse in the root time namespace to use it in
>>   common_timer_get().
> 
>   - The time in the root name space for common_timer_get()
> 
>> It looks like another reason why we need a separate callback to return
>> clock value in ktime_t.
> 
>  That adds a valid reason to finally implement a separate callback which
>  returns the time in ktime_t format.
> 
> Hmm?

Agree, the patch has become bigger than wanted and the message could
have been better in technical sense. Will split, add kernel doc and fix
the commit message(s).

[..]
> TBH, this patch is way to big. It changes too many things at once. Can you
> please structure it this way:
> 
>  1) Rename k_clock::clock_get to k_clock::clock_get_timespec and fix up all
>     struct initializers
> 
>  2) Rename the clock_get_timespec functions per instance
> 
>  3) Add the new callback
> 
>  4) Add the new functions per instance and add them to the corresponding
>     struct initializers
> 
>  5) Use the new callback
> 
Thanks,
          Dima
