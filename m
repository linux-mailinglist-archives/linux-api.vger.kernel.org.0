Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB7544F4C4
	for <lists+linux-api@lfdr.de>; Sat, 13 Nov 2021 20:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbhKMTRl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 13 Nov 2021 14:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbhKMTRk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 13 Nov 2021 14:17:40 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2062EC061766
        for <linux-api@vger.kernel.org>; Sat, 13 Nov 2021 11:14:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g14so52191510edz.2
        for <linux-api@vger.kernel.org>; Sat, 13 Nov 2021 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Th5b5uEbVAClqQZKB40iBYxSoIX0RninCCu9L6PZkvQ=;
        b=gdORQZNcyLnT5FHqxDVdbiV0XvJnzs/yQjphexWwwHRnM6VsmOsWJbJaGu4crX3tAt
         yEdJa4ORZvokpeqdvTIKG8LRau7lS8+MGz95jq6CCczv6kkVN+X3dMobk5wZQyufTPiU
         0aXFtHYalFTxPnbb1riVAdfQyuXm6RcCJLeoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Th5b5uEbVAClqQZKB40iBYxSoIX0RninCCu9L6PZkvQ=;
        b=xV7hH/+AsjiHKQp6jUwxdutLrGij+jy8olb1KNeaYwH34zANjaka5UJ/Z0RaYz794a
         SwV/KfCAOki6HNCSv5/P+9GxyCgP4CSmMvbLhHb+o7f7J6vYN8NA7JKDbe87HNyYA9vf
         8LlT3nosKJmq2Nrve/Kgu0Tq4G63YEq+TTmZtuyng7D245yPjUa6C1/o3RaxKslILf8g
         LvjuY39i3ZBHSWDNfsJTWDuSA7MP5aPSTPUcl7Z7KUhfYR55y8eXuBRlwX+6N5gwQMV5
         aHqODBUbTT/EGDVR559gbmLUm/PmbxHrKI/NFoyCW24OH1ptwBxCBLsswjpD3natjkr+
         oSIw==
X-Gm-Message-State: AOAM531Tyewud8RHacwqkLcJdQwC1bhzGLZIJjaaijutKeMNjajDhYFy
        lSVqPv4UFTjUlwnDbTfB/R1VSRwdSbzTD9WNGE4=
X-Google-Smtp-Source: ABdhPJxIcUQamhen7p3NBFyqG3T6xAFgccszd9gHmLQVLWsD1u2YMUz1BNqyZbJSjVqtnTQPtymIig==
X-Received: by 2002:a05:6402:3588:: with SMTP id y8mr35453857edc.328.1636830886461;
        Sat, 13 Nov 2021 11:14:46 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id cw20sm4034943ejc.32.2021.11.13.11.14.45
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 11:14:45 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id p18so1116007wmq.5
        for <linux-api@vger.kernel.org>; Sat, 13 Nov 2021 11:14:45 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr28153806wms.144.1636830885325;
 Sat, 13 Nov 2021 11:14:45 -0800 (PST)
MIME-Version: 1.0
References: <878ry512iv.fsf@disp2133> <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
 <871r3uy2vw.fsf@disp2133>
In-Reply-To: <871r3uy2vw.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 11:14:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
Message-ID: <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
Subject: Re: [GIT PULL] per signal_struct coredumps
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Git List Mailing <git@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[ Coming back to this email because I'm starting to see the light at
the end of the merge window tunnel .. ]

Adding the git list to see if somebody has suggestions, and
top-posting because the email from Eric is more of "explanation for
the issue" than anything else, so I'm quoting it at the end for
context.

The basic issue is how to sanely keep track of a cover letter when you
have a branch that you haven't sent out yet, but will ask somebody to
pull. It may still be seeing more testing and development before that
pull happens, though.

This very much smells of what the "branch description" is all about, but

 (a) I suspect "git branch --edit-description" is not very well known

 (b) it works well with "git request-pull", but not so much some other
things (like copying it into a signed tag)

 (c) it makes an unholy mess of your config file if you actually use
it for extensive explanations (branch descriptions _work_ for
multi-line messages, but it really was designed as a one-liner thing).

 (d) it doesn't work across repositories (ie multiple developers or
even just a single developer on multiple machines).

IOW, the "branch description" is _kind_ of the right thing, but not really.

The fake merge _does_ solve all these issues, it just then ends up
leaving that turd around in the history.

An empty commit would do it as well, but an empty commit very easily
gets lost (git rebase etc). The fake merge does have similar issues.

Both a fake merge, and an empty commit have the advantage that they
are easy to see and work with (ie "git log" and all the other git
workflows work very naturally).

Comments from git people?

                Linus

On Fri, Nov 5, 2021 at 9:38 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Wed, Nov 3, 2021 at 12:07 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > I've pulled it, but I'm not convinced about that odd extra merge
> > commit that contains the commentary.
> >
> > That's what signed tags are for, and they have that explanation that
> > then makes it into the merge - plus they have the crypto signature to
> > show it all comes from you.
> >
> > So that would have been the much better model than a fake extra merge.
> >
> > But at least that extra merge did have explanations, so at least it
> > doesn't trigger me on _that_ level.
>
> I have been creating those when I place a patchset with an interesting
> cover letter in a branch.  Now with the entire branch being just that
> patchset, it doesn't make a lot of sense (except as somewhere to store
> that cover letter so I don't loose it).  At other times when there are
> multiple sets of changes on a single branch I think it makes more sense.
>
> Am I missing a better way to preserve the cover letter for the
> changes when multiple sets of changes land in a single branch?
>
> Eric
