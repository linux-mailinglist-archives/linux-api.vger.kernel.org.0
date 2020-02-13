Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9116715B61F
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 01:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgBMAse (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 19:48:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34759 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbgBMAse (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 19:48:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so4562613ljc.1
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 16:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqI0VbPVaJfcsCTXac52W5YMJCYaSOj7FaTDjIsxYoQ=;
        b=RRc0XamveMQXj/q8pfpDyw3+6RSQiI77zx4rXZCf1ovpx19fhSLX9IAuu7EAbdT6D5
         hRgPzQzTBFhOQsMCJ5pC8fUtChqlceueXHqMOFdtZldjIC/GLh+J70scUbbfpK2vng/u
         uee+XaR52NHzT1hMiW+QFymxjV6nraNw8Kd1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqI0VbPVaJfcsCTXac52W5YMJCYaSOj7FaTDjIsxYoQ=;
        b=hT6vU6M/c8R3DVUfyqUZOP8MdhRmzuxlbGKyesVIu7NAMCHWC1UaVMCByF2mKvcPdH
         TgC1kayWER1FRY32Zf12EsEll3FvMgZ7UCRx3tWSfZ25du7oBhGt1UWMZfnnjqTk+puX
         fLng5V2C0R4s4FLqTgbzQdEC6de4LcgkvgOvhvjRvKIUkG2T0ezRYreCtyFhrOzjAUpw
         wCFXxITYzsn0wCRnP9X4Dkui4xPRjVyENXQRl4z3phHH/83UgEB81eUI4zhGm19Dstxx
         AY5rc+8grdU4WsuxRvIULyhkr7HPN8Bf8MunRZJsr1hldU/XW1//0wcL+o7jrRETDipq
         nnBw==
X-Gm-Message-State: APjAAAXIXL/89ls7+Ir4O2Kp1xtsAWXfgF3RC7XdTLAysmJvzKo2CURl
        N1P6yTckBejtfXgHprA7ZmNq1n6/P6c=
X-Google-Smtp-Source: APXvYqxO8nLpqcPpoyL/u0MEH5z9zoLVyhQUD2WOXm+yswn48P+JTQ09C23w2l3j1PmVap0xwhlvyA==
X-Received: by 2002:a2e:9d3:: with SMTP id 202mr9527089ljj.60.1581554911809;
        Wed, 12 Feb 2020 16:48:31 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w9sm337877ljh.106.2020.02.12.16.48.31
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 16:48:31 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id r19so4560875ljg.3
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 16:48:31 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr9459753ljb.150.1581554910763;
 Wed, 12 Feb 2020 16:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com> <87lfp7h422.fsf@x220.int.ebiederm.org>
In-Reply-To: <87lfp7h422.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 16:48:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
Message-ID: <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 12, 2020 at 1:48 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The good news is proc_flush_task isn't exactly called from process exit.
> proc_flush_task is called during zombie clean up. AKA release_task.

Yeah, that at least avoids some of the nasty locking while dying debug problems.

But the one I was more worried about was actually the lock contention
issue with lots of processes. The lock is basically a single global
lock in many situations - yes, it's technically per-ns, but in a lot
of cases you really only have one namespace anyway.

And we've had problems with global locks in this area before, notably
the one you call out:

> Further after proc_flush_task does it's thing the code goes
> and does "write_lock_irq(&task_list_lock);"

Yeah, so it's not introducing a new issue, but it is potentially
making something we already know is bad even worse.

> What would be downside of having a mutex for a list of proc superblocks?
> A mutex that is taken for both reading and writing the list.

That's what the original patch actually was, and I was hoping we could
avoid that thing.

An rwsem would be possibly better, since most cases by far are likely
about reading.

And yes, I'm very aware of the task_list_lock, but it's literally why
I don't want to make a new one.

I'm _hoping_ we can some day come up with something better than task_list_lock.

            Linus
