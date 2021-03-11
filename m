Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D6337ABE
	for <lists+linux-api@lfdr.de>; Thu, 11 Mar 2021 18:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCKRZR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Mar 2021 12:25:17 -0500
Received: from mail.efficios.com ([167.114.26.124]:36842 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhCKRYq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Mar 2021 12:24:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 660EC28E668;
        Thu, 11 Mar 2021 12:24:45 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bFUnkYnH5NPu; Thu, 11 Mar 2021 12:24:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0BC3028E931;
        Thu, 11 Mar 2021 12:24:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0BC3028E931
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1615483485;
        bh=0es5nw/ggWUoYDySiqDbYKjmQxvlEcsoAK8a6oHJBbQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IeKl8IYrw42aGjiqrJEfGlXM2anjABzpfM/CVRUpHyaL7Z0jufWQ35tribep9SzTz
         f2vxuFsFA+/fagA50VRmNV1dsnmMtzwHS6qolrz41XnfQ1j5U1I20VcMBzxKUqz5fN
         g4vyWTMs8h/Ss6lT6tz9UaRDKSmCgpQ137OyJyzLwSocsmNtAjmBTvQDxjRoMvCssE
         X+sPtfiiUNkPsnDH2/VwXSi4EZV6QeEKYkXbG+mvHvDojgLi4PrUn6e/arUWVZr4PG
         DO0rNb5YOAWZbj1U9oeRa3QZugXtV19oHvd6QXB53CZ/CZf2eXy98mdpIC9yLrdL0T
         rG2oAia+8lA6Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ptpoVccYqNze; Thu, 11 Mar 2021 12:24:44 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id EAC7228E4FF;
        Thu, 11 Mar 2021 12:24:44 -0500 (EST)
Date:   Thu, 11 Mar 2021 12:24:44 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Piotr Figiel <figiel@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Florian Weimer <fweimer@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, emmir <emmir@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1972946676.5785.1615483484807.JavaMail.zimbra@efficios.com>
In-Reply-To: <YEpKoa9PgjffO7Q5@hirez.programming.kicks-ass.net>
References: <20210226135156.1081606-1-figiel@google.com> <1173189328.5477.1615474316906.JavaMail.zimbra@efficios.com> <YEpKoa9PgjffO7Q5@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH v2] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Thread-Index: bG+JyMYCodWp6UM/Hbxvt6m6jbkUEw==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Mar 11, 2021, at 11:51 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Mar 11, 2021 at 09:51:56AM -0500, Mathieu Desnoyers wrote:
>> 
>> 
>> ----- On Feb 26, 2021, at 8:51 AM, Piotr Figiel figiel@google.com wrote:
>> 
>> > For userspace checkpoint and restore (C/R) a way of getting process state
>> > containing RSEQ configuration is needed.
>> > 
>> > There are two ways this information is going to be used:
>> > - to re-enable RSEQ for threads which had it enabled before C/R
>> > - to detect if a thread was in a critical section during C/R
>> > 
>> > Since C/R preserves TLS memory and addresses RSEQ ABI will be restored
>> > using the address registered before C/R.
>> > 
>> > Detection whether the thread is in a critical section during C/R is needed
>> > to enforce behavior of RSEQ abort during C/R. Attaching with ptrace()
>> > before registers are dumped itself doesn't cause RSEQ abort.
>> > Restoring the instruction pointer within the critical section is
>> > problematic because rseq_cs may get cleared before the control is passed
>> > to the migrated application code leading to RSEQ invariants not being
>> > preserved. C/R code will use RSEQ ABI address to find the abort handler
>> > to which the instruction pointer needs to be set.
>> > 
>> > To achieve above goals expose the RSEQ ABI address and the signature value
>> > with the new ptrace request PTRACE_GET_RSEQ_CONFIGURATION.
>> > 
>> > This new ptrace request can also be used by debuggers so they are aware
>> > of stops within restartable sequences in progress.
>> > 
>> > Signed-off-by: Piotr Figiel <figiel@google.com>
>> > Reviewed-by: Michal Miroslaw <emmir@google.com>
>> 
>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> How do we route this? Do I stick this in tip/sched/core as being an rseq
> patch?

Sure, it's fine with me, thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
