Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA99381062
	for <lists+linux-api@lfdr.de>; Fri, 14 May 2021 21:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhENTVy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 May 2021 15:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhENTVx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 May 2021 15:21:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095C5C061574
        for <linux-api@vger.kernel.org>; Fri, 14 May 2021 12:20:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c15so24557862ljr.7
        for <linux-api@vger.kernel.org>; Fri, 14 May 2021 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHGE/SI1tO0CAdU9DspiMRu/IcggidAjeljmucgj+1U=;
        b=FHhNFP0HjOwmcUgJGOwZ/2fTGf6YloAj1IJt9cgCeCY5gct1ms0aePvfJ+p26Am9aT
         BgrkbekSovaMhMO5v4pdqS8eAlzBpMJLm9klgoPAMR35d4hkcz4CXmBtjJs+Fzkwi9i+
         rg2vQHNDh6q1olgYalhfdAxn+xT9pYxV7ONgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHGE/SI1tO0CAdU9DspiMRu/IcggidAjeljmucgj+1U=;
        b=N4u27pNeK7e90eRGkvncDdKB8BV0Zw/ALrUEcPAzub4fMxu3CxM49GbkC55Hz6cnCI
         qgxnX7f/ZjVb8h0Fv2jF1uEsIWC/rl97LbzhPNbZ/U8Znar7+TPJFlN4iGfT2cZkeeFr
         YyyH4a8l91jXIIeNHJj5Rb/zH0f726Fez5tp3FixKD+n62O9LaSFVsbScGA4zUMLq6SF
         64+zsiaKVmK6KA7ZBI2HOtS8AidE1fGw5HafFr8uq23iAMHXZOYA6UOG92t1u311Trcu
         z1ZzEP9JAhXKtAiQ6TD/EE5GwBmS14kCTsao2gKvuAXJU2jjEU7GJUh79HJQ4cQPUALT
         E2vg==
X-Gm-Message-State: AOAM5311yq+ZygjGbFGqqa+iZ29/0QK6ozufsTn7IykWA90Ot65zc22Y
        NhkPkW4UQ9TzfNO6XOsgaFTfl7+wHdx3SKbXW5Q=
X-Google-Smtp-Source: ABdhPJylTqJDbDIc3fGiaCmn8TkLhPDRsYRLYdPcmy9zwPX3JzPgKGakOwiFaWgJx0wNfbJBc68o2Q==
X-Received: by 2002:a2e:8011:: with SMTP id j17mr35800275ljg.106.1621020039199;
        Fri, 14 May 2021 12:20:39 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id k25sm1323013lji.61.2021.05.14.12.20.38
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 12:20:39 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id h4so44579136lfv.0
        for <linux-api@vger.kernel.org>; Fri, 14 May 2021 12:20:38 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr38227020lji.465.1621019658636;
 Fri, 14 May 2021 12:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org> <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org> <m1tuni8ano.fsf_-_@fess.ebiederm.org> <m1a6oxewym.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1a6oxewym.fsf_-_@fess.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 12:14:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikDD+gCUECg9NZAVSV6W_FUdyZFHzK4isfrwES_+sH-w@mail.gmail.com>
Message-ID: <CAHk-=wikDD+gCUECg9NZAVSV6W_FUdyZFHzK4isfrwES_+sH-w@mail.gmail.com>
Subject: Re: [GIT PULL] siginfo: ABI fixes for v5.13-rc2
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 13, 2021 at 9:55 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please pull the for-v5.13-rc2 branch from the git tree:

I really don't like this tree.

The immediate cause for "no" is the silly

 #if IS_ENABLED(CONFIG_SPARC)

and

 #if IS_ENABLED(CONFIG_ALPHA)

code in kernel/signal.c. It has absolutely zero business being there,
when those architectures have a perfectly fine arch/*/kernel/signal.c
file where that code would make much more sense *WITHOUT* any odd
preprocessor games.

But there are other oddities too, like the new

    send_sig_fault_trapno(SIGFPE, si_code, (void __user *) regs->pc,
0, current);

in the alpha code, which fundamentally seems bogus: using
send_sig_fault_trapno() with a '0' for trapno seems entirely
incorrect, since the *ONLY* point of that function is to set si_trapno
to something non-zero.

So it would seem that a plain send_sig_fault() without that 0 would be
the right thing to do.

This also mixes in a lot of other stuff than just the fixes. Which
would have been ok during the merge window, but I'm definitely not
happy about it now.

             Linus
