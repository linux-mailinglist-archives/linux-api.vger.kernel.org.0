Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7631BC219
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2020 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgD1O6V (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Apr 2020 10:58:21 -0400
Received: from mail.efficios.com ([167.114.26.124]:35546 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgD1O6V (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Apr 2020 10:58:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 00FE927D8A1;
        Tue, 28 Apr 2020 10:58:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qyS4QE5KyFE6; Tue, 28 Apr 2020 10:58:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8AD9627D8A0;
        Tue, 28 Apr 2020 10:58:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8AD9627D8A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588085899;
        bh=C19Y7Q0zQ58ch1DAMA7Z2tNyypEx+FfZlqejx6D0qFc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WKMti1qlpDedWfwpWf8tT+yqjC1KtMkJ84KO1DLvz5R71ROSA9EI69dMxFpyy5aG0
         cbmZp45DtkwMJYRjHXqq4ZK2qB90alYMOQdGkwRELT0Kr5vD4RtyeE5cZ3PuQOEo4w
         Rcll+HM9PVkMAF5F7jAGagwznMxCi43fgoc/mQBuJFZsivC1hgc7RHan2iURMui+k6
         N7pcYNU+AjCDsw3aAZRZaORjT6xZQPWgs7oeSQDZXX5vsoFDX04AUBcHo63Fhr9xlM
         ltf6wzFQNfhhMssoCnqgGW45Nc0wP6/GFbUEVhh5uBDIQMhkbHfWPKpsAgBsr1uZcQ
         FxT+VSZGalHag==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uHieuJrZs_Il; Tue, 28 Apr 2020 10:58:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 73AC527DB03;
        Tue, 28 Apr 2020 10:58:19 -0400 (EDT)
Date:   Tue, 28 Apr 2020 10:58:19 -0400 (EDT)
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
Message-ID: <437249723.72685.1588085899422.JavaMail.zimbra@efficios.com>
In-Reply-To: <87tv13py8j.fsf@mid.deneb.enyo.de>
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com> <87zhawvphv.fsf@mid.deneb.enyo.de> <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com> <87ftcnrf7d.fsf@mid.deneb.enyo.de> <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com> <878sifrdo0.fsf@mid.deneb.enyo.de> <190402462.72430.1588077816717.JavaMail.zimbra@efficios.com> <87tv13py8j.fsf@mid.deneb.enyo.de>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C
 startup and thread creation (v17)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v17)
Thread-Index: kRSloVX/dc1bhqo8Fu56s9W7NvdZew==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 28, 2020, at 8:54 AM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Apr 28, 2020, at 8:35 AM, Florian Weimer fw@deneb.enyo.de wrote:
>>
>>> * Mathieu Desnoyers:
>>> 
>>>> One issue I'm currently facing when running "make check": because
>>>> nptl/tst-rseq-nptl.c uses pthread_cancel(), I run into an Abort
>>>> with:
>>>>
>>>> libgcc_s.so.1 must be installed for pthread_cancel to work
>>>> Didn't expect signal from child: got `Aborted'
>>> 
>>> This is really unusual.  Is the affected test statically linked?
>>
>> I built glibc without specifying anything particular, and ran
>> "make check". It indeed seems to be dynamically linked to libc:
>>
>> ldd tst-rseq-nptl
>> ./tst-rseq-nptl: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found
>> (required by ./tst-rseq-nptl)
>> linux-vdso.so.1 (0x00007ffd3a2f3000)
>> libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f0527560000)
>> libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f052716f000)
>> /home/efficios/glibc-test5/lib/ld-linux-x86-64.so.2 =>
>> /lib64/ld-linux-x86-64.so.2 (0x00007f0527986000)
> 
> That's expected if the installed glibc is older than the built glibc.
> 
>> After make check I have:
>>
>> cat tst-rseq-nptl.test-result
>> FAIL: nptl/tst-rseq-nptl
>> original exit status 134
> 
> What's in the tst-rseq-nptl.out file?

It contains:

Didn't expect signal from child: got `Aborted'

>> And if I run
>>
>> ./tst-rseq-nptl
>>
>> Then I get
>>
>> libgcc_s.so.1 must be installed for pthread_cancel to work
>> Didn't expect signal from child: got `Aborted'
>> libgcc_s.so.1 must be installed for pthread_cancel to work
>> Aborted (core dumped)
> 
> I'm puzzled why you don't get a GLIBC_2.32 version error in this case.
> Do you build with --enable-hardcoded-path-in-tests?

Just tried with this, and it fails the same way. However, the output
of ldd nptl/tst-rseq-nptl changes:

linux-vdso.so.1 (0x00007ffc235c9000)
libpthread.so.0 => /home/efficios/git/glibc-build/nptl/libpthread.so.0 (0x00007fd308278000)
libc.so.6 => /home/efficios/git/glibc-build/libc.so.6 (0x00007fd307ebc000)
/home/efficios/git/glibc-build/elf/ld.so => /lib64/ld-linux-x86-64.so.2 (0x00007fd30869e000)


>> Same result if I do ./testrun.sh nptl/tst-rseq-nptl
> 
> That one definitely should work.
> 
> I expect you might see this if libgcc_s.so.1 is installed into a
> multiarch subdirectory that upstream glibc does not search.  (The
> Debian patches are unfortunately not upstream.)

My test environment is a Ubuntu 18.04.1 LTS.

> 
> I think on my system, the built glibc can find the system libgcc_s via
> /etc/ld.so.cache, so I haven't seen this issue yet.

On my system, libgcc_s is provided here:

/lib/x86_64-linux-gnu/libgcc_s.so.1

by this package:

Package: libgcc1
Architecture: amd64
Version: 1:8.4.0-1ubuntu1~18.04

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
