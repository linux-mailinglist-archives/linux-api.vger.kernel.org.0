Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F158B3C287D
	for <lists+linux-api@lfdr.de>; Fri,  9 Jul 2021 19:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGIRgt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Jul 2021 13:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhGIRgs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Jul 2021 13:36:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041CCC0613E5
        for <linux-api@vger.kernel.org>; Fri,  9 Jul 2021 10:34:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so14992005lfl.2
        for <linux-api@vger.kernel.org>; Fri, 09 Jul 2021 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYHFQPZLMEZqJ5hoI56H8A3fDpGmOgQX0Jz5WMfwiWY=;
        b=W/zWC4Uhdto5kBEizw4YBkrg0EYQj8KKI2lB6O9bojXsuvT888jzqk/MmYTrBm6Smy
         GAxVJIa3crAtxNn66uKO8beFjglkKWRQAcclEE+D1U9UXqctCl+rKXOhtGQgcubdVDPH
         VDBfZz3V2/VIeRGhbMOosvw60emXnrzx02KXPAtq26PzkR1shra/pjYpAy/l5ySbZ8ih
         S/nVptznFp1nFA4kvRr1kkX9qnCHkXJ5rVBKfRbdFDRnSakD4UWl6/9vC8scRSrY7Tk4
         3Q72ddTDSz1nySlUtfoiAhdCymF6HLjrsePot7JI1PEkywuEQnWWyZfQrPbQPkj08Xpt
         R4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYHFQPZLMEZqJ5hoI56H8A3fDpGmOgQX0Jz5WMfwiWY=;
        b=NS870k+P2DwVd5UbAbQW9fb0dO0JCA04tCGNwKtj+hvBJxq77k8M68t+5Vvn5IHwEg
         AGRDwuj+hpyp9Su8eGWVRs+YSwM+5EelX0pbY1wlIT/IB4OUC9OdZhEG/WxkrtmNKBTe
         KLzNdtajPOOpMqqpWD7EdHRXv2MBMdFuHjJ5vaaP5OGAzVFi94+kSHa18KFfu88AbCEi
         gHDnRz0crC6WCjLUDUzwe431DdyFoHclkk1ac5p6rLlLFBa0ZW43YvaA5jSKqe4Yzyjd
         xMkcg9eThOQeho40xFSihMCNJbjRgk8GPMMah31KCoAHI8Nfp/lCcEs2NQQRgz9CbwCf
         7iuw==
X-Gm-Message-State: AOAM533yKSxO46Vq5q4fI+ZptdDm4N7uC2/c+C9rLBIKLsoHTonBw74o
        dvcET08LVHp3Oh1ZRV7JANSDjaP/u32lrTchai4KVg==
X-Google-Smtp-Source: ABdhPJzP6naunX8J0C4EFDKw+dy+AIM/fEQHxoM7x/G+DjK6ZsPHVXMyrwI7uam6dftT85wEarkKysGWACdTccnSCZM=
X-Received: by 2002:a19:c508:: with SMTP id w8mr29468321lfe.446.1625852043036;
 Fri, 09 Jul 2021 10:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210708194638.128950-1-posk@google.com> <20210708194638.128950-3-posk@google.com>
 <YOgCdMWE9OXvqczk@hirez.programming.kicks-ass.net> <CAPNVh5fbDTNPCnSoQFia_VSuDcLsReGey+7iouK6V=p1S7v=sg@mail.gmail.com>
In-Reply-To: <CAPNVh5fbDTNPCnSoQFia_VSuDcLsReGey+7iouK6V=p1S7v=sg@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 9 Jul 2021 10:33:51 -0700
Message-ID: <CAPNVh5fH49Ehh2xNqcEVgK46KTWV6xz9BMw40BW-rzj=-Y2YLA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3 v0.2] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 9, 2021 at 9:57 AM Peter Oskolkov <posk@google.com> wrote:
>
> On Fri, Jul 9, 2021 at 1:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
[...]

> > What's wrong with the trivial lockless single
> > linked list approach?.
>
> I'm not sure how to get around the ABA problem with a lockless single
> linked list: https://en.wikipedia.org/wiki/ABA_problem
>
> Our semantics can probably be relied on to prevent ABA from happening
> with idle workers (popped/removed by the userspace), but idle servers
> can trivially have it:
>
> (initial state): head => Server A => Server B => NULL
>
> task1 :
> - read head (get A), read A (get B), {/* delayed */}
>
> tasks 2-3-4:
> - pop A, pop B, push A
>
> task 1:
> - cmp_xchg(head, A /* old */, B /* new */) - succeeds, now B is in the
> list erroneously

I think the kernel can just mark "popped" servers as such (by setting
the lowest bit of its "next" pointer to one) without actually removing
them from the list, and letting the userspace do the cleanup/GC. With
hard-limiting the max length of idle servers at 2*NUM_CPUs or similar,
this may work out OK. I'll work on this approach. Please have a look
at patch 3. :)

>
> >
> > On top of that, you really want to avoid all that endless stac/clac
> > nonsense and only have that once, at the outer edges of things.
> >
> > Something like the *completely* untested below (except it needs lots of
> > extra gunk to support compilers without asm-goto-output, and more widths
> > and ...
>
> I'll try the approach you suggest below once it is clear how to deal
> with the ABA issue (and the wake server issue raised in patch 3).
>

[...]
