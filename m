Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3345E5ADC2
	for <lists+linux-api@lfdr.de>; Sun, 30 Jun 2019 01:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfF2Xnc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 29 Jun 2019 19:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfF2Xnc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 29 Jun 2019 19:43:32 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4C8F2184B
        for <linux-api@vger.kernel.org>; Sat, 29 Jun 2019 23:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561851811;
        bh=6Ls1mmfTCbzFx4Rzb3UhYmFEV6me19aFFOMlTGuTuMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fKAjCc+JM24ptph7FQwwWDjNeU0M7u1DLMDnFvO5RD2JO4y5N6c03CLXkbCz0PUBw
         8rc0VpCNeD7ziYfz2RtjYgq+uwSJVs3Zsoa/luWgVigokxMHuZiFxRcQhJuq+VEwsY
         aCZFtR37i+6FQbF9MgjOdGmDd3+cLNyeUVYypWDM=
Received: by mail-wr1-f47.google.com with SMTP id e3so360453wrs.11
        for <linux-api@vger.kernel.org>; Sat, 29 Jun 2019 16:43:30 -0700 (PDT)
X-Gm-Message-State: APjAAAV1YspR4P3AW+L4gcIMWVubDF7Vq7I1x68C8GbwtWVDrOcVd+mp
        WdA1p5eU/KvbIV57DZ9uLDT2grG2domJr4Xsf4Z02A==
X-Google-Smtp-Source: APXvYqy1lccm+W/+pWlsgMcG6L5G1lNH4IFhUO6vjgvEXUaNIhYR7BWWHlgDd5MOsBd1OpDkbJ+gIKmRECPoUjBLpFU=
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr10561378wrm.265.1561851809106;
 Sat, 29 Jun 2019 16:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190628194158.2431-1-yu-cheng.yu@intel.com> <20190628194158.2431-2-yu-cheng.yu@intel.com>
In-Reply-To: <20190628194158.2431-2-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 29 Jun 2019 16:43:18 -0700
X-Gmail-Original-Message-ID: <CALCETrVvbbCWMPo7v5eYgTocaxRQPHerJ=CRjWscGxgb6QjOFA@mail.gmail.com>
Message-ID: <CALCETrVvbbCWMPo7v5eYgTocaxRQPHerJ=CRjWscGxgb6QjOFA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] Introduce arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE)
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> On Jun 28, 2019, at 12:41 PM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> The CET legacy code bitmap covers the whole user-mode address space and i=
s
> located at the top of the user-mode address space.  It is allocated only
> when the first time arch_prctl(ARCH_X86_MARK_LEGACY_CODE) is called from
> an application.
>
> Introduce:
>
> arch_prctl(ARCH_X86_MARK_LEGACY_CODE, unsigned long *buf)
>    Mark an address range as IBT legacy code.

How about defining a struct for this?

The change log should discuss where the bitmap goes and how it=E2=80=99s al=
located.

> +static int alloc_bitmap(void)
> +{
> +    unsigned long addr;
> +    u64 msr_ia32_u_cet;
> +
> +    addr =3D do_mmap_locked(NULL, IBT_BITMAP_ADDR, IBT_BITMAP_SIZE,
> +                  PROT_READ | PROT_WRITE,
> +                  MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE,
> +                  VM_IBT | VM_NORESERVE, NULL);
> +
> +    if (IS_ERR((void *)addr))
> +        return addr;
> +
> +    current->thread.cet.ibt_bitmap_addr =3D addr;

addr is a constant. Why are you storing it?  If it ends up not being
constant, you should wire up mremap like the vDSO does.


> +static int set_user_bits(unsigned long __user *buf, unsigned long buf_si=
ze,
> +             unsigned long start_bit, unsigned long end_bit, unsigned lo=
ng set)
> +{
> +    unsigned long start_ul, end_ul, total_ul;
> +    int i, j, r;
> +
> +    if (round_up(end_bit, BITS_PER_BYTE) / BITS_PER_BYTE > buf_size)
> +        end_bit =3D buf_size * BITS_PER_BYTE - 1;
> +
> +    start_ul =3D start_bit / BITS_PER_LONG;
> +    end_ul =3D end_bit / BITS_PER_LONG;
> +    total_ul =3D (end_ul - start_ul + 1);
> +
> +    i =3D start_bit % BITS_PER_LONG;
> +    j =3D end_bit % BITS_PER_LONG;
> +
> +    r =3D 0;
> +    put_user_try {

put_user_try is obsolete.  Just use get_user(), etc.

Also, I must be missing something fundamental, because this series
claims that user code can't write directly to the bitmap.  This means
that this entire function shouldn't work at all.
