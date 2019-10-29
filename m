Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA20E8BB0
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 16:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbfJ2PVI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 11:21:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32866 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389299AbfJ2PVI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 11:21:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id u13so10098219ote.0
        for <linux-api@vger.kernel.org>; Tue, 29 Oct 2019 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kpw6kIhG5qk5+SF1ocs8o7hmvdHB1eO67/DCJ4bRv80=;
        b=JYrOuGv/xDIu8OSupe0HmWiAxv5wEi1FCYbEN6SGbriWdCAI5idijo6yXIRBECTqhc
         vmtyxGKEG7XOo+BcLtqKLDYo6aFo/3btITf8S7qh/JsubrFaR487MDGa2/u61mXZGTIX
         4WnHc6OUZqe/4s0b1hAjVf4D6kB2fjyGr/xK1E/XTk7mefU1Sw23dv0zN+q7DARlL/no
         0D3IGwmbLnOi89eB4K4OipKyvnS18TM7a8CSYvb+68Upa3Xaimkzax2bPS9/o/2BTGYW
         kxT2p831P07PIW37IYxE2hXuRV16RvHwKWLPZPUkMdM/X+Af/QQsmb5wnC/B6a1/VRLs
         JJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kpw6kIhG5qk5+SF1ocs8o7hmvdHB1eO67/DCJ4bRv80=;
        b=EoXdio5R+EidAn8Xr/9PyZkb3mHgN0szEL7UZkXUo/Pd0hvyX8bTZe7peepAiuuhHY
         fsGtK6aTfaNTJ/WF7wvvV8xbC2HeqG/A1jGI1NdbzvKKszoMfnH7JZhCbW7hixe47PgG
         5arZiXK5mok0YbinygUw4ienqgPjldhytoIyCNTcRUloufAwEayMQ9qdpoFkhtE+P3m+
         bJBCukVHAGySmGJhT2L3LOR3NcYt9EVvVKVJQYf+J5dVhAhmq8Zpz85ZfU8cLmCew6P3
         ndbcLSlK4HLX0WlJZ4v25139Cyyb1QH/KspAOPcVBK0jCIp2XfmGL/fbhhMFuYwrNfuT
         iq2A==
X-Gm-Message-State: APjAAAVG5VZqKwk3cjBrNikYHIEuBsAfyhk7qciAXWN883+HjPL2RR11
        jBpQkJkzrqugVn9Oe93zic9j7LT+htdKEAQxyQpbYw==
X-Google-Smtp-Source: APXvYqzkSZazuhPDk5ny3gLrUl+AS++zX+xcHitd9HhsB7kkFpJrE0QiMk4fGIii4YKCcUGZYaG6+XzxBGQ9CHBwLiI=
X-Received: by 2002:a9d:3a75:: with SMTP id j108mr10442372otc.110.1572362464482;
 Tue, 29 Oct 2019 08:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <CAG48ez3q=BeNcuVTKBN79kJui4vC6nw0Bfq6xc-i0neheT17TA@mail.gmail.com>
 <20191028172143.4vnnjpdljfnexaq5@wittgenstein> <CAG48ez20hn8vToY+=C62nA-rbUfxh=JD6N-f7XVS3_GZOoPjxw@mail.gmail.com>
 <20191029112706.p5dd5yzpcgouo6n5@wittgenstein> <20191029142622.jxmssu4s4ndui7bw@wittgenstein>
In-Reply-To: <20191029142622.jxmssu4s4ndui7bw@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Oct 2019 16:20:37 +0100
Message-ID: <CAG48ez1pH9fGacQF6m7=R39bDMRqNR_ML7d2v-e=-kVLJhBuPA@mail.gmail.com>
Subject: Re: For review: documentation of clone3() system call
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
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

On Tue, Oct 29, 2019 at 3:26 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Tue, Oct 29, 2019 at 12:27:07PM +0100, Christian Brauner wrote:
> > On Mon, Oct 28, 2019 at 08:09:13PM +0100, Jann Horn wrote:
> > > On Mon, Oct 28, 2019 at 6:21 PM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > > where stack + stack_size is addition on a void pointer which usually
> > > > clang and gcc are not very happy about.
> > > > I wanted to bring this up on the mailing list soon: If possible, I don't
> > > > want userspace to need to know about stack direction and just have stack
> > > > point to the beginning and then have the kernel do the + stack_size
> > > > after the copy_clone_args_from_user() if the arch needs it. For example,
> > > > by having a dumb helder similar to copy_thread_tls()/coyp_thread() that
> > > > either does the + stack_size or not. Right now, clone3() is supported on
> > > > parisc and afaict, the stack grows upwards for it. I'm not sure if there
> > > > are obvious reasons why that won't work or it would be a bad idea...
> > >
> > > That would mean adding a new clone flag that redefines how those
> > > parameters work and describing the current behavior in the manpage as
> > > the behavior without the flag (which doesn't exist on 5.3), right?
> >
> > I would break API and if someone reports breakage we'll revert and go
> > the more complicated route you outlined (see [1]).
>
> @Jann, I think the following patch might even be enough?...
[...]
> +static inline void clone3_prepare_stack(struct kernel_clone_args *kargs)
> +{
> +#if !defined(CONFIG_STACK_GROWSUP) && !defined(CONFIG_IA64)
> +       kargs->stack += kargs->stack_size;
> +#endif
> +}

I guess it might work as long as nobody is actually using clone3 yet
and you can get this patch into the 5.3 stable tree and any distro
kernels on 5.3 before people do start using clone3?
