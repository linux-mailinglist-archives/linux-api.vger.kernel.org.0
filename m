Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D079C459DF
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 12:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfFNKDH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 06:03:07 -0400
Received: from mail.efficios.com ([167.114.142.138]:33086 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfFNKDH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 06:03:07 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B2F3A251338;
        Fri, 14 Jun 2019 06:03:05 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id aGDopCXhabIV; Fri, 14 Jun 2019 06:03:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 455F4251331;
        Fri, 14 Jun 2019 06:03:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 455F4251331
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560506585;
        bh=Hu2sfywP1wr/V2iml0Iwu3DskdZlle9a1sk8RIwPbAc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fvSF4UnSVmbjIlv9Khoar4edqsd+o8saf61h4OK1+vIa0MgvAEnu/UKIG6N0a3apx
         tiA7uuHAHRZy4dE8/w6aFGS05JUYkzKpfU/Hp0sUR8dLGa1RTyvIoc1RcI+Zqs8uww
         EhYjeSssh2WOJo4xfeApdEIr7FfjxCje1SFA8lyywbM541+2WbLuP8fp/9665+tgwf
         upU2nGhuAZzX4ZgGUyxKMvD1Gy32eTP5WwAiGaTvDqWB9L8AurGI/iNK96XYEqjGr8
         x870WRvXafGceB05ZQ0JHYiemFDLtNq8m2mtALm2Yrm9zKcaFGc6IoKaFgaHfxL6kx
         dzXk3iMwytTeQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id LKwutttasM3j; Fri, 14 Jun 2019 06:03:05 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 1BD4A251327;
        Fri, 14 Jun 2019 06:03:05 -0400 (EDT)
Date:   Fri, 14 Jun 2019 06:03:04 -0400 (EDT)
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
Message-ID: <802638054.3032.1560506584705.JavaMail.zimbra@efficios.com>
In-Reply-To: <914051741.43025.1560348011775.JavaMail.zimbra@efficios.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <87muj2k4ov.fsf@oldenburg2.str.redhat.com> <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com> <87o93d4lqb.fsf@oldenburg2.str.redhat.com> <117220011.27079.1559663870037.JavaMail.zimbra@efficios.com> <87wohzorj0.fsf@oldenburg2.str.redhat.com> <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com> <914051741.43025.1560348011775.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: 6rG93gdkMSoHS5ZP168diTIrRPG9C+LZilEL
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 12, 2019, at 4:00 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jun 10, 2019, at 4:43 PM, carlos carlos@redhat.com wrote:
> 
>> On 6/6/19 7:57 AM, Florian Weimer wrote:
>>> Let me ask the key question again: Does it matter if code observes the
>>> rseq area first without kernel support, and then with kernel support?
>>> If we don't expect any problems immediately, we do not need to worry
>>> much about the constructor ordering right now.  I expect that over time,
>>> fixing this properly will become easier.
>> 
>> I just wanted to chime in and say that splitting this into:
>> 
>> * Ownership (__rseq_handled)
>> 
>> * Initialization (__rseq_abi)
>> 
>> Makes sense to me.
>> 
>> I agree we need an answer to this question of ownership but not yet
>> initialized, to owned and initialized.
>> 
>> I like the idea of having __rseq_handled in ld.so.
> 
> Very good, so I'll implement this approach. Sorry for the delayed
> feedback, I am traveling this week.

I had issues with cases where application or LD_PRELOAD library also
define the __rseq_handled symbol. They appear not to see the same
address as the one initialized by ld.so.

I tried using the GL() macro in ld.so to set __rseq_handled, but it's
the wrong address compared to what the preload lib and application observe.

Any thoughts on how to solve this ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
