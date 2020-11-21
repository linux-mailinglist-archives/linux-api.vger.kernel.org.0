Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6769A2BBACD
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 01:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgKUAYG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Nov 2020 19:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKUAYG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Nov 2020 19:24:06 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D259DC0613CF
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 16:24:05 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x15so5741953pll.2
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 16:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A7SWgXPCiajknxZfIgmm/Chff6x+olo2cJ70dACeOlI=;
        b=Ufe7L8IQ5v/I7T8tt4gsPuDnhpRA272mwrcmv9XewlpzYhDUXW2jqTxD1hslQrth5g
         eDmR9NJxf5+la/wDoV9T4gAXWEe4Q7fIOQHWwX9t1BmbdmwqQejV3fWvEwLhxFduJBYM
         xKz63gHciuxUu58RjUr5pEfsRqThUo8eAQyEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7SWgXPCiajknxZfIgmm/Chff6x+olo2cJ70dACeOlI=;
        b=nUa9/YRBwUrZk5Xx79ZN5Z4qZpvqDPOXC+2FlvyvMWISoIR0dltNKH4Xu2DiQ8jHpz
         4Q61qckHuNCOc+iffV5+kSfDSMlmOBSUdy5IFhq4tQPlDhCYX3RysubVyySwGnRkZb7l
         4/91jUl3chuzuMLzOeLb5AMHAP1w0eWpDiDaQYGcbKnTqlu9l10Gz0ZslYdhC0qhsMg8
         0/PragAqBggfrOZIQbuRcuOovfCCYW+hlvH0ATShHNAPWWg+X09MmDFPFl6qTFx04M8B
         catej4IWQTh2e2FKElTznubQWTOV36hOxtQk61kYbpfLgYqelbrBUaRQIEwnvG6wjK9p
         XUTg==
X-Gm-Message-State: AOAM530+UWmPEUtA365JWhMXmwvxU0mJ1ECcYddH3aubyAMjiEpgrsfA
        JbWUiFuTT9baWcfcu6GFXks5IQ==
X-Google-Smtp-Source: ABdhPJzjpCFLnLrUalvrO32PJt+53p5u2neas7NkD6ncxIwW6NEts5vwrkfDaOU5cA3xZBMV+Vy9Gg==
X-Received: by 2002:a17:902:8e81:b029:d9:f1a8:54ac with SMTP id bg1-20020a1709028e81b02900d9f1a854acmr2502635plb.69.1605918245442;
        Fri, 20 Nov 2020 16:24:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5sm5324184pfc.165.2020.11.20.16.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:24:04 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:24:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, luto@kernel.org,
        tglx@linutronix.de, christian.brauner@ubuntu.com,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v7 0/7] Syscall User Dispatch
Message-ID: <202011201623.FBFA4471@keescook>
References: <20201118032840.3429268-1-krisman@collabora.com>
 <20201119123827.GL3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119123827.GL3121392@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 19, 2020 at 01:38:27PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 10:28:33PM -0500, Gabriel Krisman Bertazi wrote:
> > Gabriel Krisman Bertazi (7):
> >   x86: vdso: Expose sigreturn address on vdso to the kernel
> >   signal: Expose SYS_USER_DISPATCH si_code type
> >   kernel: Implement selective syscall userspace redirection
> >   entry: Support Syscall User Dispatch on common syscall entry
> >   selftests: Add kselftest for syscall user dispatch
> >   selftests: Add benchmark for syscall user dispatch
> >   docs: Document Syscall User Dispatch
> 
> Aside from the one little nit this looks good to me.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Agreed, and thank you Gabriel for the SYSCALL_WORK series too. :) That's
so nice to have!

-- 
Kees Cook
