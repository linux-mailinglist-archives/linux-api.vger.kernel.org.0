Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D4B31A3AD
	for <lists+linux-api@lfdr.de>; Fri, 12 Feb 2021 18:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhBLRaw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Feb 2021 12:30:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231686AbhBLRar (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Feb 2021 12:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613150961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Ue6UWZYwyAvO9YFZKl3E6wcYmOcTl43h7n8qAVY1TQ=;
        b=aPn2B7Ld+OSgBZgGYgJcNuAbYEAxRbRmIlacIOUhIhu1cxPrHEj8w9WIuVDWiA53GRZ6Da
        eqbFAWU31ox9LU3AAljaqLMprV3OHHm7ygp3FMhjkkfq5losH4y0qDlE5uioAlNCXEZRBe
        3hQxPnz3zKzyfDMRQeialkCSmIOSThs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-COOHzF2sOya4tpx2NozfKw-1; Fri, 12 Feb 2021 12:29:18 -0500
X-MC-Unique: COOHzF2sOya4tpx2NozfKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47527BBEE2;
        Fri, 12 Feb 2021 17:29:17 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-113-131.ams2.redhat.com [10.36.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23D4E5D9FC;
        Fri, 12 Feb 2021 17:29:15 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: Re: Are vDSO addresses special?
References: <87zh0bq62r.fsf@oldenburg.str.redhat.com>
        <442A16C0-AE5A-4A44-B261-FE6F817EAF3C@amacapital.net>
Date:   Fri, 12 Feb 2021 18:29:37 +0100
In-Reply-To: <442A16C0-AE5A-4A44-B261-FE6F817EAF3C@amacapital.net> (Andy
        Lutomirski's message of "Thu, 11 Feb 2021 08:10:42 -0800")
Message-ID: <87wnvdgpoe.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Andy Lutomirski:

>> On Feb 11, 2021, at 2:05 AM, Florian Weimer <fweimer@redhat.com> wrote:
>>=20
>> =EF=BB=BFIn glibc, we have some code that copies the DT_SONAME string of=
 the
>> kernel vDSO into the heap, commented this way:
>>=20
>>             /* Work around a kernel problem.  The kernel cannot handle
>>                addresses in the vsyscall DSO pages in writev() calls.  */
>>=20
>> Is this really a problem anymore?  vDSO addresses are ordinary userspace
>> addresses, I think.  (The vsyscall stuff is very different, of course,
>> and maybe the vDSO started out the same way.)
>
> I don=E2=80=99t think it was ever a problem, and it certainly haven=E2=80=
=99t been a
> problem for a long, long time. vDSO addresses are regular user
> addresses.  The *vsyscall* addresses are not, and most syscalls will
> not accept them, but that shouldn=E2=80=99t matter especially since modern
> kernels, by default, won=E2=80=99t let you read those addresses from user=
 code
> either.

Thanks.  Patch posted:

<https://sourceware.org/pipermail/libc-alpha/2021-February/122603.html>

> Saying =E2=80=9Cvsyscall DSO=E2=80=9D is odd. There=E2=80=99s no such thi=
ng.

In the glibc context, it sometimes means =E2=80=9Csystem-call-like function
implemented in the vDSO=E2=80=9D.  But that's not the case here.

Florian
--=20
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'N=
eill

