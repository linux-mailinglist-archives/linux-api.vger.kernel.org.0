Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B3B5A1723
	for <lists+linux-api@lfdr.de>; Thu, 25 Aug 2022 18:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbiHYQqD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Aug 2022 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbiHYQpX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Aug 2022 12:45:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE0CBC83C
        for <linux-api@vger.kernel.org>; Thu, 25 Aug 2022 09:43:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id og21so3133660ejc.2
        for <linux-api@vger.kernel.org>; Thu, 25 Aug 2022 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Zej4CxY/1CWynJQcpIFCE/ePm/cZkXwlSREUqfzuJ8Y=;
        b=h5BQlI0xIEyNRWKjxWMt8RcIcaw6Iab9Lro//TN7cNvmYLCYmjHA9b7vqil1aO5lR2
         jjncnbXB0E5n8vUT5r/OBW2cdzESp8HNiF0+6Am4i8gbPE/IF29BiN++mET+t+9HhGXy
         KU+7dVHbSPecBR62YILXw08KL2z9er7opHtdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Zej4CxY/1CWynJQcpIFCE/ePm/cZkXwlSREUqfzuJ8Y=;
        b=lexFz9PdHvEDt/mECfRIf8g+J6mhi/loAxXRPOywvmcAEG1tPP8tGaQj8yolN3crxm
         /EUN9nQGbeTJtBnmJkESYfHxUqj6XL3J/N4Cv/D0pLtxNmFFUNepqPl8NO02Ag3rODhr
         BxbcexRHk0II7aiseoKk6KNRwCZGQAca3mQ28AteQJ9qhdfv3vKdIMYcRr9DnO1PEkTF
         hlmZb19/zAZcsZHYHxKEhF72dAUTB1xitoF78uxpWLpzYbkV7yn+rhiwxJR+WY8hNsGq
         r08RaH3qLAmLQKbuqDqropWFSshTXbn1Kd4bDk9py7sgtw6FHVxWeIiod4MisX8yxUtt
         zAIg==
X-Gm-Message-State: ACgBeo0s3lKwlGfGpktNWHTFVWKbpSpDNHDhTyzi4W4fDA2yjx4EKoJg
        9Et9MDAuVW0NpMFN6k/fxcLvxzNM5ab/n0ZE/ZA=
X-Google-Smtp-Source: AA6agR45tkQQJfTEay/3KUEFKfIj/Nbl1VL/jN138VBFWJLW3nU8A8QeAsNWde1smVux2v6mFosB/g==
X-Received: by 2002:a17:906:9b90:b0:738:60f9:c7d6 with SMTP id dd16-20020a1709069b9000b0073860f9c7d6mr3068809ejc.198.1661445809109;
        Thu, 25 Aug 2022 09:43:29 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id 12-20020a508e4c000000b0043ba437fe04sm5196175edx.78.2022.08.25.09.43.28
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 09:43:28 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id bq11so18767572wrb.12
        for <linux-api@vger.kernel.org>; Thu, 25 Aug 2022 09:43:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr2680808wri.442.1661445807749; Thu, 25
 Aug 2022 09:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com> <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <87ilmgddui.fsf@oldenburg.str.redhat.com> <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
 <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Aug 2022 09:43:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWiU_KjueEE1Mi7rk6NCKaQRE=5hQaQC+2MY6-CabKFA@mail.gmail.com>
Message-ID: <CAHk-=wgWiU_KjueEE1Mi7rk6NCKaQRE=5hQaQC+2MY6-CabKFA@mail.gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C naming
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
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

On Thu, Aug 25, 2022 at 7:38 AM Joseph Myers <joseph@codesourcery.com> wrote:
>
> I've not yet implemented it for glibc or for GCC format checking, but C23
> adds 'wN' format length modifiers so you will be able to e.g. use "%w64d"
> with printf to print an int64_t and won't need those PRI macros any more.

Yeah, that's going to help user space.

We don't typically have huge issues with it (any more) in the kernel
exactly because we refused to do the syntactically horrendous PRIxyz
thing.

So in the kernel, we still do have some format string issues, but they
tend to be about "different architectures and configurations do
different things for this type", and those different things are sadly
not necessarily about a fixed width.

IOW, we used to have horrors like "sector_t can be 32-bit or 64-bit
depending on config options" (because small machines didn't want the
overhead of having to pass 64-bit things around - from back when
32-bit was a primary target).

We got rid of *that* thing a few years ago because it just wasn't
worth supporting any more, but some similar issues remain.

So we still have a number of cases of "if you really need to print
this out, you need to use '%llui' and cast the value to 'unsigned long
long'".

But it's happily not as common as it used to be.

                 Linus
