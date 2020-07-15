Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FCA220D98
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 15:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgGONDB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 09:03:01 -0400
Received: from mail.efficios.com ([167.114.26.124]:45970 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgGONDB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 09:03:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A3B4A2818D1;
        Wed, 15 Jul 2020 09:02:59 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id T-XhEFUSaRUD; Wed, 15 Jul 2020 09:02:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2A5E128199D;
        Wed, 15 Jul 2020 09:02:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2A5E128199D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594818179;
        bh=Sbd+cGFRnpcsVMskyWR7rP8BqYCfqctsQ8T1oYWLSPA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ip+9qV9oYQB6oHNPVhT20tRLymHcsVPD1Pn7A/qIKoBDmIhZKIkc9/l2kFaUaqp3z
         cEa44OxzVDEUfrEiKe4Zsa5qRxiCrivTGSbMr/pip1nqAo2hdtjOekoBpxnOs1fmcI
         L8OVVdNXdK6/QrdlI3nOdl/XsZxG0b56WLJamyFQStKwMsSs8K8U3mH3Y1G5RxTJQX
         yH841PgJLYFZiCylIz5/nZsxu6iwOCdCZJSPLLUtFd45JbQuELsJEM1QtZ0xOKeSq0
         9HIJnSLJQrOlnjZh6oBPg+9DeLE3yKhA0E7a7lWUVAEYHwa13uTeovCBlbX/OfvtU7
         3u8Zlb/zbG2+A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mTcnIX4OkSq5; Wed, 15 Jul 2020 09:02:59 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1875528199C;
        Wed, 15 Jul 2020 09:02:59 -0400 (EDT)
Date:   Wed, 15 Jul 2020 09:02:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     carlos <carlos@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Chris Kennelly <ckennelly@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <1190016739.14119.1594818179014.JavaMail.zimbra@efficios.com>
In-Reply-To: <e7ede994-ebec-8022-b12b-ac7147641ffb@redhat.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <e7ede994-ebec-8022-b12b-ac7147641ffb@redhat.com>
Subject: Re: [RFC PATCH 0/4] rseq: Introduce extensible struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Introduce extensible struct rseq
Thread-Index: Uvni3ynFct6LM9XWdCgpU+47NQj6gw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 14, 2020, at 4:55 PM, carlos carlos@redhat.com wrote:

> On 7/13/20 11:03 PM, Mathieu Desnoyers wrote:
>> Recent discussion led to a solution for extending struct rseq. This is
>> an implementation of the proposed solution.
>> 
>> Now is a good time to agree on this scheme before the release of glibc
>> 2.32, just in case there are small details to fix on the user-space
>> side in order to allow extending struct rseq.
> 
> Adding extensibility to the rseq registration process would be great,
> but we are out of time for the glibc 2.32 release.

Of course, and my goal is not to add this support for extensibility
before glibc 2.32, but merely to see if we need to change anything in
the way it uses rseq today (before the release) in order to facilitate
extensibility in the future.

> Should we revert rseq for glibc 2.32 and spend quality time discussing
> the implications of an extensible design, something that Google already
> says they are doing?

Google's approach is limited to contexts simpler than multiple unrelated
libraries scenarios. Peter Oskolkov stated as a follow-up that my
extension approach would be one way to deal with problems associated
with sharing __rseq_abi between unrelated libraries:

https://lore.kernel.org/lkml/CAPNVh5fiCCJpyeLj_ciWzFrO4fasVXZNhpfKXJhJWJirXdJOjQ@mail.gmail.com/

The fact that Google already have their own rseq extensions internally
confirms that planning for extensibility is needed.

> We can, with a clear head, and an agreed upon extension mechanism
> include rseq in glibc 2.33 (release scheduled for Feburary 1st 2021).
> We release time boxed every 6 months, no deviation, so you know when
> your next merge window will be.
> 
> We have already done the hard work of fixing the nesting signal
> handler issues, and glibc integration. If we revert today that will
> also give time for Firefox and Chrome to adjust their sandboxes.
> 
> Do you wish to go forward with rseq as we have it in glibc 2.32,
> or do you wish to revert rseq from glibc 2.32, discuss the extension
> mechanism, and put it back into glibc 2.33 with adjustments?

So here we have a catch-22 situation. Linus wants to see how rseq
is being used before accepting additional features (ref.
https://lore.kernel.org/lkml/CAHk-=wjk-2c4XvWjdzc-bs9Hbgvy-p7ASSnKKphggr5qDoXRDQ@mail.gmail.com/).
This lack of ability to allow user-space to make any large-scale use
of the rseq system call in a coordinated fashion blocks wide use of rseq.
This coordination is supposed to be done by glibc, and I told
every user-space project maintainer who contacted me to hold off
using rseq until it is integrated into glibc. "tcmalloc" from Google
is the exception because they do not care about ABI compatibility with
other libraries (they are OK with a breakage and requiring upgrade).

The process I'm going through right now is checking what are our
options for extending rseq starting from the current ABI, just
to see if we are painting ourselves in a corner with the current
glibc integration. However, if we postpone integration of rseq
into glibc because of possible future extensibility features, those
may never happen because of the lack of usage feedback, due of lack
of users, due to lack of coordinated ABI registration.

At this point, the main question I would like answered is whether
it would be acceptable to increase the size and alignment of
the __rseq_abi symbol (which will be exposed by glibc) between
e.g. glibc 2.32 and 2.33. If it's not possible, then we can
find other solutions, for instance using an indirection with
a pointer to an extended structure, but this appears to be
slightly less efficient.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
