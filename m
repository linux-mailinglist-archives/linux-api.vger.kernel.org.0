Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C55220DC5
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgGONM7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 09:12:59 -0400
Received: from mail.efficios.com ([167.114.26.124]:49496 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgGONM7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 09:12:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1A2F7281847;
        Wed, 15 Jul 2020 09:12:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id napCJTeg1Q0z; Wed, 15 Jul 2020 09:12:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BF7F2281846;
        Wed, 15 Jul 2020 09:12:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BF7F2281846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594818777;
        bh=LnCa9Kr94GXO3BET3VyB1xLtyWYGkc9KxiXdaJE05S8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NgBZLj/63aQIAwjTDb+VnNQiIIxdZ0tvxQ1V+FQPvTiuJN887zN8gLsrCxOJaCN3K
         MZSlB+MiHiGRpLj4qNJhA6GrPpqqWVvsfz1pjxOkzlDP8GOBlorOB85cKVg7tQwV0j
         /BcFJQROTOndn36iSyfDM7kzLICqitQoa3PJntsLOyOgoF7D+rVJ0GwLCKqL+JKN9j
         gWj4CqeiXF9R7xqarNOJRwBNB0eI28vl6dWYjBmvYycfipMb8eI4zM7MEmN3WHBntf
         wu1c8YMAInZGg0CaihtAxDPdM95cRXe26X7Ayv2siPKZSQQJpblgrxYSyx1z72bCYj
         qvT4pIhqI6FcQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JF1Uh8Y6dtqf; Wed, 15 Jul 2020 09:12:57 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id AED50281B17;
        Wed, 15 Jul 2020 09:12:57 -0400 (EDT)
Date:   Wed, 15 Jul 2020 09:12:57 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     carlos <carlos@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <2053637148.14136.1594818777608.JavaMail.zimbra@efficios.com>
In-Reply-To: <71f08b3a-56f5-0e0f-53b0-cc680f7e8181@redhat.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <20200714030348.6214-3-mathieu.desnoyers@efficios.com> <87mu42bepq.fsf@oldenburg2.str.redhat.com> <131549905.11442.1594731035989.JavaMail.zimbra@efficios.com> <87a7028d5u.fsf@oldenburg2.str.redhat.com> <2452161.11491.1594732791558.JavaMail.zimbra@efficios.com> <71f08b3a-56f5-0e0f-53b0-cc680f7e8181@redhat.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Allow extending struct rseq
Thread-Index: 1MYp5kfIfB2JXymSbY4v1NcGryrEAQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 14, 2020, at 5:30 PM, carlos carlos@redhat.com wrote:

> On 7/14/20 9:19 AM, Mathieu Desnoyers wrote:
>> Is there an arch-agnostic way to get the thread pointer from user-space code ?
>> That
>> would be needed by all rseq critical section implementations.
> 
> Yes, and no. We have void *__builtin_thread_pointer (void), but
> few architectures implement the builtin so we'd have to go through
> a round of compiler updates and backports. All targets know how to
> access the thread pointer because the compiler has to generate
> IE-mode accesses to the TLS variables.

Practically speaking, I suspect this would mean postponing availability of
rseq for widely deployed applications for a few more years ? I can very well
see end users upgrading their kernel and using an early-adoption library
to use rseq today, but requiring to upgrade the entire toolchain will likely
postpone adoption to many years from now.

It would be good to start getting feedback from rseq users so we can progress
on the system call feature development. Unfortunately everything has been in
a stand-still for the past years due to lack of rseq registration coordination
in user-space.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
