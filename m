Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9343124A1
	for <lists+linux-api@lfdr.de>; Sun,  7 Feb 2021 15:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBGOOX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 09:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhBGOOL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Feb 2021 09:14:11 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19564C061788
        for <linux-api@vger.kernel.org>; Sun,  7 Feb 2021 06:13:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j11so10285617wmi.3
        for <linux-api@vger.kernel.org>; Sun, 07 Feb 2021 06:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DzycL/Z08ICnL6EIGg9bduNGDWkRGyuAWxX+VA81rHA=;
        b=j0riZoK3kpoXTxaF8etREr3dSBu8Qm0Su+VN632qv7OnN/HkzXInF0m6/vnMg4l3qJ
         XTKRtO4/NRMei8ukCbmDfm0JKtuo5sCSP0RnmJ02eLr7DB2TVoTwQPBO53Jvm39fsNml
         wPrLEbS3BDTsdy301O+OZEc1YbIfBya0SayB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DzycL/Z08ICnL6EIGg9bduNGDWkRGyuAWxX+VA81rHA=;
        b=kpI5+osj6fGsLNcjqJ5h/0pKHEsOsgye/hVic1iRmz3xBo6xRHyJyxIPhjcdGpoi1O
         4x1EtkYW+ZojDVdK3Uqkm5VgZ9GoHWSDdwgbl7Sj09m4ffh2pl6CC9Q6UNEzItXNUMi+
         TmoYXXcZ3fRGmWerSEgjEjUW2sxjyAE0akX+dofRPyXuAOL1qsLlPF/v6p7d1dJWZYnn
         VmJXizkRMHQ7oaNyJq1dvPHLCXSADIlnWW+rUeljuXzjhcSx2GkDmIi58kRvjDyJaRb1
         CxRYo4gSFAVN8gDcdrzBkqVAdKKMm8XqVxaYVecw7StWkSlUmvpN/1ZRKp6MA7fxgzDK
         wMpA==
X-Gm-Message-State: AOAM530+MwUnepnrLlvFJQAw4vlb8QjcUj/rLCwz02Oh8NmP6O6Uk6Pk
        8VcjpNQ+Km4sjeAnaEZFMgEwRQ==
X-Google-Smtp-Source: ABdhPJzL5qCa8SXoD+AHQOX0YZvRbRW4DHAM018MmghGG++f9V3lSj+qPydm56SbzapSRCbqejkI9A==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr2433100wmf.82.1612707209516;
        Sun, 07 Feb 2021 06:13:29 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id q4sm22825430wrg.22.2021.02.07.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:13:29 -0800 (PST)
Date:   Sun, 7 Feb 2021 14:13:28 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <YB/1iHwwTi9dOv38@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
 <YB11jybvFCb95S9e@alley>
 <YB3Fwh827m0F+y3n@chrisdown.name>
 <49124db60cdc88c4e9fcca1bbc9767432ad5a93b.camel@perches.com>
 <YB8IcCqOJA7vzqiJ@chrisdown.name>
 <dc6cf90d978e012b0d698a698935d526ca4b0a1c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dc6cf90d978e012b0d698a698935d526ca4b0a1c.camel@perches.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Joe Perches writes:
>> There are certainly printks which can't be trivially monitored using the printk
>> format alone, but the vast majority of the ones that are monitored _do_ have
>> meaningful formats and can be monitored over time. No solution to this is going
>> to catch every single case, especially when so much of the information can be
>> generated dyamically, but this patchset still goes a long way to making printk
>> monitoring more tractable for use cases like the one described in the
>> changelog.
>
>For the _vast_ majority of printk strings, this can easily be found
>and compared using a trivial modification to strings.

There are several issues with your proposed approach that make it unsuitable 
for use as part of a reliable production environment:

1. It misses printk() formats without KERN_SOH

printk() formats without KERN_SOH are legal and use MESSAGE_LOGLEVEL_DEFAULT.  
On my test kernel, your proposed patch loses >5% of printk formats -- over 200 
messages -- due to this, including critical ones like those about hardware or 
other errors.

2. Users don't always have the kernel image available

Many of our machines and many of the machines of others like us do not boot 
using local storage, but instead use PXE or other technologies where the kernel 
may not be stored during runtime.

As is described in the changelog, it is necessary to be able to vary 
remediations not only based on what is already in /dev/kmsg, but also to be 
able to make decisions about our methodology based on what's _supported_ in the 
running kernel at runtime, and your proposed approach makes this not viable.

3. `KERN_SOH + level' can appear in other places than just printk strings

KERN_SOH is just ASCII '\001' -- it's not distinctive or unique, even when 
paired with a check for something that looks like a level after it. For this 
reason, your proposed patch results in a non-trivial amount of non-printk 
related garbage in its output. For example:

     % binutils/strings -k /tmp/vmlinux | head -5
     3L)s
     3L)s
     c,[]A\
     c(L)c
     d$pL)d$`u4

Fundamentally, one cannot use a tool which just determines whether something is 
printable to determine semantic intent.

4. strings(1) output cannot differentiate embedded newlines and new formats

The following has exactly the same output from strings(1), but will manifest 
completely differently at printk() time:

     printk(KERN_ERR "line one\nline two\nline three\n");
     printk("line four\n");

With strings, the hypothetical output would be:*

     3line one\nline two\nline three\nline four\n

* "line four\n" would also be missing with your current -k check.

But this makes it impossible to distinguish between this, compared to:

     printk(KERN_ERR "line one\nline two\n");
     printk("line three\n");
     printk("line four\n");

The originally posted patch _does_ differentiate between these cases, using \0 
as a reliable separator. Its outputs are, respectively:

     \0013line one\nline two\nline three\0\nline four\n\0
     \0013line one\nline two\n\0line three\nline four\n\0

This isn't just a theoretical concern -- there are plenty of places which use 
multiline printks, and we must be able to distinguish between that and 
_multiple_ printks. Not being able to differentiate cases like these would 
dramatically reduce the effectiveness of printk enumeration, as we can no 
longer ascertain which formats will always be used together (for example, in 
the case of sequences of printks guarded by conditionals, which are all over 
the place).

5. strings(1) is not contextually aware, and cannot be made to act as if it is

strings has no idea about what it is reading, which is why it is more than 
happy to output the kind of meaningless output shown in #3. There are plenty of 
places across the kernel where there might be a sequence of bytes which the 
strings utility happens to interpret as being semantically meaningful, but in 
reality just happens to be an unrelated sequence of coincidentally printable 
bytes that just happens to contain a \001.

I appreciate your willingness to propose other solutions, but for these 
reasons, the proposed strings(1) patch would not suffice as an interface for 
printk enumeration.
