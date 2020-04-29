Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309BA1BD6FB
	for <lists+linux-api@lfdr.de>; Wed, 29 Apr 2020 10:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD2IST (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Apr 2020 04:18:19 -0400
Received: from albireo.enyo.de ([37.24.231.21]:55198 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgD2IST (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 29 Apr 2020 04:18:19 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jThuy-0004qC-GE; Wed, 29 Apr 2020 08:18:08 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jThuy-0004kT-E2; Wed, 29 Apr 2020 10:18:08 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
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
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C startup and thread creation (v17)
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
        <87zhawvphv.fsf@mid.deneb.enyo.de>
        <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
        <87ftcnrf7d.fsf@mid.deneb.enyo.de>
        <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com>
        <878sifrdo0.fsf@mid.deneb.enyo.de>
        <190402462.72430.1588077816717.JavaMail.zimbra@efficios.com>
        <87tv13py8j.fsf@mid.deneb.enyo.de>
        <437249723.72685.1588085899422.JavaMail.zimbra@efficios.com>
        <20200429081606.GP29015@arm.com>
Date:   Wed, 29 Apr 2020 10:18:08 +0200
In-Reply-To: <20200429081606.GP29015@arm.com> (Szabolcs Nagy's message of
        "Wed, 29 Apr 2020 09:16:09 +0100")
Message-ID: <87a72ug0xr.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Szabolcs Nagy:

> The 04/28/2020 10:58, Mathieu Desnoyers wrote:
>> ----- On Apr 28, 2020, at 8:54 AM, Florian Weimer fw@deneb.enyo.de wrote:
>> > That one definitely should work.
>> > 
>> > I expect you might see this if libgcc_s.so.1 is installed into a
>> > multiarch subdirectory that upstream glibc does not search.  (The
>> > Debian patches are unfortunately not upstream.)
>> 
>> My test environment is a Ubuntu 18.04.1 LTS.
>> 
>> > 
>> > I think on my system, the built glibc can find the system libgcc_s via
>> > /etc/ld.so.cache, so I haven't seen this issue yet.
>> 
>> On my system, libgcc_s is provided here:
>> 
>> /lib/x86_64-linux-gnu/libgcc_s.so.1
>> 
>> by this package:
>> 
>> Package: libgcc1
>> Architecture: amd64
>> Version: 1:8.4.0-1ubuntu1~18.04
>
> before running the tests
>
> cp `$CC --print-file-name libgcc_s.so.1` glibc/build/dir
> cp `$CC --print-file-name libstdc++.so.6` glibc/build/dir
>
> so those toolchain libs are in the search path
> of the newly built libc when running tests.

Do you actually see the need for these steps yourself?

I guess the correct fix would be to upstream the Debian multiarch
changes and activate them automatically with a configure check on
systems that use multiarch paths.
