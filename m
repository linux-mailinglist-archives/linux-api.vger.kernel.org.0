Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83E530A73
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 10:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfEaIiA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 04:38:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:53698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfEaIiA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 31 May 2019 04:38:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD507AC2E;
        Fri, 31 May 2019 08:37:58 +0000 (UTC)
Date:   Fri, 31 May 2019 10:37:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [RFCv2 5/6] mm: introduce external memory hinting API
Message-ID: <20190531083757.GH6896@dhcp22.suse.cz>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-6-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531064313.193437-6-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 31-05-19 15:43:12, Minchan Kim wrote:
> There is some usecase that centralized userspace daemon want to give
> a memory hint like MADV_[COLD|PAGEEOUT] to other process. Android's
> ActivityManagerService is one of them.
> 
> It's similar in spirit to madvise(MADV_WONTNEED), but the information
> required to make the reclaim decision is not known to the app. Instead,
> it is known to the centralized userspace daemon(ActivityManagerService),
> and that daemon must be able to initiate reclaim on its own without
> any app involvement.
> 
> To solve the issue, this patch introduces new syscall process_madvise(2).
> It could give a hint to the exeternal process of pidfd.
> 
>  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> 			unsigned long cookie, unsigned long flag);
> 
> Since it could affect other process's address range, only privileged
> process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> gives it the right to ptrace the process could use it successfully.
> 
> The syscall has a cookie argument to privode atomicity(i.e., detect
> target process's address space change since monitor process has parsed
> the address range of target process so the operaion could fail in case
> of happening race). Although there is no interface to get a cookie
> at this moment, it could be useful to consider it as argument to avoid
> introducing another new syscall in future. It could support *atomicity*
> for disruptive hint(e.g., MADV_DONTNEED|FREE).
> flag argument is reserved for future use if we need to extend the API.

Providing an API that is incomplete will not fly. Really. As this really
begs for much more discussion and it would be good to move on with the
core idea of the pro active memory memory management from userspace
usecase. Could you split out the core change so that we can move on and
leave the external for a later discussion. I believe this would lead to
a smoother integration.
-- 
Michal Hocko
SUSE Labs
