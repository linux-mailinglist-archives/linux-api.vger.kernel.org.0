Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A18C1E136E
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbgEYRg0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 May 2020 13:36:26 -0400
Received: from mail.efficios.com ([167.114.26.124]:53764 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgEYRg0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 May 2020 13:36:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2C2622C438D;
        Mon, 25 May 2020 13:36:25 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pof2oeGh7p-k; Mon, 25 May 2020 13:36:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B18F92C3FE9;
        Mon, 25 May 2020 13:36:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B18F92C3FE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1590428184;
        bh=YJSgtXw/2qFLeYoA0bx8GuMUqdVH5+3SyAR99jrIWYo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nesYSIuGOlTOzlctV9A+1f5gZq2DmdqudCRB03TPV1bEKvSFKu2cBQKNMr6a+bwwS
         NwyKb2aIK8IjUApFkFY2X1F37HKFqfTQyCE+lqXj2fT+oxN8Rwi0MSKuE9TvEdKawU
         qR+WZMvl1Is57zHOM6IgolxJH3iDK1X1n6Ed919XEGfOmErqq318ynv8zFmciGe4qL
         GpM79nXHoPJm+FOa90ZjczwLfHTSCv12OvyK77ZyvIaVB3uH7evc3UVnSOfclgms1o
         0eIeOrAD+q+j927i6YLDkaBIq81S3YEwEvqXfSTDrJEw6ahjYyFWpTfrdSDgOvrE7N
         NanGh7fb/4zQA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zI1L57FqandZ; Mon, 25 May 2020 13:36:24 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9EDF52C3F76;
        Mon, 25 May 2020 13:36:24 -0400 (EDT)
Date:   Mon, 25 May 2020 13:36:24 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Message-ID: <108939265.33525.1590428184533.JavaMail.zimbra@efficios.com>
In-Reply-To: <87367ovy6k.fsf@oldenburg2.str.redhat.com>
References: <20200501021439.2456-1-mathieu.desnoyers@efficios.com> <20200501021439.2456-2-mathieu.desnoyers@efficios.com> <87v9kqbzse.fsf@oldenburg2.str.redhat.com> <941087675.33347.1590418305398.JavaMail.zimbra@efficios.com> <87367ovy6k.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v19)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v19)
Thread-Index: 6to34dl4ew/LNfoxYauNE9D4OCKBdw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On May 25, 2020, at 11:20 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> The larger question here is: considering that we re-implement the entire
>> uapi header within glibc (which includes the uptr addition), do we still
>> care about using the header provided by the Linux kernel ?
> 
> We don't care, but our users do.  Eventually, they want to include
> <sys/rseq.h> and <linux/rseq.h> to get new constants that are not yet
> known to glibc.

Good point!

> 
>> Having different definitions depending on whether a kernel header is
>> installed or not when including a glibc header seems rather unexpected.
> 
> Indeed.
> 
>> *If* we want to use the uapi header, I think something is semantically
>> missing. Here is the scheme I envision. We could rely on the kernel header
>> version.h to figure out which of glibc or kernel uapi header is more
>> recent. Any new concept we try to integrate into glibc (e.g. uptr)
>> should go into the upstream Linux uapi header first.
> 
> I think we should always prefer the uapi header.  The Linux version
> check does not tell you anything about backports.

Fair enough.

> 
>> For the coming glibc e.g. 2.32, we use the kernel uapi header if
>> kernel version is >= 4.18.0. Within glibc, the fallback implements
>> exactly the API exposed by the kernel rseq.h header.
> 
> Agreed.
> 
>> As we eventually introduce the uptr change into the Linux kernel, and
>> say it gets merged for Linux 5.9.0, we mirror this change into glibc
>> (e.g. release 2.33), and bump the Linux kernel version cutoff to 5.9.0.
>> So starting from that version, we use the Linux kernel header only if
>> version >= 5.9.0, else we fallback on glibc's own implementation.
> 
> Fortunately, we don't need to settle this today. 8-)
> 
> Let's stick to the 4.18 definitions for the fallback for now, and
> discuss the incorporation of future changes later.

OK

> 
>>>> +/* Ensure the compiler supports __attribute__ ((aligned)).  */
>>>> +_Static_assert (__alignof__ (struct rseq_cs) >= 32, "alignment");
>>>> +_Static_assert (__alignof__ (struct rseq) >= 32, "alignment");
>>> 
>>> This needs #ifndef __cplusplus or something like that.  I'm surprised
>>> that this passes the installed header tests.
>>
>> Would the following be ok ?
>>
>> #ifdef __cplusplus
>> #define rseq_static_assert      static_assert
>> #else
>> #define rseq_static_assert      _Static_assert
>> #endif
>>
>> /* Ensure the compiler supports __attribute__ ((aligned)).  */
>> rseq_static_assert (__alignof__ (struct rseq_cs) >= 32, "alignment");
>> rseq_static_assert (__alignof__ (struct rseq) >= 32, "alignment");
> 
> Seems reasonable, yes.  __alignof__ is still a GCC extension.  C++11 has
> alignof, C11 has _Alignof.  So you could use something like this
> (perhaps without indentation for the kernel header version):
> 
> #ifdef __cplusplus
> # if  __cplusplus >= 201103L
> #  define rseq_static_assert(x)      static_assert x;
> #  define rseq_alignof alignof
> # endif
> #elif __STDC_VERSION__ >= 201112L
> # define rseq_static_assert(x)      _Static_assert x;
> # define rseq_alignof _Alignof
> #endif
> #ifndef rseq_static_assert
> # define rseq_static_assert /* nothing */
> #endif
> rseq_static_assert ((rseq_alignof__ (struct rseq_cs) >= 32, "alignment"))
> rseq_static_assert ((rseq_alignof (struct rseq) >= 32, "alignment"))

Something like this ?

#ifdef __cplusplus
# if  __cplusplus >= 201103L
#  define rseq_static_assert (expr, diagnostic)         static_assert (expr, diagnostic)
#  define rseq_alignof                                  alignof
# endif
#elif __STDC_VERSION__ >= 201112L
# define rseq_static_assert (expr, diagnostic)          _Static_assert (expr, diagnostic)
# define rseq_alignof                                   _Alignof
#endif

#ifndef rseq_static_assert
# define rseq_static_assert (expr, diagnostic)          /* nothing */
#endif

/* Ensure the compiler supports __attribute__ ((aligned)).  */
rseq_static_assert ((rseq_alignof (struct rseq_cs) >= 32, "alignment"));
rseq_static_assert ((rseq_alignof (struct rseq) >= 32, "alignment"));

> And something similar for _Alignas/attribute aligned,

I don't see where _Alignas is needed here ?

For attribute aligned, what would be the oldest supported C and C++
standards ?

> with an error for
> older standards and !__GNUC__ compilers (because neither the type nor
> __thread can be represented there).

By "type" you mean "struct rseq" here ? What does it contain that requires
a __GNUC__ compiler ?

About __thread, I recall other compilers have other means to declare it.
In liburcu, I end up with the following:

#if defined (__cplusplus) && (__cplusplus >= 201103L)
# define URCU_TLS_STORAGE_CLASS thread_local
#elif defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 201112L)
# define URCU_TLS_STORAGE_CLASS _Thread_local
#elif defined (_MSC_VER)
# define URCU_TLS_STORAGE_CLASS __declspec(thread)
#else
# define URCU_TLS_STORAGE_CLASS __thread
#endif

Would something along those lines be OK for libc ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
