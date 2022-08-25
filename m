Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545155A0AB6
	for <lists+linux-api@lfdr.de>; Thu, 25 Aug 2022 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiHYHt3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Aug 2022 03:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiHYHt2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Aug 2022 03:49:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C6A0333
        for <linux-api@vger.kernel.org>; Thu, 25 Aug 2022 00:49:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lx1so1480738ejb.12
        for <linux-api@vger.kernel.org>; Thu, 25 Aug 2022 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pTSOf4yZBT6vxC8cWVxq54me3auAZtvDfhz2BczVtgE=;
        b=Ig6BLIDsaP7fwO4f2tblxSV8D0IEZ23t5746evH4pnH6oehSyZT/w7P79opUL+FnmK
         po3y3tMhPtweDHchzB18ityI3jwyATZyGSAP0WrqhvTn5ohd5US0JPEFOAGmxSk5vacw
         sKRqdCKWOUSMVwQEX9dCud+27HCTh3lUtbqk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pTSOf4yZBT6vxC8cWVxq54me3auAZtvDfhz2BczVtgE=;
        b=H3OyAEQrsgqTYp6oGgqdbhR1Ayo3YBQ8v7iaCfGHr2MzNR+6XIHhltrbvA1Eizct46
         oLf+Os1nxE1+Z4G7+7wR4v4LTlTWQlSUppxyJVqBxSa3QmyB+mQndB/J/0kszLjofUfX
         2nLqoSr2lWTunY+P4lTAwicvKdw5t/9JljxXv6k2lFY0QCoqLwusDz+FvekfmMEwq/RY
         /yUm2k7yXZ3R6Kn5ktAPM3eHdmfSXDjBseyaVmWLpq24cR7BVvh4WjY/4n4fgxU8j665
         78yPpegtVJDi6N8wOVn/GlWvLVo9xSixWLrFlCrax//zioHklDONkyF0z/NacgRusDt1
         LOMQ==
X-Gm-Message-State: ACgBeo0/bgCWsqBYtfvvJel+B0S1DoMCbOK2X1vvWhnkh8JhrAqObLG0
        pELa+tU66iv6SIJSWBMU8mRbRvbQN+NQNZDLJI0=
X-Google-Smtp-Source: AA6agR5Bu39SBwCvITSwLFN4LryQcrBW2Zd5xMXS7Zd/YPxpIphqq8+8MFDxp8p4n2rQBefuSpL3UQ==
X-Received: by 2002:a17:907:2722:b0:731:2aeb:7942 with SMTP id d2-20020a170907272200b007312aeb7942mr1630693ejl.734.1661413765036;
        Thu, 25 Aug 2022 00:49:25 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id r9-20020a170906280900b0073d6d6e698bsm2031443ejc.187.2022.08.25.00.49.24
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:49:24 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso2061222wmr.3
        for <linux-api@vger.kernel.org>; Thu, 25 Aug 2022 00:49:24 -0700 (PDT)
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id
 s25-20020a7bc399000000b003a5f3fb85e0mr1402129wmj.38.1661413369950; Thu, 25
 Aug 2022 00:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com> <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
 <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
In-Reply-To: <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Aug 2022 00:42:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSx8O0=p18C1aQuH4Gw7xmKujBKMEiSitCA7oG2h6WLg@mail.gmail.com>
Message-ID: <CAHk-=wgSx8O0=p18C1aQuH4Gw7xmKujBKMEiSitCA7oG2h6WLg@mail.gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C naming
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 25, 2022 at 12:20 AM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> This patch is not about kernel, but about the section 2 and 3 manual
> pages, which are directed towards user-space readers most of the time.

They are about the types to the kernel interfaces. Those types that
the kernel defines and exposes.

And the kernel type in question looks like this:

        struct { /* anonymous struct used by BPF_PROG_LOAD command */
                __u32           prog_type;      /* one of enum bpf_prog_type */
                __u32           insn_cnt;
                __aligned_u64   insns;
                __aligned_u64   license;

because the kernel UAPI header wants to

 (a) work whether or not <stdint.h> was included

 (b) doesn't want to include <stdint.h> so as to not pollute the namespace

 (c) actually wants to use our special types

I quoted a few more fields for that (c) reason: we've had a long
history of getting the user space API wrong due to strange alignment
issues, where 32-bit and 64-bit targets had different alignment for
types. So then we ended up with various compat structures to translate
from one to the other because they had all the same fields, but
different padding.

This happened a few times with the DRM people, and they finally got
tired of it, and started using that "__aligned_u64" type, which is
just the same old __u64, but explicitly aligned to its natural
alignment.

So these are the members that the interface actually uses.

If you document those members, wouldn't it be good to have that
documentation be actually accurate?

Honestly, I don't think it makes a *huge* amount of difference, but
documentation that doesn't actually match the source of the
documentation will just confuse somebody in the end. Somebody will go
"that's not right", and maybe even change the structure definitions to
match the documentation.

Which would be wrong.

Now, you don't have to take the kernel uapi headers. We *try* to make
those usable as-is, but hey, there has been problems in the past, and
it's not necessarily wrong to take the kernel header and then munge it
to be "appropriate" for user space.

So I guess you can just make your own structures with the names and
syntax you want, and say "these are *my* header files, and *my*
documentation for them".

That's fine. But I'm not surprised if the kernel maintainer then goes
"no, that's not the interface I agreed to" if only because it's a pain
to verify that you got it all right. Maybe it was all trivial and
automated and there can be no errors, but it's still a "why is there a
different copy of this complicated interface".

If you really want to describe things to people, wouldn't it be nicer
to just say "there's a 32-bit unsigned 'prog_type' member" and leave
it at that?

Do you really want to enforce your opinion of what is prettier on the
maintainer that wrote that thing, and then argue with him when he
doesn't agree?

                  Linus
