Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808121FF28C
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2020 15:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgFRNDJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jun 2020 09:03:09 -0400
Received: from mail.efficios.com ([167.114.26.124]:47862 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgFRNDI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jun 2020 09:03:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9E35E2CB436;
        Thu, 18 Jun 2020 09:03:07 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Q_N-iFXQcfuX; Thu, 18 Jun 2020 09:03:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4AD162CB604;
        Thu, 18 Jun 2020 09:03:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4AD162CB604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1592485387;
        bh=8gWLFXHOJUpku+xtywyZMhyrAoZEdReQUERAiZw8Wug=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=eNBHkIRwLJUzBAeavqkz4XJ/BS4whc1v36WwKFkdk8My/tyzuPzmE7YLcK86x2K8e
         BYcAeV6+EWT5ezTAtuoxLZUh37oteVuYwfm/IOWhZX+IR689s3jdJuAeN7psTo0GQu
         Z0e6o6TOKfHEM/9ILqKsGlgkP6RfYGA2Sq0/RrafkAy6W6xnCkbb6N1mmXvvTDnqcE
         NqQmIxtcbbQLypATQZbGCslLNjR15ARJC6fu4icZfmMMn3aX5qWeefpKDTuqslHxu3
         uVoN7T8GkHc1s3o7O/8Hhhkn4uKQUT2nczpeBgod/JycEremkeuLQIOTGdKt7UNi98
         HJyF9sHqSIROA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2fwGZoJZoEOb; Thu, 18 Jun 2020 09:03:07 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 353362CB0EE;
        Thu, 18 Jun 2020 09:03:07 -0400 (EDT)
Date:   Thu, 18 Jun 2020 09:03:07 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ben Maurer <bmaurer@fb.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>
Message-ID: <906553413.6099.1592485387108.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200618122213.GQ4066@arm.com>
References: <20200527185130.5604-1-mathieu.desnoyers@efficios.com> <87d06gxsla.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.2006031718070.7179@digraph.polyomino.org.uk> <188671972.53608.1591269056445.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.2006041745360.8237@digraph.polyomino.org.uk> <419546979.1229.1591897672174.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.2006112026090.18393@digraph.polyomino.org.uk> <20200618122213.GQ4066@arm.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v20)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v20)
Thread-Index: brALBVk5nps/waYHI5PMCjDnnv99CA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 18, 2020, at 8:22 AM, Szabolcs Nagy szabolcs.nagy@arm.com wrote:

> The 06/11/2020 20:26, Joseph Myers wrote:
>> On Thu, 11 Jun 2020, Mathieu Desnoyers wrote:
>> > I managed to get a repository up and running for librseq, and have integrated
>> > the rseq.2 man page with comments from Michael Kerrisk here:
>> > 
>> > https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/man/rseq.2
>> > 
>> > Is that a suitable URL ? Can we simply point to it from glibc's manual ?
>> 
>> Yes, that seems something reasonable to link to.
> 
> is there work to make the usage of rseq critical
> sections portable? (e.g. transactional memory
> critical section has syntax in gcc, but that
> doesn't require straight line code with
> begin/end/abort labels in a particular layout.)
> 
> the macros and inline asm in rseq-*.h are not
> too nice, but if they can completely hide the
> non-portable bits then i guess that works.

My goal with librseq is indeed to provide static inlines
which hide the architecture-specific ugliness of rseq
critical section assembly code behind an API which can be
used from all supported architectures for most of the
known use-cases, so only very specific use-case would
have to craft their own assembly.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
