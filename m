Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEFCA3022B
	for <lists+linux-api@lfdr.de>; Thu, 30 May 2019 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE3SrQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 May 2019 14:47:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfE3SrQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 May 2019 14:47:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96A02AD35;
        Thu, 30 May 2019 18:47:14 +0000 (UTC)
Date:   Thu, 30 May 2019 20:47:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC 6/7] mm: extend process_madvise syscall to support vector
 arrary
Message-ID: <20190530184713.GI6703@dhcp22.suse.cz>
References: <20190521024820.GG10039@google.com>
 <20190521062421.GD32329@dhcp22.suse.cz>
 <20190521102613.GC219653@google.com>
 <20190521103726.GM32329@dhcp22.suse.cz>
 <20190527074940.GB6879@google.com>
 <CAKOZuesK-8zrm1zua4dzqh4TEMivsZKiccySMvfBjOyDkg-MEw@mail.gmail.com>
 <20190529103352.GD18589@dhcp22.suse.cz>
 <20190530021748.GE229459@google.com>
 <20190530065755.GD6703@dhcp22.suse.cz>
 <20190530080214.GA159502@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530080214.GA159502@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 30-05-19 17:02:14, Minchan Kim wrote:
> On Thu, May 30, 2019 at 08:57:55AM +0200, Michal Hocko wrote:
> > On Thu 30-05-19 11:17:48, Minchan Kim wrote:
[...]
> > > First time, I didn't think about atomicity about address range race
> > > because MADV_COLD/PAGEOUT is not critical for the race.
> > > However you raised the atomicity issue because people would extend
> > > hints to destructive ones easily. I agree with that and that's why
> > > we discussed how to guarantee the race and Daniel comes up with good idea.
> > 
> > Just for the clarification, I didn't really mean atomicity but rather a
> > _consistency_ (essentially time to check to time to use consistency).
> 
> What do you mean by *consistency*? Could you elaborate it more?

That you operate on the object you have got by some means. In other
words that the range you want to call madvise on hasn't been
remapped/replaced by a different mmap operation.

-- 
Michal Hocko
SUSE Labs
