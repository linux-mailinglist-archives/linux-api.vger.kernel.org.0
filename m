Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EAC311A0A
	for <lists+linux-api@lfdr.de>; Sat,  6 Feb 2021 04:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhBFD2y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 5 Feb 2021 22:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhBFCbc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 5 Feb 2021 21:31:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D103C08ECAC
        for <linux-api@vger.kernel.org>; Fri,  5 Feb 2021 14:45:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s5so10797232edw.8
        for <linux-api@vger.kernel.org>; Fri, 05 Feb 2021 14:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tI1f4i4ziW/Ximd5HKHu71YFTC8v8qUtKb681+ALp0o=;
        b=YZdenX0Q9zk0V+QGiih7o/6iLs3mnbotXB87u469aXGFh8TPPwu5nPQD6MAlrqDm9b
         V8qg2QBHm1+ncL5H95h1Kz8bFfws38DJF9HtFKz5WAyAs2VmQRN0wUJiKHKyS6giqYI5
         MklliWJw3bOuhQLEIorHi0QMOpnHWKi0gTFk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tI1f4i4ziW/Ximd5HKHu71YFTC8v8qUtKb681+ALp0o=;
        b=NFzSc2o8f4DDK+yTgTWsH+9jW1jGBRZg4fFRVQusVXMs8G0gypsKxs300S9MNE/hTK
         ix8mphvr7s95Uka+O2Vyqtla3ki4XyAqK+XXMQ1DlwmVavhRkzSyvVuDRUzsvE0lfN/e
         B4F/vfcNQb1hjbQk2JL+k5MiXbRFLERnsrjwWUqjYqCtNyVu/30DveO+YhOhGlAOCk8s
         aqUCSF+2g5ApInSec8XaUMmItwxMh7UcZhLpIw8VE/ojXJ9ab31OY4m3mtzvOIpFReEi
         QS+hczsQMjhlznKKbdW8fc+uJC8CbIAKSyidVOall6kDxJHs4uzA+8+0LKPyuAj7wtL7
         Bp1A==
X-Gm-Message-State: AOAM531VC9IyKT7ysJay9KMQGlPsPSjnglsS1VAfBLqB9g8OqLJsrwH/
        6fSNLwW4EKR7L4FZl8iF34GxjQ==
X-Google-Smtp-Source: ABdhPJyt3LLWpY62x1OjCahx1+I3sSaPyiQWpqmMIWHpa/OcR+efeRyrMqnBFf//oHc04KqZBHpyNg==
X-Received: by 2002:aa7:d6c2:: with SMTP id x2mr5765469edr.225.1612565120194;
        Fri, 05 Feb 2021 14:45:20 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:66bb])
        by smtp.gmail.com with ESMTPSA id o4sm4656387edw.78.2021.02.05.14.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:45:19 -0800 (PST)
Date:   Fri, 5 Feb 2021 22:45:19 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <YB3Kf896Zt9O+/Yh@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
 <YB11jybvFCb95S9e@alley>
 <20210205124748.4af2d406@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210205124748.4af2d406@gandalf.local.home>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Steven,

Steven Rostedt writes:
>Interesting, because when I was looking at the original patch (looked at
>the lore link before reading your reply), I thought to myself "this looks
>exactly like what I did for trace_printk formats", which the above file is
>where it is shown. I'm curious if this work was inspired by that?

The double __builtin_constant_p() trick was suggested by Johannes based on 
prior art in trace_puts() just prior to patch submission. Other than that, it 
seems we came up with basically the same solution independently. :-)

>> Anyway, there is something wrong at the moment. The output looks fine
>> with cat. But "less" says that it is a binary format and the output
>> is a bit messy:
>
>Hmm, that's usually the case when lseek gets messed up. Not sure how that
>happened.

It looks as intended to me -- none of the newlines, nulls, or other control 
sequences are escaped currently, since I didn't immediately see a reason to do 
that. If that's a blocker though, I'm happy to change it.

>> $> less /proc/printk_formats
>> "/proc/printk_formats" may be a binary file.  See it anyway?
>> vmlinux,^A3Warning: unable to open an initial console.
>> ^@vmlinux,^A3Failed to execute %s (error %d)
>> ^@vmlinux,^A6Kernel memory protection disabled.
>> ^@vmlinux,^A3Starting init: %s exists but couldn't execute it (error %d)
>>
>>
>> That is for now. I still have to think about it. And I am also curious
>> about what others thing about this idea.
>>
>
>I'm not against the idea. I don't think it belongs in /proc. Perhaps
>debugfs is a better place to put it.

Any location is fine with me, as long as it gets to userspace. How does 
<debugfs>/printk/formats or <debugfs>/printk/formats/<module> sound to you?

Thanks,

Chris
