Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145B3405F3F
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 00:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbhIIWL0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Sep 2021 18:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbhIIWLX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Sep 2021 18:11:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67098C061574
        for <linux-api@vger.kernel.org>; Thu,  9 Sep 2021 15:10:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c8so6674132lfi.3
        for <linux-api@vger.kernel.org>; Thu, 09 Sep 2021 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0wi+3EaAjTlirAetzelnksxkE4SBKzh2dQ06WhITDfE=;
        b=FZjb4etGZ3GPE6MwPDx+C7u7Dozy6NrY5vjn+dOX7byAjbvApFp5MBe3v+1MW7ZDCm
         zZzsG17wPJzKzQMbauzktXuwW3EsFcewl0phgk3gihWWHwaJ7iKZJ7+SPLoB8CsOhL3j
         RtklJLzuJJ2hWJjaI7NhqcSw1HxEHAVDIhsqx4ZaE57poP5rfa9kcxCn6eswj1Obq/tr
         Js8g+x456ENf+fD7t0e/eZ95JNjilLJ1SmOhy3SN3UMzUjfOw77F56Qrpp+Fk55OmHf2
         t/5DX4yAZjcK/20vPJl4PoRL/z2hRjhxDHEMvmWgglihkIcVigfLdSOlSmRfAlIJ0trB
         p28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wi+3EaAjTlirAetzelnksxkE4SBKzh2dQ06WhITDfE=;
        b=dznv79PZ80427GNZJ3Nl9ca027SZGGQHC+WP+JOThyzJc0acjWtehX5suW/67VsvPj
         iBlmYqh8hl6kv332CQ57IMYRwTMVWu9XSHbBBevH1vpVXU3UgL4zD3B0zLG7NoqQUfk/
         m8wsmKm8GQ9iiIeNba38lQN94QieVJaipO7CljZTr5timiUdLyh2YBUJCbRCErACdssg
         65zJ4F1ljhEakPRECfaWWHwv322hA1WrLJ2ztjPaZbw1qEoN7y/2LP7FYlG9Q+zigZCy
         GZM4bDQuI0HXMAy4Ftpgqy0qBB5mQdZK2eD6F1dadgp8TDgTa5wqTWX2MmZqW8VcaaME
         lWKg==
X-Gm-Message-State: AOAM5323hkAoQijUWGXpyWH1xt/rsm2/OphDa0Pj6KqZchYfW+KYqQqf
        ghbe2q5iwV+irYR0wJx+sz3lYKLHPbrYXkGEZ0E9Dw==
X-Google-Smtp-Source: ABdhPJwbWpl8KwLW02YtE5vs8E2iNxEfy4WpQ3ZYQUd1fK19n5IYgTY13l/REJAlap3+B7TdnC6mDNw3X/+JSgVQ7/Q=
X-Received: by 2002:a05:6512:1518:: with SMTP id bq24mr1554159lfb.232.1631225411416;
 Thu, 09 Sep 2021 15:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com> <CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com>
In-Reply-To: <CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 9 Sep 2021 15:09:59 -0700
Message-ID: <CAPNVh5eF6x8e4Lp=ZDOspwrbRYNOEyjeNW4WC99jCAZyeKLGww@mail.gmail.com>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
To:     Jann Horn <jannh@google.com>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 9, 2021 at 2:21 PM Jann Horn <jannh@google.com> wrote:
>

[...]

> >
> > Option 1: as you suggest, pin pages holding struct umcg_task in sys_umcg_ctl;
>
> FWIW, there is a variant on this that might also be an option:
>
> You can create a new memory mapping from kernel code and stuff pages
> into it that were originally allocated as normal kernel pages. This is
> done in a bunch of places, e.g.:
>
> This has the advantage that it avoids pinning random pages that were
> originally allocated from ZONE_MOVABLE blocks. (Or pinning hugepages,
> or something like that.)
> The downsides are that it reduces userspace's freedom to place the
> UAPI structs wherever it wants (so userspace e.g. probably can't
> directly put the struct in thread-local storage, instead it has to
> store a pointer to the struct), and that you need to write a bunch of
> code to create the mapping and allocate slots in these pages for
> userspace threads.

Thanks again, Jann! Why do you think using custom mapping like this is
preferable to doing just kzalloc(size, GFP_USER), or maybe
alloc_page(GFP_USER)?

The documentation here
https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html
says:

"GFP_USER means that the allocated memory is not movable and it must
be directly accessible by the kernel", which sounds exactly what we
need here.

[...]
