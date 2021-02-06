Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16FD31202D
	for <lists+linux-api@lfdr.de>; Sat,  6 Feb 2021 22:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBFVWi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 6 Feb 2021 16:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBFVWg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 6 Feb 2021 16:22:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C75CC061786
        for <linux-api@vger.kernel.org>; Sat,  6 Feb 2021 13:21:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id df22so13714186edb.1
        for <linux-api@vger.kernel.org>; Sat, 06 Feb 2021 13:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4wW5VTUcRTFbR4u94MCMC2jAL2U1utCwiV+qip59h3k=;
        b=rhTmVW1DUSzmHb3WLOOZwJ+pwbYtc/R6X1stBHcxnnMgict/xR3SFjwrVRhPDHkgo4
         /hCbszRAUWCLjOZxhgnyqkGvlvJRCJsMBKGuc5F/yQYuhJd0V5j+3PguzRVQotZJJGhX
         6MUcgDYamidYlox7QFLnUPTM3c7JbCUOSNMTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4wW5VTUcRTFbR4u94MCMC2jAL2U1utCwiV+qip59h3k=;
        b=KW4LH+mojYlZB8/VblJTbrClbTR4M+PWZ9U6yfTx+FF6vSx1mOXCIZguYInk/g3wR1
         /b/dgBmC58dVf+QSpsi5384rZ58PXEzSM1J9Z7/Enwxd3yWSf5cbrxKIhWZsGbjeEOHt
         ABPZMB8YfIapfRejMcPQ1B/c2MhTGQFJ2JCXbFv8SsVmByUsEQ+09Ddm5nbBsBtYWeRz
         1wZL6Y/WMDUETTtLkXbE/8cjO50PQfXB7RqIpy+icJUMQmuu2s5qY3ei2WWQLm84ze9L
         lqB6FisKbdCmpK2eBwh2qgGTUq95W8QEp2+HYRdE0Fcb3EBH1VQKi4m7zr3Bf1VRkJhk
         H08Q==
X-Gm-Message-State: AOAM531wISIOsngd4pD9voyJt6w5Ym2hNndCxACbCyr3M6c5llPtBK8J
        sjp60PspUxPYQxHmuBWdqal9OA==
X-Google-Smtp-Source: ABdhPJwvLv4pt9o7nQ/BY+vs32B8rrd3tj3b4cHlYtdsfmYEYWty4t7nqkWOU/+D6AHUOKGtRogiTA==
X-Received: by 2002:a50:acc1:: with SMTP id x59mr9878803edc.43.1612646513475;
        Sat, 06 Feb 2021 13:21:53 -0800 (PST)
Received: from localhost ([148.252.129.5])
        by smtp.gmail.com with ESMTPSA id x5sm6257406edi.35.2021.02.06.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 13:21:52 -0800 (PST)
Date:   Sat, 6 Feb 2021 21:21:52 +0000
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
Message-ID: <YB8IcCqOJA7vzqiJ@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
 <YB11jybvFCb95S9e@alley>
 <YB3Fwh827m0F+y3n@chrisdown.name>
 <49124db60cdc88c4e9fcca1bbc9767432ad5a93b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49124db60cdc88c4e9fcca1bbc9767432ad5a93b.camel@perches.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Joe Perches writes:
>On Fri, 2021-02-05 at 22:25 +0000, Chris Down wrote:
>> Petr Mladek writes:
>> >   + <module> is already optinaly added by pr_fmt() to the printed strings
>> >     as:  pr_fmt(): ...
>>
>> pr_fmts are not consistently used across the kernel, and sometimes differ from
>> the module itself. Many modules don't use it at all, and we also don't have it
>> for pr_cont. Just picking some random examples:
>>
>>      % grep -av vmlinux /proc/printk_formats | shuf -n 10
>>      mac80211,6%s: mesh STA %pM switches to channel requiring DFS (%d MHz, width:%d, CF1/2: %d/%d MHz), aborting
>>      thinkpad_acpi,c N/Athinkpad_acpi,c %dthinkpad_acpi,5thinkpad_acpi: temperatures (Celsius):thinkpad_acpi,3thinkpad_acpi: Out of memory for LED data
>
>I don't understand this format.
>
>"Out of memory for LED data" is a single printk ending with a '\n' newline
>I expected this to be broken up into multiple lines, one for each printk
>that endsd in a newline.

Hmm, that's just a manifestation of directly using `shuf` without doing the 
transformation of trailing nulls to newlines shown in the changelog. They are 
still distinct and separated by nulls.

>And what would happen if the function was refactored removing the pr_cont
>uses like the below: (basically, any output that uses a mechanism that
>aggregates a buffer then emits it, and there are a _lot_ of those)
>
>	printk("%s\n", buffer);

There are certainly printks which can't be trivially monitored using the printk 
format alone, but the vast majority of the ones that are monitored _do_ have 
meaningful formats and can be monitored over time. No solution to this is going 
to catch every single case, especially when so much of the information can be 
generated dyamically, but this patchset still goes a long way to making printk 
monitoring more tractable for use cases like the one described in the 
changelog.
