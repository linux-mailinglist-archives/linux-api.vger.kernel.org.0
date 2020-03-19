Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4326F18BF12
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 19:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSSJR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 14:09:17 -0400
Received: from mail.efficios.com ([167.114.26.124]:38474 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSSJR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 14:09:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6CFE627A2DF;
        Thu, 19 Mar 2020 14:09:15 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jmjOxRt2Bg4k; Thu, 19 Mar 2020 14:09:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BC42B27A457;
        Thu, 19 Mar 2020 14:09:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BC42B27A457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1584641354;
        bh=QrUfFRjrLvNryzVs/34w+Qbbt1S0+IB1GOeGR35CWVA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=j7x2KgimtwhqQsWjVREY7tOUb2YWfb8SdALWYZ9Hma7LiL8cFz72GnezhOhsdgM0F
         YoGt1Gae8nPb7aqSDHLfWjNr2H6/FbnXoLqxI1LRG1v2KozNRzCvPIlNGjm7s/p8up
         jUTTbZxQtUY6sFOUkOoHLLimIysp6gODwcdjshSx5lgIPgM9K61cRrggADEqv55N6Y
         60dF6oM+1w8pJlJalrIok0I08gQv6h9bpb9KSsb/CXxsNCmzqf5RR3rmIpoDGfXfif
         y3YUhyCxVczDigwQqyU5j9HIu9RXF98C7PMHvWqH8Bn5HfY1fnHW5wmCDx34nafW51
         CbcO5uDrBsoxg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EfSP2e1G3KXZ; Thu, 19 Mar 2020 14:09:14 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A98C027A69C;
        Thu, 19 Mar 2020 14:09:14 -0400 (EDT)
Date:   Thu, 19 Mar 2020 14:09:14 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     libc-alpha <libc-alpha@sourceware.org>, carlos <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Message-ID: <1302331358.3965.1584641354569.JavaMail.zimbra@efficios.com>
In-Reply-To: <87r1xo5o2s.fsf@mid.deneb.enyo.de>
References: <20200319144110.3733-1-mathieu.desnoyers@efficios.com> <20200319144110.3733-5-mathieu.desnoyers@efficios.com> <874kukpf9f.fsf@mid.deneb.enyo.de> <2147217200.3240.1584633395285.JavaMail.zimbra@efficios.com> <87r1xo5o2s.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C
 startup and thread creation (v15)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v15)
Thread-Index: Kjg1gZuOhEP58Sea3WPaGgIlKF6ZUA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Mar 19, 2020, at 12:03 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
>=20
>>> Can you use __has_include in <sys/rseq.h>, with a copy of the kernel
>>> definitions if the kernel header is not available?
>>
>> Sure. Should I pull a verbatim copy of uapi linux/rseq.h into glibc ?
>> If so, where should I put it ?
>=20
> Probably into <sys/rseq.h>, perhaps with a construct like this
> (untested):
>=20
> #ifdef __has_include
> # if __has_include ("linux/rseq.h")
> #   define __GLIBC_HAVE_KERNEL_RSEQ
> # endif
> #else
> # include <linux/version.h>
> # if LINUX_VERSION_CODE >=3D KERNEL_VERSION (4, 18, 0)
> #   define __GLIBC_HAVE_KERNEL_RSEQ
> # endif
> #endif
>=20
> #ifdef __GLIBC_HAVE_KERNEL_RSEQ
> # include <linux/rseq.h>
> #else
>=20
> =E2=80=A6 (fallback goes here)
> #endif

OK will do.

>=20
> We have an ongoing debate whether the fallback definition should use
> __u64 or uint64_t.

Then I'll keep including <linux/types.h> in the fallback and use
__u{32,64} for now. If this proves to be an issue we can change it later.
This is the minimal change from the uapi header.

>=20
> You also need to add an assert that the compiler supports
> __attribute__ ((aligned)) because ignoring it produces an
> ABI-incompatible header.

Are you aware of some helper macro I should use to do this, or
is it done elsewhere in glibc ?

> The struct rseq/struct rseq_cs definitions
> are broken, they should not try to change the alignment.

AFAIU, this means we should ideally not have used __attribute__((aligned))
in the uapi headers in the first place. Why is it broken ? However, now
that it is in the wild, it's a bit late to change that.

> PS: I have Internet connection trouble.  Nobody should be worried if I
> drop off the net for a while.  I understand this is quite a bad time
> for that. 8-(

Allright, thanks for the heads up! Stay safe!

Thanks,

Mathieu


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
