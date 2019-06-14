Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692D545D31
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfFNMzN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 08:55:13 -0400
Received: from mail.efficios.com ([167.114.142.138]:53076 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFNMzN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 08:55:13 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AD255251A81;
        Fri, 14 Jun 2019 08:55:11 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id vjOPiLiBh4EO; Fri, 14 Jun 2019 08:55:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3702A251A7D;
        Fri, 14 Jun 2019 08:55:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3702A251A7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560516911;
        bh=1jNGz+08JhCbBTSKtCKZD6e/5y7z6m/+et2U9s4q3DY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WK+aVbRqZX3GWZkCTNmBmkP06UmdScAi7xxO/4Yxj1vGiMaXhMdeODn41ULeNGet9
         KU+WLE6OikqBK+5fRtI0l9Mj/ZITrs/JRZ/RmIpazdPM/ebTIz1JCgtp6cNPAlLPFy
         OPUwAjqTTpsvIsgBAuaCwsfFNEByeJo5LUFCeNcozs+TR5DEMk7x8jL25TYCyvzNRu
         IVkLLouOcbVcMiTnEOyoF+o+H7U/4xxFUQX/IiSrWIIgN0iKXl/KCduwNHXgMAdg39
         ZPPQ/magsSzUzlCC26sMk3S3veIWUIUDXAwGN4tfmdzKyy60TepO7FSHbL/VTnN2D/
         5RaEN5Bb26b1Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id UZGT-TPhGr3m; Fri, 14 Jun 2019 08:55:11 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 1B658251A71;
        Fri, 14 Jun 2019 08:55:11 -0400 (EDT)
Date:   Fri, 14 Jun 2019 08:55:10 -0400 (EDT)
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
Message-ID: <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com>
In-Reply-To: <87tvcsv1pk.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <87wohzorj0.fsf@oldenburg2.str.redhat.com> <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com> <914051741.43025.1560348011775.JavaMail.zimbra@efficios.com> <802638054.3032.1560506584705.JavaMail.zimbra@efficios.com> <87ftocwkei.fsf@oldenburg2.str.redhat.com> <1635690189.3049.1560507249693.JavaMail.zimbra@efficios.com> <87tvcsv1pk.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: nxhND8m/7T2GVm9h2nQ+6XKFJSEm7Q==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 14, 2019, at 1:35 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> * Makefile:
>>
>> LIBCPATH=/home/efficios/glibc-test/lib
>> KERNEL_HEADERS=/home/efficios/git/linux-percpu-dev/usr/include
>> CFLAGS=-I${KERNEL_HEADERS} -L${LIBCPATH} -Wl,--rpath=${LIBCPATH}
>> -Wl,--dynamic-linker=${LIBCPATH}/ld-linux-x86-64.so.2
>>
>> all:
>> 	gcc ${CFLAGS} -o a a.c
>> 	gcc ${CFLAGS} -shared -fPIC -o s.so s.c
> 
> For me, that does not correctly link against the built libc because the
> system dynamic loader seeps into the link.

I have the same issue. I tried adding "-B${LIBCPATH}" as well, but it did
not seem to help. I still have this ldd output:

ldd a
./a: /lib64/ld-linux-x86-64.so.2: version `GLIBC_2.30' not found (required by ./a)
	linux-vdso.so.1 (0x00007fffaa7e9000)
	libc.so.6 => /home/efficios/glibc-test/lib/libc.so.6 (0x00007fac5d479000)
	/home/efficios/glibc-test/lib/ld-linux-x86-64.so.2 => /lib64/ld-linux-x86-64.so.2 (0x00007fac5da33000)

Still no luck there. Any idea what compiler/linker flag I am missing ?

> 
>> specifically this commit:
>> https://github.com/compudj/glibc-dev/commit/c49a286497d065a7fc00aafd846e6edce14f97fc
> 
> This commit links __rseq_handled into libc.so.6 via rseq-sym.c, but does
> not export it from there.

Moving __rseq_handled to elf/dl-support.c and elf/rtld.c was part a commit on top.
I've force-pushed on the dev branch, and the commit moving __rseq_handled to the
dynamic linker it now appears as:
https://github.com/compudj/glibc-dev/commit/f0d4e60e5d0ceb0c2642f99da5af61b6ad988531

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
