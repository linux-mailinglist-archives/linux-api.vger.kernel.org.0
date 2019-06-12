Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D94284A
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439555AbfFLOAO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 10:00:14 -0400
Received: from mail.efficios.com ([167.114.142.138]:41738 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439540AbfFLOAO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 10:00:14 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 596B0249AED;
        Wed, 12 Jun 2019 10:00:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 6Lb4WZKRxa9k; Wed, 12 Jun 2019 10:00:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 02FA5249AE3;
        Wed, 12 Jun 2019 10:00:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 02FA5249AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560348012;
        bh=/7ujPEmKCbMtPLRlDvPpClTu5LXEic44ruUyrcVirq4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=G5YOtqFdFOujZTu7WHLmzKCD900izZdnPDZVu8Rm5ME/ERFd4Kh+OBjZ5f+qdyuZM
         24hlYXxihIvEkpFpA2+u3FPaHonG384CdmeIJBMvfiQULOnqUBdU/USEboQ+RFTxan
         /ut8cgM3abBMJSdRF2x01DN0ufIir0ia6WOHEspEsJr7DfoBuylxPmjUfFtVyKWl2b
         1bMOyDL+ZJxeWSgPY/klbgXkS4QkPXKUQECaDAxElSwc/swJRwAJDc2KBGMQx1Q9Mg
         R5TdSB9zjURzjd52/jh8Fi557U7eddrVejt818MAcvijsHnir3Ft+U0GYLpJxGsQ8Z
         0V5mdeTbfpx/w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id uCvd9gaxCDwI; Wed, 12 Jun 2019 10:00:11 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id D9A96249AD9;
        Wed, 12 Jun 2019 10:00:11 -0400 (EDT)
Date:   Wed, 12 Jun 2019 10:00:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <914051741.43025.1560348011775.JavaMail.zimbra@efficios.com>
In-Reply-To: <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com> <87muj2k4ov.fsf@oldenburg2.str.redhat.com> <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com> <87o93d4lqb.fsf@oldenburg2.str.redhat.com> <117220011.27079.1559663870037.JavaMail.zimbra@efficios.com> <87wohzorj0.fsf@oldenburg2.str.redhat.com> <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: 6rG93gdkMSoHS5ZP168diTIrRPG9Cw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 10, 2019, at 4:43 PM, carlos carlos@redhat.com wrote:

> On 6/6/19 7:57 AM, Florian Weimer wrote:
>> Let me ask the key question again: Does it matter if code observes the
>> rseq area first without kernel support, and then with kernel support?
>> If we don't expect any problems immediately, we do not need to worry
>> much about the constructor ordering right now.  I expect that over time,
>> fixing this properly will become easier.
> 
> I just wanted to chime in and say that splitting this into:
> 
> * Ownership (__rseq_handled)
> 
> * Initialization (__rseq_abi)
> 
> Makes sense to me.
> 
> I agree we need an answer to this question of ownership but not yet
> initialized, to owned and initialized.
> 
> I like the idea of having __rseq_handled in ld.so.

Very good, so I'll implement this approach. Sorry for the delayed
feedback, I am traveling this week.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
