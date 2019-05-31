Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05C3108C
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfEaOsd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 10:48:33 -0400
Received: from mail.efficios.com ([167.114.142.138]:57136 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfEaOsc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 10:48:32 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F403122C750;
        Fri, 31 May 2019 10:48:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id sV7czKx3TTpV; Fri, 31 May 2019 10:48:30 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2F25D22C738;
        Fri, 31 May 2019 10:48:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2F25D22C738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1559314110;
        bh=lYLdvWHqEgBh1XBCm59pnUmR4YJ5QkepViWEd/RjOYI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=S8s8YrEv9PUYAcQmbW4RtdpZpAJXGaRmOucXGAKVs4HoATvOVlLGhhZDEAaP9jklS
         cQ9PNtiVIsp5ipKJS/yUrHuvwp6TkE23l4YUNAh2Ut4LFycY8NAc0mboVuT7crWCd4
         nyy+9FFDrcNuaH4EMuxhpls1KhhOmxQcQh1SvY6I+lR2maQxXMnDyGKsLkFulNZZpR
         /JU1TzYg+h3FECve48pOpAgwBq/lfuAofZYlb+Lphw1/ORZLSa7Lz0Kjr7/yPTnDDb
         YeRTrTJEIS7tNGZz8DGm7a8G3rySd+x4Ahdkv05hbbA3P70VsIMjc8lAmSbmVfqZCc
         IwBAIVhU/8Pvg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id tP2Ij7GqSvCE; Fri, 31 May 2019 10:48:30 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0E29A22C729;
        Fri, 31 May 2019 10:48:30 -0400 (EDT)
Date:   Fri, 31 May 2019 10:48:29 -0400 (EDT)
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
Message-ID: <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com>
In-Reply-To: <875zprm4jo.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <20190503184219.19266-2-mathieu.desnoyers@efficios.com> <87h89gjgaf.fsf@oldenburg2.str.redhat.com> <1239705947.14878.1558985272873.JavaMail.zimbra@efficios.com> <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com> <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com> <875zprm4jo.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: hCqY8L0Nc/c0WllqkYAE8st/EothUg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



----- On May 31, 2019, at 4:06 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> I found that it's because touching a __thread variable from
>> ld-linux-x86-64.so.2 ends up setting the DF_STATIC_TLS flag
>> for that .so, which is really not expected.
>>
>> Even if I tweak the assert to make it more lenient there,
>> touching the __thread variable ends up triggering a SIGFPE.
> 
> Sorry, I got distracted at this critical juncture.  Yes, I forgot that
> there isn't TLS support in the dynamic loader today.
> 
>> So rather than touching the TLS from ld-linux-x86-64.so.2,
>> I've rather experimented with moving the rseq initialization
>> for both SHARED and !SHARED cases to a library constructor
>> within libc.so.
>>
>> Are you aware of any downside to this approach ?
> 
> The information whether the kernel supports rseq would not be available
> to IFUNC resolvers.  And in some cases, ELF constructors for application
> libraries could run before the libc.so.6 constructor, so applications
> would see a transition from lack of kernel support to kernel support.
> 
>> +static
>> +__attribute__ ((constructor))
>> +void __rseq_libc_init (void)
>> +{
>> +  rseq_init ();
>> +  /* Register rseq ABI to the kernel.   */
>> +  (void) rseq_register_current_thread ();
>> +}
> 
> I think the call to rseq_init (and the __rseq_handled variable) should
> still be part of the dynamic loader.  Otherwise there could be confusion
> about whether glibc handles the registration (due the constructor
> ordering issue).

Let's break this down into the various sub-issues involved:

1) How early do we need to setup rseq ? Should it be setup before:
   - LD_PRELOAD .so constructors ?
     - Without circular dependency,
     - With circular dependency,
   - audit libraries initialization ?
   - IFUNC resolvers ?
   - other callbacks ?
   - memory allocator calls ?

We may end up in a situation where we need memory allocation to be setup
in order to initialize TLS before rseq can be registered for the main
thread. I suspect we will end up needing a fallbacks which always work
for the few cases that would try to use rseq too early in dl/libc startup.

2) Do we need to setup __rseq_handled and __rseq_abi at the same stage of
   startup, or is it OK to setup __rseq_handled before __rseq_abi ?

3) Which shared object owns __rseq_handled and __rseq_abi ?
   - libc.so ?
   - ld-linux-*.so.2 ?
   - Should both symbols be owned by the same .so ?
   - What about the !SHARED case ? I think this would end up in libc.a in all cases.

4) Inability to touch a TLS variable (__rseq_abi) from ld-linux-*.so.2
   - Should we extend the dynamic linker to allow such TLS variable to be
     accessed ? If so, how much effort is required ?
   - Can we find an alternative way to initialize rseq early during
     dl init stages while still performing the TLS access from a function
     implemented within libc.so ?

So far, I got rseq to be initialized before LD_PRELOADed library constructors
by doing the initialization in a constructor within libc.so. I don't particularly
like this approach, because the constructor order is not guaranteed.

One possible solution would be to somehow expose a rseq initialization function
symbol from libc.so, look it up from ld-linux-*.so.2, and invoke it after libc.so
has been loaded. It would end up being similar to a constructor, but with a
fixed invocation order.

I'm just not sure we have everything we need to do this in ld-linux-*.so.2
init stages.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
