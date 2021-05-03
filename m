Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DAB3720FE
	for <lists+linux-api@lfdr.de>; Mon,  3 May 2021 21:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhECTyq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 May 2021 15:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhECTyp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 May 2021 15:54:45 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB213C06138B
        for <linux-api@vger.kernel.org>; Mon,  3 May 2021 12:53:51 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id j75so805716oih.10
        for <linux-api@vger.kernel.org>; Mon, 03 May 2021 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sL1cfgAwusROayggatCngmy+CDfZipZ8K0S97Q3yq6Q=;
        b=CRqyGcRJzr2t7Pmj7oHIyJjjFWQLWJae/kCMd4aaJk17BYeX/DnQGhh392/1rXNiCq
         3+jnOVqKRj2FR+odqa11vu4G+JXB5kSnuoZBhV7IBiWr0MfVSCa9PeXqfPYsewvLvZ6G
         hSOTPzHmojo+8IKA9lYSVlvLKLijZk64DYfy+EjSjuL7laMXS2e2DCbw8j4ZOWq4V/Po
         scljdkDPvwGCxWGA53xZTE2JNExwx17RQiuIJZ18Ul/Vjc3NODdA26x7hYe5rY0GGZsq
         Lur3c5i20XfFU1Y82iznEq14q1DPrpnU/is5Sptlk2NDIxe5jFuPZkwSn8SY7z2JnNLN
         TDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sL1cfgAwusROayggatCngmy+CDfZipZ8K0S97Q3yq6Q=;
        b=J8AY0HdL86Bq/H47xsBKO2lPaJfvjWYB4RsO6S7yznB2a14z9qoyxACDePxOs6tBJU
         UnW99yMPb7HIfxkEXZ+w4gUmeaegbK5icQ+f4IpmwsrwxRGzJw8J3hDEQL4UYzgcjyOf
         4VWfBmeZRSpHuvlj0/KkoC9uIG2V64KYD2JdK0tU21Se1ZEuDKguJCfp2P0Xz8CBFxgh
         8AAUSTt9lRNZ0SEG5/SbcLarDQ+fQ6zEqw0+gLa8mC0CW6bJPhw0K4UTVj/B6ALfpB99
         6VLjn0gUtQ9MNEzYLgGaJQZVVk/koP0f3v1t5Ogp3TarcpAOQhI0fCPm2qVgsRVDbBx0
         M/lQ==
X-Gm-Message-State: AOAM530gbtv6gK69jbgkl2cPX4oG+BtqOFfhNdBhnbg3OZ5biElIL1r3
        wN/qYqDE001PlLgdyuCCEq8JCVANDcO2UUgkOyuWqQ==
X-Google-Smtp-Source: ABdhPJxWqJOXiH/95U6rrLRMIPGQFk6oJv1bO9Wxu4NNmUUeQHEBRT3D3+oQLsWrAa5qP9iF+z00FCubwSjXwRKUQxQ=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr14657198oif.121.1620071630990;
 Mon, 03 May 2021 12:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m11rarqqx2.fsf_-_@fess.ebiederm.org>
 <CANpmjNNJ_MnNyD4R2+9i24E=9xPHKnwTh6zwWtBYkuAq1Xo6-w@mail.gmail.com>
 <m1wnshm14b.fsf@fess.ebiederm.org> <YI/wJSwQitisM8Xf@hirez.programming.kicks-ass.net>
 <m1sg33ip4w.fsf@fess.ebiederm.org>
In-Reply-To: <m1sg33ip4w.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 3 May 2021 21:53:39 +0200
Message-ID: <CANpmjNNyvOFyEDLPKuGn-pjFTMfLCOBHOQrMocLVpdEG47Ge3A@mail.gmail.com>
Subject: Re: [PATCH 7/3] signal: Deliver all of the perf_data in si_perf
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 3 May 2021 at 21:38, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
>
> > On Sun, May 02, 2021 at 01:39:16PM -0500, Eric W. Biederman wrote:
> >
> >> The one thing that this doesn't do is give you a 64bit field
> >> on 32bit architectures.
> >>
> >> On 32bit builds the layout is:
> >>
> >>      int si_signo;
> >>      int si_errno;
> >>      int si_code;
> >>      void __user *_addr;
> >>
> >> So I believe if the first 3 fields were moved into the _sifields union
> >> si_perf could define a 64bit field as it's first member and it would not
> >> break anything else.
> >>
> >> Given that the data field is 64bit that seems desirable.
> >
> > The data field is fundamentally an address, it is internally a u64
> > because the perf ring buffer has u64 alignment and it saves on compat
> > crap etc.
> >
> > So for the 32bit/compat case the high bits will always be 0 and
> > truncating into an unsigned long is fine.
>
> I see why it is fine to truncate the data field into an unsigned long.
>
> Other than technical difficulties in extending siginfo_t is there any
> reason not to define data as a __u64?

No -- like I pointed at earlier, si_perf used to be __u64, but we
can't because of the siginfo_t limitation. What we have now is fine,
and not worth dwelling over given siginfo limitations.

Thanks,
-- Marco
