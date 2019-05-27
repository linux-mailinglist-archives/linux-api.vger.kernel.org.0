Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828452BA53
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 20:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfE0Ssf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 14:48:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44964 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfE0Ssf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 May 2019 14:48:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id e13so15408792ljl.11
        for <linux-api@vger.kernel.org>; Mon, 27 May 2019 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0M9+CuFDRY6zmkTMsFyEFGMzc2pk/FXTc+geD/xhgG8=;
        b=IDb/hbyQgY21nuV2LBO2TNOaRE38NoV5Q4XHoHqiTOvqshvusynIuDSsYkw9iF2nFD
         P22g7ZqLtG4bPc/b2ghLW9uSs/wM+jeoVRHpYQ6vVG+QMJM/0QapWZU445OWqOUdACPp
         nxGsQsTufyxMtNW4p9qkFejvax39+NRHIkUz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0M9+CuFDRY6zmkTMsFyEFGMzc2pk/FXTc+geD/xhgG8=;
        b=luPVFT+Z9Yee18r+pISzW1KrxX7to2QRpkM5fTTKbuSpYdcP07IRsEgU7jDgNPP0P+
         pWhKtEeYJvGqy3TiZ6oktWANRTQajYN7z4710dNDAYO8+J/uCCNPiMLW6q23KYZlkEpK
         tlEzwtH4LOThrEcArxooCJHBz72eeNXtLgvnW+FJsHA77O0/fzHe4PGNnNjsA1DpXxua
         8aesyl3gkfqa3auq5xFEiHf4EiLAjcSl4i+nQF29YRWjLoXTE7tmEbekNsdMGyvge3Ov
         eRtT6UASVUkQqK+fWfb0zCuxsatrYDQb5sELyMtdkW/AYUjULtKgD9/MwxticO9nlyLd
         DvxQ==
X-Gm-Message-State: APjAAAUkdAk+SA1MG593k3CuoUlpQN8dtcLkXHLKkVuwR/gymZ8kLCy/
        LcEw5nVvBMmH9sqxKsrb/47ohKgz4I8=
X-Google-Smtp-Source: APXvYqypU72h/kA0EEEN0OS3v7BtD7AdANk08bFP+Z4wgd6espEOEKBpv2+wKbGwqbnhGBCoNYrdKQ==
X-Received: by 2002:a2e:9c09:: with SMTP id s9mr34135738lji.74.1558982912506;
        Mon, 27 May 2019 11:48:32 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c17sm862197lfi.93.2019.05.27.11.48.29
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 11:48:30 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id r15so3262627lfm.11
        for <linux-api@vger.kernel.org>; Mon, 27 May 2019 11:48:29 -0700 (PDT)
X-Received: by 2002:a19:ae01:: with SMTP id f1mr21133934lfc.29.1558982909294;
 Mon, 27 May 2019 11:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io> <20190526102612.6970-2-christian@brauner.io>
 <CAK8P3a1Ltsna_rtKxhMU7X0t=UOXDA75tKpph6s=OZ4itJe7VQ@mail.gmail.com>
 <20190527104528.cao7wamuj4vduh3u@brauner.io> <CAK8P3a3q=5Ca0xoMp+kyCvOqNDRzDTgu28f+U8J-buMVcZcVaw@mail.gmail.com>
 <20190527123414.rv2r6g6de6y3ay6w@brauner.io>
In-Reply-To: <20190527123414.rv2r6g6de6y3ay6w@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 May 2019 11:48:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgixXANa=2U0AeKud9zk9XvaV4mVRNNpkOWKpy+uuvtsg@mail.gmail.com>
Message-ID: <CAHk-=wgixXANa=2U0AeKud9zk9XvaV4mVRNNpkOWKpy+uuvtsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: wire-up clone6() syscall on x86
To:     Christian Brauner <christian@brauner.io>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 27, 2019 at 5:34 AM Christian Brauner <christian@brauner.io> wrote:
>
> Afaict, stack_size is *only* used on ia64:

That's because ia64 "stacks" are an odd non-stack thing (like so much
of the architecture).

In computer science, a stack is a FIFO that grows/shrinks according to
use. In practical implementations, it also has a direction, but the
"size" is basically not relevant if you just allow it to grow
dynamically. The key word here being "dynamically": the stack size is
inherently a dynamic thing.

So you don't really need a "stack size". The whole concept doesn't
make sense, outside of the obvious maximum limit things (ie
RLIMIT_STACK) and simply just hitting other allocations.

But ia64 is "special".

The ia64 stack isn't actually a stack. It's *two* stacks, growing in
opposite directions. One for the hardware spilling of the register
state and call frame ("backing store"), and one for the traditional
software stack.

So on ia64, the stack size suddenly becomes a fixed thing, because
it's not a dynamically growing single stack that grows in one
direction, it's literally a fixed virtual area that has two different
stacks growing towards each other.

Btw, don't get me wrong. Two stacks can be a good thing, and a lot of
security people want to have two stacks - one for actual call frame
data, and a separate one for automatic stack variables that have their
address taken.

Having separate stacks avoids the whole traditional stack smash model
(well, it avoids the one that overwrites the return frame - you can
still possibly have security issues because one function smashes the
automatic stack of a caller and then cause the caller to be confused
and do something insecure).

And the ia64 double stack kind of works that way automatically. So
"double stack" very much isn't wrong per se, but doing it the way ia64
did was too inflexible and the register stack (and rotation) was and
is just a bad idea.

Two stacks without the hw register renaming and flushing can be
lovely, and can even merit some hw support (ie the whole "Shadow
stack" model).

              Linus
