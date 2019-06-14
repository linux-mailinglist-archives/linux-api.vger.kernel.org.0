Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91933459EB
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 12:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfFNKHC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 06:07:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbfFNKHC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 14 Jun 2019 06:07:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6AE37E421;
        Fri, 14 Jun 2019 10:06:56 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-180.str.redhat.com [10.33.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9C841001DC8;
        Fri, 14 Jun 2019 10:06:46 +0000 (UTC)
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
        <87muj2k4ov.fsf@oldenburg2.str.redhat.com>
        <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com>
        <87o93d4lqb.fsf@oldenburg2.str.redhat.com>
        <117220011.27079.1559663870037.JavaMail.zimbra@efficios.com>
        <87wohzorj0.fsf@oldenburg2.str.redhat.com>
        <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com>
        <914051741.43025.1560348011775.JavaMail.zimbra@efficios.com>
        <802638054.3032.1560506584705.JavaMail.zimbra@efficios.com>
Date:   Fri, 14 Jun 2019 12:06:45 +0200
In-Reply-To: <802638054.3032.1560506584705.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 14 Jun 2019 06:03:04 -0400
        (EDT)")
Message-ID: <87ftocwkei.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 14 Jun 2019 10:07:02 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Jun 12, 2019, at 4:00 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
>
>> ----- On Jun 10, 2019, at 4:43 PM, carlos carlos@redhat.com wrote:
>> 
>>> On 6/6/19 7:57 AM, Florian Weimer wrote:
>>>> Let me ask the key question again: Does it matter if code observes the
>>>> rseq area first without kernel support, and then with kernel support?
>>>> If we don't expect any problems immediately, we do not need to worry
>>>> much about the constructor ordering right now.  I expect that over time,
>>>> fixing this properly will become easier.
>>> 
>>> I just wanted to chime in and say that splitting this into:
>>> 
>>> * Ownership (__rseq_handled)
>>> 
>>> * Initialization (__rseq_abi)
>>> 
>>> Makes sense to me.
>>> 
>>> I agree we need an answer to this question of ownership but not yet
>>> initialized, to owned and initialized.
>>> 
>>> I like the idea of having __rseq_handled in ld.so.
>> 
>> Very good, so I'll implement this approach. Sorry for the delayed
>> feedback, I am traveling this week.
>
> I had issues with cases where application or LD_PRELOAD library also
> define the __rseq_handled symbol. They appear not to see the same
> address as the one initialized by ld.so.

What exactly did you do?  How did you determine the addresses?  How is
__rseq_handled defined in ld.so?

Thanks,
Florian
