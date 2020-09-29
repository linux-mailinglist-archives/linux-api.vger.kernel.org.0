Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788CA27BEEF
	for <lists+linux-api@lfdr.de>; Tue, 29 Sep 2020 10:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgI2INw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Sep 2020 04:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgI2INw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Sep 2020 04:13:52 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601367230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MeMpmPFrdOGRtU5ng8ECDSHXJcr1++BDe0Y6s4CWwho=;
        b=PwKNY7U2GzxeB5S+v+ec/MAjW86yiFDbnbXaMvHqYPwVp4XhY2ox4nCSCCD5JDDSbQNTrM
        zfm+L4XZ+Y47E1KIhBxnM+3+B0oBRHyYc+XyxmTI7zobAhc1E6Xmv8guvd/eAx7+sMtJnO
        qOgwMNFTZt4kI8l+qlI1P2HeaJX7cms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-TTVOso58PKmkvxrSBD76sA-1; Tue, 29 Sep 2020 04:13:48 -0400
X-MC-Unique: TTVOso58PKmkvxrSBD76sA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3985425D2;
        Tue, 29 Sep 2020 08:13:45 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-114-84.ams2.redhat.com [10.36.114.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5223510013BD;
        Tue, 29 Sep 2020 08:13:40 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH 1/2] rseq: Implement KTLS prototype for x86-64
References: <20200925181518.4141-1-mathieu.desnoyers@efficios.com>
        <87r1qm2atk.fsf@oldenburg2.str.redhat.com>
        <905713397.71512.1601314192367.JavaMail.zimbra@efficios.com>
Date:   Tue, 29 Sep 2020 10:13:38 +0200
In-Reply-To: <905713397.71512.1601314192367.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 28 Sep 2020 13:29:52 -0400
        (EDT)")
Message-ID: <873631yp8t.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

>> So we have a bootstrap issue here that needs to be solved, I think.
>
> The one thing I'm not sure about is whether the vDSO interface is indeed
> superior to KTLS, or if it is just the model we are used to.
>
> AFAIU, the current use-cases for vDSO is that an application calls into
> glibc, which then calls the vDSO function exposed by the kernel. I wonder
> whether the vDSO indirection is really needed if we typically have a glibc
> function used as indirection ? For an end user, what is the benefit of vDSO
> over accessing KTLS data directly from glibc ?

I think the kernel can only reasonably maintain a single userspace data
structure.  It's not reasonable to update several versions of the data
structure in parallel.

This means that glibc would have to support multiple kernel data
structures, and users might lose userspace acceleration after a kernel
update, until they update glibc as well.  The glibc update should be
ABI-compatible, but someone would still have to backport it, apply it to
container images, etc.

What's worse, the glibc code would be quite hard to test because we
would have to keep around multiple kernel versions to exercise all the
different data structure variants.

In contrast, the vDSO code always matches the userspace data structures,
is always updated at the same time, and tested together.  That looks
like a clear win to me.

> If we decide that using KTLS from a vDSO function is indeed a requirement,
> then, as you point out, the thread_pointer is available as ABI, but we miss
> the KTLS offset.
>
> Some ideas on how we could solve this: we could either make the KTLS
> offset part of the ABI (fixed offset), or save the offset near the
> thread pointer at a location that would become ABI. It would have to
> be already populated with something which can help detect the case
> where a vDSO is called from a thread which does not populate KTLS
> though. Is that even remotely doable ?

I don't know.

We could decide that these accelerated system calls must only be called
with a valid TCB.  That's unavoidable if the vDSO sets errno directly,
so it's perhaps not a big loss.  It's also backwards-compatible because
existing TCB-less code won't know about those new vDSO entrypoints.
Calling into glibc from a TCB-less thread has always been undefined.
TCB-less code would have to make direct, non-vDSO system calls, as today.

For discovering the KTLS offset, a per-process page at a fixed offset
from the vDSO code (i.e., what real shared objects already do for global
data) could store this offset.  This way, we could entirely avoid an ABI
dependency.

We'll see what will break once we have the correct TID after vfork. 8->
glibc currently supports malloc-after-vfork as an extension, and
a lot of software depends on it (OpenJDK, for example).

>> With the latter, we could
>> directly expose the vDSO implementation to applications, assuming that
>> we agree that the vDSO will not fail with ENOSYS to request fallback to
>> the system call, but will itself perform the system call.
>
> We should not forget the fields needed by rseq as well: the rseq_cs
> pointer and the cpu_id fields need to be accessed directly from the
> rseq critical section, without function call. Those use-cases require
> that applications and library can know the KTLS offset and size and
> use those fields directly.

Yes, but those offsets could be queried using a function from the vDSO
(or using a glibc interface, to simplify linking).

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

