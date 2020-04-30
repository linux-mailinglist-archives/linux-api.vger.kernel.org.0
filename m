Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21AF1C0398
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD3RHe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 13:07:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbgD3RHd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 13:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588266452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n84NKkMGhM/sUUh7/zgvH7HP13DgY6SqFKXlVUHweRo=;
        b=fLKE/dPCNctFjQ0lJNqGqUzUP1RJ01ZU0w2TS8Y78WbKZxnIY2SnztU87rIU/f/pMXKMSb
        YtfM2jahsq3htwN9xT2Z49yqPtBoXXGou3B8p4+/a2wwXmrtpjkGv0kAslioC/1fNXARHU
        sFxiowZjhAbBfNBdBZZSh5XZul4x8a8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-V-sb3-CdPvGn1CGtBBGUQw-1; Thu, 30 Apr 2020 13:07:28 -0400
X-MC-Unique: V-sb3-CdPvGn1CGtBBGUQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0137B1895A28;
        Thu, 30 Apr 2020 17:07:26 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-72.ams2.redhat.com [10.36.113.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6B7D5D9F1;
        Thu, 30 Apr 2020 17:07:18 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [RFC PATCH glibc 1/3] glibc: Perform rseq(2) registration at C startup and thread creation (v18)
References: <20200428171513.22926-1-mathieu.desnoyers@efficios.com>
        <875zdhmaft.fsf@oldenburg2.str.redhat.com>
        <1287616647.77866.1588263099045.JavaMail.zimbra@efficios.com>
        <878sidkk0z.fsf@oldenburg2.str.redhat.com>
        <1972833271.77975.1588265754974.JavaMail.zimbra@efficios.com>
Date:   Thu, 30 Apr 2020 19:07:17 +0200
In-Reply-To: <1972833271.77975.1588265754974.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 30 Apr 2020 12:55:54 -0400
        (EDT)")
Message-ID: <874kt0lx6i.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> If we go this way, I'd also recommend to treat any situation where
> __rseq_abi.cpu_id is already initialized as a fatal error. Does the
> code below seem OK to you ?
>
> static inline void
> rseq_register_current_thread (void)
> {
>   int ret;
>
>   if (__rseq_abi.cpu_id !=3D RSEQ_CPU_ID_UNINITIALIZED)
>     __libc_fatal ("rseq already initialized for this thread\n");

Agreed; this should work because this code runs after relocation
processing.

>   ret =3D INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq),
>                               0, RSEQ_SIG);
>   if (INTERNAL_SYSCALL_ERROR_P (ret))
>     {
>       if (INTERNAL_SYSCALL_ERRNO (ret) =3D=3D EBUSY)
>         __libc_fatal ("rseq already registered for this thread\n");
>       __rseq_abi.cpu_id =3D RSEQ_CPU_ID_REGISTRATION_FAILED;
>     }
> }

__libc_fatal does not attribute the error to glibc, so I suggest to
start the error messages with =E2=80=9Cglibc fatal error: =E2=80=9D, so tha=
t people know
where to look.

Thanks,
Florian

