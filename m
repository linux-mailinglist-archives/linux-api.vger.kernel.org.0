Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F222BAC8
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 21:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfE0Tgp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 15:36:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33905 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfE0Tgp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 May 2019 15:36:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id u64so12583212oib.1
        for <linux-api@vger.kernel.org>; Mon, 27 May 2019 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wOkTICbGGgSQKfMenc3seaDZ/KLgjroUdiof+HnQ4s=;
        b=KyX4N9fqFU6gT9OH1da4ukXI54+PtAJWkozfkY5dUnyUl5SliiI+ox0dC1m6ecKZkq
         2cbeynpQeQdlLyOhc4lLQPmNFVaaUFHrjJECflBdQMk+kPLdR9ZOcMMFL5uRCwKatFeb
         tTuV1ATMZeoqPCVAxo0v7AvtjchgMA3H3KoZ4cGjCUSRYRZjRouCFPSdlCdiIYGaTkEL
         N707cRBDzsjTd7MxleiRRg27FLy+pSktaDy092UqsDWvyOv01ZFtZ6aDYKcck3lXKsWQ
         QYJk7Y8LfRDDa0Fx6Qylo9I0yvrAkm4kgPWIZUqvAg63Tjkxf/jCRM8G82NSuPvj6fkE
         hHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wOkTICbGGgSQKfMenc3seaDZ/KLgjroUdiof+HnQ4s=;
        b=lsYYI5Q8BFw3zGibOry7X3sUlGTxOarsTzakalIP4vndsr7etw6N/fKXTd8AFYCIph
         cpAFxzWnfj7AoolCZBYVyTnwcr4eDt7CMYvxNQ/ri6fNa3xY7RykFNiNOQtiNq7LuYEe
         8CjiHTDqiA8fE2Q9Pk07Ic8wvNgqP1LMWaGT0uMJicnCaY7f4zex9SMyBvu2msvzoS8l
         pUsqwE+KP7pBgo/EIKDDI58gCTkVcevmw5vBE/52tSCTg6dwtW9Q/squUWaxT1k6McTo
         CcDzxLGMXIkrRG/15lSx/zoLrg85DIqQU3DTEWHS3h02YGB8Bde+gukM94TybjDwkvZK
         DydA==
X-Gm-Message-State: APjAAAX9JVIagEHYqVFZ1K1y2CTiB5D/1oDE7/Ggirw4YaDeILcGSi3V
        x04ebkHDubLjWWFfa8wdRlaOsKeJzB73bw7zOQcQGA==
X-Google-Smtp-Source: APXvYqzjis5QKOqN7UmcaChzDsoUV0+dmtf01xdFNdjoZUGPORQ++uXNnITdfqBZARKJxYLU5wQK2Caza/hcN5eqwcc=
X-Received: by 2002:aca:c48c:: with SMTP id u134mr364457oif.39.1558985804503;
 Mon, 27 May 2019 12:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io> <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
 <20190527104239.fbnjzfyxa4y4acpf@brauner.io> <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
In-Reply-To: <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 May 2019 21:36:18 +0200
Message-ID: <CAG48ez2wyDhM-V1hs5ya1R4x7wHT=T8XLOYCPUyw97kzzLhbhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fork: add clone6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
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

+Kees

On Mon, May 27, 2019 at 9:27 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, May 27, 2019 at 3:42 AM Christian Brauner <christian@brauner.io> wrote:
> > Hm, still pondering whether having one unsigned int argument passed
> > through registers that captures all the flags from the old clone() would
> > be a good idea.
>
> That sounds like a reasonable thing to do.
>
> Maybe we could continue to call the old flags CLONE_XYZ and continue
> to pass them in as "flags" argument, and then we have CLONE_EXT_XYZ
> flags for a new 64-bit flag field that comes in through memory in the
> new clone_args thing?

With the current seccomp model, that would have the unfortunate effect
of making it impossible to filter out new clone flags - which would
likely mean that people who want to sandbox their code would not use
the new clone() because they don't want their sandboxed code to be
able to create time namespaces and whatever other new fancy things
clone() might support in the future. This is why I convinced Christian
to pass flags in registers for the first patch version.

The alternative I see would be to somehow extend seccomp to support
argument structures that are passed in memory - that would probably
require quite a bit of new plumbing though, both in the kernel and in
userspace code that configures seccomp filters.
