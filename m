Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC11F1BBE4A
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2020 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgD1MyX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Apr 2020 08:54:23 -0400
Received: from albireo.enyo.de ([37.24.231.21]:48706 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgD1MyW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 28 Apr 2020 08:54:22 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jTPka-0002WQ-A9; Tue, 28 Apr 2020 12:54:12 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jTPkT-00031t-02; Tue, 28 Apr 2020 14:54:05 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        carlos <carlos@redhat.com>, Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C startup and thread creation (v17)
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
        <87ees9z417.fsf@mid.deneb.enyo.de>
        <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com>
        <87zhawvphv.fsf@mid.deneb.enyo.de>
        <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
        <87ftcnrf7d.fsf@mid.deneb.enyo.de>
        <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com>
        <878sifrdo0.fsf@mid.deneb.enyo.de>
        <190402462.72430.1588077816717.JavaMail.zimbra@efficios.com>
Date:   Tue, 28 Apr 2020 14:54:04 +0200
In-Reply-To: <190402462.72430.1588077816717.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 28 Apr 2020 08:43:36 -0400
        (EDT)")
Message-ID: <87tv13py8j.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Apr 28, 2020, at 8:35 AM, Florian Weimer fw@deneb.enyo.de wrote:
>
>> * Mathieu Desnoyers:
>> 
>>> One issue I'm currently facing when running "make check": because
>>> nptl/tst-rseq-nptl.c uses pthread_cancel(), I run into an Abort
>>> with:
>>>
>>> libgcc_s.so.1 must be installed for pthread_cancel to work
>>> Didn't expect signal from child: got `Aborted'
>> 
>> This is really unusual.  Is the affected test statically linked?
>
> I built glibc without specifying anything particular, and ran
> "make check". It indeed seems to be dynamically linked to libc:
>
> ldd tst-rseq-nptl
> ./tst-rseq-nptl: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found (required by ./tst-rseq-nptl)
> linux-vdso.so.1 (0x00007ffd3a2f3000)
> libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f0527560000)
> libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f052716f000)
> /home/efficios/glibc-test5/lib/ld-linux-x86-64.so.2 => /lib64/ld-linux-x86-64.so.2 (0x00007f0527986000)

That's expected if the installed glibc is older than the built glibc.

> After make check I have:
>
> cat tst-rseq-nptl.test-result 
> FAIL: nptl/tst-rseq-nptl
> original exit status 134

What's in the tst-rseq-nptl.out file?

> And if I run
>
> ./tst-rseq-nptl
>
> Then I get
>
> libgcc_s.so.1 must be installed for pthread_cancel to work
> Didn't expect signal from child: got `Aborted'
> libgcc_s.so.1 must be installed for pthread_cancel to work
> Aborted (core dumped)

I'm puzzled why you don't get a GLIBC_2.32 version error in this case.
Do you build with --enable-hardcoded-path-in-tests?

> Same result if I do ./testrun.sh nptl/tst-rseq-nptl

That one definitely should work.

I expect you might see this if libgcc_s.so.1 is installed into a
multiarch subdirectory that upstream glibc does not search.  (The
Debian patches are unfortunately not upstream.)

I think on my system, the built glibc can find the system libgcc_s via
/etc/ld.so.cache, so I haven't seen this issue yet.
