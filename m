Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294D83BF543
	for <lists+linux-api@lfdr.de>; Thu,  8 Jul 2021 07:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhGHFoA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Jul 2021 01:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229593AbhGHFoA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Jul 2021 01:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625722878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1q1GzSSargcyAtgTNwOM0FZXkXUZDLZ+n4JlGr4Nm8=;
        b=RRNqFHeUAVpMGyXgj8mdJJEPMfSxmv/WY6/XeK9xF4UWbn92pikd6SSDVJk040SJ3KixTa
        ouI+slRSjDbxkqjR8IIKxAPG51rZ53M5Di/sAFGQwqHPVSDqhsf9ctGJzmapmbql7+itKR
        uFc+/Ol/Dp+QTrgGY1uIS7hZ7oYHkhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-wtLBaRfVPLy05KoC9hwVRQ-1; Thu, 08 Jul 2021 01:41:17 -0400
X-MC-Unique: wtLBaRfVPLy05KoC9hwVRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE5A1084F4C;
        Thu,  8 Jul 2021 05:41:14 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB8CD5D9DD;
        Thu,  8 Jul 2021 05:41:00 +0000 (UTC)
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
Date:   Thu, 08 Jul 2021 07:40:58 +0200
In-Reply-To: <CAJuCfpEWpvw+gW+NvBPOdGqUOEyucFoT8gdC2uk18dMBQFbhqw@mail.gmail.com>
        (Suren Baghdasaryan's message of "Wed, 7 Jul 2021 14:07:15 -0700")
Message-ID: <87wnq1z7kl.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Suren Baghdasaryan:

> On Wed, Jul 7, 2021 at 2:47 AM Florian Weimer <fweimer@redhat.com> wrote:
>>
>> * Suren Baghdasaryan:
>>
>> > The API is as follows,
>> >
>> >           int process_reap(int pidfd, unsigned int flags);
>> >
>> >         DESCRIPTION
>> >           The process_reap() system call is used to free the memory of=
 a
>> >           dying process.
>> >
>> >           The pidfd selects the process referred to by the PID file
>> >           descriptor.
>> >           (See pidofd_open(2) for further information)
>> >
>> >           The flags argument is reserved for future use; currently, th=
is
>> >           argument must be specified as 0.
>> >
>> >         RETURN VALUE
>> >           On success, process_reap() returns 0. On error, -1 is return=
ed
>> >           and errno is set to indicate the error.
>>
>> I think the manual page should mention what it means for a process to be
>> =E2=80=9Cdying=E2=80=9D, and how to move a process to this state.
>
> Thanks for the suggestion, Florian! Would replacing "dying process"
> with "process which was sent a SIGKILL signal" be sufficient?

That explains very clearly the requirement, but it raises the question
why this isn't an si_code flag for rt_sigqueueinfo, reusing the existing
system call.

Thanks,
Florian

