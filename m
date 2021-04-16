Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4877C36258E
	for <lists+linux-api@lfdr.de>; Fri, 16 Apr 2021 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDPQVF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Apr 2021 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDPQUv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Apr 2021 12:20:51 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4C4C061574
        for <linux-api@vger.kernel.org>; Fri, 16 Apr 2021 09:20:24 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y10so1686472ilv.0
        for <linux-api@vger.kernel.org>; Fri, 16 Apr 2021 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhuo2ce7pEsFd+kWMkBzZgqO2R7b3NnKTCwVUUXvoQw=;
        b=GtTfUk0gMN3laeFMw9A0MclH1hnTnlOPku7sIH5pQH0GsiLF3h0Qpvf+rdsAdYvp8U
         r4yakBREBILVxvsFr1aWzRGZJdIQNGwssOYXq7pcdxYvIuekz4HP9oIlQULAdrCeRIRB
         N6LKPZ7ZixCmCtSYYoLYHrMuQW9q49K734t1yJ8j1nIhQjMqJ/u2WMFH9/gDeggjbDwq
         9W6p/k7FI6yOIsMChARxhmW/4HkE1w8a3o3tuM7dMInoC3+go2e32yJf4uSmegNBJlG3
         qfgbhB7Q5YfTz6/DX1W4UXmK72OHNQ59kLhQAwd3DDQkA92qvwEtX9wjALKs+BXP75Dn
         4p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhuo2ce7pEsFd+kWMkBzZgqO2R7b3NnKTCwVUUXvoQw=;
        b=dXsY06xdLv/u5g2jqy6dnEGVOPiI4CjC9Gcl6fzgFXDLgwQiPwZpzG/kWcOLU1G6yu
         N+66Q58LgNVbXpCWqjBrzWSIwtp5oEFQX2Y3LM49/+q/rIqomsKAfksT5JhRtzFE5HpX
         ZwaJAnAXh8wGjMjPHJxLWAL4gWnTTdbwkOTo3Z8L5KSSH/gIE2L5/Hft6FJGbrvzYmC3
         C3LaaPMVmbKoa0b1HLtlRDZgcziX4Vvm5Z6uPg1e/n9J50IwB+qMnqNPQuFRCb/pFY24
         BpFssc+1f6Q6zHUQHS4VCrDsGxEVnCyKXOot+mSJpnqzxbki2aunyiEZoRFF1WK/pxad
         3RKg==
X-Gm-Message-State: AOAM5313BKxwjN21JVkVO/P9BxrDVz4zgjEryz6Or5JjrZIs7JvSHbwZ
        wjC66ylF/E/KMNzvdOskXZK/6JnRmmBuDA1JubPAOg==
X-Google-Smtp-Source: ABdhPJzxxsYx/Qhtk7Zi7pGWCVoX+DqX+oHS2t2EvbUwqFo+JT5kC3hbQfUwYL+RX5V8qG/x4hUlqc2+rOIkEL9s0UE=
X-Received: by 2002:a05:6e02:1145:: with SMTP id o5mr7295502ill.61.1618590024064;
 Fri, 16 Apr 2021 09:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <13d725cb8e741950fb9d6e64b2cd9bd54ff7c3f9.1616123271.git.pcc@google.com>
 <161839488327.21932.16461913261970131291.b4-ty@arm.com>
In-Reply-To: <161839488327.21932.16461913261970131291.b4-ty@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 16 Apr 2021 09:20:12 -0700
Message-ID: <CAMn1gO7-DnGdhP6gO61ZR6o-jq5ymMOYuCdEeLu+xH7kFrvaTw@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] arm64: mte: make the per-task SCTLR_EL1 field
 usable elsewhere
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kostya Serebryany <kcc@google.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Evgenii Stepanov <eugenis@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        libc-alpha@sourceware.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 14, 2021 at 3:10 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, 18 Mar 2021 20:10:52 -0700, Peter Collingbourne wrote:
> > In an upcoming change we are going to introduce per-task SCTLR_EL1
> > bits for PAC. Move the existing per-task SCTLR_EL1 field out of the
> > MTE-specific code so that we will be able to use it from both the
> > PAC and MTE code paths and make the task switching code more efficient.
>
> Applied to arm64 (for-next/pac-set-get-enabled-keys).
>
> Peter, can you please have a look and give it a try as part of the arm64
> for-next/core branch? I rebased your patches on top of the
> for-next/mte-async-kernel-mode branch as this was adding more code to
> mte_thread_switch(), so I kept the function for now.
>
> Thanks.
>
> [1/3] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
>       https://git.kernel.org/arm64/c/2f79d2fc391e
> [2/3] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
>       https://git.kernel.org/arm64/c/201698626fbc
> [3/3] arm64: pac: Optimize kernel entry/exit key installation code paths
>       https://git.kernel.org/arm64/c/b90e483938ce

Hi Catalin,

I tested the rebased patch series on an Apple M1 under a hypervisor
with my Android forward-edge PAC prototype and it seems to work.

I think it should be possible to get rid of at least one of the ISBs
that are now on the task switch path, but let's leave that to a later
patch. The patch series looks good otherwise.

Peter
