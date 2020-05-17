Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3561D67A3
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2020 13:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgEQLR6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 May 2020 07:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgEQLR6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 May 2020 07:17:58 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9EC05BD09
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 04:17:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g9so5963150edr.8
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4+u2L05qamryNPAo2T4bzOw/jmfe9BMj+ubXlFIP3M=;
        b=r3/9LGFiYPgwjcwX6d1PLqCTLUBo9OdlxmUFn1astZTDgXFVIOQPcFGV6gDJVgO9Yc
         g/U7d6pS4ayuWtjYbz4YbamZqxVRupQ7iJkTa7uDCYoXOzqonderuwAURCVreToE1SUo
         Dv3B+yX4s3fvWOWBSqAKZiXZcBA1NWHB0EUmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4+u2L05qamryNPAo2T4bzOw/jmfe9BMj+ubXlFIP3M=;
        b=C88NnJHiYCUX9CNhqSiZUdnf2Qf18a11zRXKuhE2ZaHYlVBW2SRIxFDBvQe3yJvASm
         pwXa5kItrHkYe+rom0BSbPjGvGfav6NPesBLblJiLJZ5CGtDEu6MMcFT1ZppxG14IpPk
         2cGhyc97uy75UToo0knmUJx2W9NkwSj+To2hgNOeCaEaEtj9b174893cuIuLq3HOv03Z
         fImIwE+J062ErGZGHilZ9eekovpEipZQoYcNs+twjhcj021njLjcm++uPTVeNQnECUeJ
         pp8YRhSucBowXYdH9bg4cHYJymW6dOxx8qipxyDQSAWUzEV71g42PNLqbA6STmf0JX3C
         XaOA==
X-Gm-Message-State: AOAM533eOgVPBfJJoNPPTJMTlBUnKpUogJaYXkbyvbR4pG4qHKdAQ8DM
        lATJcxtNNHzvhRtytZ1797SjihhZRWx8+VJGL5i4Vw==
X-Google-Smtp-Source: ABdhPJySir2IEf/xIHAzDY5chi9uwUVmvi9gPyjR+LEZtW4loF25ecwGZN6Jzv+7FB2NgAj6AGF5k+olpj0lnUZ1PL8=
X-Received: by 2002:aa7:c617:: with SMTP id h23mr8804881edq.305.1589714275547;
 Sun, 17 May 2020 04:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234005.32370-1-sargun@sargun.me> <202005162344.74A02C2D@keescook>
In-Reply-To: <202005162344.74A02C2D@keescook>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sun, 17 May 2020 04:17:19 -0700
Message-ID: <CAMp4zn-Ak0062t9HfMMZvKNv1+EAujgEeg5c4-gtjD-pAGAtTw@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 17, 2020 at 12:17 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 15, 2020 at 04:40:05PM -0700, Sargun Dhillon wrote:
> > This includes the thread group leader ID in the seccomp_notif. This is
> > immediately useful for opening up a pidfd for the group leader, as
> > pidfds only work on group leaders.
> >
> > Previously, it was considered to include an actual pidfd in the
> > seccomp_notif structure[1], but it was suggested to avoid proliferating
> > mechanisms to create pidfds[2].
> >
> > [1]: https://lkml.org/lkml/2020/1/24/133
> > [2]: https://lkml.org/lkml/2020/5/15/481
>
> nit: please use lore.kernel.org/lkml/ URLs
>
> > Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > ---
> >  include/uapi/linux/seccomp.h                  |  2 +
> >  kernel/seccomp.c                              |  1 +
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 50 +++++++++++++++++++
> >  3 files changed, 53 insertions(+)
> >
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > index c1735455bc53..f0c272ef0f1e 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -75,6 +75,8 @@ struct seccomp_notif {
> >       __u32 pid;
> >       __u32 flags;
> >       struct seccomp_data data;
> > +     __u32 tgid;
> > +     __u8 pad0[4];
> >  };
>
> I think we need to leave off padding and instead use __packed. If we
> don't then userspace can't tell when "pad0" changes its "meaning" (i.e.
> the size of seccomp_notif becomes 88 bytes with above -- either via
> explicit padding like you've got or via implicit by the compiler. If
> some other u32 gets added in the future, user space will still see "88"
> as the size.
>
I've had previous feedback about using "packed". See:
https://lore.kernel.org/lkml/87o8w9bcaf.fsf@mid.deneb.enyo.de/
https://lore.kernel.org/lkml/a328b91d-fd8f-4f27-b3c2-91a9c45f18c0@rasmusvillemoes.dk/
> So I *think* the right change here is:
>
> -};
> +       __u32 tgid;
> +} __packed;
>
> Though tgid may need to go above seccomp_data... for when it grows.
> Agh...
(How) can seccomp_data grow safely, even with this extensibility mechanism?
>
> _However_, unfortunately, I appear to have no thought this through very
> well, and there is actually no sanity-checking in the kernel for dealing
> with an old userspace when sizes change. :( For example, if a userspace
> doesn't check sizes and calls an ioctl, etc, the kernel will clobber the
> user buffer if it's too small.
>
> Even the SECCOMP_GET_NOTIF_SIZES command lacks a buffer size argument.
> :(
>
> So:
>
> - should we just declare such userspace as "wrong"? I don't think
>   that'll work, especially since what if we ever change the size of
>   seccomp_data...  that predated the ..._SIZES command.
>
> - should we add a SECCOMP_SET_SIZES command to tell the kernel what
>   we're expecting? There's no "state" associated across seccomp(2)
>   calls, but maybe that doesn't matter because only user_notif writes
>   back to userspace. For the ioctl, the state could be part of the
>   private file data? Sending seccomp_data back to userspace only
>   happens here, and any changes in seccomp_data size will just be seen
>   as allowing a filter to query further into it.
Will we ever grow seccomp_data?

I suggest we throw away the _SIZES api, and just introduce RECV2, which sends
back a known, fixed format, and deprecate these dynamically sized uapi
shenanigans.

(Queue RECV3, etc..)

Maybe we do something like perf_event_open, where there's a read_format,
and that's used by the user to determine how big of a response / fields they
want to get?

>
> - should GET_SIZES report "useful" size? (i.e. exclude padding?)
>
> > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
>
> Yay test updates! :)
>
> > +TEST(user_notification_groupleader)
>
> In my first pass of review I was going to say "can you please also check
> the sizes used by the ioctl?" But that triggered the above size checking
> mess in my mind.
>
> Let me look at this more closely on Monday, and I'll proposed something.
> :P
To summarize my set of ideas:
1. We take the ptrace-style API, where we have a request to get the tgid of
a given request ID (or any new / extensible field)
2. We add a perf_event_open style API, where you have to tell it what fields
to include in the response
3. We introduce RECV2 [through N]
4. We never extend seccomp_data, and just continue to append things to the API
5. We rev the API _once_ and unroll seccomp_data, and make it so that
new members have to be *asked for*, rather than are implicitly
included.
>
> Thanks!
>
> -Kees
>
> --
> Kees Cook
