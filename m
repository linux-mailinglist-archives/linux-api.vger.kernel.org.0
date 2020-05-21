Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62431DDA7E
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2020 00:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgEUWsy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 May 2020 18:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbgEUWsy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 May 2020 18:48:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63188C08C5C1
        for <linux-api@vger.kernel.org>; Thu, 21 May 2020 15:48:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so3594551plt.5
        for <linux-api@vger.kernel.org>; Thu, 21 May 2020 15:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GyTf6Xj9P6LVcKZuqtG5D3WfhPVAAS23C/vfOfVmvVo=;
        b=JQ5+k5fG9g4wICrJVrj+Br5mMHgmfUrY1fz0/Q+Ow5rb2eZ4Bix1+T2xIANfTB4ZFd
         Y328LIcEeJtuQYMvWdCOldUGLOQX2yLMevOhzN95bRCKS32ODcWOBunRXDnXc3n6JjtR
         Uz35IGJqcsdhQ7q1JVctK60WwdGIv6BOfFTb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GyTf6Xj9P6LVcKZuqtG5D3WfhPVAAS23C/vfOfVmvVo=;
        b=dU63eJYBatLxjiZmeCxZfKMmb4N4eg+SjnJ1ul+M9hKanshPvRVsfJwN3DAF/NvtM6
         2Q55qyKF5MCIG8NnvbfjZ2d8flXmznnZ4/QJeMntWXdTQ9ICJEuB/ZUzWxTrye7+1gYw
         I4gsYJSGdfAV2GWW45HQwBWm0pL+D5D+qFU4KFsgFY99aOm4zVd8rsqy7GIYdkkpcOZr
         tGBHNLBbYNzMC2q7tzhbx0b7ij8sPsfsIkbyNIOHGUatQ1HTKeCg/kFf4mC/MSXrXFn8
         TukENQtdg2SPKxxG87WZbozWNHcDz2u/BB1JOcTjLpscSlGbUE38dpuh+Tyylz77sxBh
         rnjg==
X-Gm-Message-State: AOAM533Vx9PWLaSIRcJwQiwfvkqWhPgnnK5Y4l7EJPCe49wFyWb/aOrK
        K89cL+gK+CLl+oo7/nRHx1FQVQ==
X-Google-Smtp-Source: ABdhPJy3Q2xXlUY5QDcApxlF/OSND06IZDqLO/7UxztEP9ScV3THnWlBAlZ9dNNqxf+7dp9/go+Z2A==
X-Received: by 2002:a17:90a:ad49:: with SMTP id w9mr927815pjv.20.1590101333920;
        Thu, 21 May 2020 15:48:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k1sm5352804pfg.205.2020.05.21.15.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:48:53 -0700 (PDT)
Date:   Thu, 21 May 2020 15:48:52 -0700
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
Message-ID: <202005211547.793B36B@keescook>
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

If the headers and code are going to be repeated, I would put that in a
shared header so they're not copy/pasted between these two tests.

-Kees

-- 
Kees Cook
