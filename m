Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA4CEC1E
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 23:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfD2ViA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 17:38:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32792 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfD2Vh7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 17:37:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so10843317ljc.0
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xn/5jS+m49YEHy9VewaGSeXNPslEqie8PTvJU6EXUNw=;
        b=hxFbqa4ewa41rSYJkjywqzmK/JSCoGBv9pbM0qVpY7Jcn8QmH+hVBPBdi7+D/zJmdk
         nmh191WRMCDQnlnOa+BZyyPstDYFCZkzpGRd0yKcaYhaQ9NmaL1Wd+MyXvvygdZSo+wh
         4K4v5k4yhv7oc8csttKN+MRZCq2FU2n6mdTIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xn/5jS+m49YEHy9VewaGSeXNPslEqie8PTvJU6EXUNw=;
        b=sO2l3Op4VzFIzoBjDSst3dX1HutXs+Uhp9Az69lD39Nu6EiTh/xbANWnXY4GVa6WLF
         zs67YfNhXenm3Y5gLkB7QGYtWs3MtWlnaxZIaQdJovcJCo0+J7iWZ1fMQQ9HYQh7L4gb
         nJJyMgX/DO48JqR5nFSCR9GzGDyQLsnV/kYrIIOjroCpRH/zhSWah26Ml+SyJC2JEYmW
         4Lo+nFZQP9SrAMsnoJ5iF6ETdRfqT6/TxvkjHkEmNezFAi/PaitovLkW+rA5JoRPkGIQ
         xG7IT4CDd8FgdJMkry7R8GaZMP71uO1TEWU4W6IbTg4OhEV59gz0N/Sf0S+zaJvu3WII
         YY4w==
X-Gm-Message-State: APjAAAX/pPtm/gLwyHlZtocRraXec81ndldHNoEyX8CgHQyGKq1Ia85b
        fHDiuiQL522dnNb3NZLFyM40GWMWC5U=
X-Google-Smtp-Source: APXvYqzdho/xLUcht7ryWrK//sKv6pANedhiWMv8bKGy1FRxRnwbnsl7toO6tOs+EGlFEEFuWo9L2Q==
X-Received: by 2002:a2e:9c57:: with SMTP id t23mr9162700ljj.152.1556573877400;
        Mon, 29 Apr 2019 14:37:57 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id m21sm7562580lfj.47.2019.04.29.14.37.56
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:37:57 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id v1so9181920lfg.5
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 14:37:56 -0700 (PDT)
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr3927622lfl.67.1556573506825;
 Mon, 29 Apr 2019 14:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
 <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com> <87zho8bl8x.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87zho8bl8x.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 14:31:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPv4QJBC0qX8xxnT5P2C7S5uDG0HKdvdSpcoXaHG91tQ@mail.gmail.com>
Message-ID: <CAHk-=wiPv4QJBC0qX8xxnT5P2C7S5uDG0HKdvdSpcoXaHG91tQ@mail.gmail.com>
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

On Mon, Apr 29, 2019 at 1:38 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> In Linux-as-the-ABI (as opposed to Linux-as-the-implementation), vfork
> is sometimes implemented as fork, so applications cannot rely on the
> vfork behavior regarding the stopped parent and the shared address
> space.

What broken library does that?

Sure, we didn't have a proper vfork() long long long ago. But that
predates both git and BK, so it's some time in the 90's. We've had a
proper vfork() *forever*.

> In fact, it would be nice to have a flag we can check in the posix_spawn
> implementation, so that we can support vfork-as-fork without any run
> time cost to native Linux.

No. Just make a bug-report to whatever broken library you use. What's
the point of having a library that can't even get vfork() right? Why
would you want to have a flag to say "vfork is broken"?

                 Linus
