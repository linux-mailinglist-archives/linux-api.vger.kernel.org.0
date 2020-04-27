Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166951BAE28
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 21:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgD0Tlt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 15:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbgD0Tls (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 15:41:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85971C03C1A7
        for <linux-api@vger.kernel.org>; Mon, 27 Apr 2020 12:41:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g4so18942065ljl.2
        for <linux-api@vger.kernel.org>; Mon, 27 Apr 2020 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xl34K+WyxLr+OBvYQN0aKmiQr358TgE2J+a3gDDkuqM=;
        b=MF42SY0yJDHJdeoyY2Bjwc+L+5Rr7RvBuYk1vaEDqwpzTy0Ar8l+AbQfdBq1oayuyv
         SJXbUSShjHhaEBMZLwdk+OxRBeDjhp1VRKMog083j5glNgfGCc+7I5FgZ6vPiIIHhGWh
         sF7V0Ruklt+nNaNQX+JILLGfdp6vZWflEQ6iV76Id0K1rDOJArWBcMfpAUBaBLoVsXVb
         ypw+plAYtlWVCBp2m7iOCt6tepzBEZbd2OKkM4g8zh2qfOKC//uFor3uGBjViUMwr4CN
         VzVmewGExwi+4HTaPdyE/SZ/V0ozK5wjvdksx5p7yrkQWK1+DILp1h1GhuPi1M7VJjv0
         YM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xl34K+WyxLr+OBvYQN0aKmiQr358TgE2J+a3gDDkuqM=;
        b=o47Txv8Iq3ybcpcJQNQ8HxncgBKdJF3GFxiirrwNx2ck6+dX9x5LcmrEdfjF2+mmwS
         RCF8Bt7LTg/GY5uAgX9tCzee+6VYLpeH/rDme6r6NWXVYz940QUAleZuO5X7JYQRe9kK
         JSzBziMW95hHt9T8gJN2YO/Pr55Y2ta09g1796zF/MJtx/6dzkyB+qt9sMCg9MbPIwtW
         F4eDqTskE1w1FXI9BnAqWhSHN2q6X7J6uPN5fCOjHyCcLqEIP9XfDD1+TxQ4lzhGxvz5
         oFeagwyfiw2THmdrrYL0sRpeOAPb/32VATbk3IbHZHZMqOUKY2SdEQoARdynAQX1hnKq
         Gkig==
X-Gm-Message-State: AGi0PuYBcQRyj7bKJ5apqlql30kvxkiAq6FOA1ScgsXgF9mNmHsDQugz
        +LtSEDsu0c4Quxnsji1y4yAwH+vzHYClHYB1riRsfw==
X-Google-Smtp-Source: APiQypJB2kkCHuH47L8Yqrr/alg5ajajOgnK9X0cKKMKzoNexUMBYbSy7qjFlCoaorsBN9I9MYaWgib532GjcJ9d3i8=
X-Received: by 2002:a2e:760c:: with SMTP id r12mr14755084ljc.139.1588016506746;
 Mon, 27 Apr 2020 12:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200427143646.619227-1-christian.brauner@ubuntu.com>
 <CAG48ez3eSJSODADpo=O-j9txJ=2R+EupunRvs5H9t5Wa8mvkRA@mail.gmail.com> <20200427181507.ry3hw7ufiifwhi5k@wittgenstein>
In-Reply-To: <20200427181507.ry3hw7ufiifwhi5k@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 Apr 2020 21:41:20 +0200
Message-ID: <CAG48ez2D36QZU0djiXGbirCgcFeAWA02s8PCk6SWEY5MoKg_kg@mail.gmail.com>
Subject: Re: [PATCH] nsproxy: attach to namespaces via pidfds
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 27, 2020 at 8:15 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Mon, Apr 27, 2020 at 07:28:56PM +0200, Jann Horn wrote:
> > On Mon, Apr 27, 2020 at 4:47 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
[...]
> > > That means
> > > setns(nsfd, CLONE_NEWNET) equals setns(pidfd, CLONE_NEWNET). However,
> > > when a pidfd is passed, multiple namespace flags can be specified in the
> > > second setns() argument and setns() will attach the caller to all the
> > > specified namespaces all at once or to none of them. If 0 is specified
> > > together with a pidfd then setns() will interpret it the same way 0 is
> > > interpreted together with a nsfd argument, i.e. attach to any/all
> > > namespaces.
> > [...]
> > > Apart from significiantly reducing the number of syscalls from double
> > > digit to single digit which is a decent reason post-spectre/meltdown
> > > this also allows to switch to a set of namespaces atomically, i.e.
> > > either attaching to all the specified namespaces succeeds or we fail.
> >
> > Apart from the issues I've pointed out below, I think it's worth
> > calling out explicitly that with the current design, the switch will
> > not, in fact, be fully atomic - the process will temporarily be in
> > intermediate stages where the switches to some namespaces have
> > completed while the switches to other namespaces are still pending;
> > and while there will be less of these intermediate stages than before,
> > it also means that they will be less explicit to userspace.
>
> Right, that can be fixed by switching to the unshare model of getting a
> new set of credentials and committing it after the nsproxy has been
> installed? Then there shouldn't be an intermediate state anymore or
> rather an intermediate stage where we can still fail somehow.

It still wouldn't be atomic (in the sense of parallelism, not in the
sense of intermediate error handling) though; for example, if task B
does setns(<pidfd_of_task_a>, 0) and task C concurrently does
setns(<pidfd_of_task_b>, 0), then task C may end up with the new mount
namespace of task B but the old user namespace, or something like
that. If C is more privileged than B, that may cause C to have more
privileges through its configuration of namespaces than B does (e.g.
by running in the &init_user_ns but with a mount namespace owned by an
unprivileged user), which C may not expect. Same thing for racing
between unshare() and setns().

[...]
> > > +               put_user_ns(user_ns);
> > > +       }
> > > +#else
> > > +       if (flags & CLONE_NEWUSER)
> > > +               ret = -EINVAL;
> > > +#endif
> > > +
> > > +       if (!ret && wants_ns(flags, CLONE_NEWNS))
> > > +               ret = __ns_install(nsproxy, mnt_ns_to_common(nsp->mnt_ns));
> >
> > And this one might be even worse, because the mount namespace change
> > itself is only stored in the nsproxy at this point, but the cwd and
> > root paths have already been overwritten on the task's fs_struct.
> >
> > To actually make sys_set_ns() atomic, I think you'd need some
> > moderately complicated prep work, splitting the ->install handlers up
> > into prep work and a commit phase that can't fail.
>
> Wouldn't it be sufficient to move to an unshare like model, i.e.
> creating a new set of creds, and passing the new user_ns to
> create_new_namespaces() as well as having a temporary new_fs struct?
> That should get rid of all intermediate stages.

Ah, good point, I didn't realize that that already exists for unshare().
