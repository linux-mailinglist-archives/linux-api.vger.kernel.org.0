Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12FE1339D1
	for <lists+linux-api@lfdr.de>; Wed,  8 Jan 2020 04:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgAHDy1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jan 2020 22:54:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40962 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgAHDyY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jan 2020 22:54:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so1808887ljc.8
        for <linux-api@vger.kernel.org>; Tue, 07 Jan 2020 19:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q40DWgK8M0OoDe3G8fJtUun454pFc/8k6TQoLjBZYSE=;
        b=f8EEU0mlDTrnDmO/oZvkaHYgwqetzmMJkLMEkXSz1Dtu/XdjBFpxCQNfx6jLkIcORD
         SBMC/xmiR45kNQlrj3VE3OodCQ7pLCtyqVB0mi8a3qFl8sRqMkSBt2Z3OSKULIfLKE/8
         yEAosVbnsvj2vSVqNYp6pjkhfpVEYQPi8ytG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q40DWgK8M0OoDe3G8fJtUun454pFc/8k6TQoLjBZYSE=;
        b=gkzImwIGioFbFmumt2XkWLGR1BNbGF8OqoUH4z3HlApEjXaREkABj52JBMfZRGaNOc
         lAWNgK1On0CJrQhRG2ZgT9u/h3mslEwOf6f8CmcAnnxDA2tCx2RPrM877z+wDVjrWwLo
         ixHHbT/mkuXLutG8QkIRIQv+VtDF5Z+oWgKAmCtXYVz4GT+7uHA2bhJWr27mKtfBrN2t
         1ZSXrVdOzEGb6ZDDF4kN152a2OUwK62gs/2Gr5UFUZf60Erft+razFQPfdzAuBjPIboh
         EY8Ky1QMJqxZ70YRIrA8hpgZRpBSRevhhfDxl8S/VQ44cxoExgsmXr7JqxaKgIyVL8yH
         8gkg==
X-Gm-Message-State: APjAAAXXut85oXESxF1tZUC+dekTADolHNLKpck95gqLc5h0tF8cJL/n
        ZjlGjWLi6zpcd9EnRqMrBZ6vIZ/13wc=
X-Google-Smtp-Source: APXvYqzR3/NobY30vgs44Qv6EspnP5jJmLlaUIZmPoxvUFlydkv6gB+yI7TaQ4e4dKnTcMraqN4jow==
X-Received: by 2002:a2e:b0f5:: with SMTP id h21mr1632527ljl.9.1578455660782;
        Tue, 07 Jan 2020 19:54:20 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id f30sm559652ljp.31.2020.01.07.19.54.18
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 19:54:19 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id m26so1779500ljc.13
        for <linux-api@vger.kernel.org>; Tue, 07 Jan 2020 19:54:18 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr1648047ljj.26.1578455658530;
 Tue, 07 Jan 2020 19:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20191230054413.GX4203@ZenIV.linux.org.uk> <20191230054913.c5avdjqbygtur2l7@yavin.dot.cyphar.com>
 <20191230072959.62kcojxpthhdwmfa@yavin.dot.cyphar.com> <20200101004324.GA11269@ZenIV.linux.org.uk>
 <20200101005446.GH4203@ZenIV.linux.org.uk> <20200101030815.GA17593@ZenIV.linux.org.uk>
 <20200101144407.ugjwzk7zxrucaa6a@yavin.dot.cyphar.com> <20200101234009.GB8904@ZenIV.linux.org.uk>
 <20200102035920.dsycgxnb6ba2jhz2@yavin.dot.cyphar.com> <20200103014901.GC8904@ZenIV.linux.org.uk>
 <20200108031314.GE8904@ZenIV.linux.org.uk>
In-Reply-To: <20200108031314.GE8904@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jan 2020 19:54:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQ3yOBuK8mxpnntD8cfX-+10ba81f86BYg8MhvwpvOMg@mail.gmail.com>
Message-ID: <CAHk-=wgQ3yOBuK8mxpnntD8cfX-+10ba81f86BYg8MhvwpvOMg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/1] mount: universally disallow mounting over symlinks
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        stable <stable@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jan 7, 2020 at 7:13 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, I suspect that we want to do something along the following lines:
>
> 1) make build_open_flags() treat O_CREAT | O_EXCL as if there had been
> O_NOFOLLOW in the mix.

My reaction to that is "Whee, that's a big change".

But:

> Benefit: this fragment in do_last()

you're right.

That's the semantics we have right now (and I think it's the correct
safe semantics when I think about it). But when I first looked at your
email I without thinking more about it actually thought we followed
the symlink, and then did the O_CREAT | O_EXCL on the target (and
potentially succeeded).

So I agree - making O_CREAT | O_EXCL imply O_NOFOLLOW seems to be the
right thing to do, and not only should simplify our code, it's much
more descriptive of what the real semantics are.

Even if my first reaction was that it would act differently.

Slash-and-burn approach to your explanatory subsequent steps:

> 2) make follow_managed() take &inode and &seq.
> 3) have the followup to failing __follow_mount_rcu() taken into it.
> 4) fold __follow_mount_rcu() into follow_managed(), using the latter both in
> RCU and non-RCU cases.
> 5) take the calls of follow_managed() out of lookup_fast() into its callers.
> 6) after that we have 3 callers of step_into(); [..]
> So if we manage to convert the damn thing in mountpoint_last() into
> follow_managed(), we could fold follow_managed() into step_into().

I think that all makes sense. I didn't go to look at the source, but
from the email contents your steps look reasonable to me.

> Another interesting question is whether we want O_PATH open
> to trigger automounts.

It does sound like they shouldn't, but as you say:

>     The thing is, we do *NOT* trigger them
> (or traverse mountpoints) at the starting point of lookups.
> I believe it's a mistake (and mine, at that), but I doubt that
> there's anything that can be done about it at that point.
> It's a user-visible behaviour [..]

Hmm. I wonder how set in stone that is. We may have two decades of
history of not doing it at start point of lookups, but we do *not*
have two decades of history of O_PATH.

So what I think we agree would be sane behavior would be for O_PATH
opens to not trigger automounts (unless there's a slash at the end,
whatever), but _do_ add the mount-point traversal to the beginning of
lookups.

But only do it for the actual O_PATH fd case, not the cwd/root/non-O_PATH case.

That way we maintain original behavior: if somebody overmounts your
cwd, you still see the pre-mount directory on lookups, because your
cwd is "under" the mount.

But if you open a file with O_PATH, and somebody does a mount
_afterwards_, the openat() will see that later mount and/or do the
automount.

Don't you think that would be the more sane/obvious semantics of how
O_PATH should work?

> I think the easiest way to handle that is to have O_PATH
> turn LOOKUP_AUTOMOUNT, same as the normal open() does.  That's
> trivial to do, but that changes user-visible behaviour.  OTOH,
> with the current behaviour nobody can rely upon automount not
> getting triggered by somebody else just as they are entering
> their open(dir, O_PATH), so I think that's not a problem.
>
> Linus, do you have any objections to such O_PATH semantics
> change?

See above: I think I'd prefer the O_PATH behavior the other way
around. That seems to be more of a consistent behavior of what
"O_PATH" means - it means "don't really open, we'll do it only when
you use it as a directory".

But I don't have any _strong_ opinions. If you have a good reason to
tell me that I'm being stupid, go ahead and do so and override my
stupidity.

             Linus
