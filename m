Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A919327493C
	for <lists+linux-api@lfdr.de>; Tue, 22 Sep 2020 21:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIVTfR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Sep 2020 15:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVTfQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Sep 2020 15:35:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6317C0613D0
        for <linux-api@vger.kernel.org>; Tue, 22 Sep 2020 12:35:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o25so7862671pgm.0
        for <linux-api@vger.kernel.org>; Tue, 22 Sep 2020 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sqo10I328LeM2dGrmAMbMDjHGHNfY3AhrHLzAaG7Zcc=;
        b=SbYZH3mSnGlVgEsFBRoL6JaNbinBFwv3MKZkfeP6QtPh9H7MfyP0AJW8GxXvXyh7oS
         rB2MZP6qWoEmVuRs7JlfEwiBbgK4lZ23Vz2hvbf2mKPSWCpyTVqeghNS5302lcgAU1Ot
         3V8jL6xUcHt55VvzDvDGK3RdK/gVmXzdyxNNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sqo10I328LeM2dGrmAMbMDjHGHNfY3AhrHLzAaG7Zcc=;
        b=TYIpwxHQXbbQ3HpGctpT5RDm26zrGOmIYmD9NPFnFiUPaGz5wkqgs4UmypqT7+Vknw
         dlWXeSjQh6B1f33HoXn+OOf7/p4slu5TuxslJZCmwpHemKZvXh58N0Wuj/KgASwO7aEZ
         SYt2hDEXIK3neIwtF5m0LEj0n1hRSyNPL0+BHqcUpoiv2GeeVdGaLiY1SbH8AGWf646l
         J4fOtxbB3l4ax3Msq/yugLfoCSwC4aW72cwtgQy45VkwhPytYwEeTS/GOWuZmDrCeCDo
         pIthhXCFIdoEaxxwfswMDRz8kr9WduJ9JVIaS4XVsfrEqnC7L6EVqYUFszzbosMrh6og
         ZDIw==
X-Gm-Message-State: AOAM531D2ySPfSI3yWRONUi1f6HDOu8acfhGRlRPAuNK+rKkmvVdO5Gx
        GCqSno6f+DPMtke3LfEp0CPSUg==
X-Google-Smtp-Source: ABdhPJwJXWR+YYhKJY5dfjikhbiB5OtlnQmdHcgPbPiQaDOduurUwJgYHZOyXscbN5iibVyCq0TsTQ==
X-Received: by 2002:a65:6917:: with SMTP id s23mr4517004pgq.389.1600803316089;
        Tue, 22 Sep 2020 12:35:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm3378542pjl.9.2020.09.22.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:35:14 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:35:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 8/9] selftests: Add kselftest for syscall user dispatch
Message-ID: <202009221234.C0189A8F@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-9-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-9-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:46PM -0400, Gabriel Krisman Bertazi wrote:
> Implement functionality tests for syscall user dispatch.  In order to
> make the test portable, refrain from open coding syscall dispatchers and
> calculating glibc memory ranges.
> 
> Changes since v4:
>   - Update bad selector test to reflect change in API
> 
> Changes since v3:
>   - Sort entry in Makefile
>   - Add SPDX header
>   - Use __NR_syscalls if available
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

This passes, looks good. Thank you again for the self tests!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
