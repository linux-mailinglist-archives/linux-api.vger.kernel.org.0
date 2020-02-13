Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5415B5D5
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 01:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgBMA2j (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 19:28:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:61665 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgBMA2j (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 12 Feb 2020 19:28:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 16:28:38 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="227049991"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 16:28:38 -0800
Message-ID: <ae381f0c96c5a21c9e378d3c93cd819a77b3c0df.camel@linux.intel.com>
Subject: Re: [PATCH v4 8/8] mm: support both pid and pidfd for
 process_madvise
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
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
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Date:   Wed, 12 Feb 2020 16:28:37 -0800
In-Reply-To: <20200212233946.246210-9-minchan@kernel.org>
References: <20200212233946.246210-1-minchan@kernel.org>
         <20200212233946.246210-9-minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 2020-02-12 at 15:39 -0800, Minchan Kim wrote:
> There is a demand[1] to support pid as well pidfd for process_madvise
> to reduce unnecessary syscall to get pidfd if the user has control of
> the target process(ie, they could guarantee the process is not gone
> or pid is not reused. Or, it might be okay to give a hint to wrong
> process).
> 
> This patch aims for supporting both options like waitid(2). So, the
> syscall is currently,
> 
> 	int process_madvise(int which, pid_t pid, void *addr,
> 		size_t length, int advise, unsigned long flag);
> 
> @which is actually idtype_t for userspace libray and currently,
> it supports P_PID and P_PIDFD.
> 
> [1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
> 
> Cc: Christian Brauner <christian@brauner.io>
> Suggested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

So if you move patch 7 up before patch 2 you could squash this patch with
your current patch 2 and drop one patch from your series. It would
probably help to reduce the review overhead as well.

