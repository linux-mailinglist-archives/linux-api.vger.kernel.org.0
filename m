Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2B330FDAD
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 21:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhBDUCr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 15:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhBDUAZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Feb 2021 15:00:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A283C061788
        for <linux-api@vger.kernel.org>; Thu,  4 Feb 2021 11:59:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r38so2846462pgk.13
        for <linux-api@vger.kernel.org>; Thu, 04 Feb 2021 11:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jq2q8UEnLf/ipaLn8qV8ffzERNFqom9zzTJdc5kA6TY=;
        b=ZYyCgZ2F8b338soHdc11pps9YeSV7ZHYyO2VtWyXSsMAOujNdBUH5nPK8ZS/Niujt+
         IfkH6tdg2aLeIBLt0gSKeQNFL2XubqtzQ4rZm6M7wbFlfc+3eaFryYNqoPSM7KYNMdLP
         QUK4+z7PSBVL/VWNGJ+JUJjOsKs4CFNQ8zt+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jq2q8UEnLf/ipaLn8qV8ffzERNFqom9zzTJdc5kA6TY=;
        b=EZuwIEPwoXCXBb52wPIZyNaHLVyb+Oj/UcFAgY0tEYRwbo0qK3hiytfLCkAOU35Ny+
         VdxNu1pSbZFiAX/vqPDV82zAduC5h1McU+88dlDQHb4uFyD21CnxQbzf8DawmEp29//J
         ubo5r4jINAloe9FpEDssmasutKKqg37KjDXPKH/U63JUky04OZ0GPiVDyxaxOZZTB1O9
         0UmZFovfkQ4UJnR02wx24fhNGZiN530jXpklrB+j7rMkJw3OhNE1vf41AhUibjTr59qT
         +gVORZTcdaDwJ8MmQSTduJZYmNjTtdQ9H1BjVzDzr8NCqEMtZx4+XwPPWuLxHCvcgy1d
         CVBQ==
X-Gm-Message-State: AOAM531WLG/Uf9+07SwYtXrtEtsp3yQbt2wrO3q2Lv9usG/+8zp/h/bF
        DG3FCLCL+vwChs7uxzm8OyK3Gw==
X-Google-Smtp-Source: ABdhPJyX1CKVmOuXV0WfZcsqr7hAOp3Xs811ygdcnoVbhm6hgEhwEQsoz8sIXQhzjpeiKUL/zZkRrQ==
X-Received: by 2002:a63:2d3:: with SMTP id 202mr622394pgc.438.1612468785083;
        Thu, 04 Feb 2021 11:59:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e12sm6152391pjj.23.2021.02.04.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:59:44 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:59:43 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 05/25] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Message-ID: <202102041159.44C6C3588@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-6-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:27PM -0800, Yu-cheng Yu wrote:
> Control-flow Enforcement Technology (CET) introduces these MSRs:
> 
>     MSR_IA32_U_CET (user-mode CET settings),
>     MSR_IA32_PL3_SSP (user-mode shadow stack pointer),
> 
>     MSR_IA32_PL0_SSP (kernel-mode shadow stack pointer),
>     MSR_IA32_PL1_SSP (Privilege Level 1 shadow stack pointer),
>     MSR_IA32_PL2_SSP (Privilege Level 2 shadow stack pointer),
>     MSR_IA32_S_CET (kernel-mode CET settings),
>     MSR_IA32_INT_SSP_TAB (exception shadow stack table).
> 
> The two user-mode MSRs belong to XFEATURE_CET_USER.  The first three of
> kernel-mode MSRs belong to XFEATURE_CET_KERNEL.  Both XSAVES states are
> supervisor states.  This means that there is no direct, unprivileged access
> to these states, making it harder for an attacker to subvert CET.
> 
> For sigreturn and future ptrace() support, shadow stack address and MSR
> reserved bits are checked before written to the supervisor states.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
