Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD5F21F1E1
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 14:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGNMui (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jul 2020 08:50:38 -0400
Received: from mail.efficios.com ([167.114.26.124]:52120 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNMui (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jul 2020 08:50:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 99DB42BE09A;
        Tue, 14 Jul 2020 08:50:36 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zXOl0ZI5svpu; Tue, 14 Jul 2020 08:50:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2941A2BE099;
        Tue, 14 Jul 2020 08:50:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2941A2BE099
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594731036;
        bh=nvIDjmTX+khpvKBvlnyZZH5+M6lszAXQGxYRoBA/rj8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=k9lkooh3wWIP7V6Jx5Fm6vj0aPq5o7RkXYGf7rPEISHmgM516kNWHVKsh1UtXVWiR
         3H95Z1KvWFmHNyOXAFq59NcxuQoKPsPpTbZNFCkJ8cu77Tpiin5W8eISX83+WqLk1m
         +RsaLVSAGrgNKDXAG4P1j7KrfZzjUUf4v+SbtDjt7/EeGSHuXJg3r3tgkbThFJarL0
         tAlgXlgMy2QEY+Rlw7LkRrw+URztr9M4ZYgOyb/KTPZwAIM+C3Ws00NJcaXiZ392Mf
         jFVrrNmDy23hbhBntIar0CfHY707s36xY3cV+u+M2olLnKihel++pwPeT5DYVQPQkN
         uu7wxrY6yy7aA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xcJDdzIqV-Ep; Tue, 14 Jul 2020 08:50:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 174372BE193;
        Tue, 14 Jul 2020 08:50:36 -0400 (EDT)
Date:   Tue, 14 Jul 2020 08:50:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>
Message-ID: <131549905.11442.1594731035989.JavaMail.zimbra@efficios.com>
In-Reply-To: <87mu42bepq.fsf@oldenburg2.str.redhat.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <20200714030348.6214-3-mathieu.desnoyers@efficios.com> <87mu42bepq.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Allow extending struct rseq
Thread-Index: blo1BcVxD31RP8IJoOel3hXCDJsknQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 14, 2020, at 5:58 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> +	/*
>> +	 * Very last field of the structure, to calculate size excluding padding
>> +	 * with offsetof().
>> +	 */
>> +	char end[];
>>  } __attribute__((aligned(4 * sizeof(__u64))));
> 
> This makes the header incompatible with standard C++.

One alternative would be to add a helper to compute the effective size on c++, e.g.:

/* Always updated with struct rseq_cs declaration.  */
#define rseq_last_field kernel_size

static inline size_t rseq_effective_size(void)
{
    return offsetof(struct rseq, rseq_last_field) + sizeof(((struct rseq *)NULL)->rseq_last_field);
}

> 
> How are extensions going to affect the definition of struct rseq,
> including its alignment?

The alignment will never decrease. If the structure becomes large enough
its alignment could theoretically increase. Would that be an issue ?


> As things stand now, glibc 2.32 will make the size and alignment of
> struct rseq part of its ABI, so it can't really change after that.

Can the size and alignment of a structure be defined as minimum alignment
and size values ? For instance, those would be invariant for a given glibc
version (if we always use the internal struct rseq declaration), but could
be increased in future versions.

> With a different approach, we can avoid making the symbol size part of
> the ABI, but then we cannot use the __rseq_abi TLS symbol.  As a result,
> interoperability with early adopters would be lost.

Do you mean with a function "getter", and then keeping that pointer around
in a per-user TLS ? I would prefer to avoid that because it adds an extra
pointer dereference on a fast path.

> One way to avoid this problem would be for every library to register its
> own rseq area, of the appropriate size.  Then process-wide coordination
> in userspace would not be needed.

I did propose the code to do just that in my initial rseq implementations, but
the idea was shutdown by kernel maintainers because it required the kernel to
handle a linked-list of rseq areas per thread, which was more complex within
the kernel.

Thanks,

Mathieu

> 
> Thanks,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
