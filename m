Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCD236E06B
	for <lists+linux-api@lfdr.de>; Wed, 28 Apr 2021 22:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbhD1Uj5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Apr 2021 16:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhD1Ujz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Apr 2021 16:39:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF74C06138D
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 13:39:08 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t22so10347344pgu.0
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z3WAVPi6tsHxDYkM4thG7PqVeXUU++9bnDuXCoKXmi4=;
        b=ZmnkDIBH98NF1kICfHfEsAXDmL81P1i5sho5DoEipnWM1JRdebMvTIFIB3EZrdbxZn
         y8ClFZHg8i8gUYF0PnrIs3G4b/r+BytJNDQ4uhlC+MiMF0Kec0BZ7gn7keoVd6VL500d
         WrrbVntXIXFqljgruoN87fy+qSt9FsFRYjSW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z3WAVPi6tsHxDYkM4thG7PqVeXUU++9bnDuXCoKXmi4=;
        b=nFXpCyJa+V5edzsbfxygDRNuZMkOSZrH7Gssu9tNZay0tddVskt6Vzy2dO0l2JzJgA
         KAQlkNyVHm3oUSGYCLHaozQK6hX6iMG8R2u3LIEmzTJR6XMMfqfI5/NqeQHwEJxyM2c9
         V3yixTx2aJ1C6nHkkSZrORBm3tGl76mhSMKRyHKPjr3j/fFkftD4HNCLxcKZbX70au09
         XOLeccn7Yj6OpKmegwaZ/SA3lO+XuB+eNOudE6Zvoct9DijpXbUxizmJuf1phrVTUz6/
         IcKlBCD49jcDhMHyGA5rHJV19bXk5pCiI7UC2mFHYZ2M1FSOxGT4TDUWsQmNl6kujxFB
         YcGA==
X-Gm-Message-State: AOAM532uBdhqHznhx0G7AzHIR3zxfbVy+HFBbGRvWexrAmoTbx35s9k5
        /zMrUBIOHgjOYAvbAFmcidsFMQ==
X-Google-Smtp-Source: ABdhPJz5qNc4ZUSIrp+d0WTSSyiaj2Rw5P4r2NUtbl4ssPsBN5WfJR8zNykqUu9f6aJ+oaWb6HqSaA==
X-Received: by 2002:a05:6a00:170c:b029:225:8851:5b3c with SMTP id h12-20020a056a00170cb029022588515b3cmr29728717pfc.0.1619642348454;
        Wed, 28 Apr 2021 13:39:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e10sm493387pfc.40.2021.04.28.13.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:39:07 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:39:07 -0700
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
Subject: Re: [PATCH v26 8/9] x86/vdso/32: Add ENDBR to __kernel_vsyscall
 entry point
Message-ID: <202104281339.F0CA6CA3E@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-9-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-9-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:19PM -0700, Yu-cheng Yu wrote:
> From: "H.J. Lu" <hjl.tools@gmail.com>
> 
> ENDBR is a special new instruction for the Indirect Branch Tracking (IBT)
> component of CET.  IBT prevents attacks by ensuring that (most) indirect
> branches and function calls may only land at ENDBR instructions.  Branches
> that don't follow the rules will result in control flow (#CF) exceptions.
> 
> ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
> instructions are inserted automatically by the compiler, but branch
> targets written in assembly must have ENDBR added manually.
> 
> Add that to __kernel_vsyscall entry point.
> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
