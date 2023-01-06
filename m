Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27666660942
	for <lists+linux-api@lfdr.de>; Fri,  6 Jan 2023 23:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjAFWH0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Jan 2023 17:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjAFWHM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Jan 2023 17:07:12 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F1484BEE
        for <linux-api@vger.kernel.org>; Fri,  6 Jan 2023 14:07:10 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id i185so2924573vsc.6
        for <linux-api@vger.kernel.org>; Fri, 06 Jan 2023 14:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9dqVddWwlNIkWBEkX2eMMbroRQSsxPmZhf5UK2bJx4=;
        b=O6fLaeMkOAI9qlrlbD9V9hqb0FRi+3fYwY656X3zqlxsNXYgmUCLgJYTFwJVKAjthE
         irUaeSLWBxwa416jiNkQxJky4pxbLUW3S/rzOYcjecUxbP1aO1xBadn5G83AJZJjM0GP
         8LNX+VfdzXkl4XSINWkZYmRr2ww9tgPFY2yho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9dqVddWwlNIkWBEkX2eMMbroRQSsxPmZhf5UK2bJx4=;
        b=q94IWTDDpjo2V6oN11JhQwudbtY+ri4EbTbyastZVvUIAnIW2Np4El1gRGVcUzMG3D
         gwTkp5KGOL3LbA8fYm/2D8dgttJljMrcfnPh46hpGcBEivXGNa9Ir0yIk859KLLT2HgZ
         l08pZ06P7tStnADv+uoDr0AY5VjfrfsU2RevKzZn76IcISQOuQncgSZ8xqTioVgwOdh5
         cGh4261VMcaNo3JfsqVJfC9D1QsT6MrRcckVHOtL39NQomgsU6KVYHMLI58nSwZwe6IR
         12/EETeGHYfsjqufeG/JnsitvEOYCZkssgdyRUoCrxwPDmGFNtXmavwKHz3v42cKf+Q2
         qUDw==
X-Gm-Message-State: AFqh2kpgoNZhW8tk4lCKBW4VC8Qn5JauIukbMoFmon29TRaUy/sjqio6
        /1mwx55zuejqfKXCNDQUaLfMFMQ6oMs8sapO
X-Google-Smtp-Source: AMrXdXsKD5UK+rMpjIY/M+IR6ftZcovqozOZpLNDSZrGChGUNt6ZOsHABtu7OLHlfLF1UoWXcR400A==
X-Received: by 2002:a67:e2c3:0:b0:3ce:e9bd:aa0f with SMTP id i3-20020a67e2c3000000b003cee9bdaa0fmr1565626vsm.32.1673042829052;
        Fri, 06 Jan 2023 14:07:09 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a0c4200b006f9f3c0c63csm1212194qki.32.2023.01.06.14.07.07
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:07:07 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id i12so1923157qvs.2
        for <linux-api@vger.kernel.org>; Fri, 06 Jan 2023 14:07:07 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr2661817qvv.130.1673042827328; Fri, 06
 Jan 2023 14:07:07 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com> <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com> <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
 <Y7dV1lVUYjqs8fh0@zx2c4.com> <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
 <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com> <Y7iV18CqKAa4gO9r@casper.infradead.org>
In-Reply-To: <Y7iV18CqKAa4gO9r@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jan 2023 14:06:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj7jenrb6UNjv--xLC4hrjJDsCFxuaHw1e67a4ihVEmUw@mail.gmail.com>
Message-ID: <CAHk-=wj7jenrb6UNjv--xLC4hrjJDsCFxuaHw1e67a4ihVEmUw@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 6, 2023 at 1:42 PM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> I'd be more inclined to do:
>
> typedef unsigned int vm_flags_t[2];

No, that's entirely invalid.

Never *ever* use arrays in C for type safety. Arrays are not type
safe. They can't be assigned sanely, and they silently become pointers
(which also aren't type-safe, since they end up converting silently to
'void *').

If you want to use the type system to enforce things, and you don't
want to rely on sparse, you absolutely have to use a struct (or union)
type.

So something like

   typedef struct { u64 val; } vm_flags_t;

would be an option.

              Linus
