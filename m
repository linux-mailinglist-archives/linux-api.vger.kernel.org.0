Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2524842
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 08:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfEUGnq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 02:43:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:55498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbfEUGnq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 21 May 2019 02:43:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F1A5AD12;
        Tue, 21 May 2019 06:24:22 +0000 (UTC)
Date:   Tue, 21 May 2019 08:24:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 6/7] mm: extend process_madvise syscall to support vector
 arrary
Message-ID: <20190521062421.GD32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-7-minchan@kernel.org>
 <20190520092258.GZ6836@dhcp22.suse.cz>
 <20190521024820.GG10039@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521024820.GG10039@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 21-05-19 11:48:20, Minchan Kim wrote:
> On Mon, May 20, 2019 at 11:22:58AM +0200, Michal Hocko wrote:
> > [Cc linux-api]
> > 
> > On Mon 20-05-19 12:52:53, Minchan Kim wrote:
> > > Currently, process_madvise syscall works for only one address range
> > > so user should call the syscall several times to give hints to
> > > multiple address range.
> > 
> > Is that a problem? How big of a problem? Any numbers?
> 
> We easily have 2000+ vma so it's not trivial overhead. I will come up
> with number in the description at respin.

Does this really have to be a fast operation? I would expect the monitor
is by no means a fast path. The system call overhead is not what it used
to be, sigh, but still for something that is not a hot path it should be
tolerable, especially when the whole operation is quite expensive on its
own (wrt. the syscall entry/exit).

I am not saying we do not need a multiplexing API, I am just not sure
we need it right away. Btw. there was some demand for other MM syscalls
to provide a multiplexing API (e.g. mprotect), maybe it would be better
to handle those in one go?
-- 
Michal Hocko
SUSE Labs
