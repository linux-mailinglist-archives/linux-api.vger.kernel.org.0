Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F736E059
	for <lists+linux-api@lfdr.de>; Wed, 28 Apr 2021 22:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbhD1UeY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Apr 2021 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbhD1UeR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Apr 2021 16:34:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35FFC06138A
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 13:33:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a12so2238125pfc.7
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1UitsZpR0FImv5ggcDLypma8EKgOpgnJx3YkJXeeP/g=;
        b=ARndYMZQdTMTKo8NpDPqCuYDKZF9djP2UPKbAdC42uZHJJBbMeK0GE/suIIWmROC0q
         9nS0a4P6emTISkcViGmQk/z3XR4G9JRpfAadBQb/Qo66eE9w7baiUQ4lxzMjM1Kt6lPm
         WGrhIK7HSGS2a3KHvCIcIH3ny+PK9p4PqXxpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1UitsZpR0FImv5ggcDLypma8EKgOpgnJx3YkJXeeP/g=;
        b=rK45eebKg+ZSp/sajQvKCDYcAtzMIv3uZsKmYuhFrk9uUzIC/yfSk8QVDn1BKxxqdx
         oT+Ayi/Jb0tTaZYeP/ly6EYs9ETRQKk3KiDIVfyFaTQQpLW1KQKXjrLd13veIqPWEV/c
         /8vW5TtNBEYB1rOBkPzWM6wv0AhmpbVKVtuOSWby2pIQiyDPUeMPMO1fmj69vdoZHn0D
         0YiD6EW1purKOb7JRJWrvBNSQMMHnz8OJiTlQlv+MMJ5oUU9N+n5Uht3vzCwUlE77GCn
         Yi/4Y6HJvQOemc50lKZg4xrRpLDKWSLHGbQuAeU05lqj1XCkup7WlFe9mMwwNNkHvIo2
         sDTA==
X-Gm-Message-State: AOAM532TmUiafBYa50BeQ3fZhoNHdEijsaKFP/dJQIGgUqIRzxftjAuu
        taueJmhnwzlKyROyiqU98XlqDA==
X-Google-Smtp-Source: ABdhPJyExRbj04hU9L/qeRvDTKQXZcSQ1B1hKudxqf671tB0dKgDQVVHOB8oNmiG7IBV6qX21CsVfw==
X-Received: by 2002:a63:fe53:: with SMTP id x19mr28088284pgj.449.1619642010363;
        Wed, 28 Apr 2021 13:33:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b140sm491785pfb.98.2021.04.28.13.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:33:29 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:33:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v26 7/9] x86/vdso: Introduce ENDBR macro
Message-ID: <202104281333.D76723E@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-8-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:18PM -0700, Yu-cheng Yu wrote:
> ENDBR is a special new instruction for the Indirect Branch Tracking (IBT)
> component of CET.  IBT prevents attacks by ensuring that (most) indirect
> branches and function calls may only land at ENDBR instructions.  Branches
> that don't follow the rules will result in control flow (#CF) exceptions.
> 
> ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
> instructions are inserted automatically by the compiler, but branch
> targets written in assembly must have ENDBR added manually.
> 
> Introduce ENDBR64/ENDBR32 macros.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
