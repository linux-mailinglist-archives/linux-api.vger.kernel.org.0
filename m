Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1066745E4A
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfFNNeJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:34:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:38922 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbfFNNeJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 09:34:09 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D261D25143A;
        Fri, 14 Jun 2019 09:34:07 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id eMtJxE_PKUuv; Fri, 14 Jun 2019 09:34:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5A209251437;
        Fri, 14 Jun 2019 09:34:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5A209251437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560519247;
        bh=BXdzK3imtsRVvyqNXo75xd1vpyjR6NM0BuwT0eQblbg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HffgqhImyOqrETWjZ8ZBxuodnBa4RRE0oMjQGK4I0CeMV998n9+kRLxQFhCyE3SHW
         pzxkkua62UHD/ubHQiY9NIFNhRGNCxFADrihzn2yERHxs96eJ8q5aTgPLjQl9krPG5
         V7GnOuXwxx2LqEymxUqsAc5P0QciLnloo19N3JrfR/7wLNQn65NF8GfctY9iraUb5m
         dE7ikuwq//6BwDIyqDNRw3i/csn4qDy1UGbBsnIEaZMdfiIdDXVx0Zx+XrbFd9QkRF
         aDt/sS/q2RHGdvCqhorLHhIGCsFdXOiShv2oOZXemJ42iyJbTHQ2Ea8BZFwXG8ODh+
         dHvAYZA7Znjzg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id N5H9ReVy76NV; Fri, 14 Jun 2019 09:34:07 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3EF2125142C;
        Fri, 14 Jun 2019 09:34:07 -0400 (EDT)
Date:   Fri, 14 Jun 2019 09:34:07 -0400 (EDT)
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
Message-ID: <189377747.3315.1560519247118.JavaMail.zimbra@efficios.com>
In-Reply-To: <87wohoti47.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <1635690189.3049.1560507249693.JavaMail.zimbra@efficios.com> <87tvcsv1pk.fsf@oldenburg2.str.redhat.com> <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com> <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com> <87d0jguxdk.fsf@oldenburg2.str.redhat.com> <1779359826.3226.1560518318701.JavaMail.zimbra@efficios.com> <87wohoti47.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: J/z3tq5R2TjIrEv1ISEFn2sEl/wrzw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 14, 2019, at 3:24 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Jun 14, 2019, at 3:09 PM, Florian Weimer fweimer@redhat.com wrote:
>>
>>> * Mathieu Desnoyers:
>>> 
>>>> But my original issue remains: if I define a variable called __rseq_handled
>>>> within either the main executable or the preloaded library, it overshadows
>>>> the libc one:
>>>>
>>>> efficios@compudjdev:~/test/libc-sym$ ./a
>>>> __rseq_handled main: 0 0x56135fd5102c
>>>> __rseq_abi.cpu_id main: 29 0x7fcbeca6d5a0
>>>> efficios@compudjdev:~/test/libc-sym$ LD_PRELOAD=./s.so ./a
>>>> __rseq_handled s.so: 0 0x558f70aeb02c
>>>> __rseq_abi.cpu_id s.so: -1 0x7fdca78b7760
>>>> __rseq_handled main: 0 0x558f70aeb02c
>>>> __rseq_abi.cpu_id main: 27 0x7fdca78b7760
>>>>
>>>> Which is unexpected.
>>> 
>>> Why is this unexpected?  It has to be this way if the main program uses
>>> a copy relocation of __rseq_handled.  As long as there is just one
>>> address across the entire program and ld.so initializes the copy of the
>>> variable that is actually used, everything will be fine.
>>
>> Here is a printout of the __rseq_handled address observed by ld.so, it
>> does not match:
>>
>> LD_PRELOAD=./s.so ./a
>> elf: __rseq_handled addr: 7f501c98a140
>> __rseq_handled s.so: 0 0x55817a88d02c
>> __rseq_abi.cpu_id s.so: -1 0x7f501c983760
>> __rseq_handled main: 0 0x55817a88d02c
>> __rseq_abi.cpu_id main: 27 0x7f501c983760
> 
> Where do you print the address?  Before or after the self-relocation of
> the dynamic loader?  The address is only correct after self-relocation.

I printed the address within rseq_init (), which happened to be invoked
by the linker startup waaaay too early. I followed your advice and moved
the rseq_init () invocation after linker re-relocation:

diff --git a/elf/rtld.c b/elf/rtld.c
index f29f284a7c..66b0894f9d 100644
--- a/elf/rtld.c
+++ b/elf/rtld.c
@@ -1410,9 +1410,6 @@ ERROR: '%s': cannot process note segment.\n", _dl_argv[0]);
     /* Assign a module ID.  Do this before loading any audit modules.  */
     GL(dl_rtld_map).l_tls_modid = _dl_next_tls_modid ();
 
-  /* Publicize rseq registration ownership.  */
-  rseq_init ();
-
   /* If we have auditing DSOs to load, do it now.  */
   bool need_security_init = true;
   if (__glibc_unlikely (audit_list != NULL)
@@ -2284,6 +2281,11 @@ ERROR: ld.so: object '%s' cannot be loaded as audit interface: %s; ignored.\n",
       HP_TIMING_ACCUM_NT (relocate_time, add);
     }
 
+  /* Publicize rseq registration ownership.  This must be performed
+     after rtld re-relocation, before invoking constructors of
+     preloaded libraries.  */
+  rseq_init ();
+
   /* Do any necessary cleanups for the startup OS interface code.
      We do these now so that no calls are made after rtld re-relocation
      which might be resolved to different functions than we expect.

It works fine now!

LD_PRELOAD=./s.so ./a
elf: __rseq_handled addr: 56300f0a402c
__rseq_handled s.so: 1 0x56300f0a402c
__rseq_abi.cpu_id s.so: -1 0x7fad2ff58760
__rseq_handled main: 1 0x56300f0a402c
__rseq_abi.cpu_id main: 27 0x7fad2ff58760

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
