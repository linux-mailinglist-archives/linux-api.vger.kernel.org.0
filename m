Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EA38C9C8
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbhEUPJq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbhEUPJp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 11:09:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF34C061574
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 08:08:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6D149153;
        Fri, 21 May 2021 15:08:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6D149153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1621609701; bh=V2vNepzONuwsPQWA23na/dx6eiWDxiiBVf3jQVQnBdM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=C+qfue6OZlEqHcXt1khYxZ4Cz/ChTOUbztfvYb0q2eOMpt5er1SUbdzcMDE596FMN
         Lf2Hdky4qdCaWkZi1nLRLGKEFCg2ikADuP9MlCo8T3APwnO/2gBp6eVj5D2zg0OJnl
         3dpLZTjsvVmxkOqH2uEWUzLvtfySwUBp+u/XfqjEU0FGvL1GczFSTtlLhZquuFSJlS
         FHDMVRLiZ4Fd5J8s73p6fJMhxHHjRam+C/SebSXWd7r6A4LBWhR3SZ/kmDOiOctnwa
         I68x3kKw6np7AiV8MSncLpJlkhVJegHuaSTgw9/xRM92I6n9sbUG86WL+zQcbP6Oip
         OiEl6llM6rqog==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
In-Reply-To: <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com>
References: <20210520183614.1227046-1-posk@google.com>
 <87mtspm7fe.fsf@meer.lwn.net>
 <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com>
Date:   Fri, 21 May 2021 09:08:20 -0600
Message-ID: <87eee0m8ez.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Oskolkov <posk@google.com> writes:

> On Thu, May 20, 2021 at 2:17 PM Jonathan Corbet <corbet@lwn.net> wrote:
>>
>> Peter Oskolkov <posk@google.com> writes:
>>
>> > As indicated earlier in the FUTEX_SWAP patchset:
>> >
>> > https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/
>> >
>> > "Google Fibers" is a userspace scheduling framework
>> > used widely and successfully at Google to improve in-process workload
>> > isolation and response latencies. We are working on open-sourcing
>> > this framework, and UMCG (User-Managed Concurrency Groups) kernel
>> > patches are intended as the foundation of this.
>>
>> So I have to ask...is there *any* documentation out there on what this
>> is and how people are supposed to use it?  Shockingly, typing "Google
>> fibers" into Google leads to a less than fully joyful outcome...  This
>> won't be easy for anybody to review if they have to start by
>> reverse-engineering what it's supposed to do.
>
> Hi Jonathan,
>
> There is this Linux Plumbers video: https://www.youtube.com/watch?v=KXuZi9aeGTw
> And the pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf
>
> I did not reference them in the patchset because links to sites other
> than kernel.org are strongly discouraged... I will definitely add a
> documentation patch.

I did look at those - but a presentation from 2013 is going to be of
limited relevance for a 2021 patch set.  In particular, the syscall API
appears to have evolved considerably since then.

> Feel free to reach out to me directly or through this LKML thread if
> you have any questions.
>
> Do you think a documentation patch would be useful at this point, as
> opposed to a free-form email discussion?

Documentation patches can help to guide that discussion; they also need
to be reviewed as well.  So yes, I think they should be present from the
beginning.  But then, that's the position I'm supposed to take :)  This
is a big change to the kernel's system-call API, I don't think that
there can be a proper discussion of that without a description of what
you're trying to do.

Thanks,

jon
