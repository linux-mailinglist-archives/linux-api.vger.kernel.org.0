Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626F1BBD6C
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 22:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbfIWU5p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Sep 2019 16:57:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388071AbfIWU5p (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Sep 2019 16:57:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so15463037wrv.13;
        Mon, 23 Sep 2019 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OLBQZbK2HasfWG8V4RApxBrTplzod7fgm8tE6bUCPDs=;
        b=KoIKc9S3pbAgzcihcu3qbm80TsRKNOgm4FSlPIxRcBRJOG7FgspTleW5SGTBFA5CKn
         gd+4dXIdGnxXGb4sbxDpIkfY2eMW0VB4IJBm/eJ2ldP3gsSwfVcoY/8ZzMeGMnlB1ztG
         a2nCy/md6tzBz80QwilmloibxzVGeBNZxb9zWEX4FIaeqqEEOmYhTlCUK42wRfMwZ4Rm
         sSKxVmfdayjZkQru5KmHpQIB9go7vgrBjrQmTls04k2km3485VbEaGvtqu3Ppu2Bq7h+
         u7PuCkTAzYUZFvTvG6TmIPF9ffN9cO9CwZjZXSYamfPlsXtZgAHnea6vTv5343tXVtfj
         jJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLBQZbK2HasfWG8V4RApxBrTplzod7fgm8tE6bUCPDs=;
        b=EJx5ZzvobiW99gLG3RpeQ/nXIwakcDvtrwcEMh0nY1KjpZ+d7TD8QMH2jJa5McIdEm
         iHnysf2N8bYQAdTiDA2aNNbFqxO+Xw+cnkXmkV9du7m0MFc5+9O99JrVoebU3/w0pdph
         foXo0btjHJxkG3AxBqJXg+nekybNTQefRP+vAwI+pD8EwrNxHhj6eEt4BFy1rxoyF0cC
         2mIM26KgVsK1uQFKaSAO/WJNwZkScUehz8rMSap8Jl+9a9fO+lypp4RY4obE1EQM1Fq3
         IlTKk1WfmyUCQJYng41XI6x1M/eztEBA9hCVMHIZnNNwEC2I/BAgISj+t+MCociGLOYH
         214A==
X-Gm-Message-State: APjAAAWkXxgs16LZzSd7YP2pz5KFLM/JgF2CDdBqV8iyqEjTQuDtrPNY
        REAs9BKtMPbADRYUzWp8ayQ=
X-Google-Smtp-Source: APXvYqyJEv/t1EFf7sy1b3LzgVqzb1KlROudtGp5p0ld0UzcHU6l//Fao9QoebjO69SSci2XqJeaiQ==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr911444wro.83.1569272262395;
        Mon, 23 Sep 2019 13:57:42 -0700 (PDT)
Received: from ?IPv6:2001:a61:243d:bf01:c49e:ef23:e680:96b1? ([2001:a61:243d:bf01:c49e:ef23:e680:96b1])
        by smtp.gmail.com with ESMTPSA id 132sm15568431wma.7.2019.09.23.13.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:57:41 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: For review: pidfd_open(2) manual page
To:     Florian Weimer <fw@deneb.enyo.de>
References: <90399dee-53d8-a82c-3871-9ec8f94601ce@gmail.com>
 <87tv939td6.fsf@mid.deneb.enyo.de>
 <63566f1f-667d-50ca-ae85-784924d09af4@gmail.com>
 <874l12924w.fsf@mid.deneb.enyo.de>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <d3f5191a-3026-6ce1-5cf2-6be8e0f4a989@gmail.com>
Date:   Mon, 23 Sep 2019 22:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <874l12924w.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Florian,

On 9/23/19 10:41 PM, Florian Weimer wrote:
> * Michael Kerrisk:
> 
>>>>        static
>>>>        int pidfd_open(pid_t pid, unsigned int flags)
>>>>        {
>>>>            return syscall(__NR_pidfd_open, pid, flags);
>>>>        }
>>>
>>> Please call this function something else (not pidfd_open), so that the
>>> example continues to work if glibc provides the system call wrapper.
>>
>> I figured that if the syscall does get added to glibc, then I would
>> modify the example. In the meantime, this does seem the most natural
>> way of doing things, since the example then uses the real syscall
>> name as it would be used if there were a wrapper function.
> 
> The problem is that programs do this as well, so they fail to build
> once they are built on a newer glibc version.

But isn't such a failure a good thing? I mean: it encourages
people to rid their programs of uses of syscall(2).

>> But, this leads to the question: what do you think the likelihood
>> is that this system call will land in glibc?
> 
> Quite likely.  It's easy enough to document, there are no P&C issues,
> and it doesn't need any new types.

Okay.

> pidfd_send_signal is slightly more difficult because we probably need
> to add rt_sigqueueinfo first, for consistency.

Okay. I see that's a little more problematic.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
