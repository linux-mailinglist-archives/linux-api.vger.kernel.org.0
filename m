Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F8C215DE2
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 20:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgGFSCV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 14:02:21 -0400
Received: from mail.efficios.com ([167.114.26.124]:53772 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbgGFSCV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 14:02:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 144102D976E;
        Mon,  6 Jul 2020 14:02:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aOs3hzRbu2n0; Mon,  6 Jul 2020 14:02:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AA5042D976A;
        Mon,  6 Jul 2020 14:02:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AA5042D976A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594058539;
        bh=eTqd6Xn+dXRfSXKbnUK68DewegH7Ev19o9g68FSJQUM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Kq92x25PaND72Sm8RqSLIsUdUqEIhwR7O5SlXVKLDT+3c5Au5XImAStWJPfWkLi3i
         X0hdMy1qUtfBTtNqMPeTcU+0SbPeYaxYIRUD2dZ+jOhqgoDCCosBPEpR8Jgb1dG0ny
         OQugbi8RDe31jVoJNKGmgIO3+esdGiak+wvqUOdo9dFXxtS2l5W0wrlGq6uLl/x4Bw
         LuR45zOBhND6X+xxTclr4iM5iG4h9KLgLrSg7VueTSFjTO0WkBJswgh9lYQuiqBGCx
         KULQZgersE5Vc4GlLYzN57QBQ5zyrqWfhR5RtSXa7Vkz/2vTO6cwmEQUuA76zOf5rF
         fVyb17drlqZIQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id duwtraNlSDBq; Mon,  6 Jul 2020 14:02:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9766C2D96F6;
        Mon,  6 Jul 2020 14:02:19 -0400 (EDT)
Date:   Mon, 6 Jul 2020 14:02:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1449254526.22910.1594058539512.JavaMail.zimbra@efficios.com>
In-Reply-To: <87k0zg3535.fsf@oldenburg2.str.redhat.com>
References: <20200629190036.26982-1-mathieu.desnoyers@efficios.com> <20200629190036.26982-3-mathieu.desnoyers@efficios.com> <877dvg4ud4.fsf@oldenburg2.str.redhat.com> <942999672.22574.1594046978937.JavaMail.zimbra@efficios.com> <1679448037.22891.1594056826859.JavaMail.zimbra@efficios.com> <87k0zg3535.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 2/3] Linux: Use rseq in sched_getcpu if available (v9)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3928)
Thread-Topic: Linux: Use rseq in sched_getcpu if available (v9)
Thread-Index: 5ba6+LwPPg7XbV9h0TH6wCD1RjoFCA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 6, 2020, at 1:50 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> Now we need to discuss how we introduce that fix in a way that will
>> allow user-space to trust the __rseq_abi.cpu_id field's content.
> 
> I don't think that's necessary.  We can mention it in the glibc
> distribution notes on the wiki.
> 
>> The usual approach to kernel bug fixing is typically to push the fix,
>> mark it for stable kernels, and expect everyone to pick up the
>> fixes. I wonder how comfortable glibc would be to replace its
>> sched_getcpu implementation with a broken-until-fixed kernel rseq
>> implementation without any mechanism in place to know whether it can
>> trust the value of the cpu_id field. I am extremely reluctant to do
>> so.
> 
> We have already had similar regressions in sched_getcpu, and we didn't
> put anything into glibc to deal with those.

Was that acceptable because having a wrong cpu number would never trigger
corruption, only slowdowns ?

In the case of rseq, having the wrong cpu_id value is a real issue which
will lead to corruption and crashes. So I maintain my reluctance to introduce
the fix without any way for userspace to know whether the cpu_id field
value is reliable.

What were the reasons why it was OK to have this kind of regression in
sched_getcpu in the past, and are they still valid in the context of
rseq ?

Thanks,

Mathieu

> 
> Just queue the fix for the stable kernels.  I expect that all
> distributions track stable kernel branches in some way, so just put into
> the kernel commit message that this commit is needed for a working
> sched_getcpu in glibc 2.32 and later.
> 
> Once the upstream fix is in Linus' tree, I'm going to file a request to
> backport the fix into the Red Hat Enterprise Linux 8.
> 
> Thanks for finding the root cause so quickly,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
