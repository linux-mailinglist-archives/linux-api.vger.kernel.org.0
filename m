Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB834BBF01
	for <lists+linux-api@lfdr.de>; Fri, 18 Feb 2022 19:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbiBRSHj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 18 Feb 2022 13:07:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbiBRSHi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 Feb 2022 13:07:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B71D9644
        for <linux-api@vger.kernel.org>; Fri, 18 Feb 2022 10:07:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u18so16835106edt.6
        for <linux-api@vger.kernel.org>; Fri, 18 Feb 2022 10:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DIqXxPmp6dtbTijOx2KTFQ/AdtfYUTWecKVh7q3dDI=;
        b=5c/qRto3YK3Y6/Rhnnpp4RzKmf8QhiKseObhkqXIpnLfhpnv2ua8Z7YCExbmjSYUCG
         SbBSycxSpm4FRe5zOaxst92xyRDLRie0B4d4p8x0W6snNr+dG6MghxLfcakTWMQA17Pf
         gOp7JS9gIpdJumtDaMv9IluyX8dB5LI5eLR/YC2U+D7T5N3aQr9NOYHAOP982E02xanw
         SC1uTLhbyKEp3+LiMa1bFSquyveVGLxTCPf/eSvmTiEZzxEI+wIe4AMdv5VgRD2GYf6G
         kO3gnVVxKK1wWuKxjcQ5nhLyDgmj/c1nxTJoqfRQTmuVCBNlEZ4IpVOo74LURbiOVsEg
         CBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DIqXxPmp6dtbTijOx2KTFQ/AdtfYUTWecKVh7q3dDI=;
        b=q5reeKvUkJyvE3aGuAuPOma50lSnMlZyBnpPDnccQoYkvSHW2HsX2fwnJscTb4rnBE
         S8TphAJ1kzpb2uz+sJR5EZ9vzqUGKqgphZv7D+GTourjHcpe6Ffu+NfgQBzyXOsQeRtc
         YdoVGo5mSySTrPYg1sqRTXM6D6HXGpcWFmtsBuzogZ4ddUan7litkwkGKuW3pAN2lj+f
         2+qEXtElb/is+6dU31KxAn4BZCXQDkBfLd4fcFUiwtha4jkyPXHpei1HpyN0V0TFx6oI
         PCaIZkRLeNBs8BUSJS9rODNi+LFFBBgxNfPiUUCcwhDT5mjRwrSCaWVs07HdtdBDg5H4
         N9oA==
X-Gm-Message-State: AOAM533hBWDC/YYNXQnSa6NzP8dXNEDTtU4WAEhnrcPBFM69qeekzCUm
        /LDaJhRO3Jn7WwPJ+JhyNZM0ck84FN2fdByRYm+FHQ==
X-Google-Smtp-Source: ABdhPJzKi9/dAquBFvy+ZlpESpcVBT1I3X4XtLJClo2SaEqFpqb8kdqwnL9Fphl8e/qcsjqeDfp/tX4JIrAspWajnck=
X-Received: by 2002:a05:6402:430f:b0:410:a082:c6da with SMTP id
 m15-20020a056402430f00b00410a082c6damr9386454edc.438.1645207638871; Fri, 18
 Feb 2022 10:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-14-arnd@kernel.org>
 <CALCETrVOvYPN4_6hS8wpm2v9bGZupZ5x4=vZAseG57OUgvLGfw@mail.gmail.com> <93a1ee797e9d4f789dff85a3c0f0c232@AcuMS.aculab.com>
In-Reply-To: <93a1ee797e9d4f789dff85a3c0f0c232@AcuMS.aculab.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 18 Feb 2022 10:07:07 -0800
Message-ID: <CALCETrWTB65vJXsQTPd_o7BRoSU=uqD0pFzKS+r4YgDuiCCqaQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
To:     David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "will@kernel.org" <will@kernel.org>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "bcain@codeaurora.org" <bcain@codeaurora.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "dalias@libc.org" <dalias@libc.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "richard@nod.at" <richard@nod.at>,
        "x86@kernel.org" <x86@kernel.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 18, 2022 at 1:30 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Andy Lutomirski
> > Sent: 17 February 2022 19:15
> ...
> > This isn't actually optimal.  On x86, TASK_SIZE_MAX is a bizarre
> > constant that has a very specific value to work around a bug^Wdesign
> > error^Wfeature of Intel CPUs.  TASK_SIZE_MAX is the maximum address at
> > which userspace is permitted to allocate memory, but there is a huge
> > gap between user and kernel addresses, and any value in the gap would
> > be adequate for the comparison.  If we wanted to optimize this, simply
> > checking the high bit (which x86 can do without any immediate
> > constants at all) would be sufficient and, for an access known to fit
> > in 32 bits, one could get even fancier and completely ignore the size
> > of the access.  (For accesses not known to fit in 32 bits, I suspect
> > some creativity could still come up with a construction that's
> > substantially faster than the one in your patch.)
> >
> > So there's plenty of room for optimization here.
> >
> > (This is not in any respect a NAK -- it's just an observation that
> > this could be even better.)
>
> For 64bit arch that use the top bit to separate user/kernel
> you can test '(addr | size) >> 62)'.
> The compiler optimises out constant sizes.
>
> This has all been mentioned a lot of times.
> You do get different fault types.
>
> OTOH an explicit check for constant size (less than something big)
> can use the cheaper test of the sign bit.
> Big constant sizes could be compile time errors.

The different fault type issue may well be a real problem.  Right now
the core x86 fault code reserves the right to grouch if we get #GP
instead of #PF.  We could change that.
