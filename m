Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDCB3C1ADA
	for <lists+linux-api@lfdr.de>; Thu,  8 Jul 2021 23:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhGHVPS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Jul 2021 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhGHVPS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Jul 2021 17:15:18 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C1EC06175F
        for <linux-api@vger.kernel.org>; Thu,  8 Jul 2021 14:12:36 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id h5so4388682vsg.12
        for <linux-api@vger.kernel.org>; Thu, 08 Jul 2021 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1NHfW9F+V78jjSXkJMUixUMtEy56ReUIzgPfUrq2/k=;
        b=kX91r1j3b1eond5H8vs2cxeIPsnS3WnX4y41EibTl/bRNtJ+cvF05DPNYodSGN7rVl
         a4wPQTrKiR0MODFixrsSBlfMIf9MmbyDgxPUkorZQBy5HR3F3b2E7XOSoSym+94bTRjk
         sp+86F24xZ60jEwDZ/CaNsVK6Ns53eFJ3w8GLuwCUYQkI0RVU2aCtR/wmIgfnpqFuedD
         iw9HyEyxAS086IPLo39bzeS5KBMHgyHlFRTEX1GbVXHR4A9ivJRrh0RqyuP+4UaEq4sg
         /KQM1RWfaf1/ba2uau1H0GTT0lKQgSrVrFOAmBV+GQ1vMRLuX5tfgSxX+hZMobqlmPWF
         SArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1NHfW9F+V78jjSXkJMUixUMtEy56ReUIzgPfUrq2/k=;
        b=jYsruI8T+hxvux/dATLUA3FlTOJgTH6EqYP8jMdSjjGKtS/6spGm6Dvq8sp37IniHd
         SRYWTz4ybYxs6ACYk5XYh3MX0LjoYQyTfGGpi49ksOBJulMnUVYM/rQx7L4MY89bPpd4
         pTeOR0H6gy5pu7lSebMp5+h0pzUOgT6t3Sfpa4UFWirZfN9q5Z5Hk7Ssb6kmG2ST/n3K
         poSxLWHSnNqz51H4kulIg75ut53YIE2B86EJv3TfaDivSqwv/7rvQMushGMK7p0X/oV2
         PfL8kuf+xzrtmbQSoWSjOVr4V+KVpT1T+ubx31KSeruccLTRcPdaHYlKHuJKEQXb2IQV
         WtJA==
X-Gm-Message-State: AOAM531dj2ymCum5kffm76Ip6N2XF+VLTyTVqDWrR0yYJapKckToLg0b
        cAoLmIJHHQeFlj/D3PAYQnqnfc6bMbd9ojELQxUkOQ==
X-Google-Smtp-Source: ABdhPJzjcQRpPyO+uiq9mWg8ubZa2vCyJpTZozBlll1pHMwAWuxcR59BDzuLnrWh4uOPYGHV+z02Je619Y5mcf82ISM=
X-Received: by 2002:a67:d998:: with SMTP id u24mr30784838vsj.16.1625778754878;
 Thu, 08 Jul 2021 14:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210708194638.128950-1-posk@google.com> <20210708194638.128950-3-posk@google.com>
In-Reply-To: <20210708194638.128950-3-posk@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 8 Jul 2021 23:12:08 +0200
Message-ID: <CAG48ez3LxrPva9Kxtn1DVhJWxhn3hvJ5oeDwXcrEeK_UvGh0UA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3 v0.2] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 8, 2021 at 9:46 PM Peter Oskolkov <posk@posk.io> wrote:
> Add helper functions to work atomically with userspace 32/64 bit values -
> there are some .*futex.* named helpers, but they are not exactly
> what is needed for UMCG; I haven't found what else I could use, so I
> rolled these.
>
> At the moment only X86_64 is supported.
>
> Note: the helpers should probably go into arch/ somewhere; I have
> them in kernel/sched/umcg.h temporarily for convenience. Please
> let me know where I should put them and how to name them.

Instead of open-coding spinlocks in userspace memory like this (which
some of the reviewers will probably dislike because it will have
issues around priority inversion and such), I wonder whether you could
use an actual futex as your underlying locking primitive?

The most straightforward way to do that would probably be to make the
head structure in userspace look roughly like this?

struct umcg_head {
  u64 head_ptr;
  u32 lock;
};

and then from kernel code, you could build a fastpath that directly
calls cmpxchg_futex_value_locked() and build a fallback based on
do_futex(), or something like that.

There is precedent for using futex from inside the kernel to
communicate with userspace: See mm_release(), which calls do_futex()
with FUTEX_WAKE for the clear_child_tid feature.
