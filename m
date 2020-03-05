Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C069917ADEF
	for <lists+linux-api@lfdr.de>; Thu,  5 Mar 2020 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgCESPO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Mar 2020 13:15:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:54440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgCESPO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 5 Mar 2020 13:15:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 15E96AE61;
        Thu,  5 Mar 2020 18:15:12 +0000 (UTC)
Subject: Re: [PATCH v7 2/7] mm: introduce external memory hinting API
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-3-minchan@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bc3f6bd5-f032-bcf5-a09f-556ab785c587@suse.cz>
Date:   Thu, 5 Mar 2020 19:15:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302193630.68771-3-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/2/20 8:36 PM, Minchan Kim wrote:
> There is usecase that System Management Software(SMS) want to give
> a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> in the case of Android, it is the ActivityManagerService.
> 
> It's similar in spirit to madvise(MADV_WONTNEED), but the information

You mean MADV_DONTNEED?

> required to make the reclaim decision is not known to the app.

This seems to be mixing up the differences between MADV_DONTNEED and
COLD/PAGEOUT and self-imposed vs external memory hints?

> Instead,
> it is known to the centralized userspace daemon(ActivityManagerService),
> and that daemon must be able to initiate reclaim on its own without
> any app involvement.
> 
> To solve the issue, this patch introduces a new syscall process_madvise(2).
> It uses pidfd of an external process to give the hint.
> 
>  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> 			unsigned long flag);

It's more common to call the argument 'flags' not 'flag'? The code seems to call
it flags. Also in line with madvise(2), the 'advise' argument should rather be
'advice'. This is more important for the manpage, but let's be consistent.

...

> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

For the core parts,
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
