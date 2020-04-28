Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723021BBDC4
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2020 14:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgD1Mnj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Apr 2020 08:43:39 -0400
Received: from mail.efficios.com ([167.114.26.124]:54978 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgD1Mni (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Apr 2020 08:43:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5E04A27C7EF;
        Tue, 28 Apr 2020 08:43:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hZc0DgyNWp2G; Tue, 28 Apr 2020 08:43:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E7F4527CC00;
        Tue, 28 Apr 2020 08:43:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E7F4527CC00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588077817;
        bh=pSTcinJ2v7bl76jpCZ7vaBeyRr3WL3E3P21vWCpzgGU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EGWeaswS4ocPk9VaLnAlmAMyOHKWdqDVG4CeUIM8UcBA8T8zB5MK6tRrNiqr7cxrH
         AZDRNbIIg8Y5IunLtdc2Mod4yNLQI0/gkYnUUMDhg4yPGh7Lb7wG1ektBgp0YKvULd
         g8EN544rF9X2Okc4qMVeg/3R2U/Zc+amjRt3YT4fSJ1Vuibh81+n4ps+i0dSFT5YEE
         up24SWzxiAlYUuu0pvNAjtWZjOgflA1SDATMLSvnF6q9k1NhXxM1nOWia7ZtlWS1kA
         lyOxxnjaLODGCBe5CM0bjI8l01eCrFub+LVDw7walDQJTrKPYMFyscvDrhjL/RY/K1
         45NZ0R/lWC8Bg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id laL4SbVSBY_R; Tue, 28 Apr 2020 08:43:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D3EF427C753;
        Tue, 28 Apr 2020 08:43:36 -0400 (EDT)
Date:   Tue, 28 Apr 2020 08:43:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
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
Message-ID: <190402462.72430.1588077816717.JavaMail.zimbra@efficios.com>
In-Reply-To: <878sifrdo0.fsf@mid.deneb.enyo.de>
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com> <87ees9z417.fsf@mid.deneb.enyo.de> <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com> <87zhawvphv.fsf@mid.deneb.enyo.de> <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com> <87ftcnrf7d.fsf@mid.deneb.enyo.de> <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com> <878sifrdo0.fsf@mid.deneb.enyo.de>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C
 startup and thread creation (v17)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v17)
Thread-Index: F5B1mq4gIeyZb0nt5SE+TvVdhXfIog==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 28, 2020, at 8:35 AM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
> 
>> One issue I'm currently facing when running "make check": because
>> nptl/tst-rseq-nptl.c uses pthread_cancel(), I run into an Abort
>> with:
>>
>> libgcc_s.so.1 must be installed for pthread_cancel to work
>> Didn't expect signal from child: got `Aborted'
> 
> This is really unusual.  Is the affected test statically linked?

I built glibc without specifying anything particular, and ran
"make check". It indeed seems to be dynamically linked to libc:

ldd tst-rseq-nptl
./tst-rseq-nptl: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found (required by ./tst-rseq-nptl)
linux-vdso.so.1 (0x00007ffd3a2f3000)
libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f0527560000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f052716f000)
/home/efficios/glibc-test5/lib/ld-linux-x86-64.so.2 => /lib64/ld-linux-x86-64.so.2 (0x00007f0527986000)

After make check I have:

cat tst-rseq-nptl.test-result 
FAIL: nptl/tst-rseq-nptl
original exit status 134

And if I run

./tst-rseq-nptl

Then I get

libgcc_s.so.1 must be installed for pthread_cancel to work
Didn't expect signal from child: got `Aborted'
libgcc_s.so.1 must be installed for pthread_cancel to work
Aborted (core dumped)

Same result if I do ./testrun.sh nptl/tst-rseq-nptl

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
