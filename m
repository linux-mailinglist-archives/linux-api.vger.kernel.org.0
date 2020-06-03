Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411D21ECF65
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2020 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFCMFg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Jun 2020 08:05:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48650 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725833AbgFCMFg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Jun 2020 08:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591185935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=veNBN0nIrJ2QwM6/V0a3q4/qqOsViBBqoFiGJMYOieg=;
        b=T7IB3cqKd6n/NsYeq/p1KtgdLQjmAVNqDfvvTV0rTuztiovAUErMCgngJM7ll2rCnHBUVv
        XzfzB7I3bwH3ge/PwuMsUuegNlbnS98dMMsoCsqNal5J/+EyWGPlzCrSKgpPF8NnMGsNZL
        BjhguNsBzgku4dHz/9ncO69Zh+gJDII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-XQuSdKH3OeaDMD3LRIVwnw-1; Wed, 03 Jun 2020 08:05:31 -0400
X-MC-Unique: XQuSdKH3OeaDMD3LRIVwnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5713461;
        Wed,  3 Jun 2020 12:05:28 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-181.ams2.redhat.com [10.36.112.181])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E79B15C220;
        Wed,  3 Jun 2020 12:05:22 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup and thread creation (v20)
References: <20200527185130.5604-1-mathieu.desnoyers@efficios.com>
        <20200527185130.5604-2-mathieu.desnoyers@efficios.com>
Date:   Wed, 03 Jun 2020 14:05:21 +0200
In-Reply-To: <20200527185130.5604-2-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Wed, 27 May 2020 14:51:28 -0400")
Message-ID: <87d06gxsla.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> +#ifdef __cplusplus
> +# if  __cplusplus >=3D 201103L
> +#  define __rseq_static_assert(expr, diagnostic) static_assert (expr, di=
agnostic)
> +#  define __rseq_alignof(type)                   alignof (type)
> +#  define __rseq_alignas(x)                      alignas (x)
> +#  define __rseq_tls_storage_class               thread_local
> +# endif
> +#elif (defined __STDC_VERSION__ ? __STDC_VERSION__ : 0) >=3D 201112L
> +# define __rseq_static_assert(expr, diagnostic)  _Static_assert (expr, d=
iagnostic)
> +# define __rseq_alignof(type)                    _Alignof (type)
> +# define __rseq_alignas(x)                       _Alignas (x)
> +# define __rseq_tls_storage_class                _Thread_local
> +#endif

This does not seem to work.  I get this with GCC 9:

In file included from /tmp/cih_test_gsrKbC.cc:8:0:
../sysdeps/unix/sysv/linux/sys/rseq.h:42:50: error: attribute ignored [-Wer=
ror=3Dattributes]
 #  define __rseq_alignas(x)                      alignas (x)
                                                  ^
../sysdeps/unix/sysv/linux/sys/rseq.h:122:14: note: in expansion of macro =
=E2=80=98__rseq_alignas=E2=80=99
     uint32_t __rseq_alignas (32) version;
              ^

In any case, these changes really have to go into the UAPI header first.
Only the __thread handling should remain.  Otherwise, we'll have a tough
situation on our hands changing the UAPI header, without introducing
macro definition conflicts.  I'd suggest to stick to the aligned
attribute for the time being, like the current UAPI headers.

The resut looks okay to me.

I'm still waiting for feedback from other maintainers whether the level
of documentation and testing is appropriate.

Thanks,
Florian

