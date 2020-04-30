Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF12B1C02AC
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 18:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgD3QhB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 12:37:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44241 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgD3QhB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 12:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588264619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1kujXhR0DAj22ohzNF4EmVUFABeAdXNfPVcnWuHRxo=;
        b=KFDY+ase3naK51WgBRbCjBlmNZYfCdBzYBm51jEk3Rxhk9vEoLZd7w1vJ4cSE8jORDWT+O
        /OotW0baUaJFps68dGevuP2MU1buGHRZY0X9x2O736t3sbLISiq6+aUhN7PIES1BCLhQtA
        +slKPjdGIVTO2d6QMLvRpbM1nNVCb0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-629V3yTBP9erMAd_WkCRDQ-1; Thu, 30 Apr 2020 12:36:55 -0400
X-MC-Unique: 629V3yTBP9erMAd_WkCRDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BEDC107ACF9;
        Thu, 30 Apr 2020 16:36:53 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-72.ams2.redhat.com [10.36.113.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B6F76061B;
        Thu, 30 Apr 2020 16:36:46 +0000 (UTC)
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
Date:   Thu, 30 Apr 2020 18:36:44 +0200
In-Reply-To: <1287616647.77866.1588263099045.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 30 Apr 2020 12:11:39 -0400
        (EDT)")
Message-ID: <878sidkk0z.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> @deftypevar {struct rseq} __rseq_abi
> @standards{Linux, sys/rseq.h}
> @Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with the
> Restartable Sequences system call (Linux-specific).  The layout of this
> structure is defined by the @file{sys/rseq.h} header.  Registration of each
> thread's @code{__rseq_abi} is performed by @theglibc{} at libc library
> initialization and thread creation.

s/libc library/library/

> The main executable and shared libraries may either have an undefined
> @code{__rseq_abi} TLS symbol, or define their own, with the same
> declaration as the one present in @file{sys/rseq.h}.  The dynamic linker
> will ensure that only one of those available symbols will be used at
> runtime across the process.
>
> If the main executable or shared libraries observe an uninitialized
> @code{__rseq_abi.cpu_id} field (value @code{RSEQ_CPU_ID_UNINITIALIZED}), they
> may perform rseq registration to the kernel: this means either glibc was
> prevented from doing the registration, or an older glibc version, which does
> not include rseq support, is in use.  When the main executable or a library
> thus takes ownership of the registration, the memory used to hold the
> @code{__rseq_abi} TLS variable must stay allocated, and is not re-used, until
> the very end of the thread lifetime or until an explicit rseq unregistration
> for that thread is performed.  It is not recommended to dlclose() libraries
> owning the @code{__rseq_abi} TLS variable.

s/dlclose()/@code{dlclose}/ (no parentheses)

Rest looks okay.

>>> +  if (__rseq_abi.cpu_id == RSEQ_CPU_ID_REGISTRATION_FAILED)
>>> +    return;
>>> +  ret = INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq),
>>> +                              0, RSEQ_SIG);
>>> +  if (INTERNAL_SYSCALL_ERROR_P (ret) &&
>>> +      INTERNAL_SYSCALL_ERRNO (ret) != EBUSY)
>>> +    __rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
>> 
>> Sorry, I forgot: Please add a comment that the EBUSY error is ignored
>> because registration may have already happened in a legacy library.
>
> Considering that we now disable signals across thread creation, and that
> glibc's initialization happens before other libraries' constructors
> (as far as I remember even before LD_PRELOADed library constructors),
> in which scenario can we expect to have EBUSY here ?

That's a good point.

> Not setting __rseq_abi.cpu_id to RSEQ_CPU_ID_REGISTRATION_FAILED in case
> of EBUSY is more a way to handle "unforeseen" scenarios where somehow the
> registration would already be done. But I cannot find an "expected"
> scenario which would lead to this now.
>
> So if EBUSY really is unexpected, how should we treat that ? I don't think
> setting REGISTRATION_FAILED would be appropriate, because then it would
> break assumption of the prior successful registration that have already
> been done by this thread.

You could call __libc_fatal with an error message.  ENOSYS is definitely
an expected error code here, and EPERM (and perhaps EACCES) can happen
with seccomp filters.

Thanks,
Florian

