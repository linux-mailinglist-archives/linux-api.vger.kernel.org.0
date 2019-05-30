Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636C2303A6
	for <lists+linux-api@lfdr.de>; Thu, 30 May 2019 22:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfE3U4p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 May 2019 16:56:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:52656 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3U4p (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 May 2019 16:56:45 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4525422C75B;
        Thu, 30 May 2019 16:56:43 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id xuiTPSZpoVyF; Thu, 30 May 2019 16:56:41 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B82AE22C751;
        Thu, 30 May 2019 16:56:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B82AE22C751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1559249801;
        bh=DqOvR38azidtYWY064tHH9yFqc/Lp232qmUcNljW6/w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ti4Gq1TTCmk7QcERHGMQFI+rpEs4P/FlDBc30sVpoX1rLp7WbqvcQmBRJzceKzdxr
         o0IgSLBfRABzGGp/LqjddVURi9pIEXCYnwhLLuOCrKcC1RY/fmy4gJsquighrOqdnd
         SOR4JmRVzp1NoV6xwxd/njIj7tkxesscLeLisON3YEDXEP7X2Mlqv1PdMP0pMxQ7Ok
         WCylazPt4cRd1DgUQK5BP+yfZVHzayn4UQ1AcuRL3RQWIvlrOaPviR9WNOH3Xw2PA1
         aMW9HbmaXtOCh1r/wiv8eKOS/4qMJPsmwyOnyAFAVN3Vz8hXjUQ+qG0m6WhismStmQ
         Bg8njsogzn3ew==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id zBslBDFYXAWg; Thu, 30 May 2019 16:56:41 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9CFA222C74B;
        Thu, 30 May 2019 16:56:41 -0400 (EDT)
Date:   Thu, 30 May 2019 16:56:41 -0400 (EDT)
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
Message-ID: <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com>
In-Reply-To: <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <20190503184219.19266-2-mathieu.desnoyers@efficios.com> <87h89gjgaf.fsf@oldenburg2.str.redhat.com> <1239705947.14878.1558985272873.JavaMail.zimbra@efficios.com> <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: 18yTu+T8PFt4cXiNhOg61XhmaTl3EWs0GkO7rE/zIqc=
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On May 29, 2019, at 11:45 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On May 27, 2019, at 3:27 PM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On May 27, 2019, at 7:19 AM, Florian Weimer fweimer@redhat.com wrote:
>> 
> 
> [...]
> 
>>> 
>>> Furthermore, the reference to ELF constructors is misleading.  I believe
>>> the code you added to __libc_start_main to initialize __rseq_handled and
>>> register __seq_abi with the kernel runs *after* ELF constructors have
>>> executed (and not at all if the main program is written in Go, alas).
>>> All initialization activity for the shared case needs to happen in
>>> elf/rtld.c or called from there, probably as part of the security
>>> initialization code or thereabouts.
>> 
>> in elf/rtld.c:dl_main() we have the following code:
>> 
>>  /* We do not initialize any of the TLS functionality unless any of the
>>     initial modules uses TLS.  This makes dynamic loading of modules with
>>     TLS impossible, but to support it requires either eagerly doing setup
>>     now or lazily doing it later.  Doing it now makes us incompatible with
>>     an old kernel that can't perform TLS_INIT_TP, even if no TLS is ever
>>     used.  Trying to do it lazily is too hairy to try when there could be
>>     multiple threads (from a non-TLS-using libpthread).  */
>>  bool was_tls_init_tp_called = tls_init_tp_called;
>>  if (tcbp == NULL)
>>    tcbp = init_tls ();
>> 
>> If I understand your point correctly, I should move the rseq_init() and
>> rseq_register_current_thread() for the SHARED case just after this
>> initialization, otherwise calling those from LIBC_START_MAIN() is too
>> late and it runs after initial modules constructors (or not at all for
>> Go). However, this means glibc will start using TLS internally. I'm
>> concerned that this is not quite in line with the above comment which
>> states that TLS is not initialized if no initial modules use TLS.
>> 
>> For the !SHARED use-case, if my understanding is correct, I should keep
>> rseq_init() and rseq_register_current_thread() calls within LIBC_START_MAIN().
> 
> I've moved the rseq initialization for SHARED case to the very end of
> elf/rtld.c:init_tls(), and get the following error on make check:
> 
> Generating locale am_ET.UTF-8: this might take a while...
> Inconsistency detected by ld.so: get-dynamic-info.h: 143: elf_get_dynamic_info:
> Assertion `info[DT_FLAGS] == NULL || (info[DT_FLAGS]->d_un.d_val &
> ~DF_BIND_NOW) == 0' failed!
> Charmap: "UTF-8" Inputfile: "am_ET" Outputdir: "am_ET.UTF-8" failed
> /bin/sh: 4: cannot create
> /home/efficios/git/glibc-build/localedata/am_ET.UTF-8/LC_CTYPE.test-result:
> Directory nonexistent
> 
> This error goes away if I comment out the call to rseq_register_current_thread
> (),
> which touches the __rseq_abi __thread variable and issues a system call.
> 
> Currently, the __rseq_abi __thread variable is within
> sysdeps/unix/sysv/linux/rseq-sym.c, which is added to the
> sysdep_routines within sysdeps/unix/sysv/linux/Makefile. I
> suspect it may need to be moved elsewhere.
> 
> Any thoughts on how to solve this ?

I found that it's because touching a __thread variable from
ld-linux-x86-64.so.2 ends up setting the DF_STATIC_TLS flag
for that .so, which is really not expected.

Even if I tweak the assert to make it more lenient there,
touching the __thread variable ends up triggering a SIGFPE.

So rather than touching the TLS from ld-linux-x86-64.so.2,
I've rather experimented with moving the rseq initialization
for both SHARED and !SHARED cases to a library constructor
within libc.so.

Are you aware of any downside to this approach ?

diff --git a/csu/libc-start.c b/csu/libc-start.c
index 5d9c3675fa..9755ed5467 100644
--- a/csu/libc-start.c
+++ b/csu/libc-start.c
@@ -22,6 +22,7 @@
 #include <ldsodefs.h>
 #include <exit-thread.h>
 #include <libc-internal.h>
+#include <rseq-internal.h>
 
 #include <elf/dl-tunables.h>
 
@@ -81,6 +82,14 @@ apply_irel (void)
 }
 #endif
 
+static
+__attribute__ ((constructor))
+void __rseq_libc_init (void)
+{
+  rseq_init ();
+  /* Register rseq ABI to the kernel.   */
+  (void) rseq_register_current_thread ();
+}
 
 #ifdef LIBC_START_MAIN
 # ifdef LIBC_START_DISABLE_INLINE


Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
