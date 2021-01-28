Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CAC307FBA
	for <lists+linux-api@lfdr.de>; Thu, 28 Jan 2021 21:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhA1UcF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Jan 2021 15:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhA1UcD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Jan 2021 15:32:03 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B2C061573;
        Thu, 28 Jan 2021 12:31:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m1so2306860wml.2;
        Thu, 28 Jan 2021 12:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lIO5kM+zDyYDd38SsYlTwtI8yepYfulfKs7DP0doKqU=;
        b=syRrrZb0JaALX1sz2rUrO22yiN5ffT0thUKVDW7NM/29x5HYSWhgb2aLQhdAO59sYM
         4nZSHOhVo2UOBYI5cpz5WB09gqJ4MurLALRxR791BzLKluSZUld7QV9H4qSeGrZItMvS
         Tt79TKd8Ego/XtCAS5Te2sGhJJQ+UG8l/54OukZGuqCxZIB+qi8uh5GieSAFR5ORh8eC
         Ye7HKwSodsLROPjaJqCwxK5GOXBzKK3DUQ7f50X/4jJ+Bv5SJjMtM8Cuxezo5XUgYAcn
         q48YAAN+pZcBhUW4rmarBxf2Umk1F4+yRmJPtIIQKx1Z9yuVnONQw3yd2Az0hHDIZJDt
         2auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lIO5kM+zDyYDd38SsYlTwtI8yepYfulfKs7DP0doKqU=;
        b=ccKEOxQCmbqKlpYjZBsVeOVtaJujM5DY24jkJE+2PyrnHWBcINK+KzxPJQtcqriOHK
         0d9rJNpbtOMVx/UK5fDxGlO2lu4DWMVaclmtrP5JxYmzGa2EsETeyTyBeBcyxvXf7iov
         w6eHYOWG6ez3MGPTQlGKJt1AA6zmis/U/7qjXEdxM1DNtWyqbXMVIaeimRxUOmNhn1t4
         wWGDTbRrcSr/R0iTNbCfRd8CqhfkfquPOPSXq16lvnsAkkSzTpLvcGpij4iiN9RPjEBH
         2GTwkT2qUZZ/ufiv5yiC7rID5V2Yx11OoG2RGX+z6vBVWHEB8Mlk8sei1YNlI4cXhXJk
         /UYA==
X-Gm-Message-State: AOAM532ptSiBtWiQHaHydCTVdPq8CyglYtI9hXbfd+Kr91qF3g2EiBBD
        63K+BvcY2CZSCcIXa2MZr2c=
X-Google-Smtp-Source: ABdhPJz35IIaCFuBWIp85fYEBgf494zrQNqYq+/SP3Pr7n7zye6oMIunw2HLsGbqqpCO9tQtsuyQrA==
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr840992wmj.17.1611865881702;
        Thu, 28 Jan 2021 12:31:21 -0800 (PST)
Received: from ?IPv6:2a02:2455:e0:e000:3005:efab:c884:ced0? ([2a02:2455:e0:e000:3005:efab:c884:ced0])
        by smtp.gmail.com with ESMTPSA id z63sm6975204wme.8.2021.01.28.12.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 12:31:20 -0800 (PST)
Cc:     mtk.manpages@gmail.com, linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=c3=ada?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] process_madvise.2: Add process_madvise man page
To:     Suren Baghdasaryan <surenb@google.com>
References: <20210120202337.1481402-1-surenb@google.com>
 <CAKgNAkgsQWL3QAyF6CQU=yifzA1tfp_E5kBBNKuAq_+sB4Amyw@mail.gmail.com>
 <CAJuCfpEfMgA6z5S5gmHwJB_3KWwmKKp434GeHheUGF3yC7r01w@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <6cd84701-fb65-7aa0-38db-b69fe5748754@gmail.com>
Date:   Thu, 28 Jan 2021 21:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEfMgA6z5S5gmHwJB_3KWwmKKp434GeHheUGF3yC7r01w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Suren,

On 1/28/21 7:40 PM, Suren Baghdasaryan wrote:
> On Thu, Jan 28, 2021 at 4:24 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> Hello Suren,
>>
>> Thank you for writing this page! Some comments below.
> 
> Thanks for the review!
> Couple questions below and I'll respin the new version once they are clarified.

Okay. See below.

>> On Wed, 20 Jan 2021 at 21:36, Suren Baghdasaryan <surenb@google.com> wrote:
>>>

[...]

Thanks for all the acks. That let's me know that you saw what I said.

>>> RETURN VALUE
>>>     On success, process_madvise() returns the number of bytes advised. This
>>>     return value may be less than the total number of requested bytes, if an
>>>     error occurred. The caller should check return value to determine whether
>>>     a partial advice occurred.
>>
>> So there are three return values possible,
> 
> Ok, I think I see your point. How about this instead:

Well, I'm glad you saw it, because I forgot to finish it. But yes,
you understood what I forgot to say.

> RETURN VALUE
>      On success, process_madvise() returns the number of bytes advised. This
>      return value may be less than the total number of requested bytes, if an
>      error occurred after some iovec elements were already processed. The caller
>      should check the return value to determine whether a partial
> advice occurred.
> 
>     On error, -1 is returned and errno is set appropriately.

We recently standardized some wording here:
s/appropriately/to indicate the error/.


>>> +.PP
>>> +The pointer
>>> +.I iovec
>>> +points to an array of iovec structures, defined in
>>
>> "iovec" should be formatted as
>>
>> .I iovec
> 
> I think it is formatted that way above. What am I missing?

But also in "an array of iovec structures"...

> BTW, where should I be using .I vs .IR? I was looking for an answer
> but could not find it.

.B / .I == bold/italic this line
.BR / .IR == alternate bold/italic with normal (Roman) font.

So:
.I iovec
.I iovec ,       # so that comma is not italic
.BR process_madvise ()
etc.

[...]

>>> +.I iovec
>>> +if one of its elements points to an invalid memory
>>> +region in the remote process. No further elements will be
>>> +processed beyond that point.
>>> +.PP
>>> +Permission to provide a hint to external process is governed by a
>>> +ptrace access mode
>>> +.B PTRACE_MODE_READ_REALCREDS
>>> +check; see
>>> +.BR ptrace (2)
>>> +and
>>> +.B CAP_SYS_ADMIN
>>> +capability that caller should have in order to affect performance
>>> +of an external process.
>>
>> The preceding sentence is garbled. Missing words?
> 
> Maybe I worded it incorrectly. What I need to say here is that the
> caller should have both PTRACE_MODE_READ_REALCREDS credentials and
> CAP_SYS_ADMIN capability. The first part I shamelessly copy/pasted
> from https://man7.org/linux/man-pages/man2/process_vm_readv.2.html and
> tried adding the second one to it, obviously unsuccessfully. Any
> advice on how to fix that?

I think you already got pretty close. How about:

[[
Permission to provide a hint to another process is governed by a
ptrace access mode
.B PTRACE_MODE_READ_REALCREDS
check (see
BR ptrace (2));
in addition, the caller must have the
.B CAP_SYS_ADMIN
capability.
]]

[...]

>>> +.TP
>>> +.B ESRCH
>>> +No process with ID
>>> +.I pidfd
>>> +exists.
>>
>> Should this maybe be:
>> [[
>> The target process does not exist (i.e., it has terminated and
>> been waited on).
>> ]]
>>
>> See pidfd_send_signal(2).
> 
> I "borrowed" mine from
> https://man7.org/linux/man-pages/man2/process_vm_readv.2.html but
> either one sounds good to me. Maybe for pidfd_send_signal the wording
> about termination is more important. Anyway, it's up to you. Just let
> me know which one to use.

I think the pidfd_send_signal(2) wording fits better.

[...]

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
