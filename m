Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39199456399
	for <lists+linux-api@lfdr.de>; Thu, 18 Nov 2021 20:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKRToh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Nov 2021 14:44:37 -0500
Received: from mail.efficios.com ([167.114.26.124]:40822 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhKRToh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Nov 2021 14:44:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6667B39FA3C;
        Thu, 18 Nov 2021 14:41:36 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id f-AlqC6wTb1d; Thu, 18 Nov 2021 14:41:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4872F39FC8B;
        Thu, 18 Nov 2021 14:41:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4872F39FC8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1637264495;
        bh=rqQKSOk9JGORmkN+ifgNoyVeQvAgEyg9PdnYAKaZlHI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qNpzRCqcOQ36mZuKR57rvYiw0+Hu2/iS0N92xpWBivrGLT96FMg5yS88SPQnOS3nW
         pQaCaWWMZI/jI7u/JwZX881i37RkeTanvbAvhfX8A0LPBbb0+foFuZ3siKXx73R6hl
         vc/uQKJbHiGRWycxruTR5hvh2zcTE3vc3b3+ygskWVS27l6bO/JLo/ek5mDwD/LY+m
         YTyBG2f0m9/qfeRmXPpic7HR8bk9ZSpc73FCWGOAD171fHeAzQs8V2wdHi+HJ/Irio
         FTIG6Li0PVI1FXTyKeYIi7NJ8KPegX/7yX2NBVvLzr6jzO95YiZ/ncVk8V3GyizDj3
         RhW8/Faw/KvAw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id woKrI1sZ67GA; Thu, 18 Nov 2021 14:41:35 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3C01D39FC8A;
        Thu, 18 Nov 2021 14:41:35 -0500 (EST)
Date:   Thu, 18 Nov 2021 14:41:35 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Cristian =?utf-8?Q?Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-api <linux-api@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Rich Felker <dalias@libc.org>
Message-ID: <1748005532.19737.1637264495123.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAPBLoAe+KZiM9fb3M7nXXSr_MVGOSQhFWgJYeQH-zXGF3j2cJw@mail.gmail.com>
References: <87wnl5u5rz.fsf@oldenburg.str.redhat.com> <CAPBLoAe+KZiM9fb3M7nXXSr_MVGOSQhFWgJYeQH-zXGF3j2cJw@mail.gmail.com>
Subject: Re: Bringing rseq back into glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4156 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4156)
Thread-Topic: Bringing rseq back into glibc
Thread-Index: 2QnPIJFUOtWIceQa/UrJ/wgMzHJogg==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Nov 18, 2021, at 1:48 PM, Cristian Rodr=C3=ADguez crrodriguez@open=
suse.org wrote:

> On Thu, Nov 18, 2021 at 7:17 AM Florian Weimer via Libc-alpha
> <libc-alpha@sourceware.org> wrote:
>=20
>> 4. Add public symbols __rseq_abi_offset, __rseq_abi_size (currently 32
>>    or 0), __rseq_abi_flags (currently 0).  __rseq_abi_offset is the
>>    offset to add to the thread pointer (see __builtin_thread_pointer) to
>>    get to the rseq area.  They will be public ABI symbols.  These
>>    variables are initialized before user code runs, and changing the
>>    results in undefined behavior.
>=20
> Why not then __get_rseq_whatwever functions and not variables ? or
> maybe writing to these variables results in a compiler or linker error
> instead of UB ?

rseq critical sections cannot issue function calls, and also function calls
are noticeably expensive compared to an rseq critical section. So all users
would end up needing to make a local copy of the information fetched by tho=
se
getters.

So rather than require all those extra per-user copies, I suspect exposing
a single copy through public glibc symbols is more efficient.

The downside is indeed that writing to those variables is UB.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
