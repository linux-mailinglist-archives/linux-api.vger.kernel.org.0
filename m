Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42D1B9F82
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgD0JNj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 05:13:39 -0400
Received: from albireo.enyo.de ([37.24.231.21]:46340 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgD0JNi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 Apr 2020 05:13:38 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jSzpV-00046J-PD; Mon, 27 Apr 2020 09:13:33 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jSzpV-0007Nh-NC; Mon, 27 Apr 2020 11:13:33 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-api@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH glibc 6/9] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux (v7)
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
        <20200326155633.18236-7-mathieu.desnoyers@efficios.com>
Date:   Mon, 27 Apr 2020 11:13:33 +0200
In-Reply-To: <20200326155633.18236-7-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers via Libc-alpha's message of "Thu, 26 Mar 2020 11:56:30
        -0400")
Message-ID: <87a72xz3ya.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers via Libc-alpha:

> diff --git a/sysdeps/unix/sysv/linux/sched_getcpu.c b/sysdeps/unix/sysv/linux/sched_getcpu.c
> index c019cfb3cf..2269c4f2bd 100644
> --- a/sysdeps/unix/sysv/linux/sched_getcpu.c
> +++ b/sysdeps/unix/sysv/linux/sched_getcpu.c
> @@ -18,10 +18,15 @@
>  #include <errno.h>
>  #include <sched.h>
>  #include <sysdep.h>
> +#include <atomic.h>
>  #include <sysdep-vdso.h>
>  
> -int
> -sched_getcpu (void)
> +#ifdef HAVE_GETCPU_VSYSCALL
> +# define HAVE_VSYSCALL
> +#endif
> +
> +static int
> +vsyscall_sched_getcpu (void)
>  {
>    unsigned int cpu;
>    int r = -1;
> @@ -32,3 +37,21 @@ sched_getcpu (void)
>  #endif
>    return r == -1 ? r : cpu;
>  }
> +
> +#include <sys/rseq.h>
> +
> +#ifdef RSEQ_SIG
> +int
> +sched_getcpu (void)
> +{
> +  int cpu_id = atomic_load_relaxed (&__rseq_abi.cpu_id);
> +
> +  return cpu_id >= 0 ? cpu_id : vsyscall_sched_getcpu ();
> +}
> +#else
> +int
> +sched_getcpu (void)
> +{
> +  return vsyscall_sched_getcpu ();
> +}
> +#endif

This patch needs to be rebased on current master, but the direction
looks right to me.
