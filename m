Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626171BDBE2
	for <lists+linux-api@lfdr.de>; Wed, 29 Apr 2020 14:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgD2MTx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Apr 2020 08:19:53 -0400
Received: from albireo.enyo.de ([37.24.231.21]:59794 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgD2MTw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 29 Apr 2020 08:19:52 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jTlgg-0004vQ-DM; Wed, 29 Apr 2020 12:19:38 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jTlgg-0000j1-AN; Wed, 29 Apr 2020 14:19:38 +0200
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
        <20200326155633.18236-6-mathieu.desnoyers@efficios.com>
        <87ees9z417.fsf@mid.deneb.enyo.de>
        <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com>
        <87zhawvphv.fsf@mid.deneb.enyo.de>
        <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
        <87ftcnrf7d.fsf@mid.deneb.enyo.de>
        <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com>
        <1862775654.72437.1588078588989.JavaMail.zimbra@efficios.com>
Date:   Wed, 29 Apr 2020 14:19:38 +0200
In-Reply-To: <1862775654.72437.1588078588989.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 28 Apr 2020 08:56:28 -0400
        (EDT)")
Message-ID: <87368mcwmd.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Apr 28, 2020, at 8:33 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
>
>> ----- On Apr 28, 2020, at 8:02 AM, Florian Weimer fw@deneb.enyo.de wrote:
>> 
> [...]
>>> 
>>>> x32 should not be an issue as explained above, so I'm very open to
>>>> add this "uptr" for user-space only.
>>> 
>>> Okay, then please use anonymous unions and structs as necessary, to
>>> ensure that the uptr field can be reached on all platforms in the same
>>> way.
>> 
>> OK, will do!
>
> What I came up with looks like this. User-space can use rseq_cs.uptr.ptr
> both on 32-bit and 64-bit to update the pointer:

Agreed, this should work.
