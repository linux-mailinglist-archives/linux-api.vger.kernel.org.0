Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE538D1D7
	for <lists+linux-api@lfdr.de>; Sat, 22 May 2021 01:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEUXKq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 19:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhEUXKp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 19:10:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E87C061574
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 16:09:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id t17so9094210ljd.9
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivV9cO1o2PX6t4Pw12dQrdCGDuzxlRZOxgnejFB4bGg=;
        b=UdiMBJJhEbB2K86+/mRVdi+atu++SD5EtKcvT0y1JCrslXYoGw34g1FWXNIxx7soMs
         sVmitcwirGloMhdjITiYBMUfTYn7MhfdhmDgdlMT18hsHvIutKnWVqlthua++lclnbQa
         ji0tSrRw3b2AV80x/49YLUuMv9QtDMuRWX0M7jSD/bHgUPiUqzQuuz0SAlCaA2k0Fifq
         l/fQ9uQddgiVSDea0s5PemPvWEno2xWuFNemUD560TVKD5RS3eiTQeioqTB3vQzoKzIA
         /jOfsIdHTNGG7bZM54P3cYfsV5sxpLv/nT9rUol+KH5H0GfBujgWmg8iHXy8jORLBiIo
         C5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivV9cO1o2PX6t4Pw12dQrdCGDuzxlRZOxgnejFB4bGg=;
        b=TY7kPfz1RFwHCo1hGTOeQaRHjh7PzfcLu/8Fuhyduf1dftrvYD+6FOctl3gCUUuG6K
         jJGXOaTB2EArAysP+WFXQYAnK1mr1PiSlxFOjEjN0YDLbX2Uw2Sjz2dqC2A8fmtwcyST
         ziLd7cJiWWKV24IwCi8Ie0p32oSeARB6KDmnghOaXnyrwjwrcQ1KUS4vgTRZ8OWoch2c
         NdmGo1PexZCumNIOlj/GSLv5oA3QKVvZVHSCkkcAGJ+mm+dPSaqNCLfr7v07HXcEKOad
         oLpbDNds+LRzF4pSF/iXKU6zdDriUFRA5Qc9MNtELOgoNanKcrTUqEb9lBXNtm2izYGK
         sW/g==
X-Gm-Message-State: AOAM533DAjcots7loNpDAL6lL6Nqj7dK5dVZkmA3/HqVx84wrQvMkNlv
        j3TiPA++SRJxj856QNMu8RemiTP21ElJ4Nz5QmCAzA==
X-Google-Smtp-Source: ABdhPJzcNJb4+i7O8eWJPN/a2ZPIHjwA07BotV+Uu/x2eiWHCOSLXO2U+lOXAdV6ni9BYsIktKDZyvsBeR2bzBKivZg=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr8740489ljo.94.1621638559632;
 Fri, 21 May 2021 16:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <CAEWA0a72SvpcuN4ov=98T3uWtExPCr7BQePOgjkqD1ofWKEASw@mail.gmail.com>
 <CAPNVh5d54HNYqVSGG==ozA7YjGdmkisg2M+wsYmdgGx2-p3Oog@mail.gmail.com>
In-Reply-To: <CAPNVh5d54HNYqVSGG==ozA7YjGdmkisg2M+wsYmdgGx2-p3Oog@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 22 May 2021 01:08:53 +0200
Message-ID: <CAG48ez19esMTd4XFMqOk-XsEQOPHRJUYd0O-qiyDZv=aEHYnmg@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
To:     Peter Oskolkov <posk@google.com>
Cc:     Andrei Vagin <avagin@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21, 2021 at 9:14 PM Peter Oskolkov <posk@google.com> wrote:
> On Fri, May 21, 2021 at 11:44 AM Andrei Vagin <avagin@google.com> wrote:
> > On Thu, May 20, 2021 at 11:36 AM Peter Oskolkov <posk@google.com> wrote:
> >>
> >> As indicated earlier in the FUTEX_SWAP patchset:
> >>
> >> https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/
> >
> >
> > Hi Peter,
> >
> > Do you have benchmark results? How fast is it compared with futex_swap and the google switchto?
>
> Hi Andrei,
>
> I did not run benchmarks on the same machine/kernel, but umcg_swap
> between "core" tasks (your use case for gVisor) should be somewhat
> faster than futex_swap, as there is no reading from the userspace and
> no futex hash lookup/dequeue ops;

The futex code currently creates and destroys hash table elements on
wait/wake, which does involve locking, but you could probably avoid
that if you built a faster futex variant optimized for the
single-waiter case that uses a bit more kernel memory to keep a
persistent hash table element (with RCU freeing) per pre-registered
lock address around? Whether that'd be significantly faster, I don't
know.


(As a sidenote, the futex code could slow down if the number of futex
buckets isn't well-calibrated - meaning you have something like >200
distinct futex addresses per CPU core, see futex_init(). Then
futex_init() probably needs to be tuned a bit. Actually, on my work
laptop, this is what I see right now (not counting multiple waiters on
the same address in the same process, since they intentionally occupy
the same bucket):

# for tasks_dir in /proc/*/task; do cat $tasks_dir/*/syscall | grep
'^202 ' | cut -d' ' -f2 | sort | uniq; done | wc -l
1193
# cat /sys/devices/system/cpu/possible
0-3
# gdb -core=/proc/kcore -ex "print ((unsigned long *)(0x$(grep
__futex_data /proc/kallsyms | cut -d' ' -f1)))[1]" -batch
[...]
$1 = 1024

So the load factor of the futex hash table on this machine right now
is ~117%, which I think is quite a bit higher than you'd normally want
in a hash table? I don't know how representative that is though. Seems
to mostly come from the tons of Chrome processes.)
