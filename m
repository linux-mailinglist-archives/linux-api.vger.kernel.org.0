Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486CE37047D
	for <lists+linux-api@lfdr.de>; Sat,  1 May 2021 02:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhEAAiZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Apr 2021 20:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhEAAiY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Apr 2021 20:38:24 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF9EC06138C
        for <linux-api@vger.kernel.org>; Fri, 30 Apr 2021 17:37:34 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u16so54463896oiu.7
        for <linux-api@vger.kernel.org>; Fri, 30 Apr 2021 17:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYQeAScJs1TpMXononV3fp1ygIDD0T/s8VaH8jvt3Xw=;
        b=BePQGXKejT78YB+1Qc5q1LCPNsGstYOV9R088g5QlShgvjvM6ixO0lzCO87W+2TSwp
         znK2jDTneTfQHKD5uXShgkoJJolm6Bz5N/EpZXuPhYTS6BFF5IkfvoX18p4FHyHQvY4+
         hXJbJoQq26tEPkPvjcG2/98QNh45edHmhZWqhkxCTc7VTF2opNFtY1Z0MIXNPxlaHsjB
         ZMeloEw7ihZti5Zsu/oJYJLe0bQkNbe20ExgjOelN6ADUadC/pM+rBBH/kZzZq3ZkcwK
         nnnsu4CBGHT3agel86Jlryxeenvqys1N+5c46cXHYT0kybVbeCNf+vY4SGwCaTNp6m1H
         fBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYQeAScJs1TpMXononV3fp1ygIDD0T/s8VaH8jvt3Xw=;
        b=UslrHI4DnUBZbA6ptRchsaZjOvzuFc/jVJ5dNtEiIkPNuqlcP/k4fVnRkJsj41P8Bv
         j87jNFGOJrPrIhI7ue69lcbwoKYtL1uDkN0IxPm0lIi+OPd0xG3j92mSoZHaOp+blkkb
         Bbvcop5QtdoGE3UlD3oJLEVJCmVY6i0/u4OAj7OA5jFsXH0JpR8Ty0KlIYtIOyD0pgGt
         qb0ZtH+SVUlsYNIJh4DgulE6FuY0Lc7qqMYUsoDmHnsewvvL/Ty9KysEYoEvZczzZBbj
         iIll2elfWu5mdmNYuXcsGjWwf9tw0jpOxH9Up6G8Zj6intWcZ3/f2slzpO6pF4xtFMR6
         UIPQ==
X-Gm-Message-State: AOAM530977SwTC153GEUqCnyGgE/rD7Cj6jFJcTE3VTumtv1BKq4Emdl
        BWDCVouOWUbHVeiJBfY8Yv5f8OKLWuyQITrsGCd6Ug==
X-Google-Smtp-Source: ABdhPJxIo+BVTYzvdhNqfbqRCIwfel9igFlw7u9W4kJYtv5n3JP2YhvgynpMjQkCwdk9y9SzRO6wrc/4VyE8xKAg5N0=
X-Received: by 2002:aca:408a:: with SMTP id n132mr6087597oia.70.1619829453704;
 Fri, 30 Apr 2021 17:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
In-Reply-To: <m1r1irpc5v.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 02:37:22 +0200
Message-ID: <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
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

On Sat, 1 May 2021 at 01:48, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Well with 7 patches instead of 3 that was a little more than I thought
> I was going to send.
>
> However that does demonstrate what I am thinking, and I think most of
> the changes are reasonable at this point.
>
> I am very curious how synchronous this all is, because if this code
> is truly synchronous updating signalfd to handle this class of signal
> doesn't really make sense.
>
> If the code is not synchronous using force_sig is questionable.
>
> Eric W. Biederman (7):
>       siginfo: Move si_trapno inside the union inside _si_fault
>       signal: Implement SIL_FAULT_TRAPNO
>       signal: Use dedicated helpers to send signals with si_trapno set
>       signal: Remove __ARCH_SI_TRAPNO
>       signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
>       signal: Factor force_sig_perf out of perf_sigtrap
>       signal: Deliver all of the perf_data in si_perf

Thank you for doing this so quickly -- it looks much cleaner. I'll
have a more detailed look next week and also run some tests myself.

At a first glance, you've broken our tests in
tools/testing/selftests/perf_events/ -- needs a
s/si_perf/si_perf.data/, s/si_errno/si_perf.type/

Thanks!

-- Marco
