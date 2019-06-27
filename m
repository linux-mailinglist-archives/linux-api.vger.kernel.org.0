Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D7584E8
	for <lists+linux-api@lfdr.de>; Thu, 27 Jun 2019 16:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF0OxG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 10:53:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:37520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfF0OxF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 27 Jun 2019 10:53:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C4A8AFBC;
        Thu, 27 Jun 2019 14:53:04 +0000 (UTC)
Date:   Thu, 27 Jun 2019 16:53:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 1/5] mm: introduce MADV_COLD
Message-ID: <20190627145302.GC5303@dhcp22.suse.cz>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-2-minchan@kernel.org>
 <343599f9-3d99-b74f-1732-368e584fa5ef@intel.com>
 <20190627140203.GB5303@dhcp22.suse.cz>
 <d9341eb3-08eb-3c2b-9786-00b8a4f59953@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9341eb3-08eb-3c2b-9786-00b8a4f59953@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 27-06-19 07:36:50, Dave Hansen wrote:
[...]
> For MADV_COLD, if we defined it like this, I think we could use it for
> both purposes (demotion and LRU movement):
> 
> 	Pages in the specified regions will be treated as less-recently-
> 	accessed compared to pages in the system with similar access
> 	frequencies.  In contrast to MADV_DONTNEED, the contents of the

you meant s@MADV_DONTNEED@MADV_FREE@ I suppose

> 	region are preserved.
> 
> It would be nice not to talk about reclaim at all since we're not
> promising reclaim per se.

Well, I guess this is just an implementation detail. MADV_FREE is really
only about aging. It is up to the kernel what to do during the reclaim
and the advice doesn't and shouldn't make any difference here.

Now MADV_PAGEOUT would be more tricky in that direction because it
defines an immediate action to page out the range. I do understand your
argument about NUMA unaware applications which might want to get
something like MADV_DEMOTE which would move a page to a secondary memory
(whatever that is) but I think this is asking for its own madvise.
MADV_PAGEOUT has a quite simple semnatic - move to the backing storage -
and I would rather not make it more complex.
-- 
Michal Hocko
SUSE Labs
