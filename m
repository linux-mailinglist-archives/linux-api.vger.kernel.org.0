Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED0D303F5A
	for <lists+linux-api@lfdr.de>; Tue, 26 Jan 2021 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405547AbhAZNxr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 08:53:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:51562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405524AbhAZNxo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 26 Jan 2021 08:53:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611669176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eq0eIxGFaOAtL0zlId1JHPNVaLrojruOSnd68XSBtBQ=;
        b=CyfrVNC7X2pzMVUtodZD8Q54ECXgj72/vBxcKX6o/p/ycRnIOVXjr9PY7SVSh2qANeS7X8
        tkNB7fGLi3QHWICIfDRlqoCG22/m9GfM9TnKGLTAXs6AKQerEbtX3eSn2ePgE87q5qKOvg
        a5PlvteXw8R4Jgyq8X/1YK/mMJkFWkQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72D54AEAC;
        Tue, 26 Jan 2021 13:52:56 +0000 (UTC)
Date:   Tue, 26 Jan 2021 14:52:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jann Horn <jannh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Edgar Arriaga =?iso-8859-1?Q?Garc=EDa?= 
        <edgararriaga@google.com>, Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for
 process_madvise
Message-ID: <20210126135254.GP827@dhcp22.suse.cz>
References: <20210111170622.2613577-1-surenb@google.com>
 <20210112074629.GG22493@dhcp22.suse.cz>
 <20210112174507.GA23780@redhat.com>
 <CAJuCfpFQz=x-LvONO3c4iqjKP4NKJMgUuiYc8HACKHAv1Omu0w@mail.gmail.com>
 <20210113142202.GC22493@dhcp22.suse.cz>
 <CAG48ez0=QSzuj96+5oVQ2qWqfjedv3oKtfEFzw--C8bzfvj7EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0=QSzuj96+5oVQ2qWqfjedv3oKtfEFzw--C8bzfvj7EQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 20-01-21 14:17:39, Jann Horn wrote:
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

Thanks for the clarification. I still cannot say I would have a good
mental picture. Having something in Documentation/core-api/ sounds
really needed. Wrt to perf_event_open it sounds really odd it can do
more than other places restrict indeed. Something for the respective
maintainer but I strongly suspect people simply copy the pattern from
other places because the expected semantic is not really clear.

-- 
Michal Hocko
SUSE Labs
