Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B7345FCB
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfFNN7G (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:59:06 -0400
Received: from mail.efficios.com ([167.114.142.138]:48010 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfFNN7G (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 09:59:06 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id ADE6D251CCD;
        Fri, 14 Jun 2019 09:59:04 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id rJOHjntNcuT9; Fri, 14 Jun 2019 09:59:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4EA47251CC8;
        Fri, 14 Jun 2019 09:59:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4EA47251CC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560520744;
        bh=jpmp9DG8eHAyLVISapjfq/tN+v/idvmpwbfusJBMqP4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ExDF2YU3NUQJA2JcFDQjaJL1g9CCnkPixcgar3BbM9emiOPEPyaUyLowwGJ9pBilS
         oKpc3GQ4S3kA3Avor0qnfp+nck1hSotR9n11BoNA0nmQDITQW53BtfhVrKZaIRDD8h
         kkwSz7zkEbhkR3CsBO6PJjWn/AXU1abrrjlolvpcHEEQonPzjSqqc6yHs8xXp4BUue
         gusO4b/erzcWJ06zLebUyvki5ZHoP+hMlse0PAfCDlaNLNBNJiPWCEGRPnvt6CcEZl
         rPT2RISu2jlS/WujZUTwxT4/S+PWcCe9nt5o06JnF9zGmUGXPukd2sJoE1B6i5dPVo
         YU/SE4Aj3kaWA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Mv1VjGbPs8-l; Fri, 14 Jun 2019 09:59:04 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 32072251CBE;
        Fri, 14 Jun 2019 09:59:04 -0400 (EDT)
Date:   Fri, 14 Jun 2019 09:59:04 -0400 (EDT)
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
Message-ID: <634912958.3582.1560520744040.JavaMail.zimbra@efficios.com>
In-Reply-To: <87ef3wtgs4.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <87d0jguxdk.fsf@oldenburg2.str.redhat.com> <1779359826.3226.1560518318701.JavaMail.zimbra@efficios.com> <87wohoti47.fsf@oldenburg2.str.redhat.com> <189377747.3315.1560519247118.JavaMail.zimbra@efficios.com> <87imt8tha5.fsf@oldenburg2.str.redhat.com> <26171199.3391.1560520033825.JavaMail.zimbra@efficios.com> <87ef3wtgs4.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: bTcDxImi7N70vGPu1EOcYFTLIBF+3A==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 14, 2019, at 3:53 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Jun 14, 2019, at 3:42 PM, Florian Weimer fweimer@redhat.com wrote:
>>
>>> * Mathieu Desnoyers:
>>> 
>>>> +  /* Publicize rseq registration ownership.  This must be performed
>>>> +     after rtld re-relocation, before invoking constructors of
>>>> +     preloaded libraries.  */
>>>> +  rseq_init ();
>>> 
>>> Please add a comment that IFUNC resolvers do not see the initialized
>>> value.  I think this is okay because we currently do not support access
>>> to extern variables in IFUNC resolvers.
>>
>> Do IFUNC resolvers happen to observe the __rseq_handled address that
>> was internal to ld.so ?
> 
> They should observe the correct address, but they can access the
> variable before initialization.  An initializer in ld.so will not have
> an effect if an interposed definition initalized the variable to
> something else.
> 
>> If so, we could simply initialize __rseq_handled twice: early before calling
>> IFUNC resolvers, and after ld.so re-relocation.
> 
> No, I don't think this will make a difference.

So comment it is:

  /* Publicize rseq registration ownership.  This must be performed
     after rtld re-relocation, before invoking constructors of
     preloaded libraries. IFUNC resolvers are called before this
     initialization, so they may not observe the initialized state.  */
  rseq_init ();

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
