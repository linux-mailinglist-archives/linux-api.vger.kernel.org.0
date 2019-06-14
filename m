Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B564645DF4
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfFNNSl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:18:41 -0400
Received: from mail.efficios.com ([167.114.142.138]:34932 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfFNNSl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 09:18:41 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5DE3825101D;
        Fri, 14 Jun 2019 09:18:39 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id RJkSqrXB2sYD; Fri, 14 Jun 2019 09:18:39 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EA71D251018;
        Fri, 14 Jun 2019 09:18:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EA71D251018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560518319;
        bh=/v2WHP0/4YyzHUmChvFO66kw0sHLDO7c/iZQSMDPn+0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=SN7BCSJ2tIIDUvDAz7igtpSNX52BaE4Lxpu6EQVXKUJpfKeGSfWn+z1n7D9DbuYQS
         WsMoY+jt8wMGZGvqw9zYgR08jY83zl3JDouHkERV7/SEnwBqYjEHNnQEMugVBoYZjP
         gvmpEYtGTDGROMIdr1AiYB57B8eb5TTuUHcUC9nTxyafRz28yK6Xa7qfUvIwrt1MAO
         ukrlyWUiqD/kcVn94v1QDF1M78Cr+zbHFQzZx17OxnWqzza3omEQp0CAaERzmmC5bz
         BKwBgl6Ejv4H/bRYgy4sz/OvyOTpH5wDMlcmCfDqsV0sOFjXQ9Gm3jk0raVFqDJDjK
         UdEIBC4aXlKAg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id xK7b3jYpLBEk; Fri, 14 Jun 2019 09:18:38 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id CF34325100F;
        Fri, 14 Jun 2019 09:18:38 -0400 (EDT)
Date:   Fri, 14 Jun 2019 09:18:38 -0400 (EDT)
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
Message-ID: <1779359826.3226.1560518318701.JavaMail.zimbra@efficios.com>
In-Reply-To: <87d0jguxdk.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <802638054.3032.1560506584705.JavaMail.zimbra@efficios.com> <87ftocwkei.fsf@oldenburg2.str.redhat.com> <1635690189.3049.1560507249693.JavaMail.zimbra@efficios.com> <87tvcsv1pk.fsf@oldenburg2.str.redhat.com> <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com> <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com> <87d0jguxdk.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: XZwhQyoKRjgOfzBSfSbrgHMVjax/Lw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 14, 2019, at 3:09 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> But my original issue remains: if I define a variable called __rseq_handled
>> within either the main executable or the preloaded library, it overshadows
>> the libc one:
>>
>> efficios@compudjdev:~/test/libc-sym$ ./a
>> __rseq_handled main: 0 0x56135fd5102c
>> __rseq_abi.cpu_id main: 29 0x7fcbeca6d5a0
>> efficios@compudjdev:~/test/libc-sym$ LD_PRELOAD=./s.so ./a
>> __rseq_handled s.so: 0 0x558f70aeb02c
>> __rseq_abi.cpu_id s.so: -1 0x7fdca78b7760
>> __rseq_handled main: 0 0x558f70aeb02c
>> __rseq_abi.cpu_id main: 27 0x7fdca78b7760
>>
>> Which is unexpected.
> 
> Why is this unexpected?  It has to be this way if the main program uses
> a copy relocation of __rseq_handled.  As long as there is just one
> address across the entire program and ld.so initializes the copy of the
> variable that is actually used, everything will be fine.

Here is a printout of the __rseq_handled address observed by ld.so, it
does not match:

LD_PRELOAD=./s.so ./a
elf: __rseq_handled addr: 7f501c98a140
__rseq_handled s.so: 0 0x55817a88d02c
__rseq_abi.cpu_id s.so: -1 0x7f501c983760
__rseq_handled main: 0 0x55817a88d02c
__rseq_abi.cpu_id main: 27 0x7f501c983760

This is with the following in a.c:

#include <stdio.h>
#include <linux/rseq.h>

__thread struct rseq __rseq_abi
__attribute__ ((tls_model ("initial-exec"))) = {
	.cpu_id = -1,
};
int __rseq_handled;

int main()
{
	fprintf(stderr, "__rseq_handled main: %d %p\n", __rseq_handled, &__rseq_handled);
	fprintf(stderr, "__rseq_abi.cpu_id main: %d %p\n", __rseq_abi.cpu_id, &__rseq_abi);
	return 0;
}

As we can see, the state of __rseq_handled observed by the preloaded
lib and the program is "0", but should really be "1". This can be
explained by ld.so not using the same address as the rest of the
program, but how can we fix that ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
