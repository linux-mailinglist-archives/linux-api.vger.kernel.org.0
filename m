Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1321330C9
	for <lists+linux-api@lfdr.de>; Tue,  7 Jan 2020 21:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgAGUoD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jan 2020 15:44:03 -0500
Received: from mail.efficios.com ([167.114.142.138]:42154 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGUoC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jan 2020 15:44:02 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2E119695809;
        Tue,  7 Jan 2020 15:44:01 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id fexXKIeQGx-B; Tue,  7 Jan 2020 15:44:00 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B5CC9695804;
        Tue,  7 Jan 2020 15:44:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B5CC9695804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1578429840;
        bh=a7PhLxRLqwPOptIFbATUjStQXS7bfiLqgNZX9c8LwXs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZKTM2S5itDu6Awve+O/mF1Z1DX5vlX2ILroe6oGF/dB6a5uk77biDynUJCbg6DwKw
         CcG9GRdAJUbcjRJxAZKIn1w4voCXUki4k9prXYFNO7xBzlWj0DjkgeKNVfLeMFgqsr
         MEXM27U+M6YgEKGvnyTsKrRS6f5Owl95uKOkmXLnioDJl4/VxFJqEi+brVtOJMNZdA
         S8wqlt1Brlo5Sic/hy1ZdLrh0mcLN+u+JC5PnWX0VhmDJwkPXfKvHp1oxr4es6KZFc
         2f9+s0YbRXUa0tF+ZQtdeut9RLk2EK8e6NYmAiq/XqrKYVHRBWxICRsgcyJX8C0gCs
         F87vrxZxFjXaA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 9XfQYqq71AKO; Tue,  7 Jan 2020 15:44:00 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9A43A6957F9;
        Tue,  7 Jan 2020 15:44:00 -0500 (EST)
Date:   Tue, 7 Jan 2020 15:44:00 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1968185366.4418.1578429840460.JavaMail.zimbra@efficios.com>
In-Reply-To: <871rsbv4io.fsf@oldenburg2.str.redhat.com>
References: <20200106155713.397-1-mathieu.desnoyers@efficios.com> <20200106155713.397-10-mathieu.desnoyers@efficios.com> <871rsbv4io.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH glibc 09/13] glibc: Perform rseq(2) registration at
 C startup and thread creation (v13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3894 (ZimbraWebClient - FF71 (Linux)/8.8.15_GA_3890)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v13)
Thread-Index: 64OzZkIvDax4zK6QCleAiCxTyBhzYA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



----- On Jan 7, 2020, at 7:23 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> Register rseq(2) TLS for each thread (including main), and unregister
>> for each thread (excluding main). "rseq" stands for Restartable
>> Sequences.
>>
>> See the rseq(2) man page proposed here:
>>   https://lkml.org/lkml/2018/9/19/647
>>
>> This patch is based on glibc-2.30. The rseq(2) system call was merged
>> into Linux 4.18.
> 
> This patch needs to be updated for some be/le abilist splits.
> Big-endian ABI lists for arm, microblaze, sh, appear to be missing.

done.

> This is something that can be checked with build-many-glibcs.py.

OK.

> 
>> diff --git a/manual/threads.texi b/manual/threads.texi
>> index 0858ef8f92..059f781120 100644
>> --- a/manual/threads.texi
>> +++ b/manual/threads.texi
>> @@ -881,3 +881,20 @@ Behaves like @code{pthread_timedjoin_np} except that the
>> absolute time in
>>  @c pthread_spin_unlock
>>  @c pthread_testcancel
>>  @c pthread_yield
>> +
>> +@node Restartable Sequences
>> +@section Restartable Sequences
>> +@cindex rseq
>> +
>> +This section describes the @glibcadj{} Restartable Sequences integration.
>> +
>> +The @glibcadj{} implements a __rseq_abi TLS symbol to interact with the
>   @Theglibc{}                  @code{__rseq_abi}
> 
> 
>> +Restartable Sequences system call (Linux-specific). The layout of this
>> +structure is defined by the Linux kernel rseq.h UAPI. Registration of each
>> +thread's __rseq_abi is performed by @glibcadj{} at libc initialization and
>                                       @theglibc{}
>           @code{__rseq_abi}
>> +pthread creation.
> 
>> +Each supported architecture provide a RSEQ_SIG signature in sys/rseq.h. That
>                                         @code{RSEQ_SIG}       @file{sys/rseq.h}
> 
>> +signature is expected to be present in the code before each Restartable
>> +Sequences abort handler. Failure to provide the expected signature may
>> +terminate the process with a Segmentation fault.
> 
> 
> Two spaces at the end of setences, please.

All above done.

> 
> The manual should use @deftypevar to create an index entry etc. for
> __rseq_abi.  See argp_program_version for an example of how to do this.

OK. I've added __rseq_abi as a variable and RSEQ_SIG as a macro.

> 
> I think current policy is to have documentation for at least the minimum
> functionality in the manual.  I understand that it makes it a lot of
> work to write patches which add system call wrappers.

Makes sense.

Thanks!

Mathieu

> 
> Thanks,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
