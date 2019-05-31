Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4FC30AA7
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfEaIus (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 04:50:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:56026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbfEaIur (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 31 May 2019 04:50:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BDD5AF55;
        Fri, 31 May 2019 08:50:46 +0000 (UTC)
Date:   Fri, 31 May 2019 10:50:44 +0200
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
Subject: Re: [RFCv2 3/6] mm: introduce MADV_PAGEOUT
Message-ID: <20190531085044.GJ6896@dhcp22.suse.cz>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-4-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531064313.193437-4-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 31-05-19 15:43:10, Minchan Kim wrote:
> When a process expects no accesses to a certain memory range
> for a long time, it could hint kernel that the pages can be
> reclaimed instantly but data should be preserved for future use.
> This could reduce workingset eviction so it ends up increasing
> performance.
> 
> This patch introduces the new MADV_PAGEOUT hint to madvise(2)
> syscall. MADV_PAGEOUT can be used by a process to mark a memory
> range as not expected to be used for a long time so that kernel
> reclaims the memory instantly. The hint can help kernel in deciding
> which pages to evict proactively.

Again, are there any restictions on what kind of memory can be paged out?
Private/Shared, anonymous/file backed. Any restrictions on mapping type.
Etc. Please make sure all that is in the changelog.

What are the failure modes? E.g. what if the swap is full, does the call
fails or it silently ignores the error?

Thanks!
-- 
Michal Hocko
SUSE Labs
