Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BCF207C21
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 21:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391263AbgFXT0R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 15:26:17 -0400
Received: from mail.efficios.com ([167.114.26.124]:55816 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391258AbgFXT0Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 15:26:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BDCA42C4595;
        Wed, 24 Jun 2020 15:26:15 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 12ShPN6Nre2U; Wed, 24 Jun 2020 15:26:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7F8722C4593;
        Wed, 24 Jun 2020 15:26:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7F8722C4593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593026775;
        bh=xIu++TleEqE9KPbd0HCQAeMoHm4qZFV4xZPbaDUZrbo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=a4OJmy8TKgGQhrrEb3rZfA7ZvDt17keJJgmi8Z2iZkeF73q5cUKB4Xw8nuS34jaAM
         V6ijMSdb5GN5G+r2UZ1IF0A+Od5yMIJJIHBAOkUYzVCIBDe28RnhT80xS7lG/1arAB
         TDyPp17UYNgcb2IHEHQ+Zxc8DQcfi46e+Rplwrd4VwUIplKGURyP5IbmfNRWYFP+95
         MRw8muqGcKnJhbYyu0ZVbySg/Cb48hmLS78H38MaC1+xUcRqiYam+J/WT5KDmY9vsb
         E+PV57UgWiyVM35Nb9tEwH1Wvstb9hBXAdpaGsrQFlpV2OLUGJ3FU4+QG0E+YDUaIR
         afkb4o+bFjB0Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2C3oU0ZHHEFB; Wed, 24 Jun 2020 15:26:15 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 6D8092C4608;
        Wed, 24 Jun 2020 15:26:15 -0400 (EDT)
Date:   Wed, 24 Jun 2020 15:26:15 -0400 (EDT)
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
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <247841361.11644.1593026775351.JavaMail.zimbra@efficios.com>
In-Reply-To: <87mu4s8dy8.fsf@oldenburg2.str.redhat.com>
References: <20200622180803.1449-1-mathieu.desnoyers@efficios.com> <20200622180803.1449-2-mathieu.desnoyers@efficios.com> <87d05obl4w.fsf@oldenburg2.str.redhat.com> <1158112159.11628.1593025203438.JavaMail.zimbra@efficios.com> <87r1u48eix.fsf@oldenburg2.str.redhat.com> <1248023868.11643.1593026198678.JavaMail.zimbra@efficios.com> <87mu4s8dy8.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/3] glibc: Perform rseq registration at C startup and
 thread creation (v21)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v21)
Thread-Index: eETqMJEZmX/E3RrbNFD7SiZhJ6hXcw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 24, 2020, at 3:24 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>>> I think we should keep things simple on the glibc side for now and do
>>> this changes to the kernel headers first.
>>
>> Just to be sure I understand what you mean by "keep things simple", do you
>> recommend removing the following lines completely for now from sys/rseq.h ?
>>
>> /* Ensure the compiler supports rseq_align.  */
>> __rseq_static_assert (__rseq_alignof (struct rseq_cs) >= 32, "alignment");
>> __rseq_static_assert (__rseq_alignof (struct rseq) >= 32, "alignment");
> 
> Yes, that's what I meant.

Agreed, I queued this change for my next round.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
