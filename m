Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB822110D
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgGOPcG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 11:32:06 -0400
Received: from mail.efficios.com ([167.114.26.124]:44142 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgGOPcF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 11:32:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A8032282C9F;
        Wed, 15 Jul 2020 11:32:04 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hfBGhRNx8QVl; Wed, 15 Jul 2020 11:32:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 58B91282523;
        Wed, 15 Jul 2020 11:32:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 58B91282523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594827124;
        bh=YbiH1P2Lw2AGx+BJ46bYeL6rXdS70J7RnP0imUNWnME=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZJXpiIwQclIm6nWpeWHBl8N6kABDRwl8RDiQ3GMosJeT2LiXHM+Ey2RXGOSCrF2Fq
         cFq2Y/v11DXPPUUCt46DHLN8qHeC1e4UvZWzXqG6w9NrAndbkkhgQroEf7VIT7vseI
         vjRvNFaQKiORM18ZtBF88XkKdyh5exPMneuVoTaZrQZP8iGzdpS9xJgarq9yrsV6hi
         DhfNyGFOdeUyWRnAyMPTmC5Ekh/h9rk5++aRy69Xl5g6GUG6S2fNsCc8KfiysGffkP
         4u+a64lOm2kpmETwD/DQv1DqeT2eFPuvXgZYSKvNwIN4KGGwCRjg325FKhl1ipVyJM
         uQsCR26BR1XwA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J-I4XPE67x7V; Wed, 15 Jul 2020 11:32:04 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4787228295F;
        Wed, 15 Jul 2020 11:32:04 -0400 (EDT)
Date:   Wed, 15 Jul 2020 11:32:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <306015794.14349.1594827124274.JavaMail.zimbra@efficios.com>
In-Reply-To: <87a700zu9w.fsf@oldenburg2.str.redhat.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <e7ede994-ebec-8022-b12b-ac7147641ffb@redhat.com> <87a700zu9w.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH 0/4] rseq: Introduce extensible struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Introduce extensible struct rseq
Thread-Index: zj/evqz9xvlM0ojaaTo8zHxJl5f4sg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 15, 2020, at 11:12 AM, Florian Weimer fweimer@redhat.com wrote:

> * Carlos O'Donell:
> 
>> On 7/13/20 11:03 PM, Mathieu Desnoyers wrote:
>>> Recent discussion led to a solution for extending struct rseq. This is
>>> an implementation of the proposed solution.
>>> 
>>> Now is a good time to agree on this scheme before the release of glibc
>>> 2.32, just in case there are small details to fix on the user-space
>>> side in order to allow extending struct rseq.
>>
>> Adding extensibility to the rseq registration process would be great,
>> but we are out of time for the glibc 2.32 release.
>>
>> Should we revert rseq for glibc 2.32 and spend quality time discussing
>> the implications of an extensible design, something that Google already
>> says they are doing?
>>
>> We can, with a clear head, and an agreed upon extension mechanism
>> include rseq in glibc 2.33 (release scheduled for Feburary 1st 2021).
>> We release time boxed every 6 months, no deviation, so you know when
>> your next merge window will be.
>>
>> We have already done the hard work of fixing the nesting signal
>> handler issues, and glibc integration. If we revert today that will
>> also give time for Firefox and Chrome to adjust their sandboxes.
>>
>> Do you wish to go forward with rseq as we have it in glibc 2.32,
>> or do you wish to revert rseq from glibc 2.32, discuss the extension
>> mechanism, and put it back into glibc 2.33 with adjustments?
> 
> I posted the glibc revert:
> 
>  <https://sourceware.org/pipermail/libc-alpha/2020-July/116368.html>
> 
> I do not think we have any other choice at this point.

This is indeed the safe course of action.

Let's hope the overall interest about rseq will be sufficient to justify
integrating extensibility support in the rseq system call ABI, otherwise we
have a catch-22 situation where everything is stalled again, due to further
progress on rseq kernel features awaiting user feedback on the existing
implementation, which will never come because the integration of coordinated
use across libraries is awaiting further development at the kernel level.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
