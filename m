Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A4045F9B
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfFNNxc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbfFNNxY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 14 Jun 2019 09:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAA9181F2F;
        Fri, 14 Jun 2019 13:53:23 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-180.str.redhat.com [10.33.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71F6D60BE0;
        Fri, 14 Jun 2019 13:53:16 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and thread creation (v10)
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
        <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com>
        <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com>
        <87d0jguxdk.fsf@oldenburg2.str.redhat.com>
        <1779359826.3226.1560518318701.JavaMail.zimbra@efficios.com>
        <87wohoti47.fsf@oldenburg2.str.redhat.com>
        <189377747.3315.1560519247118.JavaMail.zimbra@efficios.com>
        <87imt8tha5.fsf@oldenburg2.str.redhat.com>
        <26171199.3391.1560520033825.JavaMail.zimbra@efficios.com>
Date:   Fri, 14 Jun 2019 15:53:15 +0200
In-Reply-To: <26171199.3391.1560520033825.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 14 Jun 2019 09:47:13 -0400
        (EDT)")
Message-ID: <87ef3wtgs4.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 14 Jun 2019 13:53:23 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Jun 14, 2019, at 3:42 PM, Florian Weimer fweimer@redhat.com wrote:
>
>> * Mathieu Desnoyers:
>> 
>>> +  /* Publicize rseq registration ownership.  This must be performed
>>> +     after rtld re-relocation, before invoking constructors of
>>> +     preloaded libraries.  */
>>> +  rseq_init ();
>> 
>> Please add a comment that IFUNC resolvers do not see the initialized
>> value.  I think this is okay because we currently do not support access
>> to extern variables in IFUNC resolvers.
>
> Do IFUNC resolvers happen to observe the __rseq_handled address that
> was internal to ld.so ?

They should observe the correct address, but they can access the
variable before initialization.  An initializer in ld.so will not have
an effect if an interposed definition initalized the variable to
something else.

> If so, we could simply initialize __rseq_handled twice: early before calling
> IFUNC resolvers, and after ld.so re-relocation.

No, I don't think this will make a difference.

Thanks,
Florian
