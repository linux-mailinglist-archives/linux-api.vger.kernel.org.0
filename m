Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551C769245E
	for <lists+linux-api@lfdr.de>; Fri, 10 Feb 2023 18:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjBJRYR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Feb 2023 12:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjBJRYQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Feb 2023 12:24:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90316305D4
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 09:24:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso4572593wms.4
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 09:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jK4GcD8hacKVWz6zl8bBrz233whrxcoTUY/2ygZZfmc=;
        b=M2jDhbmblGLdfowPWsAysOenXMHJGfjKF4XBxa3qOAJbzKq8BVW5Bi70WAjt5O9fGN
         qp+ANsnVyXQKsU16qsl+FTAEnXVOzh8BC6x36hX/4beu9BTYwt7CqPuJFw/mHj4k+UR8
         H8YDYi8jHuZgdrghm16rzRYLYR86rDIbo1cgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jK4GcD8hacKVWz6zl8bBrz233whrxcoTUY/2ygZZfmc=;
        b=C+nAKD4JiqBMf9mcjt6XJIxNf/ajo71e/vJVeemQ3eGEw+dQXFJ/icbz6bWfJ9sEC5
         Q5vf6UTEelR5GrCBIPqcS/X+G7qwn53eBcJ8NDhyYhvPUTa9/38d/Hsb1m97jvasoj4N
         VXPpzupABsnwf2kbE4vugdyjazmya2WH5i+zb24ydC3K6qexpaMmbJUyDIGl8linrELC
         UXILEWdqGKMw5LkGYEyeskQfHtV9RutzmydmjKW4UMINTLv2zT3zm1JfyyiT0yzn1GrJ
         LXkVwF1Ti6f4IW6xhT6FUHi40lHrnlC9qH3+v44SiIGZlBacWaciJYfEvOECux1w19oO
         Xi1w==
X-Gm-Message-State: AO0yUKWbrhpNsmBPjzqBkKxycl3LgivE0P1YayRt30MzvOHfbZ2NIm6C
        9wrrQw4xduhIPHzLwKHS9nVR9YeXA5PmulVzSow=
X-Google-Smtp-Source: AK7set910Zey0q/vOdvtJzZOkcCdh6C68zvlqvXc7AuUbE22Yk5vymJaAl4OIIGA5XhMKLhkQSFLWQ==
X-Received: by 2002:a05:600c:713:b0:3df:ea09:fcc9 with SMTP id i19-20020a05600c071300b003dfea09fcc9mr2584221wmn.7.1676049852886;
        Fri, 10 Feb 2023 09:24:12 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id e1-20020a05600c4e4100b003dc49e0132asm9022188wmq.1.2023.02.10.09.24.12
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 09:24:12 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id dr8so17660116ejc.12
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 09:24:12 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr3050972ejw.78.1676049852037; Fri, 10 Feb
 2023 09:24:12 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <CAHk-=wip9xx367bfCV8xaF9Oaw4DZ6edF9Ojv10XoxJ-iUBwhA@mail.gmail.com> <20230210061953.GC2825702@dread.disaster.area>
In-Reply-To: <20230210061953.GC2825702@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 09:23:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj6jd0JWtxO0JvjYUgKfnGEj4BzPVOfY+4_=-0iiGh0tw@mail.gmail.com>
Message-ID: <CAHk-=wj6jd0JWtxO0JvjYUgKfnGEj4BzPVOfY+4_=-0iiGh0tw@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Dave Chinner <david@fromorbit.com>
Cc:     Stefan Metzmacher <metze@samba.org>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
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

On Thu, Feb 9, 2023 at 10:19 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Splice has two sides - a source where we splice to the transport
> pipe, then a destination where we splice pages from the transport
> pipe. For better or worse, time in the transport pipe is unbounded,
> but that does not mean the srouce or destination have unbound
> processing times.

Well, they are possibly fairly unbounded too - think things like
network packet re-send timeouts etc.

So the data lifetime - even just on just one side - can _easily_ be
"multiple seconds" even when things are normal, and if you have actual
network connectivity issues we are easily talking minutes.

So I don't think a scheme based on locking works even for just the
"one side" operations - at least in the general case.

That said, I wasn't really serious about my "retry" model either.
Maybe it could be made to work, but it sounds messy.

And when it comes to networking, in general things like TCP checksums
etc should be ok even with data that isn't stable.  When doing things
by hand, networking should always use the "copy-and-checksum"
functions that do the checksum while copying (so even if the source
data changes, the checksum is going to be the checksum for the data
that was copied).

And in many (most?) smarter network cards, the card itself does the
checksum, again on the data as it is transferred from memory.

So it's not like "networking needs a stable source" is some really
_fundamental_ requirement for things like that to work.

But it may well be that we have situations where some network driver
does the checksumming separately from then copying the data.

               Linus
