Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144B376095
	for <lists+linux-api@lfdr.de>; Fri, 26 Jul 2019 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGZIUN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Jul 2019 04:20:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37170 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZIUN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Jul 2019 04:20:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so51783260qto.4;
        Fri, 26 Jul 2019 01:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cv6ArQ9NZhLZAsMOKTlIqB/LTTH5DVyYg5LsOGfQjYU=;
        b=MVj+FRIRoI9zs4XhrIxoP8deVDubUIWYgWGfcuNcouRf5NScbPBPwTSJyMHJ2ro7SN
         kk20AvAu/Q+d82Rnxu9KrHAbpgF9yDmyNAzr0FN7+EaZGghcsZpwuC+0dhM2T5jd0zfH
         yxX6acsm37D6VPFHqqNfvjHHEYQguHanCKrxHdbdymfaphC2ny+WA034eQeDQxKC88Ka
         F5mB5VYFgV/mzWrtiomc30ia8dl3feW7Kc3AgJvS1dHlwNctxsEfc5O4IHYe7G2Mxmjf
         6HuBu8kN6UW7UhL2WgtQBBPQE4FtozrmhhpvOW90gBGph94dLcG+Dcpb6ukplR21RFRr
         zfaQ==
X-Gm-Message-State: APjAAAWd3B0/SfgNSflcrirMtULQcuszF+oIaPEUwBlMzJKyFEwoGC3t
        XpwAIVhaCoU7qsDRcmVq3ybG36z4qq1gpQxhKTs=
X-Google-Smtp-Source: APXvYqwC/d7DdwlhsZjsFA2DzW4Dzg2mP3XfZ549/GKKmq9xixhMpU5GsrFuGdHLE4SyaOeniZRS4/cdO6goonHk738=
X-Received: by 2002:a0c:e952:: with SMTP id n18mr63764893qvo.63.1564129212169;
 Fri, 26 Jul 2019 01:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-3-christian@brauner.io>
In-Reply-To: <20190724144651.28272-3-christian@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jul 2019 10:19:55 +0200
Message-ID: <CAK8P3a0+3wqCzQv-A-QmWTtioFRGjYUvq6QiLysqi9OFs3kJsw@mail.gmail.com>
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 24, 2019 at 4:47 PM Christian Brauner <christian@brauner.io> wrote:

> +
> +static int copy_rusage_to_user_any(struct rusage *kru, struct rusage __user *ru)
> +{
> +#ifdef CONFIG_COMPAT
> +       if (in_compat_syscall())
> +               return put_compat_rusage(kru, (struct compat_rusage __user *)ru);
> +#endif
> +       return copy_to_user(ru, kru, sizeof(*kru));
> +}

I think this code needs a check for COMPAT_USE_64BIT_TIME in order
to handle x32 correctly.

It would be nice to introduce it in a separate patch, and then use it
to kill off
compat_sys_getrusage() and compat_sys_wait4(), and possibly even
compat_sys_waitid() in combination with your copy_siginfo_to_user_any().
That could be done as a cleanup patch afterwards, or as part of your series.

        Arnd
