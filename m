Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2267374748
	for <lists+linux-api@lfdr.de>; Wed,  5 May 2021 19:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhEERy0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 May 2021 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhEERyS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 May 2021 13:54:18 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C713C07E5EE
        for <linux-api@vger.kernel.org>; Wed,  5 May 2021 10:25:28 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n184so2837557oia.12
        for <linux-api@vger.kernel.org>; Wed, 05 May 2021 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVTxixNEQgaMU45bwkqw/v+zgKxhFXtlznyvyelbh00=;
        b=liHtDy4G7Tu/P8bA2SaybJCA17e5TNpk9jQCZD0bJtMFkTfUxLx2PHhX/LybmHqryi
         t2hXt88MYRP4P5iwFMMaQqfP9GHzwKhnoyRDObi1ZkfsdZVwuKPae9WWSGaxpOnJTQWp
         Q0RGqpPticafRncFV2Sh666li4OrcDKmj/UlCIIRjizs2clw0mrASkpsiI/YXZWK5hVn
         d5S2GgQs4MFn8GKNjW8gTutroV2eK7fxAWyS6sD6gsTQqIJnp13UYGkWIoUIgCaA8UFF
         bl/CMx6nBxDfktUDI+2hZjsPvFTp+e+hwfmcXYwGFSjSqSMdLKPz2EeoRt6MS/e3C0sg
         Lkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVTxixNEQgaMU45bwkqw/v+zgKxhFXtlznyvyelbh00=;
        b=oUe/FG7DTtwlEAfZueFktGNUUtGiJdMHplNHn9trEIHOKR43n29NpYmmuYh02N8ylx
         5oGrpdNR2qJvJr0y1FwzpY/CLNhkCMYJ9+RaT7GdhbyxfX6e/CJyQIQZL2f2QgoxuG4Y
         XwcIjDBaggVhcWgLr+zp22A01Lkn9B4n0yBHoyah+jnEmiWZ313keHP7HY9xql/rVhzs
         ZGRfUninaD1FDtnOv0Zf2Ih0AP6iiLG4xTAZAAxPSpnLkbVD0KjtNLtDn21S7vTc8V3A
         uSvQzq1KsJcBOenYE5jOW9c672fnZdPagvgwRPpK2FPFNluS4+BZzEQTd2deiTI3q3dn
         gQSw==
X-Gm-Message-State: AOAM5331UAUS1jF/By/h/8eKPb0SR4XoLDlTgLxtnbj+Nl+t5BlgY7zu
        IB7CW0O5Xgah2IBB4VVsQAVPXmxjI+olewuyCNe6Zg==
X-Google-Smtp-Source: ABdhPJxY9cqvcFHS8ogOFbnSJlth4v2utrx2okL4r1VPI4Hpmfnm63csoO/E37sGBeSfdVMfYrIfTUu8c8CyvX1HbJc=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr22157199oif.121.1620235527302;
 Wed, 05 May 2021 10:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org> <20210505141101.11519-1-ebiederm@xmission.com>
 <20210505141101.11519-8-ebiederm@xmission.com>
In-Reply-To: <20210505141101.11519-8-ebiederm@xmission.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 19:25:00 +0200
Message-ID: <CANpmjNMhMvKePmEutfd6U0wnd-bvktEQwR-=O6efxe6RM9A_4w@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] signal: Remove __ARCH_SI_TRAPNO
To:     "Eric W. Beiderman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 5 May 2021 at 16:11, Eric W. Beiderman <ebiederm@xmission.com> wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Now that this define is no longer used remove it from the kernel.
>
> v1: https://lkml.kernel.org/r/m18s4zs7nu.fsf_-_@fess.ebiederm.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Marco Elver <elver@google.com>



> ---
>  arch/alpha/include/uapi/asm/siginfo.h | 2 --
>  arch/mips/include/uapi/asm/siginfo.h  | 2 --
>  arch/sparc/include/uapi/asm/siginfo.h | 3 ---
>  3 files changed, 7 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/siginfo.h b/arch/alpha/include/uapi/asm/siginfo.h
> index 6e1a2af2f962..e08eae88182b 100644
> --- a/arch/alpha/include/uapi/asm/siginfo.h
> +++ b/arch/alpha/include/uapi/asm/siginfo.h
> @@ -2,8 +2,6 @@
>  #ifndef _ALPHA_SIGINFO_H
>  #define _ALPHA_SIGINFO_H
>
> -#define __ARCH_SI_TRAPNO
> -
>  #include <asm-generic/siginfo.h>
>
>  #endif
> diff --git a/arch/mips/include/uapi/asm/siginfo.h b/arch/mips/include/uapi/asm/siginfo.h
> index c34c7eef0a1c..8cb8bd061a68 100644
> --- a/arch/mips/include/uapi/asm/siginfo.h
> +++ b/arch/mips/include/uapi/asm/siginfo.h
> @@ -10,9 +10,7 @@
>  #ifndef _UAPI_ASM_SIGINFO_H
>  #define _UAPI_ASM_SIGINFO_H
>
> -
>  #define __ARCH_SIGEV_PREAMBLE_SIZE (sizeof(long) + 2*sizeof(int))
> -#undef __ARCH_SI_TRAPNO /* exception code needs to fill this ...  */
>
>  #define __ARCH_HAS_SWAPPED_SIGINFO
>
> diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
> index 68bdde4c2a2e..0e7c27522aed 100644
> --- a/arch/sparc/include/uapi/asm/siginfo.h
> +++ b/arch/sparc/include/uapi/asm/siginfo.h
> @@ -8,9 +8,6 @@
>
>  #endif /* defined(__sparc__) && defined(__arch64__) */
>
> -
> -#define __ARCH_SI_TRAPNO
> -
>  #include <asm-generic/siginfo.h>
>
>
> --
> 2.30.1
