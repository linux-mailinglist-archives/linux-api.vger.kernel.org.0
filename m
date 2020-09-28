Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8C27B097
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgI1POa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 11:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbgI1POa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 11:14:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601306068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDx1d4uF52ufWWLZ4NH1bd4kYuWSE/VqVT2CjETd86o=;
        b=Rl5wodSPr3aLnJMEPI0KNjnqO2KaMHkqgzwi1rBAtMfW9LMZzpZaOx8O+UHUoFxGPyXst2
        6D/N6YLBEekjksK+onMKRJMZAV4Gk1Gn351z0dskYokThs8fysZQEpiH3++OgUeaXNJYxT
        r69q5HIoG3xjltU9mJLG2xltE0z8uH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-mpnVVk3dNCGbX1d9LReang-1; Mon, 28 Sep 2020 11:14:25 -0400
X-MC-Unique: mpnVVk3dNCGbX1d9LReang-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F119C1891E98;
        Mon, 28 Sep 2020 15:14:21 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-114-84.ams2.redhat.com [10.36.114.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6188D6EE5C;
        Mon, 28 Sep 2020 15:14:06 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos@redhat.com, Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH 1/2] rseq: Implement KTLS prototype for x86-64
References: <20200925181518.4141-1-mathieu.desnoyers@efficios.com>
Date:   Mon, 28 Sep 2020 17:13:59 +0200
In-Reply-To: <20200925181518.4141-1-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Fri, 25 Sep 2020 14:15:17 -0400")
Message-ID: <87r1qm2atk.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> Upstreaming efforts aiming to integrate rseq support into glibc led to
> interesting discussions, where we identified a clear need to extend the
> size of the per-thread structure shared between kernel and user-space
> (struct rseq).  This is something that is not possible with the current
> rseq ABI.  The fact that the current non-extensible rseq kernel ABI
> would also prevent glibc's ABI to be extended prevents its integration
> into glibc.
>
> Discussions with glibc maintainers led to the following design, which we
> are calling "Kernel Thread Local Storage" or KTLS:
>
> - at glibc library init:
>   - glibc queries the size and alignment of the KTLS area supported by the
>     kernel,
>   - glibc reserves the memory area required by the kernel for main
>     thread,
>   - glibc registers the offset from thread pointer where the KTLS area
>     will be placed for all threads belonging to the threads group which
>     are created with clone3 CLONE_RSEQ_KTLS,
> - at nptl thread creation:
>   - glibc reserves the memory area required by the kernel,
> - application/libraries can query glibc for the offset/size of the
>   KTLS area, and offset from the thread pointer to access that area.

One remaining challenge see is that we want to use vDSO functions to
abstract away the exact layout of the KTLS area.  For example, there are
various implementation strategies for getuid optimizations, some of them
exposing a shared struct cred in a thread group, and others not doing
that.

The vDSO has access to the thread pointer because it's ABI (something
that we recently (and quite conveniently) clarified for x86).  What it
does not know is the offset of the KTLS area from the thread pointer.
In the original rseq implementation, this offset could vary from thread
to thread in a process, although the submitted glibc implementation did
not use this level of flexibility and the offset is constant.  The vDSO
is not relocated by the run-time dynamic loader, so it can't use ELF TLS
data.

Furthermore, not all threads in a thread group may have an associated
KTLS area.  In a potential glibc implementation, only the threads
created by pthread_create would have it; threads created directly using
clone would lack it (and would not even run with a correctly set up
userspace TCB).

So we have a bootstrap issue here that needs to be solved, I think.

In most cases, I would not be too eager to bypass the vDSO completely,
and having the kernel expose a data-only interface.  I could perhaps
make an exception for the current TID because that's so convenient to
use in mutex implementations, and errno.  With the latter, we could
directly expose the vDSO implementation to applications, assuming that
we agree that the vDSO will not fail with ENOSYS to request fallback to
the system call, but will itself perform the system call.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

