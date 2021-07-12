Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9193C637D
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 21:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbhGLTTX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 15:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhGLTTX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 15:19:23 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D2C0613DD;
        Mon, 12 Jul 2021 12:16:34 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 63C0659F3A1E9; Mon, 12 Jul 2021 21:16:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 5F16460E710FD;
        Mon, 12 Jul 2021 21:16:33 +0200 (CEST)
Date:   Mon, 12 Jul 2021 21:16:33 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Suren Baghdasaryan <surenb@google.com>
cc:     Florian Weimer <fweimer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
In-Reply-To: <CAJuCfpF6v9QMzo81kn9zT1VEftKTHsot1ytE8Gfh3UZzqZ9WBA@mail.gmail.com>
Message-ID: <o4sq1573-2715-rs9-11qp-2nq016nr68n2@vanv.qr>
References: <20210623192822.3072029-1-surenb@google.com> <87sg0qa22l.fsf@oldenburg.str.redhat.com> <CAJuCfpEWpvw+gW+NvBPOdGqUOEyucFoT8gdC2uk18dMBQFbhqw@mail.gmail.com> <87wnq1z7kl.fsf@oldenburg.str.redhat.com> <CAJuCfpFt55Dw1uW3S6_AincNfPaAtwdi6iXYVvFr7x3fvt4uzw@mail.gmail.com>
 <q2s48op3-n660-p8r4-op50-po43r2249r24@vanv.qr> <CAJuCfpF6v9QMzo81kn9zT1VEftKTHsot1ytE8Gfh3UZzqZ9WBA@mail.gmail.com>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On Monday 2021-07-12 20:39, Suren Baghdasaryan wrote:
>>
>> The way I understood the request is that a userspace program (or perhaps two,
>> if so desired) should issue _two_ calls, one to deliver the signal,
>> one to perform the reap portion:
>>
>>         uinfo.si_code = SI_QUEUE;
>>         sigqueue(pid, SIGKILL, &uinfo);
>>         uinfo.si_code = SI_REAP;
>>         sigqueue(pid, SIGKILL, &uinfo);
>
>This approach would still lead to the same discussion: by design,
>sigqueue/kill/pidfd_send_signal deliver the signal but do not wait for
>the signal to be processed by the recipient.

Oh, so the only reason not to do that is because there is some POSIX
specification that says the sigqueue API should be non-waiting for all
possible parameter values (with an implied "present and future
values!"), not because there's some hurdle to actually add a wait
inside within rt_sigqueueinfo if the REAP flag is set.
Gotcha.
