Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A15A3E2ED9
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbhHFRZc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 13:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhHFRZc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 13:25:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6321C0613CF
        for <linux-api@vger.kernel.org>; Fri,  6 Aug 2021 10:25:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c24so16027938lfi.11
        for <linux-api@vger.kernel.org>; Fri, 06 Aug 2021 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEV2xzdFoPsyTOxL8t4/rUKDR02bQVEVN3guKtT+wRY=;
        b=STFv+5RzBr6aFH1qe0BeaS395jREDWeGc143CKC9CxIAt6DkCl51f8Q3Nvu4J8NhyS
         TiYGIfWqfI8kYjv16tWiF9bp/xD7cvjUfW+Bs1W5G+Z4ZC5B6t8LXXqUNf8JJsNHLA2k
         rNV0pEpEgtWI+P4ICAUdt3eihcvAuwK1Zd7xxFxKqdmyIn9PgL9aVm7o967H7wMYL+xV
         gA7bgHkaVLHq9+Sh8p+ppFDweRf9v3zDBvfoGpRkz91UnrSVrtyqY3brAh+RzHfxPEph
         pTmQv/HmDMWIKnUhWJcXDbnJ/0AxRxh2IcZT+NSNioEsiyD+/2/tpF2ii4Dk+ChD6nD1
         Zm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEV2xzdFoPsyTOxL8t4/rUKDR02bQVEVN3guKtT+wRY=;
        b=qzXLBXe6Ronrgz1WZdo72nzvcLfOMNxAVEpLksQJS4IluT3ir+IacDiOUwo2jExiqr
         FEW+D0pzNDZMlOz3n7+sc5dS+nkFjF+v/AB/yJsIjKdSmc7NR265AlxMW0aUnmZPzsIx
         pZEHE9IHZnGSkzju4ITe9Liqz9NYk0U+mGm3NGuZoYtsq+FXZ1lvZXdyX0zJVW6UmXyn
         3SdqjQMaFPEmhl3OKM9naXwloiZpCb5zUnTzgGzf/rbcU6dTIqxrOnb9FEmgaZWdjZK8
         9/Wl6hrqGrVq3dEiUDPgAqr5OqFAFmlfbNyQ0b+1iUsEgCY9sNYaLv3sdWR5ZIsDUmVa
         bZcg==
X-Gm-Message-State: AOAM530QT+1WuGw178XVwlx7xiRygEe8z/7q03VIAL/y2j+ITdyJhT1M
        LI0gF/scCG9omvaCfx5af1L/w116K+Pa2sqJTwom4A8lnLA=
X-Google-Smtp-Source: ABdhPJwdQMa2JrnIgVb4J+HDtNdMe0fAH9eX50oJdkzi/3lXJLp7cD3AUneoendLBZDhVCogyImaBTTE6WJrg/KTlFg=
X-Received: by 2002:ac2:46fb:: with SMTP id q27mr8012789lfo.209.1628270713989;
 Fri, 06 Aug 2021 10:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPNVh5fjcJHKJOuQP+UebpYf+GBMDkj5me1c=EzS9cpDSTbzfA@mail.gmail.com>
 <1dc64d75-da9b-272a-a9ab-7d2ae7a85764@uwaterloo.ca>
In-Reply-To: <1dc64d75-da9b-272a-a9ab-7d2ae7a85764@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 6 Aug 2021 10:25:02 -0700
Message-ID: <CAPNVh5cQG8WjRryYXhrApNmV-7ybJ7ePpjXqtS6RUdguXO4e=A@mail.gmail.com>
Subject: Re: [PATCH 3/4 v0.4] sched/umcg: add Documentation/userspace-api/umcg.rst
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     avagin@google.com, bsegall@google.com, jannh@google.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pabuhr@uwaterloo.ca, peterz@infradead.org,
        pjt@google.com, posk@posk.io, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Aug 6, 2021 at 9:52 AM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
>   > All _umcg_ state changes here happen in the userspace before
>   > sys_umcg_wait() is called. So:
>   >
>   > W1: cmpxchg W1:RUNNING => W1:IDLE
>   >  - if OK, call sys_umcg_wait()
>   >  - if failed, do something else (notes below)
>   >
>   > W2: cmpxchg W1:IDLE => W1:RUNNING
>   >  - if OK, lock itself, set W2:next_tid to W1, call sys_umcg_wait()
>   > (will not block nor spin), restore next_tid and state/unlock upon
>   > syscall return
>   >  - if failed, do something else
>
> I am talking about the case where both cmpxchg() succeed and W2 sets
> *both* UMCG_WAIT_WAKE_ONLY and UMCG_WAIT_WF_CURRENT_CPU.  More
> specifically, if things are ordered like so: (ideally use monospace font)
>
>           - w1 -                     - w2 -
>
> w1:RUNNING => w1:IDLE|L   |
> S:IDLE => S:RUNNING       |
> sys_umcg_wait():          |
>       set ~UMCG_TF_LOCKED  |
>                            |   w1:IDLE => w1:RUNNING|L
>                            |   w2:RUNNING => w2:IDLE|L
>                            |   w2:next_tid := W1.tid
>                            |   w1:RUNNING|L => w1:RUNNING
>                            |   sys_umcg_wait():
>                            |       set ~UMCG_TF_LOCKED
>                            |       do_context_switch()
>       idle_loop()          |
>
> What does ttwu() do with w1 if it has not reached idle_loop yet?

If both cmpxchg() succeeded, but W1 was never put to sleep, ttwu()
will do nothing and W1 will continue running on its initial CPU, while
W2 will continue running on its own CPU. WF_CURRENT_CPU is an advisory
flag, and in this situation it will not do anything.

>
> I am not familiar with the details of kernel context-switching, but in
> user-level threading, more specifically Cforall, this would be a problem.
> Between the call to do_context_switch() and and idle_loop(), there is a
> window where 2 CPUs run the same thread at the same time. One thread is
> performing the front side of the context switch and the other threads
> wakes up on the backside of the context switch. This behaviour invariably
> corrupts the program stack of that thread. Again, I do not know if that
> applies here. I am not exactly sure how the program stack is handled when
> inside a system call.

This is a wake, not a context switch, right? I'm not sure why you are
concerned with context switching here. And even if it were a context
switch, the kernel manages thread stacks properly, there's nothing to
worry about.

Am I missing something?
