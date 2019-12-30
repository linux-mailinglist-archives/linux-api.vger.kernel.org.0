Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1582E12CD72
	for <lists+linux-api@lfdr.de>; Mon, 30 Dec 2019 08:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfL3HyJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Dec 2019 02:54:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35463 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfL3HyI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Dec 2019 02:54:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id 15so24644791lfr.2
        for <linux-api@vger.kernel.org>; Sun, 29 Dec 2019 23:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPYZanyjmH24ggFQ0lPuYSWOsbulZsh973CIm+qG+bk=;
        b=Cx3+XC85If9Oc3+SnG+zaiVL3sW0ltnO4/9ZE8Ra0eb06emSRYR1g1CetfkcslqRDu
         zngUIRfNBEw2+zHB+1VIS6HcdT6io8j0lKAIdKyWkqzg0NCQXe4euoQAsTWtdle3aXn2
         1oukdDy3yiimYe6rjVLG8s6wv0hhJ97hy/Dzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPYZanyjmH24ggFQ0lPuYSWOsbulZsh973CIm+qG+bk=;
        b=A4FKRY8+W8DczqLMd9zPG8Pz0Om1FgAYlaSXcW2PURZz1NkONeEbEzAmyDgwttI5SM
         uOgJ0sgUsvT8FmJIPpFF0S72FfGRK43tSQcbhrwNGPRAg+DgdO1FeloMN+AaS8rvHFBS
         D/LQnraM3BV9jmHk7mJnPgMjjUeqnkkPb5O68Ig9pnYP4/LZuf6SL7hSy4/e0JeQtrn6
         nC/Xekz11JYXa6dsprQwkMB/AH8Jf/z81l4h2BS8TNH5YOW2pZszX2Py/Kgl7N+HtPJH
         8ZYTqxzN+fOn9+S/kFG0QbCxu+sn7IVbPEU5Mb9xEgwfeqa+xDyBO5GbukXhBeHixCkd
         uWsg==
X-Gm-Message-State: APjAAAV0aykRDk/EaweGtQeyvBUNj7VV869PiThXPDO27gcjD+ZZ1Kx9
        qu3C8dJVqeH6AoFa9sz4lfVJVe+/2eU=
X-Google-Smtp-Source: APXvYqy6r5yMDcM9CMPqi9FYQ4G0bWcIulI0AKWuYT3rW0Qj9km0dr66xXTJSqq8EmJq0awqvQ2Wcg==
X-Received: by 2002:ac2:46dc:: with SMTP id p28mr37482647lfo.23.1577692446075;
        Sun, 29 Dec 2019 23:54:06 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id r15sm4521565ljh.11.2019.12.29.23.54.03
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 23:54:04 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id w1so10510417ljh.5
        for <linux-api@vger.kernel.org>; Sun, 29 Dec 2019 23:54:03 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr37567234ljg.133.1577692443206;
 Sun, 29 Dec 2019 23:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20191230052036.8765-1-cyphar@cyphar.com> <20191230054413.GX4203@ZenIV.linux.org.uk>
 <20191230054913.c5avdjqbygtur2l7@yavin.dot.cyphar.com> <20191230072959.62kcojxpthhdwmfa@yavin.dot.cyphar.com>
In-Reply-To: <20191230072959.62kcojxpthhdwmfa@yavin.dot.cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Dec 2019 23:53:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxNw7hYT6bJn9mVrB_a=7Y-irmpaPsp1R4xbHHkicv7g@mail.gmail.com>
Message-ID: <CAHk-=whxNw7hYT6bJn9mVrB_a=7Y-irmpaPsp1R4xbHHkicv7g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/1] mount: universally disallow mounting over symlinks
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        stable <stable@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Dec 29, 2019 at 11:30 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000000

Would you mind building with debug info, and then running the oops through

 scripts/decode_stacktrace.sh

which makes those addresses much more legible.

>     #PF: supervisor instruction fetch in kernel mode
>     #PF: error_code(0x0010) - not-present page

Somebody jumped through a NULL pointer.

>     RAX: 0000000000000000 RBX: ffff906d0cc3bb40 RCX: 0000000000000abc
>     RDX: 0000000000000089 RSI: ffff906d74623cc0 RDI: ffff906d74475df0
>     RBP: ffff906d74475df0 R08: ffffd70b7fb24c20 R09: ffff906d066a5000
>     R10: 0000000000000000 R11: 8080807fffffffff R12: ffff906d74623cc0
>     R13: 0000000000000089 R14: ffffb70b82963dc0 R15: 0000000000000080
>     FS:  00007fbc2a8f0540(0000) GS:ffff906dcf500000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffffffffffffffd6 CR3: 00000003c68f8001 CR4: 00000000003606e0
>     Call Trace:
>      __lookup_slow+0x94/0x160

And "__lookup_slow()" has two indirect calls (they aren't obvious with
retpoline, but look for something  like

        call __x86_indirect_thunk_rax

which is the modern sad way of doing "call *%rax"). One is for
revalidatinging an old dentry, but the one I _suspect_ you trigger is
this one:

                old = inode->i_op->lookup(inode, dentry, flags);

but I thought we only could get here if we know it's a directory.

How did we miss the "d_can_lookup()", which is what should check that
yes, we can call that ->lookup() routine.

This is why I have that suspicion that it's somehow that O_PATH fd
opened in another process without O_PATH causes confusion...

So what I think has happened is that because of the O_PATH thing,
we've ended up with an inode that has never been truly opened (because
O_PATH skips that part), but then with the /proc/<pid>/fd/xyz open, we
now have a file descriptor that _looks_ like it is valid, and we're
treating that inode as if it can be used.

But I'm handwaving.

             Linus
