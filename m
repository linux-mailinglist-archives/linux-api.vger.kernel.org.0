Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BEB2B31A
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 13:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfE0LUS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 07:20:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfE0LUS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 May 2019 07:20:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D68381DFE;
        Mon, 27 May 2019 11:19:47 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-219.str.redhat.com [10.33.192.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90CB95D962;
        Mon, 27 May 2019 11:19:37 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and thread creation (v10)
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
        <20190503184219.19266-2-mathieu.desnoyers@efficios.com>
Date:   Mon, 27 May 2019 13:19:36 +0200
In-Reply-To: <20190503184219.19266-2-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Fri, 3 May 2019 14:42:15 -0400")
Message-ID: <87h89gjgaf.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 27 May 2019 11:20:18 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> +/* volatile because fields can be read/updated by the kernel.  */
> +__thread volatile struct rseq __rseq_abi = {
> +  .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
> +};

As I've explained repeatedly, the volatile qualifier is wrong because it
is impossible to get rid of it.  (Accessing an object declared volatile
using non-volatile pointers is undefined.)  Code using __rseq_abi should
use relaxed MO atomics or signal fences/compiler barriers, as
appropriate.

> +/* Advertise Restartable Sequences registration ownership across
> +   application and shared libraries.
> +
> +   Libraries and applications must check whether this variable is zero or
> +   non-zero if they wish to perform rseq registration on their own. If it
> +   is zero, it means restartable sequence registration is not handled, and
> +   the library or application is free to perform rseq registration. In
> +   that case, the library or application is taking ownership of rseq
> +   registration, and may set __rseq_handled to 1. It may then set it back
> +   to 0 after it completes unregistering rseq.
> +
> +   If __rseq_handled is found to be non-zero, it means that another
> +   library (or the application) is currently handling rseq registration.
> +
> +   Typical use of __rseq_handled is within library constructors and
> +   destructors, or at program startup.  */
> +
> +int __rseq_handled;

It's not clear to me whether the intent is that __rseq_handled reflects
kernel support for rseq or not.  Currently, it only tells us whether
glibc has been built with rseq support or not.  It does not reflect
kernel support.  I'm still not convinced that this symbol is necessary,
especially if we mandate a kernel header version which defines __NR_rseq
for building glibc (which may happen due to the time64_t work).

Furthermore, the reference to ELF constructors is misleading.  I believe
the code you added to __libc_start_main to initialize __rseq_handled and
register __seq_abi with the kernel runs *after* ELF constructors have
executed (and not at all if the main program is written in Go, alas).
All initialization activity for the shared case needs to happen in
elf/rtld.c or called from there, probably as part of the security
initialization code or thereabouts.

Thanks,
Florian
