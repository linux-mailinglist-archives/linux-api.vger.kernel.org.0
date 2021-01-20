Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19D72FD1B4
	for <lists+linux-api@lfdr.de>; Wed, 20 Jan 2021 14:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbhATNXz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Jan 2021 08:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbhATNSs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Jan 2021 08:18:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9321BC0613CF
        for <linux-api@vger.kernel.org>; Wed, 20 Jan 2021 05:18:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b26so34080010lff.9
        for <linux-api@vger.kernel.org>; Wed, 20 Jan 2021 05:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEq8tBsSJotuDC8emCL/6gnLfDlNS7DjovwJhhjL6ms=;
        b=ULlMSelK9Ah0BMaovUHmsACU3A8+D692YYxmt2OYno3eGXN24zqnixuDonvFpZ2434
         yGSCIJLnb9rvtjhVV8XPX2nCR1tR5/W56AKUtGD1OkiGVo7IeB4jiaFQf7E/SPuBZCPk
         d4Lus8TY9Pvv6JwfYfacYCpF4wqkl22vCHCQTbwiluzAHo44vfyw87aw1bj7GxrJh8cR
         nZV9kGNYb8OxcaZ9Ql7C/WeH9v4zws6ASGW2+LqT3AtKKoJHzqc0nxsas+X7WZpY7KVr
         OAUDEHg2PDM3TgJfR2sQZHreqITp3VHs1U9nSDMrPkcdRevPf/w7OuV8CjENhYu9SBn6
         VcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEq8tBsSJotuDC8emCL/6gnLfDlNS7DjovwJhhjL6ms=;
        b=iqQ1lONGwfGMBFZEW/3iaNlEeDq822fEeECkTECnybhaXLdrTIp7HLCMWHiI/4+mB0
         RjKAihqAtE8ac1FCLkGQsysAsV+H24R1KgLvQ2FigngSukSh/bxIS4jzGEaJY/I0mHcP
         NdFMbOfUoCwDhvSrezCOIv3IMfBSKZ9skI42Cv5vdEYJf/IEhagb/psDo9ApPOAYEQw4
         eF2G98mhpSue/gXm54xVTd4pA+6UIQfIl9j0LZbdQ037NW/s6tKRcqI3ITsee5E0BwRy
         kcRtUtxxrMgFDzz+2b69z7LXagYDUoyrBYuAzRlRj8RIKubzXc8lsotMSP+h+pYL62ww
         CVOw==
X-Gm-Message-State: AOAM5336VZxQKN4bAx8M6zPfcWGKUChJDMUXPqAjxaBNZL2yZOTvBJLX
        I2TDNXS/3hQkaWXZsSyxchhRzB2jeDgq+DNYVp/wpQ==
X-Google-Smtp-Source: ABdhPJzqDqJvZXUcfXv4xFpgmlCE0aHWXWLar3aIIwchg7i4ldiK53CzSQfu3T1ZKIGVaiUK6Qge3/wJtkCQkY/hjps=
X-Received: by 2002:a19:8cb:: with SMTP id 194mr4180105lfi.463.1611148685415;
 Wed, 20 Jan 2021 05:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <20210112074629.GG22493@dhcp22.suse.cz>
 <20210112174507.GA23780@redhat.com> <CAJuCfpFQz=x-LvONO3c4iqjKP4NKJMgUuiYc8HACKHAv1Omu0w@mail.gmail.com>
 <20210113142202.GC22493@dhcp22.suse.cz>
In-Reply-To: <20210113142202.GC22493@dhcp22.suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Jan 2021 14:17:39 +0100
Message-ID: <CAG48ez0=QSzuj96+5oVQ2qWqfjedv3oKtfEFzw--C8bzfvj7EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
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

On Wed, Jan 13, 2021 at 3:22 PM Michal Hocko <mhocko@suse.com> wrote:
> On Tue 12-01-21 09:51:24, Suren Baghdasaryan wrote:
> > On Tue, Jan 12, 2021 at 9:45 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 01/12, Michal Hocko wrote:
> > > >
> > > > On Mon 11-01-21 09:06:22, Suren Baghdasaryan wrote:
> > > >
> > > > > What we want is the ability for one process to influence another process
> > > > > in order to optimize performance across the entire system while leaving
> > > > > the security boundary intact.
> > > > > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > > > > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > > > > and CAP_SYS_NICE for influencing process performance.
> > > >
> > > > I have to say that ptrace modes are rather obscure to me. So I cannot
> > > > really judge whether MODE_READ is sufficient. My understanding has
> > > > always been that this is requred to RO access to the address space. But
> > > > this operation clearly has a visible side effect. Do we have any actual
> > > > documentation for the existing modes?
> > > >
> > > > I would be really curious to hear from Jann and Oleg (now Cced).
> > >
> > > Can't comment, sorry. I never understood these security checks and never tried.
> > > IIUC only selinux/etc can treat ATTACH/READ differently and I have no idea what
> > > is the difference.

Yama in particular only does its checks on ATTACH and ignores READ,
that's the difference you're probably most likely to encounter on a
normal desktop system, since some distros turn Yama on by default.
Basically the idea there is that running "gdb -p $pid" or "strace -p
$pid" as a normal user will usually fail, but reading /proc/$pid/maps
still works; so you can see things like detailed memory usage
information and such, but you're not supposed to be able to directly
peek into a running SSH client and inject data into the existing SSH
connection, or steal the cryptographic keys for the current
connection, or something like that.

> > I haven't seen a written explanation on ptrace modes but when I
> > consulted Jann his explanation was:
> >
> > PTRACE_MODE_READ means you can inspect metadata about processes with
> > the specified domain, across UID boundaries.
> > PTRACE_MODE_ATTACH means you can fully impersonate processes with the
> > specified domain, across UID boundaries.
>
> Maybe this would be a good start to document expectations. Some more
> practical examples where the difference is visible would be great as
> well.

Before documenting the behavior, it would be a good idea to figure out
what to do with perf_event_open(). That one's weird in that it only
requires PTRACE_MODE_READ, but actually allows you to sample stuff
like userspace stack and register contents (if perf_event_paranoid is
1 or 2). Maybe for SELinux things (and maybe also for Yama), there
should be a level in between that allows fully inspecting the process
(for purposes like profiling) but without the ability to corrupt its
memory or registers or things like that. Or maybe perf_event_open()
should just use the ATTACH mode.
