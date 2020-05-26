Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE91E24AE
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2020 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEZO6G (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 May 2020 10:58:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727978AbgEZO6G (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 May 2020 10:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590505085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VCJa5RbOMATerrFzZ+0VrpXn1iuIwJEs1VN+9Q6EoY=;
        b=h7r8R+Gfb+mXFel3ZNpJKpblexS9WCrGZ0ZJvStOZ17+zKu2TP0nmyUcH5RkYoSWlQz7Q+
        A75LLvTX7xBL8E8PAeUAOAudH7G+Dk1rVr6sYdhG/iN0BF2ELpplulZfoGXMwjYc17U8Kd
        c2Uysp13x2pYtB5hhD1wN4L7S7faEYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-kK8qVpVvPsKlX17v-sDKmw-1; Tue, 26 May 2020 10:58:03 -0400
X-MC-Unique: kK8qVpVvPsKlX17v-sDKmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AC45460;
        Tue, 26 May 2020 14:58:01 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-180.ams2.redhat.com [10.36.112.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BF8519930;
        Tue, 26 May 2020 14:57:57 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
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
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup and thread creation (v19)
References: <20200501021439.2456-1-mathieu.desnoyers@efficios.com>
        <87v9kqbzse.fsf@oldenburg2.str.redhat.com>
        <941087675.33347.1590418305398.JavaMail.zimbra@efficios.com>
        <87367ovy6k.fsf@oldenburg2.str.redhat.com>
        <108939265.33525.1590428184533.JavaMail.zimbra@efficios.com>
        <87lflerhqt.fsf@oldenburg2.str.redhat.com>
        <1701081361.34159.1590503556923.JavaMail.zimbra@efficios.com>
        <87ftbmpxqi.fsf@oldenburg2.str.redhat.com>
        <1931644690.34207.1590504804638.JavaMail.zimbra@efficios.com>
Date:   Tue, 26 May 2020 16:57:56 +0200
In-Reply-To: <1931644690.34207.1590504804638.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 26 May 2020 10:53:24 -0400
        (EDT)")
Message-ID: <877dwypwuj.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

>> Like the attribute, it needs to come right after the struct keyword, I
>> think.  (Trailing attributes can be ambiguous, but not in this case.)
>
> Nope. _Alignas really _is_ special :-(
>
> struct _Alignas (16) blah {
>         int a;
> };
>
> p.c:1:8: error: expected =E2=80=98{=E2=80=99 before =E2=80=98_Alignas=E2=
=80=99
>  struct _Alignas (16) blah {

Meh, yet another unnecessary C++ incompatibility.  C does not support
empty structs, so I assume they didn't see the field requirement as a
burden.

> One last thing I'm planning to add in sys/rseq.h to cover acessing the
> rseq_cs pointers with both the UAPI headers and the glibc struct rseq
> declarations:
>
> /* The rseq_cs_ptr macro can be used to access the pointer to the current
>    rseq critical section descriptor.  */
> #ifdef __LP64__
> # define rseq_cs_ptr(rseq) \
>            ((const struct rseq_cs *) (rseq)->rseq_cs.ptr)
> #else /* __LP64__ */
> # define rseq_cs_ptr(rseq) \
>            ((const struct rseq_cs *) (rseq)->rseq_cs.ptr.ptr32)
> #endif /* __LP64__ */
>
> Does it make sense ?

Written this way, it's an aliasing violation.  I don't think it's very
useful.

Thanks,
Florian

