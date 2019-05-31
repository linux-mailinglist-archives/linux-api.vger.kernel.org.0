Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5883031187
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 17:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEaPqV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Fri, 31 May 2019 11:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfEaPqV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 31 May 2019 11:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D00130C5854;
        Fri, 31 May 2019 15:46:17 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-219.str.redhat.com [10.33.192.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF7081009976;
        Fri, 31 May 2019 15:46:09 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and thread creation (v10)
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
        <20190503184219.19266-2-mathieu.desnoyers@efficios.com>
        <87h89gjgaf.fsf@oldenburg2.str.redhat.com>
        <1239705947.14878.1558985272873.JavaMail.zimbra@efficios.com>
        <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com>
        <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com>
        <875zprm4jo.fsf@oldenburg2.str.redhat.com>
        <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com>
Date:   Fri, 31 May 2019 17:46:08 +0200
In-Reply-To: <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 31 May 2019 10:48:29 -0400
        (EDT)")
Message-ID: <87muj2k4ov.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 31 May 2019 15:46:20 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> Let's break this down into the various sub-issues involved:
>
> 1) How early do we need to setup rseq ? Should it be setup before:
>    - LD_PRELOAD .so constructors ?
>      - Without circular dependency,
>      - With circular dependency,
>    - audit libraries initialization ?
>    - IFUNC resolvers ?
>    - other callbacks ?
>    - memory allocator calls ?
>
> We may end up in a situation where we need memory allocation to be setup
> in order to initialize TLS before rseq can be registered for the main
> thread. I suspect we will end up needing a fallbacks which always work
> for the few cases that would try to use rseq too early in dl/libc startup.

I think the answer to that depends on whether it's okay to have an
observable transition from “no rseq kernel support” to “kernel supports
rseq”.

> 2) Do we need to setup __rseq_handled and __rseq_abi at the same stage of
>    startup, or is it OK to setup __rseq_handled before __rseq_abi ?

I think we should be able to set __rseq_handle early, even if we can
perform the rseq area registration later.  (The distinction does not
matter if the registration needs to be performed early as well.)

Setting __rseq_handle in ld.so is easy if the variable is defined in
ld.so, which is not a problem at all.

> 3) Which shared object owns __rseq_handled and __rseq_abi ?
>    - libc.so ?
>    - ld-linux-*.so.2 ?
>    - Should both symbols be owned by the same .so ?

I think we can pick whatever works, based on the requirements from (1).
It's an implementation detail (altough it currently becomes part of the
ABI for weird reasons, but the choice itself is arbitrary).

>    - What about the !SHARED case ? I think this would end up in libc.a
>    in all cases.

Correct.

> 4) Inability to touch a TLS variable (__rseq_abi) from ld-linux-*.so.2
>    - Should we extend the dynamic linker to allow such TLS variable to be
>      accessed ? If so, how much effort is required ?
>    - Can we find an alternative way to initialize rseq early during
>      dl init stages while still performing the TLS access from a function
>      implemented within libc.so ?

This is again related to the answer for (1).  There are various hacks we
could implement to make the initialization invisible (e.g., computing
the address of the variable using the equivalent of dlsym, after loading
all the initial objects and before starting relocation).  If it's not
too hard to add TLS support to ld.so, we can consider that as well.
(The allocation side should be pretty easy, relocation support it could
be more tricky.)

> So far, I got rseq to be initialized before LD_PRELOADed library
> constructors by doing the initialization in a constructor within
> libc.so. I don't particularly like this approach, because the
> constructor order is not guaranteed.

Right.

> One possible solution would be to somehow expose a rseq initialization
> function symbol from libc.so, look it up from ld-linux-*.so.2, and
> invoke it after libc.so has been loaded. It would end up being similar
> to a constructor, but with a fixed invocation order.

This would still expose lack of rseq support to IFUNC resolvers
initially.  I don't know if this is a problem (again, it comes down to
(1) above).  There is a school of thought that you can't reference
__rseq_abi from an IFUNC resolver because it needs a relocation.

Thanks,
Florian
