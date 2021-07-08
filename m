Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E63BF568
	for <lists+linux-api@lfdr.de>; Thu,  8 Jul 2021 08:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhGHGRz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Jul 2021 02:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbhGHGRz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Jul 2021 02:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625724913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8YasAVCpavxdsfrgxlAmh4c2bWRou5hFo57Bl7Ztan4=;
        b=WHYAXO+dN3TYhrgwTvnF8UCz4tPYzSnMPbyLoKFRg1OMJ89ftj24TciZkZlR3S/dKxc/tv
        6pcF/WlIbTyHRqUC+BANL/hzHHIeuwTckVZrimgGVbNe5s9aNygPCnhSHS6d3jgOEiN4CC
        e6HAGi2fbk4WfHzTSs9+3zS6m+GXoMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-yQCV1ahBNsybJ24IYZFf3g-1; Thu, 08 Jul 2021 02:15:11 -0400
X-MC-Unique: yQCV1ahBNsybJ24IYZFf3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17730100C660;
        Thu,  8 Jul 2021 06:15:09 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31C0460854;
        Thu,  8 Jul 2021 06:14:56 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
References: <20210623192822.3072029-1-surenb@google.com>
        <87sg0qa22l.fsf@oldenburg.str.redhat.com>
        <CAJuCfpEWpvw+gW+NvBPOdGqUOEyucFoT8gdC2uk18dMBQFbhqw@mail.gmail.com>
        <87wnq1z7kl.fsf@oldenburg.str.redhat.com>
        <CAJuCfpFt55Dw1uW3S6_AincNfPaAtwdi6iXYVvFr7x3fvt4uzw@mail.gmail.com>
Date:   Thu, 08 Jul 2021 08:14:54 +0200
In-Reply-To: <CAJuCfpFt55Dw1uW3S6_AincNfPaAtwdi6iXYVvFr7x3fvt4uzw@mail.gmail.com>
        (Suren Baghdasaryan's message of "Wed, 7 Jul 2021 23:05:57 -0700")
Message-ID: <87zguxxrfl.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Suren Baghdasaryan:

> On Wed, Jul 7, 2021 at 10:41 PM Florian Weimer <fweimer@redhat.com> wrote:
>>
>> * Suren Baghdasaryan:
>>
>> > On Wed, Jul 7, 2021 at 2:47 AM Florian Weimer <fweimer@redhat.com> wro=
te:
>> >>
>> >> * Suren Baghdasaryan:
>> >>
>> >> > The API is as follows,
>> >> >
>> >> >           int process_reap(int pidfd, unsigned int flags);
>> >> >
>> >> >         DESCRIPTION
>> >> >           The process_reap() system call is used to free the memory=
 of a
>> >> >           dying process.
>> >> >
>> >> >           The pidfd selects the process referred to by the PID file
>> >> >           descriptor.
>> >> >           (See pidofd_open(2) for further information)
>> >> >
>> >> >           The flags argument is reserved for future use; currently,=
 this
>> >> >           argument must be specified as 0.
>> >> >
>> >> >         RETURN VALUE
>> >> >           On success, process_reap() returns 0. On error, -1 is ret=
urned
>> >> >           and errno is set to indicate the error.
>> >>
>> >> I think the manual page should mention what it means for a process to=
 be
>> >> =E2=80=9Cdying=E2=80=9D, and how to move a process to this state.
>> >
>> > Thanks for the suggestion, Florian! Would replacing "dying process"
>> > with "process which was sent a SIGKILL signal" be sufficient?
>>
>> That explains very clearly the requirement, but it raises the question
>> why this isn't an si_code flag for rt_sigqueueinfo, reusing the existing
>> system call.
>
> I think you are suggesting to use sigqueue() to deliver the signal and
> perform the reaping when a special value accompanies it. This would be
> somewhat similar to my early suggestion to use a flag in
> pidfd_send_signal() (see:
> https://lore.kernel.org/patchwork/patch/1060407) to implement memory
> reaping which has another advantage of operation on PIDFDs instead of
> PIDs which can be recycled.
> kill()/pidfd_send_signal()/sigqueue() are supposed to deliver the
> signal and return without blocking. Changing that behavior was
> considered unacceptable in these discussions.

Does this mean that you need two threads, one that sends SIGKILL, and
one that calls process_reap?  Given that sending SIGKILL is blocking
with the existing interfaces?

Please also note that asynchronous deallocation of resources leads to
bugs and can cause unrelated workloads to fail.  For example, in some
configurations, clone can fail with EAGAIN even in cases where the total
number of tasks is clearly bounded because the kernel signals task exit
to applications before all resources are deallocated.  I'm worried that
the new interface makes things quite a bit worse in this regard.

Thanks,
Florian

