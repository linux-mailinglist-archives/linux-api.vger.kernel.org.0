Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049FD373A3
	for <lists+linux-api@lfdr.de>; Thu,  6 Jun 2019 13:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfFFL5r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 6 Jun 2019 07:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbfFFL5r (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 6 Jun 2019 07:57:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B8B92F8BDE;
        Thu,  6 Jun 2019 11:57:33 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-180.str.redhat.com [10.33.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 476E2619CB;
        Thu,  6 Jun 2019 11:57:25 +0000 (UTC)
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
        <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com>
        <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com>
        <875zprm4jo.fsf@oldenburg2.str.redhat.com>
        <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com>
        <87muj2k4ov.fsf@oldenburg2.str.redhat.com>
        <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com>
        <87o93d4lqb.fsf@oldenburg2.str.redhat.com>
        <117220011.27079.1559663870037.JavaMail.zimbra@efficios.com>
Date:   Thu, 06 Jun 2019 13:57:23 +0200
Message-ID: <87wohzorj0.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 06 Jun 2019 11:57:47 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> Should we plan ahead for such scheme to override which library "owns" rseq
> registration from a LD_PRELOAD library ? If so, then we would want glibc to
> set __rseq_handled _after_ LD_PRELOAD ctors are executed.

I don't think so.  The LD_PRELOAD phase is not clearly delineated from
the non-preload phase.  So it's not clear to me what this would even
mean in practice.

Let me ask the key question again: Does it matter if code observes the
rseq area first without kernel support, and then with kernel support?
If we don't expect any problems immediately, we do not need to worry
much about the constructor ordering right now.  I expect that over time,
fixing this properly will become easier.

>> The final remaining case is static dlopen.  There is a copy of ld.so on
>> the dynamic side, but it is completely inactive and has never run.  I do
>> not think we need to support that because multi-threading does not work
>> reliably in this scenario, either.  However, we should skip rseq
>> registration in a nested libc (see the rtld_active function).
>
> So for SHARED, if (!rtld_active ()), we should indeed leave the state of
> __rseq_handled as it is, because we are within a nested inactive ld.so.

I think we should add __rseq_handled initialization to ld.so, so it will
only run once, ever.

It's the registration from libc.so which needs some care.  In
particular, we must not override an existing registration.

Thanks,
Florian
