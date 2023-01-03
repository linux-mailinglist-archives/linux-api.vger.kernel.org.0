Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9165C7CA
	for <lists+linux-api@lfdr.de>; Tue,  3 Jan 2023 21:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjACUAx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Jan 2023 15:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjACUAw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Jan 2023 15:00:52 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4853DCA
        for <linux-api@vger.kernel.org>; Tue,  3 Jan 2023 12:00:49 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id j16so25435702qtv.4
        for <linux-api@vger.kernel.org>; Tue, 03 Jan 2023 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xug8HsBhB4vw61CYQrO6p56II484h234IA/MNnX9p8=;
        b=EbYiDfIyp249xUh5FwvkVnPr7aBXtVFVGZSFtl9pIKq68SODoEw8kZPQnYL8sXX69z
         F8E5UHAWixIJOtaSy7hFVhbt6eKa4sXCG4zalB7Ox/hGl++YbRVBW/YzL9Wjbkm4SzAX
         YQKeVGr58BgkVk4yWdEMW4R74YCb6drskvcyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Xug8HsBhB4vw61CYQrO6p56II484h234IA/MNnX9p8=;
        b=h95Pqb9blW78hMhkkpJbsMup9lddpNhqjmbI17VzpfeQ5+03XLNVg0MZRN2srn/Is9
         dWoS79rQGYyQhaUJApHHF3NcnwLwIOUC98xY3aCqht4Aq6FP1d5Rf4KnQcJO3IGOqnOb
         oc8MKlrxaoauxhYVfWL6U0f5PiSAVae0Q2LqZF4Ar/04FmKK20N0X0AEoYboi7Q/bw0Z
         VbSGn9HXQy9Y5n/x8jfJkWoYS+9TnXm8LzCfBEaWYOQ2dX3WANe6yBNrpj2Cnib3l3bV
         ZJ/A5n0xz7bq3Cvv8IW9Udz9X7O4v4DdNekQ9M7MMI8t6u53KWGI6B510L/5USN/GdI1
         IBbg==
X-Gm-Message-State: AFqh2kpHMAnBfeiH8oI1g5Ldl2kDFxpgYcuxxjneuSgoYJCwvRJIw7tU
        DGhlQaH0EeciRvhNoeJmnsFQAhgHaqriYntf
X-Google-Smtp-Source: AMrXdXvdljzfh/1qtn9f4hxpPhvOOafu8TjkrmgqKhNqsfBaddB3nmLdwcPBnOFecUQJLmx7O+Xasw==
X-Received: by 2002:ac8:4689:0:b0:3a9:9c6a:afdf with SMTP id g9-20020ac84689000000b003a99c6aafdfmr68836810qto.50.1672776048763;
        Tue, 03 Jan 2023 12:00:48 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id b6-20020ac86786000000b003a50b9f099esm19070280qtp.12.2023.01.03.12.00.48
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 12:00:48 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id z12so25430612qtv.5
        for <linux-api@vger.kernel.org>; Tue, 03 Jan 2023 12:00:48 -0800 (PST)
X-Received: by 2002:ac8:4913:0:b0:3ab:88cb:97cb with SMTP id
 e19-20020ac84913000000b003ab88cb97cbmr986538qtq.436.1672775691842; Tue, 03
 Jan 2023 11:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com> <Y7SDgtXayQCy6xT6@zx2c4.com>
In-Reply-To: <Y7SDgtXayQCy6xT6@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jan 2023 11:54:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
Message-ID: <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
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

On Tue, Jan 3, 2023 at 11:35 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> I don't think this is about micro-optimization. Rather, userspace RNGs
> aren't really possible in a safe way at the moment.

"Bah, humbug", to quote a modern-time philosopher.

It's humbug simply because it makes two assumptions that aren't even valid:

 (a) that you have to do it in user space in the first place

 (b) that you care about the particular semantics that you are looking for

The thing is, you can just do getrandom(). It's what people already
do. Problem solved.

The system call interface just isn't that expensive. Sure, the various
spectre mitigations have screwed us over in a big way on various
hardware, but even with that in mind system calls aren't some kind of
insurmountable hazard. There are absolutely tons of system calls that
are way more performance-critical than getrandom() has ever been.

So 99% of the time, the solution really is just "getrandom()",
generally with the usual buffering ("read more than you need, so that
you don't do it all the time").\

Which is not at all different from all the other system calls like
"read()" and friends.

And that's entirely ignoring the fact that something like "read()"
basically *has* to be a system call, because there are no alternatives
(ok, mmap, but that's actually much slower, unless you're in it for
the reuse-and/or-sparse-use situation).

With random numbers, you have tons of other alternatives, including
just hardware giving you the random numbers almost for free and you
just using your own rng in user space entirely.

And yes, some users might want to do things like periodic re-seeding,
but we actually do have fast ways to check for periodic events in user
space, ranging from entirely non-kernel things like rdtsc to actual
vdso's for gettimeofday().

So when you say that this isn't about micro-optimizations, I really
say "humbug". It's *clearly* about micro-optimization of an area that
very few people care about, since the alternative is just our existing
"getrandom()" that is not at all horribly slow.

Let me guess: the people you talked to who were excited about this are
mainly just library people?

And they are excited about this not because they actually need the
random numbers themselves, but because they just don't want to do the
work. They want to get nice benchmark numbers, and push the onus of
complexity onto somebody else?

Because the people who actually *use* the random numbers and are *so*
performance-critical about them already have their own per-thread
buffers or what-not, and need to have them anyway because they write
real applications that possibly work on other systems than Linux, but
that *definitely* work on enterprise systems that won't even have this
kind of new support for another several years even if we implemented
it today.

In fact, they probably are people inside of cloud vendors that are
still running 4.x kernels on a large portion of their machines.

          Linus
