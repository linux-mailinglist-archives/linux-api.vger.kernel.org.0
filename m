Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487271E1189
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404085AbgEYPUb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 May 2020 11:20:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49976 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403996AbgEYPUb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 May 2020 11:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590420029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HYjKBsVG8/aQRDDWxnpTEgM4JQmNET1Q9YOObHs51wo=;
        b=T8I/C9fDoU/ROi3tZkI3ciQdHfZQXLRq0RDv/pNCdqsv3GLoFgJMX2p4ii5v7uckugTq3k
        U1hkpCit2aXvvHJI8DxS7BKk140wNFSlBnrJchLYEqKJJFpjA0MDL4rHFvgl3gkYNnxeaH
        NObu1xhLpdxYxD5cMMJcu/zvMGwc4Nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-c78kMZeNNO2R3tqKxuLtLA-1; Mon, 25 May 2020 11:20:27 -0400
X-MC-Unique: c78kMZeNNO2R3tqKxuLtLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92B0B80183C;
        Mon, 25 May 2020 15:20:24 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-121.ams2.redhat.com [10.36.112.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A4AB5798D;
        Mon, 25 May 2020 15:20:21 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup and thread creation (v19)
References: <20200501021439.2456-1-mathieu.desnoyers@efficios.com>
        <20200501021439.2456-2-mathieu.desnoyers@efficios.com>
        <87v9kqbzse.fsf@oldenburg2.str.redhat.com>
        <941087675.33347.1590418305398.JavaMail.zimbra@efficios.com>
Date:   Mon, 25 May 2020 17:20:19 +0200
In-Reply-To: <941087675.33347.1590418305398.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 25 May 2020 10:51:45 -0400
        (EDT)")
Message-ID: <87367ovy6k.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> The larger question here is: considering that we re-implement the entire
> uapi header within glibc (which includes the uptr addition), do we still
> care about using the header provided by the Linux kernel ?

We don't care, but our users do.  Eventually, they want to include
<sys/rseq.h> and <linux/rseq.h> to get new constants that are not yet
known to glibc.

> Having different definitions depending on whether a kernel header is
> installed or not when including a glibc header seems rather unexpected.

Indeed.

> *If* we want to use the uapi header, I think something is semantically
> missing. Here is the scheme I envision. We could rely on the kernel header
> version.h to figure out which of glibc or kernel uapi header is more
> recent. Any new concept we try to integrate into glibc (e.g. uptr)
> should go into the upstream Linux uapi header first.

I think we should always prefer the uapi header.  The Linux version
check does not tell you anything about backports.

> For the coming glibc e.g. 2.32, we use the kernel uapi header if
> kernel version is >= 4.18.0. Within glibc, the fallback implements
> exactly the API exposed by the kernel rseq.h header.

Agreed.

> As we eventually introduce the uptr change into the Linux kernel, and
> say it gets merged for Linux 5.9.0, we mirror this change into glibc
> (e.g. release 2.33), and bump the Linux kernel version cutoff to 5.9.0.
> So starting from that version, we use the Linux kernel header only if
> version >= 5.9.0, else we fallback on glibc's own implementation.

Fortunately, we don't need to settle this today. 8-)

Let's stick to the 4.18 definitions for the fallback for now, and
discuss the incorporation of future changes later.

>>> +/* Ensure the compiler supports __attribute__ ((aligned)).  */
>>> +_Static_assert (__alignof__ (struct rseq_cs) >= 32, "alignment");
>>> +_Static_assert (__alignof__ (struct rseq) >= 32, "alignment");
>> 
>> This needs #ifndef __cplusplus or something like that.  I'm surprised
>> that this passes the installed header tests.
>
> Would the following be ok ?
>
> #ifdef __cplusplus
> #define rseq_static_assert      static_assert
> #else
> #define rseq_static_assert      _Static_assert
> #endif
>
> /* Ensure the compiler supports __attribute__ ((aligned)).  */
> rseq_static_assert (__alignof__ (struct rseq_cs) >= 32, "alignment");
> rseq_static_assert (__alignof__ (struct rseq) >= 32, "alignment");

Seems reasonable, yes.  __alignof__ is still a GCC extension.  C++11 has
alignof, C11 has _Alignof.  So you could use something like this
(perhaps without indentation for the kernel header version):

#ifdef __cplusplus
# if  __cplusplus >= 201103L
#  define rseq_static_assert(x)      static_assert x;
#  define rseq_alignof alignof
# endif
#elif __STDC_VERSION__ >= 201112L
# define rseq_static_assert(x)      _Static_assert x;
# define rseq_alignof _Alignof
#endif
#ifndef rseq_static_assert
# define rseq_static_assert /* nothing */
#endif
rseq_static_assert ((rseq_alignof__ (struct rseq_cs) >= 32, "alignment"))
rseq_static_assert ((rseq_alignof (struct rseq) >= 32, "alignment"))

And something similar for _Alignas/attribute aligned, with an error for
older standards and !__GNUC__ compilers (because neither the type nor
__thread can be represented there).

Thanks,
Florian

