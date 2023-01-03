Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A3265C811
	for <lists+linux-api@lfdr.de>; Tue,  3 Jan 2023 21:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbjACU1E (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Jan 2023 15:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbjACU0o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Jan 2023 15:26:44 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D551814D3A
        for <linux-api@vger.kernel.org>; Tue,  3 Jan 2023 12:26:17 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id s9so25471485qtx.6
        for <linux-api@vger.kernel.org>; Tue, 03 Jan 2023 12:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mWQdhtHM3K1oyggbO+2dMJUZwBODavvxc7yTyFJ0lYI=;
        b=YDVCUDbgAeW0hVhs/g4JjH8kmsFuPnrsSO3rAzaQ8238JVlCpbbDmM/of5LDiFQ3ZR
         LsAhZ7OQBiszg4rGxhyYNLNLxWf8NjQaNJc7Q3pNZtyzmOdKo7YOKp1HwocTpMcHw08J
         Lp1wNe7fgslKvAudNAcF7WhpB5/QExxKAzdR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWQdhtHM3K1oyggbO+2dMJUZwBODavvxc7yTyFJ0lYI=;
        b=VZska6yi1AtpwGY24ookPRNwc0DePDXb8FLwx+ejzR6JMgRTzu0gTqFnDgrqR7kPbS
         rP/epvDWyn+YA7l0LEMQ5NXrA6v1fC/Jl4SuNAOXUmA7AlWd0HPN7ZwD2O5rB63xvIzt
         fCZ75WwkbxchPbcO7Pr2jbzjCIwSWGF+16x8xR8mgZhjPKup83GVwzMWPbyKVI8VaMek
         GiCNZg0T/rImgNDmDL62q//Bit/ysC9hGVfQzHYAztIzKhbiMVJV7wjDYdfouLwoFymo
         srNpcg7fyIA2D5Yoqy/W5yoQodET8Rx1TYowPlNjXmSebPfIChBWGNaA6oO6y/v5NGEF
         KuKw==
X-Gm-Message-State: AFqh2kqEzJAngCNkTNGGD10u1QpiHKVu8JpM83k/X5O21w7zwJbMmVnx
        oATwqeyhPlCyOYvJ86uVICqV/X9gl5fNhE5z
X-Google-Smtp-Source: AMrXdXsYuHmnsqJyKJijuGNGwZi4v23DWcFLPvFOJSj+jsEay82nY3FxXr4wTNiL7lWtrAsntKFhTw==
X-Received: by 2002:ac8:1e19:0:b0:3a7:242:501 with SMTP id n25-20020ac81e19000000b003a702420501mr67141533qtl.46.1672777576737;
        Tue, 03 Jan 2023 12:26:16 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id t29-20020a37ea1d000000b006fc40dafaa2sm22621319qkj.8.2023.01.03.12.26.15
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 12:26:15 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id pe2so15363471qkn.1
        for <linux-api@vger.kernel.org>; Tue, 03 Jan 2023 12:26:15 -0800 (PST)
X-Received: by 2002:a05:620a:1379:b0:6fc:c48b:8eab with SMTP id
 d25-20020a05620a137900b006fcc48b8eabmr1659307qkl.216.1672777574921; Tue, 03
 Jan 2023 12:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com> <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
In-Reply-To: <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jan 2023 12:25:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4SRHF6AhYDcgyokN2BMjra91Ns4h9wWPachhf-x3=xQ@mail.gmail.com>
Message-ID: <CAHk-=wg4SRHF6AhYDcgyokN2BMjra91Ns4h9wWPachhf-x3=xQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Tue, Jan 3, 2023 at 12:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 3, 2023 at 12:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > That buffering cannot be done safely currently
>
> .. again, this is "your semantics" (the (b) in my humbug list), not
> necessarily reality for anybody else.

Just to make an example: fork() is already problematic for something
as fundamental as <stdio.h>.

That doesn't mean that we do a special fork-safe stdio.h
infrastructure in the kernel. It just means that people have to do
things like fflush(NULL) (or use variations of setbuf() and friends)
when they deal with fork() and stdio interactions.

The random number generator really isn't that different. Periodic
reseeding isn't something stdio has to deal with, but having a
timestamp in user space library and forcing a re-seed isn't unheard of
in other contexts.

You don't even need anything as fancy as an actual timer, because it
doesn't need *active* flushing, just a "oh, it's been too long since
we read the random data, let's do it again".

And yes, I bet it would be a good idea to have an actual library for
this that handles (and *documents*) these kinds of issues - exactly
like a <stdio.h>, just for randomness.

I just don't think it should be involved in the kernel - again exactly
like <stdio.h>.

            Linus
