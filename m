Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD21309E7
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaIO6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 04:14:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39751 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaIO6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 04:14:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so10347514qta.6;
        Fri, 31 May 2019 01:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qz9y4gFluxzPwJy3KPISqVXROmvinNnPW5jrOuJybTo=;
        b=Tm5ewF/wi6xIdUKsIkZdEGqPXXKlR882rY6T5MTG1DHJVvlwP0o9cTJDqcudqGhlFR
         fKEhX4v13F7muxAOKwHJKK9rrnB+4+jOyD/RXIU5YIiJ3XobZdyvS0xV+3+H/Mz6lSr5
         ZEaQ3i9oBK3LkpMPoFdWKmLffTKbEkw3C2QMl830DwWBw+OXg/x8GemOkZOZlRFU8UVK
         SVFeBG9fKp86GgLhwcdBOUuy5mAo1yIt1X5rwxOE4Ml7eL0xnR19fKNv8Xz7I7bDaZZ5
         4ALrZJCEN/QuwPzm+wMySnzAOZcjyVECdT0fb8vnfluWr4h7DFB4u6wqt769i+QQXMeO
         1xdA==
X-Gm-Message-State: APjAAAW+gdazBPq7iQyBbQXa4/1xblRqpHKbCZvUgga3ZaSUnWTT9S8O
        EntfxlkNp/gu7n5VOP6yhgXgm/0T55o1W9Fx814=
X-Google-Smtp-Source: APXvYqw6R6nQclsyVadJZQRr3GlWli/1GXaaSeZb7dxTTe/GAXqX/9X+vcmpy0O5aG8/euC5SLkSQaGiK9/5s8DtIcc=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr2760555qtf.204.1559290496946;
 Fri, 31 May 2019 01:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190529152237.10719-1-christian@brauner.io> <20190530132012.GS16415@port70.net>
In-Reply-To: <20190530132012.GS16415@port70.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 10:14:40 +0200
Message-ID: <CAK8P3a1zAk1qAkpmevO-AS6zxKdJneDe0ADouhZLW5SEUqoTuw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fork: add clone3
To:     Szabolcs Nagy <nsz@port70.net>
Cc:     Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 30, 2019 at 3:20 PM Szabolcs Nagy <nsz@port70.net> wrote:
> * Christian Brauner <christian@brauner.io> [2019-05-29 17:22:36 +0200]:

> > /* uapi */
> > struct clone_args {
> >         __aligned_u64 flags;
> >         __aligned_u64 pidfd;
> >         __aligned_u64 parent_tidptr;
> >         __aligned_u64 child_tidptr;
> >         __aligned_u64 stack;
> >         __aligned_u64 stack_size;
> >         __aligned_u64 tls;
> > };
>
> is this new linux syscall api style to pass pointers as u64?

This is common for ioctls passing structures now. I don't think
we've had many system calls with structures containing pointers,
but the idea is the same, i.e. we want structures to be identical
on 32-bit and 64-bit architectures.

> i think it will look a bit ugly in userspace where cast
> to u64 would signextend pointers on most 32bit targets, so
> user code would have to do something like
>
> arg.ptr = (uint64_t)(uintptr_t)ptr;
>
> such ugliness can be hidden by the libc with a different
> struct definition, but it will require bigendian and alignment
> hackery (or translation in libc, but that does not really work
> when user calls raw syscall).

Right. Note also that user space should do zero-extension
of the variables in order for the kernel to not care about
what called it. Just leaving padding fields in the structure
is not enough here.

User space that calls the raw syscall certainly has to
go through the uintptr_t cast, but I would also expect that
applications don't normally do that, and instead call a
library function that has regular C calling conventions
with individual arguments instead of a structure.

      Arnd
