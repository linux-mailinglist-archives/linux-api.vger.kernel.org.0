Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9642836E03C
	for <lists+linux-api@lfdr.de>; Wed, 28 Apr 2021 22:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbhD1UaK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Apr 2021 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhD1UaK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Apr 2021 16:30:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235E4C06138B
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 13:29:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e2so29198849plh.8
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UeII31CqNuFlE2BoTtr+fZN9wyzsy3hprcPYll4covw=;
        b=jylj96Rw3QUQm4doFDBK0kop0iQgCV6NfySkOr5T98cqbEgl0duruUVIG5KC7g1OvD
         XbTL/oRiSQ9ur3CZJRvyYbHIxY99dg3xegs4Ok2C8JzBM74t3TX7EC/VLwhZfoPz+u4/
         RcByLq8jJDIgsj0tknp3coppc77n13njbPFO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UeII31CqNuFlE2BoTtr+fZN9wyzsy3hprcPYll4covw=;
        b=FQ/5gTQFCthxio1q5XxwUBUtXTnZNygJwwMPfIU0mEbvwUIOGgkxKN30G42dzMi6lz
         BAbxK9O816Mgl922ka7Gskt7n7Bui+6iF5ES5WjDDySZaPjGAh7jLTfkt841kR+bFreb
         pAC17uBvbds6Lhw89dV92zRKsD2VnOV1DtbpBZEYVH7Yqn5MCvViT0OaUmGzWmPx95ss
         xlLJpMLuaWaIu85hwM+GTPUa9RUi2m6InTbPTJ732vGdUtWXw1Dhvc0GndTc7BoBHY8i
         /imn3pchT/rAREk6enaAeuX+TYAyfsluzd8Xb5hRRYfzwIhzivZzoDTEaUnCGHlF2SQk
         C8Mg==
X-Gm-Message-State: AOAM531ODqxmBAk6ydFGpbKmfIJt8zzncIsefjPXyoVBUyVzxY7fSfqI
        JKVAiC27as6NLVM/hWkajJMJTg==
X-Google-Smtp-Source: ABdhPJwYkEDNlOuREptaQ5l3kQMV3gSjH3e1SrIdJIlzfjRSlDOr3aN5Uamkiddf+M4fmetyZadajQ==
X-Received: by 2002:a17:90a:8c8c:: with SMTP id b12mr36346748pjo.35.1619641762540;
        Wed, 28 Apr 2021 13:29:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm516116pfi.0.2021.04.28.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:29:21 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:29:20 -0700
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v26 1/9] x86/cet/ibt: Add Kconfig option for Indirect
 Branch Tracking
Message-ID: <202104281329.564AACB@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-2-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:12PM -0700, Yu-cheng Yu wrote:
> Indirect Branch Tracking (IBT) provides protection against CALL-/JMP-
> oriented programming attacks.  It is active when the kernel has this
> feature enabled, and the processor and the application support it.
> When this feature is enabled, legacy non-IBT applications continue to
> work, but without IBT protection.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
