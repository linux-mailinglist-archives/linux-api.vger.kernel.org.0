Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E2F419ED4
	for <lists+linux-api@lfdr.de>; Mon, 27 Sep 2021 21:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhI0TD4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Sep 2021 15:03:56 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbhI0TDz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Sep 2021 15:03:55 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MdwRi-1n4ofh3zuQ-00b4yY; Mon, 27 Sep 2021 21:02:16 +0200
Received: by mail-wm1-f43.google.com with SMTP id t16-20020a1c7710000000b003049690d882so1493491wmi.5;
        Mon, 27 Sep 2021 12:02:15 -0700 (PDT)
X-Gm-Message-State: AOAM530aHFNmQ/YXY6nBF0NEzMt8OW1uyymH1U5foQL9343OVaifRiLF
        VzUx5h+nUy0G7ip4IvKtxogYo5i6oupkE3RzqvE=
X-Google-Smtp-Source: ABdhPJy79GvrLbGbTQ8AFXTHbME27yck4aLAU/Tyk7Yz+HgqfmX9UVGglkndMij2PPstBo5KAXPiu0yRr6boGHxrkfU=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr701388wmc.98.1632769335470;
 Mon, 27 Sep 2021 12:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210927161955.28494-1-rpalethorpe@suse.com> <875yuletsw.fsf@oldenburg.str.redhat.com>
In-Reply-To: <875yuletsw.fsf@oldenburg.str.redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Sep 2021 21:01:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3o96yR4LBSv8Q-_oy0g3hULS_kcm2fpahjEvqB6i_EuQ@mail.gmail.com>
Message-ID: <CAK8P3a3o96yR4LBSv8Q-_oy0g3hULS_kcm2fpahjEvqB6i_EuQ@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/ia32: Ensure s32 is sign extended to s64
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Richard Palethorpe <rpalethorpe@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
X-Provags-ID: V03:K1:eq1p4rR48K6UZamzIXjZYFVnkdM6YeIhS041Ef2FdEAXAVwckgv
 o7+D1qnVmiu4QhUi6ozkdRUHYMAoSyHJ/VKiHID287vjTHApgLlNN1ybSFK+EBudWuVYpfS
 DumHaRHlIltIoiLQTT19d14ntJsV7fQ0wPnW+LgwLIRDAMqK+Q+uhTND1Xyi7VSo53oUFbH
 iyI1DD8L/Sk+oyeAd68oA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RlI8kg2kRSI=:CFIxa1gC9QGwHz6uvxjkmp
 v7JjCHNB+2rbqEEqRxnxg/qzRLlBSltH7i4dtvtaNyx+BX18bcsSIA4I9LXeC0TZkmLqtu/Zz
 hZHuWcQuhWC6HyNTlXTsyd3iyE4MhsM6VLqU3gRasdlW0kXAvfq5hjs462QSmPdDfTof0kCPl
 ePEI9Wvzqf7fb5YOh+KF8k6JRZc+1v3hT9IU14xQE/gdBkCpZ2p4dmYRI0lB/LMxtst9lrgmP
 XwkbQi7ZKsb8t+ILkkb9XPfYGMGIIliqhRJ6EJEceeYjBQHAyUpmGKgy6NfMu1gIaPyT6gxD4
 qlxvK6aVe3LoE0RR6j/RYhv1e2pm+UCjle2yP79VGyViWrgLBRz6jamACr9pllhE6yukQhsKk
 wuD3es3n58xig5P2AvDn96mDM/bJ4F4S28IY4mh7fngrI+RD6wHXMhgSitJKZRm29iFKtqRB8
 9n8F/KJmEGN7o7C/2Gcc9MD+qEwXwAJDZmmC9mRbXiR3A5fZnFefgJnwdbUNh2tV5psh4MS5X
 7CfbC13xjwKkbL8G1hdQ3x441lnTPtLstpkJyKES1mMIheIX9UgF2QzScEYc58bHaLrUAaoE6
 pGyTlfu9Axusx3Gio7Wf2ueUTfuWFNg2+oHvKkB689jBA8+JKoMO73S1w1TzwFpfdhTgnrs2s
 dZt7eIzrroLl2ufMXsaJrYRAS1Vn9IJoJL0r3+hGgyGIBjrnX7aCc41XoCKhexoWhxL17ZBzH
 QrCSQBAAQwDrUBi9FHzhGR0EmoXNFpiTN5oOpHx8xgMJi+SfjcvmSDr6lZl4pqJD3OOL9ZO9r
 KwxBsXYpGsko0EvoHxpkVw4QmYmLgclqF2b/Jh7ohM/+Pvo+jFruhqLTcbIBHfcko27IcBjOF
 n9oHEYJAmLprqjQOAMWg==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 27, 2021 at 8:51 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Richard Palethorpe:
>
> > +#define __SC_COMPAT_CAST(t, a)                                               \
> > +     (__typeof(__builtin_choose_expr(__TYPE_IS_L(t), 0, 0U)))        \
> > +     (unsigned int)a
>
> So this casts to int (triggering sign extension) if the type on the
> 64-bit kernel side is long?  But not in other cases (unsigned long,
> pointer)?  Just double-checking.

Correct, this is the only case that is not already handled: anything smaller
than a 'long' is the same size on all architectures we support and we
ensure those are correctly sign- or zero-extended. 'unsigned long'
and any pointer are zero-extended by the entry code from 32-bit user
space to a 64-bit register in the kernel. Only signed 'long' requires
explicit sign-extending from the userspace 'long' to the kernel function
argument.

         Arnd
