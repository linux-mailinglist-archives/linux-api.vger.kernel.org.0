Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDFC374744
	for <lists+linux-api@lfdr.de>; Wed,  5 May 2021 19:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhEERyU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 May 2021 13:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbhEERyJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 May 2021 13:54:09 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC6C034630
        for <linux-api@vger.kernel.org>; Wed,  5 May 2021 10:25:12 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso2409132oti.2
        for <linux-api@vger.kernel.org>; Wed, 05 May 2021 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhdimRmcWFxSoj8AFDYbNHsikBJUsUucL4YCEQ/2njw=;
        b=XwV87+f8d7jiYw4U+qEweujviEosUJz4mImc4wpkn1QEZXlev2sM2d4pHmB9ofh0n9
         Yq3P7e/x1h5Ku11y/LkqEy7Tg83m26DuXSv/6b8ycMo0LPll3ANtPBbvosNpyd5xtL+E
         ENILOdjTnsjJQmXGdhRXu2Hpb+fNUHY+BTdNjf4x7S3P/lDuy7sGcKn1KV1P05zZkPaU
         +uqSz3jnlE/qY9W1RdsdkdaNVel7e9fhAlzMSfmNdykR+OeoIqGnuw6gDl9eOGrhMUs6
         6lniOEx+5gWlfLei1GD2lVdJcYtfvvZwcta7uSNLTtcrObbDfRzjRogS9wh7FlfsBfeP
         l5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhdimRmcWFxSoj8AFDYbNHsikBJUsUucL4YCEQ/2njw=;
        b=J9winuNyIb+4jrb29ax+DohPlGXXJb+DiZ1Ka18t9dl7uV7WewrqT+HyHQ+XNh1uCn
         FDkoqvcXq3H0+lDebIuVxK10itF4eF+TZD7gC+5C9/04XjH7xRrtzpS4NDLzg/VlUUic
         IK/X22Y+2dWN/LP0IqxwtggX+iI5vtwmi8HF1kPGtt8ZF1ZofgIszm6oTxtEqnGIDanb
         0CjVnWnKvGWXC8NW/1SRBsAUsdB8HICOipPzN8o3MP1f+JCGFmXXZFzM2HqdNjMFsiCp
         l6mqrQ44FhDBGR9jDwCS+CzWE8RN2Neo5lcDJIvVSvKvWuLeglzUA2hP7fIi2Xl68E+a
         HEOA==
X-Gm-Message-State: AOAM532upmHvB/a0FFuU3EwtDMy5pP1QdU3RYEk0RB7V10JspuMz7pKK
        Cfaktr9+38dMuNYCIY1CDc0pTuGN5pSSsspyogxbeg==
X-Google-Smtp-Source: ABdhPJyRmdxXpkBjJhgLypJ27cbqA5yX2resHSeWAzU/LvydLIlTFHc1MP/3HSXWQhhwdgCDtzeYFR3RP7khraLUkho=
X-Received: by 2002:a05:6830:410e:: with SMTP id w14mr23863201ott.251.1620235511237;
 Wed, 05 May 2021 10:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org> <20210505141101.11519-1-ebiederm@xmission.com>
 <20210505141101.11519-4-ebiederm@xmission.com>
In-Reply-To: <20210505141101.11519-4-ebiederm@xmission.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 19:24:00 +0200
Message-ID: <CANpmjNNJ0vHq3s+mEqR1q8jqCzgHmivRcU+1m_Q8vquV5t5xWw@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] signal: Verify the alignment and size of siginfo_t
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
> Update the static assertions about siginfo_t to also describe
> it's alignment and size.
>
> While investigating if it was possible to add a 64bit field into
> siginfo_t[1] it became apparent that the alignment of siginfo_t
> is as much a part of the ABI as the size of the structure.
>
> If the alignment changes siginfo_t when embedded in another structure
> can move to a different offset.  Which is not acceptable from an ABI
> structure.
>
> So document that fact and add static assertions to notify developers
> if they change change the alignment by accident.
>
> [1] https://lkml.kernel.org/r/YJEZdhe6JGFNYlum@elver.google.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  arch/arm/kernel/signal.c           | 2 ++
>  arch/arm64/kernel/signal.c         | 2 ++
>  arch/arm64/kernel/signal32.c       | 2 ++
>  arch/sparc/kernel/signal32.c       | 2 ++
>  arch/sparc/kernel/signal_64.c      | 2 ++
>  arch/x86/kernel/signal_compat.c    | 6 ++++++
>  include/uapi/asm-generic/siginfo.h | 5 +++++
>  7 files changed, 21 insertions(+)
>
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index 2dac5d2c5cf6..643bcb0f091b 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -737,6 +737,8 @@ static_assert(NSIGBUS       == 5);
>  static_assert(NSIGTRAP == 6);
>  static_assert(NSIGCHLD == 6);
>  static_assert(NSIGSYS  == 2);
> +static_assert(sizeof(siginfo_t) == 128);
> +static_assert(__alignof__(siginfo_t) == 4);
>  static_assert(offsetof(siginfo_t, si_signo)    == 0x00);
>  static_assert(offsetof(siginfo_t, si_errno)    == 0x04);
>  static_assert(offsetof(siginfo_t, si_code)     == 0x08);
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index af8bd2af1298..ad4bd27fc044 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -985,6 +985,8 @@ static_assert(NSIGBUS       == 5);
>  static_assert(NSIGTRAP == 6);
>  static_assert(NSIGCHLD == 6);
>  static_assert(NSIGSYS  == 2);
> +static_assert(sizeof(siginfo_t) == 128);

Would using SI_MAX_SIZE be appropriate? Perhaps not.. in case somebody
changes it, given these static asserts are meant to double-check.

I leave it to you to decide what makes more sense.

> +static_assert(__alignof__(siginfo_t) == 8);
>  static_assert(offsetof(siginfo_t, si_signo)    == 0x00);
>  static_assert(offsetof(siginfo_t, si_errno)    == 0x04);
>  static_assert(offsetof(siginfo_t, si_code)     == 0x08);
> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> index b6afb646515f..ee6c7484e130 100644
> --- a/arch/arm64/kernel/signal32.c
> +++ b/arch/arm64/kernel/signal32.c
> @@ -469,6 +469,8 @@ static_assert(NSIGBUS       == 5);
>  static_assert(NSIGTRAP == 6);
>  static_assert(NSIGCHLD == 6);
>  static_assert(NSIGSYS  == 2);
> +static_assert(sizeof(compat_siginfo_t) == 128);
> +static_assert(__alignof__(compat_siginfo_t) == 4);
>  static_assert(offsetof(compat_siginfo_t, si_signo)     == 0x00);
>  static_assert(offsetof(compat_siginfo_t, si_errno)     == 0x04);
>  static_assert(offsetof(compat_siginfo_t, si_code)      == 0x08);
> diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
> index 778ed5c26d4a..32b977f253e3 100644
> --- a/arch/sparc/kernel/signal32.c
> +++ b/arch/sparc/kernel/signal32.c
> @@ -757,6 +757,8 @@ static_assert(NSIGBUS       == 5);
>  static_assert(NSIGTRAP == 6);
>  static_assert(NSIGCHLD == 6);
>  static_assert(NSIGSYS  == 2);
> +static_assert(sizeof(compat_siginfo_t) == 128);
> +static_assert(__alignof__(compat_siginfo_t) == 4);
>  static_assert(offsetof(compat_siginfo_t, si_signo)     == 0x00);
>  static_assert(offsetof(compat_siginfo_t, si_errno)     == 0x04);
>  static_assert(offsetof(compat_siginfo_t, si_code)      == 0x08);
> diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
> index c9bbf5f29078..e9dda9db156c 100644
> --- a/arch/sparc/kernel/signal_64.c
> +++ b/arch/sparc/kernel/signal_64.c
> @@ -567,6 +567,8 @@ static_assert(NSIGBUS       == 5);
>  static_assert(NSIGTRAP == 6);
>  static_assert(NSIGCHLD == 6);
>  static_assert(NSIGSYS  == 2);
> +static_assert(sizeof(siginfo_t) == 128);
> +static_assert(__alignof__(siginfo_t) == 8);
>  static_assert(offsetof(siginfo_t, si_signo)    == 0x00);
>  static_assert(offsetof(siginfo_t, si_errno)    == 0x04);
>  static_assert(offsetof(siginfo_t, si_code)     == 0x08);
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index 0e5d0a7e203b..e735bc129331 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -34,7 +34,13 @@ static inline void signal_compat_build_tests(void)
>         BUILD_BUG_ON(NSIGSYS  != 2);
>
>         /* This is part of the ABI and can never change in size: */
> +       BUILD_BUG_ON(sizeof(siginfo_t) != 128);
>         BUILD_BUG_ON(sizeof(compat_siginfo_t) != 128);
> +
> +       /* This is a part of the ABI and can never change in alignment */
> +       BUILD_BUG_ON(__alignof__(siginfo_t) != 8);
> +       BUILD_BUG_ON(__alignof__(compat_siginfo_t) != 4);
> +
>         /*
>          * The offsets of all the (unioned) si_fields are fixed
>          * in the ABI, of course.  Make sure none of them ever
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 03d6f6d2c1fe..91c80d0c10c5 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -29,6 +29,11 @@ typedef union sigval {
>  #define __ARCH_SI_ATTRIBUTES
>  #endif
>
> +/*
> + * Be careful when extending this union.  On 32bit siginfo_t is 32bit
> + * aligned.  Which means that a 64bit field or any other field that
> + * would increase the alignment of siginfo_t will break the ABI.
> + */
>  union __sifields {
>         /* kill() */
>         struct {
> --
> 2.30.1
>
