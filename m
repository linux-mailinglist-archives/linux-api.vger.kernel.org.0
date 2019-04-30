Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBCAAFDCE
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfD3Q0g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Apr 2019 12:26:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38620 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3Q0g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Apr 2019 12:26:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id e18so7481870lja.5
        for <linux-api@vger.kernel.org>; Tue, 30 Apr 2019 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0mkWPXxdneoX6ZtNfTUi9Tvo+w8cp5wN8Xc0PEQw60=;
        b=EbjP++XKgHxEkneKGZLizrtbM/P7rph4iLyi00CwA3AQOQ0XrmvNGA7c0yA2ueK8Uz
         mygblbiGSrjljLAhCMoYE5sU13o9Bt+rMjweu0Grl3dyGako9+M+H/dusOy0YkCu4M0r
         3R5BK1XDGR+K6UwjSp6+/jpIH7TevLCGc14QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0mkWPXxdneoX6ZtNfTUi9Tvo+w8cp5wN8Xc0PEQw60=;
        b=q45RdOljxxsATdY51j0vcVNcd8sbB9G4Pt+pXwbe2+v29SuzFj2PRxRXRvDtsJFUQJ
         LNmcPeehNgJjx+2n5J436wzh6FDkeYRjzely0RrW9LR9Qllcfj5vGFvgbqGAO5pXRsIn
         ZyAhz91VL/p9vTBl68Uwl9pFpr1EpcZC0yzvnnn7c0L5q/SK/NAxGIUY7C03JmNk/mX0
         RTpaT7OlS/nce3YoFKi4aihTbVVxaAP2/zC6GIpSWWly5YNnkmUJLdO5riWHPlGbfRkx
         vbehtwIrKPSdoBEZaFrISqXV07w2EMzbny3iSCFDeqr73x2mhxA5twSWmdAbokKcp/H/
         me3g==
X-Gm-Message-State: APjAAAUF8J33jtQ3GlEWTQTVo0J7/7KnxZ1rK00q6iL4Lg5LUh6KPuk2
        riuAzXQatKY0BX1sI1Y9F2gzKgajXW0=
X-Google-Smtp-Source: APXvYqwy1EcMtY9PbfkbV/UaMSqqhXl3f/a1vyuCEcuLWFMML+zCRQPV4TOUPdk21cSAhYeIgP/OFQ==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr37185238ljb.3.1556641594080;
        Tue, 30 Apr 2019 09:26:34 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y23sm7895101lfy.31.2019.04.30.09.26.33
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:26:33 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id k8so13373094lja.8
        for <linux-api@vger.kernel.org>; Tue, 30 Apr 2019 09:26:33 -0700 (PDT)
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr37367875lje.22.1556641166346;
 Tue, 30 Apr 2019 09:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
 <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
 <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
 <CAHk-=wg73au-kvOwWpPDY+rXrz8O5gwrcPiw1FZx-Qr2PqpRFg@mail.gmail.com> <87r29jaoov.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87r29jaoov.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Apr 2019 09:19:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiM8VQ_Ny6Y=fTqE9Aq1LuDdU5bKfnXPyYXU1bi7GtU4w@mail.gmail.com>
Message-ID: <CAHk-=wiM8VQ_Ny6Y=fTqE9Aq1LuDdU5bKfnXPyYXU1bi7GtU4w@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Kevin Easton <kevin@guarana.org>,
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

On Tue, Apr 30, 2019 at 1:21 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> > (In fact, if I recall correctly, the _reason_ we have an explicit
> > 'vfork()' entry point rather than using clone() with magic parameters
> > was that the lack of arguments meant that you didn't have to
> > save/restore any registers in user space, which made the whole stack
> > issue simpler. But it's been two decades, so my memory is bitrotting).
>
> That's an interesting point.  Using a callback-style interface avoids
> that because you never need to restore the registers in the new
> subprocess.  It's still appropriate to use an assembler implementation,
> I think, because it will be more obviously correct.

I agree that a callback interface would have been a whole lot more
obvious and less prone to subtle problems.

But if you want vfork() because the programs you want to build use it,
that's the interface you need..

Of course, if you *don't* need the exact vfork() semantics, clone
itself actually very much supports a callback model with s separate
stack. You can basically do this:

 - allocate new stack for the child
 - in trivial asm wrapper, do:
    - push the callback address on the child stack
    - clone(CLONE_VFORK|CLONE_VM|CLONE_SIGCHLD, chld_stack, NULL, NULL,NULL)
    - "ret"
 - free new stack

where the "ret" in the child will just go to the callback, while the
parent (eventually) just returns from the trivial wrapper and frees
the new stack (which by definition is no longer used, since the child
has exited or execve'd.

So you can most definitely create a "vfork_with_child_callback()" with
clone, and it would arguably be a much superior interface to vfork()
anyway (maybe you'd like to pass in some arguments to the callback too
- add more stack setup for the child as needed), but it wouldn't be
the right solution for programs that just want to use the standard BSD
vfork() model.

> vfork is also more benign from a memory accounting perspective.  In some
> environments, it's not possible to call fork from a large process
> because the accounting assumes (conservatively) that the new process
> will dirty a lot of its private memory.

Indeed.

                 Linus
