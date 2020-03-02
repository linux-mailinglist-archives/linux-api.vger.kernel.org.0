Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4B1765B5
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 22:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgCBVQU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 16:16:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgCBVQU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 2 Mar 2020 16:16:20 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A456F20873;
        Mon,  2 Mar 2020 21:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583183779;
        bh=1zHdXUwUuJKgz+S2bvIxUrqahpJf4qagshjRfd/2x6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZmcLe9uaAA2Qx+E2R23T0roasOLIwuwb4Ktw0FpDcq7IuHF0bxOc874A5Vgvyr/zN
         7shrL4WwoFYUXOCtUCrTkpJIO5vSMfYGlSp982jYZfyDSLtYt8Mn6YILc7T16dRdeY
         RmZOGzGZtOz3uiYbZUFBdNU6SItSYiMVo7NkrJvk=
Date:   Mon, 2 Mar 2020 13:16:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
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
Subject: Re: [PATCH v7 0/7] introduce memory hinting API for external
 process
Message-Id: <20200302131618.b0f9f0e76d53a69184321884@linux-foundation.org>
In-Reply-To: <20200302193630.68771-1-minchan@kernel.org>
References: <20200302193630.68771-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon,  2 Mar 2020 11:36:23 -0800 Minchan Kim <minchan@kernel.org> wrote:

> Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> application could give hints to kernel what memory range are preferred to be
> reclaimed. However, in some platform(e.g., Android), the information
> required to make the hinting decision is not known to the app.
> Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> and that daemon must be able to initiate reclaim on its own without any app
> involvement.
> 
> To solve the concern, this patch introduces new syscall - process_madvise(2).
> Bascially, it's same with madvise(2) syscall but it has some differences.
> 
> 1. It needs pidfd of target process to provide the hint
> 2. It supports only MADV_{COLD|PAGEOUT|MERGEABLE|UNMEREABLE} at this moment.
>    Other hints in madvise will be opened when there are explicit requests from
>    community to prevent unexpected bugs we couldn't support.
> 3. Only privileged processes can do something for other process's address
>    space.
> 
> For more detail of the new API, please see "mm: introduce external memory hinting API"
> description in this patchset.

Thanks, I grabbed these.

I massaged the patch titles significantly - mainly to alert readers to
the fact that we're proposing a new syscall.

Is a manpage for process_madvise(2) being prepared?
