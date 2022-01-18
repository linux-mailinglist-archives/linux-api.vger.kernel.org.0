Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21251492C1E
	for <lists+linux-api@lfdr.de>; Tue, 18 Jan 2022 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347127AbiARRRN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Jan 2022 12:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347010AbiARRRM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Jan 2022 12:17:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69508C06161C
        for <linux-api@vger.kernel.org>; Tue, 18 Jan 2022 09:17:12 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p18so29240458wmg.4
        for <linux-api@vger.kernel.org>; Tue, 18 Jan 2022 09:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjMQTF4eVKdyYAu8QrW4WjNPRTGXRpV0NBTS0oqE87o=;
        b=IZegMCoeQ3hsBGjk2vtSpm5HrT9deisVQ46CZM3W0KeCwtTnRXltsYEkFkK7yN3kmr
         FrxakSA4UABJoLpQ2vt1aupCGgjVZR/yetgF6KbYS+Wb1MvUDzzsBcLjGToUAv8yfWEN
         CtzNojQhJGGDxowfq4eZc6l3xtJmf2RhRdZky817UJYEa0IVe1hVWqPQ9jAmSvChBYiK
         CmJJe8g75QHXaKLXux+guYXIgee20K9ncaKL5KcgmzKX38rvjaK5D51MMxkhre0mhd9s
         halEpN+LKuSFqaBxYoxeF0T5KxSnAJXxWpNJO2ZMOb9zLt75zrGVSwmJWj3VVF7IVUMo
         uy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjMQTF4eVKdyYAu8QrW4WjNPRTGXRpV0NBTS0oqE87o=;
        b=JAD5byEZwYjI0QToM+y5ibkTfdOMs8nmoCw7S/sZG0Z3MgLcoxsFNfYWe3n2tqw1wx
         Srl95GNtZ2f0TstbiqXxX0FVQtnckESPbfZeg11O6gGTkbqg6OMUafUKHtjRaufUaUha
         PJ34XrGO6rpyD0HwtwB4meyOEDujSexbZ6LNDW3XjK3QuTfu6BnnZtSUdv+tpCSToBA+
         uX8Q9S0uWh50vs/9aBeR6Ol10XahGX41WhrBI9KEVcQ4Q9zGRy/54rJHgpcJyRviRHXq
         3JI9FJCB0g8Rz28hiP4/uFp21G4QNu7LgHIPBgvaeVSV8ZZPLUshF5+ON7kkt5XNKqbM
         Sp6A==
X-Gm-Message-State: AOAM530YSHKgNQKwa8Kja3OdsyJc92MI8WI1WfdVpSzgwTB9O5YHMDsA
        rlsFySASiiCxtzzFuC40fO8mm5pLolOhClNHj1+XQg==
X-Google-Smtp-Source: ABdhPJyM8Er7F8IWCUjoxB2zTsyLWrUtQFdcfszUUYmE5GJpHJTzU5uLC3uRD7QV0QTnKuyA/uRJk761VISSAS7dA7Q=
X-Received: by 2002:a5d:6da4:: with SMTP id u4mr20828497wrs.82.1642526230826;
 Tue, 18 Jan 2022 09:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20220113233940.3608440-1-posk@google.com> <20220113233940.3608440-5-posk@google.com>
 <YeU0nr6DfBCaH6UF@hirez.programming.kicks-ass.net>
In-Reply-To: <YeU0nr6DfBCaH6UF@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 18 Jan 2022 09:16:59 -0800
Message-ID: <CAPNVh5e+ijBCdvzZujWNUw7QnFt5Mdonw35ByuvcvzJu7gGjHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] sched: UMCG: add a blocked worker list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 17, 2022 at 1:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 13, 2022 at 03:39:39PM -0800, Peter Oskolkov wrote:

[...]

> >
> > So this change basically decouples block/wake detection from
> > M:N threading in the sense that the number of servers is now
> > does not have to be M or N, but is more driven by the scalability
> > needs of the userspace application.
>
> So I don't object to having this blocking list, we had that early on in
> the discussions.
>
> *However*, combined with WF_CURRENT_CPU this 1:N userspace model doesn't
> really make sense, also combined with Proxy-Exec (if we ever get that
> sorted) it will fundamentally not work.
>
> More consideration is needed I think...

I was not very clear here. The intent of this change is not to make
1:N a good general approach, but to make "several running workers per
single server" a viable option.

My guess, based on some numbers/benchmarks from another project, is
that having a single server/runqueue per four or eight running
workers, properly aligned with (= affined to) an AMD chiplet, will be
the most performant solution, comparing to both a runqueue per single
running worker and to a global runqueue. On Intel this will probably
look like a single runqueue per core (2 running workers/HT threads).

So in this model a "server" represents a runqueue.

I'll reply to other active umcg discussions shortly.
