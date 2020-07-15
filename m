Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9FE220F0E
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgGOOUT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 10:20:19 -0400
Received: from mail.efficios.com ([167.114.26.124]:42852 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOOUS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 10:20:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BA731282582;
        Wed, 15 Jul 2020 10:20:16 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eZg8zfz8LZ71; Wed, 15 Jul 2020 10:20:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 63C86282581;
        Wed, 15 Jul 2020 10:20:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 63C86282581
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594822816;
        bh=8pyjh3w3gqmbApSqfgRB3ksH58blRuuNrO9qaoBB2P8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NQOp04meYobOrNmaL5O+BPNwVBabfCQhcnNrZ30VkCIserTPFvBIu8bKMXfyaARMk
         my4A6xnXOOVbqsNTiZ0qH/+76r7xVJ3UX0zWkYcbF+YYPVBOcZ8ZuUsi8YPYYfw6lR
         mhRFFbO+JNHo8j4MvP25Ia06jlh3khYCXQyYzceFb45uxDtRewmnOolVFLluS9xz8A
         DiWCEz7H/6RjWNVVxtHxs1CQGMTA8vJQYqZLixXz2e67TmyIUAsL/I3pNhTqsJg+jX
         JSN+NoUEQuhuqr94Lycw1GfwCw5DCelZ9g9zIZUFquatV953iKHbYfXaYCTqTca5lG
         tfNyFO5vlhuvQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uVk_T4vgAKIJ; Wed, 15 Jul 2020 10:20:16 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 557522823A1;
        Wed, 15 Jul 2020 10:20:16 -0400 (EDT)
Date:   Wed, 15 Jul 2020 10:20:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Florian Weimer <fweimer@redhat.com>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1765484769.14232.1594822816264.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200715135554.4q6aamx4iqd4mnqh@wittgenstein>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <2452161.11491.1594732791558.JavaMail.zimbra@efficios.com> <71f08b3a-56f5-0e0f-53b0-cc680f7e8181@redhat.com> <2053637148.14136.1594818777608.JavaMail.zimbra@efficios.com> <87y2nk29rp.fsf@oldenburg2.str.redhat.com> <882700738.14181.1594819884049.JavaMail.zimbra@efficios.com> <87mu4028uk.fsf@oldenburg2.str.redhat.com> <20200715135554.4q6aamx4iqd4mnqh@wittgenstein>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Allow extending struct rseq
Thread-Index: dcnj3oHgdUUwDl0MIo+e+CqqnEuWyQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 15, 2020, at 9:55 AM, Christian Brauner christian.brauner@ubuntu.com wrote:

> On Wed, Jul 15, 2020 at 03:42:11PM +0200, Florian Weimer wrote:
>> * Mathieu Desnoyers:
>> 
>> > So indeed it could be done today without upgrading the toolchains by
>> > writing custom assembler for each architecture to get the thread's
>> > struct rseq. AFAIU the ABI to access the thread pointer is fixed for
>> > each architecture, right ?
>> 
>> Yes, determining the thread pointer and access initial-exec TLS
>> variables is baked into the ABI.
>> 
>> > How would this allow early-rseq-adopter libraries to interact with
>> > glibc ?
>> 
>> Under all extension proposals I've seen so far, early adopters are
>> essentially incompatible with glibc rseq registration.  I don't think
>> you can have it both ways.
> 
> Who are the early adopters? And if we aren't being compatible with them
> under the extensible schemes proposed we should be able to achieve
> compatibility with non-early adopters, right? Which I guess is more
> important. (I still struggle to make sense what qualifies as an early
> adopter/what the difference to a non-early adopter is.)

Early adopter libraries and applications are meant to be able to use rseq
without requiring upgrade of the entire environment to a newer glibc.

I maintain early adopter projects (liburcu, lttng-ust) which postpone using
rseq outside of prototype branches until we agree on an ABI to share
__rseq_abi between glibc and early adopter libraries. The last thing I
want is for those projects to break when an end-user upgrades their
glibc. tcmalloc is another early adopter which have less strict
compatibility requirements: they are OK with breaking changes requiring
upgrading and rebuilding tcmalloc.

Indeed, until we cast in stone the layout of struct rseq as exposed by
glibc, I think we have some freedom in our definition of "early adopter",
because pretty much every relevant open source project which want to use
rseq is waiting on glibc to define that ABI, to use rseq either as an
early-adopter or through a dependency on newer glibc.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
