Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB87218B4C
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2020 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgGHPdx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jul 2020 11:33:53 -0400
Received: from mail.efficios.com ([167.114.26.124]:43390 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgGHPdw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Jul 2020 11:33:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AC88A1B6A07;
        Wed,  8 Jul 2020 11:33:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cbQcoDh4TYFE; Wed,  8 Jul 2020 11:33:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6751C1B6A06;
        Wed,  8 Jul 2020 11:33:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6751C1B6A06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594222431;
        bh=WyW3IIRjLOGYLXL+5C9mbnVmq7l0TFfkoKLPFK7976Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=B5yLuCSQiiVsPloKMH+TaVgPO20rgY7SD5HTZMfQRS2Au8oNLn0Em8JNgaoRW44uM
         ZplzARLh5HVf5bVLim3SRkky7hzkJ58sslQrWb3o9OfiT1pFvExAgSF2Ru4+I/nInL
         JPj/Yb/Ff4PHg1wkNlzzCjsoqElalMlNHN+8MmQppGQtgEFZa9DnSdRmbYqL20W1ai
         l7HNjV+LeXuPwEl1ofLyre9JSZT0oBlQk+H6axEvxif4kgG//xEJy1IoEVUUrNU0rA
         QfrvaAcPRf7z/Aw+RNgejrHS9BNniVjGC3rCVZlF21puMy0EcDPYsoXq1/IlnVF7Vf
         7MYianB7IbLgQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KYRy-ykcUC6l; Wed,  8 Jul 2020 11:33:51 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 596521B6A05;
        Wed,  8 Jul 2020 11:33:51 -0400 (EDT)
Date:   Wed, 8 Jul 2020 11:33:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     carlos <carlos@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Message-ID: <1448906726.3717.1594222431276.JavaMail.zimbra@efficios.com>
In-Reply-To: <87zh8bw158.fsf@mid.deneb.enyo.de>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com> <20200706204913.20347-4-mathieu.desnoyers@efficios.com> <87fta3zstr.fsf@mid.deneb.enyo.de> <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com> <874kqjzhkb.fsf@mid.deneb.enyo.de> <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com> <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com> <87zh8bw158.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce
 RSEQ_FLAG_RELIABLE_CPU_ID
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
Thread-Index: zXIs9urjBp1jd5V6Y3737bWrZw5O7Q==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[ Context for Linus: I am dropping this RFC patch, but am curious to
  hear your point of view on exposing to user-space which system call
  behavior fixes are present in the kernel, either through feature
  flags or system-call versioning. The intent is to allow user-space
  to make better decisions on whether it should use a system call or
  rely on fallback behavior. ]

----- On Jul 7, 2020, at 3:55 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Carlos O'Donell:
>=20
>> It's not a great fit IMO. Just let the kernel version be the arbiter of
>> correctness.
>=20
> For manual review, sure.  But checking it programmatically does not
> yield good results due to backports.  Even those who use the stable
> kernel series sometimes pick up critical fixes beforehand, so it's not
> reliable possible for a program to say, =E2=80=9CI do not want to run on =
this
> kernel because it has a bad version=E2=80=9D.  We had a recent episode of=
 this
> with the Go runtime, which tried to do exactly this.

FWIW, the kernel fix backport issue would also be a concern if we exposed
a numeric "fix level version" with specific system calls: what should
we do if a distribution chooses to include one fix in the sequence,
but not others ? Identifying fixes are "feature flags" allow
cherry-picking specific fixes in a backport, but versions would not
allow that.

That being said, maybe it's not such a bad thing to _require_ the
entire series of fixes to be picked in backports, which would be a
fortunate side-effect of the per-syscall-fix-version approach.

But I'm under the impression that such a scheme ends up versioning
a system call, which I suspect will be a no-go from Linus' perspective.

Thanks,

Mathieu


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
