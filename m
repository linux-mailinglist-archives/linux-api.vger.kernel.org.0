Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B1C215E0B
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgGFSLo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 14:11:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25560 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729622AbgGFSLo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 14:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594059102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=od9kR8piiAvx4jR5kzxwXvNi7bWoe6/TcUiqSxKR2s4=;
        b=JAyBNiGvnjVQKMUdBRK9WjGeTwiqvQwCuC0NS2m0jFoIOR2QSTOCiw3Fyh4Am2ghJyXizc
        kukqp6ByqmFMO8CGC7nXGw4harCzIGoZk+5eT1XX5XAPmY3Xbtg6yGAinWQ7Iz9LDNHmmt
        mRLCMVIub6+b0eqZhQD9dprlzzfak2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-PmdPXVQlP5qp4MZ3G1noig-1; Mon, 06 Jul 2020 14:11:39 -0400
X-MC-Unique: PmdPXVQlP5qp4MZ3G1noig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D50A0BD8;
        Mon,  6 Jul 2020 18:11:37 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-118.ams2.redhat.com [10.36.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74C1C10021B3;
        Mon,  6 Jul 2020 18:11:31 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH 2/3] Linux: Use rseq in sched_getcpu if available (v9)
References: <20200629190036.26982-1-mathieu.desnoyers@efficios.com>
        <20200629190036.26982-3-mathieu.desnoyers@efficios.com>
        <877dvg4ud4.fsf@oldenburg2.str.redhat.com>
        <942999672.22574.1594046978937.JavaMail.zimbra@efficios.com>
        <1679448037.22891.1594056826859.JavaMail.zimbra@efficios.com>
        <87k0zg3535.fsf@oldenburg2.str.redhat.com>
        <1449254526.22910.1594058539512.JavaMail.zimbra@efficios.com>
Date:   Mon, 06 Jul 2020 20:11:29 +0200
In-Reply-To: <1449254526.22910.1594058539512.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 6 Jul 2020 14:02:19 -0400
        (EDT)")
Message-ID: <87blks344u.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Jul 6, 2020, at 1:50 PM, Florian Weimer fweimer@redhat.com wrote:
>
>> * Mathieu Desnoyers:
>> 
>>> Now we need to discuss how we introduce that fix in a way that will
>>> allow user-space to trust the __rseq_abi.cpu_id field's content.
>> 
>> I don't think that's necessary.  We can mention it in the glibc
>> distribution notes on the wiki.
>> 
>>> The usual approach to kernel bug fixing is typically to push the fix,
>>> mark it for stable kernels, and expect everyone to pick up the
>>> fixes. I wonder how comfortable glibc would be to replace its
>>> sched_getcpu implementation with a broken-until-fixed kernel rseq
>>> implementation without any mechanism in place to know whether it can
>>> trust the value of the cpu_id field. I am extremely reluctant to do
>>> so.
>> 
>> We have already had similar regressions in sched_getcpu, and we didn't
>> put anything into glibc to deal with those.
>
> Was that acceptable because having a wrong cpu number would never trigger
> corruption, only slowdowns ?

First of all, it's a kernel bug.  It's rare that we put workarounds for
kernel bugs into glibc.

And yes, in pretty much all cases it's just a performance issue for
sched_getcpu.  When you know the CPU ID of a thread due to pinning to a
single CPU, why would you call sched_getcpu?  (That's the case where you
could get corruption in theory.)

> In the case of rseq, having the wrong cpu_id value is a real issue
> which will lead to corruption and crashes. So I maintain my reluctance
> to introduce the fix without any way for userspace to know whether the
> cpu_id field value is reliable.

Yes, for rseq itself, the scenario is somewhat different.  Still, it's
just another kernel bug.  There will be others. 8-/

From a schedule point of view, it looks tough to get the magic flag into
the mainline kernel in time for the upcoming glibc 2.32 release.  If you
insist on registering rseq only if the bug is not present, we'll
probably have to back out some or all of the rseq changes.

Thanks,
Florian

