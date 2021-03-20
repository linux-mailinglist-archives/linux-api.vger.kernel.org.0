Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC25342EA5
	for <lists+linux-api@lfdr.de>; Sat, 20 Mar 2021 18:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCTRj3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 20 Mar 2021 13:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTRjO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 20 Mar 2021 13:39:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91309C061574;
        Sat, 20 Mar 2021 10:39:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e7so14458919edu.10;
        Sat, 20 Mar 2021 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fSx+Zs7EP5WNMLXrvYywy27msSplCPR3kWnh7vE+X3Y=;
        b=QrHJuaBEj0r5XptedQFnDUckmOlQMcShVczHQYTm3bhF8bg71P3fIw6GEpaHdNI/j8
         zN7YSMUlxHF7bcZH0W/nQEtwI+uLc+67FvsJz9VjS4B1TgvL9wwmQEiBUU3NRbv/TbzR
         6aH0U/v4cgYIqf4R0jAiYnFM6Siy72dBP1o3whACk+v76I8LiaLKOy5jmKHdevymZFRw
         IRUJPVQc77S1zhKvdN3vaLFj6xqKnwWwWEZxM0VH//oiCDdNikEWoqcVM3QkYFejMWca
         de4MOyIZvq51N9hqTTPJ5mZAO3iKTDX3dm791uqZy85iPDwnf8c6CQXaURLrQ/qO/Hcm
         2XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fSx+Zs7EP5WNMLXrvYywy27msSplCPR3kWnh7vE+X3Y=;
        b=nH/lhS8diDNfp1F30aZPmdhlvyRc+DbmZJIKcUSmbYW8TU4g1n6ntr+nYeLomv9BK6
         wiVhiTX2L4GSSpxcBGhOONPHu4aRlFAdruQX5eiqxZ3qxF+4psemd72//58ieVCti19c
         zMaAup4X6aWhPyAd5gIBTfJZg1Vj/9J6WuJUMugCfsPiurr6tb37AIyhpRdwrkkQ8tHa
         aYXYMAenvYLv1Q0dRXAxgCGW/vL0g43JXBJrigKiobjSIp/sgdVxrLFjGi0JJmirNpuZ
         woa8W6hSEA8om/1D4z68qe6qwB7DvfjmdTpu8jTjhqc2vRS9dYyUug10VtTHPeloI/Be
         MXYw==
X-Gm-Message-State: AOAM530JBv9AzvxsbveEuCtLtpQNg2EelD0wWRFgbgaMviQqqxXEgk1l
        4Syje4ThDI1dD4gzENtABw==
X-Google-Smtp-Source: ABdhPJyM2PI6OJKpMYe6SsKfQZo8BWtdZTpo2LtXVWwfV6BxFZ3wQTwlkVNjXQIekOkRVyrG+Zjojg==
X-Received: by 2002:aa7:d5c9:: with SMTP id d9mr17222261eds.102.1616261951878;
        Sat, 20 Mar 2021 10:39:11 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.213])
        by smtp.gmail.com with ESMTPSA id c17sm7241840edw.32.2021.03.20.10.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 10:39:11 -0700 (PDT)
Date:   Sat, 20 Mar 2021 20:39:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] Document that PF_KTHREAD _is_ ABI
Message-ID: <YFYzPcHKWm3U04pN@localhost.localdomain>
References: <YFYjOB1jpbqyNPAp@localhost.localdomain>
 <CALCETrUPAvUOr8V5db0gu5RKVftKFwbBEkh6Aob57v+D-xdEig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUPAvUOr8V5db0gu5RKVftKFwbBEkh6Aob57v+D-xdEig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Mar 20, 2021 at 10:23:12AM -0700, Andy Lutomirski wrote:
> > On Mar 20, 2021, at 9:31 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > ﻿PF_KTHREAD value is visible via field number 9 of /proc/*/stat
> >
> >    $ sudo cat /proc/2/stat
> >    2 (kthreadd) S 0 0 0 0 -1 2129984 0 ...
> >                  ^^^^^^^
> >
> > It is used by at least systemd to check for kernel-threadness:
> > https://github.com/systemd/systemd/blob/main/src/basic/process-util.c#L354
> > src/basic/process-util.c:is_kernel_thread()
> 
> Eww.
> 
> Could we fix it differently and more permanently by modifying the proc
> code to display the values systemd expects?

Right now there is no need to fix anything because 4 bits are available.
I put a comment so that PF_KTHREAD won't be moved accidently definitely
breaking systemd.

> > It means that the value can't be changed despite perceived notion that
> > task_struct flags are internal to kernel and can be shuffled at whim.
> >
> > Formally, _all_ struct task_struct::flags PF_* values are kernel ABI
> > which is a disaster.
> >
> > I hope we can mask everything but few flags and hope for the best :^)

> > +/*
> > + * PF_KTHREAD is part of kernel ABI, visible via value #9 in /proc/$pid/stat
> > + */
> > #define PF_KTHREAD        0x00200000    /* I am a kernel thread */

I think everything should be masked except PF_KTHREAD and maybe few
flags for which known users exist and then don't touch them.

Some flags are clearly internal like PF_MEMALLOC and PF_IDLE.

Some aren't -- PF_FORKNOEXEC. However it is silly for userspace to query it
because programs knows if it forked but didn't exec without external help.
