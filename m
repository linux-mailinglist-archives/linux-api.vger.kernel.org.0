Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D7945ECB
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfFNNrQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:47:16 -0400
Received: from mail.efficios.com ([167.114.142.138]:43596 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfFNNrP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 09:47:15 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 76B3B2517E2;
        Fri, 14 Jun 2019 09:47:14 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id E1TuGgOUa87X; Fri, 14 Jun 2019 09:47:14 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 19F7F2517DB;
        Fri, 14 Jun 2019 09:47:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 19F7F2517DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560520034;
        bh=81EpfFNjP6SvW3w5jVIET8nZSw4QEAdPUWyGh9rrrk0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WP5wmVF8o+loCPX8mYQM0wAdEPJvADvYrEjChO39wLC+vtYpIZxQuRACD3Kgpe7Zq
         yhLb+4GcQ7C1oJH+sDD40TqSWG3P42Q+5Pcc8M28ejSkaIRm0sg+t465+rlB++q6Gn
         m1uywQpEaIDmT3u+1QZqmeKgaI5D30aIo2kFFsg+8ey0ccxACsRsz2ozANcftu/sUn
         jB+oiHAEw5jFqmOTTOXQk/CMPgmyamBGMz5xOaH7UYn8J7FY2v6qHyeh+fBLZo3JK2
         MXBEtnwG5IJbvsUUqMouiENJR5j9pJ68XHzbGN8JAzxgrFje6wyjfArbPkO+mMVa/W
         UdJlAmp2tJ4nw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id j3nKT3CEgr1y; Fri, 14 Jun 2019 09:47:14 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id EF45F2517D4;
        Fri, 14 Jun 2019 09:47:13 -0400 (EDT)
Date:   Fri, 14 Jun 2019 09:47:13 -0400 (EDT)
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
Message-ID: <26171199.3391.1560520033825.JavaMail.zimbra@efficios.com>
In-Reply-To: <87imt8tha5.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com> <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com> <87d0jguxdk.fsf@oldenburg2.str.redhat.com> <1779359826.3226.1560518318701.JavaMail.zimbra@efficios.com> <87wohoti47.fsf@oldenburg2.str.redhat.com> <189377747.3315.1560519247118.JavaMail.zimbra@efficios.com> <87imt8tha5.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: wOBWzLotZbvRJLIS40uVtgojXXE/sQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 14, 2019, at 3:42 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> +  /* Publicize rseq registration ownership.  This must be performed
>> +     after rtld re-relocation, before invoking constructors of
>> +     preloaded libraries.  */
>> +  rseq_init ();
> 
> Please add a comment that IFUNC resolvers do not see the initialized
> value.  I think this is okay because we currently do not support access
> to extern variables in IFUNC resolvers.

Do IFUNC resolvers happen to observe the __rseq_handled address that
was internal to ld.so ?

If so, we could simply initialize __rseq_handled twice: early before calling
IFUNC resolvers, and after ld.so re-relocation.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
