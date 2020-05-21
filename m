Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A471DDA78
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2020 00:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgEUWrU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 May 2020 18:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbgEUWrT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 May 2020 18:47:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56742C061A0E
        for <linux-api@vger.kernel.org>; Thu, 21 May 2020 15:47:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n15so4076094pjt.4
        for <linux-api@vger.kernel.org>; Thu, 21 May 2020 15:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rM+9EQuq5q2z+8Rnep+GSyMO4ogI1cr2dU/BPSckSc0=;
        b=F5pZZOodmnglpG9At4hjeCVVXyzpzR4//cFTakNlKlvYwN0D+RuXv3b3KfBXiqoIPd
         /NyMZuiJBlrSFqpYzdTFBIiE/Ajl6B2wuAI+W1w9YFfa7uRzrvVkreh5wHd+nlLnew6l
         kqRmg/Q/gn8MWqph8HYDUDERDWiswmiGynNGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rM+9EQuq5q2z+8Rnep+GSyMO4ogI1cr2dU/BPSckSc0=;
        b=AmNj1afrsBSTqru5xLWMz0W/KzsKP9ZTyc12IoCaq99hUy0eiahaMSljqp+6sItLFH
         Wvw02VoeGw8rY3QxlZlL3BOWW+g9qVKYsT3hrPo8LYaVs2oNhvuYQfQWKQtjQu4UZNz0
         sNLON0f35kVuSuRn68GNAobQ1sRHQc0JmIafbFzffomd/Tc/j6t+uulemg0zMGDohupD
         sN6XHXMviXprduPM9fpKH9EgRal8tOC8v6UbndSIM/I80ApozHmFdkKP4gVQ9vjfzL0K
         yeU0cu0ZBoB6AGcU//raq7HJAvgr4tmP7WmIp7RE9x11CGGFecKr2Phc2m5eA3wWPEK+
         bqGg==
X-Gm-Message-State: AOAM530/WkK3W9SJJZ7sHCzh4UUyRyjAZUug7CTwgXKbH2oa4HTPfDP0
        jxiObiTFJ/q2MoXAtZ19xKclnA==
X-Google-Smtp-Source: ABdhPJwybfeAkdZSGfnmkfJKXBXqvxYAb7XHY72AtmJcsitduYysU62VqrkmK64cVlAk1k1RabLKSA==
X-Received: by 2002:a17:902:7b86:: with SMTP id w6mr11680926pll.292.1590101237858;
        Thu, 21 May 2020 15:47:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o11sm5192507pfd.195.2020.05.21.15.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:47:16 -0700 (PDT)
Date:   Thu, 21 May 2020 15:47:15 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [RFC PATCH 3/5] selftest/x86: Fix sigreturn_64 test.
Message-ID: <202005211545.30156BFC4@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521211720.20236-4-yu-cheng.yu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 21, 2020 at 02:17:18PM -0700, Yu-cheng Yu wrote:
> When shadow stack is enabled, selftests/x86/sigreturn_64 triggers a fault
> when doing sigreturn to 32-bit context but the task's shadow stack pointer
> is above 32-bit address range.  Fix it by:
> 
> - Allocate a small shadow stack below 32-bit address,
> - Switch to the new shadow stack,
> - Run tests,
> - Switch back to the original 64-bit shadow stack.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  tools/testing/selftests/x86/sigreturn.c | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
> index 57c4f67f16ef..5bcd74d416ff 100644
> --- a/tools/testing/selftests/x86/sigreturn.c
> +++ b/tools/testing/selftests/x86/sigreturn.c
> @@ -45,6 +45,14 @@
>  #include <stdbool.h>
>  #include <sys/ptrace.h>
>  #include <sys/user.h>
> +#include <x86intrin.h>
> +#include <asm/prctl.h>
> +#include <sys/prctl.h>
> +
> +#ifdef __x86_64__
> +int arch_prctl(int code, unsigned long *addr);
> +#define ARCH_CET_ALLOC_SHSTK 0x3004
> +#endif
>  
>  /* Pull in AR_xyz defines. */
>  typedef unsigned int u32;
> @@ -766,6 +774,20 @@ int main()
>  	int total_nerrs = 0;
>  	unsigned short my_cs, my_ss;
>  
> +#ifdef __x86_64__

I think this should also be gated by whether the compiler will know what
to do with the shadow stack instructions. (Perhaps the earlier Makefile
define can be exported and tested here.)

> +	/* Alloc a shadow stack within 32-bit address range */
> +	unsigned long arg, ssp_64, ssp_32;
> +	ssp_64 = _get_ssp();
> +
> +	if (ssp_64 != 0) {
> +		arg = 0x1001;
> +		arch_prctl(ARCH_CET_ALLOC_SHSTK, &arg);
> +		ssp_32 = arg + 0x1000 - 8;
> +		asm volatile("RSTORSSP (%0)\n":: "r" (ssp_32));
> +		asm volatile("SAVEPREVSSP");
> +	}
> +#endif

-- 
Kees Cook
