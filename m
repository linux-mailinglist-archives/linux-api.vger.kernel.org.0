Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5BE3C5CE1
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhGLNDG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 09:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhGLNDB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 09:03:01 -0400
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jul 2021 06:00:10 PDT
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04730C0613DD;
        Mon, 12 Jul 2021 06:00:10 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id EF829588A40E6; Mon, 12 Jul 2021 14:51:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id E9F8D60C36094;
        Mon, 12 Jul 2021 14:51:54 +0200 (CEST)
Date:   Mon, 12 Jul 2021 14:51:54 +0200 (CEST)
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
In-Reply-To: <CAJuCfpFt55Dw1uW3S6_AincNfPaAtwdi6iXYVvFr7x3fvt4uzw@mail.gmail.com>
Message-ID: <q2s48op3-n660-p8r4-op50-po43r2249r24@vanv.qr>
References: <20210623192822.3072029-1-surenb@google.com> <87sg0qa22l.fsf@oldenburg.str.redhat.com> <CAJuCfpEWpvw+gW+NvBPOdGqUOEyucFoT8gdC2uk18dMBQFbhqw@mail.gmail.com> <87wnq1z7kl.fsf@oldenburg.str.redhat.com>
 <CAJuCfpFt55Dw1uW3S6_AincNfPaAtwdi6iXYVvFr7x3fvt4uzw@mail.gmail.com>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On Thursday 2021-07-08 08:05, Suren Baghdasaryan wrote:
>>
>> That explains very clearly the requirement, but it raises the question
>> why this isn't an si_code flag for rt_sigqueueinfo, reusing the existing
>> system call.
>
>I think you are suggesting to use sigqueue() to deliver the signal and
>perform the reaping when a special value accompanies it. This would be
>somewhat similar to my early suggestion to use a flag in
>pidfd_send_signal() (see:
>https://lore.kernel.org/patchwork/patch/1060407) to implement memory
>reaping which has another advantage of operation on PIDFDs instead of
>PIDs which can be recycled.
>kill()/pidfd_send_signal()/sigqueue() are supposed to deliver the
>signal and return without blocking. Changing that behavior was
>considered unacceptable in these discussions.

The way I understood the request is that a userspace program (or perhaps two,
if so desired) should issue _two_ calls, one to deliver the signal,
one to perform the reap portion:

	uinfo.si_code = SI_QUEUE;
	sigqueue(pid, SIGKILL, &uinfo);
	uinfo.si_code = SI_REAP;
	sigqueue(pid, SIGKILL, &uinfo);
