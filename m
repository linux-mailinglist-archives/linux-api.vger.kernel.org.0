Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D1845D58
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfFNNBp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:01:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:54838 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfFNNBn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 09:01:43 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 52BD3251BD1;
        Fri, 14 Jun 2019 09:01:42 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id e9l0iHqx2lUz; Fri, 14 Jun 2019 09:01:42 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E2A95251BCE;
        Fri, 14 Jun 2019 09:01:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E2A95251BCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560517301;
        bh=l+b91yRE0PjAPYjW6XhBF3CAgkCEH964NMmP19OUNSU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=UzROhAR1/xNCbD4q7c/ulb3yYbTJy6Vqzgj0R2VqyMG01kfgh3LbH4JT2MLJbO3fT
         qA15jBhIiv97G6l/JhcI1vFmm4N6GdFS19c6QHAGtbzXq1kp/2YCru+28/qKtKo2H5
         pNshINMUcpRdiRaLaSy1d4yyMkSYBE22ndo+BH5hhcU9KNIwqhf6pw3HFd5FXIQ4It
         nOJWL6A+IJbYuFjeDrnZjge1tYd/m8uhwz9Nj7JchLRwAWwB17rrIOb7jEekac6hld
         +juVa8TIAIiABWJXW7sesnOPfQ5TZ2z4htPisTFtQh/H+TSUhGKvHS+7uyATNAHdF6
         gwCN6BZ0Y5XAA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id I5slPf6PHjOI; Fri, 14 Jun 2019 09:01:41 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C204B251BC3;
        Fri, 14 Jun 2019 09:01:41 -0400 (EDT)
Date:   Fri, 14 Jun 2019 09:01:41 -0400 (EDT)
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
Message-ID: <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com>
In-Reply-To: <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com> <914051741.43025.1560348011775.JavaMail.zimbra@efficios.com> <802638054.3032.1560506584705.JavaMail.zimbra@efficios.com> <87ftocwkei.fsf@oldenburg2.str.redhat.com> <1635690189.3049.1560507249693.JavaMail.zimbra@efficios.com> <87tvcsv1pk.fsf@oldenburg2.str.redhat.com> <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: nxhND8m/7T2GVm9h2nQ+6XKFJSEm7WaZYQId
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 14, 2019, at 2:55 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jun 14, 2019, at 1:35 PM, Florian Weimer fweimer@redhat.com wrote:
> 
>> * Mathieu Desnoyers:
>> 
>>> * Makefile:
>>>
>>> LIBCPATH=/home/efficios/glibc-test/lib
>>> KERNEL_HEADERS=/home/efficios/git/linux-percpu-dev/usr/include
>>> CFLAGS=-I${KERNEL_HEADERS} -L${LIBCPATH} -Wl,--rpath=${LIBCPATH}
>>> -Wl,--dynamic-linker=${LIBCPATH}/ld-linux-x86-64.so.2
>>>
>>> all:
>>> 	gcc ${CFLAGS} -o a a.c
>>> 	gcc ${CFLAGS} -shared -fPIC -o s.so s.c
>> 
>> For me, that does not correctly link against the built libc because the
>> system dynamic loader seeps into the link.
> 
> I have the same issue. I tried adding "-B${LIBCPATH}" as well, but it did
> not seem to help. I still have this ldd output:
> 
> ldd a
> ./a: /lib64/ld-linux-x86-64.so.2: version `GLIBC_2.30' not found (required by
> ./a)
>	linux-vdso.so.1 (0x00007fffaa7e9000)
>	libc.so.6 => /home/efficios/glibc-test/lib/libc.so.6 (0x00007fac5d479000)
>	/home/efficios/glibc-test/lib/ld-linux-x86-64.so.2 =>
>	/lib64/ld-linux-x86-64.so.2 (0x00007fac5da33000)
> 
> Still no luck there. Any idea what compiler/linker flag I am missing ?
> 

Actually, even though ldd seems confused, running the program seems to
use the right ld.so:

efficios@compudjdev:~/test/libc-sym$ ./a
__rseq_handled main: 1 0x55f0ec915020
__rseq_abi.cpu_id main: 28 0x7f54f6c2d4c0
efficios@compudjdev:~/test/libc-sym$ LD_PRELOAD=./s.so ./a
__rseq_handled s.so: 1 0x557350bc6020
__rseq_abi.cpu_id s.so: -1 0x7fe2f30f2680
__rseq_handled main: 1 0x557350bc6020
__rseq_abi.cpu_id main: 27 0x7fe2f30f2680

But my original issue remains: if I define a variable called __rseq_handled
within either the main executable or the preloaded library, it overshadows
the libc one:

efficios@compudjdev:~/test/libc-sym$ ./a
__rseq_handled main: 0 0x56135fd5102c
__rseq_abi.cpu_id main: 29 0x7fcbeca6d5a0
efficios@compudjdev:~/test/libc-sym$ LD_PRELOAD=./s.so ./a
__rseq_handled s.so: 0 0x558f70aeb02c
__rseq_abi.cpu_id s.so: -1 0x7fdca78b7760
__rseq_handled main: 0 0x558f70aeb02c
__rseq_abi.cpu_id main: 27 0x7fdca78b7760

Which is unexpected.

This is with my dev branch at this commit:

https://github.com/compudj/glibc-dev/commit/f0d4e60e5d0ceb0c2642f99da5af61b6ad988531

What am I missing ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
