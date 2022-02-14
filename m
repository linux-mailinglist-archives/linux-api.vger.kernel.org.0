Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78324B5B89
	for <lists+linux-api@lfdr.de>; Mon, 14 Feb 2022 22:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiBNUxw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Feb 2022 15:53:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiBNUxc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Feb 2022 15:53:32 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD1AB872
        for <linux-api@vger.kernel.org>; Mon, 14 Feb 2022 12:53:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z14so11929813lfu.5
        for <linux-api@vger.kernel.org>; Mon, 14 Feb 2022 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uV1vHLzIr83T8MOCn12tMQAgRRvl8B7jglczOSl4CII=;
        b=JVRzXzobglXSiT0bLuA7vSr1HiJLXJeQF0BO276l66RCTCZjx8953KmFOVPMErrs0l
         on/NKX4mjsS9TS9bqhorHzBzM+OjtKgBLqdNoyLvrA639t1A433SV7/dJ5dxrhaCdPXH
         bTp5UzrLKiAt8Y3WQUfvdICLgLXk8cVAfLq1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uV1vHLzIr83T8MOCn12tMQAgRRvl8B7jglczOSl4CII=;
        b=KpCvwYUMar0u8eDBKy+8RE/d1GkE9IFgGXB2OCBUMx5Dul5z5u/n28h0eocSNXL/4x
         KIXLnP0r+LHX8fvzFiw8TcQ/CcJSKukAe2SEDtLzLWUbiziRs+G3W5Qc2y3Vs4Z3RLjY
         qlH40BRt8E0xTed8XNeT7Ch3npt3UAl7RZn9YGJl6JLFCsHcPtKJ5unOjc17MZljnB9l
         aFoFmlHanLJYVHHu00MfhXTJFRgDFUp9+Qw5Z4ZGoiEvC8qI/y0wNUCpY0Zvls5pLuUC
         +ggGICRYUonMGh7Hw/+p3syxCyfhfWsPoxaINI8PE4nthqPZcmrX2qYZQKqmY1t5JY1k
         1xVg==
X-Gm-Message-State: AOAM530vtaHWpzfU+yGqWT00INfC+FANDT/DHA/Vwf0IrXhP/hkRrnm/
        4i7yvgejy7qn/bLheu0A4NyaO5Ax4bhWs7OHImY=
X-Google-Smtp-Source: ABdhPJz2mJHuebd7KQC2qbK17P79MmSqxTGI8LyIj6M7miE7mQm3FmjS8LJ46v8kffBcEtjj7SWz8Q==
X-Received: by 2002:a05:6512:15aa:: with SMTP id bp42mr524661lfb.687.1644870271485;
        Mon, 14 Feb 2022 12:24:31 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id e8sm2186451lfr.40.2022.02.14.12.24.30
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:24:30 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id o9so19023531ljq.4
        for <linux-api@vger.kernel.org>; Mon, 14 Feb 2022 12:24:30 -0800 (PST)
X-Received: by 2002:a05:651c:1543:: with SMTP id y3mr306548ljp.152.1644870269711;
 Mon, 14 Feb 2022 12:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-5-arnd@kernel.org>
 <YgqLFYqIqkIsNC92@infradead.org> <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
 <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
In-Reply-To: <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Feb 2022 12:24:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgYu67OwP4LhcrPdDVxv2mOsx-Xsc2DKoVW6GZwKFtOYQ@mail.gmail.com>
Message-ID: <CAHk-=wgYu67OwP4LhcrPdDVxv2mOsx-Xsc2DKoVW6GZwKFtOYQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] x86: use more conventional access_ok() definition
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 14, 2022 at 12:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> x86-64 has always(*) used TASK_SIZE_MAX for access_ok(), and the
> get_user() assembler implementation does the same.

Side note: we could just check the sign bit instead, and avoid big
constants that way.

Right now we actually have this complexity in the x86-64 user access code:

  #ifdef CONFIG_X86_5LEVEL
  #define LOAD_TASK_SIZE_MINUS_N(n) \
        ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
                    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx),
X86_FEATURE_LA57
  #else
  #define LOAD_TASK_SIZE_MINUS_N(n) \
          mov $(TASK_SIZE_MAX - (n)),%_ASM_DX
  #endif

just because the code tries to get that TASK_SIZE_MAX boundary just right.

And getting that boundary just right is important on 32-bit x86, but
it's *much* less important on x86-64.

There's still a (weak) reason to do it even for 64-bit code: page
faults outside the valid user space range don't actually cause a #PF
fault - they cause #GP - and then we have the #GP handler warn about
"this address hasn't been checked".

Which is nice and useful for doing syzbot kind of randomization loads
(ie user accesses that didn't go through access_ok() will stand out
nicely), but maybe it's not worth this. syzbot would be fine with only
the "sign bit set" case warning for the same thing.

So on x86-64, we could just check the sign of the address instead, and
simplify and shrink those get/put_user() code sequences (but
array_index_mask_nospec() currently uses the carry flag computation
too, so we'd have to change that part as well, maybe not worth it).

                  Linus
