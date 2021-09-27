Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2C7419E10
	for <lists+linux-api@lfdr.de>; Mon, 27 Sep 2021 20:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhI0SYU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Sep 2021 14:24:20 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhI0SYT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Sep 2021 14:24:19 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MKt3r-1mGxh702wv-00LAyB; Mon, 27 Sep 2021 20:22:40 +0200
Received: by mail-wm1-f46.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso678300wmd.5;
        Mon, 27 Sep 2021 11:22:39 -0700 (PDT)
X-Gm-Message-State: AOAM530J5gGUJ3kichtFZSMe8S7JTGFfH8GGB6J4rlEoeUD/lwy6dD7v
        IEQx3/UXhV0U+Y4pWXaISvYZe7TBwknNJ+30nBo=
X-Google-Smtp-Source: ABdhPJwCCfy48nJsv/jBkQ+FqTChrVTa3J/1b3crzTUhy/rlsn26nuFEnfQytCPMcD0SR1VltuyU2G/7abBHN508EYw=
X-Received: by 2002:a05:600c:22d4:: with SMTP id 20mr539812wmg.82.1632766959604;
 Mon, 27 Sep 2021 11:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210927161955.28494-1-rpalethorpe@suse.com>
In-Reply-To: <20210927161955.28494-1-rpalethorpe@suse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Sep 2021 20:22:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2kuZkoF1m0pTXWeq0gnzUG9oSTQKtjjdiCyo1ptmXPgA@mail.gmail.com>
Message-ID: <CAK8P3a2kuZkoF1m0pTXWeq0gnzUG9oSTQKtjjdiCyo1ptmXPgA@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/ia32: Ensure s32 is sign extended to s64
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, rpalethorpe@richiejp.com,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EOEOhVKtXUW4bSdluaJa5jihN3589/mpHa7f+YvsokOLqhtrBK+
 ghODJDGHdSQi5x1i/T/lHKYWRaJ+OKr47H+oeodVaP5BSnlQwv2ehsp9S2RCP0e4Udhlbu+
 rr47ttfDRhc+rUBdfwyW1+e3OXiDLW5biH1tsUJ18Rd22XRzzTbcgZTZ45YPPJMlV1KEH4R
 hH4CZ2+A7U2vI4kwzU7hg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i0ktgu2KnJM=:siyWKkDyvqhadWIMT55pOL
 NDQrUHMbAyvtQx1LJ+wMKv1hEUmH6EyrbYQt6YqTDk42wmO/Dx81EN4EaGSiiCyD/0lHmuyl6
 /VynQi0QtmajQk+Abn83HMr6uU91cs8cxBqNw1kaa3PtrPMewKPN20OjdMRzINX158InN5oDn
 0TR0NmVUs7teGDDVoCoa31+VEM6iOdmXyyjQqQCy1uJD9kDJIoYBKb8Pl+mTs/+bpQ9JfJWpz
 M1Ez3FWYZzZswY0ZIq7aGTVc7sxyaaL47sURFxNW0ZaJ4ibKy2bx3WCP3JT0iajcUIpzi3xyZ
 eGHzkBR1GbgePRJdViyzXfayWV1VhCNAZtp074bHVE3lUxv9HV9ZYVFd1Yh/DEm9q9nrL4D7x
 I2CsZUU1ttTVfdj4eN1u+X4xeEL9BD14e5+T9KrI8jzc+MAVwF+DJ2lkPjGrx9t++eJApuix7
 x5suKZtQjPaxAUADRKJfMU+x0wf3sjbDsEI5v1jfRCOwMtikjL2yswKKpyAfY0bSw6KfH64X0
 +7udwvN24pD3flPZF0OKfpg82KzEeybzUxTZ6uxNd+vngKnAckp6fjDv6Cdnsr/SRqLMGitTr
 1CU7t7YTZObAbCSW1pdZTJtBjXvH9vjcdzrEeX5zZnOrCNS27vFxOWZIQl68z8vFQyo4r0NoF
 UTff00gGnWO8z1Y1vFegdLpdWA1th9A2x4yymX+dOgXkxJ+07vw6IIyWqNSMqqmWMZOtigEyv
 fUjs0ZnxgXpxfQd1oQ+OSMV/kLr1h+2RGP62O24iJLH75bnNleFK1SMxspC4vhbhpfiFyzaxA
 zibAB6Q3VeKjyM2ZR19NUaGigkGkoEpuizuS9xUCHzr1fvqPDB5NQ63fPjW62HU7uRGane36t
 NEGQl+ZzPHIUdaEGCFoQ==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 27, 2021 at 6:21 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> Presently ia32 registers stored in ptregs are unconditionally cast to
> unsigned int by the ia32 stub. They are then cast to long when passed
> to __se_sys*, but will not be sign extended.
>
> This takes the sign of the syscall argument into account in the ia32
> stub. It still casts to unsigned int to avoid implementation specific
> behavior. However then casts to int or unsigned int as necessary. So
> that the following cast to long sign extends the value.
>
> This fixes the io_pgetevents02 LTP test when compiled with
> -m32. Presently the systemcall io_pgetevents_time64 unexpectedly
> accepts -1 for the maximum number of events. It doesn't appear other
> systemcalls with signed arguments are effected because they all have
> compat variants defined and wired up. A less general solution is to
> wire up the systemcall:
> https://lore.kernel.org/ltp/20210921130127.24131-1-rpalethorpe@suse.com/
>
> Fixes: ebeb8c82ffaf ("syscalls/x86: Use 'struct pt_regs' based syscall calling for IA32_EMULATION and x32")
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me, thanks for following through with this part, and for
checking the other syscalls!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I've added this to my randconfig build tree as well, to see if
it causes any unexpected compile-time issues, though I
don't expect any problems here.

There are a few things that I think we should do as a follow-up:

- do the same thing in the generic syscall wrapper, to ensure the
  other architectures also do the sign-extension.

- Fix the big-endian architectures (ppc64be, mips64be, sparc, s390
  parisc) so they pass the correct signal mask, either using your original
  approach, or by reworking the syscall to detect compat syscalls
  at runtime, killing off the separate entry point

- Go through the compat syscalls to see if any of them can be
  removed once all architectures do sign-extension correctly.

Are you motivated to help out with one or more of these as well?

       Arnd
