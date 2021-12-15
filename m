Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044FF475179
	for <lists+linux-api@lfdr.de>; Wed, 15 Dec 2021 04:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbhLODqi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Dec 2021 22:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239610AbhLODqh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Dec 2021 22:46:37 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258EEC06173E
        for <linux-api@vger.kernel.org>; Tue, 14 Dec 2021 19:46:37 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id e27so13841508vkd.4
        for <linux-api@vger.kernel.org>; Tue, 14 Dec 2021 19:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TekgYXvLI9+PhAB10t1a5FqyPcohZFo1S/h5MUzllc=;
        b=BFsYMu+UZJj1SArv/r1ASXkdEhkDV6ze8dTrFKXh3BqRPxE59I75lLftewi2N6Gdp/
         hVHKuBSEEOKvlfo92eHsingxtFZVif9P2kEl6cecf9Wk9hgAZt3SwH61VWQ5b7m3J709
         IoSEdRybiuRcZB9Tc8r+YKx7thHVGC2NJjigGfuhZ8jYYnD9Hpweg6EIeb/5PtEUWuvu
         kyEP1L9s9nZcncRMdGj7SPlQOUtLRYUv61wDX+vOEyJAa1M6B4sbg9XU/AZqbfSyq23I
         d6/QxcitDHYWCTs0pWw+Zuc6i5WaCwCgQSyJJ8IwrdQmpo/1vzgd4eMJBefEbUP2/lW2
         GgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TekgYXvLI9+PhAB10t1a5FqyPcohZFo1S/h5MUzllc=;
        b=jVU7eV7qS07uqzDBHoBK783mlSfHf7YZbo8vDvMKhhaCY2NgvJ/SdhO0Lpooqjn9rU
         peLaGM2klnqJE6dlvE4vMzrk4XnVVUVA6viHjRB9H+Ajh79+j1+j9KdfrzR5oL5e24e1
         798CMUYUMJswHGudbqbbK1SMsbo58u94yAkxT4CphKRsaleg3E7T97dPaJk4+OQTHNmJ
         DLt3btqWNSp6boPTDR5TIkkkATPLydw/ExizWfcgTZUiy8Apb5s+cCsuB9fbhC7c7FnA
         RnRM7cBv/x6dHaomNs4eBtT53N4MSiUpFKVmeaEd8HDi58o8aJHONglkoBYjj7cktS+x
         sCLg==
X-Gm-Message-State: AOAM532x9RFTr0End65IBinudC2yqBI1RC9qOgUeu00ZVmA+LzWr2S60
        BqsrqG5Ta+1Lf0i0LCuTLkxMZolAivlbMc50HhGJcg==
X-Google-Smtp-Source: ABdhPJwT1P/z+guQQbhBVQaBckIuopJw6LK6HpQeJEPxLY8JvjeQl8Z+vJL49XKvD80YtUUcd36/oxeIFPPgqM4AECg=
X-Received: by 2002:a05:6122:221c:: with SMTP id bb28mr2417373vkb.27.1639539996199;
 Tue, 14 Dec 2021 19:46:36 -0800 (PST)
MIME-Version: 1.0
References: <20211214204445.665580974@infradead.org>
In-Reply-To: <20211214204445.665580974@infradead.org>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 14 Dec 2021 19:46:25 -0800
Message-ID: <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, x86@kernel.org,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Dec 14, 2021 at 12:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi,
>
> This is actually tested code; but still missing the SMP wake-to-idle machinery.
> I still need to think about that.

Thanks, Peter!

At a first glance, your main patch does not look much smaller than
mine, and I thought the whole point of re-doing it was to throw away
extra features and make things smaller/simpler...

Anyway, I'll test your patchset over the next week or so and let you
know if anything really needed is missing (other than waking an idle
server if there is one on a worker wakeup; this piece is definitely
needed).

>
> I'll post my test-hack as a reply, but basically it does co-operative and
> preemptive UP-like user scheduling.
>
> Patches go on top of tip/master as they rely on the .fixup removal
> recently merged in tip/x86/core.
>
> Also, I still need to audit a bunch of mm code, because I'm not sure things are
> actually as well behaved as this code supposes they are.
>
