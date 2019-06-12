Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40FC429AA
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 16:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfFLOoN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 10:44:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbfFLOoN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 12 Jun 2019 10:44:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CD033087958;
        Wed, 12 Jun 2019 14:44:07 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (unknown [10.36.118.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C4DF6061E;
        Wed, 12 Jun 2019 14:43:59 +0000 (UTC)
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
        <1329439108.43041.1560348962006.JavaMail.zimbra@efficios.com>
        <87blz27uio.fsf@oldenburg2.str.redhat.com>
        <512441263.43096.1560350163180.JavaMail.zimbra@efficios.com>
Date:   Wed, 12 Jun 2019 16:43:58 +0200
In-Reply-To: <512441263.43096.1560350163180.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Wed, 12 Jun 2019 10:36:03 -0400
        (EDT)")
Message-ID: <8736ke7tjl.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 12 Jun 2019 14:44:12 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Jun 12, 2019, at 4:22 PM, Florian Weimer fweimer@redhat.com wrote:
>
>> * Mathieu Desnoyers:
>> 
>>>> It's the registration from libc.so which needs some care.  In
>>>> particular, we must not override an existing registration.
>>>
>>> OK, so it could check if __rseq_abi.cpu_id is -1, and only
>>> perform registration if it is the case. Or do you have another
>>> approach in mind ?
>> 
>> No, __rseq_abi will not be shared with the outer libc, so the inner libc
>> will always see -1 there, even if the outer libc has performed
>> registration.
>> 
>> libio/vtables.c has some example what you can do:
>> 
>>  /* In case this libc copy is in a non-default namespace, we always
>>     need to accept foreign vtables because there is always a
>>     possibility that FILE * objects are passed across the linking
>>     boundary.  */
>>  {
>>    Dl_info di;
>>    struct link_map *l;
>>    if (!rtld_active ()
>>        || (_dl_addr (_IO_vtable_check, &di, &l, NULL) != 0
>>            && l->l_ns != LM_ID_BASE))
>>      return;
>>  }
>> 
>> _IO_vtable_check would have to be replaced with your own function; the
>> actual function doesn't really matter.
>> 
>> The rtld_active check covers the static dlopen case, where
>> rtld_active () is false in the inner libc.
>
> Then out of curiosity, would it also work if I check for
>
> if (!__libc_multiple_libcs)
>
> in LIBC_START_MAIN ?

In my experience, __libc_multiple_libcs is not reliable.  I have not yet
figured out why.

Thanks,
Florian
