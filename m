Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6F213B281
	for <lists+linux-api@lfdr.de>; Tue, 14 Jan 2020 19:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgANS7t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jan 2020 13:59:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45355 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANS7s (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jan 2020 13:59:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so6794042pgk.12;
        Tue, 14 Jan 2020 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLdWsGP0XHWGCxqVZhBLWctk+c6rDeF6k4vcD9DPHeI=;
        b=i2esJgOGFaemeAJAp/5QuOJMkYpdkKC+BLVc3D4N2IEPIwfcCJcCSPc/Rp3CxvQcSX
         8kRFU0HiBO9tAtgVGddZGvBf66yxgIoiUP2gAFr9YIvFs3e1tJCgnaRRF3+HT3F6hCVX
         HQUUXaaol4cLeN7aKj8yFkgcOpznc1FoOoXd6AeqMXb4zSwz+GxGgcMO6ULnsUFnZfTQ
         +uWHsyf5dvD13xhpYMo/FUR/Rs3U11m8KLSDY1X1u9UZAfhcWHvVfUfIqeJXH4qpKJlE
         eZubYzsEvAnrRoY2zi3DmJb8WFDVO05RQQDJ1WGC8Lz+Fj0k2Jc/8s24Ix0/pXV9Txhr
         WSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLdWsGP0XHWGCxqVZhBLWctk+c6rDeF6k4vcD9DPHeI=;
        b=ovedxxpPXWGQvjcoTKshv6FTrNjOdkkdtPvUhdz7a2mDUPHojs3o/PvhIrF2rl+BZn
         M/GavCm/LOdmmmsViPo1MG7xJ5Gge6dNZTA9QeQEy932gDu11//qWTRQQJFmqrvKGsvr
         twb/eIs0JGB+/96RyTpMIUxk5OXQZ7PrS1osa+e+W3mB1YeIWQxqpF6wHgfbqTStVuxt
         b0Qf6B299mfGIPBkDRc3mYtz64UxqZpjme496qRPttpqcOiR4BWStzoCAEfKkDDDIqAJ
         dDy+BoAftl4OMqsfGgUkbjV7D+abmPZxGnPL7+1tgE85lR2DoD4O7Hq+RhqIUUEPwu0F
         VGzw==
X-Gm-Message-State: APjAAAWjESv2HwnwR2JTJq8gF3kZh8ZpeUhWcWtEf24erj2FcCgzo8Zt
        0M5eX7BkpjNdamfO4ebRl/A=
X-Google-Smtp-Source: APXvYqy/N+z69PG6y7Ebj6znXULG+UpZs19rlNT7fvG0Mt2TmO28ChC4a53hBPhfkDlB2m58VsHirQ==
X-Received: by 2002:a63:ed56:: with SMTP id m22mr28041543pgk.261.1579028387395;
        Tue, 14 Jan 2020 10:59:47 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id b4sm19392543pfd.18.2020.01.14.10.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:59:46 -0800 (PST)
Date:   Tue, 14 Jan 2020 10:59:44 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
Message-ID: <20200114185944.GA178589@google.com>
References: <20200110213433.94739-1-minchan@kernel.org>
 <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
 <20200113104256.5ujbplyec2sk4onn@wittgenstein>
 <20200113184408.GD110363@google.com>
 <20200113191046.2tidyvc544zvchek@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113191046.2tidyvc544zvchek@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Christian,

On Mon, Jan 13, 2020 at 08:10:47PM +0100, Christian Brauner wrote:
> On Mon, Jan 13, 2020 at 10:44:08AM -0800, Minchan Kim wrote:
> > On Mon, Jan 13, 2020 at 11:42:57AM +0100, Christian Brauner wrote:
> > > On Mon, Jan 13, 2020 at 11:47:11AM +0300, Kirill Tkhai wrote:
> > 
> > < snip >
> > 
> > > > > +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> > > > > +		size_t, len_in, int, behavior, unsigned long, flags)
> > > > 
> > > > I don't like the interface. The fact we have pidfd does not mean,
> > > > we have to use it for new syscalls always. A user may want to set
> > > > madvise for specific pid from console and pass pid as argument.
> > > > pidfd would be an overkill in this case.
> > > > We usually call "kill -9 pid" from console. Why shouldn't process_madvise()
> > > > allow this?
> > > > 
> > > > I suggent to extend first argument to work with both pid and pidfd.
> > > > Look at what we have for waitid(idtype, id_t id, ...) for example:
> > > > 
> > > >        idtype == P_PID
> > > >               Wait for the child whose process ID matches id.
> > > > 
> > > >        idtype == P_PIDFD (since Linux 5.4)
> > > >               Wait for the child referred to by the PID file descriptor specified in id.  (See pidfd_open(2) for  further  information  on
> > > >               PID file descriptors.)
> > > > 
> > > > We may use @flags argument for this.
> > > 
> > > Sorry for chiming in just a comment. Overall, I don't particularly care
> > > how or if you integrate pidfd here. One thing I would like to point out
> > > is that we're working on a patch to place new features under pidfd
> > > specific flags. This e.g. means a pidfd would be only be able to be used
> > > for madvise operations (or getfd operations) if it was created with that
> > > specific flag set making it easier to share them with other processes.
> > > So if you integrate them here I would be quite thankful if you target
> > > the patchset for the v5.7 merge window, not for v5.6.
> > 
> > Hi Christian,
> > Sorry but I couldn't understand your point.
> > Could you clarify what you meant?
> 
> Hi Minchan,
> 
> Sure. When you create a pidfd, e.g. with clone3() and you'd wanted to
> use it for madvise you'd need to set a flag like pidfd_cap_madvise or
> pidfd_feature_madvise when you create the pidfd. Only if the pidfd was
> created with that flag set could you use it with madvise (This does not
> affect the permission checking you're performing here.). This has come
> up a couple of times and becomes more relevant now that people keep
> adding new features on top of pidfd and is similar to what we are now
> doing with openat2().

Thanks for the explain. When I read discussion with you and Daniel, it's
still vague for me that what's the outcome so that it could land onto
v5.6.(If I miss something progress on other thread, sorry about that.)

I will keep Ccing you so that you may notice when this patchset could
be merged(Please Cc me when you send your patchset for me to notice)
So if we judge it's worth to integrate, maybe we could make a quick
patch to use it or postpone a cycle to intergrate it if we have more
time.

Thanks.
