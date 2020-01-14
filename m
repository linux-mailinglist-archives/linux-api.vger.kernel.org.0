Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2994613B2EC
	for <lists+linux-api@lfdr.de>; Tue, 14 Jan 2020 20:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgANTWz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jan 2020 14:22:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32882 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgANTWz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jan 2020 14:22:55 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1irRm7-0000Fw-1E; Tue, 14 Jan 2020 19:22:51 +0000
Date:   Tue, 14 Jan 2020 20:22:50 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Minchan Kim <minchan@kernel.org>
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
Message-ID: <20200114192249.saweb3xxiex5h4ys@wittgenstein>
References: <20200110213433.94739-1-minchan@kernel.org>
 <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
 <20200113104256.5ujbplyec2sk4onn@wittgenstein>
 <20200113184408.GD110363@google.com>
 <20200113191046.2tidyvc544zvchek@wittgenstein>
 <20200114185944.GA178589@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200114185944.GA178589@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jan 14, 2020 at 10:59:44AM -0800, Minchan Kim wrote:
> Hi Christian,
> 
> On Mon, Jan 13, 2020 at 08:10:47PM +0100, Christian Brauner wrote:
> > On Mon, Jan 13, 2020 at 10:44:08AM -0800, Minchan Kim wrote:
> > > On Mon, Jan 13, 2020 at 11:42:57AM +0100, Christian Brauner wrote:
> > > > On Mon, Jan 13, 2020 at 11:47:11AM +0300, Kirill Tkhai wrote:
> > > 
> > > < snip >
> > > 
> > > > > > +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> > > > > > +		size_t, len_in, int, behavior, unsigned long, flags)
> > > > > 
> > > > > I don't like the interface. The fact we have pidfd does not mean,
> > > > > we have to use it for new syscalls always. A user may want to set
> > > > > madvise for specific pid from console and pass pid as argument.
> > > > > pidfd would be an overkill in this case.
> > > > > We usually call "kill -9 pid" from console. Why shouldn't process_madvise()
> > > > > allow this?
> > > > > 
> > > > > I suggent to extend first argument to work with both pid and pidfd.
> > > > > Look at what we have for waitid(idtype, id_t id, ...) for example:
> > > > > 
> > > > >        idtype == P_PID
> > > > >               Wait for the child whose process ID matches id.
> > > > > 
> > > > >        idtype == P_PIDFD (since Linux 5.4)
> > > > >               Wait for the child referred to by the PID file descriptor specified in id.  (See pidfd_open(2) for  further  information  on
> > > > >               PID file descriptors.)
> > > > > 
> > > > > We may use @flags argument for this.
> > > > 
> > > > Sorry for chiming in just a comment. Overall, I don't particularly care
> > > > how or if you integrate pidfd here. One thing I would like to point out
> > > > is that we're working on a patch to place new features under pidfd
> > > > specific flags. This e.g. means a pidfd would be only be able to be used
> > > > for madvise operations (or getfd operations) if it was created with that
> > > > specific flag set making it easier to share them with other processes.
> > > > So if you integrate them here I would be quite thankful if you target
> > > > the patchset for the v5.7 merge window, not for v5.6.
> > > 
> > > Hi Christian,
> > > Sorry but I couldn't understand your point.
> > > Could you clarify what you meant?
> > 
> > Hi Minchan,
> > 
> > Sure. When you create a pidfd, e.g. with clone3() and you'd wanted to
> > use it for madvise you'd need to set a flag like pidfd_cap_madvise or
> > pidfd_feature_madvise when you create the pidfd. Only if the pidfd was
> > created with that flag set could you use it with madvise (This does not
> > affect the permission checking you're performing here.). This has come
> > up a couple of times and becomes more relevant now that people keep
> > adding new features on top of pidfd and is similar to what we are now
> > doing with openat2().
> 
> Thanks for the explain. When I read discussion with you and Daniel, it's
> still vague for me that what's the outcome so that it could land onto
> v5.6.(If I miss something progress on other thread, sorry about that.)

I'll try to post patches soon.

> 
> I will keep Ccing you so that you may notice when this patchset could
> be merged(Please Cc me when you send your patchset for me to notice)
> So if we judge it's worth to integrate, maybe we could make a quick
> patch to use it or postpone a cycle to intergrate it if we have more
> time.

Yeah, that would be great!
It's unlikely that process_madvise() will land for v5.6 anyway since
it's quite late in the cycle, so we should have some time to coordinate.

Thanks!
Christian
