Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1E5EEC0
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 04:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfD3CW2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 22:22:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43150 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfD3CW2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 22:22:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id t1so1134068lje.10
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 19:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7K80baoGD98i/ki0iA1SM4BuBVnujumewB88uhrGPE=;
        b=agEwzL5uVGX3m7CSaELzs/03mfCALUUKzAl+yfarpEfu3aAmqoEpsz3pM4cUroNLl/
         6bneaBMEu0Mu4GZZEgEZtYPC7Go4RCUjhq5pyTbn8KeNhVXtO4bI8l39EoVfErZQk0aR
         6Hh69Nwv8qf3nijb9WYOsKX2+TAZsGITw3iDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7K80baoGD98i/ki0iA1SM4BuBVnujumewB88uhrGPE=;
        b=HtTnXEgWg8gmQcgjFQTkZX7gV0kIRBGvZrNDJZxWnWlXi32O0YwPr9LMVdT/IxbGa8
         gR70jcxSUVXzYtryn09SrsNNgXSg8WteRIir+NBTYsRyOOqdP32cQI+mMXSCUh57epDF
         GTK7HZK8mxzv/THiCNjNl4Mc3rs29y3J2g0Sk+Dd+EBLY6K/Ko253JxeEnQYAIRD4YTI
         BUc1tu08FJVBoaNWCyY0JITPQjRqUtBsTAhICdyZ+iMHkwwJ6w8BihyUSe/dZkp8Eaq8
         h4TiY4o0S1xqjPNMFNzT3Lw2PXo/rU23LHuaCCDGuBQbr/tnUXyr01maneWm5MWmiqyR
         dkYw==
X-Gm-Message-State: APjAAAWfNAV2My3HqRdzKZFLzZRRneQuq6MQ0nfnm5X7utNTDZ6DeHEW
        gX54e+pnwn/9giBEmIUw5MzqZnLEfuo=
X-Google-Smtp-Source: APXvYqziK8E+mynxWE98Xha/uwoL+jC5/PRR/BjSEQ/9QhC3ewyajQMPeRo5iwontcelS8CXnkyDtA==
X-Received: by 2002:a2e:74f:: with SMTP id i15mr17481103ljd.156.1556590945547;
        Mon, 29 Apr 2019 19:22:25 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id v24sm948634lje.31.2019.04.29.19.22.25
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 19:22:25 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id s7so8537399ljh.1
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 19:22:25 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr31073909ljj.79.1556590587148;
 Mon, 29 Apr 2019 19:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
 <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com> <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
In-Reply-To: <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 19:16:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg73au-kvOwWpPDY+rXrz8O5gwrcPiw1FZx-Qr2PqpRFg@mail.gmail.com>
Message-ID: <CAHk-=wg73au-kvOwWpPDY+rXrz8O5gwrcPiw1FZx-Qr2PqpRFg@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Jann Horn <jannh@google.com>
Cc:     Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 5:39 PM Jann Horn <jannh@google.com> wrote:
>
> ... uuuh, whoops. Turns out I don't know what I'm talking about.

Well, apparently there's some odd libc issue accoprding to Florian, so
there *might* be something to it.

> Nevermind. For some reason I thought vfork() was just
> CLONE_VFORK|SIGCHLD, but now I see I got that completely wrong.

Well, inside the kernel, that's actually *very* close to what vfork() is:

  SYSCALL_DEFINE0(vfork)
  {
        return _do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, 0,
                        0, NULL, NULL, 0);
  }

but that's just an internal implementation detail. It's a real vfork()
and should act as the traditional BSD "share everything" without any
address space copying. The CLONE_VFORK flag is what does the "wait for
child to exit or execve" magic.

Note that vfork() is "exciting" for the compiler in much the same way
"setjmp/longjmp()" is, because of the shared stack use in the child
and the parent. It is *very* easy to get this wrong and cause massive
and subtle memory corruption issues because the parent returns to
something that has been messed up by the child.

That may be why some libc might end up just using "fork()", because it
ends up avoiding bugs in user space.
(In fact, if I recall correctly, the _reason_ we have an explicit
'vfork()' entry point rather than using clone() with magic parameters
was that the lack of arguments meant that you didn't have to
save/restore any registers in user space, which made the whole stack
issue simpler. But it's been two decades, so my memory is bitrotting).

Also, particularly if you have a big address space, vfork()+execve()
can be quite a bit faster than fork()+execve(). Linux fork() is pretty
efficient, but if you have gigabytes of VM space to copy, it's going
to take time even if you do it fairly well.

               Linus
