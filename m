Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC963707D8
	for <lists+linux-api@lfdr.de>; Sat,  1 May 2021 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhEAQZ2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 1 May 2021 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhEAQZ1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 1 May 2021 12:25:27 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F456C06138D
        for <linux-api@vger.kernel.org>; Sat,  1 May 2021 09:24:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so1260841otf.12
        for <linux-api@vger.kernel.org>; Sat, 01 May 2021 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CyRw8Tn64/8GQf/qvRpik9Jpd4CoRgx2tUKy0Z4v2kk=;
        b=eF/f5QKwpZj4P0iRgwV9mG08ATE6TtljmgOwFiZt6YvZXdccsD5UWUHr3XvSwu//qG
         NPJJumNb1Zr68wu1wpu1k66hY/gXorsicuXcYJFtGZGJhTD3zkyGC1NlFeVevEyC1VJY
         CRmSkGTGR/sM1sCwBRfLDIx4qq1Z1WbZpsa+rKG3t/LR2XoiQJovPWIT4VkR5fc/nAs8
         4wn6Tzmc2CG2whHqu1l7tRE+chGrFt3lXNXaaWepgbANGpj6o05TW6iLrAseEa03Iw23
         5lXhasqa0NDzEaj1UbE6BGTHoKHGohYMhVnJdcWhiNjg0tp9CJUZrIoy5Teb9U/6Cem1
         5g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyRw8Tn64/8GQf/qvRpik9Jpd4CoRgx2tUKy0Z4v2kk=;
        b=deYgRzGWrK/AhQ4whAcMgVyKz8ViG5asLbqzG1v8mAobqutKWtNgR1ZqRtb1hkW9/a
         Lj2jKDeiip/nkjObtBcdT5y3sqSPe6QsH7LVQM3bFyoREUEIQPPo+48Vq1BT2n0/3Gmq
         BtiKllfouNbKwjHsYuLe8VUN1Q73vpJMEdC/0mEYaQVes+aGzc5LCaWcJ7o35QrJNbqW
         laFbnlTXRuKtUFMLIu9FTpjKzcH9/n8EBDKjhupIgr1O56W4UN0jD6OXHlJr2+ELN66y
         hLSDYrvoxtiBulpcJeN+cT4QCkKV8ZcnfiCYAS4AsuZkiaV3Dn2H1FIRgRwa2zoaX3vN
         IZEw==
X-Gm-Message-State: AOAM532l4n9ExZdC5sVugEsIbyrNKJ4o9RXfmwc1AAXAODe21ql0XzC2
        pZ+QE0A+lksBieCtzfnZznf5zPx6K/72ErYFXumLLQ==
X-Google-Smtp-Source: ABdhPJxP2xABVwsxq8iuIy2TqPxCCxagtYWhXnnuGIb0YzWKLQ9rVYtpLctNHuotNan+7uHcpM+rhlw76MQT8E/rFJ8=
X-Received: by 2002:a9d:60c8:: with SMTP id b8mr8272179otk.17.1619886275343;
 Sat, 01 May 2021 09:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com> <m1czuapjpx.fsf@fess.ebiederm.org>
In-Reply-To: <m1czuapjpx.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 18:24:24 +0200
Message-ID: <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] signal: Move si_trapno into the _si_fault union
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Sat, 1 May 2021 at 17:17, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > On Sat, 1 May 2021 at 01:48, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Well with 7 patches instead of 3 that was a little more than I thought
> >> I was going to send.
> >>
> >> However that does demonstrate what I am thinking, and I think most of
> >> the changes are reasonable at this point.
> >>
> >> I am very curious how synchronous this all is, because if this code
> >> is truly synchronous updating signalfd to handle this class of signal
> >> doesn't really make sense.
> >>
> >> If the code is not synchronous using force_sig is questionable.
> >>
> >> Eric W. Biederman (7):
> >>       siginfo: Move si_trapno inside the union inside _si_fault
> >>       signal: Implement SIL_FAULT_TRAPNO
> >>       signal: Use dedicated helpers to send signals with si_trapno set
> >>       signal: Remove __ARCH_SI_TRAPNO
> >>       signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
> >>       signal: Factor force_sig_perf out of perf_sigtrap
> >>       signal: Deliver all of the perf_data in si_perf
> >
> > Thank you for doing this so quickly -- it looks much cleaner. I'll
> > have a more detailed look next week and also run some tests myself.
> >
> > At a first glance, you've broken our tests in
> > tools/testing/selftests/perf_events/ -- needs a
> > s/si_perf/si_perf.data/, s/si_errno/si_perf.type/
>
> Yeah.  I figured I did, but I couldn't figure out where the tests were
> and I didn't have a lot of time.  I just wanted to get this out so we
> can do as much as reasonable before the ABI starts being actively used
> by userspace and we can't change it.

No worries, and agreed. I've run tools/testing/selftests/perf_events
tests on x86-64 (native + 32-bit compat), and compile-tested x86-32,
arm64, arm (with my static asserts), m68k, and sparc64. Some trivial
breakages, note comments in other patches.

With the trivial fixes this looks good to me. I'll happily retest v2
when you send it.

Thanks,
-- Marco
