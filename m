Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7BA2B84EE
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 20:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgKRTcg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 14:32:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:45126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgKRTcg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Nov 2020 14:32:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605727954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qq+4RUIWTIRJUQsDUMjDphUgg4rSNzYU7mlJ5rkVEAA=;
        b=GHWJLGFHsuhg/s44OiNkL94AFNh0MLAJN9QkVvkm7T9NTz0yi+StlesXpSZ2D+xmtu5u33
        auEJYHzr9zrA6MO2TkX6NP3P96NjtgiCeeaPL/9G08WkSicJlzsoY4npGdhg1N+4htBKRj
        hseLF8fZb2Tf/bBo6FZizbu09Yxij3Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99EB7BDF3;
        Wed, 18 Nov 2020 19:32:34 +0000 (UTC)
Date:   Wed, 18 Nov 2020 20:32:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
Message-ID: <20201118193233.GV12284@dhcp22.suse.cz>
References: <20201113173448.1863419-1-surenb@google.com>
 <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
 <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
 <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
 <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
 <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
 <CAJuCfpH-Qjm5uqfaUcfk0QV2zC76uL96FQjd88bZGBvCuXE_aA@mail.gmail.com>
 <20201113181632.6d98489465430a987c96568d@linux-foundation.org>
 <20201118154334.GT12284@dhcp22.suse.cz>
 <CAJuCfpGC1Kv2rC7oq-TT2dX1soy5J_R+y6DU8xEzVuJgOqHKAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGC1Kv2rC7oq-TT2dX1soy5J_R+y6DU8xEzVuJgOqHKAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 18-11-20 11:22:21, Suren Baghdasaryan wrote:
> On Wed, Nov 18, 2020 at 11:10 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 13-11-20 18:16:32, Andrew Morton wrote:
> > [...]
> > > It's all sounding a bit painful (but not *too* painful).  But to
> > > reiterate, I do think that adding the ability for a process to shoot
> > > down a large amount of another process's memory is a lot more generally
> > > useful than tying it to SIGKILL, agree?
> >
> > I am not sure TBH. Is there any reasonable usecase where uncoordinated
> > memory tear down is OK and a target process which is able to see the
> > unmapped memory?
> 
> I think uncoordinated memory tear down is a special case which makes
> sense only when the target process is being killed (and we can enforce
> that by allowing MADV_DONTNEED to be used only if the target process
> has pending SIGKILL).

That would be safe but then I am wondering whether it makes sense to
implement as a madvise call. It is quite strange to expect somebody call
a syscall on a killed process. But this is more a detail. I am not a
great fan of a more generic MADV_DONTNEED on a remote process. This is
just too dangerous IMHO.

> However, the ability to apply other flavors of
> process_madvise() to large memory areas spanning multiple VMAs can be
> useful in more cases.

Yes I do agree with that. The error reporting would be more tricky but
I am not really sure that the exact reporting is really necessary for
advice like interface.

> For example in Android we will use
> process_madvise(MADV_PAGEOUT) to "shrink" an inactive background
> process.

That makes sense to me.
-- 
Michal Hocko
SUSE Labs
