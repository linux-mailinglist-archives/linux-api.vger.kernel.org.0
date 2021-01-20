Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5282FD651
	for <lists+linux-api@lfdr.de>; Wed, 20 Jan 2021 18:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404087AbhATRAY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Jan 2021 12:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391718AbhATQ6l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Jan 2021 11:58:41 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C6C061575
        for <linux-api@vger.kernel.org>; Wed, 20 Jan 2021 08:58:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y187so3454914wmd.3
        for <linux-api@vger.kernel.org>; Wed, 20 Jan 2021 08:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpcAZMiidkdn8kgbweSucunSZNfQr7y4sBDVK9pNMyU=;
        b=aSKdOyEfUZ7+nbgQG4Oz34S0QFBBEpe0NkmOUgkIRQmr7puRYU8XMppmMlQK5DGLFM
         0GuKLRPRBMQvkzaw9QCBPnYJ8+Doyqjuf4weUAIPh7K2nTvy5Y9ipXkegUZc0/jbwYMN
         Z/+ys6EhiyqdFl1caKGMEH7NMXeQT4GVAjgw0ggJJUigQcSJWPWhBUTwagRzTm3SFNUF
         Vh7dMIiU/ZWLwWHovBCP7+kQOgS1da5mvzAOu1AlNAUshTtLvBSqJVGxkhVPe4yo++Nw
         +gq/kzv307e98VThRr81N9MAIin6nMYoBnx1wOuKtT9u50vzlv3s0hf29boUw909vpQv
         283Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpcAZMiidkdn8kgbweSucunSZNfQr7y4sBDVK9pNMyU=;
        b=RuPrSEtdN1WG+q9QAVXWp9WTK/gi3ZXMqn6WsKqCkznupj2ExGuTuRCjG/FbY2tNm+
         bArGHnDvDrYv7HEiwiUxmLNx+7t80qWZUzAacFQwAkRaCXGj/mCmo0+MF81D/yEj1+Sh
         /Qb8URhxb2lsdwV7EKb8sZ/JTKBCuuL9TI/xVoPq34bkk7i2d82be/B4Aea8FOQFbex/
         Xpbp3HGQ3dSn/vXvKPiaLeGzCx0Rad52fr+6M47krujApB9asF5Jz8xvpKDMe6tdhs3a
         aJ5qfR4jU0WrSqy2z/qq3xpNsaTih/AbzaSenf90NKs8VLD10UdOBmXSKcgy19dxgb+N
         7aLg==
X-Gm-Message-State: AOAM533xGtsh/63Q3lq3HM8ktoS6mIstCFWpnxCNELJDjXc0/1BhWkGY
        q/IYW+MKn4Tjs4uz5uEn1RpgcsvnW+Sz2NjMicSN7Q==
X-Google-Smtp-Source: ABdhPJzk/tqIUvkT/+lRnqF2/87jws3xp9TGgijlSnku7fw8B2GOkgwDvPruEYich6TykilQINnAL5XxzzoViuhPoV4=
X-Received: by 2002:a1c:98c6:: with SMTP id a189mr5184234wme.88.1611161879809;
 Wed, 20 Jan 2021 08:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <20210112074629.GG22493@dhcp22.suse.cz>
 <20210112174507.GA23780@redhat.com> <CAJuCfpFQz=x-LvONO3c4iqjKP4NKJMgUuiYc8HACKHAv1Omu0w@mail.gmail.com>
 <20210113142202.GC22493@dhcp22.suse.cz> <CAG48ez0=QSzuj96+5oVQ2qWqfjedv3oKtfEFzw--C8bzfvj7EQ@mail.gmail.com>
In-Reply-To: <CAG48ez0=QSzuj96+5oVQ2qWqfjedv3oKtfEFzw--C8bzfvj7EQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 20 Jan 2021 08:57:48 -0800
Message-ID: <CAJuCfpHb6PjTJBf67BZrBwSgbavKTeDz1S5bn9msEL4k8NtbVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Jann Horn <jannh@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jan 20, 2021 at 5:18 AM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Jan 13, 2021 at 3:22 PM Michal Hocko <mhocko@suse.com> wrote:
> > On Tue 12-01-21 09:51:24, Suren Baghdasaryan wrote:
> > > On Tue, Jan 12, 2021 at 9:45 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > On 01/12, Michal Hocko wrote:
> > > > >
> > > > > On Mon 11-01-21 09:06:22, Suren Baghdasaryan wrote:
> > > > >
> > > > > > What we want is the ability for one process to influence another process
> > > > > > in order to optimize performance across the entire system while leaving
> > > > > > the security boundary intact.
> > > > > > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > > > > > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > > > > > and CAP_SYS_NICE for influencing process performance.
> > > > >
> > > > > I have to say that ptrace modes are rather obscure to me. So I cannot
> > > > > really judge whether MODE_READ is sufficient. My understanding has
> > > > > always been that this is requred to RO access to the address space. But
> > > > > this operation clearly has a visible side effect. Do we have any actual
> > > > > documentation for the existing modes?
> > > > >
> > > > > I would be really curious to hear from Jann and Oleg (now Cced).
> > > >
> > > > Can't comment, sorry. I never understood these security checks and never tried.
> > > > IIUC only selinux/etc can treat ATTACH/READ differently and I have no idea what
> > > > is the difference.
>
> Yama in particular only does its checks on ATTACH and ignores READ,
> that's the difference you're probably most likely to encounter on a
> normal desktop system, since some distros turn Yama on by default.
> Basically the idea there is that running "gdb -p $pid" or "strace -p
> $pid" as a normal user will usually fail, but reading /proc/$pid/maps
> still works; so you can see things like detailed memory usage
> information and such, but you're not supposed to be able to directly
> peek into a running SSH client and inject data into the existing SSH
> connection, or steal the cryptographic keys for the current
> connection, or something like that.
>
> > > I haven't seen a written explanation on ptrace modes but when I
> > > consulted Jann his explanation was:
> > >
> > > PTRACE_MODE_READ means you can inspect metadata about processes with
> > > the specified domain, across UID boundaries.
> > > PTRACE_MODE_ATTACH means you can fully impersonate processes with the
> > > specified domain, across UID boundaries.
> >
> > Maybe this would be a good start to document expectations. Some more
> > practical examples where the difference is visible would be great as
> > well.
>
> Before documenting the behavior, it would be a good idea to figure out
> what to do with perf_event_open(). That one's weird in that it only
> requires PTRACE_MODE_READ, but actually allows you to sample stuff
> like userspace stack and register contents (if perf_event_paranoid is
> 1 or 2). Maybe for SELinux things (and maybe also for Yama), there
> should be a level in between that allows fully inspecting the process
> (for purposes like profiling) but without the ability to corrupt its
> memory or registers or things like that. Or maybe perf_event_open()
> should just use the ATTACH mode.

Thanks for additional clarifications, Jann!
Just to clarify, the documentation I'm preparing is a man page for
process_madvise(2) which will list the required capabilities but won't
dive into all the security details.
I believe the above suggestions are for documenting different PTRACE
modes and will not be included in that man page. Maybe a separate
document could do that but I'm definitely not qualified to write it.
