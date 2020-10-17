Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAAA291016
	for <lists+linux-api@lfdr.de>; Sat, 17 Oct 2020 08:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437082AbgJQGV3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Oct 2020 02:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437079AbgJQGV2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Oct 2020 02:21:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C448DC061755
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 23:21:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c21so5049886ljn.13
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5fP2IedoKQlRQouSCWpsDIMKmWivfsQ9eQLA1F2LGk=;
        b=LMmylegyEXB4ETZFcAg0jZ3ywuK/RWOoyd8IF2q7wbf0FlBPa1CmGDbEXkW+jghAbm
         L/ZDBTeW0W+eYkvJeGow+VVh0xMTCd2CjHybf0Yd0FJf6PC7WL4xF2qG5wrVBC42yxgQ
         8zg/2jexyYshW1yQH1s+pVSH0LX9mH5ZboR6fOLWNE1KqDRC8jjvr83OZzi4/ipuIs9Q
         dFrUSBctQ7q6gHPyfMClsBZMkU9oNgNQp7tdM4fX4J+lCCSGXw7In/UD6xkyOWe4J850
         JMe5a+2COrcu8wW2/OjDhZZYR++6Jrvj9sBrMWL/JEJjmvrImBEV8RyU9R0lJv9ID5mO
         57jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5fP2IedoKQlRQouSCWpsDIMKmWivfsQ9eQLA1F2LGk=;
        b=h0o/sSe2iHIwCUcq6iq6pqT6No1kTQ+O95R281md7iGAMTVVPPO/yPGzkOpBNcS6fN
         Jh3nNogjbujKpTEBWUtVHoJdpEuli9k2ORRMiNmmqH8aBlHPaRAKn67IBoHM0qmfusCj
         bgA7ImqRXl82ze7cMUbQ+U3ootiybqGmVpci6QpUb+mvicPZoz4xSGWeYxisGyrL5aiB
         R1/GcUKntdm0fL4RSmoczwp57UzuW9V7AFj3H6cU9d5VOVj08TMija9F+/wxDefmDnRJ
         uNFZQeDgltWS8IqQ0c5DS3hVGDU/6HX7RV/WrvGZPGOkYjB+R4LjJu6x/gRfaKosje33
         eTLQ==
X-Gm-Message-State: AOAM532wHvV6qOX8OC/LafYN1wlT9itFKB+Ou8t8L9wc51SvKvQomZyG
        mIZP0uMLxaZJpgcjR2dQZpun+sgPRXyW3XYWBi7+ZA==
X-Google-Smtp-Source: ABdhPJxODCfO9ZVU11lc/q6G6VCj8F3pnGVHFozeCzeN2p8bjSk3h58nmS2HKf7Nkir5cfAE2D9bdypZ/Mc+oRT6tqk=
X-Received: by 2002:a05:651c:1205:: with SMTP id i5mr2905687lja.47.1602915685058;
 Fri, 16 Oct 2020 23:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014370305b1c55370@google.com> <202010162042.7C51549A16@keescook>
In-Reply-To: <202010162042.7C51549A16@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 17 Oct 2020 08:20:58 +0200
Message-ID: <CAG48ez1KEOHL5VCNtrsRTHa6Wj9xUY+daReb4V08O8dFzarkjw@mail.gmail.com>
Subject: Re: UBSAN: array-index-out-of-bounds in alg_bind
To:     Kees Cook <keescook@chromium.org>
Cc:     herbert@gondor.apana.org.au,
        syzbot <syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com>,
        linux-crypto@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-hardening@vger.kernel.org,
        Elena Petrova <lenaptr@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

+linux-api because this is about fixing UAPI without breaking userspace

On Sat, Oct 17, 2020 at 8:02 AM Kees Cook <keescook@chromium.org> wrote:
> On Fri, Oct 16, 2020 at 01:12:24AM -0700, syzbot wrote:
> > dashboard link: https://syzkaller.appspot.com/bug?extid=92ead4eb8e26a26d465e
> > [...]
> > Reported-by: syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com
> > [...]
> > UBSAN: array-index-out-of-bounds in crypto/af_alg.c:166:2
> > index 91 is out of range for type '__u8 [64]'
>
> This seems to be an "as intended", if very odd. false positive (the actual
> memory area is backed by the on-stack _K_SS_MAXSIZE-sized sockaddr_storage
> "address" variable in __sys_bind. But yes, af_alg's salg_name member
> size here doesn't make sense. The origin appears to be that 3f69cc60768b
> ("crypto: af_alg - Allow arbitrarily long algorithm names") intentionally
> didn't extend the kernel structure (which is actually just using the UAPI
> structure). I don't see a reason the UAPI couldn't have been extended:
> it's a sockaddr implementation, so the size is always passed in as part
> of the existing API.

If you e.g. recompiled the wrong parts of the "btcheck" project with
such changed UAPI headers, I think you'd get OOB writes, because they
have this in a header
(https://sources.debian.org/src/btcheck/2.1-4/src/kernelcryptoapi.h/?hl=29#L29):

typedef struct {
  struct sockaddr_alg sa;
  int safd;
  int fd;
} lkca_hash_ctx;

so if you rebuilt e.g. kernelcryptoapi.o (which uses the struct)
without also rebuilding hash.o (which allocates the struct), code in
kernelcryptoapi.o would write beyond the end of lkca_hash_ctx, I
think.

Sure, there aren't many places that do this kind of thing for this
struct. But at least in theory, you can't change the size of UAPI
structs because someone might be passing instances of that struct
around between object files.

> At the very least the kernel needs to switch to using a correctly-sized
> structure: I expected UBSAN_BOUNDS to be enabled globally by default at
> some point in the future (with the minimal runtime -- the
> instrumentation is tiny and catches real issues).

Yeah, the kernel should probably use a struct that looks different
from the userspace one. :/ I guess we'll probably end up with some
ugly hack with "#ifdef __KERNEL__", where the same struct has
different sizes between kernel and userspace? Or am I being too
puritan about UAPI consistency?

> Reproduction:
>
> struct sockaddr_alg sa = {
>     .salg_family = AF_ALG,
>     .salg_type = "skcipher",
>     .salg_name = "cbc(aes)"
> };
> fd = socket(AF_ALG, SOCK_SEQPACKET, 0);
> bind(fd, (void *)&sa, sizeof(sa));
>
> Replace "sizeof(sa)" with x where 64<x<=128.

I think you mean 88<x<=128 ?
