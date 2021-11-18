Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB24560F9
	for <lists+linux-api@lfdr.de>; Thu, 18 Nov 2021 17:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhKRQ5y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Nov 2021 11:57:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhKRQ5y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Nov 2021 11:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637254493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8TCilPmYUvQEj/36GfpyyLXNZ9Xg267LRKKj5hppHs=;
        b=XxYvC1pQW3/BYvKkF1wZ50RTb3mkgrTDvNOBcB0jDOf8Cxnys2lf3HBlArqOpWK9Df5EnL
        HlFuF4DBgHTO4RR7s8k6y2Hfq2GTaQkT/OSl3F5I2mu0pi3RMBXVYWe61m7pB/PKCDpTOx
        K4IFjvzo7n3LYiLF+NYgKUqlIDxyPQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-CVGxMyYvOLWI2w1SNTrqEw-1; Thu, 18 Nov 2021 11:54:49 -0500
X-MC-Unique: CVGxMyYvOLWI2w1SNTrqEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F305283DC10;
        Thu, 18 Nov 2021 16:54:47 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 327AB5F4F4;
        Thu, 18 Nov 2021 16:54:44 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-api <linux-api@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Rich Felker <dalias@libc.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: Bringing rseq back into glibc
References: <87wnl5u5rz.fsf@oldenburg.str.redhat.com>
        <233151767.18864.1637253179376.JavaMail.zimbra@efficios.com>
Date:   Thu, 18 Nov 2021 17:54:43 +0100
In-Reply-To: <233151767.18864.1637253179376.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 18 Nov 2021 11:32:59 -0500
        (EST)")
Message-ID: <87fsrtflpo.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Nov 18, 2021, at 5:17 AM, Florian Weimer fweimer@redhat.com wrote:
>
>> I would like to bring back rseq for glibc 2.35.
>
> That's excellent news ! Thanks for looking into this.
>
>> I propose the following steps:
>> 
>> 1. Enable rseq registration in glibc, for internal use only.  This time,
>>   put the rseq area into struct pthread, not into a initial-exec TLS
>>   symbol.  (This helps to avoid with initial-exec TLS bloat with dlopen
>>   and simplifies initialization somewhat.)
>
> That works for me.
>
>> 
>> 2. Add a tunable to disable rseq registration in glibc.  This way, if
>>   there is already an rseq user, it can be made to work again by
>>   setting the tunable.
>
> Out of curiosity, how is the glibc tunable exposed ? Can it be called
> from the application, or is it an environment variable which needs to
> be set before running the application ?

Today, it's an environment variable.

>> 3. Implement sched_getcpu on top of rseq.
>> 
>> 4. Add public symbols __rseq_abi_offset, __rseq_abi_size (currently 32
>>   or 0), __rseq_abi_flags (currently 0).  __rseq_abi_offset is the
>>   offset to add to the thread pointer (see __builtin_thread_pointer) to
>>   get to the rseq area.  They will be public ABI symbols.  These
>>   variables are initialized before user code runs, and changing the
>>   results in undefined behavior.
>
> Works for me. So if the Linux kernel eventually implements something along
> the lines of an extensible kTLS, we can could use that underneath.
>
> Small bike-shedding comment: I wonder if we want those public glibc
> symbols to be called "__rseq_abi_{offset,size,flags}", or if a name like
> "__ktls_{offset,size,flags}" might be more appropriate and future-proof
> from a glibc ABI standpoint ?

No, if the kTLS stuff arrives, it might have different sizes and
offsets, and the rseq area is just a slice of that.  So the numbers
could be different.  We could do things as you propose if rseq is
guaranteed to be at the start of the kernel area, always, but do we know
that yet?

Also, kTLS wille likely be called something else to avoid confusion with
Kernel Transport Layer Security.  That's another reason to stick with
__rseq_.

>> Steps 1 to 3 are backportable to previous glibc version, especially to
>> 2.34 with its integrated libpthread.
>
> So if we have an application or library already using rseq directly through
> the system call, upgrading glibc may cause it to fail. Arguably, no new
> symbol are exposed, so I guess it's OK with the backport guide-lines.
> My question here is: is it OK for a backported patch to break an
> application which uses the Linux kernel system calls directly ?

It depends. 8-)

I think we can get away with it because shipping software for deployment
on other people's system must have a fallback path for non-rseq mode
outside of specialized environments.  For the (hopefully) rare
exceptions, we'll provide the tunable setting.

We must have done it before with similar system calls (set_tid_address,
set_robust_list).  But system call design tends to avoid creating new
examples.  rseq is similar to set_tid_address and set_robust_list in
that more or less has to be this way, with the single-user property.
(Supporting multiple users is undesirable from a performance/complexity
perspective.)

>> Comments?  As I said, I'd like to bring these changes into glibc 2.35,
>> hopefully in early December.
>
> I won't have time to do the implementation effort myself this time due to
> other commitments, but I will try to free up some time for review. Feel
> free to grab whatever code you feel is useful from my earlier rseq
> integration patches (if any).

I plan to reuse the architecture-specific marker constants from your
version at least.  That's already going to save a lot of work.  Thanks.

Florian

