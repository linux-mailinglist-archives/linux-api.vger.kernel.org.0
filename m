Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2917BB56
	for <lists+linux-api@lfdr.de>; Fri,  6 Mar 2020 12:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFLOY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Mar 2020 06:14:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:43826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgCFLOY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 6 Mar 2020 06:14:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E631BB1D1;
        Fri,  6 Mar 2020 11:14:21 +0000 (UTC)
Subject: Re: [PATCH v7 5/7] mm: support both pid and pidfd for process_madvise
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
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-6-minchan@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <14089609-5fb1-b082-716f-c2e129d27c48@suse.cz>
Date:   Fri, 6 Mar 2020 12:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302193630.68771-6-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/2/20 8:36 PM, Minchan Kim wrote:
> There is a demand[1] to support pid as well pidfd for process_madvise
> to reduce unnecessary syscall to get pidfd if the user has control of
> the target process(ie, they could guarantee the process is not gone
> or pid is not reused).
> 
> This patch aims for supporting both options like waitid(2). So, the
> syscall is currently,
> 
> 	int process_madvise(int which, pid_t pid, void *addr,
> 		size_t length, int advise, unsigned long flag);

This is again halfway between kernel and userspace description, so if we stick
to userspace then it's:

 	int process_madvise(idtype_t idtype, id_t id, void *addr,
 		size_t length, int advice, unsigned long flags);


> @which is actually idtype_t for userspace libray and currently,
> it supports P_PID and P_PIDFD.
> 
> [1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
> 
> Cc: Christian Brauner <christian@brauner.io>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
