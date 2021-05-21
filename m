Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4438CE35
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 21:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbhEUTdn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 15:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236879AbhEUTdn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 21 May 2021 15:33:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CB6760FE7
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 19:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621625540;
        bh=jOeW49R3D0Xy2MYiigIe+4z2oWaYZOxfJxbogqAUeQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c4BD7AloCgBm56PmefVxQyf6soTh2DAU9qMfGz868gWnF23EP949zWfAt+Ew0BPHT
         u+Q2kWlyzJzd4aNbZ8du2ydCEiEf2rnY0+KlhGr7D35l+6mu0AunSThHZy99ysTIvF
         4mTPdmPZqhYii2P9ZUMp+wIyxk+qTpZG3my61++UCIiZ8u5xi76m5UUS8M5zOn+h0m
         3/8zDdUP28Xt954AM3ykTM9Q6glnGF1ZV92noMzq3GXkBn0mJACYRA5Dyj3Z8rWw8R
         E4GoarrvP1tSnuDElnKALoIRlfJSg4xbbvmFM7DVxDXAU/EOnKyDDNMXvwXYzPFeXY
         sMjbOf1fl7gFg==
Received: by mail-ed1-f42.google.com with SMTP id g7so12363349edm.4
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 12:32:19 -0700 (PDT)
X-Gm-Message-State: AOAM5329mvdI1uAqENSg6B8k4jMVD9N9xSQmaGVP65SUz/UNfZ/Bqj1w
        sbayrM8d7AQsDv9CC35buW4ueIUPvPKbMyKuIaJpyw==
X-Google-Smtp-Source: ABdhPJymY0D4EZweyfuHuPn+GXWKUbV4mm81DjwQWS/Fppjj/RBVIj5orTVVxZwikuPCXSbDsXn6I/3H3h0L+EV3D7M=
X-Received: by 2002:a05:6402:4313:: with SMTP id m19mr12643717edc.263.1621625538643;
 Fri, 21 May 2021 12:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <20210520183614.1227046-5-posk@google.com>
In-Reply-To: <20210520183614.1227046-5-posk@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 21 May 2021 12:32:07 -0700
X-Gmail-Original-Message-ID: <CALCETrXo=5r+i6f3qvSp4mEHcR93U3F0S0kFr8d5JGU6WetSqw@mail.gmail.com>
Message-ID: <CALCETrXo=5r+i6f3qvSp4mEHcR93U3F0S0kFr8d5JGU6WetSqw@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 4/9] sched/umcg: implement core UMCG API
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 11:36 AM Peter Oskolkov <posk@google.com> wrote:
>
> Implement version 1 of core UMCG API (wait/wake/swap).
>
> As has been outlined in
> https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/,
> efficient and synchronous on-CPU context switching is key
> to enabling two broad use cases: in-process M:N userspace scheduling
> and fast X-process RPCs for security wrappers.
>
> High-level design considerations/approaches used:
> - wait & wake can race with each other;
> - offload as much work as possible to libumcg in tools/lib/umcg,
>   specifically:
>   - most state changes, e.g. RUNNABLE <=> RUNNING, are done in
>     the userspace (libumcg);
>   - retries are offloaded to the userspace.

Do you have some perf numbers as to how long a UMCG context switch
takes compared to a normal one?

--Andy
